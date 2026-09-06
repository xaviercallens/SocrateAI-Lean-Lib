# PROOF-PATH — classical argument ↔ Lean names

Convention from `anthropics/fermats-last-theorem` (its `PROOF-PATH.md` maps Frey → Serre →
Ribet → Wiles → Taylor–Wiles onto formal code). Each row here maps a step of the classical
Fricke/Atkin–Lehner theory onto its formal counterpart; `—` means not yet formalized (see
`dag/theorems.jsonl` for status and dependencies).

| Classical step (Atkin–Lehner 1970; Diamond–Shurman §§5.1–5.3) | Lean name | DAG |
|---|---|---|
| The matrix `W_N = [[0,−1],[N,0]]`, `det = N` | `frickeMatrix`, `frickeMatrix_det` | FRK-DEF |
| `W_N ∈ GL₂⁺(ℝ)` | `frickeW_mem_GLPos` | FRK-01 |
| `W_N² = −N·I` (involution of ℍ) | `frickeW_sq_coe` | FRK-02 |
| `γ ∈ Γ₀(N) ⟹ N ∣ c` | `gamma0_dvd_lower_left` | FRK-03 |
| `W_N γ W_N⁻¹ = [[d,−c/N],[−Nb,a]] ∈ Γ₀(N)` | `frickeConj`, `frickeConj_mem_Gamma0`, `frickeW_conj_eq` | FRK-04/06 |
| `W_N` normalises `Γ₀(N)` | `frickeW_normalizes_Gamma0` | FRK-07 |
| `f ↦ f∣ₖW_N` preserves slash-invariance | `slash_frickeW_invariant`, `frickeSlashOperator` | FRK-08 |
| …and holomorphy + cusp conditions (`W_N` swaps 0 ↔ ∞) | `frickeModularOperator`, `isCusp_frickeW_smul`, `frickeW_conjAct_le` | FRK-09 |
| `N^{k/2−1}`-normalised operator is an involution; ±1 eigenspaces | — | FRK-10 |
| The full family `W_Q`, `Q ∥ N` | — | ALQ-01 |
| Ligozat criterion for eta-quotients on `Γ₀(N)` | — | ETA-01 |

Axiom gate: `Lean/SocrateAI/FinalCheck.lean` (`#guard_msgs in #print axioms`, build-failing).
Negative control: `scratch/GuardNegativeControl.lean` (must fail; verified 2026-09-06).
