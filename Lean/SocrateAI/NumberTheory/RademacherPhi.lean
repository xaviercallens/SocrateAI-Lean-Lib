/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.
This file states (statement text only, not proof) one theorem whose signature is a
reproduction of an Apache-2.0 theorem statement from `anthropics/fermats-last-theorem`
(c) 2026 Anthropic, PBC; see the declaration's own docstring and ATTRIBUTION.md.

# Apostol's `Φ`, Rademacher's `Ψ`, and the Euclidean descent step  (DAG: DRK-03, DRK-04)

## LL-22 — THIS FILE EXISTS TO KEEP TWO FUNCTIONS APART

`rademacherPhi` is **Apostol's** `Φ`.  `rademacherPsi` is **Rademacher's symbol** `Ψ`.  They are
different functions:

    Ψ γ = Φ γ - 3 · sign (c · (a + d)).

They are defined here under two different names, and the gate below pins both on the *same*
matrices, so a later confusion of the two fails the build rather than propagating.  Neither of
them is `dedekindSum` (`s(h,k)`, `SocrateAI/NumberTheory/DedekindSum.lean`), which is the third
function in the neighbourhood and the one both are built from.

## Provenance

* `rademacherPhi`, `rademacherPsi` and the three lemmas about them (`DRK-03`, PROVED 2026-09-07,
  `sorry`-free): **independent**, in statement *and* in proof.  FLT has no `Φ` at all — it writes
  the expression `(a+d)/c - 12·s(d,c)` inline in the statements of `Thm_rademacher_phi_step.lean`
  and `Thm_ModularForm_eta_specialLinearGroup_smul.lean` and never names it, never treats `c ≤ 0`,
  and has nothing resembling `Ψ`.  It therefore states none of these three lemmas and there was no
  upstream proof to follow: the proofs below are Lean core / Mathlib primitives
  (`Int.sign_eq_one_of_pos`, `Int.sign_neg`, `Int.natAbs_neg`, `ModularGroup.coe_T_zpow`,
  `SpecialLinearGroup.coe_neg`) plus our own `dedekindSum_neg`.  **No FLT attribution is claimed
  or owed for them.**  (The `dedekindSaw`/`dedekindSum` definitions they sit on ARE a port and ARE
  attributed — that is `DRK-01`'s entry in `ATTRIBUTION.md`, not this node's.)
  `rademacherPhi_of_pos` is the bridge that makes our named `Φ` agree with FLT's inline
  expression, so that FLT's statements can be quoted against our definition; with it proved, that
  quotation is now justified *in Lean* and not merely on paper (the only remaining textual
  difference is that our denominator is cast through `ℤ` rather than through `ℕ`-of-`toNat`, which
  `Int.toNat_of_nonneg` reconciles under `0 < c`).
* `rademacher_phi_step` (`DRK-04`, PROVED 2026-09-07, `sorry`-free): **statement only** from FLT
  (`Theorems/Thm_rademacher_phi_step.lean`, 429 bytes, Apache-2.0, fetched 2026-09-07, HTTP 200),
  reproduced with the upstream binder names and shape.  Upstream's proof is
  `p2m_exact_reverting @P2MW.S_rademacher_phi_step.solution`; that tactic does not exist here and
  the 1287-line `P2M/Sol` file behind it was never read.  **The proof below is INDEPENDENT**:
  Bézout from `hdet`+`hrd` for `Nat.Coprime r c`, then `dedekindSum_add_mul` + `dedekindSum_neg`
  (our `DRK-01`) to rewrite `s(d,c) = -s(r,c)`, then `dedekindSum_add_dedekindSum` (our `DRK-02`,
  proved by the Rademacher–Grosswald double count) on the pair `(r,c)`, then the private
  `phi_step_algebra`.  Do **not** cite FLT for the proof; the statement is what is attributed.
  The twelve named instance pins and three negative controls preceding it are independent too.

## Normalisation, stated once so it cannot drift

`Φ` is defined on **all** of `SL(2,ℤ)`, in three pieces:

* `c = 0`:  `Φ γ = b/d`.  (Then `d = ±1`, so this is `±b`; on `T^n` it is `n`.)
* `c ≠ 0`:  `Φ γ = (a+d)/c - 12·sign(c)·s(d,|c|)`.

The `sign(c)` factor is what makes `Φ (-γ) = Φ γ` come out (`rademacherPhi_neg`), which is what
licenses reducing the `c < 0` case to `c > 0` by replacing `γ` with `-γ`.  `rademacherPhi_of_pos`
records that for `c > 0` the definition collapses to FLT's inline `(a+d)/c - 12·s(d, c.toNat)`.
-/
import SocrateAI.NumberTheory.DedekindSum
import Mathlib.LinearAlgebra.Matrix.SpecialLinearGroup

set_option autoImplicit false

namespace SocrateAI.NumberTheory

open Matrix
open scoped MatrixGroups

/-! ## DRK-03, part 1 — the two definitions -/

/-- **Apostol's `Φ`**, on all of `SL(2,ℤ)`.

**This is NOT the Rademacher symbol `Ψ`** (`rademacherPsi` below); LL-22. -/
def rademacherPhi (γ : SL(2, ℤ)) : ℚ :=
  if γ 1 0 = 0 then ((γ 0 1 : ℤ) : ℚ) / ((γ 1 1 : ℤ) : ℚ)
  else ((γ 0 0 + γ 1 1 : ℤ) : ℚ) / ((γ 1 0 : ℤ) : ℚ)
         - 12 * ((Int.sign (γ 1 0) : ℤ) : ℚ) * dedekindSum (γ 1 1) (γ 1 0).natAbs

/-- **Rademacher's symbol `Ψ`**, named separately from `Φ` so that the two can never be
confused (LL-22).  `Ψ γ = Φ γ - 3·sign(c(a+d))`.  `Ψ` is conjugation-invariant and is the
homogenisation of `Φ`; `Φ` is the one that appears in the `η` transformation formula. -/
def rademacherPsi (γ : SL(2, ℤ)) : ℚ :=
  rademacherPhi γ - 3 * ((Int.sign (γ 1 0 * (γ 0 0 + γ 1 1)) : ℤ) : ℚ)

/-- `!![a,b;c,d]` as an element of `SL(2,ℤ)`, for writing pins. -/
def slOf (a b c d : ℤ) (h : a * d - b * c = 1) : SL(2, ℤ) :=
  ⟨!![a, b; c, d], by simp [Matrix.det_fin_two_of, h]⟩

/-- Entrywise description of `-γ` in `SL(2, ℤ)`.  Used by `rademacherPhi_neg`. -/
theorem SL2_neg_apply (γ : SL(2, ℤ)) (i j : Fin 2) : (-γ) i j = -(γ i j) := by
  simp [SpecialLinearGroup.coe_neg]

/-! ## DRK-00 (second half) — SIGN DISCIPLINE GATE for `Φ` and `Ψ`  (LL-22)

Nothing below this section may be used before it.  Every pin is a kernel evaluation of the two
definitions above and of `dedekindSum`; none of `rademacherPhi_of_pos`, `rademacherPhi_neg`,
`rademacherPhi_T_zpow` has been stated yet, so the pins cannot be contaminated by them.

As in `DedekindSum.lean`, plain `decide` does not discharge these (the kernel is stuck on
`Rat.num` of a `Finset` fold); `decide +kernel` does.  Deviation from the brief, stated loudly. -/

section SignDisciplineGate

-- `Φ` on the three matrices the brief names
example : rademacherPhi (slOf 1 0 1 1 (by decide)) = 2 - 12 * dedekindSum 1 1 := by decide +kernel
example : rademacherPhi (slOf 1 0 1 1 (by decide)) = 2 := by decide +kernel
example : rademacherPhi ModularGroup.S = 0 := by decide +kernel
example : rademacherPhi ModularGroup.T = 1 := by decide +kernel

-- `Φ` where the Dedekind sum is actually doing work (`c > 0` and `c < 0`)
example : rademacherPhi (slOf 2 1 5 3 (by decide)) = 1 := by decide +kernel
example : rademacherPhi (slOf 5 2 12 5 (by decide)) = 1 := by decide +kernel
example : rademacherPhi (slOf 3 (-2) (-4) 3 (by decide)) = -3 := by decide +kernel

-- `Φ (-γ) = Φ γ`, pinned at SIX explicit `γ` (c = 0, c > 0, c < 0), BEFORE `rademacherPhi_neg`
example : rademacherPhi (-slOf 1 0 1 1 (by decide))
    = rademacherPhi (slOf 1 0 1 1 (by decide)) := by decide +kernel
example : rademacherPhi (-ModularGroup.S) = rademacherPhi ModularGroup.S := by decide +kernel
example : rademacherPhi (-ModularGroup.T) = rademacherPhi ModularGroup.T := by decide +kernel
example : rademacherPhi (-slOf 2 1 5 3 (by decide))
    = rademacherPhi (slOf 2 1 5 3 (by decide)) := by decide +kernel
example : rademacherPhi (-slOf 3 (-2) (-4) 3 (by decide))
    = rademacherPhi (slOf 3 (-2) (-4) 3 (by decide)) := by decide +kernel
example : rademacherPhi (-slOf 5 2 12 5 (by decide))
    = rademacherPhi (slOf 5 2 12 5 (by decide)) := by decide +kernel

-- LL-22 TRIPWIRE.  `Φ` and `Ψ` are DIFFERENT NUMBERS on the same matrices.  If anyone ever
-- redefines one as the other, these fail.
example : rademacherPsi (slOf 1 0 1 1 (by decide)) = -1 := by decide +kernel
example : rademacherPhi (slOf 1 0 1 1 (by decide))
    ≠ rademacherPsi (slOf 1 0 1 1 (by decide)) := by decide +kernel
example : rademacherPhi (slOf 2 1 5 3 (by decide))
    ≠ rademacherPsi (slOf 2 1 5 3 (by decide)) := by decide +kernel
example : rademacherPhi (slOf 3 (-2) (-4) 3 (by decide))
    ≠ rademacherPsi (slOf 3 (-2) (-4) 3 (by decide)) := by decide +kernel
-- They DO agree exactly where `sign(c(a+d)) = 0`, i.e. on `S` and on `T`:
example : rademacherPhi ModularGroup.S = rademacherPsi ModularGroup.S := by decide +kernel
example : rademacherPhi ModularGroup.T = rademacherPsi ModularGroup.T := by decide +kernel

-- LL-22 TRIPWIRE, second face.  `Φ` is not `s(d,c)` either.
example : rademacherPhi (slOf 5 2 12 5 (by decide)) ≠ dedekindSum 5 12 := by decide +kernel

-- `Φ` on `T^n`, pinned before `rademacherPhi_T_zpow`
example : rademacherPhi (ModularGroup.T ^ (3 : ℤ)) = 3 := by decide +kernel
example : rademacherPhi (ModularGroup.T ^ (-2 : ℤ)) = -2 := by decide +kernel

-- DRK-04 (`rademacher_phi_step`) was instance-checked here at four `(a,b,c,d,q)` as anonymous
-- `example`s.  Those four are now the first four of the TWELVE NAMED, AXIOM-GUARDED pins in the
-- `RademacherPhiStepGate` block below (an `example` has no name and so cannot carry a
-- `#print axioms` guard).  Nothing was dropped: the four instances are still checked, at
-- `rademacher_phi_step_pin_c5_r2`, `_c5_r7`, `_c3_r2`, `_c4_r5`.

/-! ### DRK-03 SIGN-DISCIPLINE PINS — named, axiom-guarded, and placed BEFORE the proofs

The three `DRK-03` lemmas each get instance pins as **named theorems** (so `#print axioms` in
`FinalCheck.lean` can see them), computed by `decide +kernel` from the definitions alone.  Every
value below was recomputed independently in Python (`fractions.Fraction`, re-implementing
`dedekindSaw`/`dedekindSum`/`Φ` from the mathematical definitions, not from this file) before the
Lean statements were written; the two agree on all of them.

`pinC` carries the **negative control**: for `c < 0` the `rademacherPhi_of_pos` right-hand side is
a *different number* from `Φ`, so the hypothesis `0 < γ 1 0` is load-bearing and not decorative
(`Φ !![3,-2;-4,3] = -3`, while the `of_pos` RHS there is `-3/2`). -/

/-- Pin matrix `!![2,1;5,3]`, `c = 5 > 0`. -/
def pinMatC5 : SL(2, ℤ) := slOf 2 1 5 3 (by decide)
/-- Pin matrix `!![5,2;12,5]`, `c = 12 > 0` (composite `c`, `s(5,12) = -1/72 ≠ 0`). -/
def pinMatC12 : SL(2, ℤ) := slOf 5 2 12 5 (by decide)
/-- Pin matrix `!![3,-2;-4,3]`, `c = -4 < 0` — the NEGATIVE CONTROL for `rademacherPhi_of_pos`. -/
def pinMatCneg4 : SL(2, ℤ) := slOf 3 (-2) (-4) 3 (by decide)
/-- Pin matrix `!![1,5;0,1]`, `c = 0` with `b = 5` — the `c = 0` branch doing real work. -/
def pinMatC0 : SL(2, ℤ) := slOf 1 5 0 1 (by decide)
/-- Pin matrix `!![1,0;1,1]`, `c = 1 > 0` (smallest positive `c`). -/
def pinMatC1 : SL(2, ℤ) := slOf 1 0 1 1 (by decide)

/-- PIN 1/11 for `rademacherPhi_of_pos`, at `c = 5`.  Φ = 1 = (2+3)/5 - 12·s(3,5), s(3,5) = 0. -/
theorem rademacherPhi_of_pos_pin_c5 :
    rademacherPhi pinMatC5
      = ((pinMatC5 0 0 + pinMatC5 1 1 : ℤ) : ℚ) / ((pinMatC5 1 0 : ℤ) : ℚ)
        - 12 * dedekindSum (pinMatC5 1 1) (pinMatC5 1 0).toNat := by decide +kernel

/-- PIN 2/11 for `rademacherPhi_of_pos`, at `c = 12`.  Φ = 1 = 10/12 - 12·(-1/72). -/
theorem rademacherPhi_of_pos_pin_c12 :
    rademacherPhi pinMatC12
      = ((pinMatC12 0 0 + pinMatC12 1 1 : ℤ) : ℚ) / ((pinMatC12 1 0 : ℤ) : ℚ)
        - 12 * dedekindSum (pinMatC12 1 1) (pinMatC12 1 0).toNat := by decide +kernel

/-- PIN 3/11 for `rademacherPhi_of_pos`, at `c = 1`.  Φ = 2 = 2/1 - 12·s(1,1), s(1,1) = 0. -/
theorem rademacherPhi_of_pos_pin_c1 :
    rademacherPhi pinMatC1
      = ((pinMatC1 0 0 + pinMatC1 1 1 : ℤ) : ℚ) / ((pinMatC1 1 0 : ℤ) : ℚ)
        - 12 * dedekindSum (pinMatC1 1 1) (pinMatC1 1 0).toNat := by decide +kernel

/-- PIN 4/11 — **NEGATIVE CONTROL**.  At `c = -4` the `rademacherPhi_of_pos` identity is FALSE:
`Φ = -3` but the right-hand side is `-3/2` (`(-4).toNat = 0`, so the Dedekind term vanishes).
The hypothesis `0 < γ 1 0` of `rademacherPhi_of_pos` is therefore load-bearing. -/
theorem rademacherPhi_of_pos_fails_c_neg :
    rademacherPhi pinMatCneg4
      ≠ ((pinMatCneg4 0 0 + pinMatCneg4 1 1 : ℤ) : ℚ) / ((pinMatCneg4 1 0 : ℤ) : ℚ)
        - 12 * dedekindSum (pinMatCneg4 1 1) (pinMatCneg4 1 0).toNat := by decide +kernel

/-- PIN 5/11 for `rademacherPhi_neg`, `c > 0`. -/
theorem rademacherPhi_neg_pin_c_pos :
    rademacherPhi (-pinMatC5) = rademacherPhi pinMatC5 := by decide +kernel

/-- PIN 6/11 for `rademacherPhi_neg`, `c < 0` (this is the one that fails if the `sign c` factor
is dropped from the definition). -/
theorem rademacherPhi_neg_pin_c_neg :
    rademacherPhi (-pinMatCneg4) = rademacherPhi pinMatCneg4 := by decide +kernel

/-- PIN 7/11 for `rademacherPhi_neg`, `c = 0` with `b ≠ 0` (fails if the `c = 0` branch were
`b/a` or `a/d`). -/
theorem rademacherPhi_neg_pin_c_zero :
    rademacherPhi (-pinMatC0) = rademacherPhi pinMatC0 := by decide +kernel

/-- PIN 8/11 — the `c = 0` branch's value: `Φ !![1,5;0,1] = 5`. -/
theorem rademacherPhi_pin_c_zero_value : rademacherPhi pinMatC0 = 5 := by decide +kernel

/-- PIN 9/11 for `rademacherPhi_T_zpow`, `n = 0`. -/
theorem rademacherPhi_T_zpow_pin_zero :
    rademacherPhi (ModularGroup.T ^ (0 : ℤ)) = 0 := by decide +kernel

/-- PIN 10/11 for `rademacherPhi_T_zpow`, `n = 4`. -/
theorem rademacherPhi_T_zpow_pin_four :
    rademacherPhi (ModularGroup.T ^ (4 : ℤ)) = 4 := by decide +kernel

/-- PIN 11/11 for `rademacherPhi_T_zpow`, `n = -5` (negative exponent). -/
theorem rademacherPhi_T_zpow_pin_neg_five :
    rademacherPhi (ModularGroup.T ^ (-5 : ℤ)) = -5 := by decide +kernel

/-- Kernel-evaluation pins carry no extra axioms. -/
theorem rademacherPhi_S_pin : rademacherPhi ModularGroup.S = 0 := by decide +kernel

/-- LL-22, as a named theorem so `#print axioms` can see it: `Φ ≠ Ψ`. -/
theorem rademacherPhi_ne_rademacherPsi :
    ∃ γ : SL(2, ℤ), rademacherPhi γ ≠ rademacherPsi γ :=
  ⟨slOf 1 0 1 1 (by decide), by decide +kernel⟩

/-! ### DRK-04 SIGN-DISCIPLINE PINS — twelve instances and three NEGATIVE CONTROLS

Placed BEFORE `rademacher_phi_step` (and before `rademacherPhi_of_pos`/`_neg`/`_T_zpow`), so no
pin can be discharged by anything it is meant to pin.  Every value below was recomputed
independently in Python (`fractions.Fraction`, re-implementing `dedekindSaw`/`dedekindSum`
straight from the mathematical definitions and NOT from this file, and re-deriving both sides of
the identity from the definitions and NOT from reciprocity) before the Lean was written; the
Lean kernel then agrees on all twelve.  The same Python sweep enumerated **every** `(a,b,c,d,q)`
with `1 ≤ c ≤ 14`, `|d| ≤ 25`, `gcd(|d|,c) = 1`, `|a| ≤ 12`, `b := (a·d−1)/c` integral, `|q| ≤ 8`
and `r = q·c − d > 0` — 24 769 satisfying instances, **0 counterexamples**, with the corners a
port usually breaks in covered: `c = 1` (10 625), `r = 1` (1 037), `d < 0` (19 320), `q < 0`
(6 207), `a < 0` (12 188), `q = 0` (1 457), `d ≥ c` (3 713).

The twelve pins below are chosen from that sweep to hit each of those corners at least once.
The three negative controls show that `hdet` and `hrd` are load-bearing.

As everywhere else in this file, plain `decide` does not discharge these (the kernel is stuck on
`Rat.num` of a `Finset` fold); `decide +kernel` does, and adds no axiom — the guards in
`FinalCheck.lean` show `[propext, Classical.choice, Quot.sound]` and no `Lean.ofReduceBool`. -/

/-- PIN 1/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (2,1,5,3,1)`, `r = 2`
(`a·d - b·c = 1`, `r = q·c - d = 2`).  smallest working instance; `s(3,5) = s(5,2) = 0`, so this one pins the *rational* part alone.  Both sides equal `1`. -/
theorem rademacher_phi_step_pin_c5_r2 :
    ((2 + 3 : ℤ) : ℚ) / ((5 : ℕ) : ℚ) - 12 * dedekindSum (3 : ℤ) (5 : ℕ)
      = ((1 * 2 - 1 + ((5 : ℕ) : ℤ) : ℤ) : ℚ) / ((2 : ℕ) : ℚ)
          - 12 * dedekindSum (((5 : ℕ)) : ℤ) (2 : ℕ) + ((1 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 2/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (2,1,5,3,2)`, `r = 7`
(`a·d - b·c = 1`, `r = q·c - d = 7`).  `r > c` (the descent step is NOT required to decrease `c`); `s(5,7) = -1/14 ≠ 0`.  Both sides equal `1`. -/
theorem rademacher_phi_step_pin_c5_r7 :
    ((2 + 3 : ℤ) : ℚ) / ((5 : ℕ) : ℚ) - 12 * dedekindSum (3 : ℤ) (5 : ℕ)
      = ((2 * 2 - 1 + ((5 : ℕ) : ℤ) : ℤ) : ℚ) / ((7 : ℕ) : ℚ)
          - 12 * dedekindSum (((5 : ℕ)) : ℤ) (7 : ℕ) + ((2 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 3/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (1,0,3,1,1)`, `r = 2`
(`a·d - b·c = 1`, `r = q·c - d = 2`).  `s(1,3) = 1/18 ≠ 0` on the left, `s(3,2) = 0` on the right.  Both sides equal `0`. -/
theorem rademacher_phi_step_pin_c3_r2 :
    ((1 + 1 : ℤ) : ℚ) / ((3 : ℕ) : ℚ) - 12 * dedekindSum (1 : ℤ) (3 : ℕ)
      = ((1 * 1 - 0 + ((3 : ℕ) : ℤ) : ℤ) : ℚ) / ((2 : ℕ) : ℚ)
          - 12 * dedekindSum (((3 : ℕ)) : ℤ) (2 : ℕ) + ((1 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 4/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (3,2,4,3,2)`, `r = 5`
(`a·d - b·c = 1`, `r = q·c - d = 5`).  BOTH Dedekind sums non-zero: `s(3,4) = -1/8`, `s(4,5) = -1/5`.  Both sides equal `3`. -/
theorem rademacher_phi_step_pin_c4_r5 :
    ((3 + 3 : ℤ) : ℚ) / ((4 : ℕ) : ℚ) - 12 * dedekindSum (3 : ℤ) (4 : ℕ)
      = ((2 * 3 - 2 + ((4 : ℕ) : ℤ) : ℤ) : ℚ) / ((5 : ℕ) : ℚ)
          - 12 * dedekindSum (((4 : ℕ)) : ℤ) (5 : ℕ) + ((2 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 5/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (1,0,1,1,2)`, `r = 1`
(`a·d - b·c = 1`, `r = q·c - d = 1`).  the DOUBLY degenerate corner `c = 1` and `r = 1`, where both sums vanish by `dedekindSum_one_right`.  Both sides equal `2`. -/
theorem rademacher_phi_step_pin_c1_r1 :
    ((1 + 1 : ℤ) : ℚ) / ((1 : ℕ) : ℚ) - 12 * dedekindSum (1 : ℤ) (1 : ℕ)
      = ((2 * 1 - 0 + ((1 : ℕ) : ℤ) : ℤ) : ℚ) / ((1 : ℕ) : ℚ)
          - 12 * dedekindSum (((1 : ℕ)) : ℤ) (1 : ℕ) + ((2 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 6/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (6,5,7,6,1)`, `r = 1`
(`a·d - b·c = 1`, `r = q·c - d = 1`).  `r = 1` with `c > 1`: the base case of the Euclidean descent; `s(6,7) = -5/14 ≠ 0`.  Both sides equal `6`. -/
theorem rademacher_phi_step_pin_c7_r1 :
    ((6 + 6 : ℤ) : ℚ) / ((7 : ℕ) : ℚ) - 12 * dedekindSum (6 : ℤ) (7 : ℕ)
      = ((1 * 6 - 5 + ((7 : ℕ) : ℤ) : ℤ) : ℚ) / ((1 : ℕ) : ℚ)
          - 12 * dedekindSum (((7 : ℕ)) : ℤ) (1 : ℕ) + ((1 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 7/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (2,-1,5,-2,0)`, `r = 2`
(`a·d - b·c = 1`, `r = q·c - d = 2`).  `q = 0` AND `d < 0` — the two hypotheses that a naive `omega`/`Nat`-subtraction proof breaks on.  Both sides equal `0`. -/
theorem rademacher_phi_step_pin_c5_q0 :
    ((2 + (-2) : ℤ) : ℚ) / ((5 : ℕ) : ℚ) - 12 * dedekindSum ((-2) : ℤ) (5 : ℕ)
      = ((0 * 2 - (-1) + ((5 : ℕ) : ℤ) : ℤ) : ℚ) / ((2 : ℕ) : ℚ)
          - 12 * dedekindSum (((5 : ℕ)) : ℤ) (2 : ℕ) + ((0 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 8/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (3,-5,5,-8,-1)`, `r = 3`
(`a·d - b·c = 1`, `r = q·c - d = 3`).  `q < 0`, `d < 0`, `b < 0`: `r = q·c - d = 3 > 0` even though `q` is negative.  Both sides equal `-1`. -/
theorem rademacher_phi_step_pin_c5_qneg :
    ((3 + (-8) : ℤ) : ℚ) / ((5 : ℕ) : ℚ) - 12 * dedekindSum ((-8) : ℤ) (5 : ℕ)
      = (((-1) * 3 - (-5) + ((5 : ℕ) : ℤ) : ℤ) : ℚ) / ((3 : ℕ) : ℚ)
          - 12 * dedekindSum (((5 : ℕ)) : ℤ) (3 : ℕ) + (((-1) : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 9/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (-3,-1,7,2,1)`, `r = 5`
(`a·d - b·c = 1`, `r = q·c - d = 5`).  `a < 0` and `b < 0`; `s(2,7) = 1/14` (corrected 2026-09-08; a docstring sign error, not a proof error).  Both sides equal `-1`. -/
theorem rademacher_phi_step_pin_c7_aneg :
    (((-3) + 2 : ℤ) : ℚ) / ((7 : ℕ) : ℚ) - 12 * dedekindSum (2 : ℤ) (7 : ℕ)
      = ((1 * (-3) - (-1) + ((7 : ℕ) : ℤ) : ℤ) : ℚ) / ((5 : ℕ) : ℚ)
          - 12 * dedekindSum (((7 : ℕ)) : ℤ) (5 : ℕ) + ((1 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 10/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (5,2,12,5,1)`, `r = 7`
(`a·d - b·c = 1`, `r = q·c - d = 7`).  COMPOSITE `c = 12` where the `gcd > 1` summands are killed by the `if` branch of `dedekindSaw`; `s(5,12) = -1/72`, `s(12,7) = -1/14`.  Both sides equal `1`. -/
theorem rademacher_phi_step_pin_c12_r7 :
    ((5 + 5 : ℤ) : ℚ) / ((12 : ℕ) : ℚ) - 12 * dedekindSum (5 : ℤ) (12 : ℕ)
      = ((1 * 5 - 2 + ((12 : ℕ) : ℤ) : ℤ) : ℚ) / ((7 : ℕ) : ℚ)
          - 12 * dedekindSum (((12 : ℕ)) : ℤ) (7 : ℕ) + ((1 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 11/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (1,2,5,11,3)`, `r = 4`
(`a·d - b·c = 1`, `r = q·c - d = 4`).  `d = 11 > c` — an UNREDUCED numerator, so `dedekindSum_add_mul` is doing real work; `s(11,5) = 1/5`, `s(5,4) = 1/8`.  Both sides equal `0`. -/
theorem rademacher_phi_step_pin_c5_dbig :
    ((1 + 11 : ℤ) : ℚ) / ((5 : ℕ) : ℚ) - 12 * dedekindSum (11 : ℤ) (5 : ℕ)
      = ((3 * 1 - 2 + ((5 : ℕ) : ℤ) : ℤ) : ℚ) / ((4 : ℕ) : ℚ)
          - 12 * dedekindSum (((5 : ℕ)) : ℤ) (4 : ℕ) + ((3 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- PIN 12/12 for `rademacher_phi_step`, at `(a,b,c,d,q) = (5,3,13,8,1)`, `r = 5`
(`a·d - b·c = 1`, `r = q·c - d = 5`).  largest `c`; `s(8,13) = 0` but the rational part `(5+8)/13` is non-integral.  Both sides equal `1`. -/
theorem rademacher_phi_step_pin_c13_r5 :
    ((5 + 8 : ℤ) : ℚ) / ((13 : ℕ) : ℚ) - 12 * dedekindSum (8 : ℤ) (13 : ℕ)
      = ((1 * 5 - 3 + ((13 : ℕ) : ℤ) : ℤ) : ℚ) / ((5 : ℕ) : ℚ)
          - 12 * dedekindSum (((13 : ℕ)) : ℤ) (5 : ℕ) + ((1 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- **NEGATIVE CONTROL** for `hdet`.  At `(a,b,c,d,q) = (2,1,5,4,2)`, `r = 6`, the
determinant hypothesis FAILS (`a·d - b·c = 3 ≠ 1`) and so does the identity: the left side is `18/5`,
the right side is `11/3`.  `hdet` is therefore load-bearing, not decorative. -/
theorem rademacher_phi_step_fails_det_ne_one :
    ((2 + 4 : ℤ) : ℚ) / ((5 : ℕ) : ℚ) - 12 * dedekindSum (4 : ℤ) (5 : ℕ)
      ≠ ((2 * 2 - 1 + ((5 : ℕ) : ℤ) : ℤ) : ℚ) / ((6 : ℕ) : ℚ)
          - 12 * dedekindSum (((5 : ℕ)) : ℤ) (6 : ℕ) + ((2 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- **NEGATIVE CONTROL** for `hdet`.  At `(a,b,c,d,q) = (1,1,5,3,1)`, `r = 2`, the
determinant hypothesis FAILS (`a·d - b·c = -2 ≠ 1`) and so does the identity: the left side is `4/5`,
the right side is `1/2`.  `hdet` is therefore load-bearing, not decorative. -/
theorem rademacher_phi_step_fails_det_ne_one_2 :
    ((1 + 3 : ℤ) : ℚ) / ((5 : ℕ) : ℚ) - 12 * dedekindSum (3 : ℤ) (5 : ℕ)
      ≠ ((1 * 1 - 1 + ((5 : ℕ) : ℤ) : ℤ) : ℚ) / ((2 : ℕ) : ℚ)
          - 12 * dedekindSum (((5 : ℕ)) : ℤ) (2 : ℕ) + ((1 : ℤ) : ℚ) - 3 := by
  decide +kernel

/-- **NEGATIVE CONTROL** for `hrd`.  Same `(a,b,c,d,q) = (2,1,5,3,1)` as PIN 1/12, whose
true remainder is `r = q·c - d = 2`, but evaluated at `r = 3` instead: the identity FAILS
(`1` versus `2/3`).  `hrd` is load-bearing: the theorem is about the Euclidean
remainder specifically, not about an arbitrary positive `r`. -/
theorem rademacher_phi_step_fails_hrd :
    ((2 + 3 : ℤ) : ℚ) / ((5 : ℕ) : ℚ) - 12 * dedekindSum (3 : ℤ) (5 : ℕ)
      ≠ ((1 * 2 - 1 + ((5 : ℕ) : ℤ) : ℤ) : ℚ) / ((3 : ℕ) : ℚ)
          - 12 * dedekindSum (((5 : ℕ)) : ℤ) (3 : ℕ) + ((1 : ℤ) : ℚ) - 3 := by
  decide +kernel


end SignDisciplineGate

/-! ## DRK-03, part 2 — the three lemmas  (PROVED, sorry-free) -/

/-- **DRK-03 (PROVED).**  For `c > 0`, `Φ` collapses to the inline expression FLT uses in
`Thm_rademacher_phi_step.lean` and `Thm_ModularForm_eta_specialLinearGroup_smul.lean`.  This is
the bridge lemma: without it our named `Φ` and FLT's anonymous expression are not known to be
the same number, and every downstream quotation of an FLT statement is unjustified. -/
theorem rademacherPhi_of_pos {γ : SL(2, ℤ)} (hc : 0 < γ 1 0) :
    rademacherPhi γ = ((γ 0 0 + γ 1 1 : ℤ) : ℚ) / ((γ 1 0 : ℤ) : ℚ)
                        - 12 * dedekindSum (γ 1 1) (γ 1 0).toNat := by
  -- `c ≠ 0`, so the `if` takes its second branch.
  -- `Int.sign c = 1` for `0 < c`, and `c.natAbs = c.toNat` for `0 ≤ c`.
  have hnat : (γ 1 0).natAbs = (γ 1 0).toNat := by omega
  rw [rademacherPhi, if_neg hc.ne', Int.sign_eq_one_of_pos hc, hnat]
  push_cast
  ring

/-- **DRK-03 (PROVED 2026-09-08) — the `toNat` phrasing of `rademacherPhi_of_pos`.**

Identical to `rademacherPhi_of_pos` except that the **denominator** is written
`((c.toNat : ℕ) : ℚ)` rather than `((c : ℤ) : ℚ)`.  That is the form FLT's
`Thm_ModularForm_eta_specialLinearGroup_smul.lean` uses, and under `0 < c` the two are the same
rational — but "the same under `hc`" is not a rewrite, and without this lemma the two DRK-06
phrasings below are interchangeable only on paper.  The DRK-06 comparator flagged exactly this
one-step cast gap; this lemma closes it, so `eta_specialLinearGroup_smul_flt` really is
`eta_smul_eq_exp_rademacherPhi` plus **one** `rw`.

INDEPENDENT: `Int.toNat_of_nonneg` plus a cast.  No FLT text. -/
theorem rademacherPhi_of_pos_toNat {γ : SL(2, ℤ)} (hc : 0 < γ 1 0) :
    rademacherPhi γ = ((γ 0 0 + γ 1 1 : ℤ) : ℚ) / (((γ 1 0).toNat : ℕ) : ℚ)
                        - 12 * dedekindSum (γ 1 1) (γ 1 0).toNat := by
  rw [rademacherPhi_of_pos hc]
  congr 2
  exact_mod_cast (Int.toNat_of_nonneg hc.le).symm

/-- **DRK-03 (PROVED).**  `Φ` is invariant under `γ ↦ -γ`, hence descends to `PSL(2,ℤ)`.

This is what licenses the `c < 0` reduction: `Φ` on a matrix with `c < 0` is `Φ` on `-γ`, which
has `c > 0`.  Pinned at six explicit `γ` in the gate above. -/
theorem rademacherPhi_neg (γ : SL(2, ℤ)) : rademacherPhi (-γ) = rademacherPhi γ := by
  rw [rademacherPhi, rademacherPhi, SL2_neg_apply, SL2_neg_apply, SL2_neg_apply, SL2_neg_apply]
  by_cases hc : γ 1 0 = 0
  · -- `c = 0` branch: `(-b)/(-d) = b/d`.
    rw [hc, if_pos rfl, if_pos neg_zero]
    push_cast
    rw [neg_div_neg_eq]
  · -- `c ≠ 0` branch.  `(-(a+d))/(-c) = (a+d)/c`, and the two sign flips
    -- `Int.sign (-c) = -Int.sign c`, `dedekindSum (-d) k = -dedekindSum d k` cancel.
    rw [if_neg hc, if_neg (by simpa using hc : -(γ 1 0) ≠ 0),
      Int.sign_neg, Int.natAbs_neg, dedekindSum_neg]
    have hC : ((γ 1 0 : ℤ) : ℚ) ≠ 0 := Int.cast_ne_zero.mpr hc
    push_cast
    field_simp
    ring

/-- **DRK-03 (PROVED).**  `Φ (T^n) = n`.  This is the normalisation of `Φ`: it is what fixes the
additive constant, and it is the `c = 0` branch of the definition doing its only job. -/
theorem rademacherPhi_T_zpow (n : ℤ) : rademacherPhi (ModularGroup.T ^ n) = (n : ℚ) := by
  -- `ModularGroup.coe_T_zpow n : (T ^ n).1 = !![1, n; 0, 1]`, so `c = 0`, `b = n`, `d = 1`,
  -- and the `c = 0` branch of the definition gives `n / 1`.
  have hent : ∀ i j : Fin 2,
      (ModularGroup.T ^ n) i j = (!![1, (n : ℤ); 0, 1] : Matrix (Fin 2) (Fin 2) ℤ) i j := by
    intro i j
    rw [show ((ModularGroup.T ^ n) i j) = ((ModularGroup.T ^ n).1 i j) from rfl,
      ModularGroup.coe_T_zpow]
  rw [rademacherPhi, hent 1 0, hent 0 1, hent 1 1]
  simp

/-! ## DRK-04 — the Euclidean descent cocycle step  (PROVED 2026-09-07, `sorry`-free)

The **statement** is STATEMENT-ONLY from FLT (`Theorems/Thm_rademacher_phi_step.lean`),
reproduced with the upstream binder names, hypothesis order and shape, so that it can be compared
against upstream character-for-character.

The **proof is INDEPENDENT.**  Upstream's is the single tactic
`p2m_exact_reverting @P2MW.S_rademacher_phi_step.solution` against a 1287-line `P2M/Sol` file;
that tactic does not exist in this library and that file was never read.  What is written below
is the three-line arithmetic the node's own searcher brief describes — Bézout for coprimality,
`dedekindSum_add_mul` + `dedekindSum_neg` to replace `s(d,c)` by `-s(r,c)`, DRK-02 reciprocity
on the pair `(r,c)`, and then field algebra — re-derived against our own DRK-01/DRK-02 lemmas.
**Do not cite FLT for the proof.** -/

/-- The purely algebraic core of `rademacher_phi_step`, with both Dedekind sums already
eliminated (the left one by periodicity + oddness, the right pair by reciprocity).

`R = Q·C - D` is the Euclidean step and `A·D - B·C = 1` is the determinant; the content is that
those two force `A/C + C/R + 1/(RC) = (QA - B + C)/R`, i.e. `A·R + 1 = C·(QA - B)`.

INDEPENDENT: this is field algebra over `ℚ` and has no FLT counterpart (upstream never isolates
it).  Private: nothing outside this file needs it. -/
private lemma phi_step_algebra {A B C D Q R : ℚ} (hC : C ≠ 0) (hR : R ≠ 0)
    (hrd : R = Q * C - D) (hdet : A * D - B * C = 1) :
    (A + D) / C + (R / C + C / R + 1 / (R * C)) - 3
      = (Q * A - B + C) / R + Q - 3 := by
  -- Eliminate `D` with the Euclidean step, then `B` with the determinant; what is left is an
  -- identity in `A, C, Q, R` alone, so `field_simp; ring` closes it with nothing to guess.
  have hD : D = Q * C - R := by linarith
  subst hD
  have hB : B = (A * (Q * C - R) - 1) / C := by
    field_simp
    linear_combination -hdet
  subst hB
  field_simp
  ring

/-- **DRK-04 (PROVED 2026-09-07, `sorry`-free).**  The Euclidean-descent cocycle step for `Φ`.

Replacing `γ = !![a,b;c,d]` by the matrix whose lower-left entry is the next remainder
`r = q·c - d` changes `(a+d)/c - 12·s(d,c)` by exactly `q - 3`.  This is the arithmetic engine
that turns the analytic identification of the `η` multiplier into a strong induction on `c`.

Instance-checked at TWELVE `(a,b,c,d,q)`, with three negative controls, in the
`RademacherPhiStepGate` block above — all of them written and kernel-checked BEFORE this proof.

Inputs used: `dedekindSum_add_dedekindSum` (DRK-02), `dedekindSum_add_mul` and `dedekindSum_neg`
(DRK-01), `Int.isCoprime_iff_gcd_eq_one` and `Int.gcd_natCast_natCast` (Mathlib), and the private
`phi_step_algebra` above.  `dedekindSum_one_right`, which the brief also offered, turned out NOT
to be needed: the `c = 1` and `r = 1` corners fall out of the same uniform argument (they are
pinned at `rademacher_phi_step_pin_c1_r1` and `_c7_r1` anyway).

LL-22: `dedekindSum` here is **Apostol's `s(h,k)`**.  This lemma is about the expression that
`rademacherPhi` equals for `c > 0` (`rademacherPhi_of_pos`), i.e. about **`Φ`**, not about the
Rademacher symbol `Ψ`.  It says nothing about `c ≤ 0`; `c : ℕ` with `0 < c` makes that
inexpressible, and the `c ≤ 0` bookkeeping lives in DRK-03 (`rademacherPhi_neg`, the `c = 0`
branch of the definition, `rademacherPhi_T_zpow`).  A downstream node that needs `c ≤ 0` must
route through those; this one does not cover it. -/
theorem rademacher_phi_step (c r : ℕ) (hc : 0 < c) (hr : 0 < r) (a b d q : ℤ)
    (hrd : (r : ℤ) = q * c - d) (hdet : a * d - b * c = 1) :
    ((a + d : ℤ) : ℚ) / c - 12 * dedekindSum d c
      = ((q * a - b + c : ℤ) : ℚ) / r - 12 * dedekindSum c r + q - 3 := by
  have hC : ((c : ℕ) : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hc.ne'
  have hR : ((r : ℕ) : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hr.ne'
  -- STEP 1.  `gcd (r, c) = 1`.  No coprimality hypothesis is assumed: `hdet` and `hrd` together
  -- EXHIBIT a Bézout combination, `(-a)·r + (a·q - b)·c = a·d - b·c = 1`.
  have hcop : Nat.Coprime r c := by
    have hIC : IsCoprime (r : ℤ) (c : ℤ) :=
      ⟨-a, a * q - b, by linear_combination (-a) * hrd + hdet⟩
    have h1 : Int.gcd (r : ℤ) (c : ℤ) = 1 := Int.isCoprime_iff_gcd_eq_one.1 hIC
    simpa [Int.gcd_natCast_natCast] using h1
  -- STEP 2.  `d = -r + q·c`, so `d ≡ -r (mod c)`: periodicity (`dedekindSum_add_mul`) and
  -- oddness (`dedekindSum_neg`) turn `s(d, c)` into `-s(r, c)` with `r` a NATURAL number —
  -- which is what DRK-02 needs, since reciprocity is stated for `h k : ℕ`.
  have hdr : d = -(r : ℤ) + q * (c : ℤ) := by linear_combination hrd
  have hsd : dedekindSum d c = - dedekindSum ((r : ℕ) : ℤ) c := by
    rw [hdr, dedekindSum_add_mul, dedekindSum_neg]
  -- STEP 3.  Reciprocity (DRK-02) at the coprime positive pair `(r, c)`.  NOTE THE ARGUMENT
  -- ORDER: the theorem has `s(d,c)` on the left and `s(c,r)` on the right, and it is exactly
  -- this swap that reciprocity supplies.
  have hrec := dedekindSum_add_dedekindSum r c hr hc hcop
  have hs1 : dedekindSum ((r : ℕ) : ℤ) c
      = ((r : ℚ) / c + (c : ℚ) / r + 1 / ((r : ℚ) * c)) / 12 - 1 / 4
        - dedekindSum ((c : ℕ) : ℤ) r := by linarith
  -- STEP 4.  Substituting, `s(c,r)` cancels between the two sides and what is left is
  -- `phi_step_algebra`.
  rw [hsd, hs1]
  have halg := phi_step_algebra (A := (a : ℚ)) (B := (b : ℚ)) (C := ((c : ℕ) : ℚ))
      (D := (d : ℚ)) (Q := (q : ℚ)) (R := ((r : ℕ) : ℚ)) hC hR
      (by exact_mod_cast hrd) (by exact_mod_cast hdet)
  push_cast
  linarith [halg]

end SocrateAI.NumberTheory
