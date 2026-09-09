/-
NEGATIVE CONTROL for the TDUAL-M2 instance-agreement pins.  THIS FILE MUST FAIL TO COMPILE.

It restates the five pins of `SocrateAI/StringTheory/TDualityBridge.lean` (TDUAL-M2 section) with
*wrong* right-hand sides, under the *identical* tactic blocks, and must fail with exactly ten
`error:` occurrences — two per pin, one on the `GL(2,ℝ)` side and one on the `SL(2,ℤ)` side.  That
is what certifies that each pin's tactic block computes the Möbius value from the matrix rather than
being closed by whatever it is compared against.

Run:  lake --packages=local-packages.json env lean verification/TDualM2PinNegControl.lean
      -> MUST exit nonzero, with exactly 10 `error:` lines.

The wrong values are not arbitrary; each is the value a specific definitional error would produce,
recomputed in exact Gaussian-rational arithmetic:
  * id  pin, τ = i          : `-i`         — a conjugation / orientation-convention error.
  * T   pin, τ = i          : `(1+i)/2`    — the TRANSPOSED matrix `!![1,0;1,1]`.
  * S   pin, τ = 1+i        : `(1-i)/2`    — a `b`-entry SIGN FLIP `!![0,1;1,0]`.
  * L2  pin, τ = i          : `2+i`        — the TRANSPOSED matrix `!![1,2;0,1]`.
  * G2  pin, τ = i          : `(5+i)/2`    — the TRANSPOSED matrix `!![3,2;1,1]`.
Recorded honestly: the `b`-entry sign flip is NOT a discriminating variant at the L2 pin, whose
`b`-entry is already `0` (flipping it is the identity), which is why the L2 pin is given the
transpose variant instead.  The S pin's transpose is likewise NOT discriminating (`!![0,1;-1,0]`
gives `-1/(1+i) = (-1+i)/2`, the true value), which is why the S pin is given the `b`-flip instead.
-/
import SocrateAI.ModularForms.FrickeComposite

namespace TDualM2PinNegControl

open Matrix CongruenceSubgroup UpperHalfPlane Complex
open scoped MatrixGroups

-- The four pin matrices, restated locally (this file is self-contained and imports only
-- `FrickeComposite`, exactly as `TDual0PinNegControl.lean` and `TDualM1NegControl.lean` do).
-- They are character-for-character the `pinGamma*` definitions of `TDualityBridge.lean`.
def pinGammaT : SL(2, ℤ) := ⟨!![1, 1; 0, 1], by norm_num [Matrix.det_fin_two_of]⟩
def pinGammaS : SL(2, ℤ) := ⟨!![0, -1; 1, 0], by norm_num [Matrix.det_fin_two_of]⟩
def pinGammaL2 : SL(2, ℤ) := ⟨!![1, 0; 2, 1], by norm_num [Matrix.det_fin_two_of]⟩
def pinGammaG2 : SL(2, ℤ) := ⟨!![3, 1; 2, 1], by norm_num [Matrix.det_fin_two_of]⟩

-- 1/5 : identity pin, wrong value `-i`
theorem neg_pin_id_i :
    ((Matrix.SpecialLinearGroup.mapGL ℝ (1 : SL(2, ℤ)) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = -Complex.I ∧
      (((1 : SL(2, ℤ)) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = -Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [coe_smul_of_det_pos (by simp)]
    simp [num, denom, Matrix.SpecialLinearGroup.mapGL]
  · rw [coe_specialLinearGroup_apply]
    simp

-- 2/5 : T pin, TRANSPOSED value `(1+i)/2`
theorem neg_pin_T_i :
    ((Matrix.SpecialLinearGroup.mapGL ℝ pinGammaT • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (1 + Complex.I) / 2 ∧
      ((pinGammaT • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (1 + Complex.I) / 2 := by
  refine ⟨?_, ?_⟩
  · rw [coe_smul_of_det_pos (by simp)]
    simp [num, denom, pinGammaT, Matrix.SpecialLinearGroup.mapGL]
    ring
  · rw [coe_specialLinearGroup_apply]
    simp [pinGammaT]
    ring

-- 3/5 : S pin, b-SIGN-FLIP value `(1-i)/2`
theorem neg_pin_S_onePlusI :
    ((Matrix.SpecialLinearGroup.mapGL ℝ pinGammaS • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (1 - Complex.I) / 2 ∧
      ((pinGammaS • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (1 - Complex.I) / 2 := by
  refine ⟨?_, ?_⟩
  · rw [coe_smul_of_det_pos (by simp)]
    simp only [num, denom, pinGammaS, Matrix.SpecialLinearGroup.mapGL]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaS]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

-- 4/5 : Γ₀(2) lower pin, TRANSPOSED value `2+i` (written over 5 so the same tactic block applies)
theorem neg_pin_G0two_lower_i :
    pinGammaL2 ∈ Gamma0 2 ∧
      ((Matrix.SpecialLinearGroup.mapGL ℝ pinGammaL2 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (10 + 5 * Complex.I) / 5 ∧
      ((pinGammaL2 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (10 + 5 * Complex.I) / 5 := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Gamma0_mem, pinGammaL2]
    decide
  · rw [coe_smul_of_det_pos (by simp)]
    simp only [num, denom, pinGammaL2, Matrix.SpecialLinearGroup.mapGL]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaL2]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

-- 5/5 : Γ₀(2) general pin, TRANSPOSED value `(5+i)/2`
theorem neg_pin_G0two_i :
    pinGammaG2 ∈ Gamma0 2 ∧
      ((Matrix.SpecialLinearGroup.mapGL ℝ pinGammaG2 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (5 + Complex.I) / 2 ∧
      ((pinGammaG2 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (5 + Complex.I) / 2 := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Gamma0_mem, pinGammaG2]
    decide
  · rw [coe_smul_of_det_pos (by simp)]
    simp only [num, denom, pinGammaG2, Matrix.SpecialLinearGroup.mapGL]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaG2]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

end TDualM2PinNegControl
