/- NEGATIVE CONTROL for `SDF-PIN-03` — the level-four, weight-four pin in expanded `η` form, its
   `FinalCheck` guards, the four REACH claims, the one stated LIMITATION, and the companion pins
   that break this node's `N = k` degeneracy (Mathesis HARDNESS.md H2: a checker that cannot fail is
   not a checker).

   `SDF-PIN-03` is `selfDual_eigen_pin_level_four_weight_four_eta`:

     η(-1/(4z))² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))²  =  16 · z⁴ · (η(z)² · η(2z)⁴ · η(4z)²)

   the `(N, r, k) = (4, rPinLevelFourWeightFour, 4)` instance of `SDF-05` with every definition of
   `EtaQuotientFrickeSelfDual.lean` unfolded away.  This file asserts the NEGATION of each claim the
   node and its section make, so that none of them can be vacuous.

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/SdfPin03NegControl.lean

   and it MUST exit nonzero.  (`--packages` is a GLOBAL lake flag and must precede the subcommand:
   LL-27, LL-32.  The other spellings exit 1 for an ENVIRONMENT reason, which makes a negative
   control look like it passed when it examined nothing.)

   `open Complex (I)` and `autoImplicit false` are LOAD-BEARING: without them `I` is silently
   auto-bound as an implicit variable and item 3 would fail on something that never examined
   `Complex.I` — the "control that examined nothing" failure mode.

   ITEMS 5 AND 6 ARE THE NAME-DRIFT CONTROLS and are the ones to read first.  `_level_four` ALONE
   already means `N = 4`, `r = (-2, 6, -2)`, `k = 1` throughout this library — `sqrt_natPow_level_four`
   is `√(4¹) = 2`, NOT `√(4⁴) = 16`.  Item 5 tries to close this node's radicand with that lemma and
   must fail.  Item 6 tries to close this node's EQUATION with `selfDual_pin_level_two_weight_one`'s
   sibling shape, the `selfDual_pin_*` five-way HYPOTHESIS CONJUNCTION family, and must fail on a
   type mismatch — which is why the DAG node names `selfDual_eigen_pin_level_four_weight_four_eta`
   and not `selfDual_pin_level_four`.

   ITEM 9 IS THE DEGENERACY CONTROL.  The node's own statement CANNOT distinguish `√(N^k)` from
   `√(k^N)`, because `N = 4 = k` there.  Item 9 asserts that the LEVEL-NINE companion is equally
   blind, and must fail: at `N = 9`, `k = 4` the two read `81` and `512`.  If item 9 compiled, the
   whole reason the companion pins exist would be gone. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms
open Complex (I)
set_option autoImplicit false

local notation "ℍₒ" => UpperHalfPlane.upperHalfPlaneSet

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`SdfPin03` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the node is axiom-free.
/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_four_eta' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_four_eta

-- 2. THE WRONG CONSTANT — `256` (which is `s` and `N^k`, i.e. the radicand, not its square root)
--    in place of `16`.  Numerically this fails at relative error 9.4e-1 at `z = 0.3+0.7i`.  It is
--    the single most likely transcription error in this node, since `256` appears in `SDF-02`'s
--    product pin at the same instance.  It must fail as a TYPE MISMATCH against the real theorem.
theorem neg_control_sdfpin03_radicand_not_root {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (2 : ℤ)
      = (256 : ℂ) * z ^ (4 : ℤ)
        * (ModularForm.eta z ^ (2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
          * ModularForm.eta ((4 : ℂ) * z) ^ (2 : ℤ)) :=
  selfDual_eigen_pin_level_four_weight_four_eta hz

-- 3. THE WRONG WEIGHT in the `z` factor — `z²` in place of `z⁴`.  Numerically fails at relative
--    error 1.5 at `z = 0.3+0.7i`.  Must fail as a type mismatch.
theorem neg_control_sdfpin03_wrong_zpow {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (2 : ℤ)
      = (16 : ℂ) * z ^ (2 : ℤ)
        * (ModularForm.eta z ^ (2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
          * ModularForm.eta ((4 : ℂ) * z) ^ (2 : ℤ)) :=
  selfDual_eigen_pin_level_four_weight_four_eta hz

-- 4. THE EIGENVALUE IS NOT `256`.  Stated on the constant alone, so that item 2's failure cannot
--    be blamed on the `η` bookkeeping.  `decide`/`norm_num` must reject `16 = 256`.
theorem neg_control_sdfpin03_eigenvalue : frickeEigenvalue 4 4 = 256 := by
  rw [frickeEigenvalue_pin_level_four_weight_four]

-- 5. NAME DRIFT, RADICAND.  `sqrt_natPow_level_four` is `√(4¹) = 2`, the library's OTHER level-four
--    instance (`r = (-2, 6, -2)`, `k = 1`).  This node needs `√(4⁴) = 16`.  Closing the weight-four
--    radicand with the weight-one lemma must fail.
theorem neg_control_sdfpin03_wrong_radicand_lemma :
    Real.sqrt (((4 : ℕ) : ℝ) ^ (4 : ℤ)) = 16 := sqrt_natPow_level_four

-- 6. NAME DRIFT, NODE SHAPE.  `selfDual_pin_*` (no `eigen`) is the `SDF-PIN-01` family of five-way
--    HYPOTHESIS CONJUNCTIONS, mentioning neither `z` nor `η`.  This node is an η-level EQUATION.
--    Feeding one where the other is expected must fail on a type mismatch; that is why the DAG node
--    is named `selfDual_eigen_pin_level_four_weight_four_eta` and not `selfDual_pin_level_four`.
theorem neg_control_sdfpin03_wrong_family {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (2 : ℤ)
      = (16 : ℂ) * z ^ (4 : ℤ)
        * (ModularForm.eta z ^ (2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
          * ModularForm.eta ((4 : ℂ) * z) ^ (2 : ℤ)) :=
  selfDual_pin_level_one

-- 7. THE MIS-PAIRED VECTOR IS NOT SELF-DUAL.  `rPinLevelFourMispaired = (4, 4, 0)` has the SAME
--    weight sum `8 = 2·4` as the node's vector but fails `r 1 = r 4`.  `decide` must reject it; if
--    it did not, `selfDual_cond_pin_level_four_weight_four` would be vacuous.
theorem neg_control_sdfpin03_mispaired_selfdual :
    IsFrickeSelfDual 4 rPinLevelFourMispaired := by decide

-- 8. THE NODE'S VECTOR IS NOT CONSTANT.  `r 1 = 2` and `r 2 = 4`.  If this compiled, the pairing
--    evidence `..._evidence_pairing` — the whole reason this node was worth stating on top of
--    `SDF-PIN-02` — would be empty.
theorem neg_control_sdfpin03_constant_vector :
    rPinLevelFourWeightFour 1 = rPinLevelFourWeightFour 2 := by decide

-- 9. THE DEGENERACY CONTROL.  At the node's instance `N = 4 = k`, so `√(N^k)` and `√(k^N)` agree
--    and the node cannot tell them apart — that is `..._no_evidence_level_weight`, stated in the
--    library.  This item claims the LEVEL-NINE companion is equally blind.  It must fail:
--    `√(9⁴) = 81` while `√(4⁹) = 512`.
theorem neg_control_sdfpin03_level_weight_blind :
    Real.sqrt (((9 : ℕ) : ℝ) ^ (4 : ℤ)) = Real.sqrt (((4 : ℕ) : ℝ) ^ (9 : ℤ)) := by
  rw [sqrt_natPow_level_nine_weight_four]
  norm_num

-- 10. THE SIGN CONTROL.  Pin D's eigenvalue is `-4`, not `+4`: at `k = 2` the factor `i^{-2} = -1`
--     is doing visible work.  A statement that had dropped `i^{-k}` closes the node (`i^{-4} = 1`)
--     and PIN C (`i^{-4} = 1`) and must fail here.
theorem neg_control_sdfpin03_dropped_i_factor : frickeEigenvalue 4 2 = 4 := by
  rw [frickeEigenvalue_pin_level_four_weight_two]

-- 11. THE CALIBRATION IS NOT VACUOUS.  `eta_S_via_fricke` fixes the `N = 1`, `k = 12` target
--     upstream, WITHOUT self-duality.  A wrong exponent there must be rejected.
theorem neg_control_sdfpin03_calibration_wrong_weight {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / z)) ^ (24 : ℕ) = z ^ (6 : ℕ) * ModularForm.eta z ^ (24 : ℕ) :=
  selfDual_eigen_pin_level_one_eta_calibration hz

-- 12. THE INVOLUTION IS NOT THE IDENTITY AT LEVEL FOUR.  `4 / 1 = 4 ≠ 1`.  Only the middle divisor
--     is fixed; if the whole involution were the identity, `IsFrickeSelfDual 4` would be vacuous.
theorem neg_control_sdfpin03_involution_identity :
    ∀ δ ∈ (4 : ℕ).divisors, (4 : ℕ) / δ = δ := by decide
