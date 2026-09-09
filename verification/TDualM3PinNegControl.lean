/-
NEGATIVE CONTROL for the TDUAL-M3 fractional-linear pins.  THIS FILE MUST FAIL TO COMPILE.

It restates the five pins of `SocrateAI/StringTheory/TDualityBridge.lean` (TDUAL-M3 gate) with
*wrong* right-hand sides, under the *identical* tactic blocks, and must fail with exactly ten
`error:` occurrences — two per pin, one on the action side and one on the formula side.  (The two
`Γ₀` membership conjuncts are left correct and stay proved, so they contribute no errors.)  That is
what certifies that each pin's tactic block computes the value from the matrix entries rather than
being closed by whatever it is compared against.

Run:  lake --packages=local-packages.json env lean verification/TDualM3PinNegControl.lean
      -> MUST exit nonzero, with exactly 10 `error:` lines.

The wrong values are not arbitrary; each is the value a specific ENTRY-POSITION error in the
`TDUAL-M3` statement would produce, recomputed in exact Gaussian-rational arithmetic:
  * `2111` pin, τ = i   : `(3+i)/5`        — an `a`/`d` SWAP `!![1,1;1,2]`.
  * `Tsq`  pin, τ = i   : `(2+i)/5`        — the TRANSPOSED matrix `!![1,0;2,1]`.
  * `L3`   pin, τ = i   : `3+i`            — the TRANSPOSED matrix `!![1,3;0,1]`.
  * `G5`   pin, τ = i   : `(64+41i)/109`   — a `b`-entry SIGN FLIP `!![7,-2;10,3]`.
  * `negB` pin, τ = 2i  : `(-2-i)/2`       — a `c`-entry SIGN FLIP `!![1,-1;-1,0]`.
Recorded honestly, because each pin is blind to exactly one of the four variants: the `2111` pin
cannot see a transpose (`b = c = 1`), `Tsq` cannot see a `c`-flip (`c = 0`) or an `a`/`d` swap
(`a = d`), `L3` cannot see a `b`-flip (`b = 0`) or an `a`/`d` swap, and each is therefore given a
variant it CAN see.  Only the `G5` pin sees all five variants.
-/
import SocrateAI.ModularForms.FrickeComposite

namespace TDualM3PinNegControl

open Matrix CongruenceSubgroup UpperHalfPlane Complex
open scoped MatrixGroups

-- The five pin matrices, restated locally (this file is self-contained and imports only
-- `FrickeComposite`, exactly as the other TDUAL negative controls do).  They are
-- character-for-character the `pinGamma*` definitions of `TDualityBridge.lean`.
def pinGamma2111 : SL(2, ℤ) := ⟨!![2, 1; 1, 1], by norm_num [Matrix.det_fin_two_of]⟩

def pinGammaTsq : SL(2, ℤ) := ⟨!![1, 2; 0, 1], by norm_num [Matrix.det_fin_two_of]⟩

def pinGammaL3 : SL(2, ℤ) := ⟨!![1, 0; 3, 1], by norm_num [Matrix.det_fin_two_of]⟩

def pinGammaG5 : SL(2, ℤ) := ⟨!![7, 2; 10, 3], by norm_num [Matrix.det_fin_two_of]⟩

def pinGammaNegB : SL(2, ℤ) := ⟨!![1, -1; 1, 0], by norm_num [Matrix.det_fin_two_of]⟩

theorem neg_m3_pin_2111_i :
    ((pinGamma2111 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (3 + Complex.I) / 5 ∧
      (((pinGamma2111.1 0 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGamma2111.1 0 1 : ℤ) : ℂ)) /
        (((pinGamma2111.1 1 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGamma2111.1 1 1 : ℤ) : ℂ))
        = (3 + Complex.I) / 5 := by
  refine ⟨?_, ?_⟩
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGamma2111]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · simp only [pinGamma2111]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

theorem neg_m3_pin_Tsq_i :
    ((pinGammaTsq • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (2 + Complex.I) / 5 ∧
      (((pinGammaTsq.1 0 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaTsq.1 0 1 : ℤ) : ℂ)) /
        (((pinGammaTsq.1 1 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaTsq.1 1 1 : ℤ) : ℂ))
        = (2 + Complex.I) / 5 := by
  refine ⟨?_, ?_⟩
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaTsq]
    rw [div_eq_iff (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
  · simp only [pinGammaTsq]
    rw [div_eq_iff (by norm_num)]
    ring_nf
    simp [Complex.I_sq]

theorem neg_m3_pin_L3_i :
    pinGammaL3 ∈ Gamma0 3 ∧
      ((pinGammaL3 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (30 + 10 * Complex.I) / 10 ∧
      (((pinGammaL3.1 0 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaL3.1 0 1 : ℤ) : ℂ)) /
        (((pinGammaL3.1 1 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaL3.1 1 1 : ℤ) : ℂ))
        = (30 + 10 * Complex.I) / 10 := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Gamma0_mem, pinGammaL3]
    decide
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaL3]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · simp only [pinGammaL3]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

theorem neg_m3_pin_G5_i :
    pinGammaG5 ∈ Gamma0 5 ∧
      ((pinGammaG5 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (64 + 41 * Complex.I) / 109 ∧
      (((pinGammaG5.1 0 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaG5.1 0 1 : ℤ) : ℂ)) /
        (((pinGammaG5.1 1 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaG5.1 1 1 : ℤ) : ℂ))
        = (64 + 41 * Complex.I) / 109 := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Gamma0_mem, pinGammaG5]
    decide
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaG5]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · simp only [pinGammaG5]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

theorem neg_m3_pin_negB_twoI :
    ((pinGammaNegB • (⟨2 * Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (-2 - Complex.I) / 2 ∧
      (((pinGammaNegB.1 0 0 : ℤ) : ℂ) * ((⟨2 * Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaNegB.1 0 1 : ℤ) : ℂ)) /
        (((pinGammaNegB.1 1 0 : ℤ) : ℂ) * ((⟨2 * Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaNegB.1 1 1 : ℤ) : ℂ))
        = (-2 - Complex.I) / 2 := by
  refine ⟨?_, ?_⟩
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaNegB]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
  · simp only [pinGammaNegB]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]

end TDualM3PinNegControl
