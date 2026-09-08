/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.NumberTheory.DedekindSum
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Tactic.NormNum.LegendreSymbol

/-!
# DRK-10, half 1 — the Dedekind sum modulo 8 and the Jacobi symbol

`12 k s(h,k) = k + 1 - 2 (h|k) + 8t` for odd `k` coprime to `h`.

LL-22: everything in this file is Apostol's `s(h,k)` (`SocrateAI.NumberTheory.dedekindSum`).
It is **not** `Φ` and **not** Rademacher's `Ψ`.

## Provenance, per declaration (ATTRIBUTION.md §8)

* `dedekindSum_jacobiSym_mod_eight` — **STATEMENT-ONLY port** of
  `anthropics/fermats-last-theorem`, `Theorems/Thm_dedekindSum_jacobiSym_mod_eight.lean`
  (Apache-2.0; fetched 2026-09-08, HTTP 200, 449 bytes).  Its statement is reproduced here
  character for character after whitespace normalisation.  Upstream's *proof* is
  `p2m_exact_reverting @_root_.P2MW.S_dedekindSum_jacobiSym_mod_eight.solution`, a tactic that
  does not exist in this library, so **no proof text was or could be taken**: the proof below is
  ours (Euclidean descent on the odd modulus, run through our own `DRK-02`).
* every other declaration in this file — **INDEPENDENT**.  In particular
  `exists_intCast_eq_twelve_mul_dedekindSum` is *not* upstream's
  `exists_intCast_eq_six_mul_dedekindSum`; see its docstring, which states loudly that ours is
  the strictly weaker `12k` form.

## Scope, stated loudly (LL-1)

* **ODD MODULUS ONLY.**  `hk : Odd k` is load-bearing and the theorem is *false* without it —
  `drk10_fails_k_even_one_two`, `..._three_eight` are kernel negative controls.  Nothing here
  says anything about the even-`c` branch of the Petersson multiplier.
* **`h : ℕ`.**  The numerator is a natural number, as upstream.  A consumer needing `s(d,c)`
  with `d < 0` must first go through `dedekindSum_add_mul` / `dedekindSum_neg`.
* `hhk : Nat.Coprime h k` is load-bearing too — `drk10_fails_gcd_three_nine`,
  `..._gcd_five_fifteen`.
-/

set_option autoImplicit false

namespace SocrateAI.NumberTheory

open Finset

/-! ## DRK-10 SIGN-DISCIPLINE GATE (LL-22)

Twelve instances of the exact statement of `dedekindSum_jacobiSym_mod_eight`, with the witness
`t` written out, and four negative controls.  Every `s(h,k)` value is a `decide +kernel`
evaluation of the *definition*; every Jacobi symbol is `norm_num`'s quadratic-reciprocity
evaluation; every `t` was computed independently in Python (`fractions.Fraction`, the sawtooth
and `s(h,k)` re-implemented from the mathematical definition and first checked against all
eleven existing `decide +kernel` pins of `DedekindSum.lean`) **before** any of this was written.
The same Python sweep checked the statement at all 3889 pairs with `k` odd `< 80`, `h < 120`,
`gcd(h,k) = 1`: zero violations.

No general lemma of this file is stated above this gate. -/

section Drk10Gate

/-- PIN 1/12 — `k = 1`, the base case of the induction. -/
theorem drk10_pin_one_one :
    ∃ t : ℤ, 12 * (1 : ℚ) * dedekindSum 1 1
      = (1 : ℚ) + 1 - 2 * ((jacobiSym 1 1 : ℤ) : ℚ) + 8 * t := by
  refine ⟨0, ?_⟩
  have hs : dedekindSum 1 1 = 0 := by decide +kernel
  have hj : jacobiSym 1 1 = 1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 2/12 — `h = 0`, forced by coprimality to `k = 1`. -/
theorem drk10_pin_zero_one :
    ∃ t : ℤ, 12 * (1 : ℚ) * dedekindSum 0 1
      = (1 : ℚ) + 1 - 2 * ((jacobiSym 0 1 : ℤ) : ℚ) + 8 * t := by
  refine ⟨0, ?_⟩
  have hs : dedekindSum 0 1 = 0 := by decide +kernel
  have hj : jacobiSym 0 1 = 1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 3/12 — `(1,5)`, `t = 1`. -/
theorem drk10_pin_one_five :
    ∃ t : ℤ, 12 * (5 : ℚ) * dedekindSum 1 5
      = (5 : ℚ) + 1 - 2 * ((jacobiSym 1 5 : ℤ) : ℚ) + 8 * t := by
  refine ⟨1, ?_⟩
  have hs : dedekindSum 1 5 = 1 / 5 := by decide +kernel
  have hj : jacobiSym 1 5 = 1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 4/12 — `(2,5)`, an **even** numerator and `(2|5) = -1`, `t = -1`. -/
theorem drk10_pin_two_five :
    ∃ t : ℤ, 12 * (5 : ℚ) * dedekindSum 2 5
      = (5 : ℚ) + 1 - 2 * ((jacobiSym 2 5 : ℤ) : ℚ) + 8 * t := by
  refine ⟨-1, ?_⟩
  have hs : dedekindSum 2 5 = 0 := by decide +kernel
  have hj : jacobiSym 2 5 = -1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 5/12 — `(3,7)`, `t = -2`. -/
theorem drk10_pin_three_seven :
    ∃ t : ℤ, 12 * (7 : ℚ) * dedekindSum 3 7
      = (7 : ℚ) + 1 - 2 * ((jacobiSym 3 7 : ℤ) : ℚ) + 8 * t := by
  refine ⟨-2, ?_⟩
  have hs : dedekindSum 3 7 = -1 / 14 := by decide +kernel
  have hj : jacobiSym 3 7 = -1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 6/12 — `(5,7)`, `t = -2`. -/
theorem drk10_pin_five_seven :
    ∃ t : ℤ, 12 * (7 : ℚ) * dedekindSum 5 7
      = (7 : ℚ) + 1 - 2 * ((jacobiSym 5 7 : ℤ) : ℚ) + 8 * t := by
  refine ⟨-2, ?_⟩
  have hs : dedekindSum 5 7 = -1 / 14 := by decide +kernel
  have hj : jacobiSym 5 7 = -1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 7/12 — `(7,11)`, `t = -4`. -/
theorem drk10_pin_seven_eleven :
    ∃ t : ℤ, 12 * (11 : ℚ) * dedekindSum 7 11
      = (11 : ℚ) + 1 - 2 * ((jacobiSym 7 11 : ℤ) : ℚ) + 8 * t := by
  refine ⟨-4, ?_⟩
  have hs : dedekindSum 7 11 = -3 / 22 := by decide +kernel
  have hj : jacobiSym 7 11 = -1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 8/12 — `(9,25)`, `k` a prime **power**, `t = 3`. -/
theorem drk10_pin_nine_twentyfive :
    ∃ t : ℤ, 12 * (25 : ℚ) * dedekindSum 9 25
      = (25 : ℚ) + 1 - 2 * ((jacobiSym 9 25 : ℤ) : ℚ) + 8 * t := by
  refine ⟨3, ?_⟩
  have hs : dedekindSum 9 25 = 4 / 25 := by decide +kernel
  have hj : jacobiSym 9 25 = 1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 9/12 — `(11,13)`, `t = -8`. -/
theorem drk10_pin_eleven_thirteen :
    ∃ t : ℤ, 12 * (13 : ℚ) * dedekindSum 11 13
      = (13 : ℚ) + 1 - 2 * ((jacobiSym 11 13 : ℤ) : ℚ) + 8 * t := by
  refine ⟨-8, ?_⟩
  have hs : dedekindSum 11 13 = -4 / 13 := by decide +kernel
  have hj : jacobiSym 11 13 = -1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 10/12 — `(2,15)`, `k` **composite** and the numerator even, `t = 7`. -/
theorem drk10_pin_two_fifteen :
    ∃ t : ℤ, 12 * (15 : ℚ) * dedekindSum 2 15
      = (15 : ℚ) + 1 - 2 * ((jacobiSym 2 15 : ℤ) : ℚ) + 8 * t := by
  refine ⟨7, ?_⟩
  have hs : dedekindSum 2 15 = 7 / 18 := by decide +kernel
  have hj : jacobiSym 2 15 = 1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 11/12 — `(4,9)`, `t = -3`. -/
theorem drk10_pin_four_nine :
    ∃ t : ℤ, 12 * (9 : ℚ) * dedekindSum 4 9
      = (9 : ℚ) + 1 - 2 * ((jacobiSym 4 9 : ℤ) : ℚ) + 8 * t := by
  refine ⟨-3, ?_⟩
  have hs : dedekindSum 4 9 = -4 / 27 := by decide +kernel
  have hj : jacobiSym 4 9 = 1 := by norm_num
  rw [hs, hj]; norm_num

/-- PIN 12/12 — `(13,5)`, numerator **larger than the modulus**, `t = -1`. -/
theorem drk10_pin_thirteen_five :
    ∃ t : ℤ, 12 * (5 : ℚ) * dedekindSum 13 5
      = (5 : ℚ) + 1 - 2 * ((jacobiSym 13 5 : ℤ) : ℚ) + 8 * t := by
  refine ⟨-1, ?_⟩
  have hs : dedekindSum 13 5 = 0 := by decide +kernel
  have hj : jacobiSym 13 5 = -1 := by norm_num
  rw [hs, hj]; norm_num

/-! ### Negative controls — both hypotheses are load-bearing -/

/-- NEGATIVE CONTROL 1/4 — `k = 2` is even and the conclusion **fails**
(`12·2·s(1,2) = 0` but the right-hand side is `1 + 8t`). -/
theorem drk10_fails_k_even_one_two :
    ¬ ∃ t : ℤ, 12 * (2 : ℚ) * dedekindSum 1 2
      = (2 : ℚ) + 1 - 2 * ((jacobiSym 1 2 : ℤ) : ℚ) + 8 * t := by
  rintro ⟨t, ht⟩
  have hs : dedekindSum 1 2 = 0 := by decide +kernel
  have hj : jacobiSym 1 2 = 1 := by norm_num
  rw [hs, hj] at ht
  have h8 : ((8 * t : ℤ) : ℚ) = -1 := by push_cast at ht ⊢; linarith
  have : (8 * t : ℤ) = -1 := by exact_mod_cast h8
  omega

/-- NEGATIVE CONTROL 2/4 — `k = 6`, even and **composite**, with a nontrivial numerator and
`(5|6) = -1`: `12·6·s(5,6) = -20` while the right-hand side is `9 + 8t`. -/
theorem drk10_fails_k_even_five_six :
    ¬ ∃ t : ℤ, 12 * (6 : ℚ) * dedekindSum 5 6
      = (6 : ℚ) + 1 - 2 * ((jacobiSym 5 6 : ℤ) : ℚ) + 8 * t := by
  rintro ⟨t, ht⟩
  have hs : dedekindSum 5 6 = -5 / 18 := by decide +kernel
  have hj : jacobiSym 5 6 = -1 := by norm_num
  rw [hs, hj] at ht
  have h8 : ((8 * t : ℤ) : ℚ) = -29 := by push_cast at ht ⊢; linarith
  have : (8 * t : ℤ) = -29 := by exact_mod_cast h8
  omega

/-- NEGATIVE CONTROL 3/4 — `gcd(3,9) = 3`: `k` is odd but coprimality fails. -/
theorem drk10_fails_gcd_three_nine :
    ¬ ∃ t : ℤ, 12 * (9 : ℚ) * dedekindSum 3 9
      = (9 : ℚ) + 1 - 2 * ((jacobiSym 3 9 : ℤ) : ℚ) + 8 * t := by
  rintro ⟨t, ht⟩
  have hs : dedekindSum 3 9 = 1 / 18 := by decide +kernel
  have hj : jacobiSym 3 9 = 0 := by norm_num
  rw [hs, hj] at ht
  have h8 : ((8 * t : ℤ) : ℚ) = -4 := by push_cast at ht ⊢; linarith
  have : (8 * t : ℤ) = -4 := by exact_mod_cast h8
  omega

/-- NEGATIVE CONTROL 4/4 — `gcd(5,15) = 5`. -/
theorem drk10_fails_gcd_five_fifteen :
    ¬ ∃ t : ℤ, 12 * (15 : ℚ) * dedekindSum 5 15
      = (15 : ℚ) + 1 - 2 * ((jacobiSym 5 15 : ℤ) : ℚ) + 8 * t := by
  rintro ⟨t, ht⟩
  have hs : dedekindSum 5 15 = 1 / 18 := by decide +kernel
  have hj : jacobiSym 5 15 = 0 := by norm_num
  rw [hs, hj] at ht
  have h8 : ((8 * t : ℤ) : ℚ) = -6 := by push_cast at ht ⊢; linarith
  have : (8 * t : ℤ) = -6 := by exact_mod_cast h8
  omega

end Drk10Gate


/-! ## Step 1 — integrality: `12 k s(h,k)` is an integer

Independent derivation from the definition.  The engine is
`12 k s(h,k) = 12(∑ r·m_r)/k − 6 ∑ r·ε_r − 6 ∑ m_r + 3k ∑ ε_r`
with `m_r = hr mod k` and `ε_r = min m_r 1 ∈ {0,1}`, together with `k ∣ 6 ∑ r·m_r`.
No coprimality is used anywhere in this section: `ε_r` is exactly what absorbs the `k ∣ hr`
branch of `dedekindSaw`. -/

section Integrality

/-- `hr mod k`, wrapped so that `push_cast` cannot rewrite it into an integer `%` and break the
symmetry between the `ℤ` and `ℚ` forms of the same sum.  Bookkeeping only. -/
private def modAux (h k r : ℕ) : ℕ := h * r % k

/-- `ε_r = min (hr mod k) 1`: `0` exactly when `k ∣ hr`.  Wrapped for the same reason. -/
private def epsAux (h k r : ℕ) : ℕ := min (h * r % k) 1

private lemma modAux_lt {h k : ℕ} (r : ℕ) (hk : 0 < k) : modAux h k r < k := Nat.mod_lt _ hk

/-- The sawtooth at `hr/k` in a form that covers **both** branches of `dedekindSaw` at once:
`((hr/k)) = m_r/k − ε_r/2`.  The `ε_r` is what makes this work without coprimality: when
`k ∣ hr` the sawtooth is `0`, not `−1/2`. -/
private lemma saw_mul_div (h k r : ℕ) (hr1 : 1 ≤ r) (hr2 : r < k) :
    dedekindSaw (((h : ℤ) : ℚ) * r / k)
      = ((modAux h k r : ℕ) : ℚ) / (k : ℚ) - ((epsAux h k r : ℕ) : ℚ) / 2 := by
  have hk : 0 < k := by omega
  have hk0 : (k : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hk.ne'
  rw [show ((h : ℤ) : ℚ) = (h : ℚ) by push_cast; ring]
  unfold modAux epsAux
  have hdm : (k : ℚ) * ((h * r / k : ℕ) : ℚ) + ((h * r % k : ℕ) : ℚ) = (h : ℚ) * (r : ℚ) := by
    have h0 : k * (h * r / k) + h * r % k = h * r := Nat.div_add_mod (h * r) k
    exact_mod_cast congrArg (fun n : ℕ => (n : ℚ)) h0
  have hsplit : (h : ℚ) * (r : ℚ) / (k : ℚ)
      = ((h * r % k : ℕ) : ℚ) / (k : ℚ) + ((h * r / k : ℕ) : ℚ) := by
    rw [← hdm]; field_simp; ring
  by_cases h0 : h * r % k = 0
  · rw [h0] at hsplit ⊢
    rw [hsplit]
    simp [dedekindSaw_natCast]
  · have hmin : min (h * r % k) 1 = 1 := Nat.min_eq_right (by omega)
    rw [hsplit, dedekindSaw_add_natCast,
      dedekindSaw_natCast_div (Nat.pos_of_ne_zero h0) (Nat.mod_lt _ hk), hmin]
    norm_num

/-- `6 ∑_{r=1}^{k-1} r² = (k−1)k(2k−1)` over `ℤ`. -/
private lemma six_sum_sq (k : ℕ) :
    6 * (∑ r ∈ Finset.Ico 1 k, (r : ℤ) ^ 2)
      = ((k : ℤ) - 1) * (k : ℤ) * (2 * (k : ℤ) - 1) := by
  induction k with
  | zero => simp
  | succ m ih =>
      rcases Nat.eq_zero_or_pos m with rfl | hm
      · simp
      · rw [Finset.sum_Ico_succ_top hm]
        push_cast
        linear_combination ih

/-- `∑ r·m_r = h ∑ r² − k ∑ r⌊hr/k⌋`. -/
private lemma modSum_split (h k : ℕ) :
    (∑ r ∈ Finset.Ico 1 k, (r : ℤ) * ((modAux h k r : ℕ) : ℤ))
      = (h : ℤ) * (∑ r ∈ Finset.Ico 1 k, (r : ℤ) ^ 2)
        - (k : ℤ) * (∑ r ∈ Finset.Ico 1 k, (r : ℤ) * ((h * r / k : ℕ) : ℤ)) := by
  rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun r _ => ?_
  unfold modAux
  have hdm : (k : ℤ) * ((h * r / k : ℕ) : ℤ) + ((h * r % k : ℕ) : ℤ) = (h : ℤ) * (r : ℤ) := by
    exact_mod_cast congrArg (fun n : ℕ => (n : ℤ)) (Nat.div_add_mod (h * r) k)
  linear_combination (r : ℤ) * hdm

/-- `k ∣ 6 ∑_{r=1}^{k-1} r·m_r`.  This is the whole content of integrality: `m_r ≡ hr (mod k)`,
so `6 ∑ r m_r ≡ h·(6 ∑ r²) = h(k−1)k(2k−1) ≡ 0`. -/
private lemma dvd_six_modSum (h k : ℕ) :
    (k : ℤ) ∣ 6 * ∑ r ∈ Finset.Ico 1 k, (r : ℤ) * ((modAux h k r : ℕ) : ℤ) := by
  refine ⟨(h : ℤ) * (((k : ℤ) - 1) * (2 * (k : ℤ) - 1))
      - 6 * ∑ r ∈ Finset.Ico 1 k, (r : ℤ) * ((h * r / k : ℕ) : ℤ), ?_⟩
  rw [modSum_split]
  linear_combination (h : ℤ) * six_sum_sq k

/-- **`12 k s(h,k)` is an integer**, for every `h` and every `k`.

LOUDLY (LL-1): this is the `12k` form, and it is **strictly weaker** than upstream FLT's
`Theorems/Thm_exists_intCast_eq_six_mul_dedekindSum.lean` (fetched 2026-09-08, HTTP 200,
330 bytes), which asserts `∃ z : ℤ, (z : ℚ) = 6 * k * dedekindSum h k` for `0 < k`.  We do not
prove the `6k` form and do not claim it.  `12k` is exactly what `DRK-10` consumes.
PROVENANCE: **INDEPENDENT** — upstream's proof is a `p2m_exact_reverting` call into a solution
file that does not exist here and was not read; the derivation is from our own
`dedekindSum_eq_sum_Ico` and `dedekindSaw_natCast_div`. -/
theorem exists_intCast_eq_twelve_mul_dedekindSum (h k : ℕ) :
    ∃ z : ℤ, (z : ℚ) = 12 * (k : ℚ) * dedekindSum (h : ℤ) k := by
  rcases Nat.eq_zero_or_pos k with rfl | hk
  · exact ⟨0, by rw [dedekindSum_zero_right]; norm_num⟩
  have hk0 : (k : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hk.ne'
  obtain ⟨c, hc⟩ := dvd_six_modSum h k
  have key : 12 * (k : ℚ) * dedekindSum (h : ℤ) k
      = 12 * (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((modAux h k r : ℕ) : ℚ)) / (k : ℚ)
        - 6 * (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((epsAux h k r : ℕ) : ℚ))
        - 6 * (∑ r ∈ Finset.Ico 1 k, ((modAux h k r : ℕ) : ℚ))
        + 3 * (k : ℚ) * (∑ r ∈ Finset.Ico 1 k, ((epsAux h k r : ℕ) : ℚ)) := by
    rw [dedekindSum_eq_sum_Ico]
    rw [Finset.sum_congr rfl (fun r hr => by
      rw [saw_mul_div h k r (Finset.mem_Ico.1 hr).1 (Finset.mem_Ico.1 hr).2])]
    simp only [Finset.mul_sum, Finset.sum_div, ← Finset.sum_sub_distrib,
      ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun r _ => ?_
    field_simp
    ring
  refine ⟨2 * c
      - 6 * (∑ r ∈ Finset.Ico 1 k, (r : ℤ) * ((epsAux h k r : ℕ) : ℤ))
      - 6 * (∑ r ∈ Finset.Ico 1 k, ((modAux h k r : ℕ) : ℤ))
      + 3 * (k : ℤ) * (∑ r ∈ Finset.Ico 1 k, ((epsAux h k r : ℕ) : ℤ)), ?_⟩
  have hcQ : 6 * (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((modAux h k r : ℕ) : ℚ))
      = (k : ℚ) * (c : ℚ) := by
    have hh := congrArg (fun z : ℤ => (z : ℚ)) hc
    push_cast at hh
    linarith [hh]
  have h12 : 12 * (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((modAux h k r : ℕ) : ℚ)) / (k : ℚ)
      = 2 * (c : ℚ) := by
    field_simp
    linarith [hcQ]
  rw [key, h12]
  push_cast
  ring

end Integrality

/-! ## Step 2 — the two mod-8 case checks, as pure integer arithmetic

Neither lemma mentions a Dedekind sum or a Jacobi symbol.  Both were verified in `sympy`
(all four residuals `0`) before being written. -/

section Mod8Arithmetic

/-- One Euclidean descent step.  `ε` is `(k|h)`, `σ` is the reciprocity sign
`(-1)^(⌊h/2⌋⌊k/2⌋)`, `t'` is the inductive witness at the smaller modulus.

The four witnesses come from `u(u+1) = 2p`, `v(v+1) = 2q` and the parity of `uv` — which is
exactly the parity that `σ` records.  That coincidence *is* quadratic reciprocity doing its
job here, and it is why `hσ` cannot be dropped. -/
private lemma descent_mod_eight (H K A ε σ t' u v : ℤ)
    (hH : H = 2 * u + 1) (hK : K = 2 * v + 1)
    (hkey : H * A + K * (H + 1 - 2 * ε + 8 * t')
              = H ^ 2 + K ^ 2 + 1 - 3 * H * K)
    (hε : ε = 1 ∨ ε = -1)
    (hσ : (Even (u * v) ∧ σ = 1) ∨ (Odd (u * v) ∧ σ = -1)) :
    (8 : ℤ) ∣ A - (K + 1 - 2 * (σ * ε)) := by
  subst hH
  subst hK
  obtain ⟨p, hp⟩ := Int.even_mul_succ_self u
  obtain ⟨q, hq⟩ := Int.even_mul_succ_self v
  have hstep : (8 : ℤ) ∣ (2 * u + 1) * (A - ((2 * v + 1) + 1 - 2 * (σ * ε))) := by
    rcases hε with rfl | rfl <;> rcases hσ with ⟨⟨w, hw⟩, rfl⟩ | ⟨⟨w, hw⟩, rfl⟩
    · exact ⟨p + q - u - v - 5 * w - (2 * v + 1) * t', by
        linear_combination hkey + 4 * hp + 4 * hq - 20 * hw⟩
    · exact ⟨p + q - 2 * u - v - 5 * w - 3 - (2 * v + 1) * t', by
        linear_combination hkey + 4 * hp + 4 * hq - 20 * hw⟩
    · exact ⟨p + q - 2 * u - 2 * v - 5 * w - 1 - (2 * v + 1) * t', by
        linear_combination hkey + 4 * hp + 4 * hq - 20 * hw⟩
    · exact ⟨p + q - u - 2 * v - 5 * w - 3 - (2 * v + 1) * t', by
        linear_combination hkey + 4 * hp + 4 * hq - 20 * hw⟩
  have h8 : (8 : ℤ) ∣ (2 * u + 1) ^ 2 - 1 := ⟨p, by linear_combination 4 * hp⟩
  have hsplit : A - ((2 * v + 1) + 1 - 2 * (σ * ε))
      = (2 * u + 1) * ((2 * u + 1) * (A - ((2 * v + 1) + 1 - 2 * (σ * ε))))
        - ((2 * u + 1) ^ 2 - 1) * (A - ((2 * v + 1) + 1 - 2 * (σ * ε))) := by ring
  rw [hsplit]
  exact dvd_sub (hstep.mul_left _) (h8.mul_right _)

/-- The reflection `h ↦ k − h`, which turns an even numerator into an odd one at the **same**
modulus.  `χ` is `(-1|k) = χ₄(k)`; `J` is `(h|k)`. -/
private lemma reflect_mod_eight (K A J χ m : ℤ)
    (hd : (8 : ℤ) ∣ -A - (K + 1 - 2 * (χ * J)))
    (hJ : J = 1 ∨ J = -1)
    (hK : (K = 4 * m + 1 ∧ χ = 1) ∨ (K = 4 * m + 3 ∧ χ = -1)) :
    (8 : ℤ) ∣ A - (K + 1 - 2 * J) := by
  have hsplit : A - (K + 1 - 2 * J)
      = -(-A - (K + 1 - 2 * (χ * J))) - ((K + 1 - 2 * (χ * J)) + (K + 1 - 2 * J)) := by ring
  rw [hsplit]
  refine dvd_sub (dvd_neg.mpr hd) ?_
  rcases hJ with rfl | rfl <;> rcases hK with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · exact ⟨m, by ring⟩
  · exact ⟨m + 1, by ring⟩
  · exact ⟨m + 1, by ring⟩
  · exact ⟨m + 1, by ring⟩

end Mod8Arithmetic

/-! ## Step 3 — the descent -/

/-- The engine of `DRK-10`: strong induction on the **odd modulus** `k`.

Structure, in the order the branches are taken:
* `k = 1`: both sides are `0`.
* `k ≥ 2`, numerator reduced mod `k`, then
  * numerator odd: one reciprocity step (`DRK-02`) plus quadratic reciprocity, descending to
    the strictly smaller **odd** modulus `h'`;
  * numerator even: reflect `h' ↦ k − h'` (odd, same modulus) and use the odd branch.

The reflection is *not* a second induction: it consumes `odd_case`, which is already available
at this `k`.  This is what makes the even-numerator case terminate. -/
private theorem mod_eight_aux (k : ℕ) :
    ∀ h : ℕ, Odd k → Nat.Coprime h k → ∀ A : ℤ,
      (A : ℚ) = 12 * (k : ℚ) * dedekindSum (h : ℤ) k →
      (8 : ℤ) ∣ A - ((k : ℤ) + 1 - 2 * jacobiSym (h : ℤ) k) := by
  induction k using Nat.strong_induction_on with
  | _ k IH =>
    intro h hkodd hhk A hA
    obtain ⟨v, hv⟩ := hkodd
    have hkpos : 0 < k := by omega
    have hkZ : (k : ℤ) = 2 * (v : ℤ) + 1 := by exact_mod_cast congrArg (fun n : ℕ => (n : ℤ)) hv
    rcases Nat.lt_or_ge k 2 with hk1 | hk2
    · -- base case `k = 1`
      have hk1' : k = 1 := by omega
      have hA0 : A = 0 := by
        have : (A : ℚ) = 0 := by rw [hA, hk1', dedekindSum_one_right]; ring
        exact_mod_cast this
      have hj : jacobiSym (h : ℤ) k = 1 := by rw [hk1']; exact jacobiSym.one_right _
      rw [hA0, hj, hk1']
      norm_num
    · -- odd numerator, strictly below the modulus
      have odd_case : ∀ h' : ℕ, Odd h' → h' < k → Nat.Coprime h' k → ∀ A' : ℤ,
          (A' : ℚ) = 12 * (k : ℚ) * dedekindSum (h' : ℤ) k →
          (8 : ℤ) ∣ A' - ((k : ℤ) + 1 - 2 * jacobiSym (h' : ℤ) k) := by
        intro h' hh'odd hh'lt hh'cop A' hA'
        obtain ⟨u, hu⟩ := hh'odd
        have hh'pos : 0 < h' := by omega
        have hh'Z : (h' : ℤ) = 2 * (u : ℤ) + 1 := by
          exact_mod_cast congrArg (fun n : ℕ => (n : ℤ)) hu
        have hh'Q : (h' : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hh'pos.ne'
        have hkQ : (k : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hkpos.ne'
        obtain ⟨B, hB⟩ := exists_intCast_eq_twelve_mul_dedekindSum k h'
        obtain ⟨t', ht'⟩ := IH h' hh'lt k ⟨u, hu⟩ hh'cop.symm B hB
        have hrec := dedekindSum_add_dedekindSum h' k hh'pos hkpos hh'cop
        have hrec' : 12 * (h' : ℚ) * (k : ℚ)
              * (dedekindSum (h' : ℤ) k + dedekindSum (k : ℤ) h')
            = (h' : ℚ) ^ 2 + (k : ℚ) ^ 2 + 1 - 3 * (h' : ℚ) * (k : ℚ) := by
          rw [hrec]; field_simp; ring
        have hkeyQ : (h' : ℚ) * (A' : ℚ) + (k : ℚ) * (B : ℚ)
            = (h' : ℚ) ^ 2 + (k : ℚ) ^ 2 + 1 - 3 * (h' : ℚ) * (k : ℚ) := by
          rw [hA', hB]; linear_combination hrec'
        have hkeyZ : (h' : ℤ) * A' + (k : ℤ) * B
            = (h' : ℤ) ^ 2 + (k : ℤ) ^ 2 + 1 - 3 * (h' : ℤ) * (k : ℤ) := by
          exact_mod_cast hkeyQ
        have hB' : B = (h' : ℤ) + 1 - 2 * jacobiSym (k : ℤ) h' + 8 * t' := by linarith
        rw [hB'] at hkeyZ
        have hJpm : jacobiSym (k : ℤ) h' = 1 ∨ jacobiSym (k : ℤ) h' = -1 :=
          jacobiSym.eq_one_or_neg_one (by simpa using hh'cop.symm)
        have hqr : jacobiSym (h' : ℤ) k
            = (-1) ^ (h' / 2 * (k / 2)) * jacobiSym (k : ℤ) h' :=
          jacobiSym.quadratic_reciprocity ⟨u, hu⟩ ⟨v, hv⟩
        have hu2 : h' / 2 = u := by omega
        have hv2 : k / 2 = v := by omega
        have hσ : (Even ((u : ℤ) * (v : ℤ)) ∧ ((-1 : ℤ)) ^ (u * v) = 1)
            ∨ (Odd ((u : ℤ) * (v : ℤ)) ∧ ((-1 : ℤ)) ^ (u * v) = -1) := by
          rcases Nat.even_or_odd (u * v) with hev | hod
          · refine Or.inl ⟨?_, hev.neg_one_pow⟩
            obtain ⟨w, hw⟩ := hev
            exact ⟨(w : ℤ), by exact_mod_cast congrArg (fun n : ℕ => (n : ℤ)) hw⟩
          · refine Or.inr ⟨?_, hod.neg_one_pow⟩
            obtain ⟨w, hw⟩ := hod
            exact ⟨(w : ℤ), by exact_mod_cast congrArg (fun n : ℕ => (n : ℤ)) hw⟩
        rw [hqr, hu2, hv2]
        exact descent_mod_eight (h' : ℤ) (k : ℤ) A' (jacobiSym (k : ℤ) h')
          ((-1 : ℤ) ^ (u * v)) t' (u : ℤ) (v : ℤ) hh'Z hkZ hkeyZ hJpm hσ
      -- any numerator strictly below the modulus
      have lt_case : ∀ h' : ℕ, h' < k → Nat.Coprime h' k → ∀ A' : ℤ,
          (A' : ℚ) = 12 * (k : ℚ) * dedekindSum (h' : ℤ) k →
          (8 : ℤ) ∣ A' - ((k : ℤ) + 1 - 2 * jacobiSym (h' : ℤ) k) := by
        intro h' hh'lt hh'cop A' hA'
        rcases Nat.even_or_odd h' with hev | hod
        · have hh'pos : 0 < h' := by
            rcases Nat.eq_zero_or_pos h' with rfl | hp
            · rw [Nat.coprime_zero_left] at hh'cop; omega
            · exact hp
          have hle : h' ≤ k := le_of_lt hh'lt
          have hcop2 : Nat.Coprime (k - h') k := by
            have hd1 : Nat.gcd (k - h') k ∣ h' := by
              have h1 : Nat.gcd (k - h') k ∣ k := Nat.gcd_dvd_right _ _
              have h2 : Nat.gcd (k - h') k ∣ (k - h') := Nat.gcd_dvd_left _ _
              have h4 : Nat.gcd (k - h') k ∣ k - (k - h') := Nat.dvd_sub h1 h2
              rwa [show k - (k - h') = h' from by omega] at h4
            have hd2 : Nat.gcd (k - h') k ∣ Nat.gcd h' k :=
              Nat.dvd_gcd hd1 (Nat.gcd_dvd_right (k - h') k)
            rw [show Nat.gcd h' k = 1 from hh'cop] at hd2
            show Nat.gcd (k - h') k = 1
            exact Nat.dvd_one.mp hd2
          have hodd2 : Odd (k - h') := Nat.Odd.sub_even hle ⟨v, hv⟩ hev
          have hlt2 : k - h' < k := by omega
          have hcastZ : ((k - h' : ℕ) : ℤ) = -(h' : ℤ) + (k : ℤ) * 1 := by
            push_cast [Nat.cast_sub hle]; ring
          have hA2 : ((-A' : ℤ) : ℚ) = 12 * (k : ℚ) * dedekindSum ((k - h' : ℕ) : ℤ) k := by
            rw [show ((k - h' : ℕ) : ℤ) = -(h' : ℤ) + 1 * (k : ℤ) by rw [hcastZ]; ring,
              dedekindSum_add_mul, dedekindSum_neg]
            push_cast [hA']
            ring
          have hd := odd_case (k - h') hodd2 hlt2 hcop2 (-A') hA2
          have hj2 : jacobiSym ((k - h' : ℕ) : ℤ) k
              = jacobiSym (-1) k * jacobiSym (h' : ℤ) k := by
            have hm : jacobiSym ((k - h' : ℕ) : ℤ) k = jacobiSym (-(h' : ℤ)) k := by
              refine jacobiSym.mod_left' ?_
              rw [hcastZ]
              exact Int.add_mul_emod_self_left _ _ _
            rw [hm, show (-(h' : ℤ)) = (-1) * (h' : ℤ) by ring, jacobiSym.mul_left]
          rw [hj2] at hd
          have hJpm : jacobiSym (h' : ℤ) k = 1 ∨ jacobiSym (h' : ℤ) k = -1 :=
            jacobiSym.eq_one_or_neg_one (by simpa using hh'cop)
          have hchi : jacobiSym (-1) k = ZMod.χ₄ (k : ZMod 4) := jacobiSym.at_neg_one ⟨v, hv⟩
          rcases Nat.odd_mod_four_iff.mp (Nat.odd_iff.mp ⟨v, hv⟩) with h4 | h4
          · exact reflect_mod_eight (k : ℤ) A' (jacobiSym (h' : ℤ) k) (jacobiSym (-1) k)
              ((k / 4 : ℕ) : ℤ) hd hJpm
              (Or.inl ⟨by omega, by rw [hchi, ZMod.χ₄_nat_one_mod_four h4]⟩)
          · exact reflect_mod_eight (k : ℤ) A' (jacobiSym (h' : ℤ) k) (jacobiSym (-1) k)
              ((k / 4 : ℕ) : ℤ) hd hJpm
              (Or.inr ⟨by omega, by rw [hchi, ZMod.χ₄_nat_three_mod_four h4]⟩)
        · exact odd_case h' hod hh'lt hh'cop A' hA'
      -- reduce the numerator mod `k`
      have hmodcop : Nat.Coprime (h % k) k := by
        show Nat.gcd (h % k) k = 1
        rw [← Nat.gcd_rec]
        exact hhk.symm
      have hnat : h % k + k * (h / k) = h := Nat.mod_add_div h k
      have hds : dedekindSum (h : ℤ) k = dedekindSum ((h % k : ℕ) : ℤ) k := by
        have hcast : (h : ℤ) = ((h % k : ℕ) : ℤ) + ((h / k : ℕ) : ℤ) * (k : ℤ) := by
          conv_lhs => rw [← hnat]
          push_cast
          ring
        rw [hcast, dedekindSum_add_mul]
      have hjmod : jacobiSym (h : ℤ) k = jacobiSym ((h % k : ℕ) : ℤ) k := by
        refine jacobiSym.mod_left' ?_
        have hc : ((h % k : ℕ) : ℤ) = (h : ℤ) % (k : ℤ) := by push_cast; ring
        rw [hc]
        exact (Int.emod_emod_of_dvd _ dvd_rfl).symm
      rw [hjmod]
      exact lt_case (h % k) (Nat.mod_lt _ hkpos) hmodcop A (by rw [hA, hds])

/-! ## DRK-10, half 1 -/

/-- **DRK-10, half 1 (PROVED).**  For odd `k` coprime to `h`,
`12 k s(h,k) = k + 1 − 2 (h|k) + 8t` for some integer `t`.

STATEMENT: a **verbatim port** (whitespace aside) of `anthropics/fermats-last-theorem`,
`Theorems/Thm_dedekindSum_jacobiSym_mod_eight.lean` (Apache-2.0, fetched 2026-09-08, HTTP 200,
449 bytes).  PROOF: **ours** — upstream's is `p2m_exact_reverting` into a `P2M/Sol` solution file
that does not exist in this library, so no proof text was taken.  The route here is Euclidean
descent on the odd modulus through our own `DRK-02` (`dedekindSum_add_dedekindSum`), Mathlib's
`jacobiSym.quadratic_reciprocity`, and the integrality lemma above.

SCOPE, LOUDLY (LL-1): `hk : Odd k` and `hhk : Nat.Coprime h k` are both load-bearing — see the
four kernel negative controls in the gate.  `h` is a **natural number**; a consumer wanting
`s(d,c)` for `d < 0` must first move through `dedekindSum_add_mul` / `dedekindSum_neg`.  Nothing
here covers even `k`, so this says nothing about the even-`c` branch of the eta multiplier. -/
theorem dedekindSum_jacobiSym_mod_eight (h k : ℕ) (hk : Odd k) (hhk : Nat.Coprime h k) :
    ∃ t : ℤ, 12 * (k : ℚ) * dedekindSum h k
      = (k : ℚ) + 1 - 2 * ((jacobiSym h k : ℤ) : ℚ) + 8 * t := by
  obtain ⟨A, hA⟩ := exists_intCast_eq_twelve_mul_dedekindSum h k
  obtain ⟨t, ht⟩ := mod_eight_aux k h hk hhk A hA
  refine ⟨t, ?_⟩
  rw [← hA, show A = (k : ℤ) + 1 - 2 * jacobiSym (h : ℤ) k + 8 * t by linarith]
  push_cast
  ring


/-- **Consistency tripwire (LL-2).**  Runs the *general* theorem at `(7,11)` and proves that the
witness it produces is exactly the `-4` that `drk10_pin_seven_eleven` asserts from the kernel
evaluation of the definition.  If the general proof ever drifts to a different normalisation of
`t`, this breaks. -/
theorem drk10_general_matches_pin_seven_eleven :
    ∃ t : ℤ, t = -4 ∧ 12 * (11 : ℚ) * dedekindSum 7 11
      = (11 : ℚ) + 1 - 2 * ((jacobiSym 7 11 : ℤ) : ℚ) + 8 * t := by
  obtain ⟨t, ht⟩ := dedekindSum_jacobiSym_mod_eight 7 11 (by decide) (by decide)
  refine ⟨t, ?_, ht⟩
  have hs : dedekindSum 7 11 = -3 / 22 := by decide +kernel
  have hj : jacobiSym 7 11 = -1 := by norm_num
  push_cast at ht
  rw [hs, hj] at ht
  have h8 : ((8 * t : ℤ) : ℚ) = -32 := by push_cast at ht ⊢; linarith
  have : (8 * t : ℤ) = -32 := by exact_mod_cast h8
  omega

end SocrateAI.NumberTheory
