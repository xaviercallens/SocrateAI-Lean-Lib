/- NEGATIVE CONTROL for the TDUAL-M0 decide-pins.  This file MUST FAIL to compile:

     lake env lean verification/TDual0PinNegControl.lean   # must exit nonzero

   Each theorem below is one of the four TDUAL-M0 pins with a deliberately WRONG right-hand
   side — the value the pin would take against a VARIANT frickeMatrix (transpose, b-entry sign
   flip, dropped factor of N), recomputed in exact Gaussian rationals — and with the SAME tactic
   block as the real pin in Lean/SocrateAI/StringTheory/TDualityBridge.lean.  If any of these
   compiles, that tactic block is proving something vacuous and TDUAL-M0 is worthless.

   Expected: exactly four `unsolved goals` errors.

   Note on what these controls CANNOT test: an inverted action convention.  `frickeW_sq_coe`
   gives W_N² = -N·I, a scalar, so W_N and W_N⁻¹ induce the same Möbius map on ℍ — every pin
   returns the true value against W_N⁻¹.  No decide-pin can ever detect that, which is why the
   TDUAL-01 falsifier no longer claims one does. -/
import SocrateAI.ModularForms.FrickeComposite

namespace TD0Neg
open Matrix CongruenceSubgroup UpperHalfPlane Complex
open SocrateAI.ModularForms
open scoped MatrixGroups

-- WRONG: transpose value at N=2 is 2i, not i/2.
theorem neg_pin2_transpose :
    ((frickeW (N := 2) (by norm_num) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = 2 * Complex.I := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  field_simp
  ring_nf
  simp [Complex.I_sq]

-- WRONG: transpose value at N=4, tau=i/2 is 8i, not i/2.
theorem neg_pin3_transpose :
    ((frickeW (N := 4) (by norm_num) • (⟨Complex.I / 2, by norm_num [Complex.div_im]⟩ : ℍ) : ℍ) : ℂ)
      = 8 * Complex.I := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  field_simp
  ring_nf
  simp [Complex.I_sq]

-- WRONG: b-sign-flipped matrix !![0,1;1,0] gives (1-i)/2 at tau = 1+i, not (-1+i)/2.
theorem neg_pin4_bsign :
    ((frickeW (N := 1) (by norm_num) • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
      = (1 - Complex.I) / 2 := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
  ring_nf
  simp [Complex.I_sq]
  ring

-- WRONG: N-dropped matrix !![0,-1;1,0] gives i at N=2, tau=i, not i/2.
theorem neg_pin2_dropN :
    ((frickeW (N := 2) (by norm_num) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos (by norm_num))]
  simp [num, denom, frickeMatrix]

end TD0Neg
