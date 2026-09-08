/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.
This file states (statement text only, not proof) one theorem whose signature is a
reproduction of an Apache-2.0 theorem statement from `anthropics/fermats-last-theorem`
(c) 2026 Anthropic, PBC; see the declaration's own docstring and ATTRIBUTION.md.

# The Dedekind `η` multiplier system  (DAG: DRK-05, DRK-06, DRK-07, ETA-01)

The statement layer for the closed form of the `η` multiplier on **all** of `SL(2,ℤ)`, and for
the general-`N` Ligozat criterion that it unlocks.

## READ FIRST — the brief this file was written from was TRUNCATED

The node list handed to this run ends mid-node at

    {"id": "DRK-05", "statement": "theorem logDeriv_eta_smul_eq_logDeriv_csqrt

with no closing brace, no `statement_nl`, no `depends_on` and no `built_from`, and there is no
`DRK-06` in the brief at all even though `DRK-04`'s own `statement_nl` refers to "the arithmetic
engine of DRK-06".  `DRK-05`, `DRK-06` and `DRK-07` below are therefore **RECONSTRUCTED**, not
transcribed.  What is reconstructed, and from what:

* `DRK-05` — the name `logDeriv_eta_smul_eq_logDeriv_csqrt` survives in the brief verbatim; its
  statement is modelled on Mathlib's `ModularForm.logDeriv_eta_comp_eq_logDeriv_csqrt_eta`
  (`Mathlib/NumberTheory/ModularForms/Discriminant.lean:75`), which is exactly this statement for
  `γ = S`, generalised to arbitrary `γ` with `c > 0`.
* `DRK-06` — this one is **not** guesswork about the mathematics, only about the node id: the
  statement is FLT's `ModularForm.eta_specialLinearGroup_smul`
  (`Theorems/Thm_ModularForm_eta_specialLinearGroup_smul.lean`, Apache-2.0, fetched 2026-09-07,
  HTTP 200, 1024 bytes), which the run brief separately and explicitly identifies as
  "OUR OWN SECTION 5 ITEM (3), VERBATIM".  It is reproduced twice below: once in FLT's exact
  inline form (`eta_specialLinearGroup_smul_flt`, for character-by-character comparison against
  upstream) and once through our named `rademacherPhi` (`eta_smul_eq_exp_rademacherPhi`).  The
  two are the same statement because of `rademacherPhi_of_pos_toNat` (DRK-03), which is now
  PROVED; as of 2026-09-08 both DRK-06 forms are PROVED and the second is one `rw` off the first.
* `DRK-07` — the packaging step: the multiplier `ε(γ)` as a named function of `γ` alone.
* `ETA-01` — the run's stated success criterion (Ligozat's criterion at general `N`).  It is
  stated here so that the target is written down; it is OPEN and it is far from the frontier.

## Status  (updated 2026-09-08)

`DRK-05` is **PROVED**, sorry-free, in both halves:
`logDeriv_eta_smul_eq_logDeriv_csqrt` and `exists_eta_smul_const`, each
`#print axioms` = `[propext, Classical.choice, Quot.sound]`.  Twenty-three `norm_num` pins and two
negative controls (twenty-five declarations total) precede them and are proved from Mathlib primitives only.

`DRK-06` is **PROVED 2026-09-08, sorry-free**, in both phrasings:
`eta_smul_eq_exp_rademacherPhi` (through our named `Φ`) and `eta_specialLinearGroup_smul_flt`
(FLT's inline phrasing), each `#print axioms` = `[propext, Classical.choice, Quot.sound]`.
Sixteen pins and three negative controls precede them; every `Φ` pin is a `decide +kernel`
evaluation of the definitions.  **Statement from FLT, proof independent (ADAPTED, not ported).**

SCOPE, LOUDLY (LL-1): DRK-06 is proved for `0 < c` **only** — that is FLT's own scope, so it is
not a weakening of the reference, but it is **not** the full `η` transformation law on all of
`SL(2,ℤ)`.  `c = 0` is `eta_add_int` + `rademacherPhi_T_zpow`; `c < 0` reduces by `γ ↦ -γ`
(`rademacherPhi_neg`) and is **not** written down here.  `ETA-01` needs both and therefore is
**not** unblocked by DRK-06 alone.

`DRK-07` and `ETA-01` are **still open** and still `sorry`.  Read the honesty note on
`exists_eta_smul_const` before quoting DRK-05 anywhere: DRK-05 is the **analytic half** — it says
the multiplier is a constant, not what the constant *is*.  It is strictly weaker than
`eta_specialLinearGroup_smul_flt` and it is **not used** by the DRK-06 proof, which produces the
constant and its value together by strong induction on `c`.

## Provenance

`eta_specialLinearGroup_smul_flt` is **statement-only from FLT**; upstream's proof is `p2m_exact_reverting @P2MW.S_ModularForm_eta_specialLinearGroup_smul`
(the solution file is 9054 bytes in `P2M/Sol/`), that tactic does not exist in this library, and
that solution file was never read.  Everything else is our own phrasing, and **every proof in
this file is INDEPENDENT**: the two DRK-05 declarations (FLT has no counterpart to DRK-05(a) at
all) and the whole DRK-06 descent (`eta_smul_of_c_eq_one`, `eta_smul_descent_step`,
`eta_smul_strong_induction`, and the `csqrt` branch algebra they rest on).  `ATTRIBUTION.md`
records the distinction per declaration.

## The route we intend, and why it is not FLT's

`MATHLIB_PR.md` recommends deriving `Φ` as the **period of `E2`**, using Mathlib's existing
`E2_slash_action` machinery
(`Mathlib/NumberTheory/ModularForms/EisensteinSeries/E2/`), rather than FLT's closed-form-first
route.  `DRK-05` is phrased to sit on that route: it is the `logDeriv` identity, which is where
`E2_slash_action` enters, and Mathlib's `S`-case proof of it
(`logDeriv_eta_comp_eq_logDeriv_csqrt_eta`) already uses `E2_slash_action ModularGroup.S`
literally.  The general-`γ` case is **not** literally the same proof with `ModularGroup.S`
replaced by `γ` — Mathlib's `S`-case proof leans on `ModularGroup.denom_S : denom S z = z` and on
the bare `sqrt`, neither of which survives.  What does survive is the shape, and DRK-05(a) is now
proved on it: `logDeriv_eta_eq_E2` on both `z` and `γz`, `E2_slash_action γ` for the weight-2
defect `D2 γ z = 2πi·c/denom`, and `Complex.deriv_sqrt` for the `√` side.  The two sides meet at
`+c/(2(cz+d))`, and the `+` is `i² = -1` acting on the *subtracted* defect.  That route is
genuinely ours and is closer to what a Mathlib PR needs.

## What this file does NOT do

It does not close `F3.2-OBSTRUCTED`, and DRK-06 being proved does **not** by itself close it.
DRK-06 gives the multiplier's value for `γ ∈ SL(2,ℤ)` with `c > 0`.  Turning that into Ligozat
at general `N` still needs, all of which are OPEN here: (i) the `c ≤ 0` cases (`c = 0` from
`eta_add_int`/`rademacherPhi_T_zpow`, `c < 0` from `rademacherPhi_neg`), (ii) the multiplier of
`η(δz)` rather than `η(z)`, i.e. the conjugated matrix `γ_δ` for each `δ ∣ N`, and (iii) the
product `∏_δ ε(γ_δ)^{r_δ} = 1` under Ligozat's congruences, which is `DRK-07`'s cocycle plus a
counting argument.  The four-level (`N ≤ 4`) and prime-level (`N ∈ {5,7,13}`) results in
`EtaQuotientModularity.lean` / `EtaQuotientPrimeLevel.lean` therefore remain the only Ligozat
statements in this library that are actually proved, and `ligozat_general` is still `sorry`.
-/
import SocrateAI.NumberTheory.RademacherPhi
import SocrateAI.ModularForms.EtaQuotientModularity

set_option autoImplicit false

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm Complex
open UpperHalfPlane hiding I
open scoped MatrixGroups Real
open SocrateAI.NumberTheory

/-! ## DRK-05 — the `logDeriv` identity for a general `γ`  (PROVED 2026-09-08) -/

/-! ### The sign gate: `norm_num` pins, and they come first

**Nothing above this gate is used to prove anything in it, and nothing in it uses `mobiusC`, the
auxiliary lemmas, or either DRK-05 theorem.**  Each pin is discharged from Mathlib primitives
(`Complex.I_sq`, `field_simp`, `norm_num`) alone, so a pin cannot be satisfied by the very
argument it exists to check.

Every right-hand side below was computed **independently, before any Lean proof of this node
existed**: once numerically in `mpmath` at 50 decimal digits, and once exactly in Python
`fractions.Fraction`.  The two agree to the last printed digit.  The same sweep also checked the
full DRK-05(a) identity numerically at 16 `(γ, z)` pairs
(`γ = [2,1;3,2], [1,0;1,1], [3,2;4,3], [0,-1;1,0], [5,2;12,5], [2,-1;5,-2], [7,3;16,7],
[1,-1;2,-1]` at `z = 0.31 + 1.7i` and `z = -0.42 + 2.3i`), against the closed form
`logDeriv η z + c/(2(cz+d))`; agreement was `≤ 3e-51` except at `c = 12, 16`, where the residual
is `η`-product truncation at `γz` (`Im(γz)` small), the same effect the DRK-05 comparator
already recorded.

**What each family would catch.**

* `drk05_pin_slit_*` — `Re(-i(cz+d)) = c·Im z`.  This is the *only* place `hc : 0 < c` enters the
  proof: it is what puts `-i(cz+d)` in the open right half plane, hence in `Complex.slitPlane`,
  where the principal `Complex.sqrt` is holomorphic and non-vanishing.  Writing `+i` instead of
  `-i`, or dropping `hc`, flips the sign of every one of these.
* `drk05_pin_defect_*` — the `E2` defect constant.  `E2_slash_action` *subtracts*
  `(1/(2ζ(2)))·D2 γ`, and `(πi/12)` times that subtracted term is `-c/(2(cz+d))`, so the defect
  *adds* `+c/(2(cz+d))` — which is exactly what the `√` side contributes.  A wrong `12`, a wrong
  `ζ(2) = π²/6`, or a flipped `i²` makes all seven fail.  LL-22 note: no Dedekind sum, no `Φ` and
  no `Ψ` appears anywhere in DRK-05, so the `Φ`/`Ψ` confusion cannot enter this node.
-/

/-- Pin: `Re(-i(cz+d)) = c·Im z`, here `c = 3`, `d = 2`. -/
theorem drk05_pin_slit_c3d2 :
    (-Complex.I * ((3 : ℂ) * (1/3 + 2*Complex.I) + (2 : ℂ))).re = 6 := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: the same value is positive — this is the `slitPlane` membership `hc` buys. -/
theorem drk05_pin_slit_pos_c3d2 :
    0 < (-Complex.I * ((3 : ℂ) * (1/3 + 2*Complex.I) + (2 : ℂ))).re := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: `Re(-i(cz+d)) = c·Im z`, here `c = 1`, `d = 1`. -/
theorem drk05_pin_slit_c1d1 :
    (-Complex.I * ((1 : ℂ) * (1/3 + 2*Complex.I) + (1 : ℂ))).re = 2 := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: the same value is positive — this is the `slitPlane` membership `hc` buys. -/
theorem drk05_pin_slit_pos_c1d1 :
    0 < (-Complex.I * ((1 : ℂ) * (1/3 + 2*Complex.I) + (1 : ℂ))).re := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: `Re(-i(cz+d)) = c·Im z`, here `c = 4`, `d = 3`. -/
theorem drk05_pin_slit_c4d3 :
    (-Complex.I * ((4 : ℂ) * (1/3 + 2*Complex.I) + (3 : ℂ))).re = 8 := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: the same value is positive — this is the `slitPlane` membership `hc` buys. -/
theorem drk05_pin_slit_pos_c4d3 :
    0 < (-Complex.I * ((4 : ℂ) * (1/3 + 2*Complex.I) + (3 : ℂ))).re := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: `Re(-i(cz+d)) = c·Im z`, here `c = 12`, `d = 5`. -/
theorem drk05_pin_slit_c12d5 :
    (-Complex.I * ((12 : ℂ) * (1/3 + 2*Complex.I) + (5 : ℂ))).re = 24 := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: the same value is positive — this is the `slitPlane` membership `hc` buys. -/
theorem drk05_pin_slit_pos_c12d5 :
    0 < (-Complex.I * ((12 : ℂ) * (1/3 + 2*Complex.I) + (5 : ℂ))).re := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: `Re(-i(cz+d)) = c·Im z`, here `c = 5`, `d = (-2)`. -/
theorem drk05_pin_slit_c5dm2 :
    (-Complex.I * ((5 : ℂ) * (1/3 + 2*Complex.I) + ((-2) : ℂ))).re = 10 := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: the same value is positive — this is the `slitPlane` membership `hc` buys. -/
theorem drk05_pin_slit_pos_c5dm2 :
    0 < (-Complex.I * ((5 : ℂ) * (1/3 + 2*Complex.I) + ((-2) : ℂ))).re := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: `Re(-i(cz+d)) = c·Im z`, here `c = 16`, `d = 7`. -/
theorem drk05_pin_slit_c16d7 :
    (-Complex.I * ((16 : ℂ) * (1/3 + 2*Complex.I) + (7 : ℂ))).re = 32 := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: the same value is positive — this is the `slitPlane` membership `hc` buys. -/
theorem drk05_pin_slit_pos_c16d7 :
    0 < (-Complex.I * ((16 : ℂ) * (1/3 + 2*Complex.I) + (7 : ℂ))).re := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: `Re(-i(cz+d)) = c·Im z`, here `c = 2`, `d = (-1)`. -/
theorem drk05_pin_slit_c2dm1 :
    (-Complex.I * ((2 : ℂ) * (1/3 + 2*Complex.I) + ((-1) : ℂ))).re = 4 := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: the same value is positive — this is the `slitPlane` membership `hc` buys. -/
theorem drk05_pin_slit_pos_c2dm1 :
    0 < (-Complex.I * ((2 : ℂ) * (1/3 + 2*Complex.I) + ((-1) : ℂ))).re := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: `Re(-i(cz+d)) = c·Im z`, here `c = 1`, `d = 0`. -/
theorem drk05_pin_slit_c1d0 :
    (-Complex.I * ((1 : ℂ) * (-2/5 + 3*Complex.I) + (0 : ℂ))).re = 3 := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: the same value is positive — this is the `slitPlane` membership `hc` buys. -/
theorem drk05_pin_slit_pos_c1d0 :
    0 < (-Complex.I * ((1 : ℂ) * (-2/5 + 3*Complex.I) + (0 : ℂ))).re := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- **Negative control.**  For `c < 0` the real part is negative: `hc : 0 < γ 1 0` is
load-bearing, not decoration.  (`γ = [3,-2;-4,3]`, the `c < 0` matrix `RademacherPhi.lean` also
uses as a control.) -/
theorem drk05_neg_control_slit_cneg :
    ¬ (0 < (-Complex.I * ((-4 : ℂ) * (1/3 + 2*Complex.I) + (3 : ℂ))).re) := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- **Negative control.**  With `+i` instead of `-i` the real part is negative even for `c > 0`:
the minus sign inside the radical is load-bearing.  This is the normalisation DRK-05 shares with
FLT's `eta_specialLinearGroup_smul`, and it is *not* Mathlib's bare `sqrt` in the `γ = S` case. -/
theorem drk05_neg_control_plus_I :
    ¬ (0 < (Complex.I * ((3 : ℂ) * (1/3 + 2*Complex.I) + (2 : ℂ))).re) := by
  norm_num [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.div_re, Complex.div_im, Complex.normSq_apply, Complex.ext_iff]

/-- Pin: `(πi/12)·((1/(2ζ(2)))·(2πi·c/w)) = -c/(2w)`, at `c = 3`, `w = (2 + 5*Complex.I)`.
The right-hand side is the independently computed rational value, not the formula. -/
theorem drk05_pin_defect_c3 :
    (Real.pi : ℂ) * Complex.I / 12 *
        ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
          (2 * (Real.pi : ℂ) * Complex.I * (3 : ℂ) / (2 + 5*Complex.I)))
      = -(3/29 : ℂ) + (15/58 : ℂ) * Complex.I := by
  have hpi : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  have hw : ((2 + 5*Complex.I) : ℂ) ≠ 0 := by norm_num [Complex.ext_iff]
  have h : (Real.pi : ℂ) * Complex.I / 12 *
      ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
        (2 * (Real.pi : ℂ) * Complex.I * (3 : ℂ) / (2 + 5*Complex.I)))
      = Complex.I ^ 2 * ((3 : ℂ) / (2 * (2 + 5*Complex.I))) := by
    field_simp
    ring
  rw [h, Complex.I_sq]
  norm_num [Complex.ext_iff, Complex.div_re, Complex.div_im, Complex.normSq_apply]

/-- Pin: `(πi/12)·((1/(2ζ(2)))·(2πi·c/w)) = -c/(2w)`, at `c = 1`, `w = (-1 + 4*Complex.I)`.
The right-hand side is the independently computed rational value, not the formula. -/
theorem drk05_pin_defect_c1 :
    (Real.pi : ℂ) * Complex.I / 12 *
        ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
          (2 * (Real.pi : ℂ) * Complex.I * (1 : ℂ) / (-1 + 4*Complex.I)))
      = (1/34 : ℂ) + (2/17 : ℂ) * Complex.I := by
  have hpi : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  have hw : ((-1 + 4*Complex.I) : ℂ) ≠ 0 := by norm_num [Complex.ext_iff]
  have h : (Real.pi : ℂ) * Complex.I / 12 *
      ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
        (2 * (Real.pi : ℂ) * Complex.I * (1 : ℂ) / (-1 + 4*Complex.I)))
      = Complex.I ^ 2 * ((1 : ℂ) / (2 * (-1 + 4*Complex.I))) := by
    field_simp
    ring
  rw [h, Complex.I_sq]
  norm_num [Complex.ext_iff, Complex.div_re, Complex.div_im, Complex.normSq_apply]

/-- Pin: `(πi/12)·((1/(2ζ(2)))·(2πi·c/w)) = -c/(2w)`, at `c = 12`, `w = (7 - 3*Complex.I)`.
The right-hand side is the independently computed rational value, not the formula. -/
theorem drk05_pin_defect_c12 :
    (Real.pi : ℂ) * Complex.I / 12 *
        ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
          (2 * (Real.pi : ℂ) * Complex.I * (12 : ℂ) / (7 - 3*Complex.I)))
      = -(21/29 : ℂ) - (9/29 : ℂ) * Complex.I := by
  have hpi : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  have hw : ((7 - 3*Complex.I) : ℂ) ≠ 0 := by norm_num [Complex.ext_iff]
  have h : (Real.pi : ℂ) * Complex.I / 12 *
      ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
        (2 * (Real.pi : ℂ) * Complex.I * (12 : ℂ) / (7 - 3*Complex.I)))
      = Complex.I ^ 2 * ((12 : ℂ) / (2 * (7 - 3*Complex.I))) := by
    field_simp
    ring
  rw [h, Complex.I_sq]
  norm_num [Complex.ext_iff, Complex.div_re, Complex.div_im, Complex.normSq_apply]

/-- Pin: `(πi/12)·((1/(2ζ(2)))·(2πi·c/w)) = -c/(2w)`, at `c = 5`, `w = (1/2 + 5/2*Complex.I)`.
The right-hand side is the independently computed rational value, not the formula. -/
theorem drk05_pin_defect_c5 :
    (Real.pi : ℂ) * Complex.I / 12 *
        ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
          (2 * (Real.pi : ℂ) * Complex.I * (5 : ℂ) / (1/2 + 5/2*Complex.I)))
      = -(5/26 : ℂ) + (25/26 : ℂ) * Complex.I := by
  have hpi : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  have hw : ((1/2 + 5/2*Complex.I) : ℂ) ≠ 0 := by norm_num [Complex.ext_iff]
  have h : (Real.pi : ℂ) * Complex.I / 12 *
      ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
        (2 * (Real.pi : ℂ) * Complex.I * (5 : ℂ) / (1/2 + 5/2*Complex.I)))
      = Complex.I ^ 2 * ((5 : ℂ) / (2 * (1/2 + 5/2*Complex.I))) := by
    field_simp
    ring
  rw [h, Complex.I_sq]
  norm_num [Complex.ext_iff, Complex.div_re, Complex.div_im, Complex.normSq_apply]

/-- Pin: `(πi/12)·((1/(2ζ(2)))·(2πi·c/w)) = -c/(2w)`, at `c = 4`, `w = (-6 + Complex.I)`.
The right-hand side is the independently computed rational value, not the formula. -/
theorem drk05_pin_defect_c4 :
    (Real.pi : ℂ) * Complex.I / 12 *
        ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
          (2 * (Real.pi : ℂ) * Complex.I * (4 : ℂ) / (-6 + Complex.I)))
      = (12/37 : ℂ) + (2/37 : ℂ) * Complex.I := by
  have hpi : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  have hw : ((-6 + Complex.I) : ℂ) ≠ 0 := by norm_num [Complex.ext_iff]
  have h : (Real.pi : ℂ) * Complex.I / 12 *
      ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
        (2 * (Real.pi : ℂ) * Complex.I * (4 : ℂ) / (-6 + Complex.I)))
      = Complex.I ^ 2 * ((4 : ℂ) / (2 * (-6 + Complex.I))) := by
    field_simp
    ring
  rw [h, Complex.I_sq]
  norm_num [Complex.ext_iff, Complex.div_re, Complex.div_im, Complex.normSq_apply]

/-- Pin: `(πi/12)·((1/(2ζ(2)))·(2πi·c/w)) = -c/(2w)`, at `c = 16`, `w = (11 + 13*Complex.I)`.
The right-hand side is the independently computed rational value, not the formula. -/
theorem drk05_pin_defect_c16 :
    (Real.pi : ℂ) * Complex.I / 12 *
        ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
          (2 * (Real.pi : ℂ) * Complex.I * (16 : ℂ) / (11 + 13*Complex.I)))
      = -(44/145 : ℂ) + (52/145 : ℂ) * Complex.I := by
  have hpi : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  have hw : ((11 + 13*Complex.I) : ℂ) ≠ 0 := by norm_num [Complex.ext_iff]
  have h : (Real.pi : ℂ) * Complex.I / 12 *
      ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
        (2 * (Real.pi : ℂ) * Complex.I * (16 : ℂ) / (11 + 13*Complex.I)))
      = Complex.I ^ 2 * ((16 : ℂ) / (2 * (11 + 13*Complex.I))) := by
    field_simp
    ring
  rw [h, Complex.I_sq]
  norm_num [Complex.ext_iff, Complex.div_re, Complex.div_im, Complex.normSq_apply]

/-- Pin: `(πi/12)·((1/(2ζ(2)))·(2πi·c/w)) = -c/(2w)`, at `c = 2`, `w = (1 + Complex.I)`.
The right-hand side is the independently computed rational value, not the formula. -/
theorem drk05_pin_defect_c2 :
    (Real.pi : ℂ) * Complex.I / 12 *
        ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
          (2 * (Real.pi : ℂ) * Complex.I * (2 : ℂ) / (1 + Complex.I)))
      = -(1/2 : ℂ) + (1/2 : ℂ) * Complex.I := by
  have hpi : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  have hw : ((1 + Complex.I) : ℂ) ≠ 0 := by norm_num [Complex.ext_iff]
  have h : (Real.pi : ℂ) * Complex.I / 12 *
      ((1 / (2 * ((Real.pi : ℂ) ^ 2 / 6))) *
        (2 * (Real.pi : ℂ) * Complex.I * (2 : ℂ) / (1 + Complex.I)))
      = Complex.I ^ 2 * ((2 : ℂ) / (2 * (1 + Complex.I))) := by
    field_simp
    ring
  rw [h, Complex.I_sq]
  norm_num [Complex.ext_iff, Complex.div_re, Complex.div_im, Complex.normSq_apply]

/-- The Möbius map of `γ` as a self-map of `ℂ` (not of `ℍ`), which is the form `logDeriv` and
Mathlib's `Discriminant.lean` work in: `w ↦ (a w + b)/(c w + d)`.  For `γ = S` this is
`(-1 / ·)`, the map appearing in `logDeriv_eta_comp_eq_logDeriv_csqrt_eta`. -/
noncomputable def mobiusC (γ : SL(2, ℤ)) (w : ℂ) : ℂ :=
  ((γ 0 0 : ℂ) * w + (γ 0 1 : ℂ)) / ((γ 1 0 : ℂ) * w + (γ 1 1 : ℂ))


/-! ### Auxiliary lemmas for DRK-05

All of these are independent derivations against Mathlib; none is ported.  They are kept in a
sub-namespace so they do not shadow anything in `SocrateAI.ModularForms`. -/

namespace DRK05Aux

/-- `logDeriv √ = 1/(2·)` on the slit plane, where the principal `Complex.sqrt` is holomorphic.
Mathlib has `Complex.deriv_sqrt` but no `logDeriv` form; this is that form. -/
lemma logDeriv_csqrt {u : ℂ} (hu : u ∈ Complex.slitPlane) :
    logDeriv Complex.sqrt u = 1 / (2 * u) := by
  have hu0 : u ≠ 0 := Complex.slitPlane_ne_zero hu
  have hsq : Complex.sqrt u * Complex.sqrt u = u := by
    rw [Complex.sqrt, ← Complex.cpow_add _ _ hu0]; norm_num
  have hs0 : Complex.sqrt u ≠ 0 := by
    intro h; rw [h, mul_zero] at hsq; exact hu0 hsq.symm
  have h1 : u ^ (-1/2 : ℂ) = (Complex.sqrt u)⁻¹ := by
    rw [Complex.sqrt, show (-1/2 : ℂ) = -(2⁻¹ : ℂ) by norm_num, Complex.cpow_neg]
  rw [logDeriv_apply, Complex.deriv_sqrt hu, h1]
  conv_rhs => rw [← hsq]
  field_simp

/-- **The sign step, isolated.**  Given the `E2` slash relation in the shape `E2_slash_action`
delivers it, `(πi/12)·E2(γz)/denom²` equals `(πi/12)·E2 z + c/(2·denom)`.  The `+` is the content:
it comes from `i² = -1` cancelling the minus in front of the subtracted defect.  This is what
`drk05_pin_defect_*` pins, at seven independently computed `(c, w)`. -/
lemma defect_algebra (F E D c P : ℂ) (hP : P ≠ 0) (hD : D ≠ 0)
    (h : F * (D ^ 2)⁻¹ = E - (1 / (2 * (P ^ 2 / 6))) * (2 * P * Complex.I * c / D)) :
    P * Complex.I / 12 * F * (1 / D ^ 2) = P * Complex.I / 12 * E + c / (2 * D) := by
  have key : F * P = D * (D * E * P - 6 * Complex.I * c) := by
    field_simp at h; linear_combination h
  have hF : F = D * (D * E * P - 6 * Complex.I * c) / P := by rw [eq_div_iff hP]; exact key
  subst hF
  field_simp
  linear_combination (-12 * c) * Complex.I_sq

lemma denom_eq (γ : SL(2, ℤ)) (z : ℍ) :
    UpperHalfPlane.denom (γ : GL (Fin 2) ℝ) (z : ℂ) = (γ 1 0 : ℂ) * z + (γ 1 1 : ℂ) := by
  rw [ModularGroup.denom_apply]

lemma denom_ne (γ : SL(2, ℤ)) (z : ℍ) : ((γ 1 0 : ℂ) * z + (γ 1 1 : ℂ)) ≠ 0 := by
  rw [← denom_eq γ z]; exact UpperHalfPlane.denom_ne_zero _ z

/-- `mobiusC` is the `ℂ`-valued shadow of the `ℍ`-action. -/
lemma coe_mobiusC (γ : SL(2, ℤ)) (z : ℍ) : mobiusC γ (z : ℂ) = ((γ • z : ℍ) : ℂ) := by
  rw [UpperHalfPlane.coe_specialLinearGroup_apply]
  unfold mobiusC
  simp only [algebraMap_int_eq, eq_intCast]
  push_cast
  ring

lemma mobiusC_mem (γ : SL(2, ℤ)) {x : ℂ} (hx : x ∈ upperHalfPlaneSet) :
    mobiusC γ x ∈ upperHalfPlaneSet := by
  rw [show mobiusC γ x = ((γ • (⟨x, hx⟩ : ℍ) : ℍ) : ℂ) from coe_mobiusC γ ⟨x, hx⟩]
  exact (γ • (⟨x, hx⟩ : ℍ)).2

/-- `d/dz (az+b)/(cz+d) = 1/(cz+d)²` — this is where `det γ = 1` is spent. -/
lemma hasDerivAt_mobiusC (γ : SL(2, ℤ)) (z : ℍ) :
    HasDerivAt (mobiusC γ) (1 / ((γ 1 0 : ℂ) * z + (γ 1 1 : ℂ)) ^ 2) (z : ℂ) := by
  have hden := denom_ne γ z
  have hdet : (γ 0 0 : ℂ) * (γ 1 1 : ℂ) - (γ 0 1 : ℂ) * (γ 1 0 : ℂ) = 1 := by
    have h := Matrix.SpecialLinearGroup.det_coe γ
    rw [Matrix.det_fin_two] at h
    exact_mod_cast congrArg (fun x : ℤ => (x : ℂ)) h
  have hf : HasDerivAt (fun w : ℂ => (γ 0 0 : ℂ) * w + (γ 0 1 : ℂ)) (γ 0 0 : ℂ) (z : ℂ) := by
    simpa using ((hasDerivAt_id (z : ℂ)).const_mul ((γ 0 0 : ℂ))).add_const ((γ 0 1 : ℂ))
  have hg : HasDerivAt (fun w : ℂ => (γ 1 0 : ℂ) * w + (γ 1 1 : ℂ)) (γ 1 0 : ℂ) (z : ℂ) := by
    simpa using ((hasDerivAt_id (z : ℂ)).const_mul ((γ 1 0 : ℂ))).add_const ((γ 1 1 : ℂ))
  have h := hf.div hg hden
  refine h.congr_deriv ?_
  rw [div_eq_div_iff (pow_ne_zero 2 hden) (pow_ne_zero 2 hden)]
  linear_combination ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)) ^ 2 * hdet

/-- **Where `hc : 0 < c` is spent.**  `Re(-i(cx+d)) = c·Im x > 0`, so `-i(cx+d)` lies in the open
right half plane, hence in `Complex.slitPlane`.  Pinned at eight `(c, d)` by
`drk05_pin_slit_*`, with `drk05_neg_control_slit_cneg` and `drk05_neg_control_plus_I` showing both
signs are load-bearing. -/
lemma slit_mem (c d : ℤ) (hc : 0 < c) {x : ℂ} (hx : x ∈ upperHalfPlaneSet) :
    (-Complex.I * ((c : ℂ) * x + (d : ℂ))) ∈ Complex.slitPlane := by
  rw [Complex.mem_slitPlane_iff]
  left
  have him : ((c : ℂ) * x + (d : ℂ)).im = (c : ℝ) * x.im := by simp
  have hre : (-Complex.I * ((c : ℂ) * x + (d : ℂ))).re = ((c : ℂ) * x + (d : ℂ)).im := by
    simp [Complex.mul_re]
  rw [hre, him]
  exact mul_pos (by exact_mod_cast hc) hx

lemma lin_ne_zero (c d : ℤ) (hc : 0 < c) {x : ℂ} (hx : x ∈ upperHalfPlaneSet) :
    ((c : ℂ) * x + (d : ℂ)) ≠ 0 := by
  intro h
  have him : ((c : ℂ) * x + (d : ℂ)).im = (c : ℝ) * x.im := by simp
  rw [h] at him
  simp only [Complex.zero_im] at him
  have : (0 : ℝ) < (c : ℝ) * x.im := mul_pos (by exact_mod_cast hc) hx
  linarith

lemma csqrt_lin_ne_zero (c d : ℤ) (hc : 0 < c) {x : ℂ} (hx : x ∈ upperHalfPlaneSet) :
    Complex.sqrt (-Complex.I * ((c : ℂ) * x + (d : ℂ))) ≠ 0 := by
  have h0 : (-Complex.I * ((c : ℂ) * x + (d : ℂ))) ≠ 0 :=
    Complex.slitPlane_ne_zero (slit_mem c d hc hx)
  simp only [Complex.sqrt, ne_eq, Complex.cpow_eq_zero_iff, not_and, not_not]
  intro hcontra
  exact absurd hcontra h0

lemma hasDerivAt_lin (c d : ℤ) (x : ℂ) :
    HasDerivAt (fun w : ℂ => -Complex.I * ((c : ℂ) * w + (d : ℂ))) (-Complex.I * (c : ℂ)) x := by
  simpa using
    (((hasDerivAt_id x).const_mul ((c : ℂ))).add_const ((d : ℂ))).const_mul (-Complex.I)

lemma differentiableAt_csqrt_lin (c d : ℤ) (hc : 0 < c) {x : ℂ} (hx : x ∈ upperHalfPlaneSet) :
    DifferentiableAt ℂ (fun w : ℂ => Complex.sqrt (-Complex.I * ((c : ℂ) * w + (d : ℂ)))) x := by
  have h := (Complex.differentiableAt_sqrt (slit_mem c d hc hx)).comp x
      (hasDerivAt_lin c d x).differentiableAt
  simpa [Function.comp_def] using h

/-- **The `√` side.**  `logDeriv (w ↦ √(-i(cw+d))) x = c/(2(cx+d))` — the *same* `+c/(2(cx+d))`
the `E2` defect produces on the other side.  That the two agree is the whole theorem. -/
lemma logDeriv_csqrt_lin (c d : ℤ) (hc : 0 < c) {x : ℂ} (hx : x ∈ upperHalfPlaneSet) :
    logDeriv (fun w : ℂ => Complex.sqrt (-Complex.I * ((c : ℂ) * w + (d : ℂ)))) x
      = (c : ℂ) / (2 * ((c : ℂ) * x + (d : ℂ))) := by
  have hslit := slit_mem c d hc hx
  have hne := lin_ne_zero c d hc hx
  have hcomp : logDeriv (Complex.sqrt ∘ (fun w : ℂ => -Complex.I * ((c : ℂ) * w + (d : ℂ)))) x
      = logDeriv Complex.sqrt (-Complex.I * ((c : ℂ) * x + (d : ℂ)))
        * deriv (fun w : ℂ => -Complex.I * ((c : ℂ) * w + (d : ℂ))) x :=
    logDeriv_comp (Complex.differentiableAt_sqrt hslit) (hasDerivAt_lin c d x).differentiableAt
  rw [show (fun w : ℂ => Complex.sqrt (-Complex.I * ((c : ℂ) * w + (d : ℂ))))
        = Complex.sqrt ∘ (fun w : ℂ => -Complex.I * ((c : ℂ) * w + (d : ℂ))) from rfl,
    hcomp, logDeriv_csqrt hslit, (hasDerivAt_lin c d x).deriv]
  field_simp

end DRK05Aux

open DRK05Aux

/-- **DRK-05(a) — PROVED 2026-09-08.**  The `logDeriv` identity behind the `η` transformation
law, for an arbitrary `γ ∈ SL(2,ℤ)` with `c > 0`.

`logDeriv (η ∘ γ) = logDeriv (√(-i(cz+d)) · η)` on `ℍ`.  Since `ℍ` is connected and both sides
are nonvanishing and holomorphic, this is exactly the assertion that
`η(γz) / (√(-i(cz+d)) · η(z))` is a **constant** — the multiplier — and `DRK-06` is the
computation of that constant.

**Provenance: INDEPENDENT.**  FLT has no counterpart to this statement (it states only the closed
form).  The proof is the `E2`-period route recommended by `MATHLIB_PR.md`: `logDeriv_eta_eq_E2`
turns each side into `E2`, `E2_slash_action γ` supplies the weight-2 defect `D2 γ`, and
`i² = -1` turns the *subtracted* defect into the *added* `c/(2(cz+d))` that the `√` side produces
by `Complex.deriv_sqrt`.  No FLT text was used.

Relative to Mathlib's `ModularForm.logDeriv_eta_comp_eq_logDeriv_csqrt_eta`
(`Mathlib/NumberTheory/ModularForms/Discriminant.lean:75`) this is a strict generalisation:
Mathlib has only `γ = ModularGroup.S`.  It is *equivalent* to Mathlib's statement at `γ = S`,
modulo the constant `√(-i)` inside our radical — Mathlib writes the bare `sqrt` and absorbs
`√(-i)` into its constant, and `logDeriv` kills that constant either way.  We do **not** route
through that bridge; the proof computes `deriv_sqrt` on our own expression directly, so the
normalisation is FLT's, character for character.

HONESTY (LL-1): this is the **analytic half only**.  It says a multiplier exists; it says nothing
about its value.  The arithmetic payload — the Dedekind sum, `Φ`, the Euclidean descent — is all
in `DRK-06`, which is still open.  Do not report this as "the `η` transformation formula". -/
theorem logDeriv_eta_smul_eq_logDeriv_csqrt (γ : SL(2, ℤ)) (hc : 0 < γ 1 0) (z : ℍ) :
    logDeriv (ModularForm.eta ∘ mobiusC γ) (z : ℂ)
      = logDeriv
          (fun w : ℂ => Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * w + (γ 1 1 : ℂ)))
            * ModularForm.eta w) (z : ℂ) := by
  have hpi : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  have hden := denom_ne γ z
  have hz : (z : ℂ) ∈ upperHalfPlaneSet := z.2
  -- the `η ∘ γ` side, through `E2`
  have hmob := coe_mobiusC γ z
  have hetad : DifferentiableAt ℂ ModularForm.eta (mobiusC γ (z : ℂ)) := by
    rw [hmob]; exact ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet (γ • z).2
  have hmd : DifferentiableAt ℂ (mobiusC γ) (z : ℂ) := (hasDerivAt_mobiusC γ z).differentiableAt
  rw [logDeriv_comp hetad hmd, (hasDerivAt_mobiusC γ z).deriv, hmob,
    ModularForm.logDeriv_eta_eq_E2 (γ • z)]
  -- the `√ · η` side
  rw [logDeriv_mul (z : ℂ) (csqrt_lin_ne_zero _ _ hc hz)
      (ModularForm.eta_ne_zero hz) (differentiableAt_csqrt_lin _ _ hc hz)
      (ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet hz),
    logDeriv_csqrt_lin _ _ hc hz, ModularForm.logDeriv_eta_eq_E2 z]
  -- the weight-2 defect of `E2`
  have hE2 := congrFun (EisensteinSeries.E2_slash_action γ) z
  simp only [SL_slash_apply, Pi.sub_apply, Pi.smul_apply, smul_eq_mul,
    EisensteinSeries.D2, riemannZeta_two, denom_eq γ z] at hE2
  rw [show (-2 : ℤ) = -((2 : ℕ) : ℤ) by norm_num, _root_.zpow_neg, zpow_natCast] at hE2
  rw [defect_algebra _ _ _ _ _ hpi hden hE2]
  ring

/-- **DRK-05(b) — PROVED 2026-09-08.**  The multiplier exists as a constant: there is a `C γ ≠ 0`
with `η(γz) = C γ · √(-i(cz+d)) · η(z)` for every `z`.  `DRK-06` says `C γ = exp(πi Φ(γ)/12)`.

**Provenance: INDEPENDENT.**  This is DRK-05(a) plus `logDeriv_eqOn_iff` on the (open, convex,
hence preconnected) `upperHalfPlaneSet`, the same move Mathlib's
`eta_comp_eqOn_const_mul_csqrt_eta` makes for `γ = S`.

HONESTY (LL-1): **this is strictly weaker than FLT's `ModularForm.eta_specialLinearGroup_smul`**,
which is `eta_specialLinearGroup_smul_flt` below.  The reference gives the multiplier's *value*,
`exp(πi/12·((a+d)/c - 12·s(d,c)))`; this statement replaces that value by an unnamed existential.
The reference implies this in one line (`ε := exp(…)`, nonzero because `exp` is); the converse is
the whole of `DRK-06`.  The quantifier order is `∃ C, C ≠ 0 ∧ ∀ z` — `C` does not depend on `z`,
which is what makes it a multiplier and what `DRK-06` will evaluate. -/
theorem exists_eta_smul_const (γ : SL(2, ℤ)) (hc : 0 < γ 1 0) :
    ∃ C : ℂ, C ≠ 0 ∧ ∀ z : ℍ, ModularForm.eta ((γ • z : ℍ) : ℂ)
      = C * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta (z : ℂ) := by
  obtain ⟨C, hC0, hCeq⟩ :=
    (logDeriv_eqOn_iff (f := ModularForm.eta ∘ mobiusC γ)
        (g := fun w : ℂ => Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * w + (γ 1 1 : ℂ)))
          * ModularForm.eta w)
        (s := upperHalfPlaneSet)
        (by
          apply DifferentiableOn.comp (t := upperHalfPlaneSet)
          · exact fun x hx =>
              (ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet hx).differentiableWithinAt
          · exact fun x hx =>
              ((hasDerivAt_mobiusC γ ⟨x, hx⟩).differentiableAt).differentiableWithinAt
          · exact fun y hy => mobiusC_mem γ hy)
        (fun x hx => ((differentiableAt_csqrt_lin _ _ hc hx).mul
          (ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet hx)).differentiableWithinAt)
        isOpen_upperHalfPlaneSet
        (Convex.isPreconnected (convex_halfSpace_im_gt 0))
        (fun x hx => mul_ne_zero (csqrt_lin_ne_zero _ _ hc hx) (ModularForm.eta_ne_zero hx))
        (fun x hx => ModularForm.eta_ne_zero (mobiusC_mem γ hx))).mp
      (fun x hx => logDeriv_eta_smul_eq_logDeriv_csqrt γ hc ⟨x, hx⟩)
  refine ⟨C, hC0, fun z => ?_⟩
  have h := hCeq z.2
  simp only [Function.comp_apply, Pi.smul_apply, smul_eq_mul, coe_mobiusC γ z] at h
  rw [h, mul_assoc]

/-! ## DRK-06 — the closed form of the multiplier  (PROVED 2026-09-08, `sorry`-free)

Two phrasings of one theorem.  `eta_smul_eq_exp_rademacherPhi` is the one that is proved from
scratch below; `eta_specialLinearGroup_smul_flt` is FLT's exact inline phrasing, and is now a
one-`rw` corollary of it via `rademacherPhi_of_pos_toNat` (DRK-03).

### PROVENANCE — read this before citing anything here

* **STATEMENT: from FLT.**  `eta_specialLinearGroup_smul_flt` is
  `anthropics/fermats-last-theorem`, `Theorems/Thm_ModularForm_eta_specialLinearGroup_smul.lean`
  (Apache-2.0), transcribed character-for-character modulo notation.  `ATTRIBUTION.md` records it.
* **PROOF: INDEPENDENT — ADAPTED, NOT PORTED.**  Upstream's proof is the single tactic
  `p2m_exact_reverting @P2MW.S_ModularForm_eta_specialLinearGroup_smul` against a 9054-byte
  `P2M/Sol` file; that tactic does not exist in this library and that file was never read.  The
  proof below is a Euclidean descent written against **our** architecture:
  `rademacher_phi_step` (DRK-04, ours), `rademacherPhi_of_pos` (DRK-03, ours), `eta_add_int`
  (F3.1-B3, ours), `csqrt_sq` (F3.2-A7, ours), and Mathlib's `eta_comp_eq_csqrt_I_inv`.
  Do **not** cite FLT for any proof step here.

### THE ARGUMENT, IN ONE PARAGRAPH

Strong induction on `c = γ 1 0`.  Write the Euclidean step `r = q·c - d` with `0 ≤ r < c`
(`Int.emod`); `r = 0` forces `c ∣ d`, hence `c ∣ 1`, hence `c = 1`.  **Base `c = 1`:**
`γ = T^a · S · T^d` literally, so `η(γz)` is `eta_add_int` twice around Mathlib's `S`-law
`eta_comp_eq_csqrt_I_inv`, and `Φ(γ) = a + d` because `s(d,1) = 0` (`dedekindSum_one_right`).
**Step `0 < r < c`:** `γ = γ' · S · T^q` with `γ' = !![q·a - b, a; r, c]`, and
`γ' 1 0 = r < c`, so the induction hypothesis applies to `γ'`.  Unwinding gives
`η(γz) = e^{πiΦ(γ')/12} · e^{πiq/12} · √A · √(-i) · √w · η(z)` with `w = z + q`,
`A = -i(r·(-1/w) + c)`, and `√A·(√(-i)·√w) = √(-i)·√(-i(cz+d))` — the whole content of the step
is that **branch** identity.  `√(-i) = e^{-πi/4} = e^{πi·(-3)/12}` is the missing `-3`, and
`rademacher_phi_step` (DRK-04) says `Φ(γ) = Φ(γ') + q - 3` exactly.

### WHY THE BRANCH BOOKKEEPING IS SAFE

`Complex.sqrt` is the principal branch `z ^ (2⁻¹ : ℂ)`.  Two principal roots multiply correctly,
`√u·√v = √(uv)`, **iff** `Re(√u·√v) > 0` — that is `csqrt_mul_of_re_mul_pos`, proved from
`csqrt_sq` alone (both sides have the same square, and `Re √(uv) ≥ 0` always, so the `-` branch
is excluded by a strict real inequality).  Every use below discharges that hypothesis from
`0 < Re A`, `0 < Re B`, `0 < Re ξ`, which are `hc : 0 < c`, `0 < r` and `Im z > 0` respectively.
`hc` is load-bearing in exactly this way and nowhere else.

### HONESTY (LL-1, and the DRK-06 comparator's residual (b))

Like FLT, this says **nothing** about `c = 0` (that is `eta_add_int` / `rademacherPhi_T_zpow`)
and nothing about `c < 0` (reduce by `γ ↦ -γ` with `rademacherPhi_neg`).  DRK-06 as stated is
therefore **NOT** the full `η` transformation law on all of `SL(2,ℤ)`; anything downstream that
needs `c ≤ 0` — `ETA-01` does — must add those two cases explicitly.  `DRK-05`
(`exists_eta_smul_const`) is **not used** by the proof below: the induction produces the constant
and its value in one go, so the analytic half is subsumed rather than invoked.  Nothing about
`DRK-07` follows for free.

### SIGN-DISCIPLINE GATE (LL-22), AND IT COMES FIRST

The pins below were computed **independently before any Lean proof of this node existed**
(Python `fractions.Fraction` for every `Φ`, and `mpmath`/`cmath` for the analytic identity: the
full law was checked at 8 matrices × 2 points and the branch identity `√A·√B = √(-i)·√ξ` at
6 matrices × 2 points, all ratios `1 ± 1e-13`).  Each Lean pin is a **kernel** evaluation of
`rademacherPhi`/`dedekindSum`, so it cannot be satisfied by the theory it exists to check.

* `drk06_pin_descent_*` — `Φ(γ) = Φ(γ') + q - 3` at eight `γ`, including `q = 0`, negative `d`,
  and `c ∈ {2,3,4,5,7,12,13}`.  A wrong shift constant fails all eight;
  `drk06_neg_control_minus_two` and `drk06_neg_control_no_shift` prove `-2` and `0` do fail.
* `drk06_pin_base_*` — `Φ = a + d` at six `c = 1` matrices, which is the induction's base value.
* `drk06_pin_branch_im_neg` / `_im_pos` / `drk06_neg_control_branch_sign` — the branch itself:
  `√(-i)` has **negative** imaginary part and `√(+i)` positive, so `e^{-πi/4}` cannot be replaced
  by `e^{+πi/4}`.  That substitution is the `+3`-for-`-3` error, i.e. exactly the `Φ`-vs-`Ψ`
  eighth-root-of-unity failure mode of LL-22 seen on the analytic side.
-/

section DRK06SignGate




def drk06MatC5  : SL(2, ℤ) := slOf 2 1 5 3 (by decide)
def drk06MatC5p : SL(2, ℤ) := slOf 1 2 2 5 (by decide)
def drk06MatC7  : SL(2, ℤ) := slOf 3 2 7 5 (by decide)
def drk06MatC7p : SL(2, ℤ) := slOf 1 3 2 7 (by decide)
def drk06MatC2  : SL(2, ℤ) := slOf 1 1 2 3 (by decide)
def drk06MatC2p : SL(2, ℤ) := slOf 1 1 1 2 (by decide)
def drk06MatC4  : SL(2, ℤ) := slOf 3 (-1) 4 (-1) (by decide)
def drk06MatC4p : SL(2, ℤ) := slOf 1 3 1 4 (by decide)
def drk06MatC5b : SL(2, ℤ) := slOf 2 (-1) 5 (-2) (by decide)
def drk06MatC3  : SL(2, ℤ) := slOf 1 0 3 1 (by decide)
def drk06MatC3p : SL(2, ℤ) := slOf 1 1 2 3 (by decide)
def drk06MatC12 : SL(2, ℤ) := slOf 5 2 12 5 (by decide)
def drk06MatC12p: SL(2, ℤ) := slOf 3 5 7 12 (by decide)
def drk06MatC13 : SL(2, ℤ) := slOf 5 3 13 8 (by decide)
def drk06MatC13p: SL(2, ℤ) := slOf 2 5 5 13 (by decide)

theorem drk06_pin_descent_c5 :
    rademacherPhi drk06MatC5 = rademacherPhi drk06MatC5p + 1 - 3 := by decide +kernel
theorem drk06_pin_descent_c7 :
    rademacherPhi drk06MatC7 = rademacherPhi drk06MatC7p + 1 - 3 := by decide +kernel
theorem drk06_pin_descent_c2 :
    rademacherPhi drk06MatC2 = rademacherPhi drk06MatC2p + 2 - 3 := by decide +kernel
theorem drk06_pin_descent_c4 :
    rademacherPhi drk06MatC4 = rademacherPhi drk06MatC4p + 0 - 3 := by decide +kernel
theorem drk06_pin_descent_c5b :
    rademacherPhi drk06MatC5b = rademacherPhi drk06MatC5p + 0 - 3 := by decide +kernel
theorem drk06_pin_descent_c3 :
    rademacherPhi drk06MatC3 = rademacherPhi drk06MatC3p + 1 - 3 := by decide +kernel
theorem drk06_pin_descent_c12 :
    rademacherPhi drk06MatC12 = rademacherPhi drk06MatC12p + 1 - 3 := by decide +kernel
theorem drk06_pin_descent_c13 :
    rademacherPhi drk06MatC13 = rademacherPhi drk06MatC13p + 1 - 3 := by decide +kernel

theorem drk06_neg_control_minus_two :
    rademacherPhi drk06MatC5 ≠ rademacherPhi drk06MatC5p + 1 - 2 := by decide +kernel
theorem drk06_neg_control_no_shift :
    rademacherPhi drk06MatC5 ≠ rademacherPhi drk06MatC5p + 1 := by decide +kernel

def drk06MatBaseS  : SL(2, ℤ) := slOf 0 (-1) 1 0 (by decide)
def drk06MatBaseT  : SL(2, ℤ) := slOf 1 0 1 1 (by decide)
def drk06MatBase23 : SL(2, ℤ) := slOf 2 5 1 3 (by decide)
def drk06MatBaseM14 : SL(2, ℤ) := slOf (-1) (-5) 1 4 (by decide)
def drk06MatBase5M2 : SL(2, ℤ) := slOf 5 (-11) 1 (-2) (by decide)
def drk06MatBaseM4M7 : SL(2, ℤ) := slOf (-4) 27 1 (-7) (by decide)

theorem drk06_pin_base_S : rademacherPhi drk06MatBaseS = 0 := by decide +kernel
theorem drk06_pin_base_T : rademacherPhi drk06MatBaseT = 2 := by decide +kernel
theorem drk06_pin_base_23 : rademacherPhi drk06MatBase23 = 5 := by decide +kernel
theorem drk06_pin_base_m14 : rademacherPhi drk06MatBaseM14 = 3 := by decide +kernel
theorem drk06_pin_base_5m2 : rademacherPhi drk06MatBase5M2 = 3 := by decide +kernel
theorem drk06_pin_base_m4m7 : rademacherPhi drk06MatBaseM4M7 = -11 := by decide +kernel


theorem drk06_pin_branch_im_neg : (Complex.sqrt (-Complex.I)).im < 0 := by
  rw [Complex.sqrt_neg_I]
  simp only [Complex.mul_im, Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im,
    Complex.I_re, Complex.I_im, Complex.ofReal_re, Complex.ofReal_im]
  have : (0:ℝ) < Real.sqrt 2⁻¹ := Real.sqrt_pos.2 (by norm_num)
  nlinarith

theorem drk06_pin_branch_im_pos : 0 < (Complex.sqrt Complex.I).im := by
  rw [Complex.sqrt_I]
  simp only [Complex.mul_im, Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im,
    Complex.I_re, Complex.I_im, Complex.ofReal_re, Complex.ofReal_im]
  have : (0:ℝ) < Real.sqrt 2⁻¹ := Real.sqrt_pos.2 (by norm_num)
  nlinarith

theorem drk06_neg_control_branch_sign :
    Complex.sqrt (-Complex.I) ≠ Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((3 : ℤ) : ℂ)) := by
  intro h
  have h1 := drk06_pin_branch_im_neg
  rw [h] at h1
  have hrw : (Real.pi : ℂ) * Complex.I / 12 * ((3 : ℤ) : ℂ)
      = ((Real.pi / 4 : ℝ) : ℂ) * Complex.I := by push_cast; ring
  rw [hrw, Complex.exp_mul_I, ← Complex.ofReal_cos, ← Complex.ofReal_sin,
    Real.sin_pi_div_four] at h1
  simp only [Complex.add_im, Complex.ofReal_im, Complex.mul_im, Complex.ofReal_re,
    Complex.I_re, Complex.I_im, zero_add, mul_one, mul_zero, add_zero] at h1
  have hpos : (0:ℝ) < Real.sqrt 2 := Real.sqrt_pos.2 (by norm_num)
  linarith




end DRK06SignGate

/-! ### DRK-06, part 2 — the machinery  (all INDEPENDENT) -/
/-! ### csqrt algebra -/

theorem csqrt_mul_self (x : ℂ) : Complex.sqrt x * Complex.sqrt x = x := by
  have h := csqrt_sq x
  rw [pow_two] at h
  exact h

theorem csqrt_re_nonneg (x : ℂ) : 0 ≤ (Complex.sqrt x).re := by
  rw [Complex.sqrt, Complex.cpow_inv_two_re]
  exact Real.sqrt_nonneg _

theorem csqrt_re_mul_re_sub (x : ℂ) :
    (Complex.sqrt x).re * (Complex.sqrt x).re - (Complex.sqrt x).im * (Complex.sqrt x).im = x.re := by
  have h := congrArg Complex.re (csqrt_mul_self x)
  simpa [Complex.mul_re] using h

theorem csqrt_two_re_mul_im (x : ℂ) :
    2 * ((Complex.sqrt x).re * (Complex.sqrt x).im) = x.im := by
  have h := congrArg Complex.im (csqrt_mul_self x)
  simp [Complex.mul_im] at h
  linarith [h]

/-- For `Re u > 0`, the principal square root lies in the open sector `|arg| < π/4`. -/
theorem abs_im_csqrt_lt_re {u : ℂ} (hu : 0 < u.re) :
    |(Complex.sqrt u).im| < (Complex.sqrt u).re := by
  have h1 := csqrt_re_mul_re_sub u
  have h2 := csqrt_re_nonneg u
  rw [abs_lt]
  constructor
  · nlinarith
  · nlinarith

/-- For `Im v > 0`, the principal square root lies in the open first quadrant. -/
theorem csqrt_re_pos_im_pos {v : ℂ} (hv : 0 < v.im) :
    0 < (Complex.sqrt v).re ∧ 0 < (Complex.sqrt v).im := by
  have h1 := csqrt_two_re_mul_im v
  have h2 := csqrt_re_nonneg v
  have hre : 0 < (Complex.sqrt v).re := by
    rcases lt_or_eq_of_le h2 with h | h
    · exact h
    · exfalso
      rw [← h] at h1
      simp at h1
      linarith
  refine ⟨hre, ?_⟩
  nlinarith

/-- The branch-tracking core: two principal square roots multiply correctly precisely when the
product of the roots is not in the closed left half plane. -/
theorem csqrt_mul_of_re_mul_pos {u v : ℂ}
    (h : 0 < (Complex.sqrt u * Complex.sqrt v).re) :
    Complex.sqrt u * Complex.sqrt v = Complex.sqrt (u * v) := by
  have h1 := csqrt_mul_self u
  have h2 := csqrt_mul_self v
  have h3 := csqrt_mul_self (u * v)
  have hsq : (Complex.sqrt u * Complex.sqrt v - Complex.sqrt (u * v)) *
      (Complex.sqrt u * Complex.sqrt v + Complex.sqrt (u * v)) = 0 := by
    linear_combination (Complex.sqrt v * Complex.sqrt v) * h1 + u * h2 - h3
  rcases mul_eq_zero.1 hsq with hz | hz
  · exact sub_eq_zero.mp hz
  · exfalso
    have hre : (Complex.sqrt u * Complex.sqrt v).re + (Complex.sqrt (u * v)).re = 0 := by
      have := congrArg Complex.re hz
      simpa using this
    linarith [csqrt_re_nonneg (u * v)]

theorem csqrt_mul_of_re_pos {u v : ℂ} (hu : 0 < u.re) (hv : 0 < v.re) :
    Complex.sqrt u * Complex.sqrt v = Complex.sqrt (u * v) := by
  refine csqrt_mul_of_re_mul_pos ?_
  have h1 := abs_im_csqrt_lt_re hu
  have h2 := abs_im_csqrt_lt_re hv
  rw [abs_lt] at h1 h2
  rw [Complex.mul_re]
  nlinarith [mul_pos (show (0:ℝ) < (Complex.sqrt u).re + (Complex.sqrt u).im by linarith [h1.1])
      (show (0:ℝ) < (Complex.sqrt v).re - (Complex.sqrt v).im by linarith [h2.2]),
    mul_pos (show (0:ℝ) < (Complex.sqrt u).re - (Complex.sqrt u).im by linarith [h1.2])
      (show (0:ℝ) < (Complex.sqrt v).re + (Complex.sqrt v).im by linarith [h2.1])]

theorem csqrt_neg_I_mul {v : ℂ}
    (hv : 0 < (Complex.sqrt v).re + (Complex.sqrt v).im) :
    Complex.sqrt (-Complex.I) * Complex.sqrt v = Complex.sqrt (-Complex.I * v) := by
  refine csqrt_mul_of_re_mul_pos ?_
  have ha : (0:ℝ) < Real.sqrt 2⁻¹ := Real.sqrt_pos.2 (by norm_num)
  rw [Complex.sqrt_neg_I]
  simp only [Complex.mul_re, Complex.mul_im, Complex.sub_re, Complex.sub_im,
    Complex.one_re, Complex.one_im, Complex.I_re, Complex.I_im, Complex.ofReal_re,
    Complex.ofReal_im]
  nlinarith


/-! ### the branch constant `√(-i) = e^{-πi/4}` -/

theorem csqrt_neg_I_eq_exp :
    Complex.sqrt (-Complex.I)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((-3 : ℤ) : ℂ)) := by
  have hs2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have h2 : Real.sqrt 2⁻¹ = Real.sqrt 2 / 2 := by
    rw [Real.sqrt_inv]
    field_simp
    linarith [hs2]
  have hrw : (Real.pi : ℂ) * Complex.I / 12 * ((-3 : ℤ) : ℂ)
      = ((-(Real.pi / 4) : ℝ) : ℂ) * Complex.I := by
    push_cast
    ring
  rw [Complex.sqrt_neg_I, hrw, Complex.exp_mul_I, ← Complex.ofReal_cos, ← Complex.ofReal_sin,
    Real.cos_neg, Real.sin_neg, Real.cos_pi_div_four, Real.sin_pi_div_four, h2]
  push_cast
  ring

theorem csqrt_I_inv : (Complex.sqrt Complex.I)⁻¹ = Complex.sqrt (-Complex.I) := by
  have hs : ((Real.sqrt 2⁻¹ : ℝ) : ℂ) * ((Real.sqrt 2⁻¹ : ℝ) : ℂ) = (2⁻¹ : ℂ) := by
    rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by norm_num)]
    norm_num
  have h : Complex.sqrt Complex.I * Complex.sqrt (-Complex.I) = 1 := by
    rw [Complex.sqrt_I, Complex.sqrt_neg_I]
    linear_combination (2 : ℂ) * hs
      - ((Real.sqrt 2⁻¹ : ℝ) : ℂ) * ((Real.sqrt 2⁻¹ : ℝ) : ℂ) * Complex.I_sq
  exact inv_eq_of_mul_eq_one_right h


/-! ### the descent matrix -/

theorem slOf_apply (a b c d : ℤ) (h : a * d - b * c = 1) :
    (slOf a b c d h) 0 0 = a ∧ (slOf a b c d h) 0 1 = b ∧
    (slOf a b c d h) 1 0 = c ∧ (slOf a b c d h) 1 1 = d :=
  ⟨rfl, rfl, rfl, rfl⟩

theorem sl2_det (γ : SL(2, ℤ)) : γ 0 0 * γ 1 1 - γ 0 1 * γ 1 0 = 1 := by
  have h := γ.2
  rwa [Matrix.det_fin_two] at h

theorem sl2_descent_eq {γ γ' : SL(2, ℤ)} {q : ℤ}
    (h00 : γ' 0 0 = q * γ 0 0 - γ 0 1) (h01 : γ' 0 1 = γ 0 0)
    (h10 : γ' 1 0 = q * γ 1 0 - γ 1 1) (h11 : γ' 1 1 = γ 1 0) :
    γ = γ' * ModularGroup.S * ModularGroup.T ^ q := by
  apply Subtype.ext
  rw [Matrix.SpecialLinearGroup.coe_mul, Matrix.SpecialLinearGroup.coe_mul,
    ModularGroup.coe_S, ModularGroup.coe_T_zpow,
    Matrix.eta_fin_two (γ' : Matrix (Fin 2) (Fin 2) ℤ)]
  rw [show (γ' : Matrix (Fin 2) (Fin 2) ℤ) 0 0 = q * γ 0 0 - γ 0 1 from h00,
    show (γ' : Matrix (Fin 2) (Fin 2) ℤ) 0 1 = γ 0 0 from h01,
    show (γ' : Matrix (Fin 2) (Fin 2) ℤ) 1 0 = q * γ 1 0 - γ 1 1 from h10,
    show (γ' : Matrix (Fin 2) (Fin 2) ℤ) 1 1 = γ 1 0 from h11]
  simp only [Matrix.mul_fin_two]
  ext i j
  fin_cases i <;> fin_cases j <;> simp <;> ring

theorem rademacherPhi_descent {γ γ' : SL(2, ℤ)} (hc : 0 < γ 1 0) {q : ℤ}
    (hr : 0 < γ' 1 0)
    (h00 : γ' 0 0 = q * γ 0 0 - γ 0 1)
    (h10 : γ' 1 0 = q * γ 1 0 - γ 1 1) (h11 : γ' 1 1 = γ 1 0) :
    rademacherPhi γ = rademacherPhi γ' + q - 3 := by
  have hct : (((γ 1 0).toNat : ℕ) : ℤ) = γ 1 0 := Int.toNat_of_nonneg hc.le
  have hrt : (((γ' 1 0).toNat : ℕ) : ℤ) = γ' 1 0 := Int.toNat_of_nonneg hr.le
  have hstep := rademacher_phi_step (γ 1 0).toNat (γ' 1 0).toNat
      (by omega) (by omega) (γ 0 0) (γ 0 1) (γ 1 1) q
      (by rw [hrt, hct]; exact h10)
      (by rw [hct]; exact sl2_det γ)
  have hcq : ((γ 1 0 : ℤ) : ℚ) = (((γ 1 0).toNat : ℕ) : ℚ) := by
    exact_mod_cast hct.symm
  have hrq : ((γ' 1 0 : ℤ) : ℚ) = (((γ' 1 0).toNat : ℕ) : ℚ) := by
    exact_mod_cast hrt.symm
  have hds : dedekindSum (γ 1 0) ((γ' 1 0).toNat)
      = dedekindSum ((((γ 1 0).toNat : ℕ) : ℤ)) ((γ' 1 0).toNat) := by rw [hct]
  rw [rademacherPhi_of_pos hc, rademacherPhi_of_pos hr, h00, h11, hcq, hrq, hds]
  push_cast at hstep ⊢
  rw [hcq]
  linarith [hstep]



/-! ### coercion helpers -/

theorem coe_T_zpow_smul (n : ℤ) (z : ℍ) : ((ModularGroup.T ^ n • z : ℍ) : ℂ) = (z : ℂ) + n := by
  rw [UpperHalfPlane.modular_T_zpow_smul]
  simp [UpperHalfPlane.coe_vadd]
  ring

theorem coe_S_smul (z : ℍ) : ((ModularGroup.S • z : ℍ) : ℂ) = -((z : ℂ))⁻¹ := by
  rw [UpperHalfPlane.modular_S_smul, UpperHalfPlane.coe_mk, inv_neg]

theorem im_pos_coe (z : ℍ) : 0 < (z : ℂ).im := z.2

theorem eta_neg_inv (w : ℍ) :
    ModularForm.eta (-((w : ℂ))⁻¹)
      = Complex.sqrt (-Complex.I) * (Complex.sqrt (w : ℂ) * ModularForm.eta (w : ℂ)) := by
  have h : ModularForm.eta (-((w : ℂ))⁻¹)
      = (Complex.sqrt Complex.I)⁻¹ * (Complex.sqrt (w : ℂ) * ModularForm.eta (w : ℂ)) := by
    simpa [neg_div] using ModularForm.eta_comp_eq_csqrt_I_inv w.2
  rw [h, csqrt_I_inv]

theorem re_neg_I_mul_lin (m n : ℤ) (x : ℂ) :
    (-Complex.I * ((m : ℂ) * x + (n : ℂ))).re = (m : ℝ) * x.im := by
  simp [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im]


/-! ### the descent step -/

theorem eta_smul_descent_step {γ γ' : SL(2, ℤ)} (hc : 0 < γ 1 0) {q : ℤ}
    (hr : 0 < γ' 1 0)
    (h00 : γ' 0 0 = q * γ 0 0 - γ 0 1) (h01 : γ' 0 1 = γ 0 0)
    (h10 : γ' 1 0 = q * γ 1 0 - γ 1 1) (h11 : γ' 1 1 = γ 1 0)
    (IH : ∀ u : ℍ, ModularForm.eta ((γ' • u : ℍ) : ℂ)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((rademacherPhi γ' : ℚ) : ℂ))
        * Complex.sqrt (-Complex.I * ((γ' 1 0 : ℂ) * (u : ℂ) + (γ' 1 1 : ℂ)))
        * ModularForm.eta (u : ℂ))
    (z : ℍ) :
    ModularForm.eta ((γ • z : ℍ) : ℂ)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((rademacherPhi γ : ℚ) : ℂ))
        * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta (z : ℂ) := by
  set w : ℍ := ModularGroup.T ^ q • z with hwdef
  set u : ℍ := ModularGroup.S • w with hudef
  have hwc : (w : ℂ) = (z : ℂ) + (q : ℂ) := by rw [hwdef]; exact coe_T_zpow_smul q z
  have huc : (u : ℂ) = -((w : ℂ))⁻¹ := by rw [hudef]; exact coe_S_smul w
  have hwim : 0 < (w : ℂ).im := im_pos_coe w
  have huim : 0 < (u : ℂ).im := im_pos_coe u
  have hwne : (w : ℂ) ≠ 0 := by
    intro h; rw [h] at hwim; simp at hwim
  have hsm : (γ • z : ℍ) = γ' • u := by
    rw [sl2_descent_eq h00 h01 h10 h11, mul_smul, mul_smul, ← hwdef, ← hudef]
  -- positivity of the three right-half-plane arguments
  have hReA : 0 < (-Complex.I * ((γ' 1 0 : ℂ) * (u : ℂ) + (γ' 1 1 : ℂ))).re := by
    rw [re_neg_I_mul_lin]
    have : (0 : ℝ) < ((γ' 1 0 : ℤ) : ℝ) := by exact_mod_cast hr
    positivity
  have hReB : 0 < (-Complex.I * (w : ℂ)).re := by simpa using hwim
  have hRexi : 0 < (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ))).re := by
    rw [re_neg_I_mul_lin]
    have : (0 : ℝ) < ((γ 1 0 : ℤ) : ℝ) := by exact_mod_cast hc
    have := im_pos_coe z
    positivity
  -- the two eta reductions
  have hA : ModularForm.eta ((u : ℂ))
      = Complex.sqrt (-Complex.I) * (Complex.sqrt ((w : ℂ)) * ModularForm.eta ((w : ℂ))) := by
    rw [huc]; exact eta_neg_inv w
  have hB : ModularForm.eta ((w : ℂ))
      = Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (q : ℂ) / 24) * ModularForm.eta ((z : ℂ)) := by
    rw [hwc]; exact eta_add_int q (z : ℂ)
  -- the branch bookkeeping
  have hstep1 : Complex.sqrt (-Complex.I) * Complex.sqrt ((w : ℂ))
      = Complex.sqrt (-Complex.I * (w : ℂ)) := by
    refine csqrt_neg_I_mul ?_
    obtain ⟨h1, h2⟩ := csqrt_re_pos_im_pos hwim
    linarith
  have hz : (z : ℂ) = (w : ℂ) - (q : ℂ) := by rw [hwc]; ring
  have hAeq : ((γ' 1 0 : ℂ)) * (u : ℂ) + ((γ' 1 1 : ℂ))
      = ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)) / (w : ℂ) := by
    rw [huc, h10, h11, hz]
    push_cast
    field_simp
    ring
  have hprod : (-Complex.I * ((γ' 1 0 : ℂ) * (u : ℂ) + (γ' 1 1 : ℂ))) * (-Complex.I * (w : ℂ))
      = -Complex.I * (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ))) := by
    rw [hAeq]
    field_simp
  have hstep2 : Complex.sqrt (-Complex.I * ((γ' 1 0 : ℂ) * (u : ℂ) + (γ' 1 1 : ℂ)))
        * Complex.sqrt (-Complex.I * (w : ℂ))
      = Complex.sqrt (-Complex.I * (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))) := by
    rw [csqrt_mul_of_re_pos hReA hReB, hprod]
  have hstep3 : Complex.sqrt (-Complex.I)
        * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
      = Complex.sqrt (-Complex.I * (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))) := by
    refine csqrt_neg_I_mul ?_
    have h1 := abs_im_csqrt_lt_re hRexi
    rw [abs_lt] at h1
    linarith [h1.1]
  have hmerge : Complex.sqrt (-Complex.I * ((γ' 1 0 : ℂ) * (u : ℂ) + (γ' 1 1 : ℂ)))
        * (Complex.sqrt (-Complex.I) * Complex.sqrt ((w : ℂ)))
      = Complex.sqrt (-Complex.I)
        * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ))) := by
    rw [hstep1, hstep2, hstep3]
  -- the exponentials
  have hexp' : Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((rademacherPhi γ' : ℚ) : ℂ))
        * Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (q : ℂ) / 24)
        * Complex.sqrt (-Complex.I)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((rademacherPhi γ : ℚ) : ℂ)) := by
    rw [csqrt_neg_I_eq_exp, ← Complex.exp_add, ← Complex.exp_add]
    congr 1
    have hphi : ((rademacherPhi γ : ℚ) : ℂ)
        = ((rademacherPhi γ' : ℚ) : ℂ) + (q : ℂ) - 3 := by
      rw [rademacherPhi_descent hc hr h00 h10 h11]
      push_cast
      ring
    rw [hphi]
    push_cast
    ring
  rw [hsm, IH u, hA, hB]
  linear_combination (ModularForm.eta ((z : ℂ)) *
      Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((rademacherPhi γ' : ℚ) : ℂ)) *
      Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (q : ℂ) / 24)) * hmerge
    + (Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta ((z : ℂ))) * hexp'


/-! ### the base case `c = 1` -/

theorem coe_T_zpow_entry (n : ℤ) (i j : Fin 2) :
    (ModularGroup.T ^ n : SL(2, ℤ)) i j = (!![1, n; 0, 1] : Matrix (Fin 2) (Fin 2) ℤ) i j := by
  rw [show ((ModularGroup.T ^ n : SL(2, ℤ)) i j)
      = ((ModularGroup.T ^ n : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ) i j from rfl,
    ModularGroup.coe_T_zpow]

theorem eta_smul_of_c_eq_one {γ : SL(2, ℤ)} (hc : γ 1 0 = 1) (z : ℍ) :
    ModularForm.eta ((γ • z : ℍ) : ℂ)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((rademacherPhi γ : ℚ) : ℂ))
        * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta (z : ℂ) := by
  have hcpos : (0 : ℤ) < γ 1 0 := by rw [hc]; norm_num
  have hdet := sl2_det γ
  rw [hc] at hdet
  -- Φ γ = a + d
  have hphiQ : rademacherPhi γ = ((γ 0 0 : ℤ) : ℚ) + ((γ 1 1 : ℤ) : ℚ) := by
    rw [rademacherPhi_of_pos hcpos, hc]
    norm_num [dedekindSum_one_right]
  -- γ = T^a * S * T^d
  have hdec : γ = ModularGroup.T ^ (γ 0 0) * ModularGroup.S * ModularGroup.T ^ (γ 1 1) := by
    refine sl2_descent_eq ?_ ?_ ?_ ?_
    · rw [coe_T_zpow_entry]; simp; linear_combination -hdet
    · rw [coe_T_zpow_entry]; simp
    · rw [coe_T_zpow_entry, hc]; simp
    · rw [coe_T_zpow_entry, hc]; simp
  set w : ℍ := ModularGroup.T ^ (γ 1 1) • z with hwdef
  set v : ℍ := ModularGroup.S • w with hvdef
  have hwc : (w : ℂ) = (z : ℂ) + ((γ 1 1 : ℤ) : ℂ) := by
    rw [hwdef]; exact coe_T_zpow_smul _ z
  have hvc : (v : ℂ) = -((w : ℂ))⁻¹ := by rw [hvdef]; exact coe_S_smul w
  have hwim : 0 < (w : ℂ).im := im_pos_coe w
  have hsm : (γ • z : ℍ) = ModularGroup.T ^ (γ 0 0) • v := by
    conv_lhs => rw [hdec]
    rw [mul_smul, mul_smul, ← hwdef, ← hvdef]
  have hcoe : ((ModularGroup.T ^ (γ 0 0) • v : ℍ) : ℂ) = (v : ℂ) + ((γ 0 0 : ℤ) : ℂ) :=
    coe_T_zpow_smul _ v
  have hA : ModularForm.eta ((v : ℂ))
      = Complex.sqrt (-Complex.I) * (Complex.sqrt ((w : ℂ)) * ModularForm.eta ((w : ℂ))) := by
    rw [hvc]; exact eta_neg_inv w
  have hB : ModularForm.eta ((w : ℂ))
      = Complex.exp (2 * (Real.pi : ℂ) * Complex.I * ((γ 1 1 : ℤ) : ℂ) / 24)
        * ModularForm.eta ((z : ℂ)) := by
    rw [hwc]; exact eta_add_int (γ 1 1) (z : ℂ)
  have hstep1 : Complex.sqrt (-Complex.I) * Complex.sqrt ((w : ℂ))
      = Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ))) := by
    have h1 : Complex.sqrt (-Complex.I) * Complex.sqrt ((w : ℂ))
        = Complex.sqrt (-Complex.I * (w : ℂ)) := by
      refine csqrt_neg_I_mul ?_
      obtain ⟨ha, hb⟩ := csqrt_re_pos_im_pos hwim
      linarith
    rw [h1, hwc, hc]
    push_cast
    ring_nf
  have hexp : Complex.exp (2 * (Real.pi : ℂ) * Complex.I * ((γ 0 0 : ℤ) : ℂ) / 24)
        * Complex.exp (2 * (Real.pi : ℂ) * Complex.I * ((γ 1 1 : ℤ) : ℂ) / 24)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((rademacherPhi γ : ℚ) : ℂ)) := by
    rw [← Complex.exp_add, hphiQ]
    congr 1
    push_cast
    ring
  rw [hsm, hcoe, eta_add_int (γ 0 0) (v : ℂ), hA, hB]
  linear_combination (ModularForm.eta ((z : ℂ))
      * Complex.exp (2 * (Real.pi : ℂ) * Complex.I * ((γ 0 0 : ℤ) : ℂ) / 24)
      * Complex.exp (2 * (Real.pi : ℂ) * Complex.I * ((γ 1 1 : ℤ) : ℂ) / 24)) * hstep1
    + (Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta ((z : ℂ))) * hexp


/-! ### the strong induction on `c` -/

theorem eta_smul_strong_induction : ∀ n : ℕ, ∀ γ : SL(2, ℤ), (γ 1 0).toNat = n → 0 < γ 1 0 →
    ∀ z : ℍ, ModularForm.eta ((γ • z : ℍ) : ℂ)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((rademacherPhi γ : ℚ) : ℂ))
        * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta (z : ℂ) := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    intro γ hn hc z
    obtain ⟨r, e, hrd, hr0, hrc⟩ :
        ∃ r e : ℤ, r = (-e) * γ 1 0 - γ 1 1 ∧ 0 ≤ r ∧ r < γ 1 0 := by
      refine ⟨(-(γ 1 1)) % (γ 1 0), (-(γ 1 1)) / (γ 1 0), ?_, Int.emod_nonneg _ hc.ne',
        Int.emod_lt_of_pos _ hc⟩
      linear_combination Int.emod_add_ediv_mul (-(γ 1 1)) (γ 1 0)
    have hdet := sl2_det γ
    rcases eq_or_lt_of_le hr0 with hr | hr
    · -- `r = 0` forces `c = 1`: the Euclidean algorithm has terminated.
      have hd : γ 1 1 = -(γ 1 0 * e) := by linear_combination hrd + hr
      have hdvd : γ 1 0 ∣ 1 :=
        ⟨-(γ 0 0 * e) - γ 0 1, by rw [hd] at hdet; linear_combination -hdet⟩
      have hc1 : γ 1 0 = 1 := by
        have := Int.le_of_dvd one_pos hdvd
        omega
      exact eta_smul_of_c_eq_one hc1 z
    · -- `0 < r < c`: descend.
      have hdet' : ((-e) * γ 0 0 - γ 0 1) * γ 1 0 - γ 0 0 * r = 1 := by
        linear_combination hdet - γ 0 0 * hrd
      obtain ⟨γ', e00, e01, e10, e11⟩ :
          ∃ g : SL(2, ℤ), g 0 0 = (-e) * γ 0 0 - γ 0 1 ∧ g 0 1 = γ 0 0 ∧
            g 1 0 = r ∧ g 1 1 = γ 1 0 :=
        ⟨slOf ((-e) * γ 0 0 - γ 0 1) (γ 0 0) r (γ 1 0) hdet', rfl, rfl, rfl, rfl⟩
      have hr' : 0 < γ' 1 0 := by rw [e10]; exact hr
      have hlt : (γ' 1 0).toNat < n := by rw [e10]; omega
      exact eta_smul_descent_step hc hr' (by rw [e00]) (by rw [e01]) (by rw [e10]; exact hrd)
        (by rw [e11]) (fun u => ih _ hlt γ' rfl hr' u) z


/-- **DRK-06 (PROVED 2026-09-08, `sorry`-free) — the closed form of the `η` multiplier, through
our named `Φ`.**

`η(γz) = exp(πi·Φ(γ)/12) · √(-i(cz+d)) · η(z)` for `γ ∈ SL(2,ℤ)` with `c > 0`.

LL-22: the `Φ` here is `rademacherPhi`, Apostol's `Φ`, **not** `rademacherPsi`.  Substituting
`Ψ` would multiply the right-hand side by `exp(-πi/4 · sign(c(a+d)))`, an eighth root of unity,
and the statement would be false; `rademacherPhi_ne_rademacherPsi` and the gate above exist to
make that substitution fail the build.

**Provenance: ADAPTED.**  Statement from FLT (see `eta_specialLinearGroup_smul_flt`); proof
independent.  Scope: `c > 0` only — see the honesty note at the head of this section. -/
theorem eta_smul_eq_exp_rademacherPhi (γ : SL(2, ℤ)) (hc : 0 < γ 1 0) (z : ℍ) :
    ModularForm.eta ((γ • z : ℍ) : ℂ)
      = Complex.exp (Real.pi * Complex.I / 12 * ((rademacherPhi γ : ℚ) : ℂ))
        * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta (z : ℂ) :=
  eta_smul_strong_induction ((γ 1 0).toNat) γ rfl hc z

/-- **DRK-06 (PROVED 2026-09-08, `sorry`-free) — FLT's statement, transcribed, now discharged.**

`η(γz) = exp(πi/12 · ((a+d)/c - 12·s(d,c))) · √(-i(cz+d)) · η(z)` for `γ ∈ SL(2,ℤ)` with `c > 0`.

The STATEMENT is transcribed from `anthropics/fermats-last-theorem`,
`Theorems/Thm_ModularForm_eta_specialLinearGroup_smul.lean` (Apache-2.0), with the Dedekind sum
written inline exactly as upstream writes it, `c.toNat` as the second argument and no `Φ`
anywhere.  The run brief identifies this as our own Section 5 item (3), verbatim.

The PROOF is one `rw` off `eta_smul_eq_exp_rademacherPhi` — genuinely one, because
`rademacherPhi_of_pos_toNat` (DRK-03) now carries the `((c : ℤ) : ℚ)` vs `((c.toNat : ℕ) : ℚ)`
cast step that the DRK-06 comparator flagged as its residual (a). -/
theorem eta_specialLinearGroup_smul_flt (γ : SL(2, ℤ)) (hc : 0 < γ 1 0) (z : ℍ) :
    ModularForm.eta ((γ • z : ℍ) : ℂ)
      = Complex.exp (Real.pi * Complex.I / 12 *
          ((((γ 0 0 + γ 1 1 : ℤ) : ℚ) / (((γ 1 0).toNat : ℕ) : ℚ)
              - 12 * dedekindSum (γ 1 1) (γ 1 0).toNat : ℚ) : ℂ))
        * Complex.sqrt (-Complex.I * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)))
        * ModularForm.eta (z : ℂ) := by
  rw [← rademacherPhi_of_pos_toNat hc]
  exact eta_smul_eq_exp_rademacherPhi γ hc z

/-! ## DRK-07 — the multiplier as a function of `γ` alone  (OPEN) -/

/-- The `η` multiplier `ε(γ) = exp(πi·Φ(γ)/12)`, for `γ` with `c > 0`.  Defined for **all** `γ`
by the same formula; `DRK-07` is the statement that it deserves the name. -/
noncomputable def etaMultiplierPhi (γ : SL(2, ℤ)) : ℂ :=
  Complex.exp (Real.pi * Complex.I / 12 * ((rademacherPhi γ : ℚ) : ℂ))

/-- **DRK-07 (OPEN).**  `ε` is a 24th root of unity.  This is `Φ (T^n) = n` (DRK-03) plus the
fact that `Φ` takes values in `ℤ` on `SL(2,ℤ)` — the integrality of `Φ`, which is a corollary of
`DRK-04` and is not separately stated in the brief. -/
theorem etaMultiplierPhi_pow24 (γ : SL(2, ℤ)) : (etaMultiplierPhi γ) ^ (24 : ℕ) = 1 := by
  -- OPEN: DRK-07.a.  Needs `Φ γ ∈ ℤ`, i.e. `∃ n : ℤ, rademacherPhi γ = n`, which is the
  -- OPEN: integrality corollary of DRK-04 and is NOT yet stated anywhere in this library.
  sorry

/-- **DRK-07 (OPEN).**  `ε` is multiplicative up to the `√` cocycle — the statement that makes
`ε` a multiplier *system* rather than a formula.  Left in the weak "there exists an eighth root
of unity" form because the precise cocycle sign is exactly what `Ψ` (not `Φ`) is designed to
track, and pinning it wrongly is the LL-22 failure mode. -/
theorem etaMultiplierPhi_mul_cocycle (γ δ : SL(2, ℤ)) (hγ : 0 < γ 1 0) (hδ : 0 < δ 1 0)
    (hγδ : 0 < (γ * δ) 1 0) :
    ∃ ζ : ℂ, ζ ^ (8 : ℕ) = 1 ∧
      etaMultiplierPhi (γ * δ) = ζ * etaMultiplierPhi γ * etaMultiplierPhi δ := by
  -- OPEN: DRK-07.b.  The `Φ` cocycle is `Φ(γδ) = Φ(γ) + Φ(δ) - 3·sign(c_γ c_δ c_{γδ})`
  -- OPEN: (Rademacher); the `-3` is precisely the `Φ`-vs-`Ψ` discrepancy of LL-22.
  sorry

/-! ## ETA-01 — the run's success criterion  (OPEN, and NOT at the frontier)

Stated so that the target is written down, and so that `dag/theorems.jsonl` has something for
`ETA-01`'s `lean_name` to point at once it is proved.  It is `open` and its dependency chain
(`DRK-02 → DRK-04 → DRK-06 → ETA-01`) contains the single largest arithmetic block of the run. -/

-- QUARANTINED 2026-09-08 (LL-1): `ligozat_trivial_multiplier_of_twelve_dvd` (formerly
-- `ligozat_general`) was moved to `Lean/SocrateAI/Quarantine/LigozatTrivialMultiplierRefuted.lean`,
-- a module NOT imported by `Lean/SocrateAI.lean`, because its statement is machine-refuted
-- (see that file, and `eta01_seventeen_refutes_trivial_multiplier` in `EtaLigozatGeneral.lean`).
-- Its FinalCheck guard moved with it, into the same quarantine file.


end SocrateAI.ModularForms
