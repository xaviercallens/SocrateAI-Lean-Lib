/- NEGATIVE CONTROL for `SDF-PIN-04` — the level-four, WEIGHT-ZERO pin in expanded `η` form, its
   `FinalCheck` guards, its three REACH claims, its stated LIMITATION, and the two-route agreement
   (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   `SDF-PIN-04` is `selfDual_eigen_pin_level_four_weight_zero_eta`:

     η(-1/(4z))⁻² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))⁻²  =  η(z)⁻² · η(2z)⁴ · η(4z)⁻²

   the `(N, r, k) = (4, rPinLevelFourWeightZero, 0)` instance of `SDF-05`, `λ = 1`, with every
   definition of `EtaQuotientFrickeSelfDual.lean` unfolded away.  This file asserts the NEGATION of
   each claim the node and its section make, so that none of them can be vacuous.

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/SdfPin04NegControl.lean

   and it MUST exit nonzero.  (`--packages` is a GLOBAL lake flag and must precede the subcommand:
   LL-27, LL-32.  The other spellings exit 1 for an ENVIRONMENT reason, which makes a negative
   control look like it passed when it examined nothing.)

   `open Complex (I)` and `autoImplicit false` are LOAD-BEARING: without them `I` is silently
   auto-bound as an implicit variable and item 8 would fail on something that never examined
   `Complex.I` — the "control that examined nothing" failure mode.

   ITEM 6 IS THE NAME-DRIFT CONTROL and is the one to read first.  `_weight_zero` is NOT
   `_zero_exp`: `selfDual_eigen_pin_level_four_zero_exp` is the `r ≡ 0` pin at the SAME level, the
   SAME weight `k = 0` and the SAME eigenvalue `λ = 1`, so the two are easy to conflate.  Item 6
   tries to close this node's η-level equation with it and must fail on a type mismatch; item 7
   asserts this node's vector IS the zero vector at `δ = 2` and must fail on `decide`.

   ITEM 9 IS THE HONESTY CONTROL.  The section states in Lean that at `k = 0` the pin sees NO
   component of the constant (`..._no_evidence_constant`).  Item 9 asserts the OPPOSITE — that
   `i^{-0} ≠ i^{+0}` — and must fail.  If it compiled, the file's own limitation statement would be
   false and the node would be being oversold in the other direction.

   ITEM 10 IS THE LOAD-BEARING-HYPOTHESIS CONTROL.  `rPinLevelFourWeightZeroMispaired = (0, 4, -4)`
   satisfies the WEIGHT hypothesis `∑ r δ = 0 = 2 · 0` exactly, so only `IsFrickeSelfDual` rejects
   it.  Item 10 instantiates `SDF-05` there with the same tactic block the node uses, and must fail
   on `hr` alone.  Numerically that vector misses the node's equation by relative error 0.58-1.06. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms
open Complex (I)
set_option autoImplicit false

local notation "ℍₒ" => UpperHalfPlane.upperHalfPlaneSet

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`SdfPin04` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the node is axiom-free.
/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_eta' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_eta

-- 2. THE SIGN OF THE EIGENVALUE.  `λ = -1` in place of `λ = 1`.  Numerically this fails at
--    relative error 2.0 at `z = 0.3+0.7i`.  It must fail here as a TYPE MISMATCH against the real
--    theorem, since `k = 0` is exactly where a lost `i^{-k}` would be invisible.
theorem neg_control_sdfpin04_sign {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = (-1 : ℂ) * (ModularForm.eta z ^ (-2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
          * ModularForm.eta ((4 : ℂ) * z) ^ (-2 : ℤ)) :=
  selfDual_eigen_pin_level_four_weight_zero_eta hz

-- 3. THE OTHER LEVEL-FOUR CONSTANT.  `λ = 16` is `SDF-PIN-03`'s eigenvalue at the SAME level
--    (`N = 4`, `k = 4`), and is the most likely constant to be carried over by mistake.  Fails
--    numerically at relative error 0.94.
theorem neg_control_sdfpin04_wrong_constant {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = (16 : ℂ) * (ModularForm.eta z ^ (-2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
          * ModularForm.eta ((4 : ℂ) * z) ^ (-2 : ℤ)) :=
  selfDual_eigen_pin_level_four_weight_zero_eta hz

-- 4. A `z`-POWER THAT IS NOT THERE.  `k = 0` means no `z^k` factor at all; this inserts `z¹`.
--    Fails numerically at relative error 1.30.
theorem neg_control_sdfpin04_z_power {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = z ^ (1 : ℤ) * (ModularForm.eta z ^ (-2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
          * ModularForm.eta ((4 : ℂ) * z) ^ (-2 : ℤ)) :=
  selfDual_eigen_pin_level_four_weight_zero_eta hz

-- 5. THE EXPONENTS' SIGNS TRANSPOSED — `η(2z)⁻⁴ / (η(z)⁻² η(4z)⁻²)`, i.e. the reciprocal quotient.
--    It is still self-dual and still has weight sum `0`, so the HYPOTHESES do not distinguish it;
--    only the statement does.
theorem neg_control_sdfpin04_reciprocal {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = ModularForm.eta z ^ (2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (-4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * z) ^ (2 : ℤ) :=
  selfDual_eigen_pin_level_four_weight_zero_eta hz

-- 6. NAME-DRIFT CONTROL, `_weight_zero` vs `_zero_exp`.  `selfDual_eigen_pin_level_four_zero_exp`
--    is the `r ≡ 0` pin at the same level, the same `k = 0` and the same `λ = 1`.  It does NOT
--    close this node's equation; must fail as a type mismatch.
theorem neg_control_sdfpin04_zero_exp_drift {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = ModularForm.eta z ^ (-2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * z) ^ (-2 : ℤ) :=
  selfDual_eigen_pin_level_four_zero_exp hz

-- 7. VACUITY CONTROL.  If this node's vector were the ZERO vector the identity would be `1 = 1`.
--    `rPinLevelFourWeightZero_ne_zero_pin` says it is not; this asserts the opposite at `δ = 2`.
theorem neg_control_sdfpin04_vector_is_zero : rPinLevelFourWeightZero 2 = 0 := by decide

-- 8. THE NEGATIVE EXPONENTS DENIED.  `..._evidence_negative_exponents` records `r 1 < 0`; this
--    claims the vector is nonnegative there, which would make the `zpow` bookkeeping trivial.
theorem neg_control_sdfpin04_no_negative_exponents : 0 ≤ rPinLevelFourWeightZero 1 := by decide

-- 9. THE STATED LIMITATION INVERTED — the honesty control.  `..._no_evidence_constant` asserts
--    `i^{-0} = i^{+0}`, i.e. that this pin cannot see the sign of the `i`-exponent.  This claims it
--    can.  It must fail; if it compiled, the section's own limitation statement would be false.
theorem neg_control_sdfpin04_limitation_inverted : (I : ℂ) ^ (-(0 : ℤ)) ≠ (I : ℂ) ^ ((0 : ℤ)) := by
  norm_num

-- 10. SELF-DUALITY IS LOAD-BEARING.  `rPinLevelFourWeightZeroMispaired = (0, 4, -4)` satisfies the
--     WEIGHT hypothesis exactly (`rPinLevelFourWeightZeroMispaired_weight`), so only `hr` can reject
--     it.  Same instantiation the node uses, mis-paired vector; must fail on `by decide` for `hr`.
theorem neg_control_sdfpin04_mispaired_instantiation {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 4 rPinLevelFourWeightZeroMispaired (-(1 / (((4 : ℕ) : ℂ) * z)))
      = frickeEigenvalue 4 0 * z ^ (0 : ℤ)
        * etaQuotient 4 rPinLevelFourWeightZeroMispaired z :=
  etaQuotient_fricke_selfDual (N := 4) (by norm_num)
    (r := rPinLevelFourWeightZeroMispaired) (by decide) (k := 0)
    rPinLevelFourWeightZeroMispaired_weight hz

-- 11. THE RADICAND WITH ONE FACTOR DROPPED.  `s = 1⁻² · 2⁴ · 4⁻²`; forgetting the `4⁻²` leaves
--     `16`.  Same tactic block as `prod_zpow_pin_level_four_weight_zero`; must fail.
theorem neg_control_sdfpin04_radicand_dropped_factor :
    (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourWeightZero δ)) = 16 := by
  rw [divisors_four_pin,
    Finset.prod_insert (by decide : (1 : ℕ) ∉ ({2, 4} : Finset ℕ)),
    Finset.prod_insert (by decide : (2 : ℕ) ∉ ({4} : Finset ℕ)), Finset.prod_singleton,
    show rPinLevelFourWeightZero 1 = -2 by decide,
    show rPinLevelFourWeightZero 2 = 4 by decide,
    show rPinLevelFourWeightZero 4 = -2 by decide]
  norm_num

-- 12. THE PAIRING EVIDENCE DENIED.  `..._evidence_pairing` records `r 1 ≠ r 2`; this claims the
--     vector is CONSTANT on the divisors, which is the level-two degeneracy this pin does not have.
theorem neg_control_sdfpin04_constant_vector :
    rPinLevelFourWeightZero 1 = rPinLevelFourWeightZero 2 := by decide
