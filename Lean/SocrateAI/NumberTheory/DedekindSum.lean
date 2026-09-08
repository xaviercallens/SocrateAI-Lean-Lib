/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license,
EXCEPT `dedekindSaw`, `dedekindSum` and the nineteen supporting lemmas below (marked PORT
in their own docstrings), which are (c) 2026 Anthropic, PBC, ported from the Apache-2.0
repository `anthropics/fermats-last-theorem` and released here under the Apache License,
Version 2.0 (see `licenses/APACHE-2.0-fermats-last-theorem.txt` and
`licenses/NOTICE-fermats-last-theorem.txt`, reproduced per License section 4(d)). See
`ATTRIBUTION.md` for the file-by-file declaration.

# Dedekind sums  (DAG: DRK-00, DRK-01, DRK-02)

The sawtooth `((x))` and the Dedekind sum `s(h,k)`, with the supporting lemma block, and the
**statement** of Dedekind reciprocity.

## Provenance — read this before citing anything in this file

`dedekindSaw`, `dedekindSum` and the nineteen supporting lemmas of `DRK-01` are a **PORT**, not
an independent re-derivation.  They are taken from

    anthropics/fermats-last-theorem, Definitions/Def_NumberTheory_DedekindSum.lean
    (Apache-2.0; fetched 2026-09-07, HTTP 200, 4731 bytes)

and they typecheck **verbatim** against our pinned Mathlib (`v4.32.2` /
`905b95818eb32af7874a58b427f50c1711a5e96c`); the upstream file is plain Lean over Mathlib
primitives and needs none of FLT's `P2M` infrastructure.  The only change is **ordering**: both
definitions are hoisted above the lemma block so that the `DRK-00` sign-discipline gate can sit
between them.  See `ATTRIBUTION.md` at the repository root.

`dedekindSum_add_dedekindSum` (`DRK-02`) is a **split**, and the two halves have different
provenance.  Read both sentences.

* Its **statement** is transcribed from FLT
  (`Theorems/Thm_dedekindSum_add_dedekindSum.lean`, 391 bytes), binder names and hypothesis order
  included, so that a comparator can check it character-for-character.  That half is a port.
* Its **proof is INDEPENDENT**, not a port and not an adaptation.  Upstream's proof is the single
  tactic `p2m_exact_reverting @P2MW.S_dedekindSum_add_dedekindSum.solution`; that tactic does not
  exist in this library, the 1286-line `P2M/Sol` file behind it was never read, and nothing in the
  proof below descends from it.  The argument used here is the classical Rademacher–Grosswald
  **lattice-point double count** — the route this node's own searcher brief recommended over
  Apostol's cotangent proof, because it avoids cotangent sums entirely — re-derived against
  Mathlib primitives (`Finset.sum_comm`, `Nat.div_add_mod`, `Nat.ModEq.cancel_left_of_coprime`).
  It is *not* Apostol's Theorem 3.11 proof either.  Do not cite FLT for it.

The shape of that argument, for a reader checking it rather than running it:

1. `dedekindSum_eq_modSum` — for coprime `h, k`, `s(h,k) = (∑_{r=1}^{k-1} r·(hr mod k))/k² − (k−1)/4`.
   This uses that `r ↦ hr mod k` **permutes** `Ico 1 k` (`sum_mod_perm`), which is where
   coprimality first enters and is exactly what fails at `(4,12)`.
2. `double_count` — `∑_{r=1}^{k-1} r·⌊hr/k⌋` counted over the lattice rectangle
   `Ico 1 k × Ico 1 h` cut by the line `sk = hr`, summed in the other order.  The two fibre
   identifications are `fibre_left` and `fibre_right`; `fibre_left` again needs `k ∤ hr`.
3. Squaring `h·⌊ks/h⌋ + (ks mod h) = ks` and summing turns `∑ ⌊ks/h⌋²` into `s(k,h)`, and the
   `s(k,h)` contributed by step 2 **cancels** the one already in the goal.  What is left is a
   rational-function identity in `h` and `k`, closed by `field_simp; ring`.

## LL-22 — which function is this?

`dedekindSum` is Apostol's `s(h,k)`.  The Rademacher symbol `Ψ` and Apostol's `Φ` are **not**
this function and **not** each other; both live in `SocrateAI/NumberTheory/RademacherPhi.lean`,
under two different names, with pins that fail the build if they are ever conflated.

## LL-17 / sign discipline (`DRK-00`)

Mathlib has no `norm_num` extension for `Int.floor` (`Mathlib/Tactic/NormNum/Floor.lean` does
not exist at our rev: `ls Mathlib/Tactic/NormNum/ | grep -i floor` → nothing), and plain
`decide` does **not** discharge these goals — the kernel gets stuck on `Rat.num` of a `Finset`
fold (error text recorded in the run log).  `decide +kernel` does discharge them, in ~2.7 s for
the whole block, with axiom footprint `[propext, Classical.choice, Quot.sound]`.  **This is a
deviation from the brief, which asked for `by decide`.**

## LL-1 — the brief's pin VALUES were wrong; the ones below are recomputed

The brief asked for pins `dedekindSum 1 5 = 2/5`, `dedekindSum 1 7 = 5/7`,
`dedekindSum 3 7 = -1/7`, `dedekindSum (-1) 5 = -(2/5)`.  All four are **false** for the
definition above.  Independently recomputed (Python `fractions.Fraction`, and again by the
Lean kernel below): `s(1,5) = 1/5`, `s(1,7) = 5/14`, `s(3,7) = -1/14`, `s(-1,5) = -1/5`.  The
first agrees with the classical `s(1,k) = (k-1)(k-2)/(12k)`.  The brief's other three pins
(`s(2,5) = 0`, `s(1,12) = 55/72`, `s(5,12) = -1/72`) are correct and are kept verbatim.  This
is exactly the failure the gate exists to catch.

The gate then caught a **fifth** wrong value, this one invented while writing the file and not
in the brief: `s(4,12) = 0` was written, the kernel refused it, and the correct value is
`s(4,12) = 1/18`.  Recording it here rather than quietly fixing it is the point of LL-1.
-/
import Mathlib.Data.Rat.Floor
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.LocallyFinite
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Nat.ModEq
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.LinearCombination

set_option autoImplicit false

namespace SocrateAI.NumberTheory

/-! ## DRK-01, part 1 — the two definitions (PORTED verbatim from FLT) -/

/-- The sawtooth function `((x))`: `Int.fract x - 1/2` off the integers, `0` on them.

PORTED verbatim from `anthropics/fermats-last-theorem`,
`Definitions/Def_NumberTheory_DedekindSum.lean` (Apache-2.0). -/
def dedekindSaw (x : ℚ) : ℚ :=
  if Int.fract x = 0 then 0 else Int.fract x - 1 / 2

/-- Apostol's Dedekind sum `s(h,k) = ∑_{r=0}^{k-1} ((r/k)) ((hr/k))`.

PORTED verbatim from `anthropics/fermats-last-theorem`,
`Definitions/Def_NumberTheory_DedekindSum.lean` (Apache-2.0).

LL-22: this is `s(h,k)`.  It is **not** Apostol's `Φ` and **not** Rademacher's `Ψ`. -/
def dedekindSum (h : ℤ) (k : ℕ) : ℚ :=
  ∑ r ∈ Finset.range k, dedekindSaw ((r : ℚ) / k) * dedekindSaw ((h : ℚ) * r / k)

/-! ## DRK-00 — SIGN DISCIPLINE GATE (LL-22)

No general sign, floor or reciprocity proof in this file may land before this section.  Every
pin below is a **kernel evaluation of the two definitions above**, and of nothing else: not one
lemma of `DRK-01` has been stated yet, so no pin can be contaminated by the general theory it is
meant to guard.  Each value was also computed independently in Python before it was written
here (see the file header, LL-1).

The `Φ`/`Ψ` half of the gate lives in `RademacherPhi.lean`, immediately after those two
definitions, for the same reason. -/

section SignDisciplineGate

-- positive `h`, prime `k`
example : dedekindSum 1 5 = 1 / 5 := by decide +kernel
example : dedekindSum 2 5 = 0 := by decide +kernel
example : dedekindSum 1 7 = 5 / 14 := by decide +kernel
example : dedekindSum 3 7 = -1 / 14 := by decide +kernel
example : dedekindSum 1 13 = 11 / 13 := by decide +kernel
example : dedekindSum 4 13 = -1 / 13 := by decide +kernel

-- composite `k`, where the `gcd(h,k) > 1` summands are the ones a wrong `Int.fract` would break
example : dedekindSum 1 12 = 55 / 72 := by decide +kernel
example : dedekindSum 5 12 = -1 / 72 := by decide +kernel
example : dedekindSum 4 12 = 1 / 18 := by decide +kernel

-- NEGATIVE `h`: the odd-in-`h` sign, pinned before `dedekindSum_neg` is stated
example : dedekindSum (-1) 5 = -(1 / 5) := by decide +kernel
example : dedekindSum (-3) 7 = 1 / 14 := by decide +kernel
example : dedekindSum (-5) 12 = 1 / 72 := by decide +kernel

-- degenerate second argument
example : dedekindSum 1 0 = 0 := by decide +kernel
example : dedekindSum 1 1 = 0 := by decide +kernel
example : dedekindSum 0 5 = 0 := by decide +kernel

-- RECIPROCITY, instance-checked at three coprime pairs BEFORE the general theorem (DRK-02)
example : dedekindSum 5 12 + dedekindSum 12 5
    = ((5 : ℚ) / 12 + (12 : ℚ) / 5 + 1 / ((5 : ℚ) * 12)) / 12 - 1 / 4 := by decide +kernel
example : dedekindSum 3 7 + dedekindSum 7 3
    = ((3 : ℚ) / 7 + (7 : ℚ) / 3 + 1 / ((3 : ℚ) * 7)) / 12 - 1 / 4 := by decide +kernel
example : dedekindSum 1 5 + dedekindSum 5 1
    = ((1 : ℚ) / 5 + (5 : ℚ) / 1 + 1 / ((1 : ℚ) * 5)) / 12 - 1 / 4 := by decide +kernel

-- NEGATIVE CONTROL: reciprocity is FALSE without coprimality, so the hypothesis of DRK-02 is
-- load-bearing rather than decorative.  `gcd(4,12) = 4`.
example : dedekindSum 4 12 + dedekindSum 12 4
    ≠ ((4 : ℚ) / 12 + (12 : ℚ) / 4 + 1 / ((4 : ℚ) * 12)) / 12 - 1 / 4 := by decide +kernel

/-! ### The gate's pins as NAMED, AXIOM-GUARDED lemmas

The `example`s above already gate the build (a wrong value is a compile error), but an `example`
has no name and so cannot be given a `#print axioms` guard.  Six of the pins are therefore
restated as named theorems, one per regime — positive `h` at prime `k`, negative `h`, composite
`k`, a degenerate `k`, a reciprocity instance, and the non-coprime negative control — so that
`FinalCheck.lean` can pin their axiom footprint.  `decide +kernel` adds NO axiom; had these been
done with `native_decide`, `Lean.ofReduceBool` would appear in the footprint and the FinalCheck
guards would fail.  Each value was computed independently in Python (`fractions.Fraction`)
before it was written here, and re-computed from scratch on 2026-09-07 with 0 mismatches. -/

/-- PIN 1/6 (positive `h`, prime `k`).  Kernel-evaluation pins carry no extra axioms.
Agrees with the classical `s(1,k) = (k-1)(k-2)/(12k)` at `k = 5`. -/
theorem dedekindSum_five_pin : dedekindSum 1 5 = 1 / 5 := by decide +kernel

/-- PIN 2/6 (NEGATIVE `h`).  The odd-in-`h` sign, pinned before `dedekindSum_neg` is stated, so
that a sign flip in the general lemma cannot be justified by the general lemma. -/
theorem dedekindSum_neg_three_seven_pin : dedekindSum (-3) 7 = 1 / 14 := by decide +kernel

/-- PIN 3/6 (composite `k`).  `gcd(4,12) = 4`, so four of the twelve summands have
`Int.fract (4r/12) = 0` and are killed by the `if` branch of `dedekindSaw`; a definition that
dropped that branch would give a different number here. -/
theorem dedekindSum_four_twelve_pin : dedekindSum 4 12 = 1 / 18 := by decide +kernel

/-- PIN 4/6 (degenerate `k`).  `k = 1`: the sum has one term, at `r = 0`, and `((0)) = 0`. -/
theorem dedekindSum_one_one_pin : dedekindSum 1 1 = 0 := by decide +kernel

/-- PIN 5/6 (RECIPROCITY, one coprime instance).  `DRK-02` checked at `(5,12)` before it is
stated in general. -/
theorem dedekindSum_reciprocity_five_twelve_pin :
    dedekindSum 5 12 + dedekindSum 12 5
      = ((5 : ℚ) / 12 + (12 : ℚ) / 5 + 1 / ((5 : ℚ) * 12)) / 12 - 1 / 4 := by
  decide +kernel

/-- PIN 6/6 (NEGATIVE CONTROL).  Reciprocity is FALSE at the non-coprime pair `(4,12)`
(`gcd = 4`), so `DRK-02`'s `Nat.Coprime` hypothesis is load-bearing and not decorative.  If a
future edit ever proves `DRK-02` without that hypothesis, this pin fails the build. -/
theorem dedekindSum_reciprocity_fails_four_twelve :
    dedekindSum 4 12 + dedekindSum 12 4
      ≠ ((4 : ℚ) / 12 + (12 : ℚ) / 4 + 1 / ((4 : ℚ) * 12)) / 12 - 1 / 4 := by
  decide +kernel

/-! ### DRK-02's own gate — pins placed BEFORE the reciprocity proof, not after it

The six pins above guard the *definition*.  The block below guards the *statement of `DRK-02`*
and the two intermediate objects its proof manipulates (the floor sum `∑ r⌊hr/k⌋` and the
mod sum `∑ r·(hr mod k)`).  Every value was computed independently in Python
(`fractions.Fraction`, from the definitions, not from the reciprocity formula) **before** any
line of the proof below was written, and is re-derived here by kernel evaluation.  A pin that
disagreed would mean the statement is wrong, and the proof would have to stop rather than be
bent to fit.  Twenty-one such checks were run; zero disagreed.

Nothing in this block is proved *by* `dedekindSum_add_dedekindSum` — each is `decide +kernel`
on the definition — so they are a genuine independent check on the general theorem and not a
restatement of it.  Both sides of each reciprocity pin were also computed by two different
routes in Python (sum-of-sawtooths versus the closed form) and agreed. -/

section ReciprocityGate

/-- DRK-02 PIN 1/7 — two distinct odd primes, both Dedekind sums non-zero and of opposite sign.
`s(7,11) = -3/22`, `s(11,7) = 1/14`, sum `-5/77`. -/
theorem dedekindSum_reciprocity_seven_eleven_pin :
    dedekindSum 7 11 + dedekindSum 11 7
      = ((7 : ℚ) / 11 + (11 : ℚ) / 7 + 1 / ((7 : ℚ) * 11)) / 12 - 1 / 4 := by
  decide +kernel

/-- DRK-02 PIN 2/7 — coprime **composites** (`9 = 3²`, `25 = 5²`), so neither argument is prime
and the `gcd(h,r) > 1` summands are exercised on both sides.  `s(9,25) = 4/25`,
`s(25,9) = -4/27`. -/
theorem dedekindSum_reciprocity_nine_twentyfive_pin :
    dedekindSum 9 25 + dedekindSum 25 9
      = ((9 : ℚ) / 25 + (25 : ℚ) / 9 + 1 / ((9 : ℚ) * 25)) / 12 - 1 / 4 := by
  decide +kernel

/-- DRK-02 PIN 3/7 — even `h` against odd composite `k`, with `s(15,2) = 0`: the pin still holds
when one of the two summands vanishes, which is where a mis-signed empty sum would show. -/
theorem dedekindSum_reciprocity_two_fifteen_pin :
    dedekindSum 2 15 + dedekindSum 15 2
      = ((2 : ℚ) / 15 + (15 : ℚ) / 2 + 1 / ((2 : ℚ) * 15)) / 12 - 1 / 4 := by
  decide +kernel

/-- DRK-02 PIN 4/7 — `(4,9)`, coprime with both arguments composite and `h < k` even. -/
theorem dedekindSum_reciprocity_four_nine_pin :
    dedekindSum 4 9 + dedekindSum 9 4
      = ((4 : ℚ) / 9 + (9 : ℚ) / 4 + 1 / ((4 : ℚ) * 9)) / 12 - 1 / 4 := by
  decide +kernel

/-- DRK-02 PIN 5/7 — `(11,13)`, consecutive odd primes, the largest pin in the block. -/
theorem dedekindSum_reciprocity_eleven_thirteen_pin :
    dedekindSum 11 13 + dedekindSum 13 11
      = ((11 : ℚ) / 13 + (13 : ℚ) / 11 + 1 / ((11 : ℚ) * 13)) / 12 - 1 / 4 := by
  decide +kernel

/-- DRK-02 PIN 6/7 — `(3,8)`, odd against a power of two. -/
theorem dedekindSum_reciprocity_three_eight_pin :
    dedekindSum 3 8 + dedekindSum 8 3
      = ((3 : ℚ) / 8 + (8 : ℚ) / 3 + 1 / ((3 : ℚ) * 8)) / 12 - 1 / 4 := by
  decide +kernel

/-- DRK-02 PIN 7/7 — the DEGENERATE corner `h = k = 1`, where both sums are empty and the whole
identity is `0 = 3/12 - 1/4`.  This is the instance that the `0 < h`, `0 < k` hypotheses sit
next to, and the one an off-by-one in the `Ico` bookkeeping would break first. -/
theorem dedekindSum_reciprocity_one_one_pin :
    dedekindSum 1 1 + dedekindSum 1 1
      = ((1 : ℚ) / 1 + (1 : ℚ) / 1 + 1 / ((1 : ℚ) * 1)) / 12 - 1 / 4 := by
  decide +kernel

/-- DRK-02 INTERMEDIATE PIN A — the floor sum `∑_{r=1}^{k-1} r⌊hr/k⌋` at `(7,11)`.  This is the
object `double_count` below computes in two ways; if the double count were off, the general
proof would still typecheck against a *wrong* value of this sum only if this pin were absent. -/
theorem floorSum_id_seven_eleven_pin :
    ∑ r ∈ Finset.Ico 1 11, r * (7 * r / 11) = 219 := by decide +kernel

/-- DRK-02 INTERMEDIATE PIN B — `∑_{r=1}^{k-1} ⌊hr/k⌋ = (h−1)(k−1)/2` at `(7,11)`, pinned in
BOTH argument orders (`30` each way, and `(7−1)(11−1)/2 = 30`).  The symmetry of this count is
the step of the proof that turns `∑ ⌊ks/h⌋` into a closed form. -/
theorem floorSum_count_seven_eleven_pin :
    ∑ r ∈ Finset.Ico 1 11, 7 * r / 11 = 30 := by decide +kernel

/-- DRK-02 INTERMEDIATE PIN B' — the other argument order of PIN B. -/
theorem floorSum_count_eleven_seven_pin :
    ∑ s ∈ Finset.Ico 1 7, 11 * s / 7 = 30 := by decide +kernel

/-- DRK-02 INTERMEDIATE PIN C — the mod sum `∑_{r=1}^{k-1} r·(hr mod k)` at `(7,11)`, which
`dedekindSum_eq_modSum` below claims equals `k²(s(h,k) + (k−1)/4)`.  Here
`286 = 121·(-3/22 + 10/4)`. -/
theorem modSum_seven_eleven_pin :
    ∑ r ∈ Finset.Ico 1 11, r * (7 * r % 11) = 286 := by decide +kernel

/-- DRK-02 NEGATIVE CONTROL 2/3 — `gcd(6,9) = 3`.  Reciprocity is FALSE here. -/
theorem dedekindSum_reciprocity_fails_six_nine :
    dedekindSum 6 9 + dedekindSum 9 6
      ≠ ((6 : ℚ) / 9 + (9 : ℚ) / 6 + 1 / ((6 : ℚ) * 9)) / 12 - 1 / 4 := by
  decide +kernel

/-- DRK-02 NEGATIVE CONTROL 3/3 — `gcd(10,15) = 5`, a case where neither argument divides the
other, so the failure is not an artefact of the `(4,12)` divisibility. -/
theorem dedekindSum_reciprocity_fails_ten_fifteen :
    dedekindSum 10 15 + dedekindSum 15 10
      ≠ ((10 : ℚ) / 15 + (15 : ℚ) / 10 + 1 / ((10 : ℚ) * 15)) / 12 - 1 / 4 := by
  decide +kernel

/-- The individual summands of PIN 1 and PIN 2, so that a compensating pair of errors in
`s(h,k)` and `s(k,h)` cannot satisfy a reciprocity pin while both values are wrong. -/
theorem dedekindSum_seven_eleven_pin : dedekindSum 7 11 = -3 / 22 := by decide +kernel

theorem dedekindSum_eleven_seven_pin : dedekindSum 11 7 = 1 / 14 := by decide +kernel

theorem dedekindSum_nine_twentyfive_pin : dedekindSum 9 25 = 4 / 25 := by decide +kernel

theorem dedekindSum_twentyfive_nine_pin : dedekindSum 25 9 = -4 / 27 := by decide +kernel

end ReciprocityGate

end SignDisciplineGate

/-! ## DRK-01, part 2 — the supporting lemma block (PORTED verbatim from FLT)

All nineteen declarations below are byte-for-byte the upstream text.  Re-verified 2026-09-07
against a fresh fetch of the upstream file (HTTP 200, 4731 bytes, 4589 characters by
`python len(str)`, LL-17): each upstream `def`/`theorem` block extracted by regex and compared
with `==` against ours — **21 identical, 0 differing, 0 missing**.

LL-1, A COUNT IN THIS HEADER WAS WRONG AND IS RETRACTED HERE RATHER THAN QUIETLY DELETED.
The run brief says "the 17 supporting lemmas" and then enumerates nineteen names; nineteen is
the correct count, and the error is in the *number word only*.  An earlier revision of this
header added the explanation that `dedekindSaw_half` "the brief's list omits" — **that
explanation was FALSE**: the brief lists `dedekindSaw_half` seventh.  A set comparison of the
brief's nineteen names against the nineteen `^theorem` names in the fetched upstream file gives
the empty set in both directions, so nothing was dropped from the port and nothing was invented
for it.  Only the numeral "17" was wrong. -/

theorem dedekindSaw_of_fract_eq_zero {x : ℚ} (h : Int.fract x = 0) : dedekindSaw x = 0 :=
  if_pos h

theorem dedekindSaw_of_fract_ne_zero {x : ℚ} (h : Int.fract x ≠ 0) :
    dedekindSaw x = Int.fract x - 1 / 2 :=
  if_neg h

theorem dedekindSaw_intCast (n : ℤ) : dedekindSaw (n : ℚ) = 0 :=
  dedekindSaw_of_fract_eq_zero (Int.fract_intCast n)

theorem dedekindSaw_natCast (n : ℕ) : dedekindSaw (n : ℚ) = 0 := by
  rw [← Int.cast_natCast]; exact dedekindSaw_intCast (n : ℤ)

theorem dedekindSaw_zero : dedekindSaw 0 = 0 := by
  rw [← Int.cast_zero]; exact dedekindSaw_intCast 0

theorem dedekindSaw_one : dedekindSaw 1 = 0 := by
  rw [← Int.cast_one]; exact dedekindSaw_intCast 1

theorem dedekindSaw_add_intCast (x : ℚ) (n : ℤ) : dedekindSaw (x + n) = dedekindSaw x := by
  unfold dedekindSaw
  rw [Int.fract_add_intCast]

theorem dedekindSaw_intCast_add (n : ℤ) (x : ℚ) : dedekindSaw ((n : ℚ) + x) = dedekindSaw x := by
  rw [add_comm, dedekindSaw_add_intCast]

theorem dedekindSaw_add_natCast (x : ℚ) (n : ℕ) : dedekindSaw (x + n) = dedekindSaw x := by
  rw [← Int.cast_natCast]; exact dedekindSaw_add_intCast x (n : ℤ)

theorem dedekindSaw_neg (x : ℚ) : dedekindSaw (-x) = -dedekindSaw x := by
  unfold dedekindSaw
  by_cases h : Int.fract x = 0
  · rw [if_pos h, if_pos (Int.fract_neg_eq_zero.2 h), neg_zero]
  · rw [if_neg h, if_neg fun h' => h (Int.fract_neg_eq_zero.1 h'), Int.fract_neg h]
    ring

theorem abs_dedekindSaw_lt_half (x : ℚ) : |dedekindSaw x| < 1 / 2 := by
  unfold dedekindSaw
  by_cases h : Int.fract x = 0
  · rw [if_pos h, abs_zero]
    exact one_half_pos
  · have h0 : 0 < Int.fract x := lt_of_le_of_ne (Int.fract_nonneg x) (Ne.symm h)
    have h1 : Int.fract x < 1 := Int.fract_lt_one x
    rw [if_neg h, abs_lt]
    constructor <;> linarith

theorem dedekindSaw_half : dedekindSaw (1 / 2) = 0 := by
  have hfr : Int.fract (1 / 2 : ℚ) = 1 / 2 :=
    Int.fract_eq_self.2 ⟨one_half_pos.le, one_half_lt_one⟩
  rw [dedekindSaw_of_fract_ne_zero (by rw [hfr]; exact one_half_pos.ne'), hfr, sub_self]

theorem dedekindSaw_natCast_div {r k : ℕ} (h0 : 0 < r) (hrk : r < k) :
    dedekindSaw ((r : ℚ) / k) = (r : ℚ) / k - 1 / 2 := by
  have hk : (0 : ℚ) < k := by exact_mod_cast h0.trans hrk
  have hpos : (0 : ℚ) < (r : ℚ) / k := div_pos (by exact_mod_cast h0) hk
  have hlt : (r : ℚ) / k < 1 := (div_lt_one hk).2 (by exact_mod_cast hrk)
  have hfr : Int.fract ((r : ℚ) / k) = (r : ℚ) / k := Int.fract_eq_self.2 ⟨hpos.le, hlt⟩
  rw [dedekindSaw_of_fract_ne_zero (by rw [hfr]; exact hpos.ne'), hfr]

theorem dedekindSum_zero_right (h : ℤ) : dedekindSum h 0 = 0 := by
  simp [dedekindSum]

theorem dedekindSum_one_right (h : ℤ) : dedekindSum h 1 = 0 := by
  simp [dedekindSum, dedekindSaw_zero]

theorem dedekindSum_zero_left (k : ℕ) : dedekindSum 0 k = 0 := by
  simp [dedekindSum, dedekindSaw_zero]

theorem dedekindSum_neg (h : ℤ) (k : ℕ) : dedekindSum (-h) k = -dedekindSum h k := by
  unfold dedekindSum
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun r _ => ?_
  rw [Int.cast_neg, neg_mul, neg_div, dedekindSaw_neg]
  ring

theorem dedekindSum_add_mul (h m : ℤ) (k : ℕ) : dedekindSum (h + m * k) k = dedekindSum h k := by
  rcases Nat.eq_zero_or_pos k with rfl | hk
  · rw [dedekindSum_zero_right, dedekindSum_zero_right]
  unfold dedekindSum
  refine Finset.sum_congr rfl fun r _ => ?_
  have hk0 : (k : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hk.ne'
  have key : ((h + m * k : ℤ) : ℚ) * r / k = (h : ℚ) * r / k + ((m * r : ℤ) : ℚ) := by
    push_cast
    field_simp
  rw [key, dedekindSaw_add_intCast]

theorem dedekindSum_eq_sum_Ico (h : ℤ) (k : ℕ) :
    dedekindSum h k =
      ∑ r ∈ Finset.Ico 1 k, ((r : ℚ) / k - 1 / 2) * dedekindSaw ((h : ℚ) * r / k) := by
  rcases Nat.eq_zero_or_pos k with rfl | hk
  · rw [dedekindSum_zero_right]
    simp
  unfold dedekindSum
  rw [Finset.range_eq_Ico, Finset.sum_eq_sum_Ico_succ_bot hk, zero_add]
  simp only [Nat.cast_zero, zero_div, dedekindSaw_zero, zero_mul, zero_add]
  refine Finset.sum_congr rfl fun r hr => ?_
  obtain ⟨h1, h2⟩ := Finset.mem_Ico.1 hr
  rw [dedekindSaw_natCast_div h1 h2]

/-! ## DRK-02 — Dedekind reciprocity  (PROVED)

The **statement** is transcribed from FLT (`Theorems/Thm_dedekindSum_add_dedekindSum.lean`) with
the upstream binder names and shape, so a comparator can check it character-for-character.  The
**proof is independent**: see the provenance section in this file's header.  It is the classical
Rademacher–Grosswald lattice-point double count, re-derived against Mathlib primitives.

The private lemmas below are the scaffolding.  They are `private` because nothing outside this
file needs them yet; if `DRK-04` turns out to want `sum_mod_perm` or `double_count`, un-privatise
them then rather than exporting on speculation. -/

section Reciprocity

open Finset

/-! ### Gauss sums over `Ico 1 n`, in `ℚ` -/

/-- `∑_{r=1}^{n-1} 1 = n - 1`.  Stated in `ℚ` so the `ℕ`-subtraction never escapes. -/
private lemma sum_Ico_one_const (n : ℕ) (hn : 0 < n) :
    (∑ _r ∈ Finset.Ico 1 n, (1 : ℚ)) = (n : ℚ) - 1 := by
  rw [Finset.sum_const, Nat.card_Ico, nsmul_eq_mul, mul_one, Nat.cast_sub hn, Nat.cast_one]

/-- `∑_{r=1}^{n-1} r = n(n-1)/2`. -/
private lemma sum_Ico_one_id (n : ℕ) :
    (∑ r ∈ Finset.Ico 1 n, (r : ℚ)) = (n : ℚ) * ((n : ℚ) - 1) / 2 := by
  induction n with
  | zero => simp
  | succ m ih =>
      rcases Nat.eq_zero_or_pos m with rfl | hm
      · simp
      · rw [Finset.sum_Ico_succ_top hm, ih]; push_cast; ring

/-- `∑_{r=1}^{n-1} r² = (n-1)n(2n-1)/6`. -/
private lemma sum_Ico_one_sq (n : ℕ) :
    (∑ r ∈ Finset.Ico 1 n, (r : ℚ) ^ 2)
      = ((n : ℚ) - 1) * (n : ℚ) * (2 * (n : ℚ) - 1) / 6 := by
  induction n with
  | zero => norm_num
  | succ m ih =>
      rcases Nat.eq_zero_or_pos m with rfl | hm
      · norm_num
      · rw [Finset.sum_Ico_succ_top hm, ih]; push_cast; ring

/-! ### `r ↦ hr mod k` permutes `Ico 1 k` — where coprimality enters -/

/-- For coprime `h, k` and `1 ≤ r < k`, `hr` is **not** divisible by `k`.  This is the single
arithmetic fact that makes reciprocity true and makes it FAIL at `(4,12)`; the negative controls
`dedekindSum_reciprocity_fails_four_twelve`, `..._six_nine` and `..._ten_fifteen` in the gate
above are the instances where it breaks. -/
private lemma mod_pos_of_coprime {h k r : ℕ} (hhk : Nat.Coprime h k)
    (h1 : 1 ≤ r) (h2 : r < k) : 0 < h * r % k := by
  rcases Nat.eq_zero_or_pos (h * r % k) with h0 | h0
  · exact absurd (Nat.le_of_dvd (by omega)
      (Nat.Coprime.dvd_of_dvd_mul_left hhk.symm (Nat.dvd_of_mod_eq_zero h0))) (by omega)
  · exact h0

/-- `r ↦ hr mod k` is a bijection of `Ico 1 k`, so any sum over it may be reindexed.  Used at
`f = id` and at `f = (·)²`. -/
private lemma sum_mod_perm {h k : ℕ} (hk : 0 < k) (hhk : Nat.Coprime h k) (f : ℕ → ℚ) :
    ∑ r ∈ Finset.Ico 1 k, f (h * r % k) = ∑ r ∈ Finset.Ico 1 k, f r := by
  have hmem : ∀ r ∈ Finset.Ico 1 k, h * r % k ∈ Finset.Ico 1 k := by
    intro r hr
    rw [Finset.mem_Ico] at hr ⊢
    exact ⟨mod_pos_of_coprime hhk hr.1 hr.2, Nat.mod_lt _ hk⟩
  have hinj : Set.InjOn (fun r => h * r % k) (Finset.Ico 1 k : Finset ℕ) := by
    intro x hx y hy hxy
    simp only [Finset.coe_Ico, Set.mem_Ico] at hx hy
    have hmod : x ≡ y [MOD k] := Nat.ModEq.cancel_left_of_coprime hhk.symm hxy
    have hx' : x % k = x := Nat.mod_eq_of_lt hx.2
    have hy' : y % k = y := Nat.mod_eq_of_lt hy.2
    have h2 := hmod
    unfold Nat.ModEq at h2
    omega
  have himg : (Finset.Ico 1 k).image (fun r => h * r % k) = Finset.Ico 1 k := by
    refine Finset.eq_of_subset_of_card_le ?_ ?_
    · intro u hu
      rw [Finset.mem_image] at hu
      obtain ⟨r, hr, rfl⟩ := hu
      exact hmem r hr
    · rw [Finset.card_image_of_injOn hinj]
  calc ∑ r ∈ Finset.Ico 1 k, f (h * r % k)
      = ∑ u ∈ (Finset.Ico 1 k).image (fun r => h * r % k), f u := (Finset.sum_image hinj).symm
    _ = ∑ r ∈ Finset.Ico 1 k, f r := by rw [himg]

/-! ### The lattice-point double count -/

/-- Fibre over `r`: inside `Ico 1 h`, the `s` with `sk < hr` are exactly `Ico 1 (⌊hr/k⌋+1)`.
Coprimality is used to rule out `sk = hr`. -/
private lemma fibre_left {h k r : ℕ} (hk : 0 < k) (hhk : Nat.Coprime h k)
    (hr : r ∈ Finset.Ico 1 k) :
    {s ∈ Finset.Ico 1 h | s * k < h * r} = Finset.Ico 1 (h * r / k + 1) := by
  rw [Finset.mem_Ico] at hr
  have hnd : ¬ (k ∣ h * r) := fun hd => by
    have := Nat.le_of_dvd (by omega) (Nat.Coprime.dvd_of_dvd_mul_left hhk.symm hd); omega
  have hh : 0 < h := by
    rcases Nat.eq_zero_or_pos h with rfl | hh
    · exact absurd (by simp : k ∣ 0 * r) hnd
    · exact hh
  have hlt : h * r / k < h := (Nat.div_lt_iff_lt_mul hk).2 (Nat.mul_lt_mul_of_pos_left hr.2 hh)
  have key : ∀ s : ℕ, (s * k < h * r) ↔ (s < h * r / k + 1) := by
    intro s
    rw [Nat.lt_succ_iff, Nat.le_div_iff_mul_le hk]
    refine ⟨le_of_lt, fun hle => ?_⟩
    rcases lt_or_eq_of_le hle with h' | h'
    · exact h'
    · exact absurd ⟨s, by rw [← h', mul_comm]⟩ hnd
  ext s
  simp only [Finset.mem_filter, Finset.mem_Ico, key]
  exact ⟨fun ⟨⟨hs1, _⟩, hs3⟩ => ⟨hs1, hs3⟩, fun ⟨hs1, hs2⟩ => ⟨⟨hs1, by omega⟩, hs2⟩⟩

/-- Fibre over `s`: inside `Ico 1 k`, the `r` with `sk < hr` are exactly `Ico (⌊ks/h⌋+1) k`.
No coprimality needed here — the strictness is on the other side of the line. -/
private lemma fibre_right {h k s : ℕ} (hh : 0 < h) :
    {r ∈ Finset.Ico 1 k | s * k < h * r} = Finset.Ico (k * s / h + 1) k := by
  have key : ∀ r : ℕ, (s * k < h * r) ↔ (k * s / h + 1 ≤ r) := fun r => by
    rw [Nat.add_one_le_iff, Nat.div_lt_iff_lt_mul hh, mul_comm k s, mul_comm r h]
  ext r
  simp only [Finset.mem_filter, Finset.mem_Ico, key]
  exact ⟨fun ⟨⟨_, hr2⟩, hr3⟩ => ⟨hr3, hr2⟩,
    fun ⟨hr1, hr2⟩ => ⟨⟨le_trans (Nat.le_add_left 1 (k * s / h)) hr1, hr2⟩, hr1⟩⟩

/-- **The double count.**  `∑_{r=1}^{k-1} r⌊hr/k⌋` is the weight-`r` count of the lattice points
of `Ico 1 k × Ico 1 h` strictly below the line `sk = hr`; summing the other way round replaces
`⌊hr/k⌋` by a tail of `Ico 1 k`.  Pinned at `(7,11)` by `floorSum_id_seven_eleven_pin`. -/
private lemma double_count {h k : ℕ} (hh : 0 < h) (hk : 0 < k) (hhk : Nat.Coprime h k) :
    ∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((h * r / k : ℕ) : ℚ)
      = ∑ s ∈ Finset.Ico 1 h, ∑ r ∈ Finset.Ico (k * s / h + 1) k, (r : ℚ) := by
  have step1 : ∀ r ∈ Finset.Ico 1 k,
      (r : ℚ) * ((h * r / k : ℕ) : ℚ)
        = ∑ s ∈ Finset.Ico 1 h, (if s * k < h * r then (r : ℚ) else 0) := by
    intro r hr
    rw [← Finset.sum_filter, fibre_left hk hhk hr, Finset.sum_const, Nat.card_Ico,
      Nat.add_sub_cancel, nsmul_eq_mul, mul_comm]
  have step2 : ∀ s ∈ Finset.Ico 1 h,
      ∑ r ∈ Finset.Ico 1 k, (if s * k < h * r then (r : ℚ) else 0)
        = ∑ r ∈ Finset.Ico (k * s / h + 1) k, (r : ℚ) := by
    intro s _
    rw [← Finset.sum_filter, fibre_right hh]
  rw [Finset.sum_congr rfl step1, Finset.sum_comm]
  exact Finset.sum_congr rfl step2

/-! ### `s(h,k)` in terms of the mod sum -/

/-- Pointwise expansion of the `Ico`-form summand.  The `k = 0` branch is real, not decorative:
`ℚ`-division by zero is `0`, and both sides come out `1/4`. -/
private lemma sum_expand (k : ℕ) (c : ℕ → ℕ) :
    ∑ r ∈ Finset.Ico 1 k, ((r : ℚ) / k - 1 / 2) * (((c r : ℕ) : ℚ) / k - 1 / 2)
      = (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((c r : ℕ) : ℚ)) / (k : ℚ) ^ 2
        - (∑ r ∈ Finset.Ico 1 k, (r : ℚ)) / (2 * (k : ℚ))
        - (∑ r ∈ Finset.Ico 1 k, ((c r : ℕ) : ℚ)) / (2 * (k : ℚ))
        + (∑ _r ∈ Finset.Ico 1 k, (1 : ℚ)) / 4 := by
  simp only [Finset.sum_div, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun r _ => ?_
  rcases eq_or_ne (k : ℚ) 0 with h0 | h0
  · rw [h0]; norm_num
  · field_simp; ring

/-- For coprime `h, k` with `0 < k`:
`s(h,k) = (∑_{r=1}^{k-1} r·(hr mod k))/k² − (k−1)/4`.
Pinned at `(7,11)` by `modSum_seven_eleven_pin` together with `dedekindSum_seven_eleven_pin`. -/
private lemma dedekindSum_eq_modSum {h k : ℕ} (hk : 0 < k) (hhk : Nat.Coprime h k) :
    dedekindSum (h : ℤ) k
      = (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((h * r % k : ℕ) : ℚ)) / (k : ℚ) ^ 2
        - ((k : ℚ) - 1) / 4 := by
  have hk0 : (k : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hk.ne'
  have hsaw : ∀ r ∈ Finset.Ico 1 k,
      ((r : ℚ) / k - 1 / 2) * dedekindSaw (((h : ℤ) : ℚ) * (r : ℚ) / (k : ℚ))
        = ((r : ℚ) / k - 1 / 2) * (((h * r % k : ℕ) : ℚ) / (k : ℚ) - 1 / 2) := by
    intro r hr
    rw [Finset.mem_Ico] at hr
    have hpos : 0 < h * r % k := mod_pos_of_coprime hhk hr.1 hr.2
    have hltk : h * r % k < k := Nat.mod_lt _ hk
    have h0 : k * (h * r / k) + h * r % k = h * r := Nat.div_add_mod (h * r) k
    have hdm : (k : ℚ) * ((h * r / k : ℕ) : ℚ) + ((h * r % k : ℕ) : ℚ)
        = (h : ℚ) * (r : ℚ) := by
      have hc := congrArg (fun n : ℕ => (n : ℚ)) h0
      simpa using hc
    have hZ : ((h : ℤ) : ℚ) = (h : ℚ) := by push_cast; ring
    have hsplit : ((h : ℤ) : ℚ) * (r : ℚ) / (k : ℚ)
        = ((h * r % k : ℕ) : ℚ) / (k : ℚ) + ((h * r / k : ℕ) : ℚ) := by
      rw [hZ, ← hdm]; field_simp; ring
    rw [hsplit, dedekindSaw_add_natCast, dedekindSaw_natCast_div hpos hltk]
  rw [dedekindSum_eq_sum_Ico, Finset.sum_congr rfl hsaw,
    sum_expand k (fun r => h * r % k),
    sum_mod_perm hk hhk (fun x => (x : ℚ)), sum_Ico_one_id k, sum_Ico_one_const k hk]
  field_simp
  ring

/-- **DRK-02 (PROVED).**  Dedekind reciprocity: for coprime positive `h, k`,
`s(h,k) + s(k,h) = (h/k + k/h + 1/(hk))/12 - 1/4`.

STATEMENT transcribed from FLT `Theorems/Thm_dedekindSum_add_dedekindSum.lean` (Apache-2.0);
PROOF independent — Rademacher–Grosswald lattice-point double count, not FLT's
`p2m_exact_reverting` (which is unavailable here) and not Apostol's cotangent argument.

Instance-checked, before this proof was written, at the coprime pairs `(5,12)`, `(3,7)`, `(1,5)`
in the `DRK-00` gate and at `(7,11)`, `(9,25)`, `(2,15)`, `(4,9)`, `(11,13)`, `(3,8)`, `(1,1)` in
the `ReciprocityGate` block, with three negative controls — `(4,12)`, `(6,9)`, `(10,15)` — where
it is FALSE, so `hhk` is load-bearing.  All three positivity/coprimality hypotheses are used:
`hhk` in `mod_pos_of_coprime` and `fibre_left`, `hk` and `hh` as the non-vanishing of the
denominators `(k : ℚ)` and `(h : ℚ)` in the closing `field_simp`. -/
theorem dedekindSum_add_dedekindSum (h k : ℕ) (hh : 0 < h) (hk : 0 < k)
    (hhk : Nat.Coprime h k) :
    dedekindSum h k + dedekindSum k h
      = ((h : ℚ) / k + (k : ℚ) / h + 1 / ((h : ℚ) * k)) / 12 - 1 / 4 := by
  have hk0 : (k : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hk.ne'
  have hh0 : (h : ℚ) ≠ 0 := Nat.cast_ne_zero.2 hh.ne'
  have hSk2 : (∑ r ∈ Finset.Ico 1 k, (r : ℚ) ^ 2)
      = ((k : ℚ) - 1) * (k : ℚ) * (2 * (k : ℚ) - 1) / 6 := sum_Ico_one_sq k
  have hSh1 : (∑ s ∈ Finset.Ico 1 h, (s : ℚ)) = (h : ℚ) * ((h : ℚ) - 1) / 2 := sum_Ico_one_id h
  have hSh2 : (∑ s ∈ Finset.Ico 1 h, (s : ℚ) ^ 2)
      = ((h : ℚ) - 1) * (h : ℚ) * (2 * (h : ℚ) - 1) / 6 := sum_Ico_one_sq h
  have hperm1 : (∑ s ∈ Finset.Ico 1 h, ((k * s % h : ℕ) : ℚ)) = ∑ s ∈ Finset.Ico 1 h, (s : ℚ) :=
    sum_mod_perm hh hhk.symm (fun x => (x : ℚ))
  have hperm2 : (∑ s ∈ Finset.Ico 1 h, ((k * s % h : ℕ) : ℚ) ^ 2)
      = ∑ s ∈ Finset.Ico 1 h, (s : ℚ) ^ 2 := sum_mod_perm hh hhk.symm (fun x => (x : ℚ) ^ 2)
  have hdivh : ∀ s : ℕ,
      (h : ℚ) * ((k * s / h : ℕ) : ℚ) + ((k * s % h : ℕ) : ℚ) = (k : ℚ) * (s : ℚ) := by
    intro s
    have h0 : h * (k * s / h) + k * s % h = k * s := Nat.div_add_mod (k * s) h
    have hc := congrArg (fun n : ℕ => (n : ℚ)) h0
    simpa using hc
  have hdivk : ∀ r : ℕ,
      (k : ℚ) * ((h * r / k : ℕ) : ℚ) + ((h * r % k : ℕ) : ℚ) = (h : ℚ) * (r : ℚ) := by
    intro r
    have h0 : k * (h * r / k) + h * r % k = h * r := Nat.div_add_mod (h * r) k
    have hc := congrArg (fun n : ℕ => (n : ℚ)) h0
    simpa using hc
  -- `∑_{s=1}^{h-1} ⌊ks/h⌋ = (k-1)(h-1)/2`, from the permutation with `f = id`.
  have hN1 : (∑ s ∈ Finset.Ico 1 h, ((k * s / h : ℕ) : ℚ))
      = ((k : ℚ) - 1) * ((h : ℚ) * ((h : ℚ) - 1) / 2) / (h : ℚ) := by
    have hstep : (h : ℚ) * (∑ s ∈ Finset.Ico 1 h, ((k * s / h : ℕ) : ℚ))
        + (∑ s ∈ Finset.Ico 1 h, ((k * s % h : ℕ) : ℚ))
        = (k : ℚ) * (∑ s ∈ Finset.Ico 1 h, (s : ℚ)) := by
      rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun s _ => hdivh s
    rw [hperm1, hSh1] at hstep
    field_simp at hstep ⊢
    linarith
  -- squaring `h⌊ks/h⌋ + (ks mod h) = ks` and summing: this is where `s(k,h)` appears
  have hN2raw : (h : ℚ) ^ 2 * (∑ s ∈ Finset.Ico 1 h, ((k * s / h : ℕ) : ℚ) ^ 2)
      = (k : ℚ) ^ 2 * (∑ s ∈ Finset.Ico 1 h, (s : ℚ) ^ 2)
        - 2 * (k : ℚ) * (∑ s ∈ Finset.Ico 1 h, (s : ℚ) * ((k * s % h : ℕ) : ℚ))
        + (∑ s ∈ Finset.Ico 1 h, ((k * s % h : ℕ) : ℚ) ^ 2) := by
    rw [Finset.mul_sum, Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib,
      ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun s _ => ?_
    linear_combination ((h : ℚ) * ((k * s / h : ℕ) : ℚ) + (k : ℚ) * (s : ℚ)
      - ((k * s % h : ℕ) : ℚ)) * hdivh s
  rw [hperm2, hSh2] at hN2raw
  have hN2 : (∑ s ∈ Finset.Ico 1 h, ((k * s / h : ℕ) : ℚ) ^ 2)
      = ((k : ℚ) ^ 2 * (((h : ℚ) - 1) * (h : ℚ) * (2 * (h : ℚ) - 1) / 6)
        - 2 * (k : ℚ) * (∑ s ∈ Finset.Ico 1 h, (s : ℚ) * ((k * s % h : ℕ) : ℚ))
        + ((h : ℚ) - 1) * (h : ℚ) * (2 * (h : ℚ) - 1) / 6) / (h : ℚ) ^ 2 := by
    field_simp at hN2raw ⊢
    linarith
  -- the double count, with the inner tail summed in closed form
  have hF1 : (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((h * r / k : ℕ) : ℚ))
      = ((h : ℚ) - 1) * ((k : ℚ) * ((k : ℚ) - 1) / 2)
        - ((∑ s ∈ Finset.Ico 1 h, ((k * s / h : ℕ) : ℚ) ^ 2)
           + (∑ s ∈ Finset.Ico 1 h, ((k * s / h : ℕ) : ℚ))) / 2 := by
    rw [double_count hh hk hhk]
    have hinner : ∀ s ∈ Finset.Ico 1 h,
        (∑ r ∈ Finset.Ico (k * s / h + 1) k, (r : ℚ))
          = (k : ℚ) * ((k : ℚ) - 1) / 2
            - (((k * s / h : ℕ) : ℚ) ^ 2 + ((k * s / h : ℕ) : ℚ)) / 2 := by
      intro s hs
      rw [Finset.mem_Ico] at hs
      have hn : k * s / h < k := (Nat.div_lt_iff_lt_mul hh).2 (Nat.mul_lt_mul_of_pos_left hs.2 hk)
      have hcons := Finset.sum_Ico_consecutive (fun r : ℕ => (r : ℚ))
        (Nat.le_add_left 1 (k * s / h)) hn
      rw [sum_Ico_one_id (k * s / h + 1), sum_Ico_one_id k] at hcons
      push_cast at hcons
      linarith
    rw [Finset.sum_congr rfl hinner, Finset.sum_sub_distrib]
    congr 1
    · rw [Finset.sum_const, Nat.card_Ico, nsmul_eq_mul, Nat.cast_sub hh, Nat.cast_one]
    · rw [← Finset.sum_div, Finset.sum_add_distrib]
  -- `hr = k⌊hr/k⌋ + (hr mod k)`, weighted by `r` and summed
  have hM1 : (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((h * r % k : ℕ) : ℚ))
      = (h : ℚ) * (∑ r ∈ Finset.Ico 1 k, (r : ℚ) ^ 2)
        - (k : ℚ) * (∑ r ∈ Finset.Ico 1 k, (r : ℚ) * ((h * r / k : ℕ) : ℚ)) := by
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun r _ => ?_
    linear_combination (r : ℚ) * hdivk r
  -- assemble: the `s(k,h)` introduced by `hN2` cancels the one already in the goal
  rw [dedekindSum_eq_modSum hk hhk, dedekindSum_eq_modSum hh hhk.symm, hM1, hSk2, hF1, hN2, hN1]
  field_simp
  ring

end Reciprocity

end SocrateAI.NumberTheory
