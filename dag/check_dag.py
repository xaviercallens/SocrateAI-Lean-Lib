#!/usr/bin/env python3
"""check_dag.py — validator for dag/theorems.jsonl.

Checks (each mirrors a rule that has already failed once somewhere in the programme):
  1. well-formed nodes, unique ids, deps resolve            (schema discipline)
  2. acyclic                                                 (it is a DAG or it is nothing)
  3. proved  => lean_name exists in Lean/ source             (Gate-0 lesson: GL2-WN-01 named
                                                              a theorem that did not exist)
  4. proved  => all deps proved                              (Mathesis ledger soundness: no
                                                              claim filed above what it rests on)
  5. physics => baseline and falsifier present               (RESEARCH_PROGRAM.md hard rule)
  6. proved  => lean_file is in the IMPORT CLOSURE of Lean/SocrateAI.lean, the default build
               target (run-4 finding: a node can name a real declaration in a real file that
               `lake build SocrateAI` never actually compiles — rule 3 alone cannot see that)
  7. proved  => lean_name has a `#guard_msgs in #print axioms` guard in FinalCheck.lean,
               UNLESS kind == "def" (a definition has no proof to guard; only theorems/lemmas
               carry an axiom footprint worth pinning). One pre-existing exception (FRK-DEF)
               motivated the kind == "def" carve-out rather than a per-id allowlist.
Then prints the FRONTIER: open nodes whose deps are all proved — what an agent may claim next.
Exit 0 iff all checks pass.
"""
import json, re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DAG = Path(__file__).resolve().parent / "theorems.jsonl"
STATUSES = {"open", "claimed", "proved", "blocked"}
KINDS = {"def", "math", "physics"}

def declared_names():
    names = set()
    kw = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+)?(?:theorem|lemma|def|abbrev|structure|instance)\s+([A-Za-z0-9_.']+)")
    for f in (ROOT / "Lean").rglob("*.lean"):
        if ".lake" in f.parts: continue
        for line in f.read_text(errors="ignore").splitlines():
            m = kw.match(line)
            if m: names.add(m.group(1).split(".")[-1])
    return names

MOD_IMPORT_RE = re.compile(r"^\s*import\s+([A-Za-z0-9_.']+)\s*$", re.M)

def module_to_path(mod: str) -> Path:
    return ROOT / "Lean" / (mod.replace(".", "/") + ".lean")

def import_closure(root_module="SocrateAI"):
    """BFS over `import Foo.Bar` lines starting at Lean/SocrateAI.lean."""
    seen, queue = set(), [root_module]
    while queue:
        mod = queue.pop()
        if mod in seen: continue
        seen.add(mod)
        f = module_to_path(mod)
        if not f.is_file(): continue
        for m in MOD_IMPORT_RE.findall(f.read_text(errors="ignore")):
            if m not in seen: queue.append(m)
    return seen

def file_to_module(lean_file: str) -> str:
    rel = Path(lean_file)
    if rel.parts[0] == "Lean": rel = Path(*rel.parts[1:])
    return ".".join(rel.with_suffix("").parts)

GUARD_RE = re.compile(r"#guard_msgs\s+in\s+#print\s+axioms\s+([A-Za-z0-9_.']+)")

def guarded_names():
    fc = ROOT / "Lean" / "SocrateAI" / "FinalCheck.lean"
    if not fc.is_file(): return set()
    return set(GUARD_RE.findall(fc.read_text(errors="ignore")))

def main():
    nodes, errors = {}, []
    for i, line in enumerate(DAG.read_text().splitlines(), 1):
        if not line.strip() or line.lstrip().startswith("#"): continue
        try:
            n = json.loads(line)
        except json.JSONDecodeError as e:
            errors.append(f"line {i}: invalid JSON: {e}"); continue
        for field in ("id", "kind", "statement_nl", "status", "depends_on"):
            if field not in n: errors.append(f"line {i}: missing field {field!r}")
        if n.get("id") in nodes: errors.append(f"line {i}: duplicate id {n['id']!r}")
        if n.get("status") not in STATUSES: errors.append(f"{n.get('id')}: bad status {n.get('status')!r}")
        if n.get("kind") not in KINDS: errors.append(f"{n.get('id')}: bad kind {n.get('kind')!r}")
        nodes[n.get("id")] = n

    for n in nodes.values():
        for d in n.get("depends_on", []):
            if d not in nodes: errors.append(f"{n['id']}: unknown dependency {d!r}")

    # acyclicity via DFS
    WHITE, GREY, BLACK = 0, 1, 2
    color = {k: WHITE for k in nodes}
    def dfs(u, stack):
        color[u] = GREY
        for v in nodes[u].get("depends_on", []):
            if v not in nodes: continue
            if color[v] == GREY: errors.append(f"cycle: {' -> '.join(stack + [u, v])}")
            elif color[v] == WHITE: dfs(v, stack + [u])
        color[u] = BLACK
    for k in list(nodes):
        if color[k] == WHITE: dfs(k, [])

    decl = declared_names()
    closure = import_closure()
    guarded = guarded_names()
    for n in nodes.values():
        if n["status"] == "proved":
            ln = n.get("lean_name")
            if not ln:
                errors.append(f"{n['id']}: proved but lean_name is null")
            elif ln.split(".")[-1] not in decl:
                errors.append(f"{n['id']}: proved but {ln!r} not found in Lean/ sources")
            for d in n.get("depends_on", []):
                if d in nodes and nodes[d]["status"] != "proved":
                    errors.append(f"{n['id']}: proved but depends on non-proved {d} ({nodes[d]['status']})")
            lf = n.get("lean_file")
            if lf:
                mod = file_to_module(lf)
                if mod not in closure:
                    errors.append(f"{n['id']}: proved, {lf!r} is NOT in the import closure of "
                                   f"Lean/SocrateAI.lean — `lake build SocrateAI` never compiles it")
            if ln and n.get("kind") != "def":
                # FinalCheck.lean guards mix qualified and short (open-namespace) names; match by
                # base name, same normalisation as the rule-3 declared-names check above.
                guarded_bases = {g.split(".")[-1] for g in guarded}
                if ln.split(".")[-1] not in guarded_bases:
                    errors.append(f"{n['id']}: proved theorem {ln!r} has no #guard_msgs axiom guard "
                                   f"in FinalCheck.lean (kind={n.get('kind')!r}; defs are exempt)")
        if n["kind"] == "physics":
            for field in ("baseline", "falsifier"):
                if not n.get(field): errors.append(f"{n['id']}: physics node missing {field!r}")

    if errors:
        print(f"FAIL — {len(errors)} error(s):")
        for e in errors: print(f"  - {e}")
        return 1

    proved = {k for k, n in nodes.items() if n["status"] == "proved"}
    frontier = [n for n in nodes.values() if n["status"] == "open"
                and all(d in proved for d in n["depends_on"])]
    counts = {}
    for n in nodes.values(): counts[n["status"]] = counts.get(n["status"], 0) + 1
    print(f"PASS — {len(nodes)} nodes ({', '.join(f'{v} {k}' for k, v in sorted(counts.items()))}), acyclic, sound.")
    print(f"FRONTIER ({len(frontier)} claimable):")
    for n in frontier:
        print(f"  [{n['id']}] {n['statement_nl'][:100]}")
    return 0

if __name__ == "__main__":
    sys.exit(main())
