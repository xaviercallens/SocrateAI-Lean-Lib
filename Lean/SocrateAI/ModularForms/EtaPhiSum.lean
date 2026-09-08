/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.
-/
import SocrateAI.ModularForms.EtaMultiplier

/-!
# DRK-09 — the eta-quotient multiplier as a single Dedekind-sum exponential

For `γ = !![a,b;c,d] ∈ Γ₀(N)` with `c > 0` and an exponent vector `r : EtaExp` of even total
weight (`Σ_{δ ∣ N} r δ = 2k`), this file evaluates the multiplier `w(γ)` of
`f = ∏_{δ ∣ N} η(δ·)^{r δ}` **in closed form**:

  `w(γ) = (-i)^k · exp(π i / 12 · Φ_N(r, γ))`,
  `Φ_N(r, γ) = Σ_{δ ∣ N} r δ · ( (a+d)·δ/c − 12·s(d, c/δ) )`.

## What this is, mathematically

Run 3 produced `etaMultiplierVal` — the multiplier EXISTS, is `z`-independent, is a character
and satisfies `w(γ)²⁴ = 1` — but nothing that says what number it is for a general `γ`.  That is
`F3.2-OBSTRUCTED`.  DRK-06 (`eta_smul_eq_exp_rademacherPhi`) evaluates the multiplier of a
SINGLE `η`; the content here is the passage from one `η` to the eta QUOTIENT, which needs three
things run 3 built and one thing DRK-06 built:

* `divisorConj` / `divisor_smul_comm_explicit` (F3.2-A3): `δ·(γz) = γ_δ·(δz)` with
  `γ_δ = !![a, bδ; c/δ, d] ∈ SL(2,ℤ)`, and `denom γ_δ (δz) = denom γ z` — the SAME automorphy
  denominator for every `δ`, which is what lets the `√` factors collect;
* DRK-06 applied to `γ_δ`, contributing `Φ(γ_δ) = (a+d)δ/c − 12·s(d, c/δ)`, which is
  character-for-character the `δ`-summand of `etaPhiSum` (`rademacherPhi_divisorConj` below);
* `csqrt_zpow_two_mul` (F3.2-A7): `(√x)^{2k} = x^k` for INTEGER `k`, which is where `hk` earns
  its keep and where the `(-i)^k` prefactor is born, from `x = -i·(cz+d)`.

## HONESTY (LL-1), read before quoting anything here

1. **This does NOT delete `F3.2-OBSTRUCTED`.**  It REPLACES the generation hypothesis `hgen` of
   `multiplier_trivial_of_congr` with an explicit Dedekind-sum evaluation.  Still open, and NOT
   claimed here:
   * `c ≤ 0`.  `c < 0` reduces by DRK-08 (`etaMultiplierVal_neg` +
     `exists_pos_lower_left_or_T_zpow`); `c = 0` is `γ = ±T^n` and is **genuinely not covered**
     — the negative control `etaMultiplierVal_c_zero_formula_fails` below records that the literal
     formula is FALSE at `c = 0` (it returns `(-i)^k` where the truth is `1`).
   * The ARITHMETIC `24 ∣ etaPhiSum N r γ` from Ligozat's congruences.  That is the actual hard
     node and it is not attempted here.  Upstream FLT proves only the two-divisor prime-level
     version of it.
2. **Scope.** `hk : Σ r δ = 2k` restricts to INTEGRAL weight.  Half-integral weight is excluded,
   which is forced by `etaMultiplierVal`'s own signature and is right for Ligozat, but it is a
   scope limit, not a theorem.
3. **`etaPhiSum` is a total `def` using `Int.ediv`.**  Off `Γ₀(N)` (i.e. when `δ ∤ c`) the
   quotient `γ 1 0 / (δ : ℤ)` silently rounds and the value is meaningless.  Every consumer must
   carry `hγ`.  It is pinned at fifteen explicit `(N, r, γ)` by `decide +kernel` below so the
   definition is anchored the way `DedekindSum.lean` anchors `dedekindSum`.
4. **Deviation from the node text, stated loudly.**  The node wrote `noncomputable def
   etaPhiSum`.  It is written here as a plain `def`, because it *is* computable and because the
   fifteen `decide +kernel` pins and the four kernel negative controls — the whole sign-discipline
   gate of this file — are impossible otherwise.  No mathematical change.
5. **`etaPhiSum_eq` needs neither `hγ` nor `hc`.**  The node carried both.  They are unused: the
   identity is `Finset.mul_sum` + `Finset.sum_sub_distrib` and holds unconditionally, including
   at `c = 0` where Lean's `x/0 = 0` makes both sides `0`.  The unconditional
   `etaPhiSum_eq_unconditional` is proved first and the node's exact phrasing is derived from it,
   so the node statement is landed verbatim AND the strictly stronger fact is available for the
   `c ≤ 0` assembly, which is where the rewrite is actually wanted.

## PROVENANCE — INDEPENDENT statement, but a counterpart EXISTS upstream (correction)

The DRK-09 node was filed as provenance "independent" with `statement_nl` saying "No FLT
counterpart".  **That sentence is false and is retracted here.**  `anthropics/fermats-last-theorem`
contains, in `P2M/Sol/S_ModularCurve_sharpUnitInvariant.lean`, namespace `DedekindEtaLaw`, a
definition `phi γ = (a+d)/c.toNat − 12·dedekindSum d c.toNat` and a lemma whose content is
`phi γ − phi γ'` for `γ' = γ_ℓ` — that is exactly `etaPhiSum` in the two-divisor case
`N = ℓ` prime, `r = (m, −m)`, `k = 0`.  `ModularForm.etaProductEleven_transform` is a further
`N = 11` instance.  See `ATTRIBUTION.md` §DRK-09.

**No text, tactic or proof strategy from FLT is used in this file**, and none of the FLT solution
files were read.  The route here is our own: DRK-06 applied factorwise through run 3's
`divisorConj`, with the `√` bookkeeping of F3.2-A7.  It is a genuine generalisation — arbitrary
`N`, arbitrary `r`, arbitrary integer weight `k`; the weight-`0` case FLT treats never performs
the `(√x)^{2k} = (-i)^k(cz+d)^k` collection that is the new content here.  Accordingly
`ATTRIBUTION.md` records this file as **independently re-derived, NOT a port**, while correcting
the "no counterpart" claim.
-/

set_option autoImplicit false

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm Complex
open UpperHalfPlane hiding I
open scoped MatrixGroups Real
open SocrateAI.NumberTheory

/-! ## DRK-09, part 0 — the definition -/

/-- **`Φ_N(r, γ) = Σ_{δ ∣ N} r_δ · ( (a+d)·δ/c − 12·s(d, c/δ) )`.**

The `δ`-summand is `Φ(γ_δ)`, Apostol's `Φ` (LL-22: **not** the Rademacher symbol `Ψ`) evaluated
at the conjugated matrix `γ_δ = !![a, bδ; c/δ, d]` of `divisorConj` — see
`rademacherPhi_divisorConj`.

`γ 1 0 / (δ : ℤ)` is `Int.ediv`.  It is the honest quotient exactly when `δ ∣ c`, which holds
for `γ ∈ Γ₀(N)` and `δ ∣ N` (`dvd_lower_left_of_mem_Gamma0`); off that hypothesis this
definition is meaningless (honesty note 3 in the file header). -/
def etaPhiSum (N : ℕ) (r : EtaExp) (γ : SL(2, ℤ)) : ℚ :=
  ∑ δ ∈ N.divisors,
    (r δ : ℚ) * (((γ 0 0 + γ 1 1 : ℤ) : ℚ) * (δ : ℚ) / ((γ 1 0 : ℤ) : ℚ)
                 - 12 * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat))

/-! ## DRK-09, part 1 — SIGN-DISCIPLINE GATE

Nothing below this section may be used before it.  Every pin is a **kernel evaluation** of
`etaPhiSum`, `dedekindSum` and `slOf`, and of nothing else: not one general lemma about
`etaPhiSum` has been stated yet, so no pin can be discharged by the theory it is meant to guard.

Every value was computed independently in Python (`fractions.Fraction`, a re-implementation of
`((x))` and `s(h,k)` from the mathematical definition, first checked against all nine of
`DedekindSum.lean`'s own `decide +kernel` pins) **before** it was written here.  The eleven
`(N, r, γ)` of the first block were additionally checked against a 4000-term `η`-product
evaluation of `w(γ) = f(γi)/((ci+d)^k f(i))`; worst relative error `3.3e-14`, and the sweep
includes odd `k` (`N = 12`, `k = 1`, `w = e^{5πi/12}`) and non-real `w` (`N = 7`, `w = i`;
`N = 13`, `w = e^{-2πi/3}`), so it is not a sweep over trivial multipliers.

As in `DedekindSum.lean` and `RademacherPhi.lean`, plain `decide` does not discharge these (the
kernel gets stuck on `Rat.num` of a `Finset` fold); `decide +kernel` does. -/

section SignDisciplineGate

/-- `!![1,0;4,1] ∈ Γ₀(4)`, `c = 4`. -/
def drk09MatC4 : SL(2, ℤ) := slOf 1 0 4 1 (by decide)
/-- `!![3,1;8,3] ∈ Γ₀(4)`, `c = 8` (a second, non-parabolic matrix at the same level). -/
def drk09MatC8 : SL(2, ℤ) := slOf 3 1 8 3 (by decide)
/-- `!![1,0;2,1] ∈ Γ₀(2)`. -/
def drk09MatC2 : SL(2, ℤ) := slOf 1 0 2 1 (by decide)
/-- `!![1,0;6,1] ∈ Γ₀(6)`. -/
def drk09MatC6 : SL(2, ℤ) := slOf 1 0 6 1 (by decide)
/-- `!![5,4;6,5] ∈ Γ₀(6)` — same level, different `γ`; the pin pair `C6`/`C6b` is what shows
`etaPhiSum` is not constant in `γ`. -/
def drk09MatC6b : SL(2, ℤ) := slOf 5 4 6 5 (by decide)
/-- `!![5,2;12,5] ∈ Γ₀(12)`.  This is the strongest pin in the file: `etaPhiSum = 11`, an ODD
value not divisible by `24`, at ODD weight `k = 1`. -/
def drk09MatC12 : SL(2, ℤ) := slOf 5 2 12 5 (by decide)
/-- `!![2,1;5,3] ∈ Γ₀(5)`. -/
def drk09MatC5 : SL(2, ℤ) := slOf 2 1 5 3 (by decide)
/-- `!![5,3;13,8] ∈ Γ₀(13)`. -/
def drk09MatC13 : SL(2, ℤ) := slOf 5 3 13 8 (by decide)
/-- `!![3,2;7,5] ∈ Γ₀(7)`. -/
def drk09MatC7 : SL(2, ℤ) := slOf 3 2 7 5 (by decide)
/-- `!![3,1;11,4] ∈ Γ₀(11)` — the level run 3 could not reach at all. -/
def drk09MatC11 : SL(2, ℤ) := slOf 3 1 11 4 (by decide)
/-- `!![2,1;9,5] ∈ Γ₀(9)` — a non-squarefree, non-prime level with three divisors. -/
def drk09MatC9 : SL(2, ℤ) := slOf 2 1 9 5 (by decide)

/-- `r = (8, -8, 8)` on `N = 4`; `Σ r = 8 = 2·4`. -/
def drk09R4 : EtaExp := fun d => if d = 1 then 8 else if d = 2 then -8 else if d = 4 then 8 else 0
/-- `r = (24, -24)` on `N = 2`; `Σ r = 0`, weight `k = 0`. -/
def drk09R2 : EtaExp := fun d => if d = 1 then 24 else if d = 2 then -24 else 0
/-- `r = (1,1,1,1)` on `N = 6`; `Σ r = 4`, weight `k = 2`. -/
def drk09R6 : EtaExp :=
  fun d => if d = 1 then 1 else if d = 2 then 1 else if d = 3 then 1 else if d = 6 then 1 else 0
/-- `r = (2,-1,0,1,-2,2)` on `N = 12`; `Σ r = 2`, ODD weight `k = 1`. -/
def drk09R12 : EtaExp :=
  fun d => if d = 1 then 2 else if d = 2 then -1 else if d = 4 then 1 else
           if d = 6 then -2 else if d = 12 then 2 else 0
/-- `r = (6, -6)` on `N = 5`; weight `k = 0`. -/
def drk09R5 : EtaExp := fun d => if d = 1 then 6 else if d = 5 then -6 else 0
/-- `r = (2, 2)` on `N = 13`; weight `k = 2`. -/
def drk09R13 : EtaExp := fun d => if d = 1 then 2 else if d = 13 then 2 else 0
/-- `r = (3, -3)` on `N = 7`; weight `k = 0`, and the multiplier there is `i`. -/
def drk09R7 : EtaExp := fun d => if d = 1 then 3 else if d = 7 then -3 else 0
/-- `r = (2, 2)` on `N = 11`; weight `k = 2`. -/
def drk09R11 : EtaExp := fun d => if d = 1 then 2 else if d = 11 then 2 else 0
/-- `r = (3, 0, 3)` on `N = 9`; weight `k = 3`. -/
def drk09R9 : EtaExp := fun d => if d = 1 then 3 else if d = 9 then 3 else 0
/-- Single-divisor probe on `N = 6`: `etaPhiSum` collapses to `Φ(γ)` itself. -/
def drk09R6a : EtaExp := fun d => if d = 1 then 1 else 0
/-- Two-divisor probe on `N = 12` skipping `δ = 2, 3, 6, 12` — an ODD, non-multiple-of-24 value. -/
def drk09R12b : EtaExp := fun d => if d = 1 then 1 else if d = 4 then -1 else 0
/-- Two-divisor probe on `N = 5`. -/
def drk09R5b : EtaExp := fun d => if d = 1 then 1 else if d = 5 then 1 else 0
/-- Two-divisor probe on `N = 9` with a negative exponent. -/
def drk09R9b : EtaExp := fun d => if d = 1 then 1 else if d = 9 then -1 else 0

-- PINS 1-11: the eleven `(N, r, γ)` that were also verified numerically against the `η`-product.
/-- PIN 1/15. `N = 4`, `k = 4`, `c = 4`. -/
theorem drk09_pin_N4_c4 : etaPhiSum 4 drk09R4 drk09MatC4 = 0 := by decide +kernel
/-- PIN 2/15. `N = 4`, `k = 4`, `c = 8`: the same level at a different `c`. -/
theorem drk09_pin_N4_c8 : etaPhiSum 4 drk09R4 drk09MatC8 = 0 := by decide +kernel
/-- PIN 3/15. `N = 2`, `k = 0`. -/
theorem drk09_pin_N2 : etaPhiSum 2 drk09R2 drk09MatC2 = -24 := by decide +kernel
/-- PIN 4/15. `N = 6`, `k = 2`, `γ = !![1,0;6,1]`. -/
theorem drk09_pin_N6_c6 : etaPhiSum 6 drk09R6 drk09MatC6 = 0 := by decide +kernel
/-- PIN 5/15. `N = 6`, `k = 2`, `γ = !![5,4;6,5]`.  Compare PIN 4: same `N`, same `r`, same `c`,
DIFFERENT value.  `etaPhiSum` is not constant in `γ`. -/
theorem drk09_pin_N6_c6b : etaPhiSum 6 drk09R6 drk09MatC6b = 24 := by decide +kernel
/-- PIN 6/15. `N = 12`, ODD weight `k = 1`, value `11` — odd, and not a multiple of `24`. -/
theorem drk09_pin_N12 : etaPhiSum 12 drk09R12 drk09MatC12 = 11 := by decide +kernel
/-- PIN 7/15. `N = 5`, `k = 0`. -/
theorem drk09_pin_N5 : etaPhiSum 5 drk09R5 drk09MatC5 = -24 := by decide +kernel
/-- PIN 8/15. `N = 13`, `k = 2`; the multiplier at this instance is `e^{-2πi/3}`, not a sign. -/
theorem drk09_pin_N13 : etaPhiSum 13 drk09R13 drk09MatC13 = 28 := by decide +kernel
/-- PIN 9/15. `N = 7`, `k = 0`; the multiplier at this instance is `i`. -/
theorem drk09_pin_N7 : etaPhiSum 7 drk09R7 drk09MatC7 = -18 := by decide +kernel
/-- PIN 10/15. `N = 11`, `k = 2` — a level run 3 could not reach by any route. -/
theorem drk09_pin_N11 : etaPhiSum 11 drk09R11 drk09MatC11 = 12 := by decide +kernel
/-- PIN 11/15. `N = 9`, `k = 3` — non-squarefree level, three divisors. -/
theorem drk09_pin_N9 : etaPhiSum 9 drk09R9 drk09MatC9 = 18 := by decide +kernel

-- PINS 12-15: sparse `r`, where individual `Φ(γ_δ)` values are exposed rather than summed away.
/-- PIN 12/15.  `r` supported on `δ = 1` only: `etaPhiSum 6 r γ = Φ(γ) = 5`. -/
theorem drk09_pin_N6_single : etaPhiSum 6 drk09R6a drk09MatC6b = 5 := by decide +kernel
/-- PIN 13/15.  `N = 12`, `r` supported on `δ ∈ {1,4}`: an odd NEGATIVE value. -/
theorem drk09_pin_N12_sparse : etaPhiSum 12 drk09R12b drk09MatC12 = -3 := by decide +kernel
/-- PIN 14/15.  `N = 5`, `r` supported on `δ ∈ {1,5}`. -/
theorem drk09_pin_N5_sparse : etaPhiSum 5 drk09R5b drk09MatC5 = 6 := by decide +kernel
/-- PIN 15/15.  `N = 9`, `r` supported on `δ ∈ {1,9}` with a negative exponent. -/
theorem drk09_pin_N9_sparse : etaPhiSum 9 drk09R9b drk09MatC9 = -8 := by decide +kernel

/-! ### Kernel negative controls

Three one-character mutations of `etaPhiSum`, each of which the numerical sweep rejected with a
relative error of order `1`.  They are written as separate definitions and shown, in the kernel,
to give a DIFFERENT rational number.  A proof that accidentally proves one of these mutants
instead of `etaPhiSum` cannot pass this gate. -/

/-- MUTANT A — the Dedekind sum enters with a `+`.  (Numerically: `|w/w' − 1| ≈ 1.15`.) -/
def etaPhiSumSignFlip (N : ℕ) (r : EtaExp) (γ : SL(2, ℤ)) : ℚ :=
  ∑ δ ∈ N.divisors,
    (r δ : ℚ) * (((γ 0 0 + γ 1 1 : ℤ) : ℚ) * (δ : ℚ) / ((γ 1 0 : ℤ) : ℚ)
                 + 12 * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat))

/-- MUTANT B — the factor `δ` is dropped from `(a+d)·δ/c`.  (Numerically: `≈ 2.00`.) -/
def etaPhiSumNoDelta (N : ℕ) (r : EtaExp) (γ : SL(2, ℤ)) : ℚ :=
  ∑ δ ∈ N.divisors,
    (r δ : ℚ) * (((γ 0 0 + γ 1 1 : ℤ) : ℚ) / ((γ 1 0 : ℤ) : ℚ)
                 - 12 * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat))

/-- MUTANT C — `s(d, c)` instead of `s(d, c/δ)`, i.e. the conjugation `γ ↦ γ_δ` is forgotten.
(Numerically: `≈ 0.68`.) -/
def etaPhiSumWrongModulus (N : ℕ) (r : EtaExp) (γ : SL(2, ℤ)) : ℚ :=
  ∑ δ ∈ N.divisors,
    (r δ : ℚ) * (((γ 0 0 + γ 1 1 : ℤ) : ℚ) * (δ : ℚ) / ((γ 1 0 : ℤ) : ℚ)
                 - 12 * dedekindSum (γ 1 1) (γ 1 0).toNat)

/-- NEGATIVE CONTROL 1/4 — MUTANT A is a different function (`11` vs `47/3` at `N = 12`). -/
theorem drk09_neg_control_sign_flip :
    etaPhiSumSignFlip 12 drk09R12 drk09MatC12 ≠ etaPhiSum 12 drk09R12 drk09MatC12 := by
  decide +kernel

/-- NEGATIVE CONTROL 2/4 — MUTANT B is a different function (`11` vs `-2/3` at `N = 12`).
This is the control for the `δ` that `divisorConj` introduces. -/
theorem drk09_neg_control_no_delta :
    etaPhiSumNoDelta 12 drk09R12 drk09MatC12 ≠ etaPhiSum 12 drk09R12 drk09MatC12 := by
  decide +kernel

/-- NEGATIVE CONTROL 3/4 — MUTANT C is a different function (`11` vs `41/3` at `N = 12`). -/
theorem drk09_neg_control_wrong_modulus :
    etaPhiSumWrongModulus 12 drk09R12 drk09MatC12 ≠ etaPhiSum 12 drk09R12 drk09MatC12 := by
  decide +kernel

/-- NEGATIVE CONTROL 4/4 — all three mutants also separate at a SECOND instance (`N = 7`,
`k = 0`, where the true multiplier is `i`), so none of the three separations above is an accident
of the `N = 12` matrix. -/
theorem drk09_neg_control_mutants_at_N7 :
    etaPhiSumSignFlip 7 drk09R7 drk09MatC7 ≠ etaPhiSum 7 drk09R7 drk09MatC7 ∧
    etaPhiSumNoDelta 7 drk09R7 drk09MatC7 ≠ etaPhiSum 7 drk09R7 drk09MatC7 ∧
    etaPhiSumWrongModulus 7 drk09R7 drk09MatC7 ≠ etaPhiSum 7 drk09R7 drk09MatC7 := by
  refine ⟨by decide +kernel, by decide +kernel, by decide +kernel⟩

end SignDisciplineGate

/-! ## DRK-09, part 2 — the split form (`etaPhiSum_eq`)

Pure `ℚ` algebra: separate the linear-in-`δ` part from the Dedekind part. -/

/-- **`etaPhiSum` split into its two halves — UNCONDITIONALLY.**

`Φ_N(r,γ) = (a+d)/c · (Σ_δ δ·r_δ) − 12 · Σ_δ r_δ · s(d, c/δ)`.

The node carried `hγ : γ ∈ Γ₀(N)` and `hc : 0 < c` on this lemma.  Neither is used: this is
`Finset.mul_sum` + `Finset.sum_sub_distrib` + `ring`, and it holds at every `γ` — including
`c = 0`, where Lean's `x/0 = 0` makes both sides `0`.  Carrying the hypotheses would make the
lemma strictly weaker than the truth and would block its use in the `c ≤ 0` assembly, which is
exactly where the rewrite is wanted (LL-1: this is a STRENGTHENING, not a weakening; the node's
literal phrasing is landed immediately below as `etaPhiSum_eq`). -/
theorem etaPhiSum_eq_unconditional (N : ℕ) (r : EtaExp) (γ : SL(2, ℤ)) :
    etaPhiSum N r γ
      = ((γ 0 0 + γ 1 1 : ℤ) : ℚ) / ((γ 1 0 : ℤ) : ℚ) * (∑ δ ∈ N.divisors, (δ : ℚ) * (r δ : ℚ))
        - 12 * ∑ δ ∈ N.divisors, (r δ : ℚ) * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat) := by
  rw [etaPhiSum, Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun δ _ => by ring

set_option linter.unusedVariables false in
/-- **DRK-09 (2/3) — the node's statement, verbatim.**  `hγ` and `hc` are genuinely unused; see
`etaPhiSum_eq_unconditional`, which is what is actually proved. -/
theorem etaPhiSum_eq {N : ℕ} (r : EtaExp) {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N)
    (hc : 0 < γ 1 0) :
    etaPhiSum N r γ
      = ((γ 0 0 + γ 1 1 : ℤ) : ℚ) / ((γ 1 0 : ℤ) : ℚ) * (∑ δ ∈ N.divisors, (δ : ℚ) * (r δ : ℚ))
        - 12 * ∑ δ ∈ N.divisors, (r δ : ℚ) * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat) :=
  etaPhiSum_eq_unconditional N r γ

/-! ## DRK-09, part 3 — the `δ`-summand IS `Φ(γ_δ)`

This is the bridge between run 3's conjugated matrix `γ_δ = divisorConj` (F3.2-A3) and Apostol's
`Φ` (DRK-03).  It is the single place where the `δ` in `(a+d)·δ/c` and the `c/δ` inside the
Dedekind sum are both produced, and it is what the three kernel negative controls above guard. -/

/-- **`Φ(γ_δ) = (a+d)·δ/c − 12·s(d, c/δ)`** for `γ_δ = !![a, bδ; c/δ, d] = divisorConj h`.

The right-hand side is character-for-character the `δ`-summand of `etaPhiSum` (divided by `r δ`).
LL-22: `Φ` here is `rademacherPhi`, Apostol's `Φ`, **not** `rademacherPsi`.

Both hypotheses are load-bearing.  `0 < δ` gives `c/δ ≠ 0`; `0 < c` (with `δ ∣ c`) gives
`0 < c/δ`, which is what `rademacherPhi_of_pos` needs — and `rademacherPhi_of_pos_fails_c_neg`
is the standing witness that it really is needed. -/
theorem rademacherPhi_divisorConj {δ : ℕ} (hδ0 : 0 < δ) {γ : SL(2, ℤ)} (hc : 0 < γ 1 0)
    (h : (δ : ℤ) ∣ γ 1 0) :
    rademacherPhi (divisorConj h)
      = ((γ 0 0 + γ 1 1 : ℤ) : ℚ) * (δ : ℚ) / ((γ 1 0 : ℤ) : ℚ)
        - 12 * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat) := by
  have hδne : (δ : ℤ) ≠ 0 := by exact_mod_cast hδ0.ne'
  have hδpos : (0 : ℤ) < (δ : ℤ) := by exact_mod_cast hδ0
  obtain ⟨q, hq⟩ := id h
  have hqd : γ 1 0 / (δ : ℤ) = q := by rw [hq]; exact Int.mul_ediv_cancel_left q hδne
  have hqpos : 0 < q := by nlinarith [hc, hq, hδpos]
  have hc' : 0 < (divisorConj h) 1 0 := by rw [divisorConj_one_zero, hqd]; exact hqpos
  have hδQ : ((δ : ℕ) : ℚ) ≠ 0 := by exact_mod_cast hδ0.ne'
  have hqQ : ((q : ℤ) : ℚ) ≠ 0 := by exact_mod_cast hqpos.ne'
  rw [rademacherPhi_of_pos hc', divisorConj_zero_zero, divisorConj_one_one,
    divisorConj_one_zero, hqd, hq]
  push_cast
  field_simp

/-! ## DRK-09, part 4 — the factorwise transformation, then the multiplier

`η(δ·(γz))` for one divisor `δ`, then the product over all of them. -/

/-- **DRK-06, transported to a dilated argument.**  For `γ ∈ Γ₀(N)`, `δ ∣ N` and `c > 0`,

  `η(δ·(γz)) = exp(πi/12 · Φ(γ_δ)) · √(-i(cz+d)) · η(δz)`,

with `Φ(γ_δ)` written out as the `δ`-summand of `etaPhiSum`.

Three inputs, in this order: `divisor_smul_comm_explicit` (F3.2-A3) rewrites `δ·(γz)` as
`γ_δ·(δz)`; `eta_smul_eq_exp_rademacherPhi` (DRK-06) evaluates the `η` multiplier of `γ_δ`;
`rademacherPhi_divisorConj` (part 3) names the resulting `Φ`.  The `√` factor comes back with
`denom γ z` and **not** `denom γ_δ (δz)` — the two are equal (`denom_divisorConj`), and that
equality is the whole reason the `√`s collect into one power below. -/
theorem eta_natScale_smul_eq {N δ : ℕ} (hδ : δ ∈ N.divisors) {γ : SL(2, ℤ)}
    (hγ : γ ∈ Gamma0 N) (hc : 0 < γ 1 0) (z : ℍ) :
    ModularForm.eta ((δ : ℂ) * ((γ • z : ℍ) : ℂ))
      = Complex.exp (Real.pi * Complex.I / 12 *
          (((((γ 0 0 + γ 1 1 : ℤ) : ℚ) * (δ : ℚ) / ((γ 1 0 : ℤ) : ℚ)
              - 12 * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat)) : ℚ) : ℂ))
        * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta ((δ : ℂ) * (z : ℂ)) := by
  have hδ0 : 0 < δ := Nat.pos_of_mem_divisors hδ
  have hdvd : (δ : ℤ) ∣ γ 1 0 :=
    dvd_lower_left_of_mem_Gamma0 (Nat.dvd_of_mem_divisors hδ) hγ
  have hδne : (δ : ℤ) ≠ 0 := by exact_mod_cast hδ0.ne'
  obtain ⟨q, hq⟩ := id hdvd
  have hqd : γ 1 0 / (δ : ℤ) = q := by rw [hq]; exact Int.mul_ediv_cancel_left q hδne
  have hδpos : (0 : ℤ) < (δ : ℤ) := by exact_mod_cast hδ0
  have hqpos : 0 < q := by nlinarith [hc, hq, hδpos]
  have hc' : 0 < (divisorConj hdvd) 1 0 := by rw [divisorConj_one_zero, hqd]; exact hqpos
  -- DRK-06 at the conjugated matrix and the dilated point
  have key := eta_smul_eq_exp_rademacherPhi (divisorConj hdvd) hc' (natScale δ hδ0 • z : ℍ)
  rw [rademacherPhi_divisorConj hδ0 hc hdvd,
    ← divisor_smul_comm_explicit hδ0 hdvd z,
    coe_natScale_smul hδ0 (γ • z), coe_natScale_smul hδ0 z] at key
  -- the automorphy denominator that comes back is `cz + d`, not `(c/δ)(δz) + d`
  have hden : ((divisorConj hdvd) 1 0 : ℂ) * ((δ : ℂ) * (z : ℂ)) + ((divisorConj hdvd) 1 1 : ℂ)
      = (γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ) := by
    rw [divisorConj_one_zero, divisorConj_one_one, hqd, hq]
    push_cast
    ring
  rw [hden] at key
  exact key

/-- **DRK-09 (3/3), the transformation law behind it.**  For `γ ∈ Γ₀(N)` with `c > 0` and
`Σ_δ r_δ = 2k`,

  `f(γz) = (-i)^k · exp(πi/12 · Φ_N(r,γ)) · (cz+d)^k · f(z)`   for every `z : ℍ`.

Three collections happen here and each has its own reason:

* the `exp` factors multiply into ONE exponential of the SUM, by `Complex.exp_int_mul` (integer
  exponents `r δ`) and `Complex.exp_sum`.  That sum is `etaPhiSum` by construction;
* the `√(-i(cz+d))` factors are all the SAME number (that is `denom_divisorConj`, F3.2-A3), so
  `prod_zpow_const` collects them into `√(-i(cz+d))^{Σ r_δ} = √(-i(cz+d))^{2k}`, and
  `csqrt_zpow_two_mul` (F3.2-A7) turns that into `(-i(cz+d))^k` with **no residual branch
  choice**.  This is the step that needs `hk`, and the step that has no half-integral analogue;
* `mul_zpow` splits `(-i(cz+d))^k` as `(-i)^k (cz+d)^k`; it is unconditional in `ℂ`. -/
theorem etaQuotientH_smul_eq_exp_etaPhiSum {N : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N)
    (hc : 0 < γ 1 0) (z : ℍ) :
    etaQuotientH N r (γ • z)
      = (-Complex.I) ^ k
        * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((etaPhiSum N r γ : ℚ) : ℂ))
        * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)) ^ k
        * etaQuotientH N r z := by
  have hD0 : ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)) ≠ 0 := DRK05Aux.denom_ne γ z
  have hIa : -Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)) ≠ 0 :=
    mul_ne_zero (neg_ne_zero.mpr Complex.I_ne_zero) hD0
  have hS0 : Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ))) ≠ 0 :=
    csqrt_ne_zero hIa
  have hfac : ∀ δ ∈ N.divisors,
      ModularForm.eta ((δ : ℂ) * ((γ • z : ℍ) : ℂ)) ^ (r δ)
        = Complex.exp ((r δ : ℂ) * ((Real.pi : ℂ) * Complex.I / 12 *
            (((((γ 0 0 + γ 1 1 : ℤ) : ℚ) * (δ : ℚ) / ((γ 1 0 : ℤ) : ℚ)
                - 12 * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat)) : ℚ) : ℂ)))
          * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ))) ^ (r δ)
          * ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ) := by
    intro δ hδ
    rw [eta_natScale_smul_eq hδ hγ hc z, mul_zpow, mul_zpow, Complex.exp_int_mul]
  have step1 : ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * ((γ • z : ℍ) : ℂ)) ^ (r δ)
      = (∏ δ ∈ N.divisors, Complex.exp ((r δ : ℂ) * ((Real.pi : ℂ) * Complex.I / 12 *
            (((((γ 0 0 + γ 1 1 : ℤ) : ℚ) * (δ : ℚ) / ((γ 1 0 : ℤ) : ℚ)
                - 12 * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat)) : ℚ) : ℂ))))
        * (∏ δ ∈ N.divisors,
            Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ))) ^ (r δ))
        * (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ)) := by
    rw [← Finset.prod_mul_distrib, ← Finset.prod_mul_distrib]
    exact Finset.prod_congr rfl hfac
  have step2 : (∏ δ ∈ N.divisors, Complex.exp ((r δ : ℂ) * ((Real.pi : ℂ) * Complex.I / 12 *
            (((((γ 0 0 + γ 1 1 : ℤ) : ℚ) * (δ : ℚ) / ((γ 1 0 : ℤ) : ℚ)
                - 12 * dedekindSum (γ 1 1) ((γ 1 0 / (δ : ℤ)).toNat)) : ℚ) : ℂ))))
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((etaPhiSum N r γ : ℚ) : ℂ)) := by
    rw [← Complex.exp_sum]
    congr 1
    rw [etaPhiSum, Rat.cast_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun δ _ => ?_
    push_cast
    ring
  have step3 : (∏ δ ∈ N.divisors,
        Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ))) ^ (r δ))
      = (-Complex.I) ^ k * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)) ^ k := by
    rw [prod_zpow_const N.divisors hS0 r, hk, csqrt_zpow_two_mul, mul_zpow]
  simp only [etaQuotientH, etaQuotient]
  rw [step1, step2, step3]
  ring

/-- **DRK-09 (3/3) — THE THEOREM THAT REPLACES `F3.2-OBSTRUCTED`'s GENERATION HYPOTHESIS.**

For `γ ∈ Γ₀(N)` with `c > 0` and an exponent vector of even total weight `Σ_δ r_δ = 2k`,

  `w(γ) = (-i)^k · exp(πi/12 · Φ_N(r,γ))`.

HONESTY (LL-1), because the node's own docstring said "deletes `F3.2-OBSTRUCTED`" and that is
**false as stated**: `F3.2-OBSTRUCTED` is the `hgen` hypothesis of `multiplier_trivial_of_congr`.
This theorem REPLACES `hgen` by an explicit Dedekind-sum evaluation; it does not discharge it.
Still required for `ETA-01`, and NOT proved here: the `c ≤ 0` cases (`c < 0` by DRK-08, `c = 0`
by `γ = ±T^n`, and the negative control `etaMultiplierVal_c_zero_formula_fails` below shows the literal
formula is FALSE at `c = 0`), and the arithmetic `24 ∣ Φ_N(r,γ)` from Ligozat's congruences,
which is a separate and harder node.  Necessary for `ETA-01`; not sufficient. -/
theorem etaMultiplierVal_eq_exp_etaPhiSum {N : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N)
    (hc : 0 < γ 1 0) :
    etaMultiplierVal N r k γ
      = (-Complex.I) ^ k
        * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((etaPhiSum N r γ : ℚ) : ℂ)) := by
  have hD0 : ((γ 1 0 : ℂ) * ((UpperHalfPlane.I : ℍ) : ℂ) + (γ 1 1 : ℂ)) ≠ 0 :=
    DRK05Aux.denom_ne γ UpperHalfPlane.I
  have hf : etaQuotientH N r UpperHalfPlane.I ≠ 0 := etaQuotientH_ne_zero N r _
  have hDk : ((γ 1 0 : ℂ) * ((UpperHalfPlane.I : ℍ) : ℂ) + (γ 1 1 : ℂ)) ^ k ≠ 0 :=
    zpow_ne_zero _ hD0
  unfold etaMultiplierVal etaMultiplierAux
  rw [etaQuotientH_smul_eq_exp_etaPhiSum r hk hγ hc UpperHalfPlane.I, DRK05Aux.denom_eq]
  field_simp

/-! ## DRK-09, part 5 — `hc : 0 < c` is LOAD-BEARING, and `c = 0` is genuinely uncovered

Two theorems, both proved, both about what DRK-09 does **not** say. -/

/-- **At `c = 0`, `etaPhiSum` is identically `0`** — for every `N`, every `r` and every `γ`.

`Int.ediv` gives `0 / δ = 0`, `dedekindSum d 0 = 0`, and Lean's `x / 0 = 0` kills the
`(a+d)·δ/c` term as well.  So the Dedekind-sum data carries NO information at `c = 0` and the
closed form degenerates to the constant `(-i)^k`.  That is the structural reason `hc` cannot
simply be dropped, and `etaMultiplierVal_c_zero_formula_fails` below is a concrete instance where
the degenerate value is WRONG. -/
theorem etaPhiSum_of_lower_left_zero (N : ℕ) (r : EtaExp) (γ : SL(2, ℤ)) (h0 : γ 1 0 = 0) :
    etaPhiSum N r γ = 0 := by
  rw [etaPhiSum]
  refine Finset.sum_eq_zero fun δ _ => ?_
  rw [h0, Int.zero_ediv, Int.toNat_zero, dedekindSum_zero_right]
  push_cast
  ring

/-- **NEGATIVE CONTROL — the DRK-09 formula is FALSE at `c = 0`.**

Take `N = 1`, `r ≡ 2` (so `f = η²`), `k = 1`, `γ = T`.  Then `c = 0`, and:

* the TRUTH is `w(T) = e^{2πi·2/24} = e^{πi/6}`, from `etaQuotientH_T_smul` and `denom T = 1`;
* the FORMULA would give `(-i)^1 · e^{πi/12 · 0} = -i`, by `etaPhiSum_of_lower_left_zero`.

`e^{πi/6} ≠ -i` because the first has real part `cos(π/6) = √3/2 > 0` and the second has real
part `0`.  So `0 < c` is not a convenience hypothesis that a later cleanup can delete: the
`c = 0` case needs the separate `γ = ±T^n` argument, and DRK-08's `c < 0` reduction does not
reach it either (`exists_pos_lower_left_or_T_zpow` returns `±T^n` precisely there).

Note the trap the comparator flagged: at `N = 1`, `r ≡ 24`, `k = 12` — where `f = Δ` — the
formula ACCIDENTALLY succeeds at `c = 0` (both sides are `1`).  A one-instance check would have
missed this.  The instance here has `k = 1` odd and a genuinely non-trivial multiplier. -/
theorem etaMultiplierVal_c_zero_formula_fails :
    etaMultiplierVal 1 (fun _ => (2 : ℤ)) 1 ModularGroup.T
      ≠ (-Complex.I) ^ (1 : ℤ)
        * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 *
            ((etaPhiSum 1 (fun _ => (2 : ℤ)) ModularGroup.T : ℚ) : ℂ)) := by
  have hk : ∑ δ ∈ (1 : ℕ).divisors, (fun _ => (2 : ℤ)) δ = 2 * 1 := by decide
  have hT0 : (ModularGroup.T : SL(2, ℤ)) 1 0 = 0 := by simp [ModularGroup.coe_T]
  -- the truth
  have h := etaQuotientH_transform (fun _ => (2 : ℤ)) hk (T_mem_Gamma0 1) UpperHalfPlane.I
  rw [etaQuotientH_T_smul, denom_T, _root_.one_zpow, mul_one] at h
  have hval : Complex.exp ((Real.pi : ℂ) * Complex.I *
      ((∑ δ ∈ (1 : ℕ).divisors, (δ : ℤ) * (fun _ => (2 : ℤ)) δ : ℤ) : ℂ) / 12)
      = etaMultiplierVal 1 (fun _ => (2 : ℤ)) 1 ModularGroup.T :=
    mul_right_cancel₀ (etaQuotientH_ne_zero 1 _ UpperHalfPlane.I) h
  have hsum : (∑ δ ∈ (1 : ℕ).divisors, (δ : ℤ) * (fun _ => (2 : ℤ)) δ) = 2 := by decide
  rw [hsum] at hval
  rw [← hval, etaPhiSum_of_lower_left_zero 1 _ ModularGroup.T hT0]
  intro hcon
  -- compare real parts
  have hre : (Complex.exp ((Real.pi : ℂ) * Complex.I * ((2 : ℤ) : ℂ) / 12)).re
      = Real.cos (Real.pi / 6) := by
    have harg : (Real.pi : ℂ) * Complex.I * ((2 : ℤ) : ℂ) / 12
        = ((Real.pi / 6 : ℝ) : ℂ) * Complex.I := by push_cast; ring
    rw [harg, Complex.exp_ofReal_mul_I_re]
  have hrhs : ((-Complex.I) ^ (1 : ℤ) *
      Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((0 : ℚ) : ℂ))).re = 0 := by
    norm_num
  have := congrArg Complex.re hcon
  rw [hre, hrhs, Real.cos_pi_div_six] at this
  have h3 : (0 : ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  linarith

/-! ## DRK-09, part 6 — a corollary that was an OPEN item in `EtaMultiplier.lean`

`etaMultiplierPhi_pow24` carries `-- OPEN: DRK-07.a.  Needs Φ γ ∈ ℤ ... which is NOT yet stated
anywhere in this library`.  DRK-09 supplies exactly that, for `c > 0`, and does it without any
new analysis: run 3's `etaMultiplierVal_level_one_24` says the multiplier of `Δ = η²⁴` is `1` on
ALL of `SL(2,ℤ)` (proved from `CuspForm.discriminant`, no Dedekind sums anywhere), while DRK-09
says that same multiplier is `(-i)^12 · e^{2πiΦ(γ)} = e^{2πiΦ(γ)}`.  Comparing them forces
`e^{2πiΦ(γ)} = 1`, i.e. `Φ(γ) ∈ ℤ`.

This is a genuine consistency check on DRK-09 as well as a new result: the exponent `24`, the
weight `k = 12` and the prefactor `(-i)^12 = 1` all have to be exactly right for it to come out.
A version of DRK-09 with any of the three mutations of the sign-discipline gate above would
produce a non-integer here. -/

/-- **`Φ(γ) ∈ ℤ` for `γ ∈ SL(2,ℤ)` with `c > 0`** — the integrality of Apostol's `Φ`, obtained
by comparing DRK-09 at `(N, r, k) = (1, 24, 12)` with `etaMultiplierVal_level_one_24`.

LL-22: this is `rademacherPhi`, Apostol's `Φ`, not `rademacherPsi`.
LL-1, scope: `0 < c` only.  `c = 0` gives `Φ(T^n) = n ∈ ℤ` by `rademacherPhi_T_zpow` and `c < 0`
follows from `rademacherPhi_neg`, but neither is packaged here. -/
theorem rademacherPhi_eq_intCast_of_pos {γ : SL(2, ℤ)} (hc : 0 < γ 1 0) :
    ∃ n : ℤ, rademacherPhi γ = (n : ℚ) := by
  have h1 : etaMultiplierVal 1 (fun _ => (24 : ℤ)) 12 γ = 1 := etaMultiplierVal_level_one_24 γ
  have h2 := etaMultiplierVal_eq_exp_etaPhiSum (fun _ => (24 : ℤ)) sum_divisors_one_24
    (mem_Gamma0_one γ) hc
  have h3 : etaPhiSum 1 (fun _ => (24 : ℤ)) γ = 24 * rademacherPhi γ := by
    have hone : (γ 1 0) / (((1 : ℕ) : ℤ)) = γ 1 0 := by norm_num
    rw [rademacherPhi_of_pos hc, etaPhiSum, Nat.divisors_one, Finset.sum_singleton, hone]
    push_cast
    ring
  rw [h1, h3] at h2
  have hI : (-Complex.I) ^ (12 : ℤ) = 1 := by
    have h4 : (-Complex.I) ^ (12 : ℤ) = ((-Complex.I) ^ (2 : ℤ)) ^ (6 : ℤ) := by
      rw [← _root_.zpow_mul]; norm_num
    have h5 : (-Complex.I) ^ (2 : ℤ) = -1 := by
      rw [show (2 : ℤ) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast, neg_pow, Complex.I_sq]
      norm_num
    rw [h4, h5]
    norm_num
  rw [hI, one_mul] at h2
  have harg : (Real.pi : ℂ) * Complex.I / 12 * (((24 * rademacherPhi γ : ℚ)) : ℂ)
      = ((rademacherPhi γ : ℚ) : ℂ) * (2 * (Real.pi : ℂ) * Complex.I) := by
    push_cast
    ring
  rw [harg] at h2
  obtain ⟨n, hn⟩ := Complex.exp_eq_one_iff.mp h2.symm
  have h2pi : (2 * (Real.pi : ℂ) * Complex.I) ≠ 0 := by
    refine mul_ne_zero (mul_ne_zero two_ne_zero ?_) Complex.I_ne_zero
    exact_mod_cast Real.pi_ne_zero
  have hcast : ((rademacherPhi γ : ℚ) : ℂ) = ((n : ℤ) : ℂ) := mul_right_cancel₀ h2pi hn
  exact ⟨n, by exact_mod_cast hcast⟩

/-- **`Φ(γ) ∈ ℤ` on ALL of `SL(2,ℤ)`.**  The three sign cases: `c > 0` is the theorem above;
`c < 0` is that case at `-γ` together with `rademacherPhi_neg`; `c = 0` forces `a·d = 1` hence
`d = ±1`, and `Φ = b/d = b·d`.  No analysis beyond what `rademacherPhi_eq_intCast_of_pos`
already used. -/
theorem rademacherPhi_eq_intCast (γ : SL(2, ℤ)) : ∃ n : ℤ, rademacherPhi γ = (n : ℚ) := by
  rcases lt_trichotomy (γ 1 0) 0 with hlt | heq | hgt
  · have hneg : 0 < (-γ) 1 0 := by rw [SL2_neg_apply]; omega
    obtain ⟨n, hn⟩ := rademacherPhi_eq_intCast_of_pos hneg
    exact ⟨n, by rw [← rademacherPhi_neg γ]; exact hn⟩
  · have hdet := sl2_det γ
    rw [heq, mul_zero, sub_zero] at hdet
    refine ⟨γ 0 1 * γ 1 1, ?_⟩
    rcases Int.eq_one_or_neg_one_of_mul_eq_one' hdet with ⟨_, hd⟩ | ⟨_, hd⟩ <;>
      rw [rademacherPhi, if_pos heq, hd] <;> push_cast <;> ring
  · exact rademacherPhi_eq_intCast_of_pos hgt

/-- **DRK-07.a, discharged.**  `ε(γ)²⁴ = 1` for the `η` multiplier `ε(γ) = e^{πiΦ(γ)/12}`, on all
of `SL(2,ℤ)`.

`EtaMultiplier.lean`'s `etaMultiplierPhi_pow24` carries `-- OPEN: DRK-07.a.  Needs Φ γ ∈ ℤ ...
which is NOT yet stated anywhere in this library`.  It is stated now
(`rademacherPhi_eq_intCast`), and this is the two-line consequence.  LOUDLY (LL-1): the `sorry`
in `EtaMultiplier.lean:1234` is left exactly where it is — this run does not edit that file, and
its inverted `FinalCheck` tripwire therefore still fires correctly.  What is claimed here is that
the tripwire is now **stale**, not that it is wrong: the statement it guards is provable, by this
proof, under a different name in this file. -/
theorem etaMultiplierPhi_pow24_of_intCast (γ : SL(2, ℤ)) :
    (etaMultiplierPhi γ) ^ (24 : ℕ) = 1 := by
  obtain ⟨n, hn⟩ := rademacherPhi_eq_intCast γ
  rw [etaMultiplierPhi, hn, ← Complex.exp_nat_mul]
  have h : ((24 : ℕ) : ℂ) * ((Real.pi : ℂ) * Complex.I / 12 * ((n : ℚ) : ℂ))
      = (n : ℂ) * (2 * (Real.pi : ℂ) * Complex.I) := by
    push_cast
    ring
  rw [h, Complex.exp_int_mul_two_pi_mul_I]

end SocrateAI.ModularForms
