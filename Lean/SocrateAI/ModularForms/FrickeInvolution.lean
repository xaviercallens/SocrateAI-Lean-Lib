/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# The Fricke involution `W_N` on `Γ₀(N)`

Mathlib (commit `905b95818e`, 2026-07-28) provides `CongruenceSubgroup.Gamma0 N`, the weight-`k`
slash action `SlashAction ℤ (GL (Fin 2) ℝ) (ℍ → ℂ)` (already carrying the determinant factor
`|det g|^(k-1)`), and `ModularForm Γ k` for `Γ : Subgroup (GL (Fin 2) ℝ)`.  It contains **no**
Fricke or Atkin–Lehner operator: a repository-wide search for `Fricke` / `AtkinLehner` returns
zero occurrences.  This file supplies the Fricke matrix, its membership in `GL(2,ℝ)⁺`, the
involution identity `W_N² = -N·I`, and the normalisation of `Γ₀(N)`.

Main results:
* `frickeW_mem_GLPos`      — `W_N ∈ GL(2,ℝ)⁺`
* `frickeW_sq_coe`         — `W_N² = -N·I`, i.e. `W_N` is an involution of `ℍ`
* `frickeW_conj_eq`        — `W_N γ W_N⁻¹ = !![d, -c/N; -N b, a]`
* `frickeW_normalizes_Gamma0` — `W_N` normalises the image of `Γ₀(N)` in `GL(2,ℝ)`
-/
import Mathlib.NumberTheory.ModularForms.SlashActions
import Mathlib.NumberTheory.ModularForms.CongruenceSubgroups

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup
open scoped MatrixGroups

/-! ### The Fricke matrix -/

/-- The Fricke matrix `W_N = !![0, -1; N, 0]` over `ℝ`. -/
def frickeMatrix (N : ℕ) : Matrix (Fin 2) (Fin 2) ℝ := !![0, -1; (N : ℝ), 0]

@[simp] theorem frickeMatrix_det (N : ℕ) : (frickeMatrix N).det = (N : ℝ) := by
  simp [frickeMatrix, Matrix.det_fin_two_of]

theorem frickeMatrix_det_ne_zero {N : ℕ} (hN : 0 < N) : (frickeMatrix N).det ≠ 0 := by
  rw [frickeMatrix_det]; exact Nat.cast_ne_zero.mpr hN.ne'

theorem frickeMatrix_det_pos {N : ℕ} (hN : 0 < N) : 0 < (frickeMatrix N).det := by
  rw [frickeMatrix_det]; exact_mod_cast hN

/-- `W_N` as an element of `GL (Fin 2) ℝ`, for `N > 0`. -/
noncomputable def frickeW {N : ℕ} (hN : 0 < N) : GL (Fin 2) ℝ :=
  Matrix.GeneralLinearGroup.mkOfDetNeZero (frickeMatrix N) (frickeMatrix_det_ne_zero hN)

@[simp] theorem frickeW_coe {N : ℕ} (hN : 0 < N) :
    ((frickeW hN : GL (Fin 2) ℝ) : Matrix (Fin 2) (Fin 2) ℝ) = frickeMatrix N := rfl

section
variable {N : ℕ} (hN : 0 < N)

theorem frickeW_det_val : (Matrix.GeneralLinearGroup.det (frickeW hN) : ℝ) = (N : ℝ) := by
  rw [Matrix.GeneralLinearGroup.val_det_apply, frickeW_coe, frickeMatrix_det]

/-- `W_N` has positive determinant `N`, hence lies in `GL(2,ℝ)⁺`. -/
theorem frickeW_mem_GLPos : frickeW hN ∈ GLPos (Fin 2) ℝ := by
  rw [Matrix.mem_glpos, frickeW_det_val]; exact_mod_cast hN

/-- `W_N² = -N·I`.  Scalar matrices act trivially on `ℍ`, so `W_N` induces an **involution**
of the upper half-plane. -/
theorem frickeW_sq_coe :
    ((frickeW hN * frickeW hN : GL (Fin 2) ℝ) : Matrix (Fin 2) (Fin 2) ℝ)
      = (-(N : ℝ)) • (1 : Matrix (Fin 2) (Fin 2) ℝ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [frickeMatrix, Matrix.mul_apply, Fin.sum_univ_two]

end

/-! ### Normalisation of `Γ₀(N)` -/

/-- For `γ ∈ Γ₀(N)` the lower-left entry is divisible by `N`. -/
theorem gamma0_dvd_lower_left {N : ℕ} {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) :
    (N : ℤ) ∣ γ.1 1 0 := by
  rw [Gamma0_mem] at hγ
  exact (ZMod.intCast_zmod_eq_zero_iff_dvd _ _).mp hγ

/-- The Fricke conjugate of `γ = !![a,b;c,d]` with `c = N·c'`, namely `!![d, -c'; -N·b, a]`.
Its determinant is `ad - bc = 1`, so it again lies in `SL(2,ℤ)`. -/
def frickeConj {N : ℕ} (γ : SL(2, ℤ)) (c' : ℤ) (hc : γ.1 1 0 = (N : ℤ) * c') : SL(2, ℤ) :=
  ⟨!![γ.1 1 1, -c'; -(N : ℤ) * γ.1 0 1, γ.1 0 0], by
    have hdet := γ.2
    rw [Matrix.det_fin_two] at hdet; rw [hc] at hdet
    rw [Matrix.det_fin_two_of]; linear_combination hdet⟩

/-- The Fricke conjugate stays in `Γ₀(N)`: its lower-left entry is `-N·b ≡ 0 (mod N)`. -/
theorem frickeConj_mem_Gamma0 {N : ℕ} (γ : SL(2, ℤ)) (c' : ℤ) (hc : γ.1 1 0 = (N : ℤ) * c') :
    frickeConj γ c' hc ∈ Gamma0 N := by
  rw [Gamma0_mem]
  show ((-(N : ℤ) * γ.1 0 1 : ℤ) : ZMod N) = 0
  push_cast; simp

/-- **Intertwining relation:** `W_N · γ = frickeConj(γ) · W_N` in `GL(2,ℝ)`. -/
theorem frickeW_intertwine {N : ℕ} (hN : 0 < N) (γ : SL(2, ℤ)) (c' : ℤ)
    (hc : γ.1 1 0 = (N : ℤ) * c') :
    frickeW hN * (Matrix.SpecialLinearGroup.mapGL ℝ γ)
      = (Matrix.SpecialLinearGroup.mapGL ℝ (frickeConj γ c' hc)) * frickeW hN := by
  apply Matrix.GeneralLinearGroup.ext
  intro i j
  have hcR : ((γ.1 1 0 : ℤ) : ℝ) = (N : ℝ) * (c' : ℝ) := by
    exact_mod_cast congrArg (Int.cast : ℤ → ℝ) hc
  fin_cases i <;> fin_cases j <;>
    simp [Units.val_mul, frickeW, frickeMatrix, frickeConj,
          Matrix.SpecialLinearGroup.mapGL_coe_matrix, Matrix.mul_apply, Fin.sum_univ_two,
          Matrix.map_apply] <;>
    linarith [hcR]

/-- **Explicit conjugation:** `W_N γ W_N⁻¹ = !![d, -c/N; -N b, a]`. -/
theorem frickeW_conj_eq {N : ℕ} (hN : 0 < N) (γ : SL(2, ℤ)) (c' : ℤ)
    (hc : γ.1 1 0 = (N : ℤ) * c') :
    frickeW hN * (Matrix.SpecialLinearGroup.mapGL ℝ γ) * (frickeW hN)⁻¹
      = Matrix.SpecialLinearGroup.mapGL ℝ (frickeConj γ c' hc) := by
  rw [frickeW_intertwine hN γ c' hc, mul_assoc, mul_inv_cancel, mul_one]

/-- **Main theorem.** `W_N` normalises the image of `Γ₀(N)` in `GL(2,ℝ)`.  Consequently
`f ↦ f ∣[k] W_N` maps weight-`k` forms for `Γ₀(N)` to weight-`k` forms for `Γ₀(N)`, and by
`frickeW_sq_coe` it is an involution up to scalars — the Fricke involution. -/
theorem frickeW_normalizes_Gamma0 {N : ℕ} (hN : 0 < N) :
    ∀ g ∈ (Gamma0 N).map (Matrix.SpecialLinearGroup.mapGL ℝ),
      frickeW hN * g * (frickeW hN)⁻¹ ∈ (Gamma0 N).map (Matrix.SpecialLinearGroup.mapGL ℝ) := by
  rintro g hg
  rw [Subgroup.mem_map] at hg
  obtain ⟨γ, hγ, rfl⟩ := hg
  obtain ⟨c', hc⟩ := gamma0_dvd_lower_left hγ
  rw [frickeW_conj_eq hN γ c' hc]
  exact Subgroup.mem_map_of_mem _ (frickeConj_mem_Gamma0 γ c' hc)

end SocrateAI.ModularForms
