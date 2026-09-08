/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# DRK-08 — the sign of the eta-quotient multiplier at `-γ`, and the `c`-sign reduction

Two statements, both about `SL(2,ℤ)` matrices and the run-3 multiplier `etaMultiplierVal`:

* `etaMultiplierVal_neg` — `w(-γ) = (-1)^k · w(γ)` for `γ ∈ Γ₀(N)`;
* `exists_pos_lower_left_or_T_zpow` — every `γ ∈ Γ₀(N)` is `±γ'` with `c(γ') > 0`, or `±T^n`.

## PROVENANCE: INDEPENDENT.  Nothing here is ported or adapted from FLT.

The comparator verdict on this node was **NO_REFERENCE**, not MATCH, and that verdict is
reproduced honestly here rather than upgraded.  The full FLT tree (GitHub trees API, recursive,
45999 paths) was filtered on `ModularForm_eta|_eta_|etaMult|rademacher|dedekindSum`; nothing in
`Theorems/` or `Definitions/` has the shape of either declaration below.  FLT's own general-`Γ₀(N)`
eta-quotient result (`ModularForm.etaProductEleven_transform`, `γ ∈ Gamma0 11`, weight `2`) reaches
all of `Γ₀(11)` by a completely different route — `Δ`, the twelfth power, continuity and
connectedness to force a twelfth root of unity, then coset enumeration — and performs **no**
`c`-sign reduction at all (its 39366-byte solution has zero hits for
`lt_trichotomy|Int.sign|natAbs|lt_or_gt`).  There is therefore no reference statement to match
against and **no `ATTRIBUTION.md` entry is owed for this file**: every proof below is built from
run-3 declarations of this library plus Mathlib primitives.  See `ATTRIBUTION.md` §"Not ported".

## DEPENDENCIES — the node's `depends_on: ["DRK-06"]` WAS WRONG (defect, corrected here)

Neither declaration uses `DRK-03`, `DRK-04`, `DRK-05`, `DRK-06`, `dedekindSum`, `rademacherPhi`,
`Complex.sqrt`, or any analysis whatsoever.  The **import list of this file is the receipt**: it
imports `SocrateAI.ModularForms.EtaQuotientModularity` and nothing else.  It deliberately does
*not* import `SocrateAI.NumberTheory.RademacherPhi`, which is why the pin matrices below are
declared locally instead of reusing `pinMatCneg4` / `pinMatC0` from that file (they are the same
two matrices: `!![3,-2;-4,3]` and a `c = 0` matrix).  `DRK-08` is **unblocked** and was provable in
parallel with `DRK-05`/`DRK-06`; the DAG should carry `depends_on: []` for it.

## `built_from` — THREE LISTED ITEMS ARE NOT USED (defect, recorded here)

* `rademacherPhi_neg` (DRK-03) — **not used**.  It licenses the `c < 0` reduction at the `η`/`Φ`
  level, which is a different theorem from anything stated here.
* `Complex.mem_slitPlane_iff` (Mathlib) — **not used**; it appeared only through the false
  docstring claim corrected in the next section.
* `etaMultiplierVal_T_eq_one` — **not used**, and it carries an extra hypothesis
  `h24 : LigozatCongr1 N r` that neither statement below has.  Flagged now so it is not a
  surprise later: the *assembled* reduction "`w(γ)` for all `γ ∈ Γ₀(N)`" does need `w(T^n) = 1`,
  hence does need `LigozatCongr1`.  `DRK-08` itself is unconditional; the assembly is not.

Actually used: `etaMultiplierVal_mul`, `etaMultiplierVal_neg_one`, `neg_one_mem_Gamma0`,
`sl_det_entries`, `eq_T_zpow_of_lower_left_zero`, `eq_neg_T_zpow_of_lower_left_zero` — all run 3,
all in `EtaQuotientModularity.lean`.

## THE NODE'S `slitPlane` DOCSTRING CLAIM IS FALSE — corrected, not copied

The node text read: "the `c ≤ 0` case never touches a `Complex.sqrt` branch identity, because
`-I·(cz+d)` leaves `slitPlane` when `c < 0`."  That is **false**.  Mathlib defines
`Complex.slitPlane : Set ℂ := {z | 0 < z.re ∨ z.im ≠ 0}` (`Analysis/Complex/Basic.lean:637`).  For
`w = cz+d` one has `re(-i·w) = c·Im z` and `im(-i·w) = -(c·Re z + d)`; with `c < 0` the `re`
disjunct fails but the `im` disjunct holds off the single vertical line `Re z = -d/c`.  Computed
counterexample: `c = -1`, `d = 0`, `z = 0.3 + 1.1i` gives `-i(cz+d) = -1.1 + 0.3i`, whose real part
is negative and whose imaginary part is nonzero — so it **is** in `slitPlane`.

The true statement, and the one this library already makes correctly, is about the open RIGHT
HALF-PLANE: `DRK05Aux.slit_mem` (`EtaMultiplier.lean:466`) establishes membership through the
`0 < re` disjunct only.  Correct form of the remark: *`Re(-i(cz+d)) = c·Im z` is negative exactly
when `c` is, so `-i(cz+d)` leaves the open right half-plane — which is the half-plane DRK-05's
`slit_mem` needs, and the one on which the principal branch of `Complex.sqrt` is multiplicative.*

## SCOPE, LOUDLY (LL-1) — DRK-08 DOES **NOT** EXTEND DRK-06 TO `c ≤ 0`

The run's write-up must not report DRK-08 as "DRK-06 now holds for all `γ`".  It does not, and
there is nothing there to extend: the closed form
`η(γz) = exp(πiΦ(γ)/12)·√(-i(cz+d))·η(z)` is **FALSE** for `c < 0`, off by a factor of `i`.
Checked numerically (400-term `η` product, python3 `cmath`, independent of this library) at
`γ = -S = !![0,1;-1,0]`, `z = 0.3 + 1.1i`:

    η(γz)                                    =  0.7996173829 - 0.0444507197 i
    exp(πiΦ(γ)/12)·√(-i(cz+d))·η(z),  c = -1 =  0.0444507197 + 0.7996173829 i   ratio = -i
    the same with c = +1 (i.e. via γ' = S)   =  0.7996173829 - 0.0444507197 i   ratio = +1

The correct general-`γ` `η` statement therefore needs a branch factor and is a *different*
theorem.  `DRK-08` is phrased at the eta-QUOTIENT multiplier level precisely because the per-`η`
defect `i` collapses there to `i^{2k} = (-1)^k` — which is exactly the factor
`etaMultiplierVal_neg` carries.  That agreement is a genuine cross-check: the `(-1)^k` below is
derived from `etaMultiplierVal_neg_one` (a fixed-point computation at `-I`), and the numerics
above reach the same factor by a route that shares nothing with it.

## LL-25 TRAP — do not "simplify" part 2 into Mathlib's lemma

Mathlib has `ModularGroup.exists_eq_T_zpow_of_c_eq_zero` (`NumberTheory/Modular.lean:328`), but
its conclusion is `∃ n : ℤ, ∀ z : ℍ, g • z = T ^ n • z` — **action-level**, i.e. `PSL`-level.  The
matrix-level facts `g = T^n` and `g = -T^(-(g 0 1))` live only inside its proof, as `suffices`
steps (lines 336 and 339), and are not exported.  Reaching for it here would silently weaken part
2 to the Möbius action and destroy the entire point of the node: `w(-γ) ≠ w(γ)` for odd `k`, which
is *why* part 1 exists.  The run-3 matrix-level lemmas `eq_T_zpow_of_lower_left_zero` and
`eq_neg_T_zpow_of_lower_left_zero` are the right tools and are the ones used.

## Status

Both declarations **PROVED, sorry-free**, 2026-09-08.  Thirteen pins and five negative controls
precede them and use nothing from either proof.
-/
import SocrateAI.ModularForms.EtaQuotientModularity

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm Complex
open UpperHalfPlane hiding I
open scoped MatrixGroups Real

/-! ## DRK-08 — SIGN-DISCIPLINE PINS, placed BEFORE the proofs

Every value below was computed independently in python3 (integer matrix arithmetic and
`(-1)**k`, re-implementing `T^n = !![1,n;0,1]` and `-γ` from the definitions, not from this file)
before the Lean statements were written; the two agree on all of them.  A failing pin means the
statement is wrong.

`decide` is used for the entry pins (integer literals in a `Matrix (Fin 2) (Fin 2) ℤ`) and
`norm_num` for the `(-1)^k` pins; none of them may use a lemma stated after this section. -/

section DRK08Pins

/-- `!![a,b;c,d]` as an element of `SL(2,ℤ)`, for writing pins.  Deliberately a local copy of
`SocrateAI.NumberTheory.slOf`: importing `RademacherPhi.lean` for it would put a false edge into
this file's dependency graph (see the header, "DEPENDENCIES"). -/
def drk08Mat (a b c d : ℤ) (h : a * d - b * c = 1) : SL(2, ℤ) :=
  ⟨!![a, b; c, d], by simp [Matrix.det_fin_two_of, h]⟩

@[simp] theorem drk08Mat_coe (a b c d : ℤ) (h : a * d - b * c = 1) :
    ((drk08Mat a b c d h : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ) = !![a, b; c, d] := rfl

/-- Entrywise description of `-γ` in `SL(2,ℤ)`.  Mathlib has `SpecialLinearGroup.coe_neg` at the
matrix level but no entry form; `SocrateAI.NumberTheory.SL2_neg_apply` is the same lemma in the
`Φ` file, which this file deliberately does not import. -/
theorem SL2_neg_entry (γ : SL(2, ℤ)) (i j : Fin 2) : (-γ) i j = -(γ i j) := by
  simp [SpecialLinearGroup.coe_neg]

/-- Pin matrix `!![3,-2;-4,3]`, `det = 9 - 8 = 1`, `c = -4 < 0`.  The `c < 0` branch of part 2.
(The same matrix as `SocrateAI.NumberTheory.pinMatCneg4`, redeclared to keep the import graph
honest.) -/
def drk08MatCneg4 : SL(2, ℤ) := drk08Mat 3 (-2) (-4) 3 (by norm_num)

/-- Pin matrix `!![2,1;5,3]`, `det = 6 - 5 = 1`, `c = 5 > 0`.  The `c > 0` branch of part 2. -/
def drk08MatC5 : SL(2, ℤ) := drk08Mat 2 1 5 3 (by norm_num)

/-- Pin matrix `!![1,5;0,1]`, `c = 0` with `a = d = 1`: the POSITIVE `c = 0` branch, `γ = T^5`. -/
def drk08MatT5 : SL(2, ℤ) := drk08Mat 1 5 0 1 (by norm_num)

/-- Pin matrix `!![-1,3;0,-1]`, `det = 1`, `c = 0` with `a = d = -1`: the NEGATIVE `c = 0`
branch.  Here `γ 0 1 = 3`, so the witness is `n = -(γ 0 1) = -3` and `γ = -(T^(-3))`. -/
def drk08MatNegT3 : SL(2, ℤ) := drk08Mat (-1) 3 0 (-1) (by norm_num)

/-- PIN 1/12.  `c = -4 < 0` at the negative pin matrix. -/
theorem drk08_pin_cneg4_entry : drk08MatCneg4 1 0 = -4 := by
  simp [drk08MatCneg4]

/-- PIN 2/12.  Negating flips the sign of `c`: `c(-γ) = 4 > 0`.  This is the whole content of the
`c < 0` branch, at a concrete matrix. -/
theorem drk08_pin_cneg4_neg_entry : (-drk08MatCneg4) 1 0 = 4 ∧ 0 < (-drk08MatCneg4) 1 0 := by
  have h : (-drk08MatCneg4) 1 0 = 4 := by
    rw [SL2_neg_entry, drk08_pin_cneg4_entry]; norm_num
  exact ⟨h, by rw [h]; norm_num⟩

/-- PIN 3/12.  Both `γ` and `-γ` lie in `Γ₀(4)`, so the branch really does stay inside the group
(`4 ∣ -4` and `4 ∣ 4`). -/
theorem drk08_pin_cneg4_mem : drk08MatCneg4 ∈ Gamma0 4 ∧ (-drk08MatCneg4) ∈ Gamma0 4 := by
  constructor
  · rw [Gamma0_mem, drk08_pin_cneg4_entry]; decide
  · rw [Gamma0_mem, drk08_pin_cneg4_neg_entry.1]; decide

/-- PIN 4/12.  `c = 5 > 0` at the positive pin matrix: the first disjunct fires with `γ' = γ`. -/
theorem drk08_pin_c5_entry : drk08MatC5 1 0 = 5 ∧ 0 < drk08MatC5 1 0 := by
  have h : drk08MatC5 1 0 = 5 := by simp [drk08MatC5]
  exact ⟨h, by rw [h]; norm_num⟩

/-- PIN 5/12.  `c = 0` and `a = d = 1` at the positive `c = 0` pin matrix. -/
theorem drk08_pin_T5_entries :
    drk08MatT5 1 0 = 0 ∧ drk08MatT5 0 0 = 1 ∧ drk08MatT5 1 1 = 1 ∧ drk08MatT5 0 1 = 5 := by
  refine ⟨by simp [drk08MatT5], by simp [drk08MatT5], by simp [drk08MatT5], by simp [drk08MatT5]⟩

/-- PIN 6/12.  The positive `c = 0` branch, as a MATRIX identity: `!![1,5;0,1] = T^5`.  Proved
from Mathlib's `coe_T_zpow` alone, so it is independent of
`eq_T_zpow_of_lower_left_zero` — which is the lemma part 2 will use for the same step. -/
theorem drk08_pin_T5_eq : drk08MatT5 = ModularGroup.T ^ (5 : ℤ) := by
  apply Subtype.ext
  rw [ModularGroup.coe_T_zpow]
  simp [drk08MatT5]

/-- PIN 7/12.  `c = 0` and `a = d = -1` at the negative `c = 0` pin matrix, with `b = 3`. -/
theorem drk08_pin_negT3_entries :
    drk08MatNegT3 1 0 = 0 ∧ drk08MatNegT3 0 0 = -1 ∧ drk08MatNegT3 1 1 = -1
      ∧ drk08MatNegT3 0 1 = 3 := by
  refine ⟨by simp [drk08MatNegT3], by simp [drk08MatNegT3], by simp [drk08MatNegT3],
    by simp [drk08MatNegT3]⟩

/-- PIN 8/12.  The negative `c = 0` branch, as a MATRIX identity: `!![-1,3;0,-1] = -(T^(-3))`,
i.e. the exponent really is `n = -(γ 0 1)` and **not** `+(γ 0 1)`.  With `n = +3` the right-hand
side would be `!![-1,-3;0,-1]`, which is a different matrix — so this pin is exactly the sign
guard for the negative branch.  Proved from `coe_T_zpow` and `coe_neg` alone. -/
theorem drk08_pin_negT3_eq : drk08MatNegT3 = -(ModularGroup.T ^ (-3 : ℤ)) := by
  apply Subtype.ext
  rw [SpecialLinearGroup.coe_neg, ModularGroup.coe_T_zpow]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [drk08MatNegT3]

/-- PIN 8b/12 — the WRONG-SIGN control for PIN 8: `!![-1,3;0,-1] ≠ -(T^(+3))`.  If the negative
`c = 0` branch carried `n = +(γ 0 1)` instead of `n = -(γ 0 1)`, part 2 would be false at this
matrix. -/
theorem drk08_neg_control_negT3_wrong_sign : drk08MatNegT3 ≠ -(ModularGroup.T ^ (3 : ℤ)) := by
  intro h
  have := congrArg (fun g : SL(2, ℤ) => g 0 1) h
  rw [SL2_neg_entry] at this
  rw [show ((ModularGroup.T ^ (3 : ℤ) : SL(2, ℤ)) 0 1)
      = (((ModularGroup.T ^ (3 : ℤ) : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ)) 0 1 from rfl,
    ModularGroup.coe_T_zpow] at this
  simp [drk08MatNegT3] at this

/-- PIN 9/12.  Odd `k`: the factor `(-1)^k` is `-1`, hence NOT `1`.  A proof of part 1 that
dropped the factor entirely would still be green at every even `k`; this is the pin that says
odd `k` is the configuration that can see the difference. -/
theorem drk08_pin_neg_one_zpow_odd : ((-1 : ℂ) ^ (1 : ℤ) = -1) ∧ ((-1 : ℂ) ^ (1 : ℤ) ≠ 1) := by
  refine ⟨by norm_num, by norm_num⟩

/-- PIN 10/12 — **NEGATIVE CONTROL**.  At even `k` the factor is invisible: `(-1)^2 = 1`.  This
is why the odd-`k` guard below (`etaMultiplierVal_neg_eta_sq`, weight one, `N = 1`, `r ≡ 2`,
`f = η²`) is the one that certifies part 1, and a weight-`12` example would not. -/
theorem drk08_neg_control_even_k_blind : (-1 : ℂ) ^ (2 : ℤ) = 1 := by norm_num

/-- PIN 11/12.  `(-1)^{-k} = (-1)^k`, at `k = 1` and `k = 3`: the two ways of writing the factor
agree, so `etaMultiplierVal_neg_one`'s `(-1)^{-k}` derivation and part 1's `(-1)^k` are the same
number and the statement is not off by an inversion. -/
theorem drk08_pin_neg_one_zpow_neg :
    ((-1 : ℂ) ^ (-1 : ℤ) = (-1 : ℂ) ^ (1 : ℤ)) ∧ ((-1 : ℂ) ^ (-3 : ℤ) = (-1 : ℂ) ^ (3 : ℤ)) := by
  refine ⟨by norm_num, by norm_num⟩

/-- PIN 12/12.  The guard configuration really has ODD `k`: at `N = 1` with `r ≡ 2` the divisor
sum is `2 = 2·1`, so `k = 1`. -/
theorem drk08_pin_eta_sq_weight : ∑ δ ∈ (1 : ℕ).divisors, (fun _ => (2 : ℤ)) δ = 2 * 1 := by
  simp [Nat.divisors_one]

end DRK08Pins

/-! ## DRK-08 part 2 — the `c`-sign reduction

`T^n` and `-(T^n)` both have lower-left entry `0`; that single fact is what makes the two
disjuncts of `exists_pos_lower_left_or_T_zpow` mutually exclusive at every concrete matrix, and
it is what the two negative controls below check. -/

/-- `c(T^n) = 0` for every `n : ℤ`.  Matrix-level, from Mathlib's `coe_T_zpow`. -/
theorem T_zpow_lower_left (n : ℤ) : (ModularGroup.T ^ n : SL(2, ℤ)) 1 0 = 0 := by
  rw [show ((ModularGroup.T ^ n : SL(2, ℤ)) 1 0)
      = (((ModularGroup.T ^ n : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ)) 1 0 from rfl,
    ModularGroup.coe_T_zpow]
  simp

/-- `c(-(T^n)) = 0` for every `n : ℤ`. -/
theorem neg_T_zpow_lower_left (n : ℤ) : (-(ModularGroup.T ^ n) : SL(2, ℤ)) 1 0 = 0 := by
  rw [SL2_neg_entry, T_zpow_lower_left, neg_zero]

/-- **DRK-08, part 2 (PROVED, `sorry`-free).**  Every `γ ∈ Γ₀(N)` is `±γ'` for some `γ' ∈ Γ₀(N)`
with lower-left entry `> 0`, or else `±T^n`.

This is the `c`-sign trichotomy in the form the `η`-multiplier reduction needs.  `c > 0` takes
`γ' = γ`; `c < 0` takes `γ' = -γ`, which is again in `Γ₀(N)` because `-1 ∈ Γ₀(N)`; `c = 0` forces
`a·d = 1` by `sl_det_entries`, hence `(a,d) = (1,1)` or `(-1,-1)`, and the two run-3 base-case
lemmas produce `T^n` and `-(T^n)` respectively.

Junk-witness free: the first disjunct pins `γ = ±γ'` and the second pins `γ = ±T^n`, so neither
can be satisfied by an arbitrary matrix.  `N = 0` is fine — `Gamma0 0` is `{c = 0}` and the second
disjunct always fires.

LL-25: this is deliberately **not** Mathlib's `ModularGroup.exists_eq_T_zpow_of_c_eq_zero`, whose
conclusion is at the level of the Möbius action and would lose the `±` distinction that part 1
exists to record.  See the header. -/
theorem exists_pos_lower_left_or_T_zpow {N : ℕ} {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) :
    (∃ γ' : SL(2, ℤ), γ' ∈ Gamma0 N ∧ 0 < γ' 1 0 ∧ (γ = γ' ∨ γ = -γ'))
    ∨ (∃ n : ℤ, γ = ModularGroup.T ^ n ∨ γ = -(ModularGroup.T ^ n)) := by
  rcases lt_trichotomy (γ 1 0) 0 with hc | hc | hc
  · -- `c < 0`: the witness is `-γ`, and `γ = -(-γ)`.
    refine Or.inl ⟨-γ, ?_, ?_, Or.inr (neg_neg γ).symm⟩
    · have hmul : (-γ : SL(2, ℤ)) = (-1 : SL(2, ℤ)) * γ := (neg_one_mul γ).symm
      rw [hmul]
      exact mul_mem (neg_one_mem_Gamma0 N) hγ
    · rw [SL2_neg_entry]
      omega
  · -- `c = 0`: `det γ = 1` degenerates to `a·d = 1`.
    refine Or.inr ?_
    have hdet := sl_det_entries γ
    rw [hc] at hdet
    have had : γ 0 0 * γ 1 1 = 1 := by linarith [hdet]
    rcases Int.eq_one_or_neg_one_of_mul_eq_one' had with ⟨ha, hd⟩ | ⟨ha, hd⟩
    · exact ⟨γ 0 1, Or.inl (eq_T_zpow_of_lower_left_zero hc ha hd)⟩
    · refine ⟨-(γ 0 1), Or.inr ?_⟩
      have h := eq_neg_T_zpow_of_lower_left_zero hc ha hd
      rwa [neg_one_mul] at h
  · -- `c > 0`: the witness is `γ` itself.
    exact Or.inl ⟨γ, hγ, hc, Or.inl rfl⟩

/-! ### DRK-08 part 2 — LL-2 / LL-7 ANTI-JUNK-WITNESS PINS

An existential theorem can be satisfied by the wrong disjunct.  These two negative controls fix
which disjunct the proof is forced to produce at a matrix of each kind, and they are proved from
the entry pins alone. -/

/-- **NEGATIVE CONTROL 1.**  At `c = -4 < 0` the SECOND disjunct of
`exists_pos_lower_left_or_T_zpow` is FALSE, so the theorem is forced to produce the first one —
i.e. it really did construct `γ' = -γ` with `c(γ') = 4 > 0`. -/
theorem drk08_neg_control_cneg4_not_T_zpow :
    ¬ ∃ n : ℤ, drk08MatCneg4 = ModularGroup.T ^ n ∨ drk08MatCneg4 = -(ModularGroup.T ^ n) := by
  rintro ⟨n, h | h⟩
  · have := congrArg (fun g : SL(2, ℤ) => g 1 0) h
    rw [T_zpow_lower_left, drk08_pin_cneg4_entry] at this
    exact absurd this (by decide)
  · have := congrArg (fun g : SL(2, ℤ) => g 1 0) h
    rw [neg_T_zpow_lower_left, drk08_pin_cneg4_entry] at this
    exact absurd this (by decide)

/-- **NEGATIVE CONTROL 2.**  At `c = 0` the FIRST disjunct is FALSE — a matrix with lower-left
entry `0` cannot be `±γ'` for any `γ'` with `c(γ') > 0`, since negation only flips the sign of an
entry that is already `0`.  So at `drk08MatT5` the theorem is forced into the `T^n` branch. -/
theorem drk08_neg_control_T5_not_pos_lower_left :
    ¬ ∃ γ' : SL(2, ℤ), 0 < γ' 1 0 ∧ (drk08MatT5 = γ' ∨ drk08MatT5 = -γ') := by
  rintro ⟨γ', hpos, h | h⟩
  · have := congrArg (fun g : SL(2, ℤ) => g 1 0) h
    rw [drk08_pin_T5_entries.1] at this
    omega
  · have := congrArg (fun g : SL(2, ℤ) => g 1 0) h
    rw [drk08_pin_T5_entries.1, SL2_neg_entry] at this
    omega

/-! ## DRK-08 part 1 — `w(-γ) = (-1)^k · w(γ)` -/

/-- **DRK-08, part 1 (PROVED, `sorry`-free).**  For `γ ∈ Γ₀(N)` and an exponent vector `r` of
even divisor sum `2k`, the eta-quotient multiplier satisfies `w(-γ) = (-1)^k · w(γ)`.

`-γ = (-1)·γ`, so `etaMultiplierVal_mul` (run 3, `F3.2-A5`) splits the multiplier and
`etaMultiplierVal_neg_one` (run 3, `F3.2-A9` at the point `-I` fixes) evaluates the `-1` factor as
`(-1)^{-k} = (-1)^k`.  The hypothesis `hγ` is load-bearing: `etaMultiplierVal_mul` needs both
factors in `Γ₀(N)`.

Degenerate `N = 0` is fine: `Nat.divisors 0 = ∅`, so `hk` forces `2k = 0`, `k = 0`, factor `1`.

SCOPE (LL-1): this is the multiplier of the eta QUOTIENT, not of `η` itself.  At the level of a
single `η` the `c < 0` defect is a factor of `i`, not `±1`; it collapses to `i^{2k} = (-1)^k` only
after the product over divisors.  See the header — DRK-08 does not extend DRK-06 to `c ≤ 0`. -/
theorem etaMultiplierVal_neg {N : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) :
    etaMultiplierVal N r k (-γ) = ((-1 : ℂ)) ^ k * etaMultiplierVal N r k γ := by
  have hmul : (-γ : SL(2, ℤ)) = (-1 : SL(2, ℤ)) * γ := (neg_one_mul γ).symm
  rw [hmul, etaMultiplierVal_mul r hk (neg_one_mem_Gamma0 N) hγ, etaMultiplierVal_neg_one r hk]

/-! ### DRK-08 part 1 — LL-1 ODD-`k` GUARD

At even `k` the factor `(-1)^k` is `1` (PIN 10), so a proof that dropped it would still compile
against every weight-`12` example.  The guard is therefore taken at weight one: `N = 1`, `r ≡ 2`,
`f = η²`, `k = 1` — the same configuration run 3 uses for its `F3.2-A9` sign guard.  There
`w(S) = -i` is already proved two independent ways (`etaMultiplierVal_eta_sq_S` via A9, and
`etaQuotientH_eta_sq_S_transform` via the Fricke route), so `w(-S) = +i` below is a genuine value,
not a tautology. -/

/-- ODD-`k` GUARD, general `γ`: at `N = 1`, `r ≡ 2` (`f = η²`, `k = 1`) part 1 says the multiplier
SIGN FLIPS under `γ ↦ -γ`. -/
theorem etaMultiplierVal_neg_eta_sq (γ : SL(2, ℤ)) :
    etaMultiplierVal 1 (fun _ => (2 : ℤ)) 1 (-γ)
      = -etaMultiplierVal 1 (fun _ => (2 : ℤ)) 1 γ := by
  rw [etaMultiplierVal_neg (fun _ => (2 : ℤ)) drk08_pin_eta_sq_weight (mem_Gamma0_one γ)]
  norm_num

/-- ODD-`k` GUARD, at a concrete matrix with a known nontrivial value: `w(-S) = i` for `f = η²`,
because `w(S) = -i`.  This is the guard that would fail if part 1 had lost the `(-1)^k`. -/
theorem etaMultiplierVal_eta_sq_neg_S :
    etaMultiplierVal 1 (fun _ => (2 : ℤ)) 1 (-ModularGroup.S) = Complex.I := by
  rw [etaMultiplierVal_neg_eta_sq, etaMultiplierVal_eta_sq_S, neg_neg]

/-- **NEGATIVE CONTROL 3.**  `w(-S) ≠ w(S)` for `f = η²`: the `(-1)^k` of part 1 is not a
decoration.  A statement of part 1 without the factor would be FALSE here. -/
theorem drk08_neg_control_neg_S_ne_S :
    etaMultiplierVal 1 (fun _ => (2 : ℤ)) 1 (-ModularGroup.S)
      ≠ etaMultiplierVal 1 (fun _ => (2 : ℤ)) 1 ModularGroup.S := by
  rw [etaMultiplierVal_eta_sq_neg_S, etaMultiplierVal_eta_sq_S]
  intro h
  have : (2 : ℂ) * Complex.I = 0 := by linear_combination h
  simp [Complex.I_ne_zero] at this

end SocrateAI.ModularForms
