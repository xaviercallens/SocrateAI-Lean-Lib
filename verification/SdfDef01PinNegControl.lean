/- NEGATIVE CONTROL for the `SDF-DEF-01` pins and their `FinalCheck` guards
   (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/SdfDef01PinNegControl.lean

   and it MUST exit nonzero, with exactly FOUR `error:` lines — one per numbered item.
   (`--packages` is a GLOBAL lake flag and must precede the subcommand: LL-27, LL-32.  The other
   two spellings both exit 1 for an ENVIRONMENT reason, which makes a negative control look like it
   passed when it examined nothing.)

   Items 2-4 matter more than item 1: they use the SAME `unfold IsFrickeSelfDual; decide` tactic
   block as the real pins, on statements that are false.  If `decide` were succeeding vacuously —
   because the binder ranged over `∅`, or because the goal had collapsed to `r δ = r δ` — these
   would compile, and the positive pins would prove nothing. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`SdfDef01` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the pin is axiom-free.
/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_six' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_cond_pin_level_six

-- 2. THE MIS-PAIRING, ASSERTED POSITIVELY.  `r = (1,11,1,11)` on `(1,2,3,6)` is self-dual under
--    the WRONG involution `1 ↔ 3`, `2 ↔ 6` but not under `δ ↦ 6/δ`.  A definition that had
--    transposed the divisor pairing would make this compile.
theorem neg_control_mispaired_is_selfDual : IsFrickeSelfDual 6 rPinSixMispaired := by
  unfold IsFrickeSelfDual
  decide

-- 3. THE LOAD-BEARING PIN, NEGATED.  If `decide` could not actually evaluate `Nat.divisors 6`
--    and the exponent vector, this would be as provable as its true counterpart.
theorem neg_control_level_six_not_selfDual : ¬ IsFrickeSelfDual 6 rPinSix := by
  unfold IsFrickeSelfDual
  decide

-- 4. THE NEGATIVE CONTROL, INVERTED.  `r = (2,0)` at `N = 2` is not self-dual; asserting that it
--    is must fail, or `IsFrickeSelfDual` is universally true and every `SDF-*` node is vacuous.
theorem neg_control_asymmetric_is_selfDual : IsFrickeSelfDual 2 rPinAsym := by
  unfold IsFrickeSelfDual
  decide
