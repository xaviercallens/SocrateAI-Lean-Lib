/- NEGATIVE CONTROL for `SDF-PIN-02` — the level-two pin in expanded `η` form, its `FinalCheck`
   guards, the three REACH claims, the one stated LIMITATION, and the two tactic-level claims its
   docstrings make (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   `SDF-PIN-02` is `selfDual_eigen_pin_level_two_eta`:

     η(-1/(2z)) · η(2 · (-1/(2z)))  =  -i·√2 · z · (η(z) · η(2z))

   the `(N, r, k) = (2, rPinTwo, 1)` instance of `SDF-05` with every definition of
   `EtaQuotientFrickeSelfDual.lean` unfolded away.  This file asserts the NEGATION of each claim the
   node and its reach section make, so that none of them can be vacuous.

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/SdfPin02NegControl.lean

   and it MUST exit nonzero.  VERIFIED THIS RUN: `NC_EXIT=1`, TEN `error:` lines, one per item, each
   for the RIGHT reason — item 1 the footprint mismatch (`does not depend on any axioms` against the
   real `[propext, Classical.choice, Quot.sound]`); item 2 a `Type mismatch` printing `-I * ↑√2`
   against the asserted `I * ↑√2`; item 3 `⊢ -I * ↑√2 ≠ -I * ↑√2`; item 4 ``The `ring` tactic failed
   to close the goal`` with the residual `⊢ (↑√2)⁻¹ * 2 = ↑√2`, which IS the claim — `√2` is an atom
   to `ring`; items 5 and 6 `⊢ (↑√2)⁻¹ = ↑√2` and `⊢ False`; items 7, 8 and 10 ``decide proved that
   the proposition … is false`` at `∀ δ ∈ Nat.divisors 2, 2 / δ = δ`, `rPinTwo 1 ≠ rPinTwo 2` and
   `∑ δ ∈ Nat.divisors 2, rPinTwo δ = 2 * 2`; item 9 a `Type mismatch` printing
   `selfDual_pin_level_two_weight_one`'s actual five-way conjunction.

   `open Complex (I)` and `autoImplicit false` above are LOAD-BEARING: without them `I` is silently
   auto-bound as an implicit variable, and items 2 and 3 would fail on something that never examined
   `Complex.I` — the "control that examined nothing" failure mode.

   (`--packages` is a GLOBAL lake flag and must precede the subcommand: LL-27, LL-32.  The other two
   spellings both exit 1 for an ENVIRONMENT reason, which makes a negative control look like it
   passed when it examined nothing.)

   ITEM 9 IS THE NAME-DRIFT CONTROL and is the one to read first.  This node was PROPOSED as
   `selfDual_pin_level_two`, one underscore from the existing `selfDual_pin_level_two_weight_one`
   (`EtaQuotientFrickeSelfDual.lean:983`) — a five-way HYPOTHESIS CONJUNCTION at the same instance
   `(2, rPinTwo, 1)`, mentioning neither `η` nor `z`.  Item 9 tries to close this node's equation
   with it and must fail on a type mismatch, which is why the DAG node names
   `selfDual_eigen_pin_level_two_eta` and why a base-name-matched axiom guard against
   `selfDual_pin_level_two*` would have guarded the wrong proposition while looking correct. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms
open Complex (I)
set_option autoImplicit false

local notation "ℍₒ" => UpperHalfPlane.upperHalfPlaneSet

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`SdfPin02` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the node is axiom-free.
/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_eta' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_eta

-- 2. THE CONJUGATE CONSTANT.  `+i√2` in place of `-i√2`.  Numerically this fails at relative error
--    2.0 at every test point; here it must fail as a TYPE MISMATCH against the real theorem.  If it
--    compiled, the node's branch commitment would be empty.
theorem neg_control_sdfpin02_conjugate {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((2 : ℂ) * z))) * ModularForm.eta ((2 : ℂ) * (-(1 / ((2 : ℂ) * z))))
      = I * ((Real.sqrt 2 : ℝ) : ℂ) * z
        * (ModularForm.eta z * ModularForm.eta ((2 : ℂ) * z)) :=
  selfDual_eigen_pin_level_two_eta hz

-- 3. THE TWO ROUTES DISAGREE.  `selfDual_eigen_pin_level_two_routes_agree` proves
--    `i⁻¹ · 2 · (√2)⁻¹ = -i·√2`; this asserts they differ.  If it compiled, the second derivation
--    `..._eta_via_upstream` could not exist and the cross-check with `fricke_level_two_pin` would be
--    an assertion rather than a build obligation.
theorem neg_control_sdfpin02_routes_disagree :
    I⁻¹ * (2 : ℂ) * ((Real.sqrt 2 : ℝ) : ℂ)⁻¹ ≠ -I * ((Real.sqrt 2 : ℝ) : ℂ) := by
  rw [selfDual_eigen_pin_level_two_routes_agree]

-- 4. TACTIC-LEVEL CONTROL — `ring` ALONE closes the `√2` step.  `two_mul_inv_sqrt_two`'s docstring
--    says it cannot, because `√2` is an ATOM to `ring` and to `norm_num`, and that the identity
--    needs `Real.mul_self_sqrt` plus `Real.sqrt_ne_zero'`.  This item is what makes that claim
--    falsifiable.  It must fail with `ring failed`.
theorem neg_control_sdfpin02_ring_closes_sqrt_step :
    (2 : ℂ) * ((Real.sqrt 2 : ℝ) : ℂ)⁻¹ = ((Real.sqrt 2 : ℝ) : ℂ) := by
  ring

-- 5. REACH 2 INVERTED — the radicand degeneracy of `N = 1` asserted AT `N = 2`.  `√2 ≠ 1`, so
--    `(√2)⁻¹ ≠ √2` and this must fail; it is what stops
--    `selfDual_eigen_pin_level_two_evidence_radicand` from being vacuous.
theorem neg_control_sdfpin02_radicand_degenerate :
    ((Real.sqrt 2 : ℝ) : ℂ)⁻¹ = ((Real.sqrt 2 : ℝ) : ℂ) := by
  norm_num

-- 6. REACH 1 INVERTED — the `N`-power degeneracy of `N = 1` asserted at `N = 2`.  `2¹ ≠ 2²`.
theorem neg_control_sdfpin02_level_pow_degenerate :
    ((2 : ℕ) : ℂ) ^ (1 : ℤ) = ((2 : ℕ) : ℂ) ^ (2 : ℤ) := by
  norm_num

-- 7. REACH 3 INVERTED — the divisor involution asserted to be the IDENTITY at `N = 2`.  `2/1 = 2`,
--    so this must fail; it is what stops
--    `selfDual_eigen_pin_level_two_evidence_involution` from being vacuous.
theorem neg_control_sdfpin02_involution_trivial :
    ∀ δ ∈ (2 : ℕ).divisors, (2 : ℕ) / δ = δ := by decide

-- 8. THE STATED LIMITATION, INVERTED — the exponent PAIRING asserted VISIBLE at level two.
--    `rPinTwo` is CONSTANT on `Nat.divisors 2`, so a transposed pairing is invisible here; this must
--    fail.  It is what stops `selfDual_eigen_pin_level_two_no_evidence_pairing` from being an
--    admission with no content — the honesty claim is checked, not merely written down.
theorem neg_control_sdfpin02_pairing_visible : rPinTwo 1 ≠ rPinTwo 2 := by decide

-- 9. THE NAME-DRIFT CONTROL.  `selfDual_pin_level_two_weight_one` is a DIFFERENT proposition — the
--    five-way conjunction at `EtaQuotientFrickeSelfDual.lean:983` — and does NOT prove this node's
--    equation.  Must fail on a type mismatch.  Compare the real resolver, which does close it:
--    `selfDual_eigen_pin_level_two_eta hz`.
theorem neg_control_sdfpin02_wrong_name {z : ℂ} (_hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((2 : ℂ) * z))) * ModularForm.eta ((2 : ℂ) * (-(1 / ((2 : ℂ) * z))))
      = -I * ((Real.sqrt 2 : ℝ) : ℂ) * z
        * (ModularForm.eta z * ModularForm.eta ((2 : ℂ) * z)) :=
  selfDual_pin_level_two_weight_one

-- 10. WRONG WEIGHT.  `rPinTwo = (1, 1)` has `∑ r δ = 2 = 2 · 1`, i.e. `k = 1`, NOT `k = 2`.  A node
--     stated at the wrong weight would carry the eigenvalue `i^{-2} · 2 = -2` instead of `-i√2`.
theorem neg_control_sdfpin02_wrong_weight :
    (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) = 2 * 2 := by decide
