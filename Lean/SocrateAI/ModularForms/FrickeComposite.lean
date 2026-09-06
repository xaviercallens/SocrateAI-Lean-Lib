/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# The Fricke composite is an explicit scalar  (DAG: FRK-10, core)

`W_N^2 = -N·I` is a scalar matrix, so slashing twice by `W_N` multiplies by a constant.  With
Mathlib's normalisation `f ∣[k] g = σ g (f (g • τ)) * |det g|^(k-1) * denom g τ ^ (-k)` and
`det (W_N^2) = N^2`, `denom (W_N^2) = -N`, `W_N^2 • τ = τ`, the constant is
`(N^2)^(k-1) * (-N)^(-k) = (-1)^k N^(k-2)`.

Consequently, for even `k`, `f ↦ N^(1-k/2) (f ∣[k] W_N)` squares to the identity, which is the
Fricke involution proper and yields the `±1` eigenspace decomposition.  (For odd `k` the
question is vacuous: `-I ∈ Γ₀(N)` forces `f ≡ 0`, Mathlib's `eq_zero_of_neg_one_mem`.)

The `σ` factor is handled without a determinant case split: `σ_mul` then `σ_sq` give
`σ (W*W) z = σ W (σ W z) = z` directly.
-/
import SocrateAI.ModularForms.FrickeModular

namespace SocrateAI.ModularForms
open Matrix ModularForm UpperHalfPlane Complex
open scoped MatrixGroups

variable {N : ℕ} (hN : 0 < N) {k : ℤ}

/-- `det (W_N * W_N) = N^2`. -/
theorem frickeW_sq_det : ((frickeW hN * frickeW hN).det.val : ℝ) = (N : ℝ) ^ 2 := by
  rw [Matrix.GeneralLinearGroup.val_det_apply, frickeW_sq_coe, Matrix.det_fin_two]
  simp
  ring

theorem frickeW_sq_det_pos : 0 < ((frickeW hN * frickeW hN).det.val : ℝ) := by
  rw [frickeW_sq_det hN]; positivity

/-- `denom (W_N^2) τ = -N`. -/
theorem frickeW_sq_denom (τ : ℍ) :
    denom (frickeW hN * frickeW hN) (τ : ℂ) = ((-(N : ℝ) : ℝ) : ℂ) := by
  simp [denom, frickeMatrix, Matrix.mul_apply, Fin.sum_univ_two]

/-- `W_N^2` acts trivially on `ℍ` (it is a scalar matrix). -/
theorem frickeW_sq_smul (τ : ℍ) : (frickeW hN * frickeW hN) • τ = τ := by
  ext
  rw [coe_smul_of_det_pos (frickeW_sq_det_pos hN)]
  have hd : denom (frickeW hN * frickeW hN) (τ : ℂ) = ((-(N : ℝ) : ℝ) : ℂ) :=
    frickeW_sq_denom hN τ
  have hNc : ((N : ℕ) : ℂ) ≠ 0 := by exact_mod_cast hN.ne'
  simp [num, hd, frickeMatrix, Matrix.mul_apply, Fin.sum_univ_two]
  exact mul_div_cancel_left₀ _ hNc

/-- **FRK-10 core probe.** -/
theorem frickeW_sq_slash (f : ℍ → ℂ) :
    (f ∣[k] frickeW hN) ∣[k] frickeW hN
      = fun τ => (((N : ℝ) ^ 2 : ℝ) : ℂ) ^ (k - 1) * ((-(N : ℝ) : ℝ) : ℂ) ^ (-k) * f τ := by
  rw [← SlashAction.slash_mul]
  funext τ
  rw [slash_apply, frickeW_sq_smul hN, frickeW_sq_denom hN, frickeW_sq_det hN,
      σ_mul, σ_sq, abs_of_nonneg (by positivity : (0:ℝ) ≤ (N:ℝ) ^ 2)]
  ring

end SocrateAI.ModularForms
