/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.
-/
import SocrateAI.ModularForms.EtaLigozatGeneral
import SocrateAI.ModularForms.EtaQuotientPrimeLevel

/-!
# DRK-12 — Ligozat at level 11: `η(z)²·η(11z)²` is weight 2 on `Γ₀(11)`

## STATUS, first, because it is the headline (LL-1 / LL-2)

**PROVED, `sorry`-free**, and it is *not* proved through `ligozat_general`:

* `ModularForm.etaProductEleven_transform` —
  `η(γτ)²·η(11·γτ)² = denom(γ,τ)² · (η(τ)²·η(11τ)²)` for **every** `γ ∈ Γ₀(11)` and every
  `τ : ℍ`.  This is FLT's `ModularForm.etaProductEleven_transform`, statement for statement
  (see `ATTRIBUTION.md §DRK-12`: statement overlap NAMED, proof INDEPENDENT).
* `exp_etaPhiSum_eq_kroneckerSym_eleven` — `DRK-11`'s exact conclusion at `N = 11`,
  `r = (2,2)`, `k = 2`, on all of `Γ₀(11)` with `c > 0`.  `DRK-11` was previously known only
  for `0 < N ≤ 4` (`exp_etaPhiSum_eq_kroneckerSym_of_le_four`, `DRK-11A`); this is a **new
  instance at a level where that theorem does not apply**.
* `etaMultiplierVal_eq_kroneckerSym_eleven` — `ETA-01`'s conclusion at the same data, on **all**
  of `Γ₀(11)` (no `c > 0`), obtained by feeding the previous item into the `sorry`-free
  reduction `etaMultiplierVal_eq_kroneckerSym_of_pos` of `EtaLigozatGeneral.lean`.

## WHAT IS *NOT* PROVED — read before citing (LL-1, loudly)

1. **`ligozat_general` IS STILL OPEN AND IS NOT USED HERE.**  `ligozat_general` (and everything
   packaged on it) still inherits `DRK-11`'s `sorry`; `FinalCheck.lean` section `Eta01` carries
   the inverted tripwires that say so, and this file does not change that.  The level-11 result
   below is proved by a route that never touches `DRK-11`'s open general statement:
   generation of `Γ₀(11)` (Schreier) plus kernel evaluation of `etaPhiSum` at the generators.
   `etaProductEleven_via_ligozat_general` at the end of this file *is* the route through
   `ligozat_general`; it is stated to make the comparison explicit and it **does** carry
   `sorryAx`, which is guarded as an inverted tripwire.  Anyone citing this file as having
   closed `ETA-01` is citing it wrongly.

2. **FLT's `CuspForm.exists_gamma0_eleven_apply_eq_eta_sq_mul_eta_sq` IS NOT REPRODUCED.**
   That statement asserts the existence of an element of `CuspForm (Γ₀ 11) 2`: slash-invariance
   **and** holomorphy **and vanishing at every cusp**.  What is proved here is the first
   conjunct only.  Holomorphy would be `mdiff_etaQuotientH`; vanishing at the cusps is
   `F3.1-OBSTRUCTED` and is not attempted — `etaQuotientModularFormGeneral` still takes
   boundedness (not vanishing) as a *hypothesis*, so even the `ModularForm` package, let alone
   the `CuspForm` one, is out of reach at this level.  The obligation named in the DRK-12 brief
   as `etaProductEleven_via_ligozat_general` has therefore been **renamed** to
   `etaProductEleven_transform` (FLT reference (a)), and FLT reference (b) is recorded here as
   NOT delivered.

3. **Nothing here is a statement about general `N`.**  Level 11 is one more level, obtained the
   way run 3 obtained 5, 7 and 13 — by generating the group — not by a general theorem.  What
   *is* new relative to run 3 is that `Γ̄₀(11)` has **no elliptic elements** (`ν₂ = ν₃ = 0`), so
   run 3's `F3.2-C3` technique (elliptic fixed points, `etaMultiplierVal_matH_diag` /
   `_matH_succ`) cannot supply a single generator value here.  Every non-`{-I, T, V}` generator
   value is instead read off `DRK-09` — the multiplier *evaluated*, not constrained — and that
   is exactly the ingredient run 3 did not have.

## PROVENANCE — INDEPENDENT

No declaration in this file is ported or adapted from `anthropics/fermats-last-theorem`.  The
`etaProductEleven_transform` STATEMENT coincides with FLT's theorem of the same name (fetched
2026-09-08, HTTP 200, 936 B); that overlap is named rather than hidden (LL-25) and recorded in
`ATTRIBUTION.md §DRK-12`.  The proof shares no step with FLT's: FLT discharges it through its
`p2m_exact_reverting` solution infrastructure, which does not exist here.  The route used is
`subgroup_eq_of_transversal` + `Gamma0_eq_of_schreier` (run 3, ours) and
`etaMultiplierVal_eq_exp_etaPhiSum` (`DRK-09`, ours).
-/

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm Complex
open UpperHalfPlane hiding I
open scoped MatrixGroups Real

/-! ## DRK-12, part 0 — SIGN-DISCIPLINE GATE

Nothing below this section may be used before it.  Every value in this block was computed
**independently in Python** (`fractions.Fraction`; `Int.fract`, `dedekindSaw`, `dedekindSum`,
`etaPhiSum` re-implemented from the Lean SOURCE) *before* it was written here, and that
re-implementation was first checked against the existing kernel pins `drk11_phi_N11`,
`drk11_phi_N3a/b/c/d` and `drk11_phi_N7` — all six reproduced exactly.

The same Python sweep evaluated `etaPhiSum 11 (2,2) γ` at **2376** matrices of `Γ₀(11)` with
`c > 0` (`c ∈ {11,…,88}`, `|d| ≤ 60`, `|a| ≤ 60`): every value is an integer `≡ 12 (mod 24)`,
zero mismatches.  `etaPhiSum ≡ 12 (mod 24)` with `k = 2` is exactly `(-i)² · e^{πi·etaPhiSum/12} = 1`.

The exponent vector is `drk11R11 = (r₁, r₁₁) = (2, 2)` of `EtaLigozatKronecker.lean` — reused,
not re-declared, so that the pins of `DRK-11` and of this node are pins of the *same* object.
-/

section Gate

/-- PIN 1 — the weight: `Σ_{δ ∣ 11} r_δ = 4 = 2k` with `k = 2`. -/
theorem drk12_pin_R11_sum : ∑ δ ∈ (11 : ℕ).divisors, drk11R11 δ = 2 * 2 := by decide

/-- PIN 2 — Ligozat (i): `Σ_δ δ·r_δ = 1·2 + 11·2 = 24`. -/
theorem drk12_pin_R11_congr1_value :
    ∑ δ ∈ (11 : ℕ).divisors, (δ : ℤ) * drk11R11 δ = 24 := by decide

/-- PIN 3 — Ligozat (ii): `Σ_δ (11/δ)·r_δ = 11·2 + 1·2 = 24`. -/
theorem drk12_pin_R11_congr2_value :
    ∑ δ ∈ (11 : ℕ).divisors, ((11 / δ : ℕ) : ℤ) * drk11R11 δ = 24 := by decide

theorem drk12_R11_congr1 : LigozatCongr1 11 drk11R11 :=
  ⟨1, by rw [drk12_pin_R11_congr1_value]; norm_num⟩

theorem drk12_R11_congr2 : LigozatCongr2 11 drk11R11 :=
  ⟨1, by rw [drk12_pin_R11_congr2_value]; norm_num⟩

/-! ### PINS 4–13 — `etaPhiSum` at the ten Schreier generators `h_{j,j'}`, `1 ≤ j ≤ 10`

`h_{j,j'} = !![-j', -1; jj'+1, j]` with `j' ≡ -j⁻¹ (mod 11)` and `0 ≤ j' < 11`.  Each is a
**kernel evaluation** (`decide +kernel`) of `etaPhiSum`, and of nothing else: no general lemma
about level 11 has been stated yet, so no pin can be discharged by the theory it guards.

All ten values are `≡ 12 (mod 24)`, as the `(-i)²·e^{πi·etaPhiSum/12} = 1` target requires; the two signs
`etaPhiSum = ±12` and `etaPhiSum = ±36` both occur, so a pin that got the sign of the Dedekind-sum term backwards
would not survive.
-/

set_option maxRecDepth 200000 in
/-- PIN 4 — `h_{1,10}`, `c = 11`, `d = 1`.  `etaPhiSum = -36 = 24·(-2) + 12`. -/
theorem drk12_phi_h_1_10 : etaPhiSum 11 drk11R11 (matH 1 10) = -36 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 5 — `h_{2,5}`, `c = 11`, `d = 2` EVEN.  `etaPhiSum = -12`. -/
theorem drk12_phi_h_2_5 : etaPhiSum 11 drk11R11 (matH 2 5) = -12 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 6 — `h_{3,7}`, `c = 22` EVEN, `d = 3`.  `etaPhiSum = -12`. -/
theorem drk12_phi_h_3_7 : etaPhiSum 11 drk11R11 (matH 3 7) = -12 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 7 — `h_{4,8}`, `c = 33`, `d = 4`.  `etaPhiSum = -12`. -/
theorem drk12_phi_h_4_8 : etaPhiSum 11 drk11R11 (matH 4 8) = -12 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 8 — `h_{5,2}`, `c = 11`, `d = 5`.  `etaPhiSum = +12`: the SIGN of `etaPhiSum` flips against PIN 5 while
the multiplier value does not, because both are `≡ 12 (mod 24)`. -/
theorem drk12_phi_h_5_2 : etaPhiSum 11 drk11R11 (matH 5 2) = 12 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 9 — `h_{6,9}`, `c = 55`, `d = 6` EVEN.  `etaPhiSum = -12`. -/
theorem drk12_phi_h_6_9 : etaPhiSum 11 drk11R11 (matH 6 9) = -12 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 10 — `h_{7,3}`, `c = 22`, `d = 7`.  `etaPhiSum = +12`. -/
theorem drk12_phi_h_7_3 : etaPhiSum 11 drk11R11 (matH 7 3) = 12 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 11 — `h_{8,4}`, `c = 33`, `d = 8` EVEN.  `etaPhiSum = +12`. -/
theorem drk12_phi_h_8_4 : etaPhiSum 11 drk11R11 (matH 8 4) = 12 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 12 — `h_{9,6}`, `c = 55`, `d = 9`.  `etaPhiSum = +12`. -/
theorem drk12_phi_h_9_6 : etaPhiSum 11 drk11R11 (matH 9 6) = 12 := by decide +kernel

set_option maxRecDepth 200000 in
/-- PIN 13 — `h_{10,1}`, `c = 11`, `d = 10` EVEN.  `etaPhiSum = +36 = 24 + 12`. -/
theorem drk12_phi_h_10_1 : etaPhiSum 11 drk11R11 (matH 10 1) = 36 := by decide +kernel

/-! ### PINS 14–16 — Ligozat's numerator and the Kronecker symbol at level 11 -/

/-- PIN 14 — `D = (-1)^2 · 1^2 · 11^2 = 121`, a perfect square (this is `drk11_num_N11`,
restated here so the gate is self-contained). -/
theorem drk12_pin_num_eleven : ligozatKroneckerNum 11 drk11R11 2 = 121 := by decide

/-- PIN 15 — `(121 / 4) = 1` at the EVEN `d` of `drk11MatN11`. -/
theorem drk12_pin_sym_four : kroneckerSym 121 (4 : ℤ) = 1 := drk11_sym_N11

/-- PIN 16 — `(121 / 3) = 1`: an odd `d`, computed through the Jacobi branch rather than `χ₈`. -/
theorem drk12_pin_sym_three : kroneckerSym 121 (3 : ℤ) = 1 := by
  rw [show (121 : ℤ) = 11 ^ 2 by norm_num]
  exact kroneckerSym_sq_of_gcd (by decide)

/-! ### NEGATIVE CONTROLS

The gate must be able to fail.  `11 ∤ d` is what makes `(121/d) = 1`; at `d` divisible by `11`
the symbol is `0`, not `1`.  `gamma0_not_dvd` is precisely the lemma that rules that out for
`γ ∈ Γ₀(11)`, and without it the character-triviality argument below is wrong. -/

/-- NEGATIVE CONTROL 1 — `(121 / 11) = 0 ≠ 1`.  So `kroneckerSym_sq_of_gcd`'s coprimality
hypothesis is load-bearing, and the appeal to `gamma0_not_dvd` in
`kroneckerSym_eleven_eq_one` is not decoration. -/
theorem drk12_neg_control_sym_eleven : kroneckerSym 121 (11 : ℤ) ≠ 1 := by
  rw [show (121 : ℤ) = 11 ^ 2 by norm_num, kroneckerSym,
    if_neg (by norm_num : (11 : ℤ) ≠ 0),
    if_neg (show ¬((11 : ℤ) ^ 2 < 0 ∧ (11 : ℤ) < 0) from fun h => absurd h.1 (by norm_num)),
    show (11 : ℤ).natAbs = 11 from rfl,
    show Nat.primeFactorsList 11 = [11] from Nat.primeFactorsList_prime (by norm_num)]
  norm_num [kroneckerPrime, legendreSym]

/-- NEGATIVE CONTROL 2 — the pins are not all the same number: `etaPhiSum(h_{1,10}) ≠ etaPhiSum(h_{2,5})`.
A `decide +kernel` that had silently collapsed to a constant would fail here. -/
theorem drk12_neg_control_phi_distinct :
    etaPhiSum 11 drk11R11 (matH 1 10) ≠ etaPhiSum 11 drk11R11 (matH 2 5) := by
  rw [drk12_phi_h_1_10, drk12_phi_h_2_5]; norm_num

end Gate

/-! ## DRK-12, part 1 — `Γ₀(11)` is generated by `{-I, T, V, h₂₅, h₃₇, h₄₈, h₆₉}`

`Gamma0_eq_of_schreier` (run 3, `EtaQuotientPrimeLevel.lean`) is stated for every `p ≥ 2` and
asks for one Schreier generator `h_{j,j'}` with `11 ∣ jj' + 1` for each `j ∈ [1,10]`.  Six of the
ten are short words in `{-I, T, V}` and the remaining four are taken as generators:

| `j` | `j'` | word |
|---|---|---|
| 1 | 10 | `T⁻¹ V⁻¹` |
| 2 | 5 | generator `h₂₅` |
| 3 | 7 | generator `h₃₇` |
| 4 | 8 | generator `h₄₈` |
| 5 | 2 | `(-I)·h₂₅⁻¹` |
| 6 | 9 | generator `h₆₉` |
| 7 | 3 | `(-I)·h₃₇⁻¹` |
| 8 | 4 | `(-I)·h₄₈⁻¹` |
| 9 | 6 | `(-I)·h₆₉⁻¹` |
| 10 | 1 | `(-I)·V·T` |

Every entry of that table is a single `decide` on `2 × 2` integer matrices.

**WHY THIS IS NOT RUN 3 AGAIN.**  `Γ̄₀(11)` is free of rank 3 with no elliptic elements, so run
3's `F3.2-C3` route — which reads each non-`{-I,T,V}` generator value off an *elliptic fixed
point* (`etaMultiplierVal_matH_diag`, `_matH_succ`) — has nothing to say about `h₂₅`, `h₃₇`,
`h₄₈`, `h₆₉`: their traces are `-3, -4, -4, -3`, all hyperbolic.  Their multiplier values come
from `DRK-09` instead, which run 3 did not have.
-/

section Generation

/-- The generating set of `Γ₀(11)`: `-I`, `T`, `V = !![1,0;-11,1]`, and the four HYPERBOLIC
Schreier generators `h_{2,5}`, `h_{3,7}`, `h_{4,8}`, `h_{6,9}`. -/
def gamma0GensP11 : Set SL(2, ℤ) :=
  {(-1 : SL(2, ℤ)), ModularGroup.T, matV 11, matH 2 5, matH 3 7, matH 4 8, matH 6 9}

theorem drk12_mem_h_2_5 : matH 2 5 ∈ Gamma0 11 := matH_mem_Gamma0 (by decide)
theorem drk12_mem_h_3_7 : matH 3 7 ∈ Gamma0 11 := matH_mem_Gamma0 (by decide)
theorem drk12_mem_h_4_8 : matH 4 8 ∈ Gamma0 11 := matH_mem_Gamma0 (by decide)
theorem drk12_mem_h_6_9 : matH 6 9 ∈ Gamma0 11 := matH_mem_Gamma0 (by decide)

theorem gamma0GensP11_subset : gamma0GensP11 ⊆ (Gamma0 11 : Set SL(2, ℤ)) := by
  intro g hg
  simp only [gamma0GensP11, Set.mem_insert_iff, Set.mem_singleton_iff] at hg
  rcases hg with rfl|rfl|rfl|rfl|rfl|rfl|rfl
  · exact neg_one_mem_Gamma0 11
  · exact T_mem_Gamma0 11
  · exact matV_mem_Gamma0 11
  · exact drk12_mem_h_2_5
  · exact drk12_mem_h_3_7
  · exact drk12_mem_h_4_8
  · exact drk12_mem_h_6_9

set_option maxRecDepth 40000 in
/-- **`Γ₀(11)` is generated by `{-I, T, V, h₂₅, h₃₇, h₄₈, h₆₉}`.**  The `p = 11` instance of
run 3's `Gamma0_eq_of_schreier`. -/
theorem closure_gamma0GensP11 : Subgroup.closure gamma0GensP11 = Gamma0 11 := by
  have hneg : (-1 : SL(2, ℤ)) ∈ Subgroup.closure gamma0GensP11 :=
    Subgroup.subset_closure (by simp [gamma0GensP11])
  have hT : ModularGroup.T ∈ Subgroup.closure gamma0GensP11 :=
    Subgroup.subset_closure (by simp [gamma0GensP11])
  have hV : matV 11 ∈ Subgroup.closure gamma0GensP11 :=
    Subgroup.subset_closure (by simp [gamma0GensP11])
  have hE1 : matH 2 5 ∈ Subgroup.closure gamma0GensP11 :=
    Subgroup.subset_closure (by simp [gamma0GensP11])
  have hE2 : matH 3 7 ∈ Subgroup.closure gamma0GensP11 :=
    Subgroup.subset_closure (by simp [gamma0GensP11])
  have hE3 : matH 4 8 ∈ Subgroup.closure gamma0GensP11 :=
    Subgroup.subset_closure (by simp [gamma0GensP11])
  have hE4 : matH 6 9 ∈ Subgroup.closure gamma0GensP11 :=
    Subgroup.subset_closure (by simp [gamma0GensP11])
  refine Gamma0_eq_of_schreier (by norm_num) ?_ hneg hT hV ?_
  · rw [Subgroup.closure_le]; exact gamma0GensP11_subset
  · intro j hj1 hj
    interval_cases j
    · refine ⟨10, by norm_num, ?_⟩
      have hw : matH ((1 : ℕ) : ℤ) ((10 : ℕ) : ℤ) = ModularGroup.T⁻¹ * (matV 11)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ (Subgroup.inv_mem _ hT) (Subgroup.inv_mem _ hV)
    · refine ⟨5, by norm_num, ?_⟩
      have hw : matH ((2 : ℕ) : ℤ) ((5 : ℕ) : ℤ) = matH 2 5 := by decide
      rw [hw]; exact hE1
    · refine ⟨7, by norm_num, ?_⟩
      have hw : matH ((3 : ℕ) : ℤ) ((7 : ℕ) : ℤ) = matH 3 7 := by decide
      rw [hw]; exact hE2
    · refine ⟨8, by norm_num, ?_⟩
      have hw : matH ((4 : ℕ) : ℤ) ((8 : ℕ) : ℤ) = matH 4 8 := by decide
      rw [hw]; exact hE3
    · refine ⟨2, by norm_num, ?_⟩
      have hw : matH ((5 : ℕ) : ℤ) ((2 : ℕ) : ℤ) = (-1 : SL(2, ℤ)) * (matH 2 5)⁻¹ := by decide
      rw [hw]; exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ hE1)
    · refine ⟨9, by norm_num, ?_⟩
      have hw : matH ((6 : ℕ) : ℤ) ((9 : ℕ) : ℤ) = matH 6 9 := by decide
      rw [hw]; exact hE4
    · refine ⟨3, by norm_num, ?_⟩
      have hw : matH ((7 : ℕ) : ℤ) ((3 : ℕ) : ℤ) = (-1 : SL(2, ℤ)) * (matH 3 7)⁻¹ := by decide
      rw [hw]; exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ hE2)
    · refine ⟨4, by norm_num, ?_⟩
      have hw : matH ((8 : ℕ) : ℤ) ((4 : ℕ) : ℤ) = (-1 : SL(2, ℤ)) * (matH 4 8)⁻¹ := by decide
      rw [hw]; exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ hE3)
    · refine ⟨6, by norm_num, ?_⟩
      have hw : matH ((9 : ℕ) : ℤ) ((6 : ℕ) : ℤ) = (-1 : SL(2, ℤ)) * (matH 6 9)⁻¹ := by decide
      rw [hw]; exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ hE4)
    · refine ⟨1, by norm_num, ?_⟩
      have hw : matH ((10 : ℕ) : ℤ) ((1 : ℕ) : ℤ)
          = (-1 : SL(2, ℤ)) * (matV 11 * ModularGroup.T) := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.mul_mem _ hV hT)

/-- The closure is PROPER: `S ∉ Γ₀(11)`, so `closure_gamma0GensP11` has not degenerated into
`closure = ⊤`. -/
theorem S_not_mem_closure_gensP11 : ModularGroup.S ∉ Subgroup.closure gamma0GensP11 := by
  rw [closure_gamma0GensP11, Gamma0_mem]
  intro h
  rw [show (ModularGroup.S : SL(2, ℤ)) 1 0 = 1 from by decide] at h
  exact absurd h (by decide)

end Generation

/-! ## DRK-12, part 2 — the multiplier is trivial at level 11

`w = etaMultiplierHom drk11R11` is a character of `Γ₀(11)` (`F3.2-A5`).  Its value at each of the
seven generators is computed:

* `w(-I) = (-1)^k = (-1)² = 1` (`etaMultiplierHom_neg_one`, `DRK-08`-free);
* `w(T) = 1` from Ligozat (i) (`etaMultiplierHom_T_eq_one`);
* `w(V) = 1` from Ligozat (ii) (`etaMultiplierHom_V_eq_one`);
* `w(h) = (-i)² e^{πi·etaPhiSum/12} = -e^{-πi} = 1` for each hyperbolic `h`, from `DRK-09`
  (`etaMultiplierVal_eq_exp_etaPhiSum`, valid because `c = jj'+1 > 0`) and the kernel pins.
-/

section Multiplier

private theorem drk12_val_of_phi {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) (hc : 0 < γ 1 0)
    {q : ℚ} (hq : etaPhiSum 11 drk11R11 γ = q) (n : ℤ) (hn : q - 6 * 2 = 24 * n) :
    etaMultiplierVal 11 drk11R11 2 γ = 1 := by
  rw [etaMultiplierVal_eq_exp_etaPhiSum drk11R11 drk12_pin_R11_sum hγ hc, hq]
  exact drk11_eq_one_of n hn

theorem drk12_mult_h_2_5 : etaMultiplierVal 11 drk11R11 2 (matH 2 5) = 1 :=
  drk12_val_of_phi drk12_mem_h_2_5 (by decide) drk12_phi_h_2_5 (-1) (by norm_num)

theorem drk12_mult_h_3_7 : etaMultiplierVal 11 drk11R11 2 (matH 3 7) = 1 :=
  drk12_val_of_phi drk12_mem_h_3_7 (by decide) drk12_phi_h_3_7 (-1) (by norm_num)

theorem drk12_mult_h_4_8 : etaMultiplierVal 11 drk11R11 2 (matH 4 8) = 1 :=
  drk12_val_of_phi drk12_mem_h_4_8 (by decide) drk12_phi_h_4_8 (-1) (by norm_num)

theorem drk12_mult_h_6_9 : etaMultiplierVal 11 drk11R11 2 (matH 6 9) = 1 :=
  drk12_val_of_phi drk12_mem_h_6_9 (by decide) drk12_phi_h_6_9 (-1) (by norm_num)

/-- **The eta multiplier of `η²·η(11·)²` is trivial on all of `Γ₀(11)`.**  PROVED, `sorry`-free.
This is the statement run 3 could reach at `N ∈ {5,7,13}` and could not reach at `N = 11`. -/
theorem etaMultiplierHom_eleven_eq_one :
    etaMultiplierHom drk11R11 drk12_pin_R11_sum = 1 := by
  refine hom_ext_of_closure gamma0GensP11_subset closure_gamma0GensP11 ?_
  intro x hx
  simp only [Set.mem_preimage, gamma0GensP11, Set.mem_insert_iff, Set.mem_singleton_iff] at hx
  have hone : ∀ y : Gamma0 11, (1 : Gamma0 11 →* ℂˣ) y = 1 := fun _ => rfl
  rcases hx with h|h|h|h|h|h|h
  · rw [show x = (⟨-1, neg_one_mem_Gamma0 11⟩ : Gamma0 11) from Subtype.ext h,
      etaMultiplierHom_neg_one, hone]
    exact Units.ext (by push_cast; norm_num)
  · rw [show x = (⟨ModularGroup.T, T_mem_Gamma0 11⟩ : Gamma0 11) from Subtype.ext h,
      etaMultiplierHom_T_eq_one drk11R11 drk12_pin_R11_sum drk12_R11_congr1, hone]
  · rw [show x = (⟨matV 11, matV_mem_Gamma0 11⟩ : Gamma0 11) from Subtype.ext h,
      etaMultiplierHom_V_eq_one (by norm_num) drk11R11 drk12_pin_R11_sum drk12_R11_congr2, hone]
  · rw [show x = (⟨matH 2 5, drk12_mem_h_2_5⟩ : Gamma0 11) from Subtype.ext h, hone]
    exact Units.ext (by rw [coe_etaMultiplierHom]; simpa using drk12_mult_h_2_5)
  · rw [show x = (⟨matH 3 7, drk12_mem_h_3_7⟩ : Gamma0 11) from Subtype.ext h, hone]
    exact Units.ext (by rw [coe_etaMultiplierHom]; simpa using drk12_mult_h_3_7)
  · rw [show x = (⟨matH 4 8, drk12_mem_h_4_8⟩ : Gamma0 11) from Subtype.ext h, hone]
    exact Units.ext (by rw [coe_etaMultiplierHom]; simpa using drk12_mult_h_4_8)
  · rw [show x = (⟨matH 6 9, drk12_mem_h_6_9⟩ : Gamma0 11) from Subtype.ext h, hone]
    exact Units.ext (by rw [coe_etaMultiplierHom]; simpa using drk12_mult_h_6_9)

/-- The unbundled form: `w(γ) = 1` at every `γ ∈ Γ₀(11)`. -/
theorem etaMultiplierVal_eleven_eq_one {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) :
    etaMultiplierVal 11 drk11R11 2 γ = 1 := by
  have h := congrArg (fun f => ((f ⟨γ, hγ⟩ : ℂˣ) : ℂ)) etaMultiplierHom_eleven_eq_one
  simpa [etaMultiplierHom] using h

end Multiplier

/-! ## DRK-12, part 3 — Ligozat's character at level 11 is trivial, and `DRK-11` at `N = 11`

`D = (-1)² ∏_{δ ∣ 11} δ^{r_δ} = 11² = 121` is a perfect square, and `γ ∈ Γ₀(11)` forces
`11 ∤ γ₁₁` (`gamma0_not_dvd`, from `ad − bc = 1` and `11 ∣ c`), so `(D/γ₁₁) = 1`.

**THE SIDE CONDITION IS NOT DECORATION.**  `drk12_neg_control_sym_eleven` shows `(121/11) = 0`,
so without `gamma0_not_dvd` the character is not trivial but *zero* — and `ETA-01`'s conclusion
would be false, not merely unproved. -/

section Character

/-- `11 ∤ γ₁₁` for `γ ∈ Γ₀(11)`. -/
theorem drk12_eleven_not_dvd {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) : ¬ ((11 : ℤ) ∣ γ 1 1) :=
  gamma0_not_dvd hγ (m := 11) (by norm_num) (by norm_num)

/-- **Ligozat's Kronecker character is trivial at level 11.** -/
theorem kroneckerSym_eleven_eq_one {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) :
    kroneckerSym (ligozatKroneckerNum 11 drk11R11 2) (γ 1 1) = 1 := by
  have hgcd : Int.gcd (11 : ℤ) (γ 1 1) = 1 := by
    simpa using gcd_pow_of_not_dvd (p := 11) (by norm_num) (drk12_eleven_not_dvd hγ) 1
  rw [drk12_pin_num_eleven, show (121 : ℤ) = 11 ^ 2 by norm_num]
  exact kroneckerSym_sq_of_gcd hgcd

/-- **`ETA-01`'s conclusion at `N = 11`, `r = (2,2)`, `k = 2`, on ALL of `Γ₀(11)`** — PROVED,
`sorry`-free, and NOT through `ligozat_general`.  Both sides are `1`. -/
theorem etaMultiplierVal_eq_kroneckerSym_eleven {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) :
    etaMultiplierVal 11 drk11R11 2 γ
      = ((kroneckerSym (ligozatKroneckerNum 11 drk11R11 2) (γ 1 1) : ℤ) : ℂ) := by
  rw [etaMultiplierVal_eleven_eq_one hγ, kroneckerSym_eleven_eq_one hγ]
  norm_num

/-- **`DRK-11`'s exact conclusion at `N = 11`, `r = (2,2)`, `k = 2`** — PROVED, `sorry`-free.

`DRK-11` was known only for `0 < N ≤ 4` (`exp_etaPhiSum_eq_kroneckerSym_of_le_four`, `DRK-11A`).
`N = 11` is outside that range, and the proof here does not go through `DRK-11A`: it is
`DRK-09` read backwards against the generator computation of part 2.  It does NOT close
`DRK-11`, which is quantified over all `N` and all `r`. -/
theorem exp_etaPhiSum_eq_kroneckerSym_eleven {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11)
    (hc : 0 < γ 1 0) :
    (-Complex.I) ^ (2 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((etaPhiSum 11 drk11R11 γ : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 11 drk11R11 2) (γ 1 1) : ℤ) : ℂ) := by
  rw [← etaMultiplierVal_eq_exp_etaPhiSum drk11R11 drk12_pin_R11_sum hγ hc]
  exact etaMultiplierVal_eq_kroneckerSym_eleven hγ

end Character

/-! ## DRK-12, part 4 — THE HEADLINE: FLT's `etaProductEleven_transform`, proved -/

section Headline

/-- `∏_{δ ∣ 11} η(δτ)^{r_δ} = η(τ)²·η(11τ)²` for `r = (2,2)`. -/
theorem etaQuotientH_eleven_eq (τ : ℍ) :
    etaQuotientH 11 drk11R11 τ
      = ModularForm.eta (τ : ℂ) ^ 2 * ModularForm.eta (11 * (τ : ℂ)) ^ 2 := by
  rw [etaQuotientH, etaQuotient, show (11 : ℕ).divisors = ({1, 11} : Finset ℕ) from by decide,
    Finset.prod_pair (by norm_num : (1 : ℕ) ≠ 11)]
  norm_num [drk11R11]
  norm_cast

/-- **DRK-12, THE HEADLINE — FLT's `ModularForm.etaProductEleven_transform`, PROVED here by an
independent route.**

`η(γτ)²·η(11·γτ)² = denom(γ,τ)² · (η(τ)²·η(11τ)²)` for every `γ ∈ Γ₀(11)`, every `τ : ℍ`.

Statement overlap with `anthropics/fermats-last-theorem`
`Theorems/Thm_ModularForm_etaProductEleven_transform.lean` is NAMED, not hidden (LL-25); see
`ATTRIBUTION.md §DRK-12`.  The proof is ours and shares no step with FLT's. -/
theorem ModularForm.etaProductEleven_transform {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) (τ : ℍ) :
    ModularForm.eta ((γ • τ : ℍ) : ℂ) ^ 2 * ModularForm.eta (11 * ((γ • τ : ℍ) : ℂ)) ^ 2
      = denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (τ : ℂ) ^ (2 : ℤ)
        * (ModularForm.eta (τ : ℂ) ^ 2 * ModularForm.eta (11 * (τ : ℂ)) ^ 2) := by
  have h := etaQuotientH_transform drk11R11 drk12_pin_R11_sum hγ τ
  rw [etaQuotientH_eleven_eq, etaQuotientH_eleven_eq, etaMultiplierVal_eleven_eq_one hγ,
    one_mul] at h
  exact h

/-- The same, in the library's `etaQuotientH` idiom — the shape `ligozat_kronecker_transform`
would have produced, with the character already discharged. -/
theorem etaQuotientH_transform_p11 {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) (τ : ℍ) :
    etaQuotientH 11 drk11R11 (γ • τ)
      = (denom (γ : GL (Fin 2) ℝ) (τ : ℂ)) ^ (2 : ℤ) * etaQuotientH 11 drk11R11 τ := by
  rw [etaQuotientH_transform drk11R11 drk12_pin_R11_sum hγ τ, etaMultiplierVal_eleven_eq_one hγ,
    one_mul]

/-- Slash invariance of `η²·η(11·)²` for the weight-2 slash action of `Γ₀(11)` — the
`slash_action_eq'` field of `ModularForm (Γ₀ 11) 2`, discharged.

WHAT IS STILL MISSING FOR A `ModularForm`, LET ALONE FLT'S `CuspForm` (LL-1): holomorphy is
`mdiff_etaQuotientH`, but BOUNDEDNESS at the cusps is still the hypothesis `hbd` of
`etaQuotientModularFormGeneral` (`F3.1-OBSTRUCTED`), and FLT's `CuspForm` statement needs
VANISHING, which is strictly stronger again.  Neither is proved here. -/
theorem etaQuotientH_eleven_slash :
    ∀ g ∈ (Gamma0 11 : Subgroup (GL (Fin 2) ℝ)),
      (etaQuotientH 11 drk11R11) ∣[(2 : ℤ)] g = etaQuotientH 11 drk11R11 :=
  etaQuotientH_slash_of_kronecker (k := 2) drk11R11
    (fun γ z => by
      rw [etaQuotientH_transform_p11 γ.2 z, kroneckerSym_eleven_eq_one γ.2]
      push_cast; rw [one_mul])
    (fun γ => kroneckerSym_eleven_eq_one γ.2)

end Headline

/-! ## DRK-12, part 5 — COMPARATORS

The DRK-12 brief asked for comparators of the form `ligozat_general … = multiplier_eq_kronecker…`,
i.e. an `Eq` between two PROOF TERMS of one `Prop`.  **That comparator carries no information**
and is deliberately not written here: two proofs of the same `Prop` are equal by `rfl` under
definitional proof irrelevance, whether or not either proof is correct, and in particular whether
or not one of them still contains `sorryAx`.  (`eta01_reduction_matches_le_four` in
`EtaLigozatGeneral.lean` is such an `rfl` comparator; it is honest about being one.)

What is written instead is the library's established tripwire idiom: **the general result must
reproduce a value that was computed OUTSIDE Lean, at data that plays no role in its proof.**
-/

section Comparators

theorem drk12_matN11_mem : drk11MatN11 ∈ Gamma0 11 := by
  rw [Gamma0_mem, show drk11MatN11 1 0 = 11 from by decide]
  decide

theorem drk12_matN11_pos : (0 : ℤ) < drk11MatN11 1 0 := by
  rw [show drk11MatN11 1 0 = 11 from by decide]; norm_num

/-- **TRIPWIRE 1 — the level-11 theorem reproduces `drk11_pin_N11_even_d`.**

`γ = !![3,1;11,4]` is not a generator, is not in the Schreier table, and appears nowhere in the
proof of `etaMultiplierHom_eleven_eq_one`.  `drk11_pin_N11_even_d` fixes the value there from a
kernel evaluation `etaPhiSum = 12` computed independently in Python.  If the generation argument, any of
the ten `etaPhiSum` pins, or the `(-i)^k` sign were wrong, the two would disagree. -/
theorem drk12_matches_pin_N11_even_d :
    (-Complex.I) ^ (2 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 11 drk11R11 drk11MatN11 : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 11 drk11R11 2) (drk11MatN11 1 1) : ℤ) : ℂ) :=
  exp_etaPhiSum_eq_kroneckerSym_eleven drk12_matN11_mem drk12_matN11_pos

/-- **TRIPWIRE 2 — the two routes to the same numeral agree, and the numeral is `12`.**

`drk12_matches_pin_N11_even_d` is proved from the GENERATION argument; `drk11_pin_N11_even_d` is
proved from the KERNEL EVALUATION `etaPhiSum = 12`.  Their conclusions are the same `Prop`, so an `Eq`
between the two proof terms would be `rfl` and would say nothing (see the section docstring).
The informative statement is that the kernel value is what the generation argument forces: with
`etaPhiSum` replaced by anything not `≡ 12 (mod 24)` the left-hand side is not `1`. -/
theorem drk12_pin_N11_value : etaPhiSum 11 drk11R11 drk11MatN11 - 6 * 2 = 24 * 0 := by
  rw [drk11_phi_N11]; norm_num

/-- **TRIPWIRE 3 — the generation route agrees with run 3 at `N ≤ 4`, on VALUES.**

`drk11MatN4 = !![1,0;4,1] ∈ Γ₀(4)`, `r = drk11R4`, `k = 8`.  ROUTE A is run 3's `F3.2-B3`
(`multiplier_eq_kronecker_of_le_four`) through `DRK-11A`; ROUTE B is `DRK-09` plus the kernel
value `etaPhiSum = 24` of `drk11_phi_N4`.  Both must land on the numeral `1`.  These are two proofs of
one numeric statement, not an `Eq` between proof terms. -/
theorem drk12_R4_sum : ∑ δ ∈ (4 : ℕ).divisors, drk11R4 δ = 2 * 8 := by decide

theorem drk12_R4_congr1 : LigozatCongr1 4 drk11R4 := by
  have h : ∑ δ ∈ (4 : ℕ).divisors, (δ : ℤ) * drk11R4 δ = 24 := by decide
  exact ⟨1, by rw [h]; ring⟩

theorem drk12_R4_congr2 : LigozatCongr2 4 drk11R4 := by
  have h : ∑ δ ∈ (4 : ℕ).divisors, ((4 / δ : ℕ) : ℤ) * drk11R4 δ = 24 := by decide
  exact ⟨1, by rw [h]; ring⟩

theorem drk12_matN4_mem : drk11MatN4 ∈ Gamma0 4 := by
  rw [Gamma0_mem, show drk11MatN4 1 0 = 4 from by decide]
  decide

theorem drk12_matN4_pos : (0 : ℤ) < drk11MatN4 1 0 := by
  rw [show drk11MatN4 1 0 = 4 from by decide]; norm_num

/-- ROUTE B — `DRK-09` plus the kernel value `etaPhiSum = 24` of `drk11_phi_N4`.  No `F3.2-B3` step. -/
theorem drk12_le_four_routeB : etaMultiplierVal 4 drk11R4 8 drk11MatN4 = 1 := by
  rw [etaMultiplierVal_eq_exp_etaPhiSum drk11R4 drk12_R4_sum drk12_matN4_mem drk12_matN4_pos,
    drk11_phi_N4]
  exact drk11_eq_one_of (-1) (by norm_num)

/-- ROUTE A — run 3's `N ≤ 4` character formula, then the symbol `(2⁴⁸ / 1) = 1`.  Shares no
step with ROUTE B: it never evaluates `etaPhiSum`. -/
theorem drk12_le_four_routeA : etaMultiplierVal 4 drk11R4 8 drk11MatN4 = 1 := by
  rw [etaMultiplierVal_eq_kroneckerSym_of_le_four (N := 4) (by norm_num) (by norm_num)
      drk11R4 drk12_R4_sum drk12_R4_congr1 drk12_R4_congr2 drk12_matN4_mem,
    drk11_num_N4, drk11_d_N4, drk11_sym_N4]
  norm_num

end Comparators

/-! ## DRK-12, part 6 — THE ROUTE THROUGH `ligozat_general` (STILL OPEN)

For the record, and so that the difference is machine-checked rather than asserted: the same
level-11 statement, derived from `ligozat_general` instead of from the generation argument.  It
is TRUE (part 4 proves it) but its proof is NOT `sorry`-free — it inherits `DRK-11`'s `sorry`
through `ligozat_kronecker_transform`.  `FinalCheck.lean` carries an INVERTED tripwire on it.

This is the honest form of the DRK-12 brief's `etaProductEleven_via_ligozat_general`. -/

section ViaLigozatGeneral

/-- **NOT `sorry`-free — inherits `DRK-11`'s `sorry` through `ligozat_general`.**  Use
`ModularForm.etaProductEleven_transform` instead; this exists only as the comparator that shows
which of the two routes is closed. -/
theorem etaProductEleven_via_ligozat_general {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) (τ : ℍ) :
    ModularForm.eta ((γ • τ : ℍ) : ℂ) ^ 2 * ModularForm.eta (11 * ((γ • τ : ℍ) : ℂ)) ^ 2
      = denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (τ : ℂ) ^ (2 : ℤ)
        * (ModularForm.eta (τ : ℂ) ^ 2 * ModularForm.eta (11 * (τ : ℂ)) ^ 2) := by
  have h := ligozat_kronecker_transform (N := 11) (by norm_num) drk11R11 drk12_pin_R11_sum
    drk12_R11_congr1 drk12_R11_congr2 ⟨γ, hγ⟩ τ
  rw [kroneckerSym_eleven_eq_one hγ] at h
  rw [etaQuotientH_eleven_eq, etaQuotientH_eleven_eq] at h
  push_cast at h
  rw [one_mul] at h
  exact h

end ViaLigozatGeneral

end SocrateAI.ModularForms
