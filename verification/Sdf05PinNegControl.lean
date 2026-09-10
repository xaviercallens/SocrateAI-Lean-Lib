/- NEGATIVE CONTROL for `SDF-05` (`etaQuotient_fricke_selfDual`), its instance pins and its
   `FinalCheck` guard (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/Sdf05PinNegControl.lean

   and it MUST exit nonzero, with exactly FOUR `error:` lines — one per numbered item.
   (`--packages` is a GLOBAL lake flag and must precede the subcommand: LL-27, LL-32.  The other
   two spellings both exit 1 for an ENVIRONMENT reason, which makes a negative control look like it
   passed when it examined nothing.)

   Items 2-4 matter more than item 1: each takes a statement that is FALSE and hands it exactly the
   tactic block the real pins use.  If `SDF-05`'s constant had dropped the square root (item 2), or
   flipped the sign of `i^{-k}` (item 4), or if `IsFrickeSelfDual` were not actually load-bearing in
   the general lemma (item 3), the corresponding item would COMPILE — and the positive pins in
   `EtaQuotientFrickeSelfDual.lean` would be evidence about nothing. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms Complex

local notation "ℍₒ" => UpperHalfPlane.upperHalfPlaneSet

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`Sdf05` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the headline theorem is axiom-free, so
--    a guard that had been written without teeth would pass here too.
/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual' does not depend on any axioms -/
#guard_msgs in #print axioms etaQuotient_fricke_selfDual

-- 2. THE SQUARE ROOT DROPPED.  At the load-bearing instance `(N, r, k) = (6, rPinSix, 12)` the
--    eigenvalue is `√(N^k) = √(6¹²) = 46656`.  This claims it is `N^k = 6¹² = 2176782336` instead —
--    the exact error `SDF-03` exists to exclude — and hands it the real pin's two rewrites.
theorem neg_control_sdf05_eigenvalue_is_natPow {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = 2176782336 * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z := by
  rw [selfDual_eigen_pin_level_six hz, frickeEigenvalue_pin_level_six]

-- 3. THE SELF-DUALITY HYPOTHESIS DROPPED.  `r = (2, 0)` at `N = 2` satisfies the WEIGHT hypothesis
--    exactly (`rPinAsym_weight`) and is NOT Fricke-self-dual (`not_selfDual_pin_asymmetric`).
--    Instantiating `SDF-05` there must fail on the `hr` argument.  If it compiled, `hr` would be
--    decoration and the theorem would say nothing about self-duality at all.
theorem neg_control_sdf05_at_non_selfDual {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 2 rPinAsym (-(1 / (((2 : ℕ) : ℂ) * z)))
      = frickeEigenvalue 2 1 * z ^ (1 : ℤ) * etaQuotient 2 rPinAsym z :=
  etaQuotient_fricke_selfDual (N := 2) (by norm_num) (r := rPinAsym)
    (by unfold IsFrickeSelfDual; decide) (k := 1) rPinAsym_weight hz

-- 4. THE SIGN OF `i^{-k}` FLIPPED.  At `k = 12`, `i^{-k} = 1`, so the eigenvalue is `+46656`.
--    This asserts `-46656`.  A statement carrying `i^{+k}` instead of `i^{-k}` would agree with the
--    real pin at `k ≡ 0 (mod 4)`, so this item is not the one that catches that — what it catches
--    is a lost `neg_neg`, an `inv_neg` slip, or a `norm_num` that closed a sign goal by accident.
theorem neg_control_sdf05_eigenvalue_sign {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = -46656 * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z := by
  rw [selfDual_eigen_pin_level_six hz, frickeEigenvalue_pin_level_six]
