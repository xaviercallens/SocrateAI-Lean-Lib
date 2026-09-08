# Building

```bash
git clone https://github.com/xaviercallens/SocrateAI-Lean-Lib
cd SocrateAI-Lean-Lib
lake exe cache get      # ~5 GB of prebuilt Mathlib .olean files — do not skip
lake build SocrateAI
```

Expect ~3767 jobs and **0 errors** (3 `sorry` warnings, all disclosed and DAG-tracked open nodes —
see `verification/README.md`). The build target includes `SocrateAI.FinalCheck`, which is the
point: it carries 797 `#guard_msgs in #print axioms` guards, so **a drifted axiom footprint fails
the build** rather than being silently reported.

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
lake build SocrateAI                       # 0 errors; 3 sorry, all DAG-tracked open nodes
grep -c '#guard_msgs' Lean/SocrateAI/FinalCheck.lean   # 797 axiom guards
python3 dag/check_dag.py                   # every "proved" node names a real declaration
lake env lean verification/GuardNegativeControl.lean  # MUST FAIL — else the guards are vacuous
  # NOTE: run this against the shared pool the way `lake build` above did — if you built with
  # `--packages=local-packages.json`, prefix that flag on `lake build` (not on `lake env lean`,
  # which does not accept it) so the .lake/build tree it reads from is populated.
```

The last one matters most. A guard that cannot fail proves nothing, so the negative control asserts
a deliberately wrong axiom footprint and is expected to be rejected.
