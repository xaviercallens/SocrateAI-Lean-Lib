# Negative controls

A guard that cannot fail proves nothing. These files assert **deliberately wrong** axiom footprints
and are expected to be **rejected** by Lean. They live outside the library target so the build stays
green while the controls stay runnable.

```bash
lake env lean verification/GuardNegativeControl.lean    # MUST exit nonzero
lake env lean verification/F31OrderNegControl.lean      # MUST exit nonzero
lake env lean verification/F31OrderNegControl2.lean     # MUST exit nonzero
```

If any of these ever *passes*, the 797 `#guard_msgs` guards in `Lean/SocrateAI/FinalCheck.lean` are
vacuous and every axiom-footprint claim in the papers is unsupported. That is the failure this
directory exists to detect.

Verified failing 2026-09-07: `GuardNegativeControl.lean` reports
`expected [], received [propext, Classical.choice, Quot.sound]`.

Verified 2026-09-08 against this run (RUN-6): `lake build SocrateAI --packages=local-packages.json`
completes at 3767 jobs; `verification/*.lean` re-checked failing.
