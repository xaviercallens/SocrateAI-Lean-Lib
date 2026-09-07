/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# The order of vanishing at a cusp: what is reachable, and the named obstruction
# (DAG: F3.1-B13, F3.1-OBSTRUCTED)

This file has two jobs, and they pull in opposite directions on purpose.

* **F3.1-B13 (PROVED).** At the cusp `∞` the order of vanishing of an eta quotient is
  `etaQuotientCuspOrder N r N`, stated in **Mathlib's own** order-of-vanishing language:
  `meromorphicOrderAt (UpperHalfPlane.cuspFunction 1 (etaQuotientH N r)) 0 = m`
  whenever `24 m = Σ_δ δ r_δ`, i.e. whenever Ligozat's first congruence holds.
* **F3.1-OBSTRUCTED (NOT PROVED, and deliberately not stated).** The same equation at a general
  cusp `c/d` is out of reach, and the record below says exactly why, with the greps that
  establish it.

## THE STATEMENT THAT DOES NOT APPEAR IN THIS DEVELOPMENT

    theorem etaQuotientCuspOrder_eq_analytic_order (N r d c) (h : Ligozat conditions) :
        analyticOrderAtCusp (c / d) (etaQuotient N r) = etaQuotientCuspOrder N r d

(Ligozat; Ono, *Web of Modularity*, Thm 1.65.)  It is not proved here, it is not assumed here,
and it is not weakened into something provable and then given this name.  `F3.1` ships
`etaQuotientCuspOrder` (F3.1-A2) as a DEFINITION, validated by the valence identity F3.1-A10 and
by the kernel-decided `#guard`s next to it, and now additionally by the `d = N` case below.

## THE OBSTRUCTION, RE-VERIFIED — AND ONE HALF OF THE RECEIVED VERSION IS WRONG

The brief for this node carried two blockers.  Both were re-run against the Mathlib in this
workspace (commit `905b95818eb32af7874a58b427f50c1711a5e96c`, 2026-07-28).  The first survives.
The second **does not**, and the way it failed is worth recording.

**Blocker (1) — CONFIRMED.  The eta multiplier system is absent.**  The classical proof computes
the order of `∏ η(δz)^{r_δ}` at `c/d` by moving the cusp to `∞` with some `γ ∈ SL(2,ℤ)` and
reading off `η ∣ γ`, which for general `γ` is governed by the multiplier system, classically
written with Dedekind sums.  Verified absent, each grep run over
`Mathlib/**/*.lean` and each returning **0 files**:

    grep -rl 'DedekindSum'     → 0        grep -rl 'etaMultiplier'   → 0
    grep -rl 'dedekindSum'     → 0        grep -rl 'eta_multiplier'  → 0
    grep -rl 'Ligozat'         → 0        grep -rl 'EtaQuotient'     → 0

What Mathlib does have for `η` is the `S`-transformation (`eta_comp_eq_csqrt_I_inv`, in
`Mathlib.NumberTheory.ModularForms.Discriminant`) and — after F3.1-B2/B3 — the
`T`-transformation.  `S` and `T` generate `SL(2,ℤ)`, but the multiplier is a **cocycle**, so
generating the group does not by itself hand over the multiplier of an arbitrary word without
the Dedekind-sum bookkeeping; this is the same wall F3.2-OBSTRUCTED hits from the other side.

**Blocker (2) — REFUTED, and it was a `grep` artefact.**  The brief asserted that Mathlib has no
notion of order of vanishing at a cusp *at all*, on the evidence that `orderAt`, `vanishingOrder`,
`cuspWidth` and `widthAt` each return zero files.  Those four greps do return zero files.  The
inference is still wrong, and the reason is CASE:

    grep -rl  'orderAt'   Mathlib → 0 files
    grep -rli 'orderat'   Mathlib → 19 files

`analyticOrderAt` and `meromorphicOrderAt` have a capital `O`.  A zero result from a
case-sensitive grep on a lowercase-initial camelCase name is not evidence of absence.  What is
actually in Mathlib at this commit, all verified by reading the files:

* `Mathlib/Analysis/Analytic/Order.lean` — `analyticOrderAt f z₀ : ℕ∞`.
* `Mathlib/Analysis/Meromorphic/Order.lean` — `meromorphicOrderAt f x : WithTop ℤ`, with
  `meromorphicOrderAt_eq_int_iff`; this is what F3.1-B13 below uses.
* `Mathlib/NumberTheory/ModularForms/Cusps.lean` — `IsCusp c 𝒢` for `c : OnePoint ℝ`, the cusp
  orbit space `CuspOrbits 𝒢` with `Finite` instance, and the **width at `∞`**
  `Subgroup.strictWidthInfty` / `widthInfty`, together with `strictWidthInfty_Gamma0 (N) = 1`.
* `Mathlib/NumberTheory/ModularForms/QExpansion.lean` — `UpperHalfPlane.cuspFunction h f`,
  `qExpansion h f : PowerSeries ℂ`, `analyticAt_cuspFunction_zero`.

So the left-hand side of the displayed equation is **not** unstateable, at the cusp `∞`: it is
`meromorphicOrderAt (cuspFunction 1 f) 0`, the width `1` being Mathlib's own
`strictWidthInfty_Gamma0`.  F3.1-B13 states it and proves it.

**What is genuinely missing, after the correction.**  Three things, and only the first is a
mathematical obstruction rather than a missing definition:

1. the eta multiplier for a general `γ ∈ Γ₀(N)` — blocker (1), Dedekind sums, absent;
2. an order of vanishing at a cusp **other than `∞`**.  Mathlib's width is `widthInfty` only;
   there is no `widthAtCusp`, no `orderAtCusp`, no `f ∣ γ`-normalised cusp expansion.  One can
   *construct* these from what is there (conjugate the group with `conjGL`, take `widthInfty` of
   the conjugate, expand `f ∣[k] γ`), so this is missing API, not an obstruction — but nothing
   downstream may pretend it exists;
3. the indexing data of the classical statement: that the cusps of `Γ₀(N)` are parametrised by
   `d ∣ N` with multiplicity `φ(gcd(d, N/d))`, and that `[SL(2,ℤ) : Γ₀(N)] = ψ(N)`.  Neither is
   in Mathlib (`grep` for an index formula on `Gamma0` returns nothing), and neither is proved
   here; `numCusps` and `dedekindPsi` (F3.1-A8) are arithmetic functions with those *classical
   readings*, nothing more.

**Consequence, stated so it cannot be over-read.**  F3.1-B13 is the cusp `∞` and nothing else.
Every other cusp needs (1), and (1) is where the wall is.  The honest scope of the F3.1 block is
therefore: `etaQuotientCuspOrder` is a definition; it is *proved* to be the analytic order at
`d = N`; at `d ≠ N` it is a transcription validated by A10 and by numerics, and calling it an
order of vanishing there is a reading, not a theorem of this development.

## Main results

* `etaQuotientTail` — the `q`-series tail `∏_δ (∏' n, (1 - (q^δ)^{n+1}))^{r_δ}` as a function of
  `q` on the unit disc, with `etaQuotientTail N r 0 = 1` and analyticity at `0`.
* `cuspFunction_etaQuotientH` — for `0 < ‖q‖ < 1`, Mathlib's cusp function of the eta quotient
  at width `1` is `q^m · etaQuotientTail N r q`.
* `meromorphicOrderAt_cuspFunction_etaQuotientH` — **F3.1-B13**, the order statement.
* `meromorphicOrderAt_cuspFunction_eq_cuspOrder_infty` — the same with `etaQuotientCuspOrder`
  in place of `m`, and `exists_...` its form under `LigozatCongr1`.
* `meromorphicOrderAt_cuspFunction_discriminant` — the external pin: `ord_∞(Δ) = 1`, the
  classical value, in the same language.  Mathlib states the same number as
  `discriminant_qExpansion_order` in `LevelOne/DimensionFormula.lean` (a file outside this
  workspace's built cone), so this is a literature cross-check, not a tautology.
-/
import SocrateAI.ModularForms.EtaQuotientModularity
import Mathlib.Analysis.Meromorphic.Order

namespace SocrateAI.ModularForms

open Complex UpperHalfPlane ModularForm
open scoped Real Topology

/-! ### F3.1-B13 — the `q`-series tail as a function on the unit disc -/

/-- The `q`-series tail of the eta quotient, as a function of the local parameter `q` at the cusp
`∞`: `T(q) = ∏_{δ ∣ N} (∏' n, (1 - (q^δ)^{n+1}))^{r_δ}`.

This is the second factor of F3.1-B11 rewritten so that the variable is `q` rather than `τ`: the
substitution is `eta_q n (δτ) = (𝕢 1 (δτ))^{n+1} = ((𝕢 1 τ)^δ)^{n+1}`, which is F3.1-B12's
`qParam_one_natCast_mul`.  Making `q` the variable is what allows Mathlib's local theory at `0`
(`AnalyticAt`, `meromorphicOrderAt`) to be applied at all. -/
noncomputable def etaQuotientTail (N : ℕ) (r : EtaExp) (q : ℂ) : ℂ :=
  ∏ δ ∈ N.divisors, (∏' n : ℕ, (1 - (q ^ δ) ^ (n + 1))) ^ (r δ)

/-- **The tail is `1` at `q = 0`.**  Every `δ ∈ N.divisors` is positive, so `0^δ = 0`, each factor
of the `∏'` is `1 - 0 = 1`, and `1^{r_δ} = 1`.  No hypothesis on `N` (at `N = 0` the divisor set
is empty and the product is the empty product) and none on `r`; negative exponents are covered
because the base is `1`.

This is the `q`-side of F3.1-B12: there the tail was shown to tend to `1` along `atImInfty`, here
the same value appears as an honest function value at the boundary point `q = 0`. -/
theorem etaQuotientTail_zero (N : ℕ) (r : EtaExp) : etaQuotientTail N r 0 = 1 := by
  refine Finset.prod_eq_one fun δ hδ => ?_
  have hδ0 : δ ≠ 0 := (Nat.pos_of_mem_divisors hδ).ne'
  simp [zero_pow hδ0]

/-- `q ↦ ∏' n, (1 - q^{n+1})` is analytic at `0`.  Mathlib's
`differentiableOn_tprod_one_sub_pow` gives differentiability on the open unit disc, and `0` is an
interior point; `DifferentiableOn.analyticAt` converts.  This is the same Mathlib lemma F3.1-B12
used for the limit, now used for the local structure instead. -/
theorem analyticAt_tprod_one_sub_pow :
    AnalyticAt ℂ (fun q : ℂ => ∏' n : ℕ, (1 - q ^ (n + 1))) 0 :=
  ModularForm.differentiableOn_tprod_one_sub_pow.analyticAt
    (Metric.ball_mem_nhds (0 : ℂ) one_pos)

/-- **The tail is analytic at `q = 0`.**  Each factor is `F(q^δ)^{r_δ}` with
`F(x) = ∏' n, (1 - x^{n+1})`: `F` is analytic at `0` by `analyticAt_tprod_one_sub_pow`, `q ↦ q^δ`
is analytic and sends `0` to `0` (`δ ≠ 0`, from `Nat.pos_of_mem_divisors`), so the composite is
analytic by `AnalyticAt.fun_comp_of_eq`; its value at `0` is `F(0) = 1 ≠ 0`, which is exactly the
side condition `AnalyticAt.fun_zpow` needs to allow NEGATIVE `r_δ`.  `Finset.analyticAt_fun_prod`
multiplies the divisors together. -/
theorem analyticAt_etaQuotientTail (N : ℕ) (r : EtaExp) :
    AnalyticAt ℂ (etaQuotientTail N r) 0 := by
  refine Finset.analyticAt_fun_prod (𝕜 := ℂ) _ fun δ hδ => ?_
  have hδ0 : δ ≠ 0 := (Nat.pos_of_mem_divisors hδ).ne'
  have hpow : AnalyticAt ℂ (fun q : ℂ => q ^ δ) 0 := (analyticAt_id).pow δ
  have hzero : (fun q : ℂ => q ^ δ) 0 = 0 := by simp [zero_pow hδ0]
  have hcomp : AnalyticAt ℂ (fun q : ℂ => ∏' n : ℕ, (1 - (q ^ δ) ^ (n + 1))) 0 :=
    AnalyticAt.fun_comp_of_eq analyticAt_tprod_one_sub_pow hpow hzero
  refine hcomp.fun_zpow ?_
  simp [zero_pow hδ0]

/-! ### F3.1-B13 — the eta quotient in the local parameter at `∞` -/

/-- **The eta quotient is `q^m` times the tail, with `m` an INTEGER.**  F3.1-B11 splits the eta
quotient as `exp(2πiτ (Σ_δ δ r_δ)/24) · tail`; the hypothesis `24 m = Σ_δ δ r_δ` — i.e. Ligozat's
first congruence, made explicit by naming the quotient `m` — turns the exponential into the
integer power `(𝕢 1 τ)^m` via `Complex.exp_int_mul`.

The integrality is not cosmetic.  `q^{m}` for `m ∈ ℤ` is a single-valued function of `q`; for a
non-integral exponent it is not, and neither the cusp function nor its order would be defined.
This is the same hypothesis that makes the eta quotient `1`-periodic (F3.1-B3), which is why the
width-`1` cusp function of Mathlib is the right object here (`strictWidthInfty_Gamma0 N = 1`). -/
theorem etaQuotientH_eq_zpow_qParam_mul_tail (N : ℕ) (r : EtaExp) (m : ℤ)
    (hm : (24 : ℤ) * m = ∑ δ ∈ N.divisors, (δ : ℤ) * r δ) (τ : ℍ) :
    etaQuotientH N r τ
      = (Function.Periodic.qParam 1 (τ : ℂ)) ^ m
        * etaQuotientTail N r (Function.Periodic.qParam 1 (τ : ℂ)) := by
  rw [etaQuotientH_eq_qpow_mul]
  simp only [etaQuotientTail]
  congr 1
  · have hs : (∑ δ ∈ N.divisors, (δ : ℂ) * (r δ : ℂ)) = (24 : ℂ) * (m : ℂ) := by
      have h := congrArg (fun x : ℤ => (x : ℂ)) hm
      push_cast at h
      rw [← h]
    rw [hs, Function.Periodic.qParam, ← Complex.exp_int_mul]
    congr 1
    push_cast
    ring
  · refine Finset.prod_congr rfl fun δ _ => ?_
    congr 1
    refine tprod_congr fun n => ?_
    rw [ModularForm.eta_q, qParam_one_natCast_mul]

/-- **Mathlib's cusp function of the eta quotient, computed.**  For `0 < ‖q‖ < 1`,

  `UpperHalfPlane.cuspFunction 1 (etaQuotientH N r) q = q^m · etaQuotientTail N r q`.

`Function.Periodic.cuspFunction h f` is `f ∘ invQParam h` off `0`, so the proof is: `invQParam 1 q`
has positive imaginary part (`im_invQParam_pos_of_norm_lt_one`), hence `ofComplex` returns that
very point; `qParam_right_inv` sends it back to `q`; and the previous lemma evaluates the eta
quotient there.  Note that no periodicity input is needed for THIS identity — it holds at every
punctured point, which is what shows a posteriori that the branch cut of `invQParam` does no
damage. -/
theorem cuspFunction_etaQuotientH (N : ℕ) (r : EtaExp) (m : ℤ)
    (hm : (24 : ℤ) * m = ∑ δ ∈ N.divisors, (δ : ℤ) * r δ) {q : ℂ}
    (hq0 : q ≠ 0) (hq : ‖q‖ < 1) :
    UpperHalfPlane.cuspFunction 1 (etaQuotientH N r) q
      = q ^ m * etaQuotientTail N r q := by
  have him : 0 < (Function.Periodic.invQParam 1 q).im :=
    Function.Periodic.im_invQParam_pos_of_norm_lt_one one_pos hq hq0
  have hq' : Function.Periodic.qParam 1 (Function.Periodic.invQParam 1 q) = q :=
    Function.Periodic.qParam_right_inv one_ne_zero hq0
  rw [UpperHalfPlane.cuspFunction, Function.Periodic.cuspFunction_eq_of_nonzero _ _ hq0,
    Function.comp_apply, UpperHalfPlane.ofComplex_apply_of_im_pos him,
    etaQuotientH_eq_zpow_qParam_mul_tail N r m hm ⟨_, him⟩]
  simp only [hq']

/-- **F3.1-B13 — the order of vanishing of an eta quotient at the cusp `∞`, in Mathlib's own
order-of-vanishing language.**

  `meromorphicOrderAt (UpperHalfPlane.cuspFunction 1 (etaQuotientH N r)) 0 = m`

for every level `N`, every integer exponent vector `r` and every integer `m` with
`24 m = Σ_δ δ r_δ`.

`meromorphicOrderAt_eq_int_iff` asks for a `g` analytic at `0` with `g 0 ≠ 0` and
`f z = (z - 0)^m • g z` on a PUNCTURED neighbourhood; `etaQuotientTail` is that `g`
(`analyticAt_etaQuotientTail`, `etaQuotientTail_zero`), and the punctured identity is
`cuspFunction_etaQuotientH` on the punctured unit disc.  Because the criterion is punctured, the
junk value that `Function.Periodic.cuspFunction` assigns at `0` never enters, and because
`meromorphicOrderAt` is `WithTop ℤ`-valued, NEGATIVE orders are covered: no holomorphy hypothesis
on `r` is imposed anywhere.

SCOPE (LL-1).  This is the cusp `∞`, whose width for `Γ₀(N)` is `1` by Mathlib's
`strictWidthInfty_Gamma0`.  It says nothing about any other cusp; see the obstruction record in
the module docstring. -/
theorem meromorphicOrderAt_cuspFunction_etaQuotientH (N : ℕ) (r : EtaExp) (m : ℤ)
    (hm : (24 : ℤ) * m = ∑ δ ∈ N.divisors, (δ : ℤ) * r δ) :
    meromorphicOrderAt (UpperHalfPlane.cuspFunction 1 (etaQuotientH N r)) 0
      = (m : WithTop ℤ) := by
  have hev : ∀ᶠ q in 𝓝[≠] (0 : ℂ),
      UpperHalfPlane.cuspFunction 1 (etaQuotientH N r) q
        = (q - 0) ^ m • etaQuotientTail N r q := by
    have hball : Metric.ball (0 : ℂ) 1 ∈ 𝓝 (0 : ℂ) := Metric.ball_mem_nhds _ one_pos
    filter_upwards [nhdsWithin_le_nhds hball, self_mem_nhdsWithin] with q hqb hq0
    have hnorm : ‖q‖ < 1 := by simpa using hqb
    have hq0' : q ≠ 0 := by simpa using hq0
    rw [cuspFunction_etaQuotientH N r m hm hq0' hnorm]
    simp
  have hmer : MeromorphicAt (UpperHalfPlane.cuspFunction 1 (etaQuotientH N r)) 0 :=
    MeromorphicAt.iff_eventuallyEq_zpow_smul_analyticAt.mpr
      ⟨m, etaQuotientTail N r, analyticAt_etaQuotientTail N r, hev⟩
  rw [meromorphicOrderAt_eq_int_iff hmer]
  exact ⟨etaQuotientTail N r, analyticAt_etaQuotientTail N r,
    by rw [etaQuotientTail_zero]; exact one_ne_zero, hev⟩

/-- **F3.1-B13, with the arithmetic definition in place of the integer.**  If
`etaQuotientCuspOrder N r N` — Ligozat's expression at the cusp denominator `d = N`, which is the
cusp `∞` — is the integer `m`, then `m` is the analytic order of the eta quotient there.

This is the one place in the whole F3.1 development where `etaQuotientCuspOrder` is PROVED to be
an order of vanishing rather than read as one, and it happens at exactly one cusp.  The bridge is
`etaQuotientCuspOrder_infty_num` (F3.1-A3): `24 · ord_∞ = Σ_δ δ r_δ` as integers. -/
theorem meromorphicOrderAt_cuspFunction_eq_cuspOrder_infty (N : ℕ) (hN : N ≠ 0) (r : EtaExp)
    {m : ℤ} (hm : etaQuotientCuspOrder N r N = (m : ℚ)) :
    meromorphicOrderAt (UpperHalfPlane.cuspFunction 1 (etaQuotientH N r)) 0
      = (m : WithTop ℤ) := by
  refine meromorphicOrderAt_cuspFunction_etaQuotientH N r m ?_
  have h := etaQuotientCuspOrder_infty_num N hN r
  rw [hm] at h
  exact_mod_cast h

/-- **F3.1-B13 under Ligozat's first congruence.**  `LigozatCongr1 N r` is exactly integrality of
`ord_∞` (F3.1-A7, `ligozatCongr1_iff`), so it is exactly the hypothesis under which the cusp `∞`
order exists as an integer and equals the transcribed expression. -/
theorem exists_meromorphicOrderAt_cuspFunction_etaQuotientH (N : ℕ) (hN : N ≠ 0) (r : EtaExp)
    (h : LigozatCongr1 N r) :
    ∃ m : ℤ, etaQuotientCuspOrder N r N = (m : ℚ) ∧
      meromorphicOrderAt (UpperHalfPlane.cuspFunction 1 (etaQuotientH N r)) 0
        = (m : WithTop ℤ) := by
  obtain ⟨m, hm⟩ := (ligozatCongr1_iff N hN r).mp h
  exact ⟨m, hm, meromorphicOrderAt_cuspFunction_eq_cuspOrder_infty N hN r hm⟩

/-- **THE EXTERNAL PIN (LL-1).**  `ord_∞(Δ) = 1`: the modular discriminant vanishes to order
exactly one at the cusp, the classical value, here in Mathlib's `meromorphicOrderAt` language and
obtained from OUR general theorem specialised at `N = 1`, `r ≡ 24`.

The number `1` is taken from the literature, not from our definitions, and three of them have to
agree for this to close: `etaQuotientH 1 (fun _ => 24) = Δ` (F3.1-B10),
`etaQuotientCuspOrder 1 (fun _ => 24) 1 = 1` (F3.1-B10, arithmetic layer) and F3.1-B13.  Mathlib
states the same number independently as `discriminant_qExpansion_order` in
`Mathlib/NumberTheory/ModularForms/LevelOne/DimensionFormula.lean`, which is outside this
workspace's built import cone — so this is a cross-check against the literature, and if our
normalisation of the cusp order were off by any factor it would fail here. -/
theorem meromorphicOrderAt_cuspFunction_discriminant :
    meromorphicOrderAt (UpperHalfPlane.cuspFunction 1 (ModularForm.discriminant : ℍ → ℂ)) 0
      = (1 : ℤ) := by
  have hfun : (ModularForm.discriminant : ℍ → ℂ) = etaQuotientH 1 (fun _ => (24 : ℤ)) :=
    funext fun τ => (etaQuotientH_level_one_24 τ).symm
  rw [hfun]
  exact meromorphicOrderAt_cuspFunction_eq_cuspOrder_infty 1 one_ne_zero (fun _ => (24 : ℤ))
    (m := 1) (by rw [etaQuotientCuspOrder_one_24]; norm_num)

/-! ### F3.1-OBSTRUCTED — the tripwire

No declaration in this file, or anywhere else in the development, states the general-cusp
equation.  If a future edit adds one, the reviewer's check is the two questions this file's
docstring answers: (a) where does the eta multiplier for a general `γ ∈ Γ₀(N)` come from, given
that Mathlib has no Dedekind sums, and (b) what is the definition of the order at a cusp other
than `∞`, given that Mathlib's width is `widthInfty` only?  A proof that cannot answer both is
either assuming the conclusion or proving a different theorem. -/

end SocrateAI.ModularForms
