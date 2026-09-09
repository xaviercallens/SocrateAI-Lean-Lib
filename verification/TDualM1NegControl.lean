/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# NEGATIVE CONTROL for TDUAL-M1 (`SocrateAI.StringTheory.frickeW_smul_coe`)

This file is **expected to FAIL to compile**, with exactly four `unsolved goals` errors.

`verification/TDual0PinNegControl.lean` already certifies that the four TDUAL-M0 decide-pins
discriminate — but pins are instances, and an instance check cannot certify that the *general*
formula's tactic block is doing real work rather than closing whatever it is handed.  This file
supplies that certificate at the general level: it restates TDUAL-M1 with four *wrong*
right-hand sides and the **identical** tactic block that proves the real thing
(`rw [coe_smul_of_det_pos (frickeW_mem_GLPos hN)]; simp [num, denom, frickeW_coe, frickeMatrix]`).

The four variants and what each one is a stand-in for:

| variant | RHS | corresponds to the `frickeMatrix` error |
| --- | --- | --- |
| 1 | `1 / (N·τ)`   | `b`-entry sign flip, `!![0,1;N,0]` |
| 2 | `-1 / τ`      | dropped factor of `N`, `!![0,-1;1,0]` |
| 3 | `-(N:ℂ) / τ`  | transposed matrix, `!![0,N;-1,0]` |
| 4 | `-1 / ((N:ℂ) + τ)` | `denom` read as `c + d·τ` rather than `c·τ + d` |

Run: `lake --packages=local-packages.json env lean verification/TDualM1NegControl.lean`
Expected: **exit 1**, exactly four `unsolved goals` errors, one per theorem below.
If this file ever *compiles*, TDUAL-M1's proof is vacuous and the node must be reopened.
-/
import SocrateAI.ModularForms.FrickeComposite

namespace SocrateAI.Verification.TDualM1NegControl

open Matrix CongruenceSubgroup UpperHalfPlane Complex
open SocrateAI.ModularForms
open scoped MatrixGroups

/-- NEG 1/4 — `b`-entry sign flip.  MUST FAIL. -/
theorem neg_bflip {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    ((frickeW hN • τ : ℍ) : ℂ) = 1 / ((N : ℂ) * (τ : ℂ)) := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos hN)]
  simp [num, denom, frickeW_coe, frickeMatrix]

/-- NEG 2/4 — dropped factor of `N`.  MUST FAIL (it is true only at `N = 1`). -/
theorem neg_dropN {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    ((frickeW hN • τ : ℍ) : ℂ) = -1 / (τ : ℂ) := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos hN)]
  simp [num, denom, frickeW_coe, frickeMatrix]

/-- NEG 3/4 — transposed matrix, `τ ↦ -N/τ`.  MUST FAIL (true only at `N = 1`). -/
theorem neg_transpose {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    ((frickeW hN • τ : ℍ) : ℂ) = -(N : ℂ) / (τ : ℂ) := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos hN)]
  simp [num, denom, frickeW_coe, frickeMatrix]

/-- NEG 4/4 — `denom` misread as `c + d·τ`.  MUST FAIL. -/
theorem neg_denom_swap {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    ((frickeW hN • τ : ℍ) : ℂ) = -1 / ((N : ℂ) + (τ : ℂ)) := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos hN)]
  simp [num, denom, frickeW_coe, frickeMatrix]

end SocrateAI.Verification.TDualM1NegControl
