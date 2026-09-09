/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# T-duality on the `T²` modulus, reduced to the Fricke involution  (DAG: TDUAL-M0..M4, TDUAL-01)

## What this file claims, and what it does not

**Primary citation for the physics.**  A. Giveon, M. Porrati, E. Rabinovici, *Target Space
Duality in String Theory*, Phys. Rept. **244** (1994) 77–202, arXiv:hep-th/9401139.  Fetched and
read 2026-09-08 (arXiv abs page confirms title/authors/journal-ref; the 1.2 MB PDF was extracted
with `pdftotext`, 348142 bytes of text, and §2.4 read directly).  Verified in §2.4 of that text:

* the `T²` carries a complex structure `τ` and a Kähler structure `ρ = B₁₂ + i·vol`;
* eq. (2.4.57) lists the `SL(2,ℤ)²` generators verbatim —
  `S : τ → -1/τ, ρ → ρ`;  `T : τ → τ+1, ρ → ρ`;  `S' : ρ → -1/ρ, τ → τ`;  `T' : ρ → ρ+1, τ → τ`;
* eq. (2.4.58) gives `p²_{L,R}` in terms of `(τ, ρ)` and the integer charges `n₁, n₂, m₁, m₂`,
  which is what makes those transformations *spectrum-preserving* rather than merely formal;
* eq. (2.4.59) is factorized duality `D₂ : (τ, ρ) → (ρ, τ)`, the stringy exchange, with the text
  identifying `S'` as the `D₂`-conjugate of `S`;  eq. (2.4.60) is `R : (τ,ρ) → (-τ̄, -ρ̄)`, and
  eq. (2.4.61) is worldsheet parity `W`.

So the *classical* fact used here — T-duality acts on the `T²` complex-structure modulus `τ` by
the fractional-linear `SL(2,ℤ)` action — is cited to the primary literature, not to any local
repository and not from memory.  Stated precisely, because the distinction matters (LL-25):
(2.4.57) displays the **generators** `S : τ ↦ -1/τ` and `T : τ ↦ τ+1`, not the scalar formula
`(aτ+b)/(cτ+d)`.  The general `τ`-action is what §2.4's surrounding prose presupposes and is
standard, but this file attributes to (2.4.57) only what (2.4.57) displays.  A grep of the full
`pdftotext` extraction for `cτ + d`, `aτ + b` and `fractional linear` returns 12 hits, none of them
a scalar `(aτ+b)/(cτ+d)`: GPR's displayed fractional-linear transformations, at (2.4.13), (2.4.24)
and (4.2.30), are the *matrix* action on the background `E`.

**Prior local attempt, named plainly.**  `SocrateAI-Scientific-DualScaleSimulator` is **not** a
dependency of this file and is **not** cited as a proof source.  It was read in full on
2026-09-08 and found to be axiom-propped: its `BuscherRules.lean` proves `buscher_involution`
entirely by invoking five self-authored axioms (`inv_inv`, `buscher_cross_inv`,
`buscher_gmunu_inv`, `buscher_Bmunu_inv`, `Phi_inv`) that assert exactly the algebraic identities
the "proof" needs, on a bare generic type with minimal typeclasses — the claim restated as
axioms, never derived and never instantiated at `ℝ` or `ℂ`.  Its `TopologicalTDuality.lean`
theorem `bem_symmetric_exchange` destructures its own hypothesis structure.  Neither file mentions
K3, `SL(2,ℤ)` or `Γ₀(N)` concretely, and that repository has no Mathlib dependency and no pinned
toolchain.  This file replaces that with a reduction to machinery already proved here.

## The reachable claim

The **full** T-duality group of a Type II compactification on `K3 × T²` acts on the Narain moduli
space `O(Γ^{4,20})/(O(4) × O(20))`.  That is **not** attempted here and is **out of scope**:
Mathlib contains no `Narain` and no `K3Surface` (repository-wide grep: zero hits), so there is no
anchor to reduce to.  Likewise **out of scope**: the K3 factor's own duality group, and Mathieu
moonshine / `M24` / `Sym²` statements of any kind.  If either becomes reachable it is a separate,
separately gate-zero'd question, and it must be built from primary literature.

What *is* reachable, and is what this file states: T-duality restricted to the `T²` factor acts
on `τ` by GPR (2.4.57)'s fractional-linear transformations; restricting that action to `Γ₀(N)`
and adjoining the level-`N` Fricke normalization `τ ↦ -1/(Nτ)` lands exactly in the setting our
own sorry-free `frickeW` artifact already occupies.  The bridge is therefore a **reduction to
existing machinery**, not new number theory — and the point of stating it in Lean is that
"coincides with" becomes a checkable equality of terms rather than a rhetorical claim.

**Explicitly NOT claimed** by `tduality_tau_fricke_bridge`: that any particular string background
has unbroken duality group exactly `Γ₀(N)⟨W_N⟩`.  That is a CHL-type statement requiring its own
primary-literature support and its own DAG node.

## Sign / definitional discipline (LL-1)

`TDUAL-M0` is a **gate**, not a corollary: four decide-pins whose values were computed *first*
from the physics formula `-1/(N·τ)` in exact Gaussian-rational arithmetic (python `fractions`,
this session), and only then written as Lean statements:

| pin | `N` | `τ` | `-1/(Nτ)` |
| --- | --- | --- | --- |
| `frickeW_pin_N1_i`        | 1 | `i`   | `i`          |
| `frickeW_pin_N2_i`        | 2 | `i`   | `i/2`        |
| `frickeW_pin_N4_halfI`    | 4 | `i/2` | `i/2`        |
| `frickeW_pin_N1_onePlusI` | 1 | `1+i` | `(-1+i)/2`   |

The first is GPR's self-dual point of `S`.  The third is a genuine `W₄` fixed point.  The fourth
is the only pin with nonzero real part, so it is what catches a sign error in the `b`-entry and any
error invisible on the imaginary axis.

Which variant each pin actually discriminates was recomputed variant-by-variant, in the same exact
Gaussian-rational arithmetic, rather than assumed:

* a **transposed** `frickeMatrix` (`!![0,N;-1,0]`, acting by `τ ↦ -N/τ`) is caught by pins **2 and
  3** (it gives `2i` and `8i` there).  It is *not* caught by pins 1 and 4: at `N = 1` the transpose
  is character-for-character the same map, so both agree with the true value.
* a **dropped factor of `N`** (`!![0,-1;1,0]`) is caught by pins 2 and 3.
* a **`b`-entry sign flip** (`!![0,1;N,0]`, acting by `τ ↦ +1/(Nτ)`) is caught by every pin, and at
  pin 4 it is the difference between `(1-i)/2` and `(-1+i)/2`.
* an **inverted action convention** is *provably undetectable by any pin whatsoever*: `frickeW_sq_coe`
  gives `W_N² = -N·I`, a scalar, and scalars act trivially on `ℍ`, so `W_N` and `W_N⁻¹` induce the
  **same** Möbius map.  Recomputing all four pins against `W_N⁻¹ = (1/N)·!![0,1;-N,0]` returns
  `i, i/2, i/2, (-1+i)/2` — identical to the true values.  No decide-pin can ever see this, and the
  claim that pin 4 catches it (asserted in an earlier draft of this file and of the `TDUAL-01`
  falsifier) is false; it is recorded here so it is not re-asserted.

The discrimination is enforced, not merely asserted: `verification/TDual0PinNegControl.lean` states
these same four pins with the *variant* right-hand sides and the *same* tactic blocks, and fails to
compile with exactly four `unsolved goals` errors
(`lake env lean verification/TDual0PinNegControl.lean` must exit nonzero).  These pins must be discharged **before** `TDUAL-M1`'s
general formula is proved.

## Status

`TDUAL-M0` (the four decide-pins), `TDUAL-M1` (the general formula `W_N • τ = -1/(Nτ)`),
`TDUAL-M2` (the five instance-agreement pins, the `GL`/`SL` action identity, and its FRK-07
consequence) and `TDUAL-M3` (the five fractional-linear pins and the formula
`γ • τ = (aτ+b)/(cτ+d)`) are **proved, sorry-free**, with axiom footprint
`[propext, Classical.choice, Quot.sound]`, guarded in `SocrateAI.FinalCheck`.  `TDUAL-M4` is also
**proved, sorry-free**, same footprint (corrected 2026-09-09 — this comment previously said M4
was still `sorry`; it is not; only `TDUAL-01` is).  `TDUAL-01` alone is `sorry`, under an INVERTED
`FinalCheck` tripwire, and it is not merely open but **actively contested**: an independent review
found it equivalent to `TDUAL-M1 ∧ TDUAL-M2 ∧ TDUAL-M3` with no added content (a relabelling, not
a reduction) and found no primary-literature support for the `Γ₀(N)`/level-`N` physics attribution
at any `N > 1`.  See the DAG node and `docs/Lean4_Fricke_Involution.tex` for the corrected account.
Do not close this `sorry`; the open question is whether the node should be retired, not proved.

`TDUAL-M3` carries its own gate, in the same order and with the same discipline as `TDUAL-M0` and
`TDUAL-M2`: five pins whose values were computed first in exact Gaussian-rational arithmetic from
`(aτ+b)/(cτ+d)`, each stating the Mathlib action value and the `TDUAL-M3` right-hand side *as two
separate conjuncts* so that a wrong entry-position assignment cannot be absorbed, with two of the
five matrices asserted in-statement to lie in `Γ₀(3)` and `Γ₀(5)`; the pins were discharged and
`verification/TDualM3PinNegControl.lean` confirmed to fail with exactly ten `error:` lines
**before** `sl_smul_coe_eq_flt` was proved.  The variant-by-variant blindness of each pin is
recorded at the gate rather than glossed, and only the `Γ₀(5)` pin `!![7,2;10,3]` catches all five
variants.

`TDUAL-M3` is the `SL(2,ℤ)`/GPR half of the bridge and nothing more: it mentions neither `frickeW`
nor `Γ₀(N)`, and it must not be read as the bridge.  `frickeW` enters through `TDUAL-M1` and
`TDUAL-M2`; the Fricke reduction itself is `TDUAL-01`, which is still open.  Relatedly, the
`Γ₀(N)` hypothesis that `TDUAL-01` carries is deliberately **unused** by the formula conjunct —
restricting a group action to a subgroup cannot change the Möbius formula — so `Γ₀(N)` must never
be described as load-bearing *in the formula*; it is load-bearing only for where `frickeW` lives.

`TDUAL-M2` carries its own gate, in the same order and with the same discipline: five pins whose
values were computed first in exact Gaussian-rational arithmetic from `(aτ+b)/(cτ+d)`, evaluating
the `GL(2,ℝ)` path and the `SL(2,ℤ)` path *separately*, with two of the five matrices asserted to
lie in `Γ₀(2)`; the pins were discharged and `verification/TDualM2PinNegControl.lean` confirmed to
fail with exactly ten `error:` lines **before** `mapGL_smul_eq_sl_smul` was proved.  That theorem is
`rfl`, and this file says so rather than dressing it up: it has no mathematical content, mentions
neither `frickeW` nor `Γ₀(N)`, and reduces to Mathlib's `SLAction` definition, not to anything of
ours.  Its whole job is the anti-pun check.  The pins are the discrimination evidence a `rfl` cannot
supply on its own, together with the recorded `pp.all` readout showing the two sides really do
elaborate through different instances (`UpperHalfPlane.glAction` on the left,
`UpperHalfPlane.SLAction` on the right).

The `TDUAL-M0` → `TDUAL-M1` order was honoured as a process gate: the four pin values were
recomputed independently in exact Gaussian-rational arithmetic and the pins compiled clean, and
`verification/TDual0PinNegControl.lean` was confirmed to fail with exactly four `unsolved goals`,
*before* `TDUAL-M1`'s general proof was attempted.  Afterwards all four pins were re-derived **from**
`frickeW_smul_coe` (a sign error in the general formula would have broken that derivation), and
`frickeW hN • frickeW hN • τ = τ` was discharged from it via `mul_smul` and the already-proved
`frickeW_sq_smul`.  `TDUAL-M1` has its own negative control at
`verification/TDualM1NegControl.lean`.

`TDUAL-01` additionally carries an **unresolved obstruction that is not a Lean problem** and must be
settled from GPR §2.4 directly before that node is claimed: (2.4.57) lists four generators over
*two* moduli — `S, T` act on the complex-structure modulus `τ`, `S', T'` on the Kähler modulus `ρ` —
and (2.4.59) makes factorized duality `D₂` the exchange `(τ,ρ) ↦ (ρ,τ)`.  On the standard reading,
T-duality proper is the `ρ`-side `SL(2,ℤ)` together with `D₂`, while `SL(2,ℤ)_τ` is the *geometric*
mapping-class group of the `T²`.  So "T-duality acts on `τ`" is at best loose and at worst a
misattribution of which `SL(2,ℤ)` is the duality group.  `TDUAL-M0`…`TDUAL-M4` are unaffected — they
assert nothing about physics, only about a Lean Möbius action — but `TDUAL-01` as currently stated
is, and is not to be closed until this is resolved (either by re-reading which modulus
`D₂`-conjugation puts `S` on, or by restating the bridge on `ρ`).

Main statements:
* `frickeW_pin_N1_i`, `frickeW_pin_N2_i`, `frickeW_pin_N4_halfI`, `frickeW_pin_N1_onePlusI`
                                       — TDUAL-M0, the sign-discipline gate
* `frickeW_smul_coe`                   — TDUAL-M1, `W_N • τ = -1/(Nτ)` pointwise in `ℂ` (proved)
* `mapGL_sl_pin_id_i`, `mapGL_sl_pin_T_i`, `mapGL_sl_pin_S_onePlusI`,
  `mapGL_sl_pin_G0two_lower_i`, `mapGL_sl_pin_G0two_i`
                                       — TDUAL-M2's instance-agreement gate (proved)
* `mapGL_smul_eq_sl_smul`              — TDUAL-M2, the `GL(2,ℝ)` and `SL(2,ℤ)` actions agree (proved)
* `exists_sl_smul_eq_of_mem_map_Gamma0` — TDUAL-M2's load-bearing consequence for FRK-07 (proved)
* `sl_flt_pin_2111_i`, `sl_flt_pin_Tsq_i`, `sl_flt_pin_L3_i`, `sl_flt_pin_G5_i`,
  `sl_flt_pin_negB_twoI`               — TDUAL-M3's entry-position gate (proved)
* `sl_smul_coe_eq_flt`                 — TDUAL-M3, that action is `(aτ+b)/(cτ+d)` (proved)
* `frickeW_invol_pin_N2_i`, `frickeW_invol_pin_N3_twoI`, `frickeW_invol_pin_N1_onePlusI`,
  `frickeW_invol_pin_N2_onePlusI`, `frickeW_invol_pin_N4_i`
                                       — TDUAL-M4's two-step gate (proved)
* `frickeW_smul_involutive`            — TDUAL-M4, `W_N` is an involution of `ℍ` itself (proved)
* `tduality_tau_fricke_bridge`         — TDUAL-01, the bridge
-/
import SocrateAI.ModularForms.FrickeComposite

namespace SocrateAI.StringTheory

open Matrix CongruenceSubgroup UpperHalfPlane Complex
open SocrateAI.ModularForms
open scoped MatrixGroups

/-! ### TDUAL-M0 — the decide-pin gate

Four independently computed instances of `τ ↦ -1/(Nτ)`, stated against the *Mathlib action* of
`frickeW`.  If any of these four fails, `TDUAL-M1` is wrong and must not be attempted. -/

/-- **TDUAL-M0 pin 1/4.**  `W₁ • i = i` — GPR's self-dual point of the generator `S`
(hep-th/9401139 eq. 2.4.57).  Value computed first in exact Gaussian rationals: `-1/(1·i) = i`. -/
theorem frickeW_pin_N1_i :
    ((frickeW (N := 1) (by norm_num) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I := by
  -- `coe_smul_of_det_pos` wants `0 < g.det.val`, which is `Matrix.mem_glpos` unfolded — so FRK-01's
  -- `frickeW_mem_GLPos` IS that proof, and is passed directly.  (`frickeMatrix_det_pos` is about the
  -- raw matrix, not the `GL` unit, and does not elaborate here.)
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos (by norm_num))]
  -- `num = 0·τ + (-1) = -1`, `denom = 1·τ + 0 = i`; remaining arithmetic `-1/i = i`.
  simp [num, denom, frickeMatrix]

/-- **TDUAL-M0 pin 2/4.**  `W₂ • i = i/2`.  Exact Gaussian-rational value: `-1/(2i) = i/2`. -/
theorem frickeW_pin_N2_i :
    ((frickeW (N := 2) (by norm_num) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I / 2 := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  -- goal is now literally `-1 / (2 * I) = I / 2`
  field_simp
  ring_nf
  simp [Complex.I_sq]

/-- **TDUAL-M0 pin 3/4.**  `W₄ • (i/2) = i/2` — a genuine fixed point of the level-4 Fricke map
(`-1/(4·(i/2)) = -1/(2i) = i/2`), so it also cross-checks `TDUAL-M4`. -/
theorem frickeW_pin_N4_halfI :
    ((frickeW (N := 4) (by norm_num) • (⟨Complex.I / 2, by norm_num [Complex.div_im]⟩ : ℍ) : ℍ) : ℂ)
      = Complex.I / 2 := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  -- goal is now literally `-1 / (4 * (I / 2)) = I / 2`
  field_simp
  ring_nf
  simp [Complex.I_sq]

/-- **TDUAL-M0 pin 4/4.**  `W₁ • (1+i) = (-1+i)/2`.  The only pin with a nonzero real part on both
sides, so it is what catches a sign error in the `b`-entry (`!![0,1;N,0]` gives `+1/(Nτ)`, i.e.
`(1-i)/2` here) and any error that is invisible on the imaginary axis.

It does **not** catch a transposed `frickeMatrix`: the transpose `!![0,N;-1,0]` acts by `τ ↦ -N/τ`,
which at `N = 1` is the same map, and gives `(-1+i)/2` here too.  The transpose is caught by pins 2
and 3 instead.  And it does not catch an inverted convention, which no pin can: `W_N² = -N·I` is
scalar (`frickeW_sq_coe`), so `W_N` and `W_N⁻¹` induce the same map on `ℍ`. -/
theorem frickeW_pin_N1_onePlusI :
    ((frickeW (N := 1) (by norm_num) • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
      = (-1 + Complex.I) / 2 := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  -- goal is now literally `-1 / (1 + I) = (-1 + I) / 2`; cross-multiply rather than rationalize.
  rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
  ring_nf
  simp [Complex.I_sq]
  ring

/-! ### TDUAL-M1 — the Fricke map in closed form -/

/-- **TDUAL-M1.**  Mathlib's `GL(2,ℝ)`-action of `frickeW` on `ℍ` is, pointwise in `ℂ`, the
textbook level-`N` Fricke map `τ ↦ -1/(Nτ)`.  At `N = 1` this is character-for-character the
generator `S : τ → -1/τ` of GPR eq. (2.4.57).

Depends on `TDUAL-M0` as a *process* gate (pins first), not logically.

Independently of the physics reading, this lemma is also the seam between the two halves of this
library: `-1 / ((N : ℂ) * z)` is verbatim the normal form the ℂ-level eta-quotient half already
runs on (`EtaQuotientModularity.lean`, inside `eta_fricke_factor`), while the `frickeW` half speaks
only of the `GL(2,ℝ)`-action.  Before this lemma no declaration connected them.

Proof, and why it is not vacuous.  `frickeW_mem_GLPos` (FRK-01) *is* the `0 < g.det.val` that
`coe_smul_of_det_pos` demands — `Matrix.mem_glpos` is that inequality by definition — so the
determinant-positive branch of `σ` is taken and there is **no** hidden complex conjugation.  Then
`num (frickeW hN) τ = 0·τ + (-1) = -1` and `denom (frickeW hN) τ = N·τ + 0 = N·τ`.  No
nonvanishing side condition is needed: division in `ℂ` is total, and the goal is an identity of
`num/denom` against the stated right-hand side.  (Note `frickeMatrix_det_pos` does *not* work here:
it is about the raw matrix, not the `GL` unit's determinant.)

That the tactic block does real work is certified, not asserted: `verification/TDualM1NegControl.lean`
restates this theorem with four *wrong* right-hand sides — `+1/(Nτ)` (`b`-flip), `-1/τ` (dropped `N`),
`-N/τ` (transpose), `-1/(N+τ)` (`denom` misread) — under the identical tactic block, and fails with
exactly four `unsolved goals`.  Each failing goal displays the simp-normalised left-hand side as
`-1 / (↑N * ↑τ)`, i.e. the simp set computes the Fricke map independently of what it is compared
against. -/
theorem frickeW_smul_coe {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    ((frickeW hN • τ : ℍ) : ℂ) = -1 / ((N : ℂ) * (τ : ℂ)) := by
  rw [coe_smul_of_det_pos (frickeW_mem_GLPos hN)]
  simp [num, denom, frickeW_coe, frickeMatrix]

/-! ### TDUAL-M2 / TDUAL-M3 — the `SL(2,ℤ)` side is the same action, in the GPR formula -/

/-! #### TDUAL-M2 pins — the instance-agreement gate

`mapGL_smul_eq_sl_smul` is closed by `rfl`, so no *tactic* in its proof can be non-vacuous and the
`TDUAL-M0` style of negative control (a wrong right-hand side that a working tactic block must fail
on) does not apply to the general statement itself.  The discipline is therefore relocated to five
pins, and it is a genuine check rather than a ritual, for a reason worth stating:

*the two sides of the general statement elaborate through different `MulAction` instances.*
Under `set_option pp.all true` the left-hand side carries `UpperHalfPlane.glAction` (the `GL(2,ℝ)`
Möbius action) and the right-hand side carries
`@UpperHalfPlane.SLAction ℤ Int.instCommRing (Ring.toIntAlgebra ℝ)`, with the two joined by
`@Matrix.SpecialLinearGroup.mapGL (Fin 2) … ℤ … ℝ`.  Each pin below evaluates **both** instance
paths, separately, against a value computed FIRST in exact Gaussian-rational arithmetic (python
`fractions`, this session) from the fractional-linear formula `τ ↦ (aτ+b)/(cτ+d)` — never one side
against the other, and never either side against `mapGL_smul_eq_sl_smul`:

| pin | `γ` | `τ` | `(aτ+b)/(cτ+d)` |
| --- | --- | --- | --- |
| `mapGL_sl_pin_id_i`          | `1`             | `i`   | `i`         |
| `mapGL_sl_pin_T_i`           | `!![1,1;0,1]`   | `i`   | `1+i`       |
| `mapGL_sl_pin_S_onePlusI`    | `!![0,-1;1,0]`  | `1+i` | `(-1+i)/2`  |
| `mapGL_sl_pin_G0two_lower_i` | `!![1,0;2,1]`   | `i`   | `(2+i)/5`   |
| `mapGL_sl_pin_G0two_i`       | `!![3,1;2,1]`   | `i`   | `(7+i)/5`   |

The last two matrices are asserted, in the pin itself, to lie in `Γ₀(2)` — so the gate is exercised
inside the very subgroup the bridge is about (the one `frickeW` normalizes, FRK-07) and not only on
generators of the full `SL(2,ℤ)`.  Pin 3 is the only one with a nonzero real part on both sides.
Pin 5 is the only one with all four entries nonzero, so it is the only pin that constrains every
entry at once.

Which variant each pin discriminates was recomputed variant-by-variant in the same exact arithmetic
rather than assumed, and the honest negative results are recorded:

* a **transposed** matrix is caught at the `T` pin (`(1+i)/2`), the `Γ₀(2)` lower pin (`2+i`) and
  the `Γ₀(2)` general pin (`(5+i)/2`).  It is **not** caught at the `S` pin: `!![0,1;-1,0]` sends
  `1+i` to `-1/(1+i) = (-1+i)/2`, the true value.
* a **`b`-entry sign flip** is caught at the `T` pin (`-1+i`), the `S` pin (`(1-i)/2`) and the
  `Γ₀(2)` general pin (`1+i`).  It is **not** caught at the `Γ₀(2)` lower pin, whose `b`-entry is
  already `0`, so flipping its sign is the identity map.
* an **`SL(2,ℤ)`-vs-`GL(2,ℝ)` instance mismatch** — the failure this node exists to exclude — is
  caught by *every* pin, because each pin states the two sides independently: if the two `•`s were
  different maps, at most one of the two conjuncts could hold.

The discrimination is enforced, not asserted: `verification/TDualM2PinNegControl.lean` restates all
five pins with the variant right-hand sides above under the identical tactic blocks and must fail
with exactly ten `error:` lines (two per pin).  The pins were discharged, and that file confirmed to
fail, **before** `mapGL_smul_eq_sl_smul` was proved. -/

/-- `T = !![1,1;0,1]`, the `τ ↦ τ+1` generator of GPR eq. (2.4.57).  Pin matrix only. -/
def pinGammaT : SL(2, ℤ) := ⟨!![1, 1; 0, 1], by norm_num [Matrix.det_fin_two_of]⟩

/-- `S = !![0,-1;1,0]`, the `τ ↦ -1/τ` generator of GPR eq. (2.4.57).  Pin matrix only. -/
def pinGammaS : SL(2, ℤ) := ⟨!![0, -1; 1, 0], by norm_num [Matrix.det_fin_two_of]⟩

/-- `!![1,0;2,1] ∈ Γ₀(2)`, a lower-triangular element of the bridge's subgroup.  Pin matrix only. -/
def pinGammaL2 : SL(2, ℤ) := ⟨!![1, 0; 2, 1], by norm_num [Matrix.det_fin_two_of]⟩

/-- `!![3,1;2,1] ∈ Γ₀(2)`, the only pin matrix with all four entries nonzero.  Pin matrix only. -/
def pinGammaG2 : SL(2, ℤ) := ⟨!![3, 1; 2, 1], by norm_num [Matrix.det_fin_two_of]⟩

/-- **TDUAL-M2 pin 1/5.**  `γ = 1`, `τ = i`: both instance paths give `i`. -/
theorem mapGL_sl_pin_id_i :
    ((Matrix.SpecialLinearGroup.mapGL ℝ (1 : SL(2, ℤ)) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = Complex.I ∧
      (((1 : SL(2, ℤ)) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [coe_smul_of_det_pos (by simp)]
    simp [num, denom, Matrix.SpecialLinearGroup.mapGL]
  · rw [coe_specialLinearGroup_apply]
    simp

/-- **TDUAL-M2 pin 2/5.**  `γ = T`, `τ = i`: both instance paths give `1+i`.  Catches a transposed
matrix (`(1+i)/2`) and a `b`-entry sign flip (`-1+i`). -/
theorem mapGL_sl_pin_T_i :
    ((Matrix.SpecialLinearGroup.mapGL ℝ pinGammaT • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = 1 + Complex.I ∧
      ((pinGammaT • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = 1 + Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [coe_smul_of_det_pos (by simp)]
    simp [num, denom, pinGammaT, Matrix.SpecialLinearGroup.mapGL]
    ring
  · rw [coe_specialLinearGroup_apply]
    simp [pinGammaT]
    ring

/-- **TDUAL-M2 pin 3/5.**  `γ = S`, `τ = 1+i`: both instance paths give `(-1+i)/2`.  The only pin
with a nonzero real part on both sides; catches a `b`-entry sign flip (`(1-i)/2`).  Does **not**
catch a transpose, which at `S` is the same Möbius map. -/
theorem mapGL_sl_pin_S_onePlusI :
    ((Matrix.SpecialLinearGroup.mapGL ℝ pinGammaS • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (-1 + Complex.I) / 2 ∧
      ((pinGammaS • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (-1 + Complex.I) / 2 := by
  refine ⟨?_, ?_⟩
  · rw [coe_smul_of_det_pos (by simp)]
    simp only [num, denom, pinGammaS, Matrix.SpecialLinearGroup.mapGL]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaS]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

/-- **TDUAL-M2 pin 4/5.**  `γ = !![1,0;2,1] ∈ Γ₀(2)`, `τ = i`: both instance paths give `(2+i)/5`.
The `Γ₀(2)` membership is part of the statement, so this pin is inside the bridge's own subgroup.
Catches a transpose (`2+i`); does **not** catch a `b`-flip, since `b = 0` here. -/
theorem mapGL_sl_pin_G0two_lower_i :
    pinGammaL2 ∈ Gamma0 2 ∧
      ((Matrix.SpecialLinearGroup.mapGL ℝ pinGammaL2 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (2 + Complex.I) / 5 ∧
      ((pinGammaL2 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (2 + Complex.I) / 5 := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Gamma0_mem, pinGammaL2]
    decide
  · rw [coe_smul_of_det_pos (by simp)]
    simp only [num, denom, pinGammaL2, Matrix.SpecialLinearGroup.mapGL]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaL2]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

/-- **TDUAL-M2 pin 5/5.**  `γ = !![3,1;2,1] ∈ Γ₀(2)`, `τ = i`: both instance paths give `(7+i)/5`.
The only pin with all four entries nonzero, so the only one that constrains every entry at once;
catches a transpose (`(5+i)/2`) and a `b`-flip (`1+i`). -/
theorem mapGL_sl_pin_G0two_i :
    pinGammaG2 ∈ Gamma0 2 ∧
      ((Matrix.SpecialLinearGroup.mapGL ℝ pinGammaG2 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (7 + Complex.I) / 5 ∧
      ((pinGammaG2 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (7 + Complex.I) / 5 := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Gamma0_mem, pinGammaG2]
    decide
  · rw [coe_smul_of_det_pos (by simp)]
    simp only [num, denom, pinGammaG2, Matrix.SpecialLinearGroup.mapGL]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaG2]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

/-- **TDUAL-M2.**  The group that `frickeW` normalizes (the `mapGL`-image of `Γ₀(N)` in `GL(2,ℝ)`,
the subject of `frickeW_normalizes_Gamma0` / FRK-07) and the group that acts on `ℍ` by Mathlib's
`SL(2,ℤ)` modular action are acting by the **same** action.  Mathlib defines `SLAction` as
`MulAction.compHom ℍ (SpecialLinearGroup.mapGL ℝ)`
(`Analysis/Complex/UpperHalfPlane/MoebiusAction.lean:283-284`), so this is definitional:
`(MulAction.compHom_smul_def _ _ _).symm` proves it, and `rfl` suffices.

This is the hinge: without it, "the group `W_N` normalizes" and "the group GPR says acts by
fractional linear transformations" are two different Lean objects and the bridge is a pun.

**Scope honesty (recorded so it is not overstated downstream).**  This lemma has *no* mathematical
content — it is definitional unfolding, and it mentions neither `frickeW` nor `Γ₀(N)`.  It does not
reduce to anything of ours; it reduces to Mathlib's `SLAction` definition.  What it supplies to the
bridge is the *anti-pun* check and nothing else, and it must not be presented anywhere as evidence
that the bridge has substance.  Its load-bearing consequence for FRK-07 is
`exists_sl_smul_eq_of_mem_map_Gamma0` immediately below; the substantive content of the bridge sits
in `TDUAL-M1` and `TDUAL-M3`.

Because the proof is `rfl`, there is no wrong-right-hand-side variant whose failure could certify
that a tactic block did work — the tactic does nothing.  The discrimination evidence is instead the
five pins above and the instance readout recorded in their preamble.

**Instance pinning (do not "clean up").**  The `Algebra ℤ ℝ` instance elaboration selects is
`Ring.toIntAlgebra ℝ`.  The statement is deliberately left instance-implicit; restating it with an
explicit `Algebra ℤ ℝ` argument would in general produce a different instance term that `rfl` does
not close. -/
theorem mapGL_smul_eq_sl_smul (γ : SL(2, ℤ)) (τ : ℍ) :
    Matrix.SpecialLinearGroup.mapGL ℝ γ • τ = γ • τ := rfl

/-- **TDUAL-M2, the FRK-07 consequence.**  `frickeW_normalizes_Gamma0` (FRK-07) is stated on
`(Gamma0 N).map (Matrix.SpecialLinearGroup.mapGL ℝ)` *inside* `GL(2,ℝ)`
(`FrickeInvolution.lean:117-119`).  This lemma is what makes that group's action on `ℍ` be Mathlib's
`SL(2,ℤ)` action, which is the only thing `TDUAL-M2` is needed for. -/
theorem exists_sl_smul_eq_of_mem_map_Gamma0 {N : ℕ} (τ : ℍ) {g : GL (Fin 2) ℝ}
    (hg : g ∈ (Gamma0 N).map (Matrix.SpecialLinearGroup.mapGL ℝ)) :
    ∃ γ ∈ Gamma0 N, g • τ = γ • τ := by
  obtain ⟨γ, hγ, rfl⟩ := hg
  exact ⟨γ, hγ, mapGL_smul_eq_sl_smul γ τ⟩

/-! ### TDUAL-M3's gate — five fractional-linear pins

`TDUAL-M3` says Mathlib's `SL(2,ℤ)`-action is `(aτ+b)/(cτ+d)` with the entries read off `γ.1` in
the positions `0 0, 0 1, 1 0, 1 1`.  The thing that can silently go wrong in such a statement is not
the arithmetic — it is the *entry-position assignment*: a transpose, an `a`/`d` swap, or a sign on
`b` or `c` produces a statement that is still well-typed, still an equality in `ℂ`, and still true
for symmetric matrices.  So the gate is stated on matrices chosen to break those symmetries.

Each pin asserts, as two separate conjuncts against one value `V`, that

* the Mathlib action `γ • τ` has coordinate `V`, and
* the `TDUAL-M3` right-hand side, *with its entries read through the same `γ.1 i j` projections the
  theorem uses*, equals `V`.

Every `V` was computed first, from `(aτ+b)/(cτ+d)`, in exact Gaussian-rational arithmetic (python
`fractions`, this session), and only then written as a Lean statement.

| pin | `γ` | `τ` | `(aτ+b)/(cτ+d)` |
| --- | --- | --- | --- |
| `sl_flt_pin_2111_i`      | `!![2,1;1,1]`  | `i`   | `(3+i)/2`      |
| `sl_flt_pin_Tsq_i`       | `!![1,2;0,1]`  | `i`   | `2+i`          |
| `sl_flt_pin_L3_i`        | `!![1,0;3,1]`  | `i`   | `(3+i)/10`     |
| `sl_flt_pin_G5_i`        | `!![7,2;10,3]` | `i`   | `(76+i)/109`   |
| `sl_flt_pin_negB_twoI`   | `!![1,-1;1,0]` | `2i`  | `(2+i)/2`      |

Which variant each pin actually discriminates was recomputed variant-by-variant in the same exact
arithmetic rather than assumed, and the honest negative results are recorded:

* a **transpose** (`b ↔ c`) is caught at `Tsq` (`(2+i)/5`), `L3` (`3+i`), `G5` (`(44+i)/13`) and
  `negB` (`(-2+i)/2`).  It is **not** caught at the `2111` pin, whose `b` and `c` entries are both
  `1`, so transposing it is the identity.
* an **`a`/`d` swap** is caught at `2111` (`(3+i)/5`), `G5` (`(44+i)/149`) and `negB` (`(-1+2i)/5`).
  It is **not** caught at `Tsq` or `L3`, both of which have `a = d = 1`.
* a **`b`-entry sign flip** is caught at `2111` (`(1+3i)/2`), `Tsq` (`-2+i`), `G5` (`(64+41i)/109`)
  and `negB` (`(2-i)/2`).  It is **not** caught at `L3`, whose `b` entry is already `0`.
* a **`c`-entry sign flip** is caught at `2111` (`(-1+3i)/2`), `L3` (`(-3+i)/10`),
  `G5` (`(-64+41i)/109`) and `negB` (`(-2-i)/2`).  It is **not** caught at `Tsq`, whose `c` entry is
  already `0`.
* an **inverted action convention** (`γ⁻¹` in place of `γ`) is caught by **all five**.  This is a
  real difference from the `TDUAL-M0` gate, where the same variant is *provably* invisible to every
  pin because `W_N² = -N·I` is a scalar and scalars act trivially on `ℍ`; here `γ ≠ γ⁻¹` for each
  pin matrix and the inverse values differ (`(-3+i)/5`, `-2+i`, `(-3+i)/10`, `(-44+i)/149`,
  `(1+2i)/5`).

`sl_flt_pin_G5_i` is the only pin that catches **all five** variants: it is the only one with all
four entries nonzero and pairwise distinct, and it lies in `Γ₀(5)` (and in `Γ₀(2)`), so it is inside
the kind of subgroup the bridge restricts to.  `sl_flt_pin_L3_i` is likewise stated with its
`Γ₀(3)` membership as part of the statement.

The discrimination is enforced, not asserted: `verification/TDualM3PinNegControl.lean` restates all
five pins with the variant right-hand sides above under the *identical* tactic blocks and must fail
with exactly ten `error:` lines (two per pin — the `Γ₀` membership conjuncts stay correct and stay
proved).  The pins were discharged, and that file confirmed to fail with exactly ten, **before**
`sl_smul_coe_eq_flt` was proved. -/

/-- `!![2,1;1,1]`.  Symmetric off-diagonal (`b = c = 1`), so it cannot see a transpose, but its
`a ≠ d` is what catches an `a`/`d` swap.  Pin matrix only. -/
def pinGamma2111 : SL(2, ℤ) := ⟨!![2, 1; 1, 1], by norm_num [Matrix.det_fin_two_of]⟩

/-- `T² = !![1,2;0,1]`.  `c = 0`, so it cannot see a `c`-sign flip; its `b = 2` is what separates
the `b` position from the `c` position under a transpose.  Pin matrix only. -/
def pinGammaTsq : SL(2, ℤ) := ⟨!![1, 2; 0, 1], by norm_num [Matrix.det_fin_two_of]⟩

/-- `!![1,0;3,1] ∈ Γ₀(3)`.  The mirror of `pinGammaTsq`: `b = 0`, so it cannot see a `b`-sign flip,
but it pins the `c` position. -/
def pinGammaL3 : SL(2, ℤ) := ⟨!![1, 0; 3, 1], by norm_num [Matrix.det_fin_two_of]⟩

/-- `!![7,2;10,3] ∈ Γ₀(5)`.  All four entries nonzero and pairwise distinct — the only pin that
constrains every position at once, and the only one that catches all five variants. -/
def pinGammaG5 : SL(2, ℤ) := ⟨!![7, 2; 10, 3], by norm_num [Matrix.det_fin_two_of]⟩

/-- `!![1,-1;1,0]`, evaluated at `τ = 2i`.  The only pin with a **negative** entry and the only one
at a point other than `i`, so it is what catches an error that is invisible at `τ = i` or that
depends on the sign of an entry rather than its position. -/
def pinGammaNegB : SL(2, ℤ) := ⟨!![1, -1; 1, 0], by norm_num [Matrix.det_fin_two_of]⟩

/-- **TDUAL-M3 pin 1/5.**  `γ = !![2,1;1,1]`, `τ = i`: action and formula both give `(3+i)/2`.
Catches an `a`/`d` swap, a `b`-flip and a `c`-flip; blind to a transpose (`b = c` here). -/
theorem sl_flt_pin_2111_i :
    ((pinGamma2111 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (3 + Complex.I) / 2 ∧
      (((pinGamma2111.1 0 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGamma2111.1 0 1 : ℤ) : ℂ)) /
        (((pinGamma2111.1 1 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGamma2111.1 1 1 : ℤ) : ℂ))
        = (3 + Complex.I) / 2 := by
  refine ⟨?_, ?_⟩
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGamma2111]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · simp only [pinGamma2111]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

/-- **TDUAL-M3 pin 2/5.**  `γ = T² = !![1,2;0,1]`, `τ = i`: both give `2+i`.  Catches a transpose
(`(2+i)/5`) and a `b`-flip (`-2+i`); blind to a `c`-flip (`c = 0`) and to an `a`/`d` swap
(`a = d`). -/
theorem sl_flt_pin_Tsq_i :
    ((pinGammaTsq • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = 2 + Complex.I ∧
      (((pinGammaTsq.1 0 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaTsq.1 0 1 : ℤ) : ℂ)) /
        (((pinGammaTsq.1 1 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaTsq.1 1 1 : ℤ) : ℂ))
        = 2 + Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaTsq]
    rw [div_eq_iff (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
  · simp only [pinGammaTsq]
    rw [div_eq_iff (by norm_num)]
    ring_nf
    simp [Complex.I_sq]

/-- **TDUAL-M3 pin 3/5.**  `γ = !![1,0;3,1] ∈ Γ₀(3)`, `τ = i`: both give `(3+i)/10`.  The `Γ₀(3)`
membership is part of the statement.  Catches a transpose (`3+i`) and a `c`-flip (`(-3+i)/10`);
blind to a `b`-flip (`b = 0`) and to an `a`/`d` swap (`a = d`). -/
theorem sl_flt_pin_L3_i :
    pinGammaL3 ∈ Gamma0 3 ∧
      ((pinGammaL3 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (3 + Complex.I) / 10 ∧
      (((pinGammaL3.1 0 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaL3.1 0 1 : ℤ) : ℂ)) /
        (((pinGammaL3.1 1 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaL3.1 1 1 : ℤ) : ℂ))
        = (3 + Complex.I) / 10 := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Gamma0_mem, pinGammaL3]
    decide
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaL3]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · simp only [pinGammaL3]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

/-- **TDUAL-M3 pin 4/5.**  `γ = !![7,2;10,3] ∈ Γ₀(5)`, `τ = i`: both give `(76+i)/109`.  The only
pin with all four entries nonzero and pairwise distinct, hence the only one that catches **every**
variant: transpose `(44+i)/13`, `a`/`d` swap `(44+i)/149`, `b`-flip `(64+41i)/109`, `c`-flip
`(-64+41i)/109`, inverse `(-44+i)/149`. -/
theorem sl_flt_pin_G5_i :
    pinGammaG5 ∈ Gamma0 5 ∧
      ((pinGammaG5 • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (76 + Complex.I) / 109 ∧
      (((pinGammaG5.1 0 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaG5.1 0 1 : ℤ) : ℂ)) /
        (((pinGammaG5.1 1 0 : ℤ) : ℂ) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaG5.1 1 1 : ℤ) : ℂ))
        = (76 + Complex.I) / 109 := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Gamma0_mem, pinGammaG5]
    decide
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaG5]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · simp only [pinGammaG5]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring

/-- **TDUAL-M3 pin 5/5.**  `γ = !![1,-1;1,0]`, `τ = 2i`: both give `(2+i)/2`.  The only pin with a
negative entry and the only one evaluated away from `i`, so it is what catches an error invisible on
the point `τ = i`.  Catches all of transpose `(-2+i)/2`, `a`/`d` swap `(-1+2i)/5`, `b`-flip
`(2-i)/2`, `c`-flip `(-2-i)/2`. -/
theorem sl_flt_pin_negB_twoI :
    ((pinGammaNegB • (⟨2 * Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = (2 + Complex.I) / 2 ∧
      (((pinGammaNegB.1 0 0 : ℤ) : ℂ) * ((⟨2 * Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaNegB.1 0 1 : ℤ) : ℂ)) /
        (((pinGammaNegB.1 1 0 : ℤ) : ℂ) * ((⟨2 * Complex.I, by simp⟩ : ℍ) : ℂ) +
          ((pinGammaNegB.1 1 1 : ℤ) : ℂ))
        = (2 + Complex.I) / 2 := by
  refine ⟨?_, ?_⟩
  · rw [coe_specialLinearGroup_apply]
    simp only [pinGammaNegB]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
  · simp only [pinGammaNegB]
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]

/-- **TDUAL-M3.**  Mathlib's `SL(2,ℤ)`-action on `ℍ` is given by exactly the fractional-linear
formula `(aτ+b)/(cτ+d)`, with integer-cast entries — i.e. it is the `SL(2,ℤ)_τ` action on the
`T²` complex-structure modulus whose generators GPR eq. (2.4.57) displays
(`S : τ ↦ -1/τ`, `T : τ ↦ τ+1`).

**Citation precision (LL-25).**  GPR (2.4.57) does *not* display the scalar formula
`(aτ+b)/(cτ+d)`; it displays the four generators `S, T, S', T'`.  The general fractional-linear
`τ`-action is what the surrounding prose of §2.4 presupposes ("`SL(2,ℤ)` is generated by two
elements"), and it is standard; but attributing the displayed scalar formula to that equation number
would be an overclaim, so this file does not.  A grep of the full `pdftotext` extraction for
`cτ + d`, `aτ + b` and `fractional linear` returns 12 hits, none of them a scalar
`(aτ+b)/(cτ+d)`: GPR's displayed fractional-linear transformations, at (2.4.13), (2.4.24) and
(4.2.30), are the *matrix* action on the background `E`, not the scalar action on `τ`.

Stated for **all** of `SL(2,ℤ)` — formalising more than the cited display, which is the harmless
direction.  The `Γ₀(N)` restriction that the bridge imposes is then definitional — restricting a
group action to a subgroup cannot change the Möbius formula — and saying so is part of the honest
claim: `Γ₀(N)` is where `frickeW` lives, not where the physics formula changes.

**Scope, so this node is not misread as the bridge.**  `sl_smul_coe_eq_flt` mentions neither
`frickeW` nor `Γ₀(N)`; it is the `SL(2,ℤ)`/GPR half only.  `frickeW` enters through `TDUAL-M1`
(`frickeW_smul_coe`) and `TDUAL-M2` (`mapGL_smul_eq_sl_smul`), and the Fricke reduction itself lives
in `TDUAL-01`. -/
theorem sl_smul_coe_eq_flt (γ : SL(2, ℤ)) (τ : ℍ) :
    ((γ • τ : ℍ) : ℂ)
      = (((γ.1 0 0 : ℤ) : ℂ) * (τ : ℂ) + ((γ.1 0 1 : ℤ) : ℂ)) /
        (((γ.1 1 0 : ℤ) : ℂ) * (τ : ℂ) + ((γ.1 1 1 : ℤ) : ℂ)) := by
  -- Mathlib's own statement at `R = ℤ` (`MoebiusAction.lean:286`), then the cast route
  -- `ℤ → ℝ → ℂ` collapsed to `ℤ → ℂ`: `algebraMap ℤ ℝ = Int.castRingHom ℝ` (`Algebra ℤ` is a
  -- subsingleton), so `eq_intCast` turns every `algebraMap` application into an `Int.cast`.
  rw [coe_specialLinearGroup_apply]
  simp only [algebraMap_int_eq, eq_intCast]
  push_cast
  ring

/-! ### TDUAL-M4 — the duality squares to the identity on the moduli

#### The two-step gate (decide-pins first, LL-1)

Five independently computed instances of `W_N • W_N • τ = τ`, each stated as a *pair*: the
intermediate value `W_N • τ` and the round trip `W_N • W_N • τ`.  All five values were computed
first in exact Gaussian-rational arithmetic from `τ ↦ -1/(Nτ)` (python `fractions`, 2026-09-08) and
only then written as Lean statements.

| pin | `N` | `τ` | `W_N • τ` | `W_N • W_N • τ` |
| --- | --- | --- | --- | --- |
| 1 | 2 | `i`   | `i/2`      | `i`   |
| 2 | 3 | `2i`  | `i/6`      | `2i`  |
| 3 | 1 | `1+i` | `(-1+i)/2` | `1+i` |
| 4 | 2 | `1+i` | `(-1+i)/4` | `1+i` |
| 5 | 4 | `i`   | `i/4`      | `i`   |

All five points satisfy `W_N • τ ≠ τ`, which is the whole point: the `TDUAL-M0` pins include the
`N = 1` self-dual point `i` and the genuine `N = 4` fixed point `i/2`, where "involution" and
"identity" and "projection" are indistinguishable.  Here they are distinguishable, and the variant
these pins exist to exclude is the *idempotent* reading `W_N • W_N • τ = W_N • τ`.

The pins go through `frickeW_smul_coe` (TDUAL-M1) applied once and twice — deliberately **not**
through `frickeW_sq_smul`, which reaches the same conclusion via the product matrix `W_N * W_N`,
its determinant `N²` and its `denom = -N`.  So the pins and the general proof below are two
independent routes to the same values.  Pin 1's and pin 3's first components are, statement for
statement, `TDUAL-M0`'s `frickeW_pin_N2_i` and `frickeW_pin_N1_onePlusI`, which were proved by a
third route (`coe_smul_of_det_pos` on the raw `frickeMatrix`); they are re-derived here rather than
cited so that all ten components run through one tactic style and the negative control can mirror
it exactly.

Discrimination is enforced, not asserted: `verification/TDualM4PinNegControl.lean` restates all ten
components with wrong values (dropped factor of `N` / flipped `b`-entry on the intermediates, the
idempotent variant on the round trips) under the identical tactic blocks, and fails with exactly ten
`error:` lines — nine `unsolved goals` and one `ring_nf made no progress`.  It was confirmed failing
**before** `frickeW_smul_involutive` was discharged. -/

/-- **TDUAL-M4 two-step pin 1/5.**  `N = 2`, `τ = i`:  `W₂ • i = i/2`, and `W₂ • (i/2) = i`. -/
theorem frickeW_invol_pin_N2_i :
    ((frickeW (N := 2) (by norm_num) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I / 2 ∧
      ((frickeW (N := 2) (by norm_num) • frickeW (N := 2) (by norm_num)
          • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    field_simp
    rw [Complex.I_sq]
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- **TDUAL-M4 two-step pin 2/5.**  `N = 3`, `τ = 2i`:  `W₃ • 2i = i/6`, and `W₃ • (i/6) = 2i`.
The only pin whose intermediate is *not* obtained from `τ` by a power of two, so a stray factor of
`N` in either step is visible here even if it cancels elsewhere. -/
theorem frickeW_invol_pin_N3_twoI :
    ((frickeW (N := 3) (by norm_num) • (⟨2 * Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = Complex.I / 6 ∧
      ((frickeW (N := 3) (by norm_num) • frickeW (N := 3) (by norm_num)
          • (⟨2 * Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = 2 * Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    field_simp
    rw [Complex.I_sq]; ring
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- **TDUAL-M4 two-step pin 3/5.**  `N = 1`, `τ = 1+i`:  `W₁ • (1+i) = (-1+i)/2`, and
`W₁ • ((-1+i)/2) = 1+i`.  The first pin with a nonzero real part on both sides, so it catches an
error invisible on the imaginary axis; its first component is `TDUAL-M0`'s `frickeW_pin_N1_onePlusI`
re-derived through `frickeW_smul_coe`. -/
theorem frickeW_invol_pin_N1_onePlusI :
    ((frickeW (N := 1) (by norm_num) • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (-1 + Complex.I) / 2 ∧
      ((frickeW (N := 1) (by norm_num) • frickeW (N := 1) (by norm_num)
          • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = 1 + Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- **TDUAL-M4 two-step pin 4/5.**  `N = 2`, `τ = 1+i`:  `W₂ • (1+i) = (-1+i)/4`, and
`W₂ • ((-1+i)/4) = 1+i`.  Nonzero real part *and* `N > 1` at once — the intermediate `(-1+i)/4`
differs from pin 3's `(-1+i)/2` by exactly the factor of `N`, so a dropped `N` sends this pin to
pin 3's value and is caught. -/
theorem frickeW_invol_pin_N2_onePlusI :
    ((frickeW (N := 2) (by norm_num) • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
        = (-1 + Complex.I) / 4 ∧
      ((frickeW (N := 2) (by norm_num) • frickeW (N := 2) (by norm_num)
          • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = 1 + Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
    ring_nf
    simp [Complex.I_sq]
    ring
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- **TDUAL-M4 two-step pin 5/5.**  `N = 4`, `τ = i`:  `W₄ • i = i/4`, and `W₄ • (i/4) = i`.
The complement of `TDUAL-M0` pin 3, which sits at `W₄`'s *fixed* point `i/2`: at `i` the level-4
map genuinely moves the point, so the round trip is a real two-step check rather than two copies of
a fixed-point identity. -/
theorem frickeW_invol_pin_N4_i :
    ((frickeW (N := 4) (by norm_num) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I / 4 ∧
      ((frickeW (N := 4) (by norm_num) • frickeW (N := 4) (by norm_num)
          • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I := by
  refine ⟨?_, ?_⟩
  · rw [frickeW_smul_coe]
    push_cast
    field_simp
    rw [Complex.I_sq]
  · rw [frickeW_smul_coe, frickeW_smul_coe]
    push_cast
    field_simp

/-- **TDUAL-M4.**  The ℍ-level involution `frickeW_sq_smul` (FRK-10's file-sibling, proved
sorry-free in `FrickeComposite.lean`), written in the associated form `W_N • W_N • τ = τ`:
for every `N > 0` and every `τ ∈ ℍ`, applying the Fricke map twice returns `τ`.

**This node has zero mathematical content, and is recorded as such.**  `frickeW_sq_smul` already
states `(W_N * W_N) • τ = τ` at the level of `ℍ`; the *only* thing added here is Mathlib's
`mul_smul : (g₁ * g₂) • p = g₁ • g₂ • p`, an axiom of `MulAction`.  In particular the matrix→`ℍ`
upgrade — the step that actually uses `W_N² = -N·I` (`frickeW_sq_coe`, FRK-02) together with
`det (W_N²) = N² > 0` and `denom (W_N²) = -N` — was done in `FrickeComposite.lean`, **not** here.
FRK-02 enters this node only transitively, through `frickeW_sq_smul`'s own proof.  This is the same
situation as `TDUAL-M2`'s `rfl`, and gets the same plain sentence rather than a promotion.

*Physics gloss, subordinate and uncited*: read informally this is "the duality squares to the
identity on the moduli".  `TDUAL-M4` asserts nothing about physics — it is an identity for a
Möbius action on `ℍ` — and `TDUAL-01`'s recorded obstruction (A) is precisely that the stringy
Buscher generator acts on the Kähler modulus `ρ`, not on `τ`.  No literature is invoked here, which
is the correct citation discipline for a mathematics node.

*Discrimination*: see the five two-step pins above and `verification/TDualM4PinNegControl.lean`.  A
wrong-right-hand-side control on *this* statement would certify nothing, because the proof is
`exact` of an existing lemma; that is stated rather than papered over. -/
theorem frickeW_smul_involutive {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    frickeW hN • frickeW hN • τ = τ := by
  -- `mul_smul` re-associates; `frickeW_sq_smul` is the whole of the mathematics, and is proved
  -- sorry-free in `FrickeComposite.lean`.
  rw [← mul_smul]
  exact frickeW_sq_smul hN τ

/-! ### TDUAL-01 — the bridge -/

/-- **TDUAL-01. THE BRIDGE.**  T-duality's action on the `T²` complex-structure modulus — GPR,
Phys. Rept. 244 (1994) §2.4, eqs. (2.4.57)–(2.4.58): `SL(2,ℤ)_τ` acting by fractional linear
transformations, spectrum-preserving, and conjugate to the stringy `SL(2,ℤ)_ρ` by factorized
duality `D₂` (2.4.59) — restricted to `Γ₀(N)` and extended by the level-`N` Fricke normalization
`τ ↦ -1/(Nτ)`, **coincides**, pointwise in `ℂ`, for every `τ ∈ ℍ` and every `N > 0`, with the
already-proven `frickeW` action on `UpperHalfPlane`.

`frickeW` normalizes exactly that `Γ₀(N)` action (`frickeW_normalizes_Gamma0`, FRK-07, proved) and
is an involution of `ℍ` (`frickeW_smul_involutive`, TDUAL-M4), so the group generated is
`Γ₀(N)⟨W_N⟩` acting on `ℍ` — the standard Fricke setting.

**Not claimed here:** that any specific string background realizes `Γ₀(N)⟨W_N⟩` as its *unbroken*
duality group (a CHL-type statement needing its own primary literature), nor anything whatsoever
about the K3 factor, the Narain moduli space, or moonshine.

*Baseline* (what the classical, non-formalized account already gives): GPR (2.4.57) states the
`τ`-action as fractional linear transformations of `SL(2,ℤ)`, and the classical theory of the
Fricke involution `W_N` on `Γ₀(N)` (Atkin–Lehner 1970) states `τ ↦ -1/(Nτ)`.  The bridge asserts
these are the *same map on the same object*; a baseline reader who believes both classical facts
should predict exactly the identity below.

*Falsifier*: any `N > 0` and `τ ∈ ℍ` for which `((frickeW hN • τ : ℍ) : ℂ) ≠ -1/(N·τ)` — e.g. any
one of the four `TDUAL-M0` pins evaluating differently from its independently computed
Gaussian-rational value, which would mean `frickeMatrix` is transposed (pins 2 and 3), has a flipped
`b`-entry (any pin), or has dropped the factor of `N` (pins 2 and 3).  An *inverted* action
convention is deliberately **not** listed: it is unfalsifiable by any pin, because `W_N² = -N·I` is
scalar and `W_N`, `W_N⁻¹` therefore induce the same map on `ℍ`.  Or: a `γ ∈ Γ₀(N)` for which
`mapGL ℝ γ • τ ≠ γ • τ`, which would mean the group `frickeW` normalizes is *not* the group acting
by GPR's formula and the identification is a pun on notation rather than a theorem. -/
theorem tduality_tau_fricke_bridge {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    (((frickeW hN • τ : ℍ) : ℂ) = -1 / ((N : ℂ) * (τ : ℂ))) ∧
      (∀ γ : SL(2, ℤ), γ ∈ Gamma0 N →
        (Matrix.SpecialLinearGroup.mapGL ℝ γ • τ = γ • τ) ∧
          (((γ • τ : ℍ) : ℂ)
            = (((γ.1 0 0 : ℤ) : ℂ) * (τ : ℂ) + ((γ.1 0 1 : ℤ) : ℂ)) /
              (((γ.1 1 0 : ℤ) : ℂ) * (τ : ℂ) + ((γ.1 1 1 : ℤ) : ℂ)))) := by
  -- OPEN: pure assembly once M1/M2/M3 are discharged:
  --   `exact ⟨frickeW_smul_coe hN τ, fun γ _ => ⟨mapGL_smul_eq_sl_smul γ τ, sl_smul_coe_eq_flt γ τ⟩⟩`
  -- The `γ ∈ Gamma0 N` hypothesis is deliberately unused in the *formula*: that the restriction
  -- adds no formula content is part of the claim (see TDUAL-M3).  It is retained in the statement
  -- because the bridge is about the Γ₀(N) subgroup — the one `frickeW` normalizes — and dropping
  -- it would state something true but about the wrong group.
  sorry

end SocrateAI.StringTheory
