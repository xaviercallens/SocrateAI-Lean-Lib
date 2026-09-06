/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# The Fricke operator on slash-invariant forms  (DAG: FRK-08)

Slashing by `W_N` preserves `Γ₀(N)`-slash-invariance: for `f` invariant under the image of
`Γ₀(N)` in `GL(2,ℝ)` and `g` in that image,

    (f ∣[k] W_N) ∣[k] g = f ∣[k] W_N ,

because `W_N · γ = δ · W_N` with `δ = frickeConj γ ∈ Γ₀(N)` (`frickeW_intertwine`), so the
slash-cocycle `slash_mul` converts invariance under `δ` into invariance of `f ∣[k] W_N`
under `γ`.  This packages the group-level normalisation theorem `frickeW_normalizes_Gamma0`
into an operator on Mathlib's bundled `SlashInvariantForm`.
-/
import SocrateAI.ModularForms.FrickeInvolution
import Mathlib.NumberTheory.ModularForms.SlashInvariantForms

namespace SocrateAI.ModularForms
open Matrix CongruenceSubgroup ModularForm
open scoped MatrixGroups

/-- The image of `Γ₀(N)` in `GL(2,ℝ)` — the subgroup for which Mathlib's bundled
`SlashInvariantForm` and `ModularForm` are stated. -/
abbrev Gamma0GL (N : ℕ) : Subgroup (GL (Fin 2) ℝ) :=
  (Gamma0 N).map (Matrix.SpecialLinearGroup.mapGL ℝ)

/-- **FRK-08.** Slashing by `W_N` preserves `Γ₀(N)`-slash-invariance. -/
theorem slash_frickeW_invariant {N : ℕ} (hN : 0 < N) {k : ℤ}
    (f : SlashInvariantForm (Gamma0GL N) k) :
    ∀ g ∈ Gamma0GL N, (⇑f ∣[k] frickeW hN) ∣[k] g = ⇑f ∣[k] frickeW hN := by
  rintro g hg
  rw [Gamma0GL, Subgroup.mem_map] at hg
  obtain ⟨γ, hγ, rfl⟩ := hg
  obtain ⟨c', hc⟩ := gamma0_dvd_lower_left hγ
  rw [← SlashAction.slash_mul, frickeW_intertwine hN γ c' hc, SlashAction.slash_mul,
      SlashInvariantFormClass.slash_action_eq f _
        (Subgroup.mem_map_of_mem _ (frickeConj_mem_Gamma0 γ c' hc))]

/-- The Fricke operator `f ↦ f ∣[k] W_N` on slash-invariant forms for `Γ₀(N)`. -/
noncomputable def frickeSlashOperator {N : ℕ} (hN : 0 < N) {k : ℤ} :
    SlashInvariantForm (Gamma0GL N) k → SlashInvariantForm (Gamma0GL N) k :=
  fun f => ⟨⇑f ∣[k] frickeW hN, slash_frickeW_invariant hN f⟩

@[simp] theorem frickeSlashOperator_coe {N : ℕ} (hN : 0 < N) {k : ℤ}
    (f : SlashInvariantForm (Gamma0GL N) k) :
    ⇑(frickeSlashOperator hN f) = ⇑f ∣[k] frickeW hN := rfl

end SocrateAI.ModularForms
