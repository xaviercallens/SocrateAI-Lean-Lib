/- NEGATIVE CONTROL for the `SDF-16` pins and their `FinalCheck` guards
   (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   `SDF-16` is `decidableIsFrickeSelfDual`, the `Decidable` instance for `IsFrickeSelfDual`.  It is
   ERGONOMICS ONLY — it removes the leading `unfold IsFrickeSelfDual` from a `decide` proof.  It is
   NOT what makes the `selfDual_cond_pin_*` pins work, and NOT what makes the self-duality
   hypothesis non-vacuous (that is `not_selfDual_pin_asymmetric` / `not_selfDual_pin_mispaired`).

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/Sdf16PinNegControl.lean

   and it MUST exit nonzero.  SIX numbered items fail, producing NINE `error:` lines: items 3, 4
   and 5 each produce TWO (Lean reports "Not a definitional equality" for the `rfl` and then a
   type mismatch on the same term), items 1, 2 and 6 produce one each.  Verified this run:
   `NC_EXIT=1`, nine `error:` lines, and item 6 reports `decide` proving `¬IsFrickeSelfDual 0
   rPinAsym` FALSE, which is the `N = 0` vacuity the real pin records.
   (`--packages` is a GLOBAL lake flag and must precede the subcommand: LL-27, LL-32.  The other
   two spellings both exit 1 for an ENVIRONMENT reason, which makes a negative control look like it
   passed when it examined nothing.)

   Items 3-6 matter most.  A `Decidable` instance is proof-carrying and so cannot DISAGREE with the
   proposition it decides; the failure mode `SDF-16` can actually have is being INERT — elaborating
   but not reducing in the kernel.  Items 3-6 are the inverted `rfl` `Bool`-value assertions: if the
   instance did not reduce, `rfl` would fail on BOTH the true and the false value and the real pin
   `decidableIsFrickeSelfDual_pin_bool_values` would be proving nothing. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`Sdf16` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the instance is axiom-free.
/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual' does not depend on any axioms -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual

-- 2. THE MIS-PAIRING, ASSERTED POSITIVELY, through the INSTANCE.  `r = (1,11,1,11)` on
--    `(1,2,3,6)` is self-dual under the WRONG involution `1 ↔ 3`, `2 ↔ 6` but not under `δ ↦ 6/δ`.
--    A predicate that had transposed the divisor pairing would make this compile by bare `decide`.
theorem neg_control_sdf16_mispaired_is_selfDual : IsFrickeSelfDual 6 rPinSixMispaired := by decide

-- 3. THE LOAD-BEARING ROW'S `Bool` VALUE, INVERTED.  `decide (IsFrickeSelfDual 6 rPinSix)` is
--    `true`; asserting `false` by `rfl` must fail.  If the instance were inert this `rfl` would
--    fail for the SAME reason the real pin's does, and the real pin would be vacuous.
theorem neg_control_sdf16_bool_level_six : decide (IsFrickeSelfDual 6 rPinSix) = false := rfl

-- 4. THE MIS-PAIRING ROW'S `Bool` VALUE, INVERTED.  It is `false`; asserting `true` must fail.
theorem neg_control_sdf16_bool_mispaired :
    decide (IsFrickeSelfDual 6 rPinSixMispaired) = true := rfl

-- 5. THE NEGATIVE-ENTRY ROW'S `Bool` VALUE, INVERTED.  `r = (-2,6,-2)` at `N = 4` IS self-dual
--    (`∏ δ^{r δ} = 2⁶/(1²·4²) = 4 = N^k`); asserting `false` must fail.  This is the row that
--    exercises negative exponents and the self-paired divisor `4/2 = 2`.
theorem neg_control_sdf16_bool_level_four_neg :
    decide (IsFrickeSelfDual 4 rPinLevelFourNeg) = false := rfl

-- 6. THE `N = 0` TRAP, INVERTED.  `Nat.divisors 0 = ∅`, so `IsFrickeSelfDual 0 rPinAsym` is
--    VACUOUSLY TRUE; asserting its negation must fail.  If this compiled, the trap recorded in
--    `decidableIsFrickeSelfDual_pin_level_zero_vacuous` — and the reason every `SDF-*` lemma
--    carries `hN : 0 < N` — would be misstated.
theorem neg_control_sdf16_level_zero_not_vacuous : ¬ IsFrickeSelfDual 0 rPinAsym := by decide
