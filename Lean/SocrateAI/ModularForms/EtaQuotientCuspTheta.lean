/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# F3.2-C2 — Ligozat's cusp-order formula, as a `Θ`-asymptotic at every cusp

## The theorem

`etaQuotient_cusp_order`.  Fix a level `N`, an integer exponent vector `r : ℕ → ℤ` with even
weight-sum `Σ_{δ ∣ N} r_δ = 2k`, and put `f(z) = ∏_{δ ∣ N} η(δz)^{r_δ}`.  Then for **every**
`γ ∈ SL(2,ℤ)` — no congruence condition, no `Γ₀(N)`-membership, no character, no choice of
generators —

    ‖(f ∣[k] γ)(z)‖  =Θ[atImInfty]  exp(-2π · ordRaw(N, r, c) · Im z),      c = γ 1 0,

    ordRaw(N, r, c) = (1/24) Σ_{δ ∣ N} gcd(c, δ)² · r_δ / δ.

That exponent is Ligozat's cusp-order expression.  Because the `Θ` is along `atImInfty`, which
puts **no** restriction on `Re z`, the statement is uniform in the real part: no approach region
is assumed, and none is needed (see "why no approach region" below).

## READ THIS BEFORE CITING: the width normalisation (LL-1)

The node was scoped with the exponent written as `ligozatOrder N r c`, i.e. with the factor
`N / (24 · gcd(c², N))`.  **That statement is false as written**, and this file does not prove it.
Ligozat's `etaQuotientCuspOrder N r d` (F3.1-A2) is an order of vanishing in the LOCAL
uniformiser `q_h = e^{2πiz/h}` at the cusp of denominator `d`, where `h = N / gcd(d², N)` is the
width of that cusp for `Γ₀(N)`; a decay statement in `Im z` therefore carries the exponent
`ord_Ligozat / h`, not `ord_Ligozat`.  Concretely

    etaQuotientCuspOrder N r d  =  h · ordRaw(N, r, d),      h = N / gcd(d², N)

(`etaQuotientCuspOrder_eq_width_mul_raw`), so `exp(-2π · ord_Ligozat · Im z)` and
`exp(-2π · ordRaw · Im z)` are DIFFERENT functions whenever `h ≠ 1`.  What this file proves is
the second one, and `etaQuotient_cusp_order_ligozat` states the same theorem with the exponent
spelled `ord_Ligozat / h` so that the correction is visible in the statement.

Ligozat's condition (iii) is untouched by the discrepancy: `h > 0`, so `ordRaw ≥ 0` at a cusp iff
`ord_Ligozat ≥ 0` there (`etaQuotientRawOrder_nonneg_iff`, in the arithmetic file).  A numeric
hand-computed pin of all of this is `rawOrder_level_two_twelve_pin`, also in the arithmetic file:
`f = (η(z)η(2z))^12` has `|f ∣[12] S| ≍ exp(-3πy/2)`, i.e. `ordRaw = 3/4` at the cusp `0`, while
Ligozat's number there is `3/2` and the width is `2`.

## The route, and what it does NOT use

The classical proof of the cusp-order formula moves the cusp to `∞` with `γ` and reads off
`η ∣ γ`, which for general `γ` is governed by the **eta multiplier system** — classically written
with Dedekind sums, and Mathlib has none (`DedekindSum`, `dedekindSum`, `etaMultiplier`: zero
files at commit `905b95818e`).  That is `F3.2-OBSTRUCTED`, and it is not circumvented here: it is
**side-stepped**, because a `Θ`-statement sees only `|f|`, and the multiplier has modulus `1`.

1.  **Hermite normal form (`Smith`).**  For `δ ∣ N` and `γ = (a,b;c,d) ∈ SL(2,ℤ)` the integral
    matrix `δ·γ = (δa, δb; c, d)` (determinant `δ`) factors as `γ_δ · A_δ` with
    `γ_δ = (P,-V;S,U) ∈ SL(2,ℤ)` and `A_δ = (A, E; 0, D)` upper triangular,
    `A = gcd(δ, c)`, `D = δ/A`.  The construction is explicit — no choice, no `Finset` choice
    principle — with `A_dvd_delta`/`A_dvd_c` for the divisions and a two-stage Bézout
    (`bezout_raw`: `δa·U + c·V = A`, built out of `Int.gcdA/gcdB` for the pairs `(δ,c)` and
    `(a,c)`, the latter coprime because `det γ = 1`).  Consequences, all `linear_combination`
    over `ℤ`: `S·A = c`, `P·A = δa`, `S·E + U·D = d`, `P·E − V·D = δb`.
    Hence, on `ℍ`, `δ·(γz) = γ_δ · w_δ(z)` with `w_δ(z) = (A z + E)/D` (`coe_gam_smul_hpt`), and
    the automorphy denominator that comes back is `denom γ_δ (w_δ z) = (cz+d)/D`
    (`denom_gam_hpt`).

2.  **`F3.2-C1` in modulus (`norm_eta_natMul_smul`).**  `abs_eta_smul` — `‖η(γz)‖ =
    √‖cz+d‖·‖η(z)‖` for all of `SL(2,ℤ)`, proved through `Δ = η²⁴` and therefore free of the
    multiplier — applied at `γ_δ` and `w_δ(z)` gives
    `‖η(δ·(γz))‖ = √(‖cz+d‖/D)·‖η(w_δ(z))‖`.

3.  **The exact modulus formula (`norm_etaQuotientH_smul_eq`).**  Taking the product over
    `δ ∣ N` with exponents `r_δ`, the `√‖cz+d‖` factors collect into `‖cz+d‖^{(Σ r_δ)/2}
    = ‖cz+d‖^k` — this is exactly where the hypothesis `Σ r_δ = 2k` is consumed — and cancel
    against the `‖denom‖^{-k}` of the slash.  What is left is an EQUALITY

        ‖(f ∣[k] γ)(z)‖ = C(γ) · exp(-2π · ordRaw · Im z) · ∏_δ ‖tail_δ(z)‖^{r_δ},

    with `C(γ) = ∏_δ (√D_δ)^{-r_δ}` a nonzero constant, `tail_δ(z) = ∏'_n (1 - eta_q n w_δ(z))`,
    and the exponent produced by `Im w_δ(z) = (A_δ/D_δ)·Im z` together with the arithmetic
    identity `A_δ/D_δ = gcd(c,δ)²/δ` (`Smith.A_div_D_eq`).

4.  **The one limit (`tendsto_cuspTail`).**  `Im w_δ(z) = (A_δ/D_δ)·Im z → ∞` along `atImInfty`
    because `A_δ/D_δ > 0`, so each `tail_δ` tends to `1` by `F3.1-B12`'s
    `tendsto_tprod_one_sub_eta_q_natCast_mul`; `isTheta_mul_of_tendsto` converts
    "`u → C ≠ 0`" into "`u·g =Θ g`".

**Why no approach region is needed.**  `atImInfty` lets `Re z` roam.  Individually
`‖η(δ·(γz))‖` and `‖cz+d‖^{-k}` are *not* `Θ` of a pure exponential there — both carry a factor
that depends on `Re z`.  They cancel EXACTLY, at the level of an identity rather than an
estimate, because the `√‖cz+d‖` produced by step 2 appears once per unit of `r_δ` and
`Σ r_δ = 2k`.  Step 3 is that cancellation; nothing is estimated until step 4.

## Guards (LL-1: a green build can prove the wrong theorem)

* `cusp_order_infty_guard` — the cusp `∞` by two routes that share no step.  Route A is this
  file's theorem at `γ = 1`; route B (`norm_etaQuotientH_isTheta_infty`) never leaves the
  `q`-product: `F3.1-B12` gives `f/q^{ord_∞} → 1`, and `‖q^{ord_∞}‖ = exp(-2π·ord_∞·Im z)`.
  The bridge between the two exponents is `etaQuotientRawOrder_infty` (`gcd(0,δ) = δ`).
* `exp_isBigO_discriminant_of_cusp_order` — the EXTERNAL pin.  At `N = 1`, `r ≡ 24`, `k = 12` the
  eta quotient is Mathlib's `Δ`, and this file's theorem returns `ordRaw = 1`, i.e.
  `‖Δ(z)‖ =Θ exp(-2π·Im z)`.  Its `=O` half is Mathlib's own
  `ModularForm.exp_isBigO_discriminant`, proved there by a different argument.  A drifted `2π`,
  a lost `24` or an inverted `gcd` breaks this line.
* `rawOrder_level_two_twelve_pin` (arithmetic file) — the hand-computed `N = 2` example above.

## Scope, stated so it cannot be over-read

This is a statement about `‖f ∣ γ‖`, a nonnegative real.  It does NOT produce the eta multiplier,
it does not give the character `χ` of Ligozat's transformation law, and it does not by itself
prove that `f` is holomorphic at the cusps — for that one needs the order statement together with
holomorphy of the cusp expansion, and the `Θ` gives the vanishing order, not the expansion.  What
it does deliver is Ligozat's condition (iii) in analytic form: `f ∣[k] γ` is bounded at `i∞`
exactly when `ordRaw ≥ 0`, at every `γ`, and by `etaQuotientRawOrder_nonneg_iff` that is
Ligozat's own inequality.  `F3.2-OBSTRUCTED` (the multiplier for a general `γ ∈ Γ₀(N)`) is
untouched.

## FILE PLACEMENT

The node named `Lean/SocrateAI/ModularForms/EtaQuotient.lean`.  That file is the ARITHMETIC layer
(module docstring there: import cone `Nat.divisors` + `Nat.totient` and nothing analytic), and it
contains no `η`, no `ℍ` and no modular form; the same deviation was taken, for the same reason,
by every one of `F3.1-B1 … B13`.  The ARITHMETIC half of this node — `etaQuotientRawOrder`, the
width bridge `etaQuotientCuspOrder_eq_width_mul_raw`, `etaQuotientRawOrder_nonneg_iff`, the two
`ordRaw` pins and the numeric pin — IS in `EtaQuotient.lean`, as the node asked.  The analytic
half is here.
-/
import SocrateAI.ModularForms.EtaQuotientCuspOrder

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm Complex Filter Asymptotics
open UpperHalfPlane hiding I
open scoped MatrixGroups Real Topology

/-! ### Smith / Hermite data for `δ · γ` -/

namespace Smith

variable (δ : ℕ) (γ : SL(2, ℤ))

/-- `A = gcd(δ, c)`, the upper-left entry of the Hermite normal form of `δ·γ`. -/
def A : ℤ := (Int.gcd (δ : ℤ) (γ 1 0) : ℤ)

/-- `D = δ / A`, the lower-right entry of the Hermite normal form of `δ·γ`. -/
def D : ℤ := (δ : ℤ) / A δ γ

theorem A_dvd_delta : A δ γ ∣ (δ : ℤ) := Int.gcd_dvd_left _ _
theorem A_dvd_c : A δ γ ∣ γ 1 0 := Int.gcd_dvd_right _ _

theorem A_pos (hδ : 0 < δ) : 0 < A δ γ := by
  have h : Int.gcd (δ : ℤ) (γ 1 0) ≠ 0 := by
    simp only [ne_eq, Int.gcd_eq_zero_iff, not_and]
    intro h; omega
  simpa [A] using Nat.pos_of_ne_zero h

theorem A_mul_D : A δ γ * D δ γ = (δ : ℤ) :=
  Int.mul_ediv_cancel' (A_dvd_delta δ γ)

theorem D_pos (hδ : 0 < δ) : 0 < D δ γ := by
  have h := A_mul_D δ γ
  have hA := A_pos δ γ hδ
  have : (0:ℤ) < (δ : ℤ) := by exact_mod_cast hδ
  nlinarith

/-- `P = δ·a / A`, the `(0,0)` entry of the auxiliary `SL(2,ℤ)` matrix. -/
def P : ℤ := ((δ : ℤ) * γ 0 0) / A δ γ

/-- `S = c / A`, the `(1,0)` entry of the auxiliary `SL(2,ℤ)` matrix. -/
def S : ℤ := γ 1 0 / A δ γ

theorem P_mul_A : P δ γ * A δ γ = (δ : ℤ) * γ 0 0 :=
  Int.ediv_mul_cancel (Dvd.dvd.mul_right (A_dvd_delta δ γ) _)

theorem S_mul_A : S δ γ * A δ γ = γ 1 0 :=
  Int.ediv_mul_cancel (A_dvd_c δ γ)

theorem det_gamma : γ 0 0 * γ 1 1 - γ 0 1 * γ 1 0 = 1 := by
  have h2 := γ.property
  rw [Matrix.det_fin_two] at h2
  exact h2

/-- The `a`-side Bézout coefficient: `a·m + c·n = 1`, from `det γ = 1`. -/
theorem coprime_a_c : Int.gcd (γ 0 0) (γ 1 0) = 1 := by
  refine Int.isCoprime_iff_gcd_eq_one.mp ⟨γ 1 1, -γ 0 1, ?_⟩
  linear_combination det_gamma γ

/-- `U`, the Bézout coefficient of `P`. -/
def U : ℤ := Int.gcdA (δ : ℤ) (γ 1 0) * Int.gcdA (γ 0 0) (γ 1 0)

/-- `V`, the Bézout coefficient of `S`. -/
def V : ℤ :=
  (δ : ℤ) * Int.gcdA (δ : ℤ) (γ 1 0) * Int.gcdB (γ 0 0) (γ 1 0) + Int.gcdB (δ : ℤ) (γ 1 0)

theorem bezout_raw : (δ : ℤ) * γ 0 0 * U δ γ + γ 1 0 * V δ γ = A δ γ := by
  have h1 : A δ γ = (δ : ℤ) * Int.gcdA (δ : ℤ) (γ 1 0) + γ 1 0 * Int.gcdB (δ : ℤ) (γ 1 0) :=
    Int.gcd_eq_gcd_ab (δ : ℤ) (γ 1 0)
  have h2 : (1 : ℤ) = γ 0 0 * Int.gcdA (γ 0 0) (γ 1 0) + γ 1 0 * Int.gcdB (γ 0 0) (γ 1 0) := by
    have := Int.gcd_eq_gcd_ab (γ 0 0) (γ 1 0)
    rw [coprime_a_c γ] at this
    exact_mod_cast this
  simp only [U, V]
  linear_combination -h1 - ((δ : ℤ) * Int.gcdA (δ : ℤ) (γ 1 0)) * h2

theorem bezout (hδ : 0 < δ) : P δ γ * U δ γ + S δ γ * V δ γ = 1 := by
  have hA : A δ γ ≠ 0 := (A_pos δ γ hδ).ne'
  have h := bezout_raw δ γ
  rw [← P_mul_A δ γ, ← S_mul_A δ γ] at h
  have : A δ γ * (P δ γ * U δ γ + S δ γ * V δ γ) = A δ γ * 1 := by linarith [h]
  exact mul_left_cancel₀ hA this

/-- `E`, the upper-right entry of the Hermite normal form of `δ·γ`. -/
def E : ℤ := U δ γ * (δ : ℤ) * γ 0 1 + V δ γ * γ 1 1

theorem S_mul_E_add (hδ : 0 < δ) : S δ γ * E δ γ + U δ γ * D δ γ = γ 1 1 := by
  have hA : A δ γ ≠ 0 := (A_pos δ γ hδ).ne'
  refine mul_left_cancel₀ hA ?_
  simp only [E]
  linear_combination (U δ γ * (δ:ℤ) * γ 0 1 + V δ γ * γ 1 1) * S_mul_A δ γ
    + U δ γ * A_mul_D δ γ + γ 1 1 * bezout_raw δ γ
    - (U δ γ * (δ:ℤ)) * det_gamma γ

theorem P_mul_E_add (hδ : 0 < δ) : P δ γ * E δ γ + (-V δ γ) * D δ γ = (δ : ℤ) * γ 0 1 := by
  have hA : A δ γ ≠ 0 := (A_pos δ γ hδ).ne'
  refine mul_left_cancel₀ hA ?_
  simp only [E]
  linear_combination (U δ γ * (δ:ℤ) * γ 0 1 + V δ γ * γ 1 1) * P_mul_A δ γ
    - V δ γ * A_mul_D δ γ + ((δ:ℤ) * γ 0 1) * bezout_raw δ γ
    + ((δ:ℤ) * V δ γ) * det_gamma γ

/-- The auxiliary matrix `γ_δ = !![P, -V; S, U]`. -/
def gammaMat : Matrix (Fin 2) (Fin 2) ℤ := !![P δ γ, -V δ γ; S δ γ, U δ γ]

theorem gammaMat_det (hδ : 0 < δ) : (gammaMat δ γ).det = 1 := by
  rw [gammaMat, Matrix.det_fin_two_of]
  linear_combination bezout δ γ hδ

/-- The auxiliary element of `SL(2,ℤ)`. -/
def gam (hδ : 0 < δ) : SL(2, ℤ) := ⟨gammaMat δ γ, gammaMat_det δ γ hδ⟩

@[simp] theorem gam_zero_zero (hδ : 0 < δ) : (gam δ γ hδ) 0 0 = P δ γ := rfl
@[simp] theorem gam_zero_one (hδ : 0 < δ) : (gam δ γ hδ) 0 1 = -V δ γ := rfl
@[simp] theorem gam_one_zero (hδ : 0 < δ) : (gam δ γ hδ) 1 0 = S δ γ := rfl
@[simp] theorem gam_one_one (hδ : 0 < δ) : (gam δ γ hδ) 1 1 = U δ γ := rfl

/-- Auxiliary: the imaginary part of `(a z + e)/d` for real `a, e, d ≠ 0`. -/
theorem div_int_im (a e d : ℤ) (hd : (d : ℝ) ≠ 0) (z : ℂ) :
    (((a : ℂ) * z + (e : ℂ)) / (d : ℂ)).im = (a : ℝ) * z.im / (d : ℝ) := by
  have hd' : ((d : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hd
  have h : ((a : ℂ) * z + (e : ℂ)) / (d : ℂ)
      = (((a : ℝ) / (d : ℝ) : ℝ) : ℂ) * z + (((e : ℝ) / (d : ℝ) : ℝ) : ℂ) := by
    push_cast
    push_cast at hd'
    field_simp
  rw [h]
  simp
  ring

/-- The Hermite point `w_δ(z) = (A z + E)/D`, made TOTAL in `δ` (junk value `z` at `δ = 0`) so
that it can appear inside a `Finset.prod` over `N.divisors` without a dependent proof argument. -/
noncomputable def hpt (δ : ℕ) (γ : SL(2, ℤ)) (z : ℍ) : ℍ :=
  if h : 0 < δ then
    ⟨((A δ γ : ℂ) * (z : ℂ) + (E δ γ : ℂ)) / (D δ γ : ℂ), by
      have hD : (0 : ℝ) < (D δ γ : ℝ) := by exact_mod_cast D_pos δ γ h
      rw [div_int_im _ _ _ hD.ne' (z : ℂ)]
      have : (0 : ℝ) < (A δ γ : ℝ) := by exact_mod_cast A_pos δ γ h
      have hz : (0 : ℝ) < (z : ℂ).im := by simpa using z.im_pos
      positivity⟩
  else z

theorem coe_hpt (hδ : 0 < δ) (z : ℍ) :
    ((hpt δ γ z : ℍ) : ℂ) = ((A δ γ : ℂ) * (z : ℂ) + (E δ γ : ℂ)) / (D δ γ : ℂ) := by
  rw [hpt, dif_pos hδ]

theorem im_hpt (hδ : 0 < δ) (z : ℍ) :
    (hpt δ γ z).im = (A δ γ : ℝ) * z.im / (D δ γ : ℝ) := by
  have hD : (0 : ℝ) < (D δ γ : ℝ) := by exact_mod_cast D_pos δ γ hδ
  rw [show (hpt δ γ z).im = ((hpt δ γ z : ℍ) : ℂ).im from rfl, coe_hpt δ γ hδ z]
  exact div_int_im (A δ γ) (E δ γ) (D δ γ) hD.ne' (z : ℂ)

theorem denom_ne_zero_int (z : ℍ) :
    ((γ 1 0 : ℤ) : ℂ) * (z : ℂ) + ((γ 1 1 : ℤ) : ℂ) ≠ 0 := by
  have h := denom_ne_zero ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) z
  rw [ModularGroup.denom_apply] at h
  push_cast at h ⊢
  exact h

theorem denom_gam_hpt (hδ : 0 < δ) (z : ℍ) :
    denom ((gam δ γ hδ : SL(2, ℤ)) : GL (Fin 2) ℝ) ((hpt δ γ z : ℍ) : ℂ)
      = (((γ 1 0 : ℤ) : ℂ) * (z : ℂ) + ((γ 1 1 : ℤ) : ℂ)) / (D δ γ : ℂ) := by
  have hD : ((D δ γ : ℤ) : ℂ) ≠ 0 := by
    exact_mod_cast (D_pos δ γ hδ).ne'
  have h1 : (S δ γ : ℂ) * (A δ γ : ℂ) = ((γ 1 0 : ℤ) : ℂ) := by
    exact_mod_cast congrArg (fun n : ℤ => (n : ℂ)) (S_mul_A δ γ)
  have h2 : (S δ γ : ℂ) * (E δ γ : ℂ) + (U δ γ : ℂ) * (D δ γ : ℂ) = ((γ 1 1 : ℤ) : ℂ) := by
    exact_mod_cast congrArg (fun n : ℤ => (n : ℂ)) (S_mul_E_add δ γ hδ)
  rw [ModularGroup.denom_apply, gam_one_zero, gam_one_one, coe_hpt δ γ hδ z]
  push_cast
  field_simp
  linear_combination (z : ℂ) * h1 + h2

theorem coe_gam_smul_hpt (hδ : 0 < δ) (z : ℍ) :
    ((gam δ γ hδ • hpt δ γ z : ℍ) : ℂ) = (δ : ℂ) * ((γ • z : ℍ) : ℂ) := by
  have hD : ((D δ γ : ℤ) : ℂ) ≠ 0 := by
    exact_mod_cast (D_pos δ γ hδ).ne'
  have hden := denom_ne_zero_int γ z
  have hd2 : denom ((gam δ γ hδ : SL(2, ℤ)) : GL (Fin 2) ℝ) ((hpt δ γ z : ℍ) : ℂ) ≠ 0 :=
    denom_ne_zero _ _
  rw [denom_gam_hpt δ γ hδ z] at hd2
  have h1 : (S δ γ : ℂ) * (A δ γ : ℂ) = ((γ 1 0 : ℤ) : ℂ) := by
    exact_mod_cast congrArg (fun n : ℤ => (n : ℂ)) (S_mul_A δ γ)
  have h2 : (S δ γ : ℂ) * (E δ γ : ℂ) + (U δ γ : ℂ) * (D δ γ : ℂ) = ((γ 1 1 : ℤ) : ℂ) := by
    exact_mod_cast congrArg (fun n : ℤ => (n : ℂ)) (S_mul_E_add δ γ hδ)
  have h3 : (P δ γ : ℂ) * (A δ γ : ℂ) = (δ : ℂ) * ((γ 0 0 : ℤ) : ℂ) := by
    exact_mod_cast congrArg (fun n : ℤ => (n : ℂ)) (P_mul_A δ γ)
  have h4 : (P δ γ : ℂ) * (E δ γ : ℂ) + (-(V δ γ) : ℂ) * (D δ γ : ℂ)
      = (δ : ℂ) * ((γ 0 1 : ℤ) : ℂ) := by
    exact_mod_cast congrArg (fun n : ℤ => (n : ℂ)) (P_mul_E_add δ γ hδ)
  rw [coe_specialLinearGroup_apply, coe_specialLinearGroup_apply]
  rw [coe_hpt δ γ hδ z]
  simp only [gam_zero_zero, gam_zero_one, gam_one_zero, gam_one_one, eq_intCast]
  push_cast
  push_cast at hden hd2 h1 h2 h3 h4
  have hnum : (P δ γ : ℂ) * (((A δ γ : ℂ) * (z : ℂ) + (E δ γ : ℂ)) / (D δ γ : ℂ))
        + (-(V δ γ) : ℂ)
      = ((δ : ℂ) * (((γ 0 0 : ℤ) : ℂ) * (z : ℂ) + ((γ 0 1 : ℤ) : ℂ))) / (D δ γ : ℂ) := by
    field_simp
    linear_combination (z : ℂ) * h3 + h4
  have hdenw : (S δ γ : ℂ) * (((A δ γ : ℂ) * (z : ℂ) + (E δ γ : ℂ)) / (D δ γ : ℂ))
        + (U δ γ : ℂ)
      = (((γ 1 0 : ℤ) : ℂ) * (z : ℂ) + ((γ 1 1 : ℤ) : ℂ)) / (D δ γ : ℂ) := by
    field_simp
    linear_combination (z : ℂ) * h1 + h2
  have hcancel : ∀ X Y : ℂ, Y ≠ 0 →
      (X / (D δ γ : ℂ)) / (Y / (D δ γ : ℂ)) = X / Y := by
    intro X Y hY
    field_simp
  rw [hnum, hdenw, hcancel _ _ hden]
  ring

theorem denom_eq_int (z : ℍ) :
    denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)
      = ((γ 1 0 : ℤ) : ℂ) * (z : ℂ) + ((γ 1 1 : ℤ) : ℂ) := by
  rw [ModularGroup.denom_apply]

/-- **The Hermite step, in modulus.**  For every `δ ≥ 1` and every `γ ∈ SL(2,ℤ)`,

  `‖η(δ·(γz))‖ = √(‖cz+d‖ / D) · ‖η(w_δ(z))‖`,  `w_δ(z) = (A z + E)/D`, `A = gcd(δ,c)`, `A·D = δ`.

`F3.2-C1`'s `abs_eta_smul` applied at the auxiliary matrix `γ_δ = !![P,-V;S,U] ∈ SL(2,ℤ)`; the
`denom` that comes back is `denom γ z / D` (`denom_gam_hpt`). -/
theorem norm_eta_natMul_smul (hδ : 0 < δ) (z : ℍ) :
    ‖ModularForm.eta ((δ : ℂ) * ((γ • z : ℍ) : ℂ))‖
      = Real.sqrt (‖denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)‖ / (D δ γ : ℝ))
        * ‖ModularForm.eta ((hpt δ γ z : ℍ) : ℂ)‖ := by
  have hDpos : (0 : ℝ) < (D δ γ : ℝ) := by exact_mod_cast D_pos δ γ hδ
  have h := abs_eta_smul (gam δ γ hδ) (hpt δ γ z)
  rw [coe_gam_smul_hpt δ γ hδ z, denom_gam_hpt δ γ hδ z] at h
  have hnormD : ‖((D δ γ : ℤ) : ℂ)‖ = (D δ γ : ℝ) := by
    rw [show ((D δ γ : ℤ) : ℂ) = (((D δ γ : ℤ) : ℝ) : ℂ) by push_cast; ring,
      Complex.norm_real, Real.norm_eq_abs, abs_of_pos hDpos]
  rw [h, ← denom_eq_int γ z, norm_div, hnormD]

end Smith

/-! ### The modulus of `η` splits as its `q`-power times a tail that tends to `1` -/

/-- `‖η(z)‖ = e^{-π·Im z/12} · ‖∏'_n (1 - eta_q n z)‖`, for EVERY `z : ℂ`.  Mathlib's definition
`η = 𝕢 24 · ∏'(1 - eta_q n ·)` with `‖exp w‖ = exp (Re w)` and `Re (2πiz/24) = -π·Im z/12`. -/
theorem norm_eta_eq_exp_mul_tail (z : ℂ) :
    ‖ModularForm.eta z‖
      = Real.exp (-π * z.im / 12) * ‖∏' n : ℕ, (1 - ModularForm.eta_q n z)‖ := by
  rw [ModularForm.eta, norm_mul]
  congr 1
  rw [Function.Periodic.qParam, Complex.norm_exp]
  congr 1
  simp [Complex.div_re, Complex.mul_re, Complex.mul_im, Complex.normSq_apply]
  ring

/-- The `η` tail tends to `1` along `atImInfty`.  `F3.1-B12`'s
`tendsto_tprod_one_sub_eta_q_natCast_mul` at `δ = 1`. -/
theorem tendsto_tprod_one_sub_eta_q_atImInfty :
    Filter.Tendsto (fun w : ℍ => ∏' n : ℕ, (1 - ModularForm.eta_q n (w : ℂ)))
      UpperHalfPlane.atImInfty (nhds 1) := by
  have h := tendsto_tprod_one_sub_eta_q_natCast_mul (δ := 1) one_ne_zero
  simpa using h

/-- The Hermite map `z ↦ w_δ(z) = (A z + E)/D` pushes `atImInfty` to `atImInfty`, because
`Im w_δ(z) = (A/D)·Im z` and `A/D > 0`. -/
theorem tendsto_hpt_atImInfty (δ : ℕ) (γ : SL(2, ℤ)) (hδ : 0 < δ) :
    Filter.Tendsto (fun z : ℍ => Smith.hpt δ γ z) UpperHalfPlane.atImInfty
      UpperHalfPlane.atImInfty := by
  have hA : (0 : ℝ) < (Smith.A δ γ : ℝ) := by exact_mod_cast Smith.A_pos δ γ hδ
  have hD : (0 : ℝ) < (Smith.D δ γ : ℝ) := by exact_mod_cast Smith.D_pos δ γ hδ
  have hc : (0 : ℝ) < (Smith.A δ γ : ℝ) / (Smith.D δ γ : ℝ) := div_pos hA hD
  simp only [UpperHalfPlane.atImInfty, Filter.tendsto_comap_iff, Function.comp_def]
  have heq : (fun z : ℍ => (Smith.hpt δ γ z).im)
      = fun z : ℍ => ((Smith.A δ γ : ℝ) / (Smith.D δ γ : ℝ)) * z.im := by
    funext z
    rw [Smith.im_hpt δ γ hδ z]
    ring
  rw [heq]
  exact Filter.Tendsto.const_mul_atTop hc Filter.tendsto_comap

/-- The `η` tail evaluated at the Hermite point tends to `1` along `atImInfty`. -/
theorem tendsto_tprod_hpt (δ : ℕ) (γ : SL(2, ℤ)) (hδ : 0 < δ) :
    Filter.Tendsto
      (fun z : ℍ => ∏' n : ℕ, (1 - ModularForm.eta_q n ((Smith.hpt δ γ z : ℍ) : ℂ)))
      UpperHalfPlane.atImInfty (nhds 1) :=
  tendsto_tprod_one_sub_eta_q_atImInfty.comp (tendsto_hpt_atImInfty δ γ hδ)

/-- The full tail of the cusp expansion of `f ∣ γ` tends to `1` along `atImInfty`. -/
theorem tendsto_cuspTail (N : ℕ) (r : EtaExp) (γ : SL(2, ℤ)) :
    Filter.Tendsto
      (fun z : ℍ => ∏ δ ∈ N.divisors,
        ‖∏' n : ℕ, (1 - ModularForm.eta_q n ((Smith.hpt δ γ z : ℍ) : ℂ))‖ ^ (r δ))
      UpperHalfPlane.atImInfty (nhds 1) := by
  have h := tendsto_finsetProd (a := fun _ : ℕ => (1 : ℝ)) N.divisors fun δ hδ => by
    have hδ0 : 0 < δ := Nat.pos_of_mem_divisors hδ
    have h1 : Filter.Tendsto
        (fun z : ℍ => ‖∏' n : ℕ, (1 - ModularForm.eta_q n ((Smith.hpt δ γ z : ℍ) : ℂ))‖)
        UpperHalfPlane.atImInfty (nhds 1) := by
      simpa using (tendsto_tprod_hpt δ γ hδ0).norm
    simpa using h1.zpow₀ (r δ) (Or.inl one_ne_zero)
  simpa using h

/-! ### Bookkeeping helpers -/

/-- Real analogue of `prod_zpow_const`. -/
theorem prod_zpow_const_real (s : Finset ℕ) {c : ℝ} (hc : c ≠ 0) (f : ℕ → ℤ) :
    ∏ δ ∈ s, c ^ (f δ) = c ^ (∑ δ ∈ s, f δ) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert a t ha ih => rw [Finset.prod_insert ha, Finset.sum_insert ha, ih, zpow_add₀ hc]

/-- `(exp x)^m = exp (m·x)` for an INTEGER exponent `m`. -/
theorem real_exp_zpow (x : ℝ) (m : ℤ) : Real.exp x ^ m = Real.exp ((m : ℝ) * x) := by
  induction m using Int.induction_on with
  | zero => simp
  | succ n ih =>
      rw [zpow_add_one₀ (Real.exp_ne_zero x), ih, ← Real.exp_add]
      push_cast
      ring_nf
  | pred n ih =>
      rw [zpow_sub_one₀ (Real.exp_ne_zero x), ih, ← Real.exp_neg, ← Real.exp_add]
      push_cast
      ring_nf

namespace Smith

/-- `A/D = gcd(c,δ)² / δ`, the arithmetic content of the Hermite normal form: the exponent that
governs the decay of `η(w_δ)` is Ligozat's `gcd(c,δ)²/δ`. -/
theorem A_div_D_eq (δ : ℕ) (γ : SL(2, ℤ)) (hδ : 0 < δ) :
    (A δ γ : ℝ) / (D δ γ : ℝ) = (Int.gcd (γ 1 0) (δ : ℤ) : ℝ) ^ 2 / (δ : ℝ) := by
  have hAgcd : A δ γ = ((Int.gcd (γ 1 0) (δ : ℤ) : ℕ) : ℤ) := by
    rw [A, Int.gcd_comm]
  have hADr : (A δ γ : ℝ) * (D δ γ : ℝ) = (δ : ℝ) := by
    exact_mod_cast congrArg (fun n : ℤ => (n : ℝ)) (A_mul_D δ γ)
  have hD : ((D δ γ : ℝ)) ≠ 0 := by
    have := D_pos δ γ hδ
    exact_mod_cast this.ne'
  have hδr : ((δ : ℝ)) ≠ 0 := by positivity
  rw [hAgcd] at hADr ⊢
  field_simp
  linear_combination (-1 : ℝ) * (((Int.gcd (γ 1 0) (δ : ℤ) : ℕ) : ℝ)) * hADr

/-- Cross-multiplied form of `A/D = gcd(c,δ)²/δ`. -/
theorem A_mul_delta (δ : ℕ) (γ : SL(2, ℤ)) :
    (A δ γ : ℝ) * (δ : ℝ) = (Int.gcd (γ 1 0) (δ : ℤ) : ℝ) ^ 2 * (D δ γ : ℝ) := by
  have hAgcd : (A δ γ : ℝ) = ((Int.gcd (γ 1 0) (δ : ℤ) : ℕ) : ℝ) := by
    rw [A, Int.gcd_comm]; norm_cast
  have hADr : (A δ γ : ℝ) * (D δ γ : ℝ) = (δ : ℝ) := by
    exact_mod_cast congrArg (fun n : ℤ => (n : ℝ)) (A_mul_D δ γ)
  rw [← hAgcd]
  linear_combination (-1 : ℝ) * (A δ γ : ℝ) * hADr

end Smith

/-! ### The un-normalised Ligozat order and the exact modulus formula -/

theorem etaQuotientRawOrder_cast (N : ℕ) (r : EtaExp) (c : ℤ) :
    ((etaQuotientRawOrder N r c : ℚ) : ℝ)
      = (∑ δ ∈ N.divisors, ((Int.gcd c (δ : ℤ) : ℝ) ^ 2 * (r δ : ℝ)) / (δ : ℝ)) / 24 := by
  rw [etaQuotientRawOrder]
  push_cast
  ring

/-- **The exact modulus of `f ∣ γ`, for EVERY `γ ∈ SL(2,ℤ)`.**

  `‖f(γz)‖ = ‖cz+d‖^k · C(γ) · exp(-2π · ordRaw · Im z) · ∏_δ ‖tail_δ(z)‖^{r_δ}`

with `C(γ) = ∏_δ (√D_δ)^{-r_δ}` a positive constant and `tail_δ(z) = ∏'_n (1 - eta_q n w_δ(z))`
the `η`-tails at the Hermite points, which tend to `1` at `i∞` (`tendsto_cuspTail`).

This is an EQUALITY, not an estimate; all the analysis is in `tendsto_cuspTail`. -/
theorem norm_etaQuotientH_smul_eq (N : ℕ) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (γ : SL(2, ℤ)) (z : ℍ) :
    ‖etaQuotientH N r ((γ : SL(2, ℤ)) • z)‖
      = ‖denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)‖ ^ k
        * ((∏ δ ∈ N.divisors, (Real.sqrt (Smith.D δ γ : ℝ))⁻¹ ^ (r δ))
          * (Real.exp (-2 * π * ((etaQuotientRawOrder N r (γ 1 0) : ℚ) : ℝ) * z.im)
            * ∏ δ ∈ N.divisors,
                ‖∏' n : ℕ, (1 - ModularForm.eta_q n ((Smith.hpt δ γ z : ℍ) : ℂ))‖ ^ (r δ))) := by
  have hXpos : (0 : ℝ) < ‖denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)‖ :=
    norm_pos_iff.mpr (denom_ne_zero _ _)
  -- Step 0: the norm of the product is the product of the norms.
  have h0 : ‖etaQuotientH N r ((γ : SL(2, ℤ)) • z)‖
      = ∏ δ ∈ N.divisors,
          ‖ModularForm.eta ((δ : ℂ) * (((γ : SL(2, ℤ)) • z : ℍ) : ℂ))‖ ^ (r δ) := by
    rw [etaQuotientH_apply, norm_prod]
    exact Finset.prod_congr rfl fun δ _ => norm_zpow _ _
  -- Step 1: each factor, via the Hermite step and the `q`-power split of `‖η‖`.
  have hfac : ∀ δ ∈ N.divisors,
      ‖ModularForm.eta ((δ : ℂ) * (((γ : SL(2, ℤ)) • z : ℍ) : ℂ))‖ ^ (r δ)
        = (Real.sqrt ‖denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)‖) ^ (r δ)
          * ((Real.sqrt (Smith.D δ γ : ℝ))⁻¹ ^ (r δ)
            * ((Real.exp (-π * ((Smith.A δ γ : ℝ) * z.im / (Smith.D δ γ : ℝ)) / 12)) ^ (r δ)
              * ‖∏' n : ℕ, (1 - ModularForm.eta_q n ((Smith.hpt δ γ z : ℍ) : ℂ))‖ ^ (r δ))) := by
    intro δ hδm
    have hδ0 : 0 < δ := Nat.pos_of_mem_divisors hδm
    rw [Smith.norm_eta_natMul_smul δ γ hδ0 z, norm_eta_eq_exp_mul_tail,
      UpperHalfPlane.coe_im, Smith.im_hpt δ γ hδ0 z, Real.sqrt_div hXpos.le,
      div_eq_mul_inv, mul_assoc]
    simp only [mul_zpow]
  rw [h0, Finset.prod_congr rfl hfac, Finset.prod_mul_distrib, Finset.prod_mul_distrib,
    Finset.prod_mul_distrib]
  congr 1
  · -- the `√‖cz+d‖` factors collect into `‖cz+d‖^k`
    rw [prod_zpow_const_real _ (Real.sqrt_ne_zero'.mpr hXpos) r, hk,
      _root_.zpow_mul, zpow_two, Real.mul_self_sqrt hXpos.le]
  · congr 1
    -- the exponentials collect into a single exponential
    have hstep : ∀ δ ∈ N.divisors,
        (Real.exp (-π * ((Smith.A δ γ : ℝ) * z.im / (Smith.D δ γ : ℝ)) / 12)) ^ (r δ)
          = Real.exp ((-2 * π * z.im / 24)
              * (((Int.gcd (γ 1 0) (δ : ℤ) : ℝ) ^ 2 * (r δ : ℝ)) / (δ : ℝ))) := by
      intro δ hδm
      have hδ0 : 0 < δ := Nat.pos_of_mem_divisors hδm
      have hD : ((Smith.D δ γ : ℝ)) ≠ 0 := by
        have := Smith.D_pos δ γ hδ0
        exact_mod_cast this.ne'
      have hδr : ((δ : ℝ)) ≠ 0 := by positivity
      rw [real_exp_zpow]
      congr 1
      have hAD := Smith.A_mul_delta δ γ
      field_simp
      linear_combination (-24 : ℝ) * (r δ : ℝ) * hAD
    rw [Finset.prod_congr rfl hstep, ← Real.exp_sum, ← Finset.mul_sum,
      etaQuotientRawOrder_cast]
    congr 1
    ring

/-! ### From the exact formula to the `Θ`-statement -/

/-- If `u → c ≠ 0` along `l`, then `u·g =Θ[l] g`.  The only asymptotic input of `F3.2-C2`. -/
theorem isTheta_mul_of_tendsto {α : Type*} {l : Filter α} {u g : α → ℝ} {c : ℝ}
    (hc : c ≠ 0) (hu : Filter.Tendsto u l (nhds c)) :
    (fun x => u x * g x) =Θ[l] g := by
  have hcpos : 0 < |c| := abs_pos.mpr hc
  have hb : ∀ᶠ x in l, |c| / 2 < |u x| :=
    hu.abs.eventually (eventually_gt_nhds (by linarith))
  constructor
  · simpa using (hu.isBigO_one ℝ).mul (Asymptotics.isBigO_refl g l)
  · refine Asymptotics.IsBigO.of_bound (2 / |c|) ?_
    filter_upwards [hb] with x hx
    rw [Real.norm_eq_abs, Real.norm_eq_abs, abs_mul, div_mul_eq_mul_div, le_div_iff₀ hcpos]
    nlinarith [abs_nonneg (g x), hx]

/-- The constant `C(γ) = ∏_{δ ∣ N} (√D_δ)^{-r_δ}` of the exact modulus formula is nonzero. -/
theorem cuspConst_ne_zero (N : ℕ) (r : EtaExp) (γ : SL(2, ℤ)) :
    (∏ δ ∈ N.divisors, (Real.sqrt (Smith.D δ γ : ℝ))⁻¹ ^ (r δ)) ≠ 0 := by
  refine Finset.prod_ne_zero_iff.mpr fun δ hδm => ?_
  have hδ0 : 0 < δ := Nat.pos_of_mem_divisors hδm
  have hD : (0 : ℝ) < (Smith.D δ γ : ℝ) := by exact_mod_cast Smith.D_pos δ γ hδ0
  exact zpow_ne_zero _ (inv_ne_zero (Real.sqrt_ne_zero'.mpr hD))

/-- **F3.2-C2 — Ligozat's cusp-order formula, as a `Θ`-asymptotic.**

For EVERY level `N`, every integer exponent vector `r` of even weight-sum `Σ r_δ = 2k`, and
EVERY `γ ∈ SL(2,ℤ)` (no congruence condition, no `Γ₀(N)`-membership, no character):

  `‖(f ∣[k] γ)(z)‖  =Θ[atImInfty]  exp(-2π · ordRaw(N, r, c) · Im z)`,  `c = γ 1 0`,

with `ordRaw(N,r,c) = (1/24) Σ_{δ ∣ N} gcd(c,δ)² r_δ / δ` — Ligozat's cusp order DIVIDED BY the
cusp width; see `etaQuotientCuspOrder_eq_width_mul_raw` and the scope note in the module
docstring. -/
theorem etaQuotient_cusp_order (N : ℕ) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (γ : SL(2, ℤ)) :
    (fun z : ℍ => ‖(etaQuotientH N r ∣[k] ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ)) z‖)
      =Θ[UpperHalfPlane.atImInfty]
      fun z : ℍ => Real.exp (-2 * π * ((etaQuotientRawOrder N r (γ 1 0) : ℚ) : ℝ) * z.im) := by
  set C : ℝ := ∏ δ ∈ N.divisors, (Real.sqrt (Smith.D δ γ : ℝ))⁻¹ ^ (r δ) with hCdef
  have hC : C ≠ 0 := cuspConst_ne_zero N r γ
  have hpt : ∀ z : ℍ, ‖(etaQuotientH N r ∣[k] ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ)) z‖
      = (C * ∏ δ ∈ N.divisors,
            ‖∏' n : ℕ, (1 - ModularForm.eta_q n ((Smith.hpt δ γ z : ℍ) : ℂ))‖ ^ (r δ))
        * Real.exp (-2 * π * ((etaQuotientRawOrder N r (γ 1 0) : ℚ) : ℝ) * z.im) := by
    intro z
    have hXne : ‖denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)‖ ≠ 0 :=
      norm_ne_zero_iff.mpr (denom_ne_zero _ _)
    rw [← ModularForm.SL_slash, ModularForm.SL_slash_apply, norm_mul, norm_zpow,
      norm_etaQuotientH_smul_eq N r hk γ z]
    rw [← hCdef]
    rw [_root_.zpow_neg]
    field_simp
  rw [funext hpt]
  exact isTheta_mul_of_tendsto hC (by
    simpa using (tendsto_const_nhds (x := C) (f := UpperHalfPlane.atImInfty)).mul
      (tendsto_cuspTail N r γ))

/-! ### F3.2-C2 — the Ligozat-normalised form, and the LL-1 guards -/

/-- The slash at the identity does nothing to the modulus. -/
theorem norm_slash_one (N : ℕ) (r : EtaExp) (k : ℤ) (z : ℍ) :
    ‖(etaQuotientH N r ∣[k] ((1 : SL(2, ℤ)) : GL (Fin 2) ℝ)) z‖ = ‖etaQuotientH N r z‖ := by
  rw [← ModularForm.SL_slash, ModularForm.SL_slash_apply]
  simp

/-- **F3.2-C2 in Ligozat's own normalisation.**  For a cusp of denominator `d ∣ N`, represented by
a `γ ∈ SL(2,ℤ)` with lower-left entry `d`,

  `‖(f ∣[k] γ)(z)‖ =Θ[atImInfty] exp(-2π · (ord_Ligozat / h) · Im z)`,  `h = N / gcd(d², N)`.

The division by the width `h` is NOT cosmetic and is not an artefact of this formalisation: see
the block comment on `etaQuotientRawOrder` in `SocrateAI.ModularForms.EtaQuotient`. -/
theorem etaQuotient_cusp_order_ligozat (N : ℕ) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (γ : SL(2, ℤ)) {d : ℕ} (hN : N ≠ 0) (hd : d ∣ N)
    (hγ : γ 1 0 = (d : ℤ)) :
    (fun z : ℍ => ‖(etaQuotientH N r ∣[k] ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ)) z‖)
      =Θ[UpperHalfPlane.atImInfty]
      fun z : ℍ => Real.exp (-2 * π
        * ((etaQuotientCuspOrder N r d / ((N : ℚ) / (Nat.gcd (d ^ 2) N : ℚ)) : ℚ) : ℝ) * z.im) := by
  have hg : 0 < Nat.gcd (d ^ 2) N := Nat.gcd_pos_of_pos_right _ (Nat.pos_of_ne_zero hN)
  have hw : (0 : ℚ) < (N : ℚ) / (Nat.gcd (d ^ 2) N : ℚ) := by
    have h1 : (0 : ℚ) < (N : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero hN
    have h2 : (0 : ℚ) < (Nat.gcd (d ^ 2) N : ℚ) := by exact_mod_cast hg
    exact div_pos h1 h2
  have hraw : etaQuotientCuspOrder N r d / ((N : ℚ) / (Nat.gcd (d ^ 2) N : ℚ))
      = etaQuotientRawOrder N r (d : ℤ) := by
    rw [etaQuotientCuspOrder_eq_width_mul_raw hd r, mul_comm,
      mul_div_assoc, div_self hw.ne', mul_one]
  rw [hraw, ← hγ]
  exact etaQuotient_cusp_order N r hk γ

/-! #### LL-1 guard 1 — the cusp `∞`, by two independent routes

Route A is `F3.2-C2` itself specialised to `γ = 1`: the Hermite decomposition, `abs_eta_smul`
(i.e. Mathlib's `Δ`-modularity) and the constant `C(γ)`.  Route B never leaves the `q`-product:
`F3.1-B12`'s `tendsto_etaQuotientH_div_qpow` says `f / q^{ord_∞} → 1` at `i∞`, and the modulus of
`q^{ord_∞} = exp(2πiz·ord_∞)` is `exp(-2π·ord_∞·Im z)` by `Complex.norm_exp`.  The two routes
share no step; a drifted exponent, a lost factor `24` or an inverted `gcd` in either would break
`cusp_order_infty_guard`. -/

/-- The modulus of the leading `q`-power. -/
theorem norm_qpow_cuspOrder (N : ℕ) (r : EtaExp) (z : ℍ) :
    ‖Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (z : ℂ)
        * ((etaQuotientCuspOrder N r N : ℚ) : ℂ))‖
      = Real.exp (-2 * π * ((etaQuotientCuspOrder N r N : ℚ) : ℝ) * z.im) := by
  rw [show (2 * (Real.pi : ℂ) * Complex.I * (z : ℂ)
        * ((etaQuotientCuspOrder N r N : ℚ) : ℂ))
      = (((2 * π * ((etaQuotientCuspOrder N r N : ℚ) : ℝ)) : ℝ) : ℂ) * (Complex.I * (z : ℂ)) by
    push_cast; ring]
  rw [Complex.norm_exp]
  congr 1
  simp [Complex.mul_re]

/-- **Route B.**  `‖f(z)‖ =Θ exp(-2π·ord_∞·Im z)` at `i∞`, straight from the `q`-product
(F3.1-B11 + F3.1-B12).  No Hermite decomposition, no `abs_eta_smul`, no `Δ`. -/
theorem norm_etaQuotientH_isTheta_infty (N : ℕ) (hN : N ≠ 0) (r : EtaExp) :
    (fun z : ℍ => ‖etaQuotientH N r z‖)
      =Θ[UpperHalfPlane.atImInfty]
      fun z : ℍ => Real.exp (-2 * π * ((etaQuotientCuspOrder N r N : ℚ) : ℝ) * z.im) := by
  have hsplit : ∀ z : ℍ, ‖etaQuotientH N r z‖
      = ‖etaQuotientH N r z / Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (z : ℂ)
            * ((etaQuotientCuspOrder N r N : ℚ) : ℂ))‖
        * Real.exp (-2 * π * ((etaQuotientCuspOrder N r N : ℚ) : ℝ) * z.im) := by
    intro z
    rw [norm_div, ← norm_qpow_cuspOrder N r z, div_mul_cancel₀]
    exact norm_ne_zero_iff.mpr (Complex.exp_ne_zero _)
  rw [funext hsplit]
  refine isTheta_mul_of_tendsto one_ne_zero ?_
  simpa using (tendsto_etaQuotientH_div_qpow N hN r).norm

/-- **THE GUARD.**  Routes A and B deliver the same `Θ`-statement at the cusp `∞`.  The first
component is `F3.2-C2` at `γ = 1` (with `etaQuotientRawOrder_infty` converting the un-normalised
order into Ligozat's `ord_∞`, legitimate because the width of `∞` is `1`); the second is the
`q`-product route.  `norm_slash_one` says the two left-hand sides are the same function. -/
theorem cusp_order_infty_guard (N : ℕ) (hN : N ≠ 0) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) :
    ((fun z : ℍ => ‖(etaQuotientH N r ∣[k] ((1 : SL(2, ℤ)) : GL (Fin 2) ℝ)) z‖)
        =Θ[UpperHalfPlane.atImInfty]
        fun z : ℍ => Real.exp (-2 * π * ((etaQuotientCuspOrder N r N : ℚ) : ℝ) * z.im))
      ∧ ((fun z : ℍ => ‖etaQuotientH N r z‖)
        =Θ[UpperHalfPlane.atImInfty]
        fun z : ℍ => Real.exp (-2 * π * ((etaQuotientCuspOrder N r N : ℚ) : ℝ) * z.im)) := by
  refine ⟨?_, norm_etaQuotientH_isTheta_infty N hN r⟩
  have h := etaQuotient_cusp_order N r hk 1
  rw [show ((1 : SL(2, ℤ)) 1 0) = 0 by simp, etaQuotientRawOrder_infty N hN r] at h
  exact h

/-! #### LL-1 guard 2 — the discriminant, against Mathlib

At `N = 1`, `r ≡ 24`, `k = 12` the eta quotient IS Mathlib's `Δ` (`etaQuotientH_level_one_24`),
and `F3.2-C2` returns `ord = 1` at every `γ`, i.e. `‖Δ(z)‖ =Θ exp(-2π·Im z)`.  Mathlib proves the
`=O` half of exactly that, `ModularForm.exp_isBigO_discriminant`, by a completely different
argument (a lower bound on the `q`-product on a ball).  So the constant `24`, the factor `2π` and
the whole Hermite bookkeeping are pinned against an authority outside this development. -/

/-- `‖Δ(z)‖ =Θ[atImInfty] exp(-2π·Im z)`, out of `F3.2-C2`. -/
theorem norm_discriminant_isTheta :
    (fun z : ℍ => ‖ModularForm.discriminant z‖)
      =Θ[UpperHalfPlane.atImInfty] fun z : ℍ => Real.exp (-2 * π * z.im) := by
  have hk : ∑ δ ∈ (1 : ℕ).divisors, (fun _ : ℕ => (24 : ℤ)) δ = 2 * 12 := by simp
  have h := etaQuotient_cusp_order 1 (fun _ => (24 : ℤ)) hk 1
  rw [etaQuotientRawOrder_one_24] at h
  have hfun : (fun z : ℍ =>
      ‖(etaQuotientH 1 (fun _ => (24 : ℤ)) ∣[(12 : ℤ)] ((1 : SL(2, ℤ)) : GL (Fin 2) ℝ)) z‖)
      = fun z : ℍ => ‖ModularForm.discriminant z‖ := by
    funext z
    rw [norm_slash_one, etaQuotientH_level_one_24]
  rw [hfun] at h
  simpa using h

/-- **THE EXTERNAL PIN.**  `F3.2-C2` reproves Mathlib's `exp_isBigO_discriminant`.  If the
exponent of `F3.2-C2` were off by any factor this would stop compiling. -/
theorem exp_isBigO_discriminant_of_cusp_order :
    (fun z : ℍ => Real.exp (-2 * π * z.im))
      =O[UpperHalfPlane.atImInfty] ModularForm.discriminant :=
  Asymptotics.isBigO_norm_right.mp norm_discriminant_isTheta.2

end SocrateAI.ModularForms
