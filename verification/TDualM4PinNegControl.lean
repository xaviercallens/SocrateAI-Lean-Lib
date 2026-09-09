/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# NEGATIVE CONTROL for the TDUAL-M4 two-step gate (`frickeW_invol_pin_*`)

This file is **expected to FAIL to compile**, with exactly ten `unsolved goals` errors — two per
pin.

## Why the control is on the pins and NOT on `frickeW_smul_involutive`

`TDUAL-M4` itself is proved by `rw [← mul_smul]; exact frickeW_sq_smul hN τ`, i.e. by *exact* of an
already-proved lemma.  A wrong-right-hand-side restatement of that theorem would fail for the
trivial reason that `exact` does not unify — which certifies nothing about the mathematics, exactly
the blindness `TDualityBridge.lean` already records for `TDUAL-M2`'s `rfl`.  So no such control is
manufactured here.

What *can* be discriminated is the two-step gate: the five `frickeW_invol_pin_*` lemmas evaluate
`W_N • τ` and `W_N • W_N • τ` **separately** at five points whose exact Gaussian-rational values
were computed first, through `frickeW_smul_coe` (TDUAL-M1) applied once and twice — a route
independent of `frickeW_sq_smul`, which reaches the same conclusion through the product matrix
`W_N * W_N` and its `denom`.  This file restates all ten conjuncts with wrong values under the
**identical** tactic blocks.

| pin | `N` | `τ` | true `W•τ` | wrong `W•τ` (variant) | true `W•W•τ` | wrong `W•W•τ` |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 2 | `i`   | `i/2`      | `i` (dropped `N`)      | `i`   | `i/2` (idempotent) |
| 2 | 3 | `2i`  | `i/6`      | `i/2` (dropped `N`)    | `2i`  | `i/6` (idempotent) |
| 3 | 1 | `1+i` | `(-1+i)/2` | `(1-i)/2` (`b`-flip)   | `1+i` | `(-1+i)/2` (idempotent) |
| 4 | 2 | `1+i` | `(-1+i)/4` | `(-1+i)/2` (dropped `N`) | `1+i` | `(-1+i)/4` (idempotent) |
| 5 | 4 | `i`   | `i/4`      | `i` (dropped `N`)      | `i`   | `i/4` (idempotent) |

The second column of wrong values is the **idempotent** variant `W•W•τ = W•τ`: the claim that the
Fricke map is a projection rather than an involution.  That is the one substantive error a
two-step pin exists to catch, and it is wrong at all five points precisely because all five were
chosen so that `W•τ ≠ τ` (which is why the `N = 1`, `τ = i` self-dual point and the `N = 4`,
`τ = i/2` fixed point of `TDUAL-M0` are *not* reused here).  The first column catches a dropped
factor of `N` or a flipped `b`-entry in `frickeMatrix` at the single-step level.

Run: `lake --packages=local-packages.json env lean verification/TDualM4PinNegControl.lean`
Expected: **exit 1**, exactly ten `unsolved goals` errors.
If this file ever *compiles*, the TDUAL-M4 gate is vacuous and the node must be reopened.
-/
import SocrateAI.StringTheory.TDualityBridge

namespace SocrateAI.Verification.TDualM4PinNegControl

open Matrix CongruenceSubgroup UpperHalfPlane Complex
open SocrateAI.ModularForms SocrateAI.StringTheory
open scoped MatrixGroups

/-- NEG pin 1/5 — `N = 2` at `i`.  MUST FAIL twice. -/
theorem neg_pin_N2_i :
    ((frickeW (N := 2) (by norm_num) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I ∧
      ((frickeW (N := 2) (by norm_num) • frickeW (N := 2) (by norm_num)
          • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I / 2 := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    field_simp
    rw [Complex.I_sq]
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- NEG pin 2/5 — `N = 3` at `2i`.  MUST FAIL twice. -/
theorem neg_pin_N3_twoI :
    ((frickeW (N := 3) (by norm_num) • (⟨2 * Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = Complex.I / 2 ∧
      ((frickeW (N := 3) (by norm_num) • frickeW (N := 3) (by norm_num)
          • (⟨2 * Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I / 6 := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    field_simp
    rw [Complex.I_sq]; ring
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- NEG pin 3/5 — `N = 1` at `1+i`.  MUST FAIL twice. -/
theorem neg_pin_N1_onePlusI :
    ((frickeW (N := 1) (by norm_num) • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (1 - Complex.I) / 2 ∧
      ((frickeW (N := 1) (by norm_num) • frickeW (N := 1) (by norm_num)
          • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (-1 + Complex.I) / 2 := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- NEG pin 4/5 — `N = 2` at `1+i`.  MUST FAIL twice. -/
theorem neg_pin_N2_onePlusI :
    ((frickeW (N := 2) (by norm_num) • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (-1 + Complex.I) / 2 ∧
      ((frickeW (N := 2) (by norm_num) • frickeW (N := 2) (by norm_num)
          • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (-1 + Complex.I) / 4 := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- NEG pin 5/5 — `N = 4` at `i`.  MUST FAIL twice. -/
theorem neg_pin_N4_i :
    ((frickeW (N := 4) (by norm_num) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I ∧
      ((frickeW (N := 4) (by norm_num) • frickeW (N := 4) (by norm_num)
          • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I / 4 := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    field_simp
    rw [Complex.I_sq]
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

end SocrateAI.Verification.TDualM4PinNegControl
