# Negative controls

A guard that cannot fail proves nothing. These files assert **deliberately wrong** axiom footprints
and are expected to be **rejected** by Lean. They live outside the library target so the build stays
green while the controls stay runnable.

```bash
lake --packages=local-packages.json env lean verification/GuardNegativeControl.lean    # MUST exit nonzero
lake --packages=local-packages.json env lean verification/F31OrderNegControl.lean      # MUST exit nonzero
lake --packages=local-packages.json env lean verification/F31OrderNegControl2.lean     # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDual0PinNegControl.lean     # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDualM1NegControl.lean      # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDualM2PinNegControl.lean    # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDualM3PinNegControl.lean    # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDualM4PinNegControl.lean    # MUST exit nonzero
```

`TDual0PinNegControl.lean` is a different kind of control: it does not assert a wrong axiom
footprint, it asserts the **wrong numeric value** of each of the four `TDUAL-M0` Fricke decide-pins
— the value the pin would take against a transposed `frickeMatrix`, a flipped `b`-entry, or a
dropped factor of `N` — using the *same* tactic block as the real pin. It exists because a
decide-pin that any nearby variant would also satisfy is not a pin.

`TDualM1NegControl.lean` is the same idea lifted from instances to the **general** formula.  Pins
are instances, and an instance check cannot certify that a general theorem's tactic block is doing
real work rather than closing whatever it is handed.  This file restates `TDUAL-M1`
(`frickeW_smul_coe : ((frickeW hN • τ : ℍ) : ℂ) = -1 / ((N : ℂ) * (τ : ℂ))`) with four *wrong*
right-hand sides — `+1/(Nτ)` (`b`-entry sign flip), `-1/τ` (dropped factor of `N`), `-N/τ`
(transposed matrix), `-1/(N+τ)` (`denom` misread as `c + d·τ`) — under the **identical** tactic
block, and must fail with exactly four `unsolved goals`.  Each failing goal displays the
simp-normalised left-hand side as `-1 / (↑N * ↑τ)`, which is the positive receipt: the simp set
computes the Fricke map independently of what it is being compared against.  If this file ever
compiles, `TDUAL-M1` is vacuous and the node must be reopened.

`TDualM3PinNegControl.lean` guards the one thing that can silently go wrong in `TDUAL-M3`
(`sl_smul_coe_eq_flt : ((γ • τ : ℍ) : ℂ) = (aτ+b)/(cτ+d)` with the entries read off `γ.1` at
`0 0, 0 1, 1 0, 1 1`): the **entry-position assignment**, not the arithmetic.  A transpose, an
`a`/`d` swap, or a sign on `b` or `c` yields a statement that is still well-typed, still an equality
in `ℂ`, and still *true* on symmetric matrices.  So it restates the five `TDUAL-M3` pins with the
value each such error would produce — `(3+i)/5` (`a`/`d` swap), `(2+i)/5` and `3+i` (transpose),
`(64+41i)/109` (`b`-flip), `(-2-i)/2` (`c`-flip), all recomputed in exact Gaussian-rational
arithmetic — under the identical tactic blocks, and must fail with exactly **ten** `error:` lines,
two per pin.  (The two `Γ₀(3)` / `Γ₀(5)` membership conjuncts are left correct and stay proved, so
they contribute no errors.)  Each pin is blind to exactly one variant and that blindness is recorded
at the gate rather than glossed; only the `Γ₀(5)` pin `!![7,2;10,3]` catches all five.

`TDualM4PinNegControl.lean` is the control the `TDUAL-M4` node is *entitled* to, and no more.
`frickeW_smul_involutive` is proved by `rw [← mul_smul]; exact frickeW_sq_smul hN τ` — `exact` of an
already-proved lemma — so a wrong-right-hand-side restatement of the theorem itself would fail only
because `exact` does not unify, certifying nothing about the mathematics.  That is stated rather
than papered over, and no such control is manufactured.  What *is* discriminated is the two-step
gate: the five `frickeW_invol_pin_*` lemmas state, as pairs, the intermediate `W_N • τ` and the
round trip `W_N • W_N • τ` at five points chosen so that `W_N • τ ≠ τ` — which is exactly what
`TDUAL-M0`'s self-dual point `W₁ • i = i` and fixed point `W₄ • (i/2) = i/2` cannot test.  Values
computed first in exact Gaussian-rational arithmetic: `N=2` at `i` → `i/2` → `i`; `N=3` at `2i` →
`i/6` → `2i`; `N=1` at `1+i` → `(-1+i)/2` → `1+i`; `N=2` at `1+i` → `(-1+i)/4` → `1+i`; `N=4` at
`i` → `i/4` → `i`.  This file restates all ten components with wrong values — a dropped factor of
`N` or a flipped `b`-entry on the intermediates, and the **idempotent** variant
`W_N • W_N • τ = W_N • τ` on the round trips — under the identical tactic blocks, and must fail with
exactly ten `error:` lines (nine `unsolved goals`, one `ring_nf made no progress`).  The pins reach
their values through `frickeW_smul_coe` (TDUAL-M1) applied once and twice, a route independent of
`frickeW_sq_smul`'s product-matrix computation, so pins and general proof agree by computation
rather than by construction.  Confirmed failing **before** `frickeW_smul_involutive` was discharged.

If any of these ever *passes*, the 816 `#guard_msgs` guards in `Lean/SocrateAI/FinalCheck.lean` are
vacuous and every axiom-footprint claim in the papers is unsupported. That is the failure this
directory exists to detect.

Verified failing 2026-09-07: `GuardNegativeControl.lean` reports
`expected [], received [propext, Classical.choice, Quot.sound]`.

Verified 2026-09-08 against this run (RUN-6): `lake build SocrateAI --packages=local-packages.json`
completes at 3767 jobs; `verification/*.lean` re-checked failing.

Verified 2026-09-08 against run 7 (TDUAL-M0): `lake build --packages=local-packages.json` completes
at 3788 jobs (`lake build SocrateAI` at 3768); `TDual0PinNegControl.lean` re-checked failing with
exactly four `unsolved goals` errors, and the other three controls re-checked failing.

Verified 2026-09-08 against run 8 (TDUAL-M1): `lake build SocrateAI --packages=local-packages.json`
completes at 3768 jobs, exit 0, with `SocrateAI.FinalCheck` built — so the flipped guard
`'SocrateAI.StringTheory.frickeW_smul_coe' depends on axioms: [propext, Classical.choice, Quot.sound]`
is enforced by the build, and the inverted tripwire on `tduality_tau_fricke_bridge` (which must
still contain `sorryAx`) still passes.  `TDual0PinNegControl.lean` and the new
`TDualM1NegControl.lean` each re-checked failing with exit 1 and exactly four errors.

Verified 2026-09-08 against run 9 (TDUAL-M3): `lake build SocrateAI --packages=local-packages.json`
completes at **3768 jobs, exit 0**, `Build completed successfully (3768 jobs).`, with
`SocrateAI.FinalCheck` built — so the six new guards (five `sl_flt_pin_*` pins and
`sl_smul_coe_eq_flt`, all `[propext, Classical.choice, Quot.sound]`) are enforced by the build, and
the inverted tripwire on `tduality_tau_fricke_bridge` (which must still contain `sorryAx`) still
passes.  The `sorry` count drops from 6 to **5** (2 `EtaMultiplier`, 1 `EtaLigozatKronecker`,
2 `TDualityBridge` for the still-open `TDUAL-M4` and `TDUAL-01`).  All five negative controls
re-checked failing: `GuardNegativeControl` exit 1 / 1 error, `TDual0PinNegControl` exit 1 / 4
errors, `TDualM1NegControl` exit 1 / 4 errors, `TDualM2PinNegControl` exit 1 / 10 errors,
`TDualM3PinNegControl` exit 1 / 10 errors.  The `TDUAL-M3` pins were discharged and
`TDualM3PinNegControl.lean` confirmed failing with exactly ten **before** `sl_smul_coe_eq_flt` was
proved.

Verified 2026-09-08 against run 10 (TDUAL-M4): `lake build SocrateAI --packages=local-packages.json`
completes at **3768 jobs, exit 0**, `Build completed successfully (3768 jobs).`, with
`SocrateAI.FinalCheck` built — so the six new guards (five `frickeW_invol_pin_*` pins and
`frickeW_smul_involutive`, all `[propext, Classical.choice, Quot.sound]`) are enforced by the build,
and the inverted tripwire on `tduality_tau_fricke_bridge` (which must still contain `sorryAx`) still
passes: closing `TDUAL-M4` does not close the bridge.  The `sorry` count in the build target drops
from 5 to **4** (2 `EtaMultiplier`, 1 `EtaLigozatKronecker`, 1 `TDualityBridge` for the still-open
`TDUAL-01`).  All eight negative controls re-checked failing: `GuardNegativeControl` exit 1 / 1
error, `F31OrderNegControl` exit 1 / 1, `F31OrderNegControl2` exit 1 / 1, `TDual0PinNegControl`
exit 1 / 4, `TDualM1NegControl` exit 1 / 4, `TDualM2PinNegControl` exit 1 / 10,
`TDualM3PinNegControl` exit 1 / 10, `TDualM4PinNegControl` exit 1 / 10.
