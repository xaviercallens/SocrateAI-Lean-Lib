# Negative controls

A guard that cannot fail proves nothing. These files assert **deliberately wrong** axiom footprints
and are expected to be **rejected** by Lean. They live outside the library target so the build stays
green while the controls stay runnable.

```bash
lake env lean verification/GuardNegativeControl.lean    # MUST exit nonzero
lake env lean verification/F31OrderNegControl.lean      # MUST exit nonzero
lake env lean verification/F31OrderNegControl2.lean     # MUST exit nonzero
```

If any of these ever *passes*, the 391 `#guard_msgs` guards in `Lean/SocrateAI/FinalCheck.lean` are
vacuous and every axiom-footprint claim in the papers is unsupported. That is the failure this
directory exists to detect.

Verified failing 2026-09-07: `GuardNegativeControl.lean` reports
`expected [], received [propext, Classical.choice, Quot.sound]`.
