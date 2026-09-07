/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# Eta quotients: the arithmetic layer of Ligozat's criterion  (DAG: F3.1-A0 … F3.1-A9)

This file is the **statement layer** for the combinatorial half of Ligozat's criterion.  Every
declaration here is a statement about the exponent vector `r : ℕ → ℤ` and the level `N` **alone**:
no modular form, no `η`, no upper half-plane appears.  That separation is deliberate and is the
main design decision of this file.

Mathlib (commit `905b95818e`, 2026-07-28) contains **no** eta quotients: repository-wide searches
for `EtaQuotient`, `Ligozat`, `Fricke`, `AtkinLehner`, `DedekindSum` and `etaMultiplier` all
return zero occurrences.  What it does have, and what we build on, is `Nat.divisors`,
`Nat.sum_div_divisors` (the divisor involution `δ ↦ N/δ`) and `Nat.totient`.

## Why the analytic content is in a different file

`etaQuotientCuspOrder` is a **definition**, never a theorem about `η`.  At a cusp `c/d` with
`d ≠ N` — that is, any cusp other than `∞` — proving that this rational number really is the
vanishing order of `∏ η(δz)^{r_δ}` requires the eta multiplier system on `Γ₀(N)`, which
classically runs through Dedekind sums, absent from Mathlib; that is the named obstruction
`F3.1-OBSTRUCTED`, recorded in full (with the greps, and with the correction of one of the two
blockers it was handed) in `SocrateAI.ModularForms.EtaQuotientCuspOrder`.

At the cusp `∞` itself — the case `d = N` — it IS a theorem, and it is proved:
`meromorphicOrderAt_cuspFunction_eq_cuspOrder_infty` (F3.1-B13, same file) identifies
`etaQuotientCuspOrder N r N` with Mathlib's own `meromorphicOrderAt` of the width-`1` cusp
function.  So exactly one of the `numCusps N` cusp values of this definition is derived, and the
rest are transcription validated by `sum_etaQuotientCuspOrder` (F3.1-A10) and by the `#guard`s.

The analytic statements live in `SocrateAI.ModularForms.EtaQuotientModularity`, whose import cone
is far larger (it needs `Mathlib.NumberTheory.ModularForms.Discriminant`).  Keeping the arithmetic
here means this file's import cone is `Nat.divisors` and `Nat.totient` and nothing else.

## A naming correction to the source brief

The brief writes the cusp-order formula with a free parameter `c`.  The free parameter is in fact
the **denominator** `d` of the cusp `c/d` (with `d ∣ N` and `gcd(c,d) = 1`); the numerator never
appears, so the order depends only on `d`.  Both `gcd`s in the brief's formula already use the
same variable, so the formula was self-consistent — only the label misled.  We call it `d`.

## Main definitions

* `EtaExp`                  — the exponent vector `r`, read only on `N.divisors`
* `EtaExp.trunc`            — its canonical representative, zero off `N.divisors`
* `etaQuotientWeight`       — `k = (1/2) Σ_δ r_δ`, valued in `ℚ` so it is total
* `etaQuotientCuspOrder`    — Ligozat's cusp-order expression at the cusp of denominator `d`
* `LigozatCongr1/2`, `LigozatHolomorphic` — Ligozat's hypotheses, as predicates on `(N, r)`
* `dedekindPsi`, `numCusps` — the arithmetic functions `ψ(N) = N ∏_{p ∣ N}(1+1/p)` and
  `Σ_{d ∣ N} φ(gcd(d, N/d))`, classically the index `[SL(2,ℤ) : Γ₀(N)]` and the cusp count of
  `Γ₀(N)`.  Both identifications are *classical readings*, not theorems of this file.

## Main results

**Proved** (F3.1-A0):

* `EtaExp.sum_divisors_congr` — a divisor sum depends on `r` only through `r`'s values on
  `N.divisors`.  This is the theorem that licenses the total-function encoding; without it,
  "read only on `N.divisors`" would be a comment rather than a claim.
* `EtaExp.sum_divisors_trunc`, `EtaExp.trunc_trunc` — the truncation corollaries.

**Proved** (F3.1-A1):

* `etaQuotientWeight_add` — the weight is additive in the exponent vector.
* `hasIntegralWeight_iff` — `HasIntegralWeight N r` holds exactly when `etaQuotientWeight N r`
  is the image of an integer, so the predicate is not a vacuous label.

**Proved / typechecked** (F3.1-A2):

* `etaQuotientCuspOrder` — Ligozat's cusp-order expression.  A definition, and deliberately
  nothing more; it is not, and is not claimed to be, an order of vanishing of anything.  Its
  correctness question is therefore transcription fidelity, which is settled by a block of
  kernel-decided `#guard`s: known divisors at level `1`, and the valence identity
  `Σ_cusps φ(gcd(d, N/d)) · ord = k · ψ(N) / 12` at levels `2, 4, 6, 9`.  Levels `4` and `9`
  are the ones with `gcd(d, N/d) ≠ 1`, so they pin down the factor a careless reading drops.
  Evidence label **A2 (program-checked)**, not A1.

**Proved** (F3.1-A3):

* `etaQuotientCuspOrder_infty` — at the cusp `∞`, i.e. denominator `d = N`, the expression
  collapses to `(1/24) Σ_δ δ·r_δ`.  This is a theorem *about the definition*, so it is A1 for
  what it says (an identity of rational numbers) and inherits the definition's A2 transcription
  status for the reading "this is `ord_∞`".  Consistency check: at `N = 9`, `r = rTest₉` it
  returns `(1·1 + 3·0 + 9·1)/24 = 5/12`, the value the `#guard` block already pins down.
* `etaQuotientCuspOrder_infty_num` — its numerator form `24·ord_∞ = Σ_δ δ·r_δ`, the integer
  appearing in Ligozat's first congruence.

**Proved** (F3.1-A4):

* `etaQuotientCuspOrder_zero` — at the cusp `0`, i.e. denominator `d = 1`, the expression
  collapses to `(N/24) Σ_δ r_δ/δ`.  Like `etaQuotientCuspOrder_infty` this is a theorem *about
  the definition*: A1 for the identity of rational numbers it states, inheriting the
  definition's A2 transcription status for the reading "this is `ord_0`".  Consistency check
  (`#guard`, next to the theorem): at `N = 9`, `r = rTest₉` the right-hand side returns
  `(9/24)(1/1 + 0/3 + 1/9) = 5/12`, the value the A2 guard block already pins down.
  Note that the hypothesis `N ≠ 0` is *not used*: at `d = 1` the collapse is unconditional
  (`Nat.gcd 1 _ = 1` needs nothing), and the binder is kept only for signature uniformity
  with its siblings.  The build reports this as an unused-variable warning, deliberately.

**Proved** (F3.1-A5):

* `etaQuotientCuspOrder_zero_eq` — the same cusp-`0` value rewritten as `(1/24) Σ_δ (N/δ)·r_δ`,
  which is the quantity Ligozat's **second** congruence constrains mod `24`.  Like its two
  siblings this is a theorem *about* the definition (A1 for the rational-number identity,
  inheriting the definition's A2 transcription status for the reading "this is `ord_0`").  The
  one piece of arithmetic content is that `δ ∣ N` makes the natural-number division `N/δ`
  exact, so `Nat.cast_div` may replace `((N/δ : ℕ) : ℚ)` by `(N : ℚ)/(δ : ℚ)`; the rewrite is
  therefore done pointwise under `Finset.sum_congr`, with membership in `N.divisors` in hand,
  and *not* by a global `push_cast` (which would be unsound here: `((2/4 : ℕ) : ℚ) = 0 ≠ 1/2`).
  Unlike `etaQuotientCuspOrder_zero`, this one does use `hN`, via that lemma.
  `Nat.sum_div_divisors` — the divisor involution — is *not* needed on this route; it would be
  the alternative if one reindexed the sum instead of casting.  Consistency check (`#guard`,
  next to the theorem): at `N = 9`, `r = rTest₉` the right-hand side is
  `(9·1 + 3·0 + 1·1)/24 = 5/12`, the value the A2 guard block pins down.

**Proved** (F3.1-A6):

* `etaQuotientCuspOrder_add`, `etaQuotientCuspOrder_smul`, `etaQuotientCuspOrder_zero_exp` —
  `r ↦ etaQuotientCuspOrder N r d` is `ℤ`-linear.  This is what makes the cusp order
  *compositional*: the order of a product of eta quotients is read off factor by factor, and
  the order of `∏ η(δz)^{r_δ}` is a `ℤ`-linear functional of the exponent vector, so Ligozat's
  holomorphy condition is a system of linear inequalities in `r` — the form in which it is
  actually solved.  All three are A1 for what they state (identities of rational numbers about
  the transcribed definition) and, like their A3/A4/A5 siblings, assert nothing about `η`.
  No hypothesis on `N` or `d` is needed: `_add` holds termwise even where the denominator
  `gcd(d, N/d)·d·δ` vanishes, since `x/0 = 0` in `ℚ`.

**Proved** (F3.1-A7):

* `LigozatCongr1`, `LigozatCongr2`, `LigozatHolomorphic` — Ligozat's three hypotheses as
  predicates on `(N, r)` alone.  No modular form occurs in any of them, so none of them is a
  claim about `η`; they are the input side of the criterion, stated so that the analytic side
  can be attached later without restating them.
* `dvd24_iff_isInt_of_mul_eq` — the clearing-denominators bridge: given `24 · q = (S : ℚ)` with
  `S : ℤ`, one has `24 ∣ S ↔ q ∈ ℤ`.  Pure `ℤ ↪ ℚ` arithmetic; both congruences are instances.
* `etaQuotientCuspOrder_zero_num` — the cleared-denominator form of A5, `24 · ord_0 =
  Σ_δ (N/δ)·r_δ` as an integer, the companion of `etaQuotientCuspOrder_infty_num`.
* `ligozatCongr1_iff` — congruence (i) is **exactly** integrality of `ord_∞`.
* `ligozatCongr2_iff` — congruence (ii) is **exactly** integrality of `ord_0`.
  Both are A1 for what they state: an equivalence between a divisibility in `ℤ` and an
  integrality in `ℚ`, inheriting the definition's A2 transcription status for the reading
  "`etaQuotientCuspOrder` is an order of vanishing".  Neither says that the eta quotient is
  invariant under `T` or under `W_N` — those readings are F3.2-A6 and F3.2-A8, they need the
  eta multiplier system, and nothing in this file claims them.

**Proved** (F3.1-A8):

* `dedekindPsi` — the Dedekind psi function `ψ(N) = N ∏_{p ∣ N} (1 + 1/p)`, written in the
  division-free form `(∏_{p ∣ N}(p+1)) · (N / ∏_{p ∣ N} p)` so that it is a natural number and
  the `ℕ`-division is exact (`Nat.prod_primeFactors_dvd`).  Classically this is the index
  `[SL(2,ℤ) : Γ₀(N)]`; **that identification is not proved here** — Mathlib has no `Γ₀(N)` index
  formula, and nothing in this file claims one.  What is proved are the two arithmetic
  identities that pin the function down.
* `numCusps` — the divisor sum `Σ_{d ∣ N} φ(gcd(d, N/d))`.  Classically the number of cusps of
  `Γ₀(N)`; again the identification with a cusp count is **not** proved here, only the divisor
  sum and its multiplicativity.
* `dedekindPsi_mul` — `ψ(mn) = ψ(m)ψ(n)` for coprime `m, n`.  No positivity hypothesis is
  needed (the brief's `m ≠ 0`, `n ≠ 0` turned out to be unnecessary and were dropped).
* `dedekindPsi_prime_pow` — `ψ(p^k) = p^{k-1}(p+1)` for `p` prime and `k ≥ 1`.
* `numCusps_mul` — the cusp count is multiplicative on coprime arguments, via the divisor
  bijection `d ↦ (gcd(d,m), gcd(d,n))`.

Eight kernel-decided `#guard`s pin the numerics: `ψ(1) = 1`, `ψ(5) = 6`, `ψ(8) = 12`,
`ψ(12) = 24`, and `numCusps(12) = 6`.

**Proved** (F3.1-A9):

* `sum_totient_gcd_sq_div` — for every `N ≠ 0` and every `δ ∣ N`,

    `Σ_{d ∣ N} φ(gcd(d, N/d)) · gcd(d,δ)² / (gcd(d, N/d) · d)  =  δ · ψ(N) / N`.

  This is the per-`δ` core of the eta-quotient valence identity: it is the statement that
  summing Ligozat's cusp-order weight of a *single* divisor `δ` over all cusp denominators `d`,
  each weighted by the number `φ(gcd(d, N/d))` of cusps with that denominator, collapses to
  `δ ψ(N)/N`.  It is a theorem of arithmetic only — no `η`, no modular form, no cusp appears in
  its proof, and it does **not** by itself say anything about vanishing orders.

  The proof is `Nat.recOnPosPrimePosCoprime`.  Both sides are multiplicative in the *pair*
  `(N, δ)` (`ligozatCuspSum_mul`, via the divisor bijection `d ↦ (gcd(d,m), gcd(d,n))` already
  used for `numCusps_mul`, plus `dedekindPsi_mul`), and on a prime power the sum is an explicit
  finite geometric computation (`ligozatCuspSum_prime_pow`): the `k+1` divisors `p^i` of `p^k`
  contribute a coefficient `p` at the two ends `i ∈ {0, k}` and `p - 1` in between, and
  `geom_sum_mul` collapses the two resulting geometric blocks.

  A kernel-checked numeric guard at `(N, δ) = (12, 4)` pins the *statement* (both sides equal
  `8`), independently of the proof; the identity was additionally program-checked outside Lean
  for every `N < 400` and every `δ ∣ N` with zero mismatches.

**Proved** (F3.1-A10):

* `sum_etaQuotientCuspOrder` — the **valence identity for eta quotients**, as pure arithmetic:

    `Σ_{d ∣ N} φ(gcd(d, N/d)) · etaQuotientCuspOrder N r d  =  etaQuotientWeight N r · ψ(N) / 12`

  for every `N ≠ 0` and every exponent vector `r`, with no hypothesis whatever on `r` (in
  particular neither Ligozat congruence is assumed).  Summing over `δ` and swapping the two
  divisor sums reduces it to F3.1-A9 applied once per `δ`, after which the factors `δ` and `N`
  cancel; the whole proof is `Finset.sum_comm`, `Finset.mul_sum` and `sum_totient_gcd_sq_div`.

  This is the strongest statement this file can carry, and its scope needs saying plainly.  It
  is A1 as an identity of rational numbers.  It is **not** the analytic valence theorem: it does
  not assert that `etaQuotientCuspOrder` is an order of vanishing, that `numCusps` counts cusps,
  or that `dedekindPsi N = [SL(2,ℤ) : Γ₀(N)]`, and it uses no multiplier system — which is why
  it is provable here while F3.2 is obstructed.  What it contributes is that the *numerical
  prediction* of the analytic valence theorem is now a theorem, which is an independent check on
  A2's transcription: a cusp-order formula for weight-`k` forms on `Γ₀(N)` that failed this
  identity would be wrong.  Kernel-decided guards at `N = 16` and `N = 36` — levels with cusps
  of multiplicity `φ(gcd(d, N/d)) = 2` — pin the statement independently of the proof, each side
  guarded separately; program-checked outside Lean on 4000 random `(N, r)` with zero mismatches.
-/
import Mathlib.NumberTheory.Divisors
import Mathlib.Data.Nat.Totient
import Mathlib.Algebra.Order.Field.Rat
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Data.Nat.Factorization.Induction
import Mathlib.Tactic.LinearCombination

namespace SocrateAI.ModularForms

open Finset

/-! ### F3.1-A0 — the exponent vector -/

/-- The exponent vector of an eta quotient of level `N`: an integer `r δ` for each divisor `δ`
of `N`.  Kept as a total function `ℕ → ℤ`; the restriction to divisors is imposed by the
summation range `N.divisors`, never by the type. -/
abbrev EtaExp := ℕ → ℤ

namespace EtaExp

/-- The truncation of an exponent vector to the divisors of `N`: values off `N.divisors` are
replaced by `0`.  This is the canonical representative of `r` for the equivalence "agrees on
`N.divisors`", and exists only to *state* `sum_divisors_trunc` below. -/
def trunc (N : ℕ) (r : EtaExp) : EtaExp := fun δ => if δ ∈ N.divisors then r δ else 0

@[simp] theorem trunc_apply_of_mem {N δ : ℕ} (r : EtaExp) (hδ : δ ∈ N.divisors) :
    trunc N r δ = r δ := if_pos hδ

@[simp] theorem trunc_apply_of_not_mem {N δ : ℕ} (r : EtaExp) (hδ : δ ∉ N.divisors) :
    trunc N r δ = 0 := if_neg hδ

/-- **The defining property of `EtaExp`.**  Any quantity assembled as a sum over `N.divisors`
depends on `r` only through its values on `N.divisors`.  This is precisely what licenses
carrying the exponent vector as a *total* function `ℕ → ℤ` rather than a dependent function on
the subtype of divisors: the two carry the same information for every use made of them here.
The general shape `F : ℕ → ℤ → M` covers every summand occurring in this file (weight, cusp
order, both Ligozat congruences), which are recovered by instantiating `F` and `M`. -/
theorem sum_divisors_congr {M : Type*} [AddCommMonoid M] (N : ℕ) {r s : EtaExp}
    (h : ∀ δ ∈ N.divisors, r δ = s δ) (F : ℕ → ℤ → M) :
    ∑ δ ∈ N.divisors, F δ (r δ) = ∑ δ ∈ N.divisors, F δ (s δ) :=
  Finset.sum_congr rfl fun δ hδ => congrArg (F δ) (h δ hδ)

/-- Consequence of `sum_divisors_congr`: zeroing out the non-divisors changes no divisor sum.
Every `r : EtaExp` is therefore interchangeable with the finitely-supported `trunc N r`. -/
theorem sum_divisors_trunc {M : Type*} [AddCommMonoid M] (N : ℕ) (r : EtaExp) (F : ℕ → ℤ → M) :
    ∑ δ ∈ N.divisors, F δ (trunc N r δ) = ∑ δ ∈ N.divisors, F δ (r δ) :=
  sum_divisors_congr N (fun _ hδ => trunc_apply_of_mem r hδ) F

/-- Truncation is idempotent, so `trunc N` really is a choice of representative. -/
@[simp] theorem trunc_trunc (N : ℕ) (r : EtaExp) : trunc N (trunc N r) = trunc N r := by
  funext δ
  by_cases hδ : δ ∈ N.divisors <;> simp [hδ]

/-- The pointwise `ℤ`-module structure on `EtaExp`, inherited from `Pi`.  Nothing is declared:
this only records that `r + s` and `m • r` — the operations `etaQuotientCuspOrder_add` and
`etaQuotientCuspOrder_smul` are stated in — already exist on the type as given. -/
example : Module ℤ EtaExp := inferInstance

end EtaExp

/-! ### F3.1-A1 — the weight -/

/-- The weight of the eta quotient `∏_{δ ∣ N} η(δz)^{r_δ}`, namely `k = (1/2) Σ_δ r_δ`.
Valued in `ℚ` so that it is a total function; integrality is the separate predicate
`HasIntegralWeight`. -/
def etaQuotientWeight (N : ℕ) (r : EtaExp) : ℚ := (∑ δ ∈ N.divisors, (r δ : ℚ)) / 2

/-- The weight `(1/2) Σ_δ r_δ` is an integer exactly when `Σ_δ r_δ` is even. -/
def HasIntegralWeight (N : ℕ) (r : EtaExp) : Prop := Even (∑ δ ∈ N.divisors, r δ)

/-- **The weight is additive in the exponent vector.**  A purely arithmetic statement about
divisor sums: nothing here asserts anything about `η`.  (Its intended analytic reading — that
adding exponent vectors multiplies the corresponding eta quotients, and weights add under
products — belongs to `EtaQuotientModularity` and is *not* claimed by this lemma.)
Proof: the summand `((r + s) δ : ℚ)` splits by `Int.cast_add`, the sum splits by
`Finset.sum_add_distrib`, and the division by `2` distributes by `add_div`. -/
theorem etaQuotientWeight_add (N : ℕ) (r s : EtaExp) :
    etaQuotientWeight N (r + s) = etaQuotientWeight N r + etaQuotientWeight N s := by
  simp only [etaQuotientWeight, Pi.add_apply, Int.cast_add, Finset.sum_add_distrib, add_div]

/-- `HasIntegralWeight` is not a vacuous label: `Σ_δ r_δ` is even exactly when the rational
number `etaQuotientWeight N r` is the image of an integer.  This is what makes the split
between the total `ℚ`-valued weight and the `Prop`-valued integrality predicate honest. -/
theorem hasIntegralWeight_iff (N : ℕ) (r : EtaExp) :
    HasIntegralWeight N r ↔ ∃ m : ℤ, etaQuotientWeight N r = (m : ℚ) := by
  have hcast : ((∑ δ ∈ N.divisors, r δ : ℤ) : ℚ) = ∑ δ ∈ N.divisors, (r δ : ℚ) := by
    push_cast
    rfl
  constructor
  · rintro ⟨m, hm⟩
    refine ⟨m, ?_⟩
    rw [etaQuotientWeight, ← hcast, hm]
    push_cast
    ring
  · rintro ⟨m, hm⟩
    rw [etaQuotientWeight, ← hcast, div_eq_iff (by norm_num : (2 : ℚ) ≠ 0)] at hm
    refine ⟨m, ?_⟩
    have h2 : ((∑ δ ∈ N.divisors, r δ : ℤ) : ℚ) = ((m + m : ℤ) : ℚ) := by
      rw [hm]
      push_cast
      ring
    exact_mod_cast h2

/-! ### F3.1-A2 — the cusp-order expression -/

/-- **Ligozat's cusp-order expression.**  For `d ∣ N` this is the rational number

  `ord(N, r, d) = (N/24) · Σ_{δ ∣ N} gcd(d,δ)² · r_δ / (gcd(d, N/d) · d · δ)`,

which classically equals the vanishing order of `∏_{δ ∣ N} η(δz)^{r_δ}` at any cusp `c/d`
of `Γ₀(N)` with denominator `d`.

This is a **definition and nothing more**.  Nothing in this file asserts that it computes an
order of vanishing of anything: see the module docstring and
`SocrateAI.ModularForms.EtaQuotientModularity`. -/
def etaQuotientCuspOrder (N : ℕ) (r : EtaExp) (d : ℕ) : ℚ :=
  (N : ℚ) / 24 * ∑ δ ∈ N.divisors,
    ((Nat.gcd d δ : ℚ) ^ 2 * (r δ : ℚ)) / ((Nat.gcd d (N / d) : ℚ) * (d : ℚ) * (δ : ℚ))

/-! #### Program-checked sanity values (evidence label **A2**, not A1)

`etaQuotientCuspOrder` is *transcribed* from the literature, so the risk it carries is a
transcription error, not a proof gap — and no theorem in this file can catch one, because every
theorem here is a theorem *about* the transcribed formula.  The guards below are the check that
can.  Each is decided by kernel reduction (`ℚ`, `Nat.divisors` and `Finset.sum` are computable),
so it is part of compilation and cannot go stale.

The expected values come from two sources, neither of which is this formula:

* **A known divisor.**  `N = 1`, `r₁ = 24` is the discriminant `Δ = η²⁴`, whose divisor is the
  cusp `∞` with multiplicity `1`.
* **The valence identity.**  A weakly holomorphic modular form of weight `k` on `Γ₀(N)` has total
  divisor degree `k · [SL(2,ℤ) : Γ₀(N)] / 12`, the cusp of denominator `d` counted with
  multiplicity `φ(gcd(d, N/d))`.  Each block below closes with that sum, using the classical
  indices `ψ(2) = 3`, `ψ(4) = 6`, `ψ(6) = 12`, `ψ(9) = 12`.

The `N = 4` and `N = 9` blocks are the discriminating ones: they are the levels with a cusp where
`gcd(d, N/d) ≠ 1`, so a transcription that dropped that factor fails them.  `N = 9` also has a
cusp of multiplicity `φ(3) = 2`, which the valence sum there is sensitive to.  Each guard was
checked to be non-vacuous by confirming that a perturbed value fails to compile.
-/

/-- Test vector: `η(z)⁻¹ η(2z)³` at level `2`, weight `1`.  Exercises negative exponents. -/
private def rTest₂ : EtaExp := fun δ => if δ = 1 then -1 else 3

/-- Test vector: `η(z)²` at level `4`, weight `1`.  Not symmetric under `δ ↦ N/δ`. -/
private def rTest₄ : EtaExp := fun δ => if δ = 1 then 2 else 0

/-- Test vector: `η(z) η(6z)` at level `6`, weight `1`.  Four cusps, all of multiplicity `1`. -/
private def rTest₆ : EtaExp := fun δ => if δ = 1 ∨ δ = 6 then 1 else 0

/-- Test vector: `η(z) η(9z)` at level `9`, weight `1`.  The cusp `d = 3` has
`gcd(3, 9/3) = 3` and multiplicity `φ(3) = 2`. -/
private def rTest₉ : EtaExp := fun δ => if δ = 1 ∨ δ = 9 then 1 else 0

-- `Δ = η²⁴` at level `1`: the unique cusp, order `1`; valence `12 · 1 / 12 = 1`.
#guard etaQuotientCuspOrder 1 (fun _ => 24) 1 = 1

-- Level `2`, weight `1`, `ψ(2) = 3`.
#guard etaQuotientCuspOrder 2 rTest₂ 1 = 1 / 24
#guard etaQuotientCuspOrder 2 rTest₂ 2 = 5 / 24
#guard etaQuotientCuspOrder 2 rTest₂ 1 + etaQuotientCuspOrder 2 rTest₂ 2 = 3 / 12

-- Level `4`, weight `1`, `ψ(4) = 6`.  Here `gcd(2, 4/2) = 2`.
#guard etaQuotientCuspOrder 4 rTest₄ 1 = 1 / 3
#guard etaQuotientCuspOrder 4 rTest₄ 2 = 1 / 12
#guard etaQuotientCuspOrder 4 rTest₄ 4 = 1 / 12
#guard etaQuotientCuspOrder 4 rTest₄ 1 + etaQuotientCuspOrder 4 rTest₄ 2
    + etaQuotientCuspOrder 4 rTest₄ 4 = 6 / 12

-- Level `6`, weight `1`, `ψ(6) = 12`.
#guard etaQuotientCuspOrder 6 rTest₆ 1 = 7 / 24
#guard etaQuotientCuspOrder 6 rTest₆ 2 = 5 / 24
#guard etaQuotientCuspOrder 6 rTest₆ 3 = 5 / 24
#guard etaQuotientCuspOrder 6 rTest₆ 6 = 7 / 24
#guard etaQuotientCuspOrder 6 rTest₆ 1 + etaQuotientCuspOrder 6 rTest₆ 2
    + etaQuotientCuspOrder 6 rTest₆ 3 + etaQuotientCuspOrder 6 rTest₆ 6 = 12 / 12

-- Level `9`, weight `1`, `ψ(9) = 12`.  Here `gcd(3, 9/3) = 3` and the cusp `d = 3` is counted
-- `φ(3) = 2` times, which is the coefficient `2` in the valence sum.
#guard Nat.totient (Nat.gcd 3 (9 / 3)) = 2
#guard etaQuotientCuspOrder 9 rTest₉ 1 = 5 / 12
#guard etaQuotientCuspOrder 9 rTest₉ 3 = 1 / 12
#guard etaQuotientCuspOrder 9 rTest₉ 9 = 5 / 12
#guard etaQuotientCuspOrder 9 rTest₉ 1 + 2 * etaQuotientCuspOrder 9 rTest₉ 3
    + etaQuotientCuspOrder 9 rTest₉ 9 = 12 / 12

/-! ### F3.1-A3 — the cusp `∞` (denominator `d = N`) -/

/-- At the cusp `∞`, i.e. denominator `d = N`, the cusp-order expression collapses to
`(1/24) Σ_δ δ · r_δ`, because `gcd(N,δ) = δ` for `δ ∣ N` and `gcd(N, N/N) = gcd(N,1) = 1`. -/
theorem etaQuotientCuspOrder_infty (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    etaQuotientCuspOrder N r N = (∑ δ ∈ N.divisors, (δ : ℚ) * (r δ : ℚ)) / 24 := by
  have hNQ : (N : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hN
  have hself : N / N = 1 := Nat.div_self (Nat.pos_of_ne_zero hN)
  -- Each summand collapses: `gcd N δ = δ` for `δ ∣ N`, and `gcd N (N/N) = gcd N 1 = 1`,
  -- so `δ² · rδ / (1 · N · δ) = δ · rδ / N`.  The cancellation of one factor `δ` is where
  -- `δ ≠ 0` (from `Nat.pos_of_mem_divisors`) is used.
  have hstep : ∀ δ ∈ N.divisors,
      ((Nat.gcd N δ : ℚ) ^ 2 * (r δ : ℚ)) / ((Nat.gcd N (N / N) : ℚ) * (N : ℚ) * (δ : ℚ))
        = ((δ : ℚ) * (r δ : ℚ)) * (N : ℚ)⁻¹ := by
    intro δ hδ
    have hdvd : δ ∣ N := Nat.dvd_of_mem_divisors hδ
    have hδQ : (δ : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.pos_of_mem_divisors hδ).ne'
    rw [Nat.gcd_eq_right hdvd, hself, Nat.gcd_one_right, Nat.cast_one, one_mul,
      ← div_eq_mul_inv, div_eq_div_iff (mul_ne_zero hNQ hδQ) hNQ]
    ring
  -- The constant `N⁻¹` then leaves the sum and cancels the prefactor `N/24`.
  have hinv : (N : ℚ) * (N : ℚ)⁻¹ = 1 := mul_inv_cancel₀ hNQ
  rw [etaQuotientCuspOrder, Finset.sum_congr rfl hstep, ← Finset.sum_mul]
  rw [show (N : ℚ) / 24 * ((∑ δ ∈ N.divisors, (δ : ℚ) * (r δ : ℚ)) * (N : ℚ)⁻¹)
      = ((N : ℚ) * (N : ℚ)⁻¹) * ((∑ δ ∈ N.divisors, (δ : ℚ) * (r δ : ℚ)) / 24) from by ring,
    hinv, one_mul]

/-- The numerator form of `etaQuotientCuspOrder_infty`: `24 · ord_∞` is the integer
`Σ_δ δ · r_δ`.  This is the quantity appearing in Ligozat's first congruence. -/
theorem etaQuotientCuspOrder_infty_num (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    24 * etaQuotientCuspOrder N r N = ((∑ δ ∈ N.divisors, (δ : ℤ) * r δ : ℤ) : ℚ) := by
  rw [etaQuotientCuspOrder_infty N hN r]
  push_cast
  ring

/-! ### F3.1-A4, A5 — the cusp `0` (denominator `d = 1`) -/

/-- At the cusp `0`, i.e. denominator `d = 1`, the expression collapses to
`(N/24) Σ_δ r_δ / δ`, because `gcd(1,δ) = 1` and `gcd(1, N/1) = 1`. -/
theorem etaQuotientCuspOrder_zero (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    etaQuotientCuspOrder N r 1 = (N : ℚ) / 24 * ∑ δ ∈ N.divisors, (r δ : ℚ) / (δ : ℚ) := by
  -- `Nat.div_one` turns `N / 1` into `N`, so both gcds are `Nat.gcd 1 _ = 1`
  -- (`Nat.gcd_one_left`); `Nat.cast_one` sends them and the factor `(d : ℚ) = (1 : ℚ)` to
  -- `1`, and `one_pow`/`one_mul` clear them out of numerator and denominator alike.
  -- The hypothesis `hN` is not needed: at `d = 1` the collapse is unconditional, and it is
  -- kept only so the signature matches its siblings.  See the note below.
  simp only [etaQuotientCuspOrder, Nat.div_one, Nat.gcd_one_left, Nat.cast_one, one_pow,
    one_mul]

-- Consistency of the collapsed right-hand side with the A2 guard block above, which pins
-- `etaQuotientCuspOrder 9 rTest₉ 1 = 5/12` from the valence identity at level `9`.  This guard
-- evaluates the *other* side of `etaQuotientCuspOrder_zero`, so together they check that the
-- theorem relates the two expressions the docstring says it relates.
#guard ((9 : ℚ) / 24 * ∑ δ ∈ (9 : ℕ).divisors, (rTest₉ δ : ℚ) / (δ : ℚ)) = 5 / 12

/-- **`ord_0` rewritten as `(1/24) Σ_δ (N/δ) · r_δ`**, the quantity constrained by Ligozat's
**second** congruence.  The bridge is that `δ ∣ N` makes the natural-number division `N/δ`
exact, so the cast `((N/δ : ℕ) : ℚ) = (N : ℚ)/(δ : ℚ)` is valid — this is `Nat.cast_div`, and
it is applied under the sum where `δ ∈ N.divisors` is available, since off the divisors it is
simply false.  Reindexing by the divisor involution `δ ↦ N/δ` (`Nat.sum_div_divisors`) is an
alternative route and is *not* used here.

A theorem about the transcribed definition, exactly like `etaQuotientCuspOrder_infty` and
`etaQuotientCuspOrder_zero`: A1 for the identity of rational numbers it states, and it makes
no claim that either side is an order of vanishing. -/
theorem etaQuotientCuspOrder_zero_eq (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    etaQuotientCuspOrder N r 1 = (∑ δ ∈ N.divisors, ((N / δ : ℕ) : ℚ) * (r δ : ℚ)) / 24 := by
  -- Collapse `ord_0` to `(N/24) Σ_δ r_δ/δ` first (F3.1-A4), then move the constant `N` into
  -- the sum.  The only arithmetic content is that `δ ∣ N` makes the *natural-number* division
  -- `N / δ` exact, so `Nat.cast_div` identifies `((N/δ : ℕ) : ℚ)` with the honest quotient
  -- `(N : ℚ)/(δ : ℚ)`.  Without divisibility this is false (e.g. `N = 2`, `δ = 4`), which is
  -- why the rewriting is done pointwise under `Finset.sum_congr` with `hδ` in hand rather
  -- than by a global `push_cast`.
  rw [etaQuotientCuspOrder_zero N hN r]
  have hstep : ∀ δ ∈ N.divisors,
      ((N / δ : ℕ) : ℚ) * (r δ : ℚ) = (N : ℚ) * ((r δ : ℚ) / (δ : ℚ)) := by
    intro δ hδ
    have hdvd : δ ∣ N := Nat.dvd_of_mem_divisors hδ
    have hδQ : (δ : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.pos_of_mem_divisors hδ).ne'
    rw [Nat.cast_div hdvd hδQ]
    ring
  rw [Finset.sum_congr rfl hstep, ← Finset.mul_sum]
  ring

-- Consistency of the *new* right-hand side with the A2 guard block, which pins
-- `etaQuotientCuspOrder 9 rTest₉ 1 = 5/12` from the valence identity at level `9`.  This
-- evaluates the `Σ_δ (N/δ)·r_δ` side, so together with the A4 guard above the three
-- expressions the two collapse theorems relate are all pinned to the same number.
#guard ((∑ δ ∈ (9 : ℕ).divisors, ((9 / δ : ℕ) : ℚ) * (rTest₉ δ : ℚ)) / 24) = 5 / 12

/-! ### F3.1-A6 — `ℤ`-linearity in the exponent vector -/

/-- **The cusp-order expression is additive in the exponent vector.**  A statement about
rational numbers and divisor sums only: nothing here mentions `η`, and in particular this is
*not* the assertion that orders of vanishing add under products of eta quotients (that reading
belongs to `EtaQuotientModularity`).

The proof is the summand splitting `gcd(d,δ)²·(r_δ + s_δ) = gcd(d,δ)²·r_δ + gcd(d,δ)²·s_δ`
(`mul_add`) pushed through the common denominator (`add_div`), then `Finset.sum_add_distrib`
and a final `mul_add` for the prefactor `N/24`.  No hypothesis on `N` or `d` is needed: the
identity holds termwise even where the denominator vanishes, since `x/0 = 0` in `ℚ` and
`0 = 0 + 0`. -/
theorem etaQuotientCuspOrder_add (N : ℕ) (r s : EtaExp) (d : ℕ) :
    etaQuotientCuspOrder N (r + s) d = etaQuotientCuspOrder N r d + etaQuotientCuspOrder N s d := by
  simp only [etaQuotientCuspOrder, Pi.add_apply, Int.cast_add, mul_add, add_div,
    Finset.sum_add_distrib]

/-- **The cusp-order expression is homogeneous of degree one in the exponent vector.**
Together with `etaQuotientCuspOrder_add` this says `r ↦ etaQuotientCuspOrder N r d` is
`ℤ`-linear, which is what makes the order compositional: it may be computed one `η`-factor at
a time.  Again a statement about divisor sums alone.

The scalar is pulled out of each summand first (`Pi.smul_apply`, `smul_eq_mul`, `Int.cast_mul`,
then `ring` inside the field `ℚ`, which handles the division), then out of the sum
(`Finset.mul_sum`, used right-to-left), then commuted past the prefactor `N/24`.  As with
`_add`, no hypothesis on `N` or `d` is needed. -/
theorem etaQuotientCuspOrder_smul (N : ℕ) (m : ℤ) (r : EtaExp) (d : ℕ) :
    etaQuotientCuspOrder N (m • r) d = (m : ℚ) * etaQuotientCuspOrder N r d := by
  have hstep : ∀ δ : ℕ,
      ((Nat.gcd d δ : ℚ) ^ 2 * (((m • r) δ : ℤ) : ℚ))
          / ((Nat.gcd d (N / d) : ℚ) * (d : ℚ) * (δ : ℚ))
        = (m : ℚ) * (((Nat.gcd d δ : ℚ) ^ 2 * ((r δ : ℤ) : ℚ))
          / ((Nat.gcd d (N / d) : ℚ) * (d : ℚ) * (δ : ℚ))) := by
    intro δ
    simp only [Pi.smul_apply, smul_eq_mul, Int.cast_mul]
    ring
  simp only [etaQuotientCuspOrder, hstep, ← Finset.mul_sum]
  ring

/-- The cusp-order expression vanishes on the zero exponent vector — the constant `η⁰ = 1` has
no zero anywhere.  This is the third linearity clause and, with the two above, exhibits
`etaQuotientCuspOrder N · d` as a `ℤ`-linear map `EtaExp → ℚ`. -/
@[simp] theorem etaQuotientCuspOrder_zero_exp (N d : ℕ) : etaQuotientCuspOrder N 0 d = 0 := by
  simp [etaQuotientCuspOrder]

/-! ### F3.1-A7 — Ligozat's hypotheses as predicates -/

/-- Ligozat's congruence (i): `Σ_{δ ∣ N} δ · r_δ ≡ 0 (mod 24)`. -/
def LigozatCongr1 (N : ℕ) (r : EtaExp) : Prop := (24 : ℤ) ∣ ∑ δ ∈ N.divisors, (δ : ℤ) * r δ

/-- Ligozat's congruence (ii): `Σ_{δ ∣ N} (N/δ) · r_δ ≡ 0 (mod 24)`. -/
def LigozatCongr2 (N : ℕ) (r : EtaExp) : Prop :=
  (24 : ℤ) ∣ ∑ δ ∈ N.divisors, ((N / δ : ℕ) : ℤ) * r δ

/-- Ligozat's holomorphy hypothesis: the cusp-order expression is nonnegative at every
cusp denominator `d ∣ N`. -/
def LigozatHolomorphic (N : ℕ) (r : EtaExp) : Prop :=
  ∀ d ∈ N.divisors, 0 ≤ etaQuotientCuspOrder N r d

/-- **The clearing-denominators bridge.**  A rational number `q` whose `24`-fold multiple is the
integer `S` is itself an integer exactly when `24 ∣ S`.  Stated for a hypothesis `24 * q = (S : ℚ)`
supplied by the caller, so that both Ligozat congruences are instances of one argument: the `∞`
instance takes `h` from `etaQuotientCuspOrder_infty_num`, the `0` instance from
`etaQuotientCuspOrder_zero_num`.

Purely an arithmetic fact about `ℤ ↪ ℚ`, with no divisor sum and no `η` in it.  Forward:
`S = 24 * m` gives `24 * q = 24 * (m : ℚ)`, and `mul_left_cancel₀` (with `(24 : ℚ) ≠ 0`) yields
`q = m`.  Backward: `q = (m : ℚ)` turns `h` into `((24 * m : ℤ) : ℚ) = (S : ℚ)`, and injectivity
of `Int.cast : ℤ → ℚ` — supplied by `exact_mod_cast` — gives `S = 24 * m` in `ℤ`. -/
theorem dvd24_iff_isInt_of_mul_eq {S : ℤ} {q : ℚ} (h : 24 * q = (S : ℚ)) :
    (24 : ℤ) ∣ S ↔ ∃ m : ℤ, q = (m : ℚ) := by
  constructor
  · rintro ⟨m, hm⟩
    refine ⟨m, ?_⟩
    refine mul_left_cancel₀ (by norm_num : (24 : ℚ) ≠ 0) ?_
    rw [h, hm]
    push_cast
    ring
  · rintro ⟨m, hm⟩
    refine ⟨m, ?_⟩
    rw [hm] at h
    exact_mod_cast h.symm

/-- The numerator form of `etaQuotientCuspOrder_zero_eq`: `24 · ord_0` is the integer
`Σ_δ (N/δ) · r_δ`, the quantity appearing in Ligozat's **second** congruence.  The companion of
`etaQuotientCuspOrder_infty_num` at the other distinguished cusp, and, like it, a theorem about
the transcribed definition and not a claim about `η`.

The natural-number division `N / δ` must be **kept** on both sides: the honest identification
`((N/δ : ℕ) : ℚ) = (N : ℚ)/(δ : ℚ)` needs `δ ∣ N` and is already discharged inside
`etaQuotientCuspOrder_zero_eq`.  This is why the proof does not use `push_cast`: `push_cast`
fires `Int.ofNat_div` and rewrites `((N/δ : ℕ) : ℤ)` to the *truncated integer* quotient
`(N : ℤ)/(δ : ℤ)`, which no longer matches the left-hand side.  Only `Int.cast` has to move,
so the three cast lemmas are named explicitly. -/
theorem etaQuotientCuspOrder_zero_num (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    24 * etaQuotientCuspOrder N r 1
      = ((∑ δ ∈ N.divisors, ((N / δ : ℕ) : ℤ) * r δ : ℤ) : ℚ) := by
  rw [etaQuotientCuspOrder_zero_eq N hN r]
  simp only [Int.cast_sum, Int.cast_mul, Int.cast_natCast]
  ring

/-- **Congruence (i) is exactly integrality of the cusp-order expression at `∞`.**
`24 ∣ Σ_δ δ·r_δ` on the one side, `ord_∞ ∈ ℤ` on the other; `etaQuotientCuspOrder_infty_num`
(F3.1-A3) says the integer is `24 · ord_∞`, and `dvd24_iff_isInt_of_mul_eq` converts.

Both sides are statements about `(N, r)` alone.  In particular this is **not** the assertion
that the eta quotient is invariant under `T`; that reading is F3.2-A6, needs the eta multiplier
system, and is not claimed anywhere in this file. -/
theorem ligozatCongr1_iff (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    LigozatCongr1 N r ↔ ∃ m : ℤ, etaQuotientCuspOrder N r N = (m : ℚ) :=
  dvd24_iff_isInt_of_mul_eq (etaQuotientCuspOrder_infty_num N hN r)

/-- **Congruence (ii) is exactly integrality of the cusp-order expression at `0`.**  The same
argument as `ligozatCongr1_iff`, with `etaQuotientCuspOrder_zero_num` (F3.1-A5) in place of
`etaQuotientCuspOrder_infty_num`.  As there, both sides are statements about `(N, r)` alone and
neither is a claim about `η`. -/
theorem ligozatCongr2_iff (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    LigozatCongr2 N r ↔ ∃ m : ℤ, etaQuotientCuspOrder N r 1 = (m : ℚ) :=
  dvd24_iff_isInt_of_mul_eq (etaQuotientCuspOrder_zero_num N hN r)

/-! ### F3.1-A8 — the index and the cusp count of `Γ₀(N)` -/

/-- The Dedekind psi function `ψ(N) = N ∏_{p ∣ N} (1 + 1/p)`, written here in the
division-free form `(∏_{p ∣ N} (p+1)) · (N / ∏_{p ∣ N} p)` so that it stays in `ℕ`; the
`ℕ`-division is exact because `∏_{p ∣ N} p ∣ N` (`Nat.prod_primeFactors_dvd`).

Classically `ψ(N) = [SL(2,ℤ) : Γ₀(N)]`.  That is a *reading* of this definition, not a theorem
proved anywhere in this development: Mathlib has no index formula for `Γ₀(N)` and none is
derived here.  What is proved about `dedekindPsi` is `dedekindPsi_mul` and
`dedekindPsi_prime_pow`, which together determine it on every `N`. -/
def dedekindPsi (N : ℕ) : ℕ :=
  (∏ p ∈ N.primeFactors, (p + 1)) * (N / ∏ p ∈ N.primeFactors, p)

/-- The divisor sum `Σ_{d ∣ N} φ(gcd(d, N/d))`, classically the number of cusps of `Γ₀(N)`.
As with `dedekindPsi`, the identification with a cusp count is a classical reading and is not
proved here; `numCusps_mul` is. -/
def numCusps (N : ℕ) : ℕ := ∑ d ∈ N.divisors, Nat.totient (Nat.gcd d (N / d))

section A8Guards

-- `ψ(1) = 1`: the empty product times `1/1`.
#guard dedekindPsi 1 = 1
-- `ψ(p) = p + 1` on a prime.
#guard dedekindPsi 5 = 6
-- `ψ(12) = 12 · (3/2) · (4/3) = 24` (classically the index `[SL(2,ℤ) : Γ₀(12)]`).
#guard dedekindPsi 12 = 24
-- `ψ(p^k) = p^{k-1}(p+1)`: `ψ(8) = 4 · 3 = 12`.
#guard dedekindPsi 8 = 12
-- Multiplicativity, numerically: `ψ(12) = ψ(4)·ψ(3) = 6 · 4`.
#guard dedekindPsi 4 * dedekindPsi 3 = dedekindPsi 12

-- The `N = 1` sum has the single term `φ(gcd(1,1)) = 1` (classically: `SL(2,ℤ)` has one cusp).
#guard numCusps 1 = 1
-- All six divisors of `12` contribute `1` (classically: `Γ₀(12)` has 6 cusps).
#guard numCusps 12 = 6
-- Multiplicativity of the cusp count, numerically.
#guard numCusps 4 * numCusps 3 = numCusps 12

end A8Guards

/-- `gcd` splits across a coprime factorisation of *both* arguments: if `x, z ∣ m` and
`y, w ∣ n` with `m, n` coprime, then `gcd(xy, zw) = gcd(x,z) · gcd(y,w)`.
`Nat.Coprime.gcd_mul` splits the second argument, and the two cancellation lemmas
`Nat.Coprime.gcd_mul_right_cancel` / `Nat.Coprime.gcd_mul_left_cancel` delete the foreign
factor from the first. -/
private theorem gcd_mul_gcd_mul {m n : ℕ} (h : Nat.Coprime m n) {x y z w : ℕ}
    (hx : x ∣ m) (hy : y ∣ n) (hz : z ∣ m) (hw : w ∣ n) :
    Nat.gcd (x * y) (z * w) = Nat.gcd x z * Nat.gcd y w := by
  have hco : ∀ {s t : ℕ}, s ∣ m → t ∣ n → Nat.Coprime s t :=
    fun hs ht => (h.coprime_dvd_left hs).coprime_dvd_right ht
  rw [Nat.Coprime.gcd_mul (x * y) (hco hz hw),
    Nat.Coprime.gcd_mul_right_cancel x (hco hz hy).symm,
    Nat.Coprime.gcd_mul_left_cancel y (hco hx hw)]

/-- The cusp-denominator `gcd` splits on a coprime factorisation: `(m*n)/(ab) = (m/a)(n/b)`
(`Nat.mul_div_mul_comm`), and then `gcd_mul_gcd_mul` applies. -/
private theorem gcd_div_mul_of_coprime {m n a b : ℕ} (h : Nat.Coprime m n)
    (ha : a ∣ m) (hb : b ∣ n) :
    Nat.gcd (a * b) (m * n / (a * b)) = Nat.gcd a (m / a) * Nat.gcd b (n / b) := by
  rw [Nat.mul_div_mul_comm ha hb]
  exact gcd_mul_gcd_mul h ha hb (Nat.div_dvd_of_dvd ha) (Nat.div_dvd_of_dvd hb)

/-- Auxiliary for `numCusps_mul`: with `m` and `n` coprime, `a ∣ m` and `b ∣ n`, the summand of
`numCusps` at the divisor `a * b` of `m * n` factors as the summand at `a` times the summand at
`b`.  This is `gcd_div_mul_of_coprime` followed by `Nat.totient_mul`. -/
private theorem totient_gcd_div_mul_of_coprime {m n a b : ℕ} (h : Nat.Coprime m n)
    (ha : a ∣ m) (hb : b ∣ n) :
    Nat.totient (Nat.gcd (a * b) (m * n / (a * b)))
      = Nat.totient (Nat.gcd a (m / a)) * Nat.totient (Nat.gcd b (n / b)) := by
  rw [gcd_div_mul_of_coprime h ha hb,
    Nat.totient_mul (((h.coprime_dvd_left ((Nat.gcd_dvd_left a (m / a)).trans ha)).coprime_dvd_right
      ((Nat.gcd_dvd_left b (n / b)).trans hb)))]

/-- **`ψ` is multiplicative on coprime arguments.**  `Nat.Coprime.primeFactors_mul` splits both
products over the disjoint union (`Finset.prod_union`), and the radical quotient splits because
`∏_{p ∣ m} p ∣ m` and `∏_{p ∣ n} p ∣ n`, so `Nat.mul_div_mul_comm` applies to the two exact
divisions.  No positivity hypothesis is needed: `Nat.Coprime.primeFactors_mul` and
`Nat.prod_primeFactors_dvd` are unconditional, and `Coprime 0 n` already forces `n = 1`. -/
theorem dedekindPsi_mul {m n : ℕ} (h : Nat.Coprime m n) :
    dedekindPsi (m * n) = dedekindPsi m * dedekindPsi n := by
  unfold dedekindPsi
  rw [h.primeFactors_mul, Finset.prod_union h.disjoint_primeFactors,
    Finset.prod_union h.disjoint_primeFactors,
    Nat.mul_div_mul_comm (Nat.prod_primeFactors_dvd m) (Nat.prod_primeFactors_dvd n)]
  exact mul_mul_mul_comm _ _ _ _

/-- **`ψ` on a prime power**: `ψ(p^k) = p^{k-1}(p+1)` for `k ≥ 1`.  The prime factors of `p^k`
are `{p}` (`Nat.primeFactors_pow_succ`, `Nat.Prime.primeFactors`), so both products collapse to a
single factor and the radical quotient is `p^{k}/p = p^{k-1}`. -/
theorem dedekindPsi_prime_pow {p k : ℕ} (hp : p.Prime) (hk : 0 < k) :
    dedekindPsi (p ^ k) = p ^ (k - 1) * (p + 1) := by
  obtain ⟨j, rfl⟩ : ∃ j, k = j + 1 := ⟨k - 1, (Nat.succ_pred_eq_of_pos hk).symm⟩
  have : p ^ (j + 1) / p = p ^ j := by
    rw [pow_succ, Nat.mul_div_cancel _ hp.pos]
  simp [dedekindPsi, Nat.primeFactors_pow_succ, hp.primeFactors, this, Nat.mul_comm]

/-- **The number of cusps is multiplicative on coprime arguments.**  The divisors of `m * n` are
in bijection with `m.divisors ×ˢ n.divisors` via `d ↦ (gcd d m, gcd d n)` and `(a,b) ↦ a*b`; both
round trips are `Nat.Coprime.gcd_mul` and the two `gcd` cancellation lemmas.  The summands match
by `totient_gcd_div_mul_of_coprime`. -/
theorem numCusps_mul {m n : ℕ} (hm : m ≠ 0) (hn : n ≠ 0) (h : Nat.Coprime m n) :
    numCusps (m * n) = numCusps m * numCusps n := by
  have hco : ∀ {x y : ℕ}, x ∣ m → y ∣ n → Nat.Coprime x y :=
    fun hx hy => (h.coprime_dvd_left hx).coprime_dvd_right hy
  -- `d ↦ (gcd d m, gcd d n)` is the inverse of multiplication on the coprime split.
  have hsplit : ∀ d ∈ (m * n).divisors, Nat.gcd d m * Nat.gcd d n = d := by
    intro d hd
    rw [← Nat.Coprime.gcd_mul d h, Nat.gcd_eq_left (Nat.mem_divisors.mp hd).1]
  have hfst : ∀ a b : ℕ, a ∣ m → b ∣ n → Nat.gcd (a * b) m = a := fun a b ha hb => by
    rw [Nat.Coprime.gcd_mul_right_cancel a (hco (dvd_refl m) hb).symm, Nat.gcd_eq_left ha]
  have hsnd : ∀ a b : ℕ, a ∣ m → b ∣ n → Nat.gcd (a * b) n = b := fun a b ha hb => by
    rw [Nat.Coprime.gcd_mul_left_cancel b (hco ha (dvd_refl n)), Nat.gcd_eq_left hb]
  unfold numCusps
  rw [Finset.sum_mul_sum, ← Finset.sum_product']
  refine Finset.sum_nbij' (fun d => (Nat.gcd d m, Nat.gcd d n)) (fun q => q.1 * q.2)
    ?_ ?_ ?_ ?_ ?_
  · intro d _
    exact Finset.mem_product.mpr
      ⟨Nat.mem_divisors.mpr ⟨Nat.gcd_dvd_right d m, hm⟩,
       Nat.mem_divisors.mpr ⟨Nat.gcd_dvd_right d n, hn⟩⟩
  · intro q hq
    obtain ⟨hq1, hq2⟩ := Finset.mem_product.mp hq
    exact Nat.mem_divisors.mpr
      ⟨mul_dvd_mul (Nat.mem_divisors.mp hq1).1 (Nat.mem_divisors.mp hq2).1,
       Nat.mul_ne_zero hm hn⟩
  · exact hsplit
  · intro q hq
    obtain ⟨hq1, hq2⟩ := Finset.mem_product.mp hq
    have ha := (Nat.mem_divisors.mp hq1).1
    have hb := (Nat.mem_divisors.mp hq2).1
    exact Prod.ext (hfst q.1 q.2 ha hb) (hsnd q.1 q.2 ha hb)
  · intro d hd
    have ha : Nat.gcd d m ∣ m := Nat.gcd_dvd_right d m
    have hb : Nat.gcd d n ∣ n := Nat.gcd_dvd_right d n
    conv_lhs => rw [← hsplit d hd]
    exact totient_gcd_div_mul_of_coprime h ha hb

/-! ### F3.1-A9 — the per-`δ` core identity

`Σ_{d ∣ N} φ(gcd(d, N/d)) · gcd(d,δ)² / (gcd(d, N/d) · d) = δ · ψ(N) / N`.

Everything in this section is arithmetic: `ℕ`, `ℚ`, `Nat.divisors`, `Nat.totient`.  The
`η`-theoretic reading — that this is the valence identity summed over the cusps of `Γ₀(N)` —
is a reading, exactly as for `numCusps` and `dedekindPsi`, and is not proved here.
-/

/-- The left-hand side of the F3.1-A9 identity, as a function of the level `N` and a single
divisor `δ`: the Ligozat weight of `δ` summed over cusp denominators `d ∣ N`, each denominator
carrying the multiplicity `φ(gcd(d, N/d))`. -/
def ligozatCuspSum (N δ : ℕ) : ℚ :=
  ∑ d ∈ N.divisors, (Nat.totient (Nat.gcd d (N / d)) : ℚ) * (Nat.gcd d δ : ℚ) ^ 2
    / ((Nat.gcd d (N / d) : ℚ) * (d : ℚ))

/-- `gcd` of two powers of a common base is the power at the `min` of the exponents.  No
primality and no positivity: for `a ≤ b` one has `p^a ∣ p^b`. -/
private theorem gcd_pow_pow (p a b : ℕ) : Nat.gcd (p ^ a) (p ^ b) = p ^ min a b := by
  rcases le_total a b with h | h
  · rw [min_eq_left h, Nat.gcd_eq_left (pow_dvd_pow p h)]
  · rw [min_eq_right h, Nat.gcd_eq_right (pow_dvd_pow p h)]

/-- On `range (k+1)` with `k ≠ 0`, the predicate `i = 0 ∨ i = k` cuts out exactly `{0, k}`. -/
private theorem filter_eq_zero_or_top {k : ℕ} (hk : 0 < k) :
    {i ∈ range (k + 1) | i = 0 ∨ i = k} = ({0, k} : Finset ℕ) := by
  ext i
  simp only [mem_filter, mem_range, mem_insert, mem_singleton]
  constructor
  · rintro ⟨-, h⟩; exact h
  · rintro (rfl | rfl) <;> omega

/-- **The geometric core of the prime-power case.**  For any `P` in a commutative ring and
`j ≤ k` with `k ≥ 1`,

  `Σ_{i=0}^{k} c_i · P^{2 min(i,j) + (k-i)} = P^{k+j} (P+1)`,

where `c_i = P` for `i ∈ {0,k}` and `c_i = P - 1` otherwise.

The proof writes `c_i = (P-1) + [i ∈ {0,k}]`, evaluates the second piece on `{0,k}`
(`filter_eq_zero_or_top`) to `P^k + P^{2j}`, splits the remaining sum at `i = j` into the two
blocks `P^k Σ_{i<j+1} P^i` and `P^{2j} Σ_{i<k-j} P^i` (the second after reindexing by
`Finset.sum_range_reflect`), and collapses both with `geom_sum_mul`.  Nothing is assumed about
`P`: it is a polynomial identity. -/
private theorem geom_block_sum (P : ℚ) {j k : ℕ} (hjk : j ≤ k) (hk : 0 < k) :
    ∑ i ∈ range (k + 1), (if i = 0 ∨ i = k then P else P - 1) * P ^ (2 * min i j + (k - i))
      = P ^ (k + j) * (P + 1) := by
  have hsplit : ∀ i : ℕ, (if i = 0 ∨ i = k then P else P - 1)
      = (P - 1) + (if i = 0 ∨ i = k then 1 else 0) := by
    intro i; split <;> ring
  simp only [hsplit, add_mul, Finset.sum_add_distrib, ite_mul, one_mul, zero_mul]
  rw [← Finset.sum_filter, filter_eq_zero_or_top hk, Finset.sum_pair (Ne.symm hk.ne'),
    ← Finset.mul_sum]
  have hB : ∑ i ∈ range (k + 1), P ^ (2 * min i j + (k - i))
      = P ^ k * ∑ i ∈ range (j + 1), P ^ i + P ^ (2 * j) * ∑ i ∈ range (k - j), P ^ i := by
    rw [Finset.range_eq_Ico,
      ← Finset.sum_Ico_consecutive _ (Nat.zero_le (j + 1)) (by omega : j + 1 ≤ k + 1)]
    congr 1
    · rw [← Finset.range_eq_Ico, Finset.mul_sum]
      refine Finset.sum_congr rfl fun i hi => ?_
      have hij : i ≤ j := by simpa [Nat.lt_succ_iff] using Finset.mem_range.mp hi
      rw [← pow_add]
      congr 1
      omega
    · rw [Finset.sum_Ico_eq_sum_range, Finset.mul_sum,
        (by omega : k + 1 - (j + 1) = k - j),
        ← Finset.sum_range_reflect (fun s => P ^ (2 * j) * P ^ s) (k - j)]
      refine Finset.sum_congr rfl fun s hs => ?_
      have hsk : s < k - j := Finset.mem_range.mp hs
      rw [← pow_add]
      congr 1
      omega
  rw [hB, (by simp : 2 * min 0 j + (k - 0) = k),
    (by simp [min_eq_right hjk] : 2 * min k j + (k - k) = 2 * j)]
  obtain ⟨t, rfl⟩ : ∃ t, k = j + t := ⟨k - j, by omega⟩
  rw [Nat.add_sub_cancel_left]
  have hg1 : (∑ i ∈ range (j + 1), P ^ i) * (P - 1) = P ^ (j + 1) - 1 := geom_sum_mul P (j + 1)
  have hg2 : (∑ i ∈ range t, P ^ i) * (P - 1) = P ^ t - 1 := geom_sum_mul P t
  linear_combination P ^ (j + t) * hg1 + P ^ (2 * j) * hg2

/-- The single summand of `ligozatCuspSum (p^k) (p^j)` at the divisor `d = p^i`, `k = i + u`,
put over the common denominator `p^{k+1}`.  The coefficient is `p` exactly when
`min(i, k-i) = 0`, i.e. at the two extreme divisors `i = 0` and `i = k`, and `p - 1` otherwise
(`Nat.totient_prime_pow_succ`). -/
private theorem ligozatTerm_prime_pow {p : ℕ} (hp : p.Prime) (i u j k : ℕ) (hk : k = i + u) :
    ((Nat.gcd (p ^ i) (p ^ k / p ^ i)).totient : ℚ) * ((Nat.gcd (p ^ i) (p ^ j) : ℕ) : ℚ) ^ 2
        / (((Nat.gcd (p ^ i) (p ^ k / p ^ i) : ℕ) : ℚ) * ((p ^ i : ℕ) : ℚ))
      = (if i = 0 ∨ i = k then (p : ℚ) else (p : ℚ) - 1)
          * (p : ℚ) ^ (2 * min i j + (k - i)) / (p : ℚ) ^ (k + 1) := by
  subst hk
  rw [Nat.pow_div (by omega) hp.pos, Nat.add_sub_cancel_left, gcd_pow_pow, gcd_pow_pow]
  have hP : (p : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hp.pos.ne'
  have hsq : (((p ^ min i j : ℕ) : ℚ)) ^ 2 = (p : ℚ) ^ (2 * min i j) := by
    push_cast; rw [← pow_mul, mul_comm]
  rw [hsq]
  rcases Nat.eq_zero_or_pos (min i u) with h0 | hpos
  · rw [if_pos (by omega), h0]
    have e1 : (p : ℚ) * (p : ℚ) ^ (2 * min i j + u)
        = (p : ℚ) ^ (2 * min i j) * ((p : ℚ) * (p : ℚ) ^ u) := by ring
    have e2 : (p : ℚ) ^ (i + u + 1) = (p : ℚ) ^ i * ((p : ℚ) * (p : ℚ) ^ u) := by ring
    rw [e1, e2, mul_div_mul_right _ _ (mul_ne_zero hP (pow_ne_zero _ hP))]
    simp
  · obtain ⟨m, hm⟩ : ∃ m, min i u = m + 1 := ⟨min i u - 1, by omega⟩
    rw [if_neg (by omega), hm, Nat.totient_prime_pow_succ hp]
    push_cast [Nat.cast_sub hp.one_le]
    have e1 : ((p : ℚ) ^ m * ((p : ℚ) - 1)) * (p : ℚ) ^ (2 * min i j)
        = (((p : ℚ) - 1) * (p : ℚ) ^ (2 * min i j)) * (p : ℚ) ^ m := by ring
    have e2 : (p : ℚ) ^ (m + 1) * (p : ℚ) ^ i
        = ((p : ℚ) * (p : ℚ) ^ i) * (p : ℚ) ^ m := by ring
    have e3 : ((p : ℚ) - 1) * (p : ℚ) ^ (2 * min i j + u)
        = (((p : ℚ) - 1) * (p : ℚ) ^ (2 * min i j)) * (p : ℚ) ^ u := by ring
    have e4 : (p : ℚ) ^ (i + u + 1) = ((p : ℚ) * (p : ℚ) ^ i) * (p : ℚ) ^ u := by ring
    rw [e1, e2, e3, e4, mul_div_mul_right _ _ (pow_ne_zero _ hP),
      mul_div_mul_right _ _ (pow_ne_zero _ hP)]

/-- **The prime-power case of F3.1-A9.**  `Nat.sum_divisors_prime_pow` turns the divisor sum
into a sum over `range (k+1)`, `ligozatTerm_prime_pow` puts every summand over the common
denominator `p^{k+1}`, and `geom_block_sum` evaluates the numerator to `p^{k+j}(p+1)`. -/
theorem ligozatCuspSum_prime_pow {p : ℕ} (hp : p.Prime) {k j : ℕ} (hk : 0 < k) (hjk : j ≤ k) :
    ligozatCuspSum (p ^ k) (p ^ j)
      = ((p ^ j : ℕ) : ℚ) * ((p ^ (k - 1) * (p + 1) : ℕ) : ℚ) / ((p ^ k : ℕ) : ℚ) := by
  have hP : (p : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hp.pos.ne'
  unfold ligozatCuspSum
  rw [Nat.sum_divisors_prime_pow hp,
    Finset.sum_congr rfl (fun i hi => ligozatTerm_prime_pow hp i (k - i) j k
      (by have := Finset.mem_range.mp hi; omega)),
    ← Finset.sum_div, geom_block_sum (p : ℚ) hjk hk]
  obtain ⟨m, rfl⟩ : ∃ m, k = m + 1 := ⟨k - 1, by omega⟩
  push_cast
  rw [div_eq_div_iff (pow_ne_zero _ hP) (pow_ne_zero _ hP)]
  ring

/-- **`ligozatCuspSum` is multiplicative in the pair `(N, δ)`.**  The divisor bijection is the
same one that proves `numCusps_mul`: `d ↦ (gcd(d,m), gcd(d,n))` with inverse `(a,b) ↦ a*b`.  The
summands match because all three `gcd`s in sight split (`gcd_div_mul_of_coprime`,
`gcd_mul_gcd_mul`) and `Nat.totient` is multiplicative on the resulting coprime pair. -/
theorem ligozatCuspSum_mul {m n a b : ℕ} (hm : m ≠ 0) (hn : n ≠ 0) (h : Nat.Coprime m n)
    (ha : a ∣ m) (hb : b ∣ n) :
    ligozatCuspSum (m * n) (a * b) = ligozatCuspSum m a * ligozatCuspSum n b := by
  have hco : ∀ {s t : ℕ}, s ∣ m → t ∣ n → Nat.Coprime s t :=
    fun hs ht => (h.coprime_dvd_left hs).coprime_dvd_right ht
  have hsplit : ∀ d ∈ (m * n).divisors, Nat.gcd d m * Nat.gcd d n = d := by
    intro d hd
    rw [← Nat.Coprime.gcd_mul d h, Nat.gcd_eq_left (Nat.mem_divisors.mp hd).1]
  have hfst : ∀ x y : ℕ, x ∣ m → y ∣ n → Nat.gcd (x * y) m = x := fun x y hx hy => by
    rw [Nat.Coprime.gcd_mul_right_cancel x (hco (dvd_refl m) hy).symm, Nat.gcd_eq_left hx]
  have hsnd : ∀ x y : ℕ, x ∣ m → y ∣ n → Nat.gcd (x * y) n = y := fun x y hx hy => by
    rw [Nat.Coprime.gcd_mul_left_cancel y (hco hx (dvd_refl n)), Nat.gcd_eq_left hy]
  unfold ligozatCuspSum
  rw [Finset.sum_mul_sum, ← Finset.sum_product']
  refine Finset.sum_nbij' (fun d => (Nat.gcd d m, Nat.gcd d n)) (fun q => q.1 * q.2)
    ?_ ?_ ?_ ?_ ?_
  · intro d _
    exact Finset.mem_product.mpr
      ⟨Nat.mem_divisors.mpr ⟨Nat.gcd_dvd_right d m, hm⟩,
       Nat.mem_divisors.mpr ⟨Nat.gcd_dvd_right d n, hn⟩⟩
  · intro q hq
    obtain ⟨hq1, hq2⟩ := Finset.mem_product.mp hq
    exact Nat.mem_divisors.mpr
      ⟨mul_dvd_mul (Nat.mem_divisors.mp hq1).1 (Nat.mem_divisors.mp hq2).1,
       Nat.mul_ne_zero hm hn⟩
  · exact hsplit
  · intro q hq
    obtain ⟨hq1, hq2⟩ := Finset.mem_product.mp hq
    have hx := (Nat.mem_divisors.mp hq1).1
    have hy := (Nat.mem_divisors.mp hq2).1
    exact Prod.ext (hfst q.1 q.2 hx hy) (hsnd q.1 q.2 hx hy)
  · intro d hd
    have hdm : Nat.gcd d m ∣ m := Nat.gcd_dvd_right d m
    have hdn : Nat.gcd d n ∣ n := Nat.gcd_dvd_right d n
    conv_lhs => rw [← hsplit d hd]
    rw [gcd_div_mul_of_coprime h hdm hdn, gcd_mul_gcd_mul h hdm hdn ha hb,
      Nat.totient_mul (hco ((Nat.gcd_dvd_left _ _).trans hdm) ((Nat.gcd_dvd_left _ _).trans hdn))]
    push_cast
    rw [div_mul_div_comm]
    ring_nf

/-- **F3.1-A9, in `ligozatCuspSum` form.**  `Nat.recOnPosPrimePosCoprime` on `N`, with the
divisor `δ` universally quantified inside the motive: the `N = 0` case is vacuous because
`Nat.divisors 0 = ∅`, the prime-power case is `ligozatCuspSum_prime_pow`, and the coprime case
splits `δ` as `gcd(δ,a) · gcd(δ,b)` and combines `ligozatCuspSum_mul` with
`dedekindPsi_mul`. -/
theorem ligozatCuspSum_eq (N : ℕ) :
    ∀ δ ∈ N.divisors, ligozatCuspSum N δ = (δ : ℚ) * (dedekindPsi N : ℚ) / (N : ℚ) := by
  induction N using Nat.recOnPosPrimePosCoprime with
  | prime_pow p n hp hn =>
      intro δ hδ
      obtain ⟨j, hjn, rfl⟩ := (Nat.mem_divisors_prime_pow hp n).mp hδ
      rw [dedekindPsi_prime_pow hp hn]
      exact ligozatCuspSum_prime_pow hp hn hjn
  | zero => intro δ hδ; simp at hδ
  | one => intro δ hδ; simp [Nat.divisors_one] at hδ; subst hδ; simp [ligozatCuspSum, dedekindPsi]
  | coprime a b ha hb hab iha ihb =>
      intro δ hδ
      have ha0 : a ≠ 0 := by omega
      have hb0 : b ≠ 0 := by omega
      have hdvd : δ ∣ a * b := (Nat.mem_divisors.mp hδ).1
      have hxy : Nat.gcd δ a * Nat.gcd δ b = δ := by
        rw [← Nat.Coprime.gcd_mul δ hab, Nat.gcd_eq_left hdvd]
      have hxa : Nat.gcd δ a ∣ a := Nat.gcd_dvd_right δ a
      have hyb : Nat.gcd δ b ∣ b := Nat.gcd_dvd_right δ b
      rw [← hxy, ligozatCuspSum_mul ha0 hb0 hab hxa hyb,
        iha _ (Nat.mem_divisors.mpr ⟨hxa, ha0⟩), ihb _ (Nat.mem_divisors.mpr ⟨hyb, hb0⟩),
        dedekindPsi_mul hab]
      push_cast
      rw [div_mul_div_comm]
      ring_nf

/-- **F3.1-A9.**  For every `N ≠ 0` and every divisor `δ` of `N`,

  `Σ_{d ∣ N} φ(gcd(d, N/d)) · gcd(d,δ)² / (gcd(d, N/d) · d) = δ · ψ(N) / N`.

This is `ligozatCuspSum_eq` with the definition unfolded.  The hypothesis `N ≠ 0` is stated for
the reader; it is not used, because `δ ∈ N.divisors` already forces `N ≠ 0`. -/
theorem sum_totient_gcd_sq_div (N : ℕ) (_hN : N ≠ 0) {δ : ℕ} (hδ : δ ∈ N.divisors) :
    ∑ d ∈ N.divisors,
        (Nat.totient (Nat.gcd d (N / d)) : ℚ) * (Nat.gcd d δ : ℚ) ^ 2
          / ((Nat.gcd d (N / d) : ℚ) * (d : ℚ))
      = (δ : ℚ) * (dedekindPsi N : ℚ) / (N : ℚ) :=
  ligozatCuspSum_eq N δ hδ

section A9Guards

/-- A kernel-checked instance of the F3.1-A9 *statement*, independent of its proof:
at `N = 12`, `δ = 4` the divisor sum is `1 + 1 + 1/3 + 4 + 1/3 + 4/3 = 8`, and the right-hand
side is `4 · ψ(12) / 12 = 4 · 24 / 12 = 8`. -/
example : ∑ d ∈ (12 : ℕ).divisors,
    (Nat.totient (Nat.gcd d (12 / d)) : ℚ) * (Nat.gcd d 4 : ℚ) ^ 2
      / ((Nat.gcd d (12 / d) : ℚ) * (d : ℚ)) = 8 := by
  rw [show (12 : ℕ).divisors = {1, 2, 3, 4, 6, 12} from by decide]
  norm_num (config := { decide := true }) [Finset.sum_insert, Finset.mem_insert,
    Finset.mem_singleton, Finset.sum_singleton,
    show Nat.gcd 2 6 = 2 from rfl, show Nat.gcd 2 4 = 2 from rfl,
    show Nat.gcd 3 4 = 1 from rfl, show Nat.gcd 4 3 = 1 from rfl,
    show Nat.gcd 6 2 = 2 from rfl, show Nat.gcd 6 4 = 2 from rfl,
    show Nat.gcd 12 4 = 4 from rfl, show Nat.totient 2 = 1 from rfl]

-- The right-hand side at `(N, δ) = (12, 4)`: `4 · ψ(12) / 12 = 8`.
#guard 4 * dedekindPsi 12 / 12 = 8

end A9Guards

/-! ### F3.1-A10 — the valence identity for eta quotients, as pure arithmetic

`Σ_{d ∣ N} φ(gcd(d, N/d)) · ord(N, r, d) = k · ψ(N) / 12`,  where `k = (1/2) Σ_δ r_δ`.

Like every other statement in this file this is arithmetic: `ℕ`, `ℚ`, `Nat.divisors`,
`Nat.totient`, `Nat.gcd`.  The classical reading — that the left side is the total degree of the
divisor of `∏_{δ ∣ N} η(δz)^{r_δ}` on `Γ₀(N)`, each cusp of denominator `d` occurring
`φ(gcd(d, N/d))` times, and the right side is `k · [SL(2,ℤ) : Γ₀(N)] / 12` — is a reading, for
the same reason as in A8 and A9: nothing here mentions `η`, `Γ₀(N)`, cusps or vanishing orders,
and Mathlib supplies none of them.
-/

/-- **F3.1-A10 — the valence identity for eta quotients, as an identity of rational numbers.**
For every `N ≠ 0` and every exponent vector `r`,

  `Σ_{d ∣ N} φ(gcd(d, N/d)) · etaQuotientCuspOrder N r d
      = etaQuotientWeight N r · ψ(N) / 12`.

**What is proved.**  An identity of rational numbers, assembled from `Nat.divisors`,
`Nat.totient`, `Nat.gcd`, `etaQuotientCuspOrder` (F3.1-A2) and `dedekindPsi` (F3.1-A8).  It is
A1 for exactly that, and it inherits A2's transcription status for the reading "the left side
sums the orders of vanishing of an eta quotient over the cusps of `Γ₀(N)`".

**Scope, stated so it cannot be over-read.**  This is *not* the analytic valence theorem.  It
does not assert that `etaQuotientCuspOrder` is an order of vanishing, that `numCusps` counts
cusps, or that `dedekindPsi N = [SL(2,ℤ) : Γ₀(N)]`; none of those three are proved anywhere in
this development, and the last two are impossible to state in Mathlib as it stands.  What the
identity does do is exhibit the *numerical prediction* the analytic valence theorem makes as a
theorem of arithmetic, which is an independent check on the transcription of A2: a formula that
failed it could not be a cusp-order formula for a weight-`k` form on `Γ₀(N)`.

**No hypothesis on `r`.**  The identity holds for *every* `r : ℕ → ℤ`, including exponent
vectors violating both Ligozat congruences and vectors supported off `N.divisors` (which the
summation range ignores, by `EtaExp.sum_divisors_congr`).  That is expected: the valence identity
is a degree count, insensitive to whether the eta quotient is actually modular on `Γ₀(N)`.

**Proof.**  Three steps, all bookkeeping on top of F3.1-A9.  Expand `etaQuotientCuspOrder` and
regroup each summand so that the `δ`-dependent factor `(N/24)(r_δ/δ)` is separated from the
`d`-dependent factor `φ(gcd(d,N/d)) · gcd(d,δ)² / (gcd(d,N/d) · d)`; swap the two sums with
`Finset.sum_comm`; apply `sum_totient_gcd_sq_div` to the inner `d`-sum, which returns
`δ · ψ(N) / N`.  The `δ` and the `N` then cancel — legitimately, since `δ ∈ N.divisors` and
`N ≠ 0` give `(δ : ℚ) ≠ 0` and `(N : ℚ) ≠ 0` — leaving `Σ_δ r_δ · ψ(N) / 24`, which is
`etaQuotientWeight N r · ψ(N) / 12`.  This is where `hN` is used. -/
theorem sum_etaQuotientCuspOrder (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    ∑ d ∈ N.divisors, (Nat.totient (Nat.gcd d (N / d)) : ℚ) * etaQuotientCuspOrder N r d
      = etaQuotientWeight N r * (dedekindPsi N : ℚ) / 12 := by
  have hNQ : (N : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hN
  -- Step 1: expand the cusp order and split each summand into a `δ`-part and a `d`-part.
  have step1 : ∀ d ∈ N.divisors,
      (Nat.totient (Nat.gcd d (N / d)) : ℚ) * etaQuotientCuspOrder N r d
        = ∑ δ ∈ N.divisors,
            ((N : ℚ) / 24 * ((r δ : ℚ) / (δ : ℚ)))
              * ((Nat.totient (Nat.gcd d (N / d)) : ℚ) * (Nat.gcd d δ : ℚ) ^ 2
                  / ((Nat.gcd d (N / d) : ℚ) * (d : ℚ))) := by
    intro d _
    rw [etaQuotientCuspOrder, Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun δ _ => ?_
    ring
  rw [Finset.sum_congr rfl step1, Finset.sum_comm]
  -- Step 2: the inner `d`-sum is F3.1-A9, and the `δ`/`N` factors cancel.
  have step2 : ∀ δ ∈ N.divisors,
      (∑ d ∈ N.divisors,
        ((N : ℚ) / 24 * ((r δ : ℚ) / (δ : ℚ)))
          * ((Nat.totient (Nat.gcd d (N / d)) : ℚ) * (Nat.gcd d δ : ℚ) ^ 2
              / ((Nat.gcd d (N / d) : ℚ) * (d : ℚ))))
        = (r δ : ℚ) * (dedekindPsi N : ℚ) / 24 := by
    intro δ hδ
    have hδQ : (δ : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.pos_of_mem_divisors hδ).ne'
    rw [← Finset.mul_sum, sum_totient_gcd_sq_div N hN hδ]
    have hcancel : (N : ℚ) / 24 * ((r δ : ℚ) / (δ : ℚ))
          * ((δ : ℚ) * (dedekindPsi N : ℚ) / (N : ℚ))
        = ((N : ℚ) / (N : ℚ)) * (((δ : ℚ) / (δ : ℚ))
            * ((r δ : ℚ) * (dedekindPsi N : ℚ) / 24)) := by
      ring
    rw [hcancel, div_self hNQ, div_self hδQ, one_mul, one_mul]
  -- Step 3: collect the surviving `Σ_δ r_δ` into the weight.
  rw [Finset.sum_congr rfl step2, etaQuotientWeight, ← Finset.sum_div, ← Finset.sum_mul]
  ring

section A10Guards

/-- Test vector at level `16`: `η(z)⁴ η(2z)⁻² η(16z)⁶`, weight `4`.  The cusp `d = 4` has
`gcd(4, 16/4) = 4` and multiplicity `φ(4) = 2`. -/
private def rTest₁₆ : EtaExp := fun δ => if δ = 1 then 4 else if δ = 2 then -2 else
  if δ = 16 then 6 else 0

/-- Test vector at level `36`: `η(z)² η(6z)⁻³ η(36z)⁵`, weight `2`.  Three of the nine cusps
(`d = 3, 6, 12`) have multiplicity `2`. -/
private def rTest₃₆ : EtaExp := fun δ => if δ = 1 then 2 else if δ = 6 then -3 else
  if δ = 36 then 5 else 0

-- A kernel-decided instance of the F3.1-A10 *statement*, independent of its proof, at a level
-- where the multiplicity `φ(gcd(d, N/d))` is not identically `1`: at `N = 16` the cusp `d = 4`
-- is counted twice, and the weighted sum of orders is
-- `9/4 + 1/4 + 2·(1/4) + 1 + 4 = 8 = 4 · 24 / 12`.  A transcription of `etaQuotientCuspOrder`
-- that dropped the `gcd(d, N/d)` factor fails this.
#guard (∑ d ∈ (16 : ℕ).divisors,
    (Nat.totient (Nat.gcd d (16 / d)) : ℚ) * etaQuotientCuspOrder 16 rTest₁₆ d)
  = etaQuotientWeight 16 rTest₁₆ * (dedekindPsi 16 : ℚ) / 12

-- The same statement at `N = 36`, whose nine cusps include three of multiplicity `2`:
-- both sides are `12 = 2 · 72 / 12`.
#guard (∑ d ∈ (36 : ℕ).divisors,
    (Nat.totient (Nat.gcd d (36 / d)) : ℚ) * etaQuotientCuspOrder 36 rTest₃₆ d)
  = etaQuotientWeight 36 rTest₃₆ * (dedekindPsi 36 : ℚ) / 12

-- The two sides separately, so that a guard passing by both sides being wrong is excluded.
#guard (∑ d ∈ (16 : ℕ).divisors,
    (Nat.totient (Nat.gcd d (16 / d)) : ℚ) * etaQuotientCuspOrder 16 rTest₁₆ d) = 8
#guard etaQuotientWeight 16 rTest₁₆ = 4
#guard dedekindPsi 16 = 24
#guard (∑ d ∈ (36 : ℕ).divisors,
    (Nat.totient (Nat.gcd d (36 / d)) : ℚ) * etaQuotientCuspOrder 36 rTest₃₆ d) = 12
#guard etaQuotientWeight 36 rTest₃₆ = 2
#guard dedekindPsi 36 = 72

end A10Guards

/-! ### F3.1-B10 (arithmetic half) — the level-`1` discriminant vector pins the weight and the
cusp-order layers

`N = 1`, `r₁ = 24` is the one exponent vector whose eta quotient is an object MATHLIB already
owns: `∏_{δ ∣ 1} η(δz)^{24} = η(z)^{24} = Δ(z)`.  Two classical facts about `Δ` therefore become
constraints on the definitions of this file, and neither is derivable from them:

* `Δ` has **weight `12`**, so `etaQuotientWeight 1 (fun _ => 24)` must be `12`;
* `Δ` vanishes to **order `1`** at the unique cusp of `SL(2,ℤ)`, so
  `etaQuotientCuspOrder 1 (fun _ => 24) 1` must be `1`.

Both are stated here as THEOREMS, not `#guard`s.  The order value is also guarded above at `A2`
strength (`#guard etaQuotientCuspOrder 1 (fun _ => 24) 1 = 1`), and the difference is not
rhetorical: a theorem carries a proof term that `#print axioms` inspects and that `FinalCheck`
can pin, a `#guard` carries none.

The third pin — that the eta quotient AT this vector really is `ModularForm.discriminant` —
needs `η`, so it lives in `SocrateAI.ModularForms.EtaQuotientModularity`
(`etaQuotient_one_eq_discriminant`).  Keeping it out of this file is what preserves the
`Nat.divisors` + `Nat.totient` import cone described at the top.

`sum_etaQuotientCuspOrder_one_24` closes the loop: the `N = 1` instance of the valence identity
`F3.1-A10` reads `1 = 12 · ψ(1) / 12`, i.e. the total divisor degree of `Δ` on `SL(2,ℤ)` is `1`.
That is the classical fact the two pins above were read off from, so a transcription error in
`etaQuotientCuspOrder`, in `etaQuotientWeight` or in `dedekindPsi` that happened to cancel in
`sum_etaQuotientCuspOrder` cannot survive all three statements at once. -/

/-- `ψ(1) = 1`: the empty product over `(1 : ℕ).primeFactors`, times `1 / 1`.  The theorem form
of the `A8` guard `#guard dedekindPsi 1 = 1`, needed by `sum_etaQuotientCuspOrder_one_24`. -/
theorem dedekindPsi_one : dedekindPsi 1 = 1 := by
  simp [dedekindPsi]

/-- **F3.1-B10, weight layer.**  `Δ = η²⁴` has weight `12`, and `(1/2) · 24 = 12`.  A definition
that had lost the factor `1/2`, or that summed over `Nat.properDivisors` (empty at `N = 1`, so
the weight would be `0`), fails here. -/
theorem etaQuotientWeight_one_24 : etaQuotientWeight 1 (fun _ => (24 : ℤ)) = 12 := by
  norm_num [etaQuotientWeight, Nat.divisors_one]

/-- **F3.1-B10, cusp-order layer.**  `Δ` vanishes to order `1` at `∞`, and at `N = d = δ = 1` the
transcribed formula gives `(1/24) · (1² · 24) / (1 · 1 · 1) = 1`.  This is the `A1` form of the
`A2` guard recorded with the other sanity values above. -/
theorem etaQuotientCuspOrder_one_24 : etaQuotientCuspOrder 1 (fun _ => (24 : ℤ)) 1 = 1 := by
  norm_num [etaQuotientCuspOrder, Nat.divisors_one]

/-- **F3.1-B10, the two layers cross-checked against `F3.1-A10`.**  The valence identity at
`N = 1` says the weighted sum of cusp orders is `k · ψ(N) / 12`; here that is `12 · 1 / 12 = 1`,
the classical divisor degree of `Δ`.  The left-hand side is computed from
`etaQuotientCuspOrder`, the right-hand side from `etaQuotientWeight` and `dedekindPsi`, so the
equation ties all three definitions to one externally known number. -/
theorem sum_etaQuotientCuspOrder_one_24 :
    ∑ d ∈ (1 : ℕ).divisors,
        (Nat.totient (Nat.gcd d (1 / d)) : ℚ) * etaQuotientCuspOrder 1 (fun _ => (24 : ℤ)) d
      = 1 := by
  rw [sum_etaQuotientCuspOrder 1 one_ne_zero, etaQuotientWeight_one_24, dedekindPsi_one]
  norm_num

/-! ### F3.2-C2 (arithmetic half) — the UN-NORMALISED Ligozat order, and the cusp width

Ligozat's `etaQuotientCuspOrder N r d` (F3.1-A2, above) is the order of vanishing measured in the
LOCAL uniformiser `q_h = e^{2πiz/h}` at the cusp of denominator `d`, where `h = N / gcd(d², N)` is
the width of that cusp for `Γ₀(N)`.  The analytic node `F3.2-C2` measures decay in `Im z`
DIRECTLY, and the exponent that governs `|f ∣ γ|` there is Ligozat's number DIVIDED by `h`:

    ordRaw(N, r, c) = (1/24) Σ_{δ ∣ N} gcd(c, δ)² r_δ / δ,
    etaQuotientCuspOrder N r d = h · ordRaw(N, r, d),   h = N / gcd(d², N).

Read that second line before citing either number: `exp(-2π · ordRaw · Im z)` and
`exp(-2π · ord_Ligozat · Im z)` are DIFFERENT functions whenever `h ≠ 1`, and it is the first one
that `F3.2-C2` proves.  What is unaffected is Ligozat's condition (iii): `h > 0`, so
`ordRaw ≥ 0 ↔ ord_Ligozat ≥ 0` (`etaQuotientRawOrder_nonneg_iff`).

Everything in this block is arithmetic in `ℚ`: no `η`, no `ℍ`, no modular form.  The analytic
theorem that consumes it is `SocrateAI.ModularForms.etaQuotient_cusp_order`, in
`SocrateAI.ModularForms.EtaQuotientCuspTheta`. -/

/-- The **un-normalised** (width-free) Ligozat order at a cusp whose representing matrix has
lower-left entry `c`:  `ordRaw(N, r, c) = (1/24) Σ_{δ ∣ N} gcd(c, δ)² r_δ / δ`.

This is a DEFINITION, exactly like `etaQuotientCuspOrder`.  What makes it an order of vanishing
is the analytic theorem `etaQuotient_cusp_order` (F3.2-C2), which proves
`‖(f ∣[k] γ)(z)‖ =Θ exp(-2π · ordRaw(N, r, γ₁₀) · Im z)` at `i∞`. -/
def etaQuotientRawOrder (N : ℕ) (r : EtaExp) (c : ℤ) : ℚ :=
  (∑ δ ∈ N.divisors, ((Int.gcd c (δ : ℤ) : ℚ) ^ 2 * (r δ : ℚ)) / (δ : ℚ)) / 24

/-- `gcd(d², N) = d · gcd(d, N/d)` for `d ∣ N`.  The two classical spellings of the denominator
of the cusp width agree; `Nat.gcd_mul_left` after writing `N = d·m`. -/
theorem gcd_sq_eq_mul {N d : ℕ} (hd : d ∣ N) :
    Nat.gcd (d ^ 2) N = d * Nat.gcd d (N / d) := by
  obtain ⟨m, rfl⟩ := hd
  rcases Nat.eq_zero_or_pos d with rfl | hd0
  · simp
  · rw [Nat.mul_div_cancel_left _ hd0, pow_two, Nat.gcd_mul_left]

/-- **The width bridge.**  For `d ∣ N`,

  `etaQuotientCuspOrder N r d = (N / gcd(d², N)) · etaQuotientRawOrder N r d`,

i.e. Ligozat's cusp order is the width `h = N / gcd(d², N)` times the un-normalised order.  Pure
`ℚ`-algebra: the constant `N / (d · gcd(d, N/d))` comes out of the divisor sum. -/
theorem etaQuotientCuspOrder_eq_width_mul_raw {N d : ℕ} (hd : d ∣ N) (r : EtaExp) :
    etaQuotientCuspOrder N r d
      = ((N : ℚ) / (Nat.gcd (d ^ 2) N : ℚ)) * etaQuotientRawOrder N r (d : ℤ) := by
  rw [etaQuotientCuspOrder, etaQuotientRawOrder, gcd_sq_eq_mul hd]
  rw [Finset.mul_sum, Finset.sum_div, Finset.mul_sum]
  refine Finset.sum_congr rfl fun δ _ => ?_
  rw [show Int.gcd (d : ℤ) (δ : ℤ) = Nat.gcd d δ from Int.gcd_natCast_natCast d δ]
  push_cast
  ring

/-- **Ligozat's condition (iii) is insensitive to the width normalisation.**  Since the width
`N / gcd(d², N)` is a positive rational, `ordRaw ≥ 0` at a cusp iff Ligozat's `ord ≥ 0` there. -/
theorem etaQuotientRawOrder_nonneg_iff {N d : ℕ} (hN : N ≠ 0) (hd : d ∣ N) (r : EtaExp) :
    0 ≤ etaQuotientRawOrder N r (d : ℤ) ↔ 0 ≤ etaQuotientCuspOrder N r d := by
  have hg : 0 < Nat.gcd (d ^ 2) N := Nat.gcd_pos_of_pos_right _ (Nat.pos_of_ne_zero hN)
  have hw : (0 : ℚ) < (N : ℚ) / (Nat.gcd (d ^ 2) N : ℚ) := by
    have h1 : (0 : ℚ) < (N : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero hN
    have h2 : (0 : ℚ) < (Nat.gcd (d ^ 2) N : ℚ) := by exact_mod_cast hg
    exact div_pos h1 h2
  rw [etaQuotientCuspOrder_eq_width_mul_raw hd r]
  exact (mul_nonneg_iff_of_pos_left hw).symm

/-- **LL-1 pin, cusp `∞`.**  At `c = 0` — the lower-left entry of the identity matrix, i.e. the
cusp `∞`, whose width for `Γ₀(N)` is `1` — the un-normalised order is Ligozat's own `ord_∞`:
`gcd(0, δ) = δ`, so `(1/24) Σ δ² r_δ/δ = (1/24) Σ δ r_δ = etaQuotientCuspOrder N r N`. -/
theorem etaQuotientRawOrder_infty (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    etaQuotientRawOrder N r 0 = etaQuotientCuspOrder N r N := by
  rw [etaQuotientCuspOrder_infty N hN r, etaQuotientRawOrder]
  congr 1
  refine Finset.sum_congr rfl fun δ hδ => ?_
  have hδ0 : 0 < δ := Nat.pos_of_mem_divisors hδ
  have hδQ : ((δ : ℚ)) ≠ 0 := by
    have h : (0 : ℚ) < (δ : ℚ) := by exact_mod_cast hδ0
    exact h.ne'
  rw [show Int.gcd 0 (δ : ℤ) = δ by simp, div_eq_iff hδQ]
  ring

/-- **LL-1 pin, the discriminant.**  At `N = 1`, `r ≡ 24` (so `f = Δ`) the un-normalised order is
`1` at EVERY cusp — there is only one — matching the classical `ord(Δ) = 1`. -/
theorem etaQuotientRawOrder_one_24 (c : ℤ) :
    etaQuotientRawOrder 1 (fun _ => (24 : ℤ)) c = 1 := by
  rw [etaQuotientRawOrder]
  simp

/-! #### F3.2-C2 (arithmetic half) — a hand-computed numeric pin

`N = 2`, `r_1 = r_2 = 12`, i.e. `f = (η(z)·η(2z))^12`, weight `k = 12`.  By hand, using
`η(-1/z) = √(z/i)·η(z)` and `η(-2/z) = √((z/2)/i)·η(z/2)`:

    |f ∣[12] S (z)| = 2^{-6}·|η(z)|^12·|η(z/2)|^12 ≍ exp(-πy)·exp(-πy/2) = exp(-2π·(3/4)·y),

so the un-normalised order at the cusp `0` (`c = 1`) must be `3/4`; Ligozat's own order there is
`3/2` and the width of the cusp `0` for `Γ₀(2)` is `N/gcd(1,N) = 2`, and indeed `3/2 = 2·(3/4)`.
At `∞` (`c = 0`) the width is `1` and both numbers are `3/2 = (1·12 + 2·12)/24`.

Every number in this theorem was computed on paper BEFORE the definitions were evaluated; it is
the check that `gcd(c,δ)²`, the `1/24` and the width factor are not transcription errors. -/
theorem rawOrder_level_two_twelve_pin :
    etaQuotientRawOrder 2 (fun δ => if δ = 1 then 12 else if δ = 2 then 12 else 0) 1 = 3 / 4
      ∧ etaQuotientRawOrder 2 (fun δ => if δ = 1 then 12 else if δ = 2 then 12 else 0) 0 = 3 / 2
      ∧ etaQuotientCuspOrder 2 (fun δ => if δ = 1 then 12 else if δ = 2 then 12 else 0) 1 = 3 / 2
      ∧ etaQuotientCuspOrder 2 (fun δ => if δ = 1 then 12 else if δ = 2 then 12 else 0) 2 = 3 / 2
      ∧ (2 : ℚ) / (Nat.gcd (1 ^ 2) 2 : ℚ) = 2
      ∧ (2 : ℚ) / (Nat.gcd (2 ^ 2) 2 : ℚ) = 1 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    norm_num [etaQuotientRawOrder, etaQuotientCuspOrder,
      show (2 : ℕ).divisors = {1, 2} from rfl, show Nat.gcd 4 2 = 2 from rfl]


end SocrateAI.ModularForms
