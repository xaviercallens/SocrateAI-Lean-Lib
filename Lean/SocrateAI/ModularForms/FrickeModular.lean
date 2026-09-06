/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# The Fricke operator on modular forms  (DAG: FRK-09)

Upgrades the slash-level operator of `FrickeSlash.lean` to Mathlib's bundled
`ModularForm (Gamma0GL N) k`, by transporting the two analytic side conditions along `W_N`:

* **holomorphy** — immediate from Mathlib's `MDifferentiable.slash`, since slashing by any
  fixed element of `GL(2,ℝ)` preserves `MDiff`;
* **boundedness at the cusps** — from `OnePoint.IsBoundedAt.smul_iff`, once we know `W_N`
  carries cusps of `Γ₀(N)` to cusps of `Γ₀(N)`.  That last fact is the subgroup form of the
  normalisation theorem `frickeW_normalizes_Gamma0` (FRK-07) combined with Mathlib's
  `IsCusp.smul` and the monotonicity of `IsCusp` in its subgroup argument.

Concretely `W_N` exchanges the cusps `0` and `∞` of `Γ₀(N)`; the statement proved here is the
weaker but sufficient one that the cusp set is preserved.
-/
import SocrateAI.ModularForms.FrickeSlash
import Mathlib.NumberTheory.ModularForms.Basic

namespace SocrateAI.ModularForms
open Matrix CongruenceSubgroup ModularForm UpperHalfPlane
open scoped MatrixGroups Pointwise

variable {N : ℕ} (hN : 0 < N) {k : ℤ}

/-- Subgroup form of FRK-07: conjugation by `W_N` maps `Γ₀(N)` into itself. -/
theorem frickeW_conjAct_le :
    ConjAct.toConjAct (frickeW hN) • Gamma0GL N ≤ Gamma0GL N := by
  rintro x hx
  rw [Subgroup.mem_pointwise_smul_iff_inv_smul_mem, ← ConjAct.toConjAct_inv,
      ConjAct.toConjAct_smul] at hx
  have h := frickeW_normalizes_Gamma0 hN _ hx
  have e : frickeW hN * ((frickeW hN)⁻¹ * x * (frickeW hN)⁻¹⁻¹) * (frickeW hN)⁻¹ = x := by group
  rwa [e] at h

/-- `IsCusp` is monotone in the subgroup, so cusps transport along `W_N`. -/
theorem isCusp_frickeW_smul {c : OnePoint ℝ} (hc : IsCusp c (Gamma0GL N)) :
    IsCusp (frickeW hN • c) (Gamma0GL N) := by
  obtain ⟨g, hg, hpar, hfix⟩ := hc.smul (frickeW hN)
  exact ⟨g, frickeW_conjAct_le hN hg, hpar, hfix⟩

/-- **FRK-09.** The Fricke operator on bundled modular forms. -/
noncomputable def frickeModularOperator :
    ModularForm (Gamma0GL N) k → ModularForm (Gamma0GL N) k := fun f =>
  { toSlashInvariantForm := frickeSlashOperator hN f.toSlashInvariantForm
    holo' := by simpa using f.holo'.slash k (frickeW hN)
    bdd_at_cusps' := by
      intro c hc
      show OnePoint.IsBoundedAt c (⇑f.toSlashInvariantForm ∣[k] frickeW hN) k
      rw [← OnePoint.IsBoundedAt.smul_iff]
      exact f.bdd_at_cusps' (isCusp_frickeW_smul hN hc) }

end SocrateAI.ModularForms
