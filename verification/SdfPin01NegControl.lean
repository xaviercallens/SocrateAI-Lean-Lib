/- NEGATIVE CONTROL for `SDF-PIN-01` — the level-one pin, its `FinalCheck` guards, and the four
   DEGENERACY witnesses that bound what it is evidence for
   (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   `SDF-PIN-01` is `selfDual_raw_pin_level_one_is_eta_S`: the `(N, r, k) = (1, r ≡ 24, 12)` instance
   of `SDF-04`, carried down to `η(-1/z)²⁴ = z¹² η(z)²⁴`.  It is a FLOOR — second-route agreement
   with a value two upstream derivations already establish — and it pins NO component of
   `λ = i^{-k} · N^k · s^{-1/2}`.  The four `selfDual_pin_level_one_no_evidence_*` theorems prove
   that limitation; this file is what stops those four from being vacuous, by asserting each
   degeneracy's NEGATION, which is exactly the claim the node text used to make.

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/SdfPin01NegControl.lean

   and it MUST exit nonzero.  VERIFIED THIS RUN: `NC_EXIT=1`, EIGHT `error:` lines, one per item,
   each for the RIGHT reason — item 1 the footprint mismatch; items 2-5 the four degeneracies
   asserted INVERTED, failing at `⊢ 1 ≠ 1`, `⊢ False`, `⊢ False`, and ``decide proved that the
   proposition ¬∀ δ ∈ Nat.divisors 1, 1 / δ = δ is false``; item 6 `⊢ False`; item 7 `⊢ -I = I`;
   item 8 a `Type mismatch` printing `selfDual_pin_level_one`'s actual five-way conjunction.
   `open Complex (I)` and `autoImplicit false` above are LOAD-BEARING: without them `I` is silently
   auto-bound as an implicit variable and items 2 and 7 fail on a rewrite that never examined
   `Complex.I` — observed once while writing this file, which is the "control that examined
   nothing" failure mode in miniature.
   (`--packages` is a GLOBAL lake flag and must precede the subcommand: LL-27, LL-32.  The other
   two spellings both exit 1 for an ENVIRONMENT reason, which makes a negative control look like it
   passed when it examined nothing.)

   ITEM 8 IS THE NAME-DRIFT CONTROL and is the one to read first.  The name `selfDual_pin_level_one`
   is taken by a DIFFERENT proposition (`EtaQuotientFrickeSelfDual.lean:908`, a five-way conjunction
   about `IsFrickeSelfDual`, the weight, the radicand and `frickeEigenvalue`, mentioning neither `η`
   nor `z`).  Item 8 tries to close `SDF-PIN-01`'s equation with it and must fail on a type
   mismatch — which is why the DAG node names `selfDual_raw_pin_level_one_is_eta_S` instead, and why
   a base-name-matched axiom guard against `selfDual_pin_level_one` would have guarded the wrong
   proposition while looking correct. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms
open Complex (I)
set_option autoImplicit false

local notation "ℍₒ" => UpperHalfPlane.upperHalfPlaneSet

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`Sdf04` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the pin is axiom-free.
/-- info: 'SocrateAI.ModularForms.selfDual_raw_pin_level_one_is_eta_S' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_raw_pin_level_one_is_eta_S

-- 2. DEGENERACY 1 INVERTED — the `i`-exponent's SIGN, asserted VISIBLE at `k = 12`.  This is the
--    old (false) claim "a wrong sign on `i^{-k}` fails here".  `i^{-12} = 1 = i^{+12}`, so it must
--    fail.  If it compiled, `selfDual_pin_level_one_no_evidence_I_sign` would be proving nothing.
theorem neg_control_sdfpin01_I_sign_visible :
    (I : ℂ) ^ (-12 : ℤ) ≠ (I : ℂ) ^ (12 : ℤ) := by
  rw [I_zpow_neg_twelve, I_zpow_twelve]

-- 3. DEGENERACY 2 INVERTED — the POWER of `N`, asserted VISIBLE at `N = 1`.  Every `zpow` of
--    `(1 : ℂ)` is `1`, so `N^k` and `N^{2k}` cannot be told apart here.
theorem neg_control_sdfpin01_level_pow_visible :
    ((1 : ℕ) : ℂ) ^ (12 : ℤ) ≠ ((1 : ℕ) : ℂ) ^ (24 : ℤ) := by
  norm_num

-- 4. DEGENERACY 3 INVERTED — the SIDE OF THE FRACTION `√s` sits on, asserted VISIBLE at `N = 1`.
--    The radicand is `s = 1²⁴ = 1`, so `(√s)⁻¹ = √s` and a constant carrying `√s` for `(√s)⁻¹`
--    reproduces this instance exactly.
theorem neg_control_sdfpin01_radicand_visible :
    ((Real.sqrt (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) : ℝ) : ℂ)⁻¹
      ≠ ((Real.sqrt (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) : ℝ) : ℂ) := by
  rw [show (1 : ℕ).divisors = {1} from by decide]
  norm_num [rPinOne, Real.sqrt_one]

-- 5. DEGENERACY 4 INVERTED — the divisor INVOLUTION, asserted VISIBLE at `N = 1`.  `δ ↦ 1/δ` is
--    the identity on `Nat.divisors 1 = {1}`, so a transposed pairing `δ ↔ N/δ` cannot be seen.
theorem neg_control_sdfpin01_involution_visible :
    ¬ (∀ δ ∈ (1 : ℕ).divisors, (1 : ℕ) / δ = δ) := by decide

-- 6. THE CONTRAST, INVERTED — `6¹² = 1`.  If this compiled, `SDF-PIN-01`'s claim that the
--    discrimination lives at `N > 1` would be empty, since the level would be as degenerate as
--    `N = 1` is.
theorem neg_control_sdfpin01_level_six_degenerate : ((6 : ℕ) : ℂ) ^ (12 : ℤ) = 1 := by norm_num

-- 7. THE ODD-WEIGHT CONTRAST, INVERTED — `i^{-1} = i^{1}`.  `i^{-1} = -i ≠ i`, so this must fail;
--    it is what stops `selfDual_pin_weight_one_evidence_I_sign` from being vacuous, i.e. what makes
--    "the `i`-sign IS visible at odd weight" a real statement rather than a restatement of item 2.
theorem neg_control_sdfpin01_I_sign_invisible_at_weight_one :
    (I : ℂ) ^ (-1 : ℤ) = (I : ℂ) ^ (1 : ℤ) := by
  rw [I_zpow_neg_one, zpow_one]

-- 8. THE NAME-DRIFT CONTROL.  `selfDual_pin_level_one` is a DIFFERENT proposition — the five-way
--    conjunction at `EtaQuotientFrickeSelfDual.lean:908` — and does NOT prove `SDF-PIN-01`'s
--    equation.  This must fail on a type mismatch.  Compare the real resolver, which does close it:
--    `selfDual_raw_pin_level_one_is_eta_S hz`.
theorem neg_control_sdfpin01_wrong_name {z : ℂ} (_hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / z)) ^ (24 : ℕ) = z ^ (12 : ℕ) * ModularForm.eta z ^ (24 : ℕ) :=
  selfDual_pin_level_one
