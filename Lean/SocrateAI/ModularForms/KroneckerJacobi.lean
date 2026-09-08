/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.ModularForms.EtaQuotientModularity
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol
import Mathlib.Tactic.NormNum.LegendreSymbol
import Mathlib.Tactic.NormNum.Prime

/-!
# DRK-10, half 2 — `kroneckerSym` versus `jacobiSym`

Run 3 built its own Kronecker symbol (`SocrateAI.ModularForms.kroneckerSym`, F3.2-B3) because
Mathlib's `jacobiSym` is *wrong at 2* for this purpose: `jacobiSym` sends the prime `2` to
`legendreSym 2`, i.e. to the trivial character of `ZMod 2`, whereas the Kronecker symbol sends it
to `χ₈`.  The two therefore disagree, and `kronecker_ne_jacobi_at_two_neg_three` below is a
kernel witness of that disagreement, not a remark.

Away from `2` they agree, and this file proves it.  That is the bridge the eta-quotient
character work needs in order to import Mathlib's Jacobi-symbol API — in particular
`jacobiSym.quadratic_reciprocity`, and through it `DRK-10` half 1 — into run 3's
`kroneckerSym`-shaped statements.

## Provenance

**INDEPENDENT, every declaration.**  FLT works with Mathlib's `jacobiSym` throughout and defines
no Kronecker symbol, so there is no upstream counterpart to port and none is claimed.  Nothing in
this file is recorded in `ATTRIBUTION.md` as a port; the file appears there only as an
"INDEPENDENT" row so that a reader can see it was considered.

## Scope, stated loudly (LL-1)

* `Odd b` is load-bearing and **the theorem is false without it** — see the two negative
  controls.  Nothing here says anything about even moduli.
* The statement is for `b : ℕ` cast into `ℤ`.  It says nothing about `kroneckerSym a d` for
  `d < 0`; that branch carries the `(if a < 0 ∧ d < 0 then -1 else 1)` sign factor, which the
  positivity of `(b : ℤ)` kills here.  Extending to `d < 0` is genuinely open work.
* `(hpos : 0 < b)` in the `DRK-10` node statement is **redundant** — `Odd b` already forces
  `b ≠ 0` in `ℕ`.  We land the node's binder list verbatim in
  `kroneckerSym_eq_jacobiSym_of_odd` and also give the hypothesis-minimal
  `kroneckerSym_eq_jacobiSym_of_odd'`, which is the one downstream code should use.
-/

set_option autoImplicit false

namespace SocrateAI.ModularForms

open NumberTheorySymbols

/-! ## Gate — the disagreement at `2`, and four instances of the agreement away from it

Every value below is computed on both sides *independently* (`decide`/`norm_num` against the
definitions, never via the theorem being gated), and was checked in Python first:
`χ₈(-3 mod 8) = χ₈(5) = -1` and `χ₈(5 mod 8) = -1`, against `legendreSym 2 (-3) = 1` and
`legendreSym 2 5 = 1`; `(5|3) = -1`, `(2|5) = -1`, `(-1|7) = -1`. -/

section KroneckerJacobiGate

/-- Two prime-factor lists, needed by every pin below.  `Nat.primeFactorsList` is defined by
well-founded recursion, so these are not `rfl`. -/
private lemma pfl_two : Nat.primeFactorsList 2 = [2] :=
  Nat.primeFactorsList_prime (by norm_num)

private lemma pfl_three : Nat.primeFactorsList 3 = [3] :=
  Nat.primeFactorsList_prime (by norm_num)

private lemma pfl_five : Nat.primeFactorsList 5 = [5] :=
  Nat.primeFactorsList_prime (by norm_num)

private lemma pfl_seven : Nat.primeFactorsList 7 = [7] :=
  Nat.primeFactorsList_prime (by norm_num)

/-- NEGATIVE CONTROL 1/2, and the whole reason run 3 built `kroneckerSym`:
`(-3 / 2) = -1` in the Kronecker symbol but `J(-3 | 2) = 1`. -/
theorem kronecker_ne_jacobi_at_two_neg_three :
    kroneckerSym (-3) (2 : ℤ) ≠ jacobiSym (-3) 2 := by
  have h1 : kroneckerSym (-3) (2 : ℤ) = -1 := by
    rw [kroneckerSym, if_neg (by norm_num : (2 : ℤ) ≠ 0),
      if_neg (by norm_num : ¬((-3 : ℤ) < 0 ∧ (2 : ℤ) < 0)), one_mul,
      show ((2 : ℤ)).natAbs = 2 from rfl, pfl_two]
    simp only [List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one]
    rw [kroneckerPrime, if_pos rfl]
    decide
  have h2 : jacobiSym (-3) 2 = 1 := by
    rw [jacobiSym.mod_left' (a₂ := 1) (by decide)]
    exact jacobiSym.one_left 2
  rw [h1, h2]
  norm_num

/-- NEGATIVE CONTROL 2/2 — the same disagreement with a *positive* numerator, so it is not an
artefact of the sign branch: `(5/2) = -1` but `J(5|2) = 1`. -/
theorem kronecker_ne_jacobi_at_two_five :
    kroneckerSym 5 (2 : ℤ) ≠ jacobiSym 5 2 := by
  have h1 : kroneckerSym 5 (2 : ℤ) = -1 := by
    rw [kroneckerSym, if_neg (by norm_num : (2 : ℤ) ≠ 0),
      if_neg (by norm_num : ¬((5 : ℤ) < 0 ∧ (2 : ℤ) < 0)), one_mul,
      show ((2 : ℤ)).natAbs = 2 from rfl, pfl_two]
    simp only [List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one]
    rw [kroneckerPrime, if_pos rfl]
    decide
  have h2 : jacobiSym 5 2 = 1 := by
    rw [jacobiSym.mod_left' (a₂ := 1) (by decide)]
    exact jacobiSym.one_left 2
  rw [h1, h2]
  norm_num

/-- PIN 1/4 — `b = 1`: both sides are the empty product. -/
theorem kronecker_eq_jacobi_pin_three_one :
    kroneckerSym 3 (1 : ℤ) = 1 ∧ jacobiSym 3 1 = 1 := by
  refine ⟨?_, jacobiSym.one_right 3⟩
  rw [kroneckerSym, if_neg (by norm_num : (1 : ℤ) ≠ 0),
    if_neg (by norm_num : ¬((3 : ℤ) < 0 ∧ (1 : ℤ) < 0)), one_mul,
    show ((1 : ℤ)).natAbs = 1 from rfl, Nat.primeFactorsList_one]
  rfl

/-- PIN 2/4 — `(5/3) = J(5|3) = -1`. -/
theorem kronecker_eq_jacobi_pin_five_three :
    kroneckerSym 5 (3 : ℤ) = -1 ∧ jacobiSym 5 3 = -1 := by
  refine ⟨?_, by norm_num⟩
  rw [kroneckerSym, if_neg (by norm_num : (3 : ℤ) ≠ 0),
    if_neg (by norm_num : ¬((5 : ℤ) < 0 ∧ (3 : ℤ) < 0)), one_mul,
    show ((3 : ℤ)).natAbs = 3 from rfl, pfl_three]
  simp only [List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one]
  rw [kroneckerPrime, if_neg (by norm_num : (3 : ℕ) ≠ 2), dif_pos (by norm_num : Nat.Prime 3)]
  norm_num

/-- PIN 3/4 — `(2/5) = J(2|5) = -1`. -/
theorem kronecker_eq_jacobi_pin_two_five :
    kroneckerSym 2 (5 : ℤ) = -1 ∧ jacobiSym 2 5 = -1 := by
  refine ⟨?_, by norm_num⟩
  rw [kroneckerSym, if_neg (by norm_num : (5 : ℤ) ≠ 0),
    if_neg (by norm_num : ¬((2 : ℤ) < 0 ∧ (5 : ℤ) < 0)), one_mul,
    show ((5 : ℤ)).natAbs = 5 from rfl, pfl_five]
  simp only [List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one]
  rw [kroneckerPrime, if_neg (by norm_num : (5 : ℕ) ≠ 2), dif_pos (by norm_num : Nat.Prime 5)]
  norm_num

/-- PIN 4/4 — a **negative** numerator: `(-1/7) = J(-1|7) = -1`. -/
theorem kronecker_eq_jacobi_pin_neg_one_seven :
    kroneckerSym (-1) (7 : ℤ) = -1 ∧ jacobiSym (-1) 7 = -1 := by
  refine ⟨?_, by norm_num⟩
  rw [kroneckerSym, if_neg (by norm_num : (7 : ℤ) ≠ 0),
    if_neg (by norm_num : ¬((-1 : ℤ) < 0 ∧ (7 : ℤ) < 0)), one_mul,
    show ((7 : ℤ)).natAbs = 7 from rfl, pfl_seven]
  simp only [List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one]
  rw [kroneckerPrime, if_neg (by norm_num : (7 : ℕ) ≠ 2), dif_pos (by norm_num : Nat.Prime 7)]
  norm_num

end KroneckerJacobiGate

/-! ## DRK-10, half 2 -/

/-- **DRK-10, half 2 (PROVED), hypothesis-minimal form.**  For **odd** `b : ℕ`, run 3's Kronecker
symbol and Mathlib's Jacobi symbol agree: `(a / b) = J(a | b)`.

The proof is by unfolding, and every step is where the hypotheses earn their keep:
`b ≠ 0` (forced by `Odd b`) kills the `d = 0` branch of `kroneckerSym`; `(b : ℤ) ≥ 0` kills its
sign factor; `Odd b` makes every prime factor of `b` odd, so `kroneckerPrime a p` is
*definitionally* `legendreSym p a` there — which is exactly what `jacobiSym` takes the product
of.  At `p = 2` this collapses (`χ₈` versus the trivial character of `ZMod 2`), which is what the
two negative controls above exhibit. -/
theorem kroneckerSym_eq_jacobiSym_of_odd' {a : ℤ} {b : ℕ} (hb : Odd b) :
    kroneckerSym a (b : ℤ) = jacobiSym a b := by
  have hb0 : b ≠ 0 := by rintro rfl; simp [Nat.odd_iff] at hb
  have hbZ : (b : ℤ) ≠ 0 := Int.natCast_ne_zero.mpr hb0
  rw [kroneckerSym, if_neg hbZ,
    if_neg (show ¬(a < 0 ∧ (b : ℤ) < 0) from fun h => absurd h.2 (by omega)), one_mul,
    Int.natAbs_natCast, jacobiSym]
  congr 1
  rw [← List.pmap_eq_map (p := fun p : ℕ => Nat.Prime p) (f := kroneckerPrime a)
    (H := fun _ pf => Nat.prime_of_mem_primeFactorsList pf)]
  refine List.pmap_congr_left _ ?_
  intro q hq h1 h2
  have hq2 : q ≠ 2 := by
    rintro rfl
    exact (Nat.not_even_iff_odd.mpr hb) (even_iff_two_dvd.mpr (Nat.dvd_of_mem_primeFactorsList hq))
  rw [kroneckerPrime, if_neg hq2, dif_pos h1]

set_option linter.unusedVariables false in
/-- **DRK-10, half 2 (PROVED)** — the `DRK-10` node's own binder list, verbatim.

LOUDLY (LL-1): `hpos` is **redundant**; `Odd b` already gives `0 < b` in `ℕ`.  It is kept here
only so that the node statement is landed exactly as written.  New code should use
`kroneckerSym_eq_jacobiSym_of_odd'`. -/
theorem kroneckerSym_eq_jacobiSym_of_odd {a : ℤ} {b : ℕ} (hb : Odd b) (hpos : 0 < b) :
    kroneckerSym a (b : ℤ) = jacobiSym a b :=
  kroneckerSym_eq_jacobiSym_of_odd' hb

/-- `hpos` really is redundant. -/
theorem pos_of_odd_nat {b : ℕ} (hb : Odd b) : 0 < b := by
  rcases b with _ | n
  · simp [Nat.odd_iff] at hb
  · exact Nat.succ_pos n

end SocrateAI.ModularForms
