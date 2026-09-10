/- NEGATIVE CONTROL for `SDF-15` (`I_zpow_neg_pm_one_iff`), its weight pins and its `FinalCheck`
   guard (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/Sdf15PinNegControl.lean

   and it MUST exit nonzero.  Verified this run: exit 1 with SEVEN `error:` lines across the seven
   items, every one failing for the RIGHT reason rather than for a resource or environment reason:
     item 1  a `#guard_msgs` mismatch printing the real footprint
             `[propext, Classical.choice, Quot.sound]` against the claimed
             `does not depend on any axioms`;
     items 2-4  `omega could not prove the goal` — the same tactic that closes the TRUE statement in
             `EtaQuotientFrickeSelfDual.lean` refuses each of the three false variants, so the
             `omega` step is discharging real content and is not a tactic that cannot fail;
     item 5  ``Tactic `decide` proved that the proposition Even 15 is false`` — reached AFTER
             rewriting by `SDF-15` itself at `k = 15`, i.e. the general lemma REFUSING to hand out
             `i^{-15} ∈ {1, -1}`;
     item 6  `unsolved goals ⊢ -1 = 1` — the sign the load-bearing pin fixes, displayed;
     item 7  ``Tactic `decide` proved that the proposition Even 15 is false``.
   None by timeout.  (`--packages` is a GLOBAL lake flag and must precede the subcommand:
   LL-27, LL-32.  The other spellings exit 1 for an ENVIRONMENT reason, which makes a negative
   control look like it passed when it examined nothing.)

   `SDF-15` is a BICONDITIONAL between a two-branch condition on a root of unity and a parity
   condition on an integer, so the errors it can hide are: one of the two disjuncts silently
   dropped (which would make it `SDF-08` or `SDF-09` wearing a different right-hand side), the
   right-hand side left at one of the two component criteria `4 ∣ k` or `k % 4 = 2` rather than
   widened to `Even k`, the right-hand side widened past parity so that the ODD weights stop being
   excluded, and a pinned VALUE simply being the wrong root of unity.  Items 2-6 each take a
   statement that is FALSE for one of those reasons and hand it EXACTLY the tactic block the
   corresponding positive declaration uses.  If any of them compiled, the pins and the theorem in
   `EtaQuotientFrickeSelfDual.lean` would be evidence about nothing. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms Complex

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`Sdf15` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the node is axiom-free, so a guard
--    written without teeth would pass here too.
/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff' does not depend on any axioms -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff

-- 2. THE `-1` DISJUNCT DROPPED.  This is `SDF-08`'s left-hand side against `SDF-15`'s right-hand
--    side, and it is FALSE at every `k ≡ 2 (mod 4)` — in particular at `k = 2`, the weight of
--    `η⁴` at level one, whose eigenvalue is genuinely `-1`.  Same tactic block as the real proof.
theorem neg_control_drop_neg_one_disjunct (k : ℤ) : (I : ℂ) ^ (-k) = 1 ↔ Even k := by
  rw [I_zpow_neg_eq_one_iff, Int.even_iff]
  omega

-- 3. THE `+1` DISJUNCT DROPPED.  `SDF-09`'s left-hand side against `SDF-15`'s right-hand side,
--    FALSE at every `k ≡ 0 (mod 4)` — in particular at `k = 12`, the `Δ = η²⁴` weight.
theorem neg_control_drop_one_disjunct (k : ℤ) : (I : ℂ) ^ (-k) = -1 ↔ Even k := by
  rw [I_zpow_neg_eq_neg_one_iff, Int.even_iff]
  omega

-- 4. RIGHT-HAND SIDE LEFT AT `SDF-08`'s CRITERION.  `Even k` narrowed back to `4 ∣ k`, which is
--    FALSE at `k = 2`: the eigenvalue there is `-1`, so the left-hand side holds and `4 ∤ 2`.
theorem neg_control_rhs_four_dvd (k : ℤ) :
    ((I : ℂ) ^ (-k) = 1 ∨ (I : ℂ) ^ (-k) = -1) ↔ (4 : ℤ) ∣ k := by
  rw [I_zpow_neg_eq_one_iff, I_zpow_neg_eq_neg_one_iff]
  omega

-- 5. THE ODD WEIGHT NOT EXCLUDED.  If parity on the right were vacuous — anything implied by every
--    `k` — the general lemma would hand out `i^{-15} ∈ {1, -1}`, which is false (`i^{-15} = i`).
--    This asks `SDF-15` itself for exactly that conclusion at `k = 15`, so it is the control on the
--    node's EXCLUSION power rather than on its inclusion power.
theorem neg_control_odd_not_excluded :
    (I : ℂ) ^ (-(15 : ℤ)) = 1 ∨ (I : ℂ) ^ (-(15 : ℤ)) = -1 := by
  rw [I_zpow_neg_pm_one_iff 15]
  decide

-- 6. THE LOAD-BEARING PIN WITH THE WRONG ROOT OF UNITY.  `I_zpow_neg_pm_one_iff_pin_two` asserts
--    `i^{-2} = -1`; this asserts `i^{-2} = 1`, the value a dropped sign would produce, and is
--    handed the pin's own route through `I_zpow_neg_two`.
theorem neg_control_pin_two_wrong_sign :
    (I : ℂ) ^ (-(2 : ℤ)) = 1 ∧ Even (2 : ℤ) :=
  ⟨by rw [show (-(2 : ℤ)) = (-2 : ℤ) by norm_num, I_zpow_neg_two], by decide⟩

-- 7. THE ODD PIN CLAIMED EVEN.  `I_zpow_neg_pm_one_iff_pin_fifteen` records `¬ Even 15`; this
--    claims `Even 15`, so a parity side proved by a tactic that cannot fail would pass here.
theorem neg_control_pin_fifteen_even : Even (15 : ℤ) := by decide
