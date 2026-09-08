/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.
-/
import SocrateAI.ModularForms.EtaLigozatKronecker
import SocrateAI.ModularForms.EtaMultiplierNeg

/-!
# ETA-01 — Ligozat's criterion at general `N`, in Kronecker-character form

The node's three declarations, verbatim from the run brief:

* `ligozat_general`      — `w(γ) = ( (-1)^k ∏_{δ ∣ N} δ^{r_δ} / γ₁₁ )` for **every** `γ ∈ Γ₀(N)`;
* `ligozat_kronecker_transform` — the same as a transformation law for `f = ∏_δ η(δz)^{r_δ}`;
* `etaQuotientModularFormGeneral` — the packaged `ModularForm (Γ₀ N) k`.

## STATUS, first, because it is the headline (LL-1 / LL-2)

**ETA-01 IS NOT CLOSED BY THIS FILE.**  What is here:

* **PROVED, `sorry`-free — the `c ≤ 0` half of ETA-01, at every `N`.**  `etaMultiplierVal_neg_c`
  (`c < 0`) and `etaMultiplierVal_c_zero` (`c = 0`, i.e. `γ = ±T^n`) evaluate the multiplier
  against the Kronecker symbol on the whole of `Γ₀(N) ∖ {c > 0}` from `DRK-08`, the Kronecker
  sign law proved here (`kroneckerSym_neg_right_of_neg`) and Ligozat's congruence (i).  Before
  this file the `c ≤ 0` cases were *named* as missing by `DRK-09` and `DRK-11`; they are now
  theorems.
* **PROVED, `sorry`-free — ETA-01 in full, for `0 < N ≤ 4`**: `etaMultiplierVal_eq_kroneckerSym_of_le_four`,
  `ligozat_kronecker_transform_of_le_four`, and the genuine `ModularForm (Γ₀ N) k` term
  `etaQuotientModularFormOfLeFour`.  This is ETA-01's exact statement on a nonempty domain.
* **NOT PROVED — the general-`N` case.**  `ligozat_general` and everything packaged on top of it
  reduce, by the trichotomy above, to **exactly one** open input: `DRK-11`
  (`exp_etaPhiSum_eq_kroneckerSym`, the `c > 0` slice).  That is the *only* `sorry` in this
  file's cone that is not already recorded against `DRK-11`.  See `ETA01_OPEN` below.

So this file's contribution to ETA-01 is: **the node now has one missing input instead of
three**, and that input is `DRK-11`, which is already an open DAG node with its own gate.

## A STATEMENT IN THIS LIBRARY IS REFUTED HERE (LL-1, loudly)

`EtaMultiplier.lean` carries an ETA-01 statement of a *different* shape —
`ligozat_trivial_multiplier_of_twelve_dvd` (called `ligozat_general` before this run) — asserting
that under Ligozat's congruences **plus `12 ∣ k`** the multiplier is **trivial**:
`f(γz) = (cz+d)^k f(z)` on all of `Γ₀(N)`.  **That statement is false.**  The witness is

  `N = 17`, `r = (r₁, r₁₇) = (21, 3)`, `k = 12`, `γ = !![6, 1; 17, 3] ∈ Γ₀(17)`.

All of its hypotheses hold — `Σ_δ r_δ = 24 = 2k`, `Σ_δ δ r_δ = 72 = 24·3`,
`Σ_δ (17/δ) r_δ = 360 = 24·15`, `12 ∣ 12` — and the character value is
`(17³ / 3) = (4913 / 3) = J(2 | 3) = -1`, not `1`.  A 4000-term `η`-product evaluation of
`w(γ) = f(γz)/((cz+d)^k f(z))` at `z = -3/17 + (0.37 + i)/17` returns
`-1.0000000000000 - 1.1e-14 i`.

`eta01_seventeen_refutes_trivial_multiplier` below makes the incompatibility **machine-checked
and `sorry`-free**: the two statements cannot both hold at that single `γ`, because the first
forces `w(γ) = 1` and the second forces `w(γ) = -1`.  Which one is wrong is settled by the
numerics and by the classical literature (Ligozat's character is a Kronecker symbol, not the
trivial character): it is the `12 ∣ k` one.  It has been renamed rather than deleted, its
docstring now says so, and its `sorry` stays — it is not "open work", it is a **false
statement**, and nobody should spend a day on it.

## PROVENANCE — INDEPENDENT

Nothing in this file is ported.  `anthropics/fermats-last-theorem` has no `ligozat`, no Kronecker
*symbol*, and no eta quotient with a nontrivial character (its `etaProductEleven_transform` is
the `N = 11`, trivial-character instance); Mathlib at our pinned revision has no `ligozat`,
`kroneckerSym`, `etaQuotient` or `dedekindSum`.  The `c ≤ 0` reduction, the Kronecker sign law
and the `N = 17` refutation are derived here from our own `DRK-08`, `DRK-11A`, run 3's
`multiplier_eq_kronecker_of_le_four` and Mathlib's `jacobiSym`.  See `ATTRIBUTION.md §ETA-01`.

## LL-22

Every Dedekind symbol reachable from this file is Apostol's `s(h,k)` (`dedekindSum`) through
`etaPhiSum`; Apostol's `Φ` is `rademacherPhi`.  Rademacher's `Ψ` (`rademacherPsi`) appears
nowhere in this file.
-/

set_option autoImplicit false

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm
open UpperHalfPlane hiding I
open scoped MatrixGroups Real
open SocrateAI.NumberTheory

/-! ## ETA-01, part 0 — SIGN-DISCIPLINE GATE (LL-22)

Nothing below may be used before this block.  Every value was computed **outside Lean** first
(python3, exact `fractions.Fraction`; `Int.fract`, `dedekindSaw`, `dedekindSum`, `etaPhiSum`,
`kroneckerPrime`, `kroneckerSym`, `ligozatKroneckerNum` re-implemented from the Lean SOURCE, and
that re-implementation reproduces every `decide +kernel` pin of `DedekindSum.lean`,
`EtaPhiSum.lean` and `EtaLigozatKronecker.lean` exactly).  Only then was it written here.

The pins are chosen to exercise **the two sign laws this file's `c ≤ 0` reduction turns on**:

* `(a / -d)` versus `(a / d)` — equal when the numerator is `> 0`, negated when it is `< 0`;
* the numerator `(-1)^k ∏ δ^{r_δ}` is `> 0` exactly when `k` is even.

If either law were stated with the wrong sign, the `c < 0` branch would silently produce the
negative of the truth at every odd weight, and *only* the odd-weight pins would catch it. -/

section SignDisciplineGate

/-- `N = 17`, `r = (21, 3)`, `k = 12` — the vector that REFUTES the `12 ∣ k` form of ETA-01. -/
def eta01R17 : EtaExp := fun d => if d = 1 then 21 else if d = 17 then 3 else 0

/-- `γ = !![6, 1; 17, 3] ∈ Γ₀(17)`, `c = 17 > 0`, `d = 3`. -/
def eta01MatN17 : SL(2, ℤ) := slOf 6 1 17 3 (by decide)

/-- `γ = !![-1, 0; -3, -1] = -!![1, 0; 3, 1] ∈ Γ₀(3)`: `c = -3 < 0`, `d = -1`. -/
def eta01MatN3negA : SL(2, ℤ) := slOf (-1) 0 (-3) (-1) (by decide)

/-- `γ = !![-2, -1; -3, -2] = -!![2, 1; 3, 2] ∈ Γ₀(3)`: `c = -3 < 0`, `d = -2` NEGATIVE EVEN. -/
def eta01MatN3negB : SL(2, ℤ) := slOf (-2) (-1) (-3) (-2) (by decide)

/-! ### PINS 1–4 — the numerator and its SIGN

`ligozatKroneckerNum N r k = (-1)^{|k|} ∏_{δ ∣ N} δ^{|r_δ|}`.  Independent values:
`(17, r, 12) ↦ 1 · 1²¹ · 17³ = 4913 > 0` (even `k`); `(3, (-3,9), 3) ↦ -1 · 1³ · 3⁹ = -19683 < 0`
(odd `k`); `(1, 24, 12) ↦ 1 · 1²⁴ = 1 > 0`. -/

/-- PIN 1 — `k = 12` EVEN, numerator `17³ = 4913 > 0`. -/
theorem eta01_pin_num_N17 : ligozatKroneckerNum 17 eta01R17 12 = 4913 := by decide

/-- PIN 2 — the sign, even `k`. -/
theorem eta01_pin_num_N17_pos : 0 < ligozatKroneckerNum 17 eta01R17 12 := by decide

/-- PIN 3 — `k = 3` ODD, numerator `-3⁹ = -19683 < 0`.  (`drk11R3` is `EtaLigozatKronecker`'s
`N = 3`, `r = (-3, 9)` vector; `drk11_num_N3` pins the value, this pins the SIGN.) -/
theorem eta01_pin_num_N3_neg : ligozatKroneckerNum 3 drk11R3 3 < 0 := by decide

/-- PIN 4 — `k = -3` NEGATIVE ODD still gives a negative numerator: the exponent is `|k|`. -/
theorem eta01_pin_num_N3_neg_k : ligozatKroneckerNum 3 drk11R3' (-3) < 0 := by decide

/-! ### PINS 5–10 — the Kronecker sign law `(a / -d)` vs `(a / d)` -/

/-- PIN 5 — numerator `> 0`, `d = 3`: `(4913 / 3) = J(2 | 3) = -1`.  This is the value that
refutes the `12 ∣ k` statement. -/
theorem eta01_pin_sym_N17_pos_d : kroneckerSym 4913 (3 : ℤ) = -1 := by
  rw [show (3 : ℤ) = ((3 : ℕ) : ℤ) from rfl, kroneckerSym_eq_jacobiSym_of_odd' (by decide)]
  norm_num

/-- PIN 6 — numerator `> 0`, `d = -3`: **unchanged**, `(4913 / -3) = -1`. -/
theorem eta01_pin_sym_N17_neg_d : kroneckerSym 4913 (-3 : ℤ) = -1 := by
  have h := eta01_pin_sym_N17_pos_d
  rw [kroneckerSym, if_neg (by norm_num : (3 : ℤ) ≠ 0),
    if_neg (by norm_num : ¬((4913 : ℤ) < 0 ∧ (3 : ℤ) < 0)), one_mul] at h
  rw [kroneckerSym, if_neg (by norm_num : (-3 : ℤ) ≠ 0),
    if_neg (by norm_num : ¬((4913 : ℤ) < 0 ∧ (-3 : ℤ) < 0)), one_mul,
    show ((-3 : ℤ)).natAbs = ((3 : ℤ)).natAbs from rfl]
  exact h

/-- PIN 7 — numerator `< 0`, `d = 1`: `(-19683 / 1) = 1` (empty product, no sign factor). -/
theorem eta01_pin_sym_N3_one : kroneckerSym (-19683) (1 : ℤ) = 1 := kroneckerSym_one_right _

/-- PIN 8 — numerator `< 0`, `d = -1`: `(-19683 / -1) = -1`.  **The sign flips.** -/
theorem eta01_pin_sym_N3_neg_one : kroneckerSym (-19683) (-1 : ℤ) = -1 :=
  kroneckerSym_neg_one_right_of_neg (by norm_num)

/-- PIN 9 — numerator `< 0`, `d = 2` EVEN (the `χ₈` branch): `(-19683 / 2) = -1`. -/
theorem eta01_pin_sym_N3_two : kroneckerSym (-19683) (2 : ℤ) = -1 := drk11_sym_N3b

/-- PIN 10 — numerator `< 0`, `d = -2`: `(-19683 / -2) = +1`.  **The sign flips**, and it flips
on the `χ₈` branch too — this is the pin that a proof handling only odd `d` would fail. -/
theorem eta01_pin_sym_N3_neg_two : kroneckerSym (-19683) (-2 : ℤ) = 1 := drk11_sym_N3c

/-! ### PINS 11–14 — the matrices -/

theorem eta01_pin_N17_entries :
    eta01MatN17 1 0 = 17 ∧ eta01MatN17 1 1 = 3 ∧ 0 < eta01MatN17 1 0 := by decide

theorem eta01_pin_N17_mem : eta01MatN17 ∈ Gamma0 17 := by
  rw [Gamma0_mem, show eta01MatN17 1 0 = 17 from by decide]
  decide

theorem eta01_pin_N3negA_entries :
    eta01MatN3negA 1 0 = -3 ∧ eta01MatN3negA 1 1 = -1 ∧ eta01MatN3negA 1 0 < 0 := by decide

theorem eta01_pin_N3negB_entries :
    eta01MatN3negB 1 0 = -3 ∧ eta01MatN3negB 1 1 = -2 ∧ eta01MatN3negB 1 0 < 0 := by decide

/-! ### PINS 15–16 — Ligozat's hypotheses at the refuting vector, and `12 ∣ k` -/

theorem eta01_pin_R17_sum : ∑ δ ∈ (17 : ℕ).divisors, eta01R17 δ = 2 * 12 := by decide

theorem eta01_pin_R17_congr1_value :
    ∑ δ ∈ (17 : ℕ).divisors, (δ : ℤ) * eta01R17 δ = 72 := by decide

theorem eta01_pin_R17_congr2_value :
    ∑ δ ∈ (17 : ℕ).divisors, ((17 / δ : ℕ) : ℤ) * eta01R17 δ = 360 := by decide

theorem eta01_R17_congr1 : LigozatCongr1 17 eta01R17 :=
  ⟨3, by rw [eta01_pin_R17_congr1_value]; norm_num⟩

theorem eta01_R17_congr2 : LigozatCongr2 17 eta01R17 :=
  ⟨15, by rw [eta01_pin_R17_congr2_value]; norm_num⟩

/-- `12 ∣ 12`: the extra hypothesis of the refuted statement really is satisfied here. -/
theorem eta01_pin_twelve_dvd : (12 : ℤ) ∣ (12 : ℤ) := ⟨1, by norm_num⟩

/-! ### NEGATIVE CONTROLS FOR THE GATE

Each shows a sign law that a careless proof might state instead, and that is FALSE. -/

/-- NEGATIVE CONTROL 1 — `(a / -d) = (a / d)` is FALSE for a negative numerator. -/
theorem eta01_neg_control_sign_law_needs_numerator_sign :
    kroneckerSym (-19683) (-1 : ℤ) ≠ kroneckerSym (-19683) (1 : ℤ) := by
  rw [eta01_pin_sym_N3_neg_one, eta01_pin_sym_N3_one]; norm_num

/-- NEGATIVE CONTROL 2 — `(a / -d) = -(a / d)` is FALSE for a positive numerator. -/
theorem eta01_neg_control_sign_law_not_always_flip :
    kroneckerSym 4913 (-3 : ℤ) ≠ -kroneckerSym 4913 (3 : ℤ) := by
  rw [eta01_pin_sym_N17_neg_d, eta01_pin_sym_N17_pos_d]; norm_num

end SignDisciplineGate


/-! ## ETA-01, part 1 — the Kronecker sign law

Two lemmas about `kroneckerSym a (-d)` versus `kroneckerSym a d`, read straight off the
definition.  They are the only place the `c < 0` branch can go wrong, and PINS 5–10 above are
their instances. -/

section SignLaw

/-- `(a / -d) = (a / d)` when `a ≥ 0`: the sign factor `[a < 0 ∧ d < 0]` never fires, and
`|-d| = |d|` so the prime-factor product is unchanged.  `d = 0` is included (`-0 = 0`). -/
theorem kroneckerSym_neg_right_of_nonneg {a : ℤ} (ha : 0 ≤ a) (d : ℤ) :
    kroneckerSym a (-d) = kroneckerSym a d := by
  rcases eq_or_ne d 0 with rfl | hd
  · norm_num
  · rw [kroneckerSym, kroneckerSym, if_neg (neg_ne_zero.mpr hd), if_neg hd,
      if_neg (fun h => absurd h.1 (not_lt.mpr ha)),
      if_neg (fun h => absurd h.1 (not_lt.mpr ha)), Int.natAbs_neg]

/-- `(a / -d) = -(a / d)` when `a < 0` and `d ≠ 0`: exactly one of `d < 0`, `-d < 0` holds, so
the sign factor fires on exactly one side.  **`d ≠ 0` is load-bearing** — at `d = 0` both sides
are `(a / 0)` and the identity would force `(a/0) = -(a/0)`. -/
theorem kroneckerSym_neg_right_of_neg {a : ℤ} (ha : a < 0) {d : ℤ} (hd : d ≠ 0) :
    kroneckerSym a (-d) = -kroneckerSym a d := by
  rw [kroneckerSym, kroneckerSym, if_neg (neg_ne_zero.mpr hd), if_neg hd, Int.natAbs_neg]
  rcases lt_or_gt_of_ne hd with h | h
  · rw [if_neg (fun hh => absurd hh.2 (by omega)), if_pos ⟨ha, h⟩]; ring
  · rw [if_pos ⟨ha, by omega⟩, if_neg (fun hh => absurd hh.2 (by omega))]; ring

/-- The divisor product `∏_{δ ∣ N} δ^{|r_δ|}` is strictly positive: every `δ ∈ N.divisors` is
`> 0` (and at `N = 0` the product is empty, hence `1`). -/
theorem ligozat_prod_pos {N : ℕ} (r : EtaExp) :
    0 < ∏ δ ∈ N.divisors, (δ : ℤ) ^ (r δ).natAbs := by
  refine Finset.prod_pos fun δ hδ => pow_pos ?_ _
  exact_mod_cast Nat.pos_of_mem_divisors hδ

/-- **The numerator's sign is the parity of `k`**, half 1: `k` even ⇒ `(-1)^k ∏ δ^{r_δ} > 0`. -/
theorem ligozatKroneckerNum_pos_of_even {N : ℕ} (r : EtaExp) {k : ℤ} (hke : Even k) :
    0 < ligozatKroneckerNum N r k := by
  have h : ((-1 : ℤ)) ^ k.natAbs = 1 := (Int.natAbs_even.mpr hke).neg_one_pow
  rw [ligozatKroneckerNum, h, one_mul]
  exact ligozat_prod_pos r

/-- **The numerator's sign is the parity of `k`**, half 2: `k` odd ⇒ `(-1)^k ∏ δ^{r_δ} < 0`.
This is the half PIN 3 and PIN 4 guard, and the one an even-weight-only test would miss. -/
theorem ligozatKroneckerNum_neg_of_odd {N : ℕ} (r : EtaExp) {k : ℤ} (hko : Odd k) :
    ligozatKroneckerNum N r k < 0 := by
  have h : ((-1 : ℤ)) ^ k.natAbs = -1 := (Int.natAbs_odd.mpr hko).neg_one_pow
  rw [ligozatKroneckerNum, h, neg_one_mul, neg_neg_iff_pos]
  exact ligozat_prod_pos r

/-- **THE SIGN LAW IN THE SHAPE THE `c < 0` BRANCH NEEDS.**  For Ligozat's numerator,

  `( D / -d ) = (-1)^k · ( D / d )`   for `d ≠ 0`,

because `D > 0 ⟺ k` even.  The `(-1)^k` on the right is *the very factor* `DRK-08` produces for
`w(-γ)`, which is why the `c < 0` case closes at all. -/
theorem kroneckerSym_ligozat_neg_right {N : ℕ} (r : EtaExp) {k : ℤ} {d : ℤ} (hd : d ≠ 0) :
    ((kroneckerSym (ligozatKroneckerNum N r k) (-d) : ℤ) : ℂ)
      = (-1 : ℂ) ^ k * ((kroneckerSym (ligozatKroneckerNum N r k) d : ℤ) : ℂ) := by
  rcases Int.even_or_odd k with hke | hko
  · rw [kroneckerSym_neg_right_of_nonneg (le_of_lt (ligozatKroneckerNum_pos_of_even r hke)) d,
      hke.neg_one_zpow, one_mul]
  · rw [kroneckerSym_neg_right_of_neg (ligozatKroneckerNum_neg_of_odd r hko) hd,
      hko.neg_one_zpow]
    push_cast
    ring

end SignLaw

/-! ## ETA-01, part 2 — the `c = 0` stratum: `γ = ±T^n`

`Γ₀(N)` meets `{c = 0}` exactly in `±T^n` (`DRK-08` part 2), and there the multiplier is computed
by run 3's `etaMultiplierVal_T_eq_one` — which is Ligozat's congruence (i) and nothing else.
The Kronecker side is `(D / ±1)`. -/

section CZero

/-- `d(T^n) = 1`. -/
theorem T_zpow_lower_right (n : ℤ) : (ModularGroup.T ^ n : SL(2, ℤ)) 1 1 = 1 := by
  rw [show ((ModularGroup.T ^ n : SL(2, ℤ)) 1 1)
      = (((ModularGroup.T ^ n : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ)) 1 1 from rfl,
    ModularGroup.coe_T_zpow]
  simp

/-- `d(-(T^n)) = -1`. -/
theorem neg_T_zpow_lower_right (n : ℤ) : (-(ModularGroup.T ^ n) : SL(2, ℤ)) 1 1 = -1 := by
  rw [SL2_neg_entry, T_zpow_lower_right]

theorem T_zpow_mem_Gamma0 (N : ℕ) (n : ℤ) : (ModularGroup.T ^ n : SL(2, ℤ)) ∈ Gamma0 N :=
  zpow_mem (T_mem_Gamma0 N) n

/-- **`w(T^n) = 1` for every `n : ℤ`.**  `w` is a homomorphism (`F3.2-A5`) and `w(T) = 1` is
Ligozat's congruence (i) (`F3.2-A6`), so this is `map_zpow`.  Negative `n` is covered because the
character lands in `ℂˣ`, which is why `etaMultiplierHom` and not `etaMultiplierVal` is used. -/
theorem etaMultiplierVal_T_zpow {N : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (h1 : LigozatCongr1 N r) (n : ℤ) :
    etaMultiplierVal N r k (ModularGroup.T ^ n) = 1 := by
  set g : Gamma0 N := ⟨ModularGroup.T, T_mem_Gamma0 N⟩ with hg
  have key : etaMultiplierHom r hk (g ^ n) = 1 := by
    rw [map_zpow, hg, etaMultiplierHom_T_eq_one r hk h1, _root_.one_zpow]
  have hcoe : ((g ^ n : Gamma0 N) : SL(2, ℤ)) = ModularGroup.T ^ n := by
    rw [hg]; push_cast; rfl
  have h := coe_etaMultiplierHom r hk (g ^ n)
  rw [key, hcoe] at h
  simpa using h.symm

/-- **ETA-01 on the `c = 0` stratum, `γ = T^n` (PROVED).**  Both sides are `1`: the left by
`etaMultiplierVal_T_zpow`, the right because `d = 1` and `(D / 1) = 1` is the empty product. -/
theorem etaMultiplierVal_eq_kroneckerSym_T_zpow {N : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (h1 : LigozatCongr1 N r) (n : ℤ) :
    etaMultiplierVal N r k (ModularGroup.T ^ n)
      = ((kroneckerSym (ligozatKroneckerNum N r k) ((ModularGroup.T ^ n : SL(2, ℤ)) 1 1) : ℤ)
          : ℂ) := by
  rw [etaMultiplierVal_T_zpow r hk h1, T_zpow_lower_right, kroneckerSym_one_right]
  norm_num

/-- **ETA-01 on the `c = 0` stratum, `γ = -(T^n)` (PROVED).**  `DRK-08` gives `w = (-1)^k`;
`d = -1` and `(D / -1) = (-1)^k` because `D < 0 ⟺ k` odd.  **This is where the odd-weight sign
lives**: at even `k` both sides are `1` and the statement is blind. -/
theorem etaMultiplierVal_eq_kroneckerSym_neg_T_zpow {N : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (h1 : LigozatCongr1 N r) (n : ℤ) :
    etaMultiplierVal N r k (-(ModularGroup.T ^ n))
      = ((kroneckerSym (ligozatKroneckerNum N r k) ((-(ModularGroup.T ^ n) : SL(2, ℤ)) 1 1) : ℤ)
          : ℂ) := by
  rw [etaMultiplierVal_neg r hk (T_zpow_mem_Gamma0 N n), etaMultiplierVal_T_zpow r hk h1,
    mul_one, neg_T_zpow_lower_right]
  rcases Int.even_or_odd k with hke | hko
  · rw [kroneckerSym_neg_one_right_of_pos (ligozatKroneckerNum_pos_of_even r hke),
      hke.neg_one_zpow]
    norm_num
  · rw [kroneckerSym_neg_one_right_of_neg (ligozatKroneckerNum_neg_of_odd r hko),
      hko.neg_one_zpow]
    norm_num

end CZero

/-! ## ETA-01, part 3 — THE REDUCTION

`etaMultiplierVal_eq_kroneckerSym_of_pos` is the file's main **proved** theorem: it takes the
`c > 0` slice of ETA-01 as a hypothesis and returns ETA-01 on all of `Γ₀(N)`.  Together with
`DRK-11A` it gives ETA-01 outright for `0 < N ≤ 4`; together with `DRK-11` it would give ETA-01
outright, and `DRK-11` is the only thing missing. -/

section Reduction

/-- `γ ∈ Γ₀(N)` with `γ₁₁ = 0` forces `N = 1`, and then Ligozat's congruence (i) forces `12 ∣ k`,
hence `Even k`.

Why this exists: the `c < 0` branch below rewrites `(D / -d)` as `(-1)^k (D / d)`, which needs
`d ≠ 0` (`kroneckerSym_neg_right_of_neg`).  At `d = 0` the rewrite is unavailable **and the
identity it would assert is false** — but the case is vacuous once `k` is even, and this lemma is
the proof that it is.  `d = 0` with `ad - bc = 1` gives `bc = -1`, so `c = ±1`; `N ∣ c` and
`0 < N` give `N = 1`; and at `N = 1` congruence (i) reads `24 ∣ r₁ = 2k`. -/
theorem even_of_lower_right_zero {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (h1 : LigozatCongr1 N r)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) (hd : γ 1 1 = 0) : Even k := by
  have hdet := sl_det_entries γ
  rw [hd, mul_zero, zero_sub] at hdet
  have hdvd1 : γ 1 0 ∣ (1 : ℤ) := ⟨-(γ 0 1), by linarith⟩
  have hNc : (N : ℤ) ∣ γ 1 0 :=
    (ZMod.intCast_zmod_eq_zero_iff_dvd _ _).mp (Gamma0_mem.mp hγ)
  have hN1 : N = 1 := by
    have h : (N : ℤ) ∣ (1 : ℤ) := hNc.trans hdvd1
    have h' : N ∣ 1 := by exact_mod_cast h
    exact Nat.dvd_one.mp h'
  subst hN1
  rw [Nat.divisors_one, Finset.sum_singleton] at hk
  obtain ⟨m, hm⟩ := h1
  rw [Nat.divisors_one, Finset.sum_singleton, Nat.cast_one, one_mul, hk] at hm
  exact ⟨6 * m, by omega⟩

/-- **THE ETA-01 REDUCTION (PROVED, `sorry`-free, every `N`).**

If the eta-quotient multiplier equals Ligozat's Kronecker symbol at every `γ ∈ Γ₀(N)` with
`c > 0`, then it equals it at **every** `γ ∈ Γ₀(N)`.

This is the content that `DRK-09` and `DRK-11` both explicitly listed as missing ("still required
for ETA-01, and NOT proved here: the `c ≤ 0` cases").  Three strata:

* `c > 0` — the hypothesis `hpos`, verbatim;
* `c < 0` — `DRK-08` (`etaMultiplierVal_neg`) turns `w(γ)` into `(-1)^k w(-γ)` with `-γ ∈ Γ₀(N)`
  of positive lower-left entry, and `kroneckerSym_ligozat_neg_right` turns `(D / -d)` into
  `(-1)^k (D / d)`.  The two `(-1)^k` are the *same* factor: that is the whole content of the
  branch, and `eta01_pin_sym_N3_neg_one` / `eta01_pin_sym_N3_neg_two` are the pins that fix it.
  The degenerate `d = 0` sub-case is `even_of_lower_right_zero`.
* `c = 0` — `DRK-08` part 2 says `γ = ±T^n`, handled by the two `CZero` lemmas.

`h2` (Ligozat's congruence (ii)) is **not used**: it is needed only inside the `c > 0` slice, and
that slice is the hypothesis.  `hN : 0 < N` is used only through `even_of_lower_right_zero`. -/
theorem etaMultiplierVal_eq_kroneckerSym_of_pos {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (h1 : LigozatCongr1 N r)
    (hpos : ∀ γ' : SL(2, ℤ), γ' ∈ Gamma0 N → 0 < γ' 1 0 →
      etaMultiplierVal N r k γ'
        = ((kroneckerSym (ligozatKroneckerNum N r k) (γ' 1 1) : ℤ) : ℂ))
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) :
    etaMultiplierVal N r k γ
      = ((kroneckerSym (ligozatKroneckerNum N r k) (γ 1 1) : ℤ) : ℂ) := by
  rcases exists_pos_lower_left_or_T_zpow hγ with ⟨γ', hγ', hc', hor⟩ | ⟨n, hor⟩
  · rcases hor with h | h
    · subst h; exact hpos _ hγ' hc'
    · subst h
      rw [etaMultiplierVal_neg r hk hγ', hpos _ hγ' hc', SL2_neg_entry]
      rcases eq_or_ne (γ' 1 1) 0 with h0 | h0
      · rw [h0, neg_zero, (even_of_lower_right_zero hN r hk h1 hγ' h0).neg_one_zpow, one_mul]
      · rw [kroneckerSym_ligozat_neg_right r h0]
  · rcases hor with h | h
    · subst h; exact etaMultiplierVal_eq_kroneckerSym_T_zpow r hk h1 n
    · subst h; exact etaMultiplierVal_eq_kroneckerSym_neg_T_zpow r hk h1 n

end Reduction

/-! ## ETA-01, part 4 — `0 < N ≤ 4`: ETA-01 IS PROVED HERE, `sorry`-free

Run 3's `multiplier_eq_kronecker_of_le_four` (F3.2-B3) already covers all of `Γ₀(N)` at those
levels, so no `c`-trichotomy is needed; the reduction of part 3 reproduces it, and
`eta01_reduction_matches_le_four` below checks that it does. -/

section LeFour

/-- **ETA-01 for `0 < N ≤ 4`, PROVED** — the multiplier value at every `γ ∈ Γ₀(N)`. -/
theorem etaMultiplierVal_eq_kroneckerSym_of_le_four {N : ℕ} (hN : 0 < N) (hN4 : N ≤ 4)
    (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) :
    etaMultiplierVal N r k γ
      = ((kroneckerSym (ligozatKroneckerNum N r k) (γ 1 1) : ℤ) : ℂ) := by
  have h := multiplier_eq_kronecker_of_le_four hN hN4 r hk h1 h2 ⟨γ, hγ⟩
  rwa [coe_etaMultiplierHom] at h

/-- **CONSISTENCY TRIPWIRE.**  Feeding run 3's `N ≤ 4` result into the part-3 reduction as its
`c > 0` hypothesis reproduces run 3's own `N ≤ 4` result on all of `Γ₀(N)`.  If the reduction's
`c < 0` branch had the `(-1)^k` backwards, this would fail at every odd weight. -/
theorem eta01_reduction_matches_le_four {N : ℕ} (hN : 0 < N) (hN4 : N ≤ 4)
    (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) :
    etaMultiplierVal_eq_kroneckerSym_of_pos hN r hk h1
        (fun _ hγ' _ => etaMultiplierVal_eq_kroneckerSym_of_le_four hN hN4 r hk h1 h2 hγ') hγ
      = etaMultiplierVal_eq_kroneckerSym_of_le_four hN hN4 r hk h1 h2 hγ := rfl

/-! The transformation-law form at `N ≤ 4` is run 3's `ligozat_kronecker_transform_of_le_four`
(`EtaQuotientModularity.lean`, F3.2-B3); it is not restated here. -/

end LeFour

/-! ## ETA-01, part 5 — THE NODE'S THREE DECLARATIONS

`ligozat_general`, `ligozat_kronecker_transform` and `etaQuotientModularFormGeneral`, verbatim
from the run brief.  All three are `sorry`-carrying, and the `sorry` is **not** here: it is
`DRK-11` (`exp_etaPhiSum_eq_kroneckerSym`), already an open DAG node; `FinalCheck.lean` section
`Eta01` carries the inverted tripwires that certify it. -/

section Node

/-- **ETA-01 core, general `N` — NOT PROVED (`DRK-11`).**  `w(γ) = (D / γ₁₁)` for every
`γ ∈ Γ₀(N)`, `D = (-1)^k ∏_{δ ∣ N} δ^{r_δ}`.

The proof is `etaMultiplierVal_eq_kroneckerSym_of_pos` (part 3, PROVED) fed with the `c > 0`
slice, which is `DRK-09` (`etaMultiplierVal_eq_exp_etaPhiSum`, PROVED) composed with `DRK-11`
(`exp_etaPhiSum_eq_kroneckerSym`, **OPEN**).  Nothing else is missing. -/
theorem etaMultiplierVal_eq_kroneckerSym {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) :
    etaMultiplierVal N r k γ
      = ((kroneckerSym (ligozatKroneckerNum N r k) (γ 1 1) : ℤ) : ℂ) :=
  etaMultiplierVal_eq_kroneckerSym_of_pos hN r hk h1
    (fun γ' hγ' hc' => by
      rw [etaMultiplierVal_eq_exp_etaPhiSum r hk hγ' hc']
      exact exp_etaPhiSum_eq_kroneckerSym hN r hk h1 h2 hγ' hc') hγ

/-- **ETA-01, declaration 1/3 — the node's statement, verbatim.**  The bundled character
`w : Γ₀(N) →* ℂˣ` of `F3.2-A5` IS Ligozat's Kronecker symbol at `γ₁₁`.

**NOT PROVED — inherits `DRK-11`'s `sorry`.** -/
theorem ligozat_general {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r) (γ : Gamma0 N) :
    ((etaMultiplierHom r hk γ : ℂˣ) : ℂ)
      = ((kroneckerSym (ligozatKroneckerNum N r k) ((γ : SL(2, ℤ)) 1 1) : ℤ) : ℂ) := by
  rw [coe_etaMultiplierHom]
  exact etaMultiplierVal_eq_kroneckerSym hN r hk h1 h2 γ.2

/-- **ETA-01, declaration 2/3 — the transformation law**, `f(γz) = χ(d)·(cz+d)^k·f(z)` on all of
`Γ₀(N)`.  **NOT PROVED — inherits `DRK-11`'s `sorry`.** -/
theorem ligozat_kronecker_transform {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r) (γ : Gamma0 N) (z : ℍ) :
    etaQuotientH N r ((γ : SL(2, ℤ)) • z)
      = ((kroneckerSym (ligozatKroneckerNum N r k) ((γ : SL(2, ℤ)) 1 1) : ℤ) : ℂ)
        * (denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH N r z := by
  rw [etaQuotientH_transform r hk γ.2 z, etaMultiplierVal_eq_kroneckerSym hN r hk h1 h2 γ.2]

/-- Slash invariance from a Kronecker transformation law whose character is trivial.  Factored
out so that the `N ≤ 4` package (PROVED) and the general package (open) share one proof.

`hχ` IS LOAD-BEARING and is NOT implied by Ligozat's congruences — see
`eta01_seventeen_hchi_fails`. -/
theorem etaQuotientH_slash_of_kronecker {N : ℕ} (r : EtaExp) {k : ℤ}
    (htr : ∀ (γ : Gamma0 N) (z : ℍ),
      etaQuotientH N r ((γ : SL(2, ℤ)) • z)
        = ((kroneckerSym (ligozatKroneckerNum N r k) ((γ : SL(2, ℤ)) 1 1) : ℤ) : ℂ)
          * (denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH N r z)
    (hχ : ∀ γ : Gamma0 N,
      kroneckerSym (ligozatKroneckerNum N r k) ((γ : SL(2, ℤ)) 1 1) = 1) :
    ∀ g ∈ (Gamma0 N : Subgroup (GL (Fin 2) ℝ)),
      (etaQuotientH N r) ∣[k] g = etaQuotientH N r := by
  rintro _ ⟨γ, hγ, rfl⟩
  show (etaQuotientH N r) ∣[k] (γ : GL (Fin 2) ℝ) = etaQuotientH N r
  rw [← ModularForm.SL_slash]
  funext τ
  rw [ModularForm.SL_slash_apply]
  have hd : (denom (γ : GL (Fin 2) ℝ) (τ : ℂ)) ≠ 0 := denom_ne_zero _ τ
  rw [htr ⟨γ, hγ⟩ τ, hχ ⟨γ, hγ⟩]
  push_cast
  rw [one_mul, mul_right_comm, ← zpow_add₀ hd, add_neg_cancel, zpow_zero, one_mul]

/-- **ETA-01, declaration 3/3 — the packaged modular form.**  **NOT PROVED — inherits `DRK-11`'s
`sorry`** through `ligozat_kronecker_transform`.

READ THE HYPOTHESIS `hχ` (LL-1).  It is *not* a consequence of Ligozat's congruences: it says the
Kronecker character is trivial on `Γ₀(N)`, which fails already at `N = 17` with `12 ∣ k`
(`eta01_seventeen_hchi_fails`).  Without it the eta quotient is a modular form **with character**,
which Mathlib's `ModularForm (Γ₀ N) k` cannot express.  `hbd` is Ligozat's condition (iii), still
a hypothesis for the F3.1-OBSTRUCTED reason recorded at run 3's `etaQuotientModularForm`. -/
noncomputable def etaQuotientModularFormGeneral {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    (hχ : ∀ γ : Gamma0 N,
            kroneckerSym (ligozatKroneckerNum N r k) ((γ : SL(2, ℤ)) 1 1) = 1)
    (hbd : ∀ γ : SL(2, ℤ), IsBoundedAtImInfty ((etaQuotientH N r) ∣[k] γ)) :
    ModularForm (Gamma0 N) k where
  toFun := etaQuotientH N r
  slash_action_eq' :=
    etaQuotientH_slash_of_kronecker r (ligozat_kronecker_transform hN r hk h1 h2) hχ
  holo' := mdiff_etaQuotientH N r
  bdd_at_cusps' hc := isBoundedAt_of_bdd_SL2Z r hbd hc

@[simp] theorem etaQuotientModularFormGeneral_apply {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    (hχ : ∀ γ : Gamma0 N,
            kroneckerSym (ligozatKroneckerNum N r k) ((γ : SL(2, ℤ)) 1 1) = 1)
    (hbd : ∀ γ : SL(2, ℤ), IsBoundedAtImInfty ((etaQuotientH N r) ∣[k] γ)) (z : ℍ) :
    etaQuotientModularFormGeneral hN r hk h1 h2 hχ hbd z = etaQuotientH N r z := rfl

/-- **The `N ≤ 4` package, PROVED and `sorry`-free** — the same construction on run 3's
transformation law.  This is the term that certifies the packaging in part 5 is not vacuous. -/
noncomputable def etaQuotientModularFormOfLeFour {N : ℕ} (hN : 0 < N) (hN4 : N ≤ 4)
    (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    (hχ : ∀ γ : Gamma0 N,
            kroneckerSym (ligozatKroneckerNum N r k) ((γ : SL(2, ℤ)) 1 1) = 1)
    (hbd : ∀ γ : SL(2, ℤ), IsBoundedAtImInfty ((etaQuotientH N r) ∣[k] γ)) :
    ModularForm (Gamma0 N) k where
  toFun := etaQuotientH N r
  slash_action_eq' :=
    etaQuotientH_slash_of_kronecker r (ligozat_kronecker_transform_of_le_four hN hN4 r hk h1 h2) hχ
  holo' := mdiff_etaQuotientH N r
  bdd_at_cusps' hc := isBoundedAt_of_bdd_SL2Z r hbd hc

end Node

/-! ## ETA-01, part 6 — THE `N = 17` REFUTATION (PROVED, `sorry`-free)

`EtaMultiplier.lean`'s `ligozat_trivial_multiplier_of_twelve_dvd` (formerly `ligozat_general`)
claims that Ligozat's congruences plus `12 ∣ k` force a TRIVIAL multiplier.  At `N = 17`,
`r = (21, 3)`, `k = 12`, `γ = !![6, 1; 17, 3]` all of its hypotheses hold and the character value
is `-1`.  The two statements are therefore incompatible **at a single explicit matrix**, and that
incompatibility is proved below without either of them. -/

section Refutation

/-- The character value at the refuting matrix: `(17³ / 3) = -1`. -/
theorem eta01_seventeen_kronecker_value :
    kroneckerSym (ligozatKroneckerNum 17 eta01R17 12) (eta01MatN17 1 1) = -1 := by
  rw [eta01_pin_num_N17, eta01_pin_N17_entries.2.1]
  exact eta01_pin_sym_N17_pos_d

/-- **`hχ` OF `etaQuotientModularFormGeneral` IS NOT AUTOMATIC.**  At `N = 17`, `r = (21,3)`,
`k = 12` — Ligozat's congruences hold, `12 ∣ k`, and the character is still nontrivial. -/
theorem eta01_seventeen_hchi_fails :
    ¬ (∀ γ : Gamma0 17,
        kroneckerSym (ligozatKroneckerNum 17 eta01R17 12) ((γ : SL(2, ℤ)) 1 1) = 1) := by
  intro h
  have hval := h ⟨eta01MatN17, eta01_pin_N17_mem⟩
  rw [show (((⟨eta01MatN17, eta01_pin_N17_mem⟩ : Gamma0 17) : SL(2, ℤ)) 1 1)
      = eta01MatN17 1 1 from rfl, eta01_seventeen_kronecker_value] at hval
  exact absurd hval (by norm_num)

/-- **THE REFUTATION (PROVED, `sorry`-free).**  These two cannot both be true:

* `(A)` the conclusion of `ligozat_trivial_multiplier_of_twelve_dvd` at
  `N = 17, r = (21,3), k = 12, γ = !![6,1;17,3]` — a TRIVIAL multiplier;
* `(B)` the conclusion of `etaMultiplierVal_eq_kroneckerSym` (ETA-01) at the same data — the
  multiplier is `(17³ / 3) = -1`.

`(A)` forces `w(γ) = 1` by `etaQuotientH_transform` and `etaQuotientH_ne_zero`; `(B)` forces
`w(γ) = -1`.  A 4000-term `η`-product evaluation says the truth is `-1`, so `(A)` is the false
one — which is why `ligozat_trivial_multiplier_of_twelve_dvd` is quarantined rather than worked
on. -/
theorem eta01_seventeen_refutes_trivial_multiplier :
    ¬ ((∀ z : ℍ, etaQuotientH 17 eta01R17 (eta01MatN17 • z)
            = (denom (eta01MatN17 : GL (Fin 2) ℝ) (z : ℂ)) ^ (12 : ℤ)
              * etaQuotientH 17 eta01R17 z)
        ∧ etaMultiplierVal 17 eta01R17 12 eta01MatN17
            = ((kroneckerSym (ligozatKroneckerNum 17 eta01R17 12) (eta01MatN17 1 1) : ℤ) : ℂ)) := by
  rintro ⟨htriv, hkron⟩
  have hd : (denom (eta01MatN17 : GL (Fin 2) ℝ) ((UpperHalfPlane.I : ℍ) : ℂ)) ≠ 0 :=
    denom_ne_zero _ _
  have hf : etaQuotientH 17 eta01R17 UpperHalfPlane.I ≠ 0 := etaQuotientH_ne_zero _ _ _
  have hA : (denom (eta01MatN17 : GL (Fin 2) ℝ) ((UpperHalfPlane.I : ℍ) : ℂ)) ^ (12 : ℤ)
      * etaQuotientH 17 eta01R17 UpperHalfPlane.I ≠ 0 :=
    mul_ne_zero (zpow_ne_zero _ hd) hf
  have h := etaQuotientH_transform eta01R17 eta01_pin_R17_sum eta01_pin_N17_mem UpperHalfPlane.I
  rw [htriv UpperHalfPlane.I, mul_assoc] at h
  have hw : etaMultiplierVal 17 eta01R17 12 eta01MatN17 = 1 :=
    mul_right_cancel₀ hA (by rw [one_mul]; exact h.symm)
  rw [hw, eta01_seventeen_kronecker_value] at hkron
  exact absurd hkron (by norm_num)

end Refutation

end SocrateAI.ModularForms
