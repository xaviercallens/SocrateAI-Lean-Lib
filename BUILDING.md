# Building

```bash
git clone https://github.com/xaviercallens/SocrateAI-Lean-Lib
cd SocrateAI-Lean-Lib
lake exe cache get      # ~5 GB of prebuilt Mathlib .olean files — do not skip
lake build SocrateAI
```

Expect 3769 jobs and **0 errors** (4 `sorry` warnings, all disclosed and DAG-tracked open nodes —
2 in `EtaMultiplier`, 1 in `EtaLigozatKronecker`, and 1 in `StringTheory/TDualityBridge` for the
still-open, actively-contested `TDUAL-01` (`TDUAL-M4` is proved — an earlier version of this line
said otherwise and is corrected; see `verification/README.md`).  `EtaQuotientFrickeSelfDual` no
longer contributes any: `SDF-13`, the unnormalised `-1` (SIGN) criterion
`frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1)`, closed this run and was that file's last open
node, so the whole file is now `sorry`-free — this line said "2 in `EtaQuotientFrickeSelfDual`,
whose only remaining open nodes are `SDF-12` and `SDF-13`" until then). The build target includes
`SocrateAI.FinalCheck`, which is the point: it carries 1031 `#guard_msgs in #print axioms` guards, so
**a drifted axiom footprint fails the build** rather than being silently reported.

Build it with the shared Mathlib pool: `lake build SocrateAI --packages=local-packages.json`.  The
repo-local `.lake/packages/mathlib` checkout has an INCOMPLETE `lake exe cache get`, so a plain
`lake build` starts recompiling Mathlib from source (observed this run on
`Mathlib/Analysis/Calculus/Deriv/Mul.lean` and two others before it was killed).  Use the flag.

> NUMBERING, read before matching an `SDF-1x` label against an older document. `SDF-12` and
> `SDF-13` — `frickeEigenvalue_eq_one_iff` and `frickeEigenvalue_eq_neg_one_iff`, now both proved
> — were labelled `SDF-11` and `SDF-12` until the commit that closed the real `SDF-11`. They were
> reconstructions produced by a run whose specification had been truncated mid-node at the string
> `theorem frickeEigenvalue_`, and their own docstrings recorded that their labels were a guess to
> be confirmed or replaced. The orchestrating session supplied the real `SDF-11` —
> `frickeEigenvalue_norm` — which is a different theorem, so both were shifted by one. It has since
> supplied `SDF-12` and then `SDF-13` in full, and each agreed with the reconstructed declaration
> CHARACTER FOR CHARACTER, `hN` included, so BOTH reconstruction caveats are now discharged and no
> unconfirmed statement remains in that file; this note called them "the two open nodes named
> above" until then. Documents written before those commits, in particular the dated run records in
> `verification/README.md`, use the old numbering and were deliberately not rewritten.

> These three counts have drifted twice, and the second drift was still uncorrected when this line
> was rewritten. The line above once read "3768 jobs / 4 `sorry` warnings / 822 guards" while the
> actual build produced 3769 / 19 / 842, because `EtaQuotientFrickeSelfDual.lean` was added as a
> statement layer without updating it. It was then corrected to "19 / 855" — but the real
> pre-`SDF-05` numbers were **17 sorry warnings and 842 guards** (13 in
> `EtaQuotientFrickeSelfDual`: the five `selfDual_pin_*` conjunctions plus `SDF-05` … `SDF-12`), so
> both halves of that correction were wrong. The three numbers were re-derived from a real
> build on 2026-09-10, after `SDF-05` closed — which removed six `sorry`s (the headline
> `etaQuotient_fricke_selfDual` plus the five `selfDual_pin_*` conjunctions, which were its
> bookkeeping) and added 67 guards: 17 → 11 and 842 → 909. They were re-derived AGAIN from a real
> build the same day, after `SDF-06` closed, which removed one `sorry` and added 15 guards:
> 11 → 10 and 909 → 924, job count unchanged at 3769. Re-derive all three from a real build
> when you change them; do not edit one and infer the others.
>
> They drifted a fourth time: this line still read "10 / 924" after `SDF-07`, `SDF-08` and `SDF-09`
> closed, which nobody updated it for. Re-derived from a real build on 2026-09-10 after `SDF-10`
> closed (adding 15 guards and removing one `sorry`): the actual numbers are **3769 jobs, 6 `sorry`
> warnings, 969 guards**, counted as `grep -c 'declaration uses \`sorry\`'` over the full build log
> and `grep -c '#guard_msgs in #print axioms' Lean/SocrateAI/FinalCheck.lean`. Run those two
> commands rather than adjusting the numbers by arithmetic.
>
> Re-derived a fifth time from a real build on 2026-09-10, after `SDF-11`
> (`frickeEigenvalue_norm`) closed: it added 12 guards and removed no `sorry` (the node needed
> none), so the numbers are **3769 jobs, 6 `sorry` warnings, 981 guards**, from the same two
> commands on that build's log and on `FinalCheck.lean`.
>
> Re-derived a sixth time from a real build on 2026-09-10, after `SDF-12`
> (`frickeEigenvalue_eq_one_iff`, 11 guards, one `sorry` removed) and then `SDF-13`
> (`frickeEigenvalue_eq_neg_one_iff`, 18 guards, one `sorry` removed) closed: **3769 jobs,
> 4 `sorry` warnings, 1010 guards**, from the same two commands, on
> `lake build SocrateAI --packages=local-packages.json`.
>
> Re-derived a SEVENTH time from a real build on 2026-09-10, after `SDF-15`
> (`I_zpow_neg_pm_one_iff`, the normalised `±1` criterion `(i^{-k} = 1 ∨ i^{-k} = -1) ↔ Even k`,
> 11 guards, no `sorry` removed — the node needed none): **3769 jobs, 4 `sorry` warnings, 1031
> guards**, from the same two commands, on `lake build SocrateAI --packages=local-packages.json`.
> This line also CORRECTS A SEVENTH DRIFT that the `SDF-15` run inherited rather than caused: the
> `SDF-14` run (`frickeEigenvalue_pm_one_iff`, 10 guards) closed after the sixth re-derivation and
> did not update either count, so "1010" was already stale by 10 when `SDF-15` began.  The 1031
> figure was MEASURED, not reached by adding 10 + 11 to 1010; that the arithmetic happens to agree
> is a check, not the source.

## What is pinned, and why exactly

| | |
|---|---|
| Toolchain | `leanprover/lean4:v4.32.2` (`lean-toolchain`) |
| Mathlib | `v4.32.2` = `905b95818eb32af7874a58b427f50c1711a5e96c`, 2026-07-28 |

Every theorem here was checked against that exact Mathlib revision, and the papers quote it. Mathlib
moves fast and its `NumberTheory/ModularForms/` tree is under active development; a newer revision
will very likely break this build. `elan` reads `lean-toolchain` and installs the right compiler
automatically.

## Disk and time

`lake exe cache get` downloads roughly **5 GB**. Without it, Lake builds Mathlib from source, which
takes hours. If the download fails partway, re-run it — it resumes.

## Developing against an existing Mathlib checkout

If you already have Mathlib at this revision somewhere (another project, a shared pool), you can
point Lake at it instead of downloading a second copy. Lake's `--packages` flag takes a JSON file
that overrides manifest entries:

```json
{"schemaVersion": "1.2.0",
 "packages":
 [{"type": "path",
   "name": "mathlib",
   "manifestFile": "lake-manifest.json",
   "inherited": false,
   "dir": "/absolute/path/to/.lake/packages/mathlib",
   "configFile": "lakefile.lean"}]}
```

```bash
lake build SocrateAI --packages=local-packages.json
```

`local-packages.json` is **gitignored on purpose** — it holds a machine-specific absolute path and
must never be committed. This repository is developed that way, against a shared 4.9 GB pool, on a
machine with too little free disk to hold a second Mathlib.

> This split is deliberate. An earlier version of this repository committed a `lakefile.lean` that
> hard-coded that pool's absolute path, and a `lean-toolchain` that did not match it. The result was
> a public repository that **could not be built by anyone**, while building fine locally. The
> committed configuration is now the portable one, and the local convenience lives in an ignored
> file.

## Checking the artifact yourself

```bash
lake build SocrateAI                       # 0 errors; 7 sorry, all DAG-tracked open nodes
grep -c '#guard_msgs' Lean/SocrateAI/FinalCheck.lean   # 954 axiom guards
python3 dag/check_dag.py                   # every "proved" node names a real declaration
lake --packages=local-packages.json env lean verification/GuardNegativeControl.lean  # MUST FAIL
  # NOTE (corrected twice — LL-27, then LL-32): `--packages` is a GLOBAL lake flag and goes
  # right after `lake`, before the subcommand. `lake env lean FILE --packages=X` fails (lean
  # itself rejects the flag); `lake env lean FILE` with no flag ALSO fails (missing oleans) —
  # both exit 1 for an environment reason, which can make a negative control look like it
  # "passed" when it examined nothing. `lake --packages=X env lean FILE` is the only form
  # that actually runs the check.
```

The last one matters most. A guard that cannot fail proves nothing, so the negative control asserts
a deliberately wrong axiom footprint and is expected to be rejected.
