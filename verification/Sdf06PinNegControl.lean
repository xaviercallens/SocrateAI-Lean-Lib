/- NEGATIVE CONTROL for `SDF-06` (`etaQuotient_fricke_selfDual_normalized`), its instance pins and
   its `FinalCheck` guard (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/Sdf06PinNegControl.lean

   and it MUST exit nonzero, with exactly SIX `error:` lines — one per numbered item, each failing
   for the RIGHT reason rather than for a resource or environment reason (verified this run):
   item 1 a `#guard_msgs` mismatch; item 2 `rewrite failed: Did not find an occurrence` (the
   cancellation lemma has nothing to fire on once the exponent's sign is flipped); items 3 and 4
   `invalid 'calc' step`; item 5 `unsolved goals` with the residue `-I * f = I * f`, which is the
   conjugation error displayed; item 6 ``decide` proved that the proposition ∀ δ ∈ Nat.divisors 2,
   rPinAsym δ = rPinAsym (2 / δ) is false`, i.e. the `hr` argument cannot be supplied at all.
   (`--packages` is a GLOBAL lake flag and must precede the subcommand: LL-27, LL-32.  The other
   two spellings both exit 1 for an ENVIRONMENT reason, which makes a negative control look like it
   passed when it examined nothing.)

   ONE FAILURE MODE WAS FIXED HERE RATHER THAN SHIPPED, recorded because it is the exact trap this
   file exists to avoid: item 2's first version left the calc head with the CORRECT exponent, so
   Lean tried to unify `z^{12}` with `z^{-12}` and died of a `(deterministic) timeout at whnf`.  A
   heartbeat timeout is not a rejection — it would have made this control pass for a resource
   reason.  The exponent is now flipped consistently through the block so the failure lands on the
   cancellation lemma instead.

   `SDF-06` is a NORMALISATION, so the errors it can hide are all in the normaliser and the
   exponent, not in the eta quotients: the wrong root, the wrong direction of the exponent, the
   root not inverted, a lost `i`.  Items 2-6 each take a statement that is FALSE for one of those
   reasons and hand it EXACTLY the tactic block the corresponding positive pin uses.  If any of them
   compiled, the positive pins in `EtaQuotientFrickeSelfDual.lean` would be evidence about nothing. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms Complex

local notation "ℍₒ" => UpperHalfPlane.upperHalfPlaneSet

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`Sdf06` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the normalised theorem is axiom-free, so
--    a guard that had been written without teeth would pass here too.
/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized' does not depend on any axioms -/
#guard_msgs in #print axioms etaQuotient_fricke_selfDual_normalized

-- 2. THE EXPONENT'S SIGN FLIPPED — `z^{+k}` where the node has `z^{-k}`.  At the load-bearing
--    instance `(N, r, k) = (6, rPinSix, 12)` the normalised law divides by `z^{12}`, i.e. multiplies
--    by `z^{-12}`.  This multiplies by `z^{+12}` instead, and is handed
--    `selfDual_norm_pin_level_six_value`'s block with the exponent flipped everywhere it occurs, so
--    that the re-association step still closes and the failure lands exactly where it should: on
--    `hzk : z^{-12} · z^{12} = 1`, which has nothing to fire on once both exponents are `+12`.  This
--    is the item that would compile if the `-k` in the statement had been transcribed as `k`.
theorem neg_control_sdf06_exponent_sign {z : ℂ} (hz : z ∈ ℍₒ) :
    (46656 : ℂ)⁻¹ * z ^ (12 : ℤ) * etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = etaQuotient 6 rPinSix z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-12 : ℤ) * z ^ (12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  rw [selfDual_eigen_pin_level_six_value hz]
  calc (46656 : ℂ)⁻¹ * z ^ (12 : ℤ) * (46656 * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z)
      = ((46656 : ℂ)⁻¹ * 46656) * (z ^ (12 : ℤ) * z ^ (12 : ℤ))
          * etaQuotient 6 rPinSix z := by ring
    _ = etaQuotient 6 rPinSix z := by rw [hzk]; norm_num

-- 3. THE NORMALISER NOT INVERTED — `√(N^k)` where the node has `(√(N^k))⁻¹`.  At the same instance
--    that means multiplying by `46656` instead of by `46656⁻¹`, a factor of `46656² = 6¹²` out.
theorem neg_control_sdf06_normaliser_uninverted {z : ℂ} (hz : z ∈ ℍₒ) :
    (46656 : ℂ) * z ^ (-12 : ℤ) * etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = etaQuotient 6 rPinSix z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-12 : ℤ) * z ^ (12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  rw [selfDual_eigen_pin_level_six_value hz]
  calc (46656 : ℂ)⁻¹ * z ^ (-12 : ℤ) * (46656 * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z)
      = ((46656 : ℂ)⁻¹ * 46656) * (z ^ (-12 : ℤ) * z ^ (12 : ℤ))
          * etaQuotient 6 rPinSix z := by ring
    _ = etaQuotient 6 rPinSix z := by rw [hzk]; norm_num

-- 4. THE SQUARE ROOT DROPPED FROM THE NORMALISER — `(N^k)⁻¹` where the node has `(√(N^k))⁻¹`.  At
--    `(6, rPinSix, 12)` that is `2176782336⁻¹` instead of `46656⁻¹`.  This is the same error class
--    `SDF-03`'s `fricke_const_pin_not_natPow` excludes upstream, restated at the normalised form.
theorem neg_control_sdf06_normaliser_is_natPow {z : ℂ} (hz : z ∈ ℍₒ) :
    (2176782336 : ℂ)⁻¹ * z ^ (-12 : ℤ) * etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = etaQuotient 6 rPinSix z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-12 : ℤ) * z ^ (12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  rw [selfDual_eigen_pin_level_six_value hz]
  calc (46656 : ℂ)⁻¹ * z ^ (-12 : ℤ) * (46656 * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z)
      = ((46656 : ℂ)⁻¹ * 46656) * (z ^ (-12 : ℤ) * z ^ (12 : ℤ))
          * etaQuotient 6 rPinSix z := by ring
    _ = etaQuotient 6 rPinSix z := by rw [hzk]; norm_num

-- 5. THE ROOT OF UNITY CONJUGATED — `i^{+k}` where the node has `i^{-k}`.  Every instance with
--    `4 ∣ k` is blind to this (`i^{12} = i^{-12} = 1`), which is exactly why the ODD-weight pin
--    exists: at `(N, r, k) = (4, rPinLevelFourNeg, 1)` the normalised eigenvalue is `i^{-1} = -i`,
--    and this asserts `+i`, with `selfDual_norm_pin_level_four_neg_value`'s block verbatim.
theorem neg_control_sdf06_root_of_unity_conjugated {z : ℂ} (hz : z ∈ ℍₒ) :
    (2 : ℂ)⁻¹ * z ^ (-1 : ℤ) * etaQuotient 4 rPinLevelFourNeg (-(1 / (((4 : ℕ) : ℂ) * z)))
      = I * etaQuotient 4 rPinLevelFourNeg z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-1 : ℤ) * z ^ (1 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  rw [selfDual_eigen_pin_level_four_neg_value hz]
  calc (2 : ℂ)⁻¹ * z ^ (-1 : ℤ)
        * (-(2 * I) * z ^ (1 : ℤ) * etaQuotient 4 rPinLevelFourNeg z)
      = ((2 : ℂ)⁻¹ * 2) * (z ^ (-1 : ℤ) * z ^ (1 : ℤ))
          * (-I * etaQuotient 4 rPinLevelFourNeg z) := by ring
    _ = -I * etaQuotient 4 rPinLevelFourNeg z := by rw [hzk]; norm_num

-- 6. THE SELF-DUALITY HYPOTHESIS DROPPED.  `r = (2, 0)` at `N = 2` satisfies the WEIGHT hypothesis
--    exactly (`rPinAsym_weight`) and is NOT Fricke-self-dual (`not_selfDual_pin_asymmetric`).
--    Instantiating `SDF-06` there must fail on the `hr` argument.  If it compiled, `hr` would be
--    decoration — and `selfDual_norm_pin_asymmetric_ne`, which shows the normaliser is wrong by a
--    factor of `√2` at exactly this `r`, would be describing a hypothesis nothing depends on.
theorem neg_control_sdf06_at_non_selfDual {z : ℂ} (hz : z ∈ ℍₒ) :
    ((Real.sqrt (((2 : ℕ) : ℝ) ^ (1 : ℤ)) : ℝ) : ℂ)⁻¹ * z ^ (-1 : ℤ)
        * etaQuotient 2 rPinAsym (-(1 / (((2 : ℕ) : ℂ) * z)))
      = I ^ (-1 : ℤ) * etaQuotient 2 rPinAsym z :=
  etaQuotient_fricke_selfDual_normalized (N := 2) (by norm_num) (r := rPinAsym)
    (by unfold IsFrickeSelfDual; decide) (k := 1) rPinAsym_weight hz
