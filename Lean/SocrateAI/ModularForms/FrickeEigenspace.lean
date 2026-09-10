/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# The Fricke eigenspace decomposition  (DAG: FRK-11 .. FRK-27, SDF-17 .. SDF-20)

## What is already proved, and what this file adds

Two sorry-free results of earlier runs are the entire input:

* `SocrateAI.ModularForms.frickeW_sq_slash` (FRK-10, `FrickeComposite.lean:51`) —
  `(f ∣[k] W_N) ∣[k] W_N = fun τ => ((N^2 : ℝ) : ℂ) ^ (k - 1) * ((-N : ℝ) : ℂ) ^ (-k) * f τ`.
  Note the shape: the scalar is `(N^2)^(k-1) * (-N)^(-k)`, NOT `(-1)^k * N^(k-2)`.  Those two
  spellings are equal but that equality is a THEOREM (`frickeW_sq_const_simplify`, FRK-17), not a
  rewrite; it is PROVED below, sorry-free, at general `k`.
* `SocrateAI.ModularForms.frickeModularOperator` (FRK-09, `FrickeModular.lean:45`) — the raw
  operator `f ↦ f ∣[k] W_N` already lands in Mathlib's bundled `ModularForm (Gamma0GL N) k`.

This file normalises that operator so that it SQUARES TO THE IDENTITY, packages it as a
`Module.End ℂ`, and defines the two eigenspaces as honest `Submodule`s.  The weight is indexed as
`2 * m` throughout, never as `k` with `Even k`: the normalising exponent is then the literal
integer-linear expression `1 - m` and no `Int` division `k / 2` ever appears.

## VACUITY — stated plainly, because a decomposition of a zero module is worthless

For ODD weight the whole question is empty and this file says so rather than hiding it.
`-1 ∈ Gamma0GL N` (it is the image of `-I ∈ Γ₀(N)`) — CHECKED, not assumed: `neg_one_mem_Gamma0GL`
(FRK-24a) is now a sorry-free proof exhibiting `(-1 : SL(2,ℤ))` and verifying entrywise that
`mapGL ℝ` sends it to `(-1 : GL (Fin 2) ℝ)`.  So Mathlib's `ModularForm.eq_zero_of_neg_one_mem`
forces `f = 0` for every `f : ModularForm (Gamma0GL N) k` with `k` odd: the module is a singleton
and ANY eigenspace statement about it is vacuously true (`modularForm_odd_weight_eq_zero` /
`modularForm_odd_weight_subsingleton`, FRK-24b/c, both PROVED sorry-free this run).  That is
recorded as a proved obligation of its own, not as a remark.  Consequently the EVEN-weight
content — everything indexed by `2 * m` — is the headline, and it is the only headline.

The even case is NOT vacuous, and this file exhibits the witness rather than asserting
non-vacuity — and as of run 10 the witness is PROVED, not merely stated: at weight `0`, for
EVERY `N > 0`, the constant form `ModularForm.const 1` satisfies
`frickeModularOperator hN (const 1) = (N : ℂ)⁻¹ • const 1` (FRK-25), hence
`frickeInvolution hN 0 (const 1) = const 1`, so `const 1 ∈ frickePlus hN 0`; and `const 1 ≠ 0` in
characteristic zero, so `const 1 ∉ frickeMinus hN 0`.  The two eigenspaces are therefore
DEMONSTRABLY DIFFERENT (FRK-27), unconditionally, at every level.

HONEST LIMIT OF THAT WITNESS, so no reader overstates it: it separates `frickePlus` from
`frickeMinus` by exhibiting an element of the first that is not in the second.  It does NOT
exhibit a nonzero element of `frickeMinus`, and NO UNCONDITIONAL `-1`-eigenform is produced
anywhere in this file at any `N`.  What run 14 adds on the minus side is CONDITIONAL and is
labelled as such throughout: `frickeMinus_ne_bot_level_four` (SDF-19b) shows
`frickeMinus ≠ ⊥` at `N = 4`, `m = 3` — the exponent vector of `η(2τ)^12` — GIVEN Ligozat's
condition (iii) as the hypothesis `hbd`, which this library discharges for no nontrivial exponent
vector at any level (`F3.1-OBSTRUCTED`).  That hypothesis is classically TRUE there, so the
statement is conditional rather than vacuous; but the reduction of the minus side to ONE named
condition at ONE level is the whole of the progress, and cusp boundedness remains the next
obstruction.  Note also that the `+1` witness lives at `m = 0` and this `-1` witness at `m = 3`:
NO SINGLE `(N, m)` has both eigenspaces shown nonzero, and `frickePlus ≠ frickeMinus` is still
proved only at weight `0`.

## THE ETA-QUOTIENT LIFT — read this before quoting anything from the `SDF-*` block

The eta-quotient lift ships in BOTH honest forms and neither one silently assumes modularity.

(a) CONDITIONAL, general `N`: node SDF-18 takes `f : ModularForm (Gamma0GL N) (2*m)` together
    with `hf : ∀ τ, f τ = etaQuotientH N r τ` as EXPLICIT HYPOTHESES — the eta quotient is never
    asserted to be a modular form, the caller supplies one.

(b) RESTRICTED, unconditional in Ligozat's transformation law only at `0 < N ≤ 4`, through the
    library's own sorry-free `etaQuotientModularForm` (`EtaQuotientModularity.lean:3494`).

CRITICAL CAVEAT THE PAPER MUST STATE: even form (b) is NOT unconditional.  `etaQuotientModularForm`
itself carries Ligozat's condition (iii) as the hypothesis
`hbd : ∀ γ : SL(2,ℤ), IsBoundedAtImInfty ((etaQuotientH N r) ∣[k] γ)`, which this library does not
discharge for any nontrivial exponent vector (the F3.1-OBSTRUCTED record).  So (b) is unconditional
in the TRANSFORMATION LAW and still conditional in CUSP BOUNDEDNESS, and `N ≤ 4` is the real bound
in the Lean sources — not the wider `N ∈ {1,2,3,4,5,7,13}` that appears in some prose.  The general
`N` route (`etaQuotientModularFormGeneral`, `EtaLigozatGeneral.lean:542`) additionally inherits
DRK-11's `sorry` AND needs the Kronecker-character hypothesis `hχ`, which is FALSE at `N = 17`
(`eta01_seventeen_refutes_trivial_multiplier`).  Nothing below may be quoted as "the eta quotient
is a Fricke eigenform" without one of these two hypothesis packages attached.

## The mathematics of the lift, so the constants can be checked by hand

Run 6 proved (SDF-05, sorry-free) the POINTWISE identity
`etaQuotient N r (-(1/(N z))) = frickeEigenvalue N k * z ^ k * etaQuotient N r z`, with
`frickeEigenvalue N k = I ^ (-k) * √(N ^ k)`.  That λ is NOT the slash constant: Mathlib's slash
carries `|det|^(k-1) * denom^(-k)`, which at `W_N` is `N^(k-1) * (N τ)^(-k) = N⁻¹ τ^(-k)`.  So
the slash eigenvalue is `λ / N` (SDF-17), and after the `N^(1-m)` normalisation at weight `k = 2m`
the eigenvalue is `N^(1-m) · N⁻¹ · I^(-2m) · N^m = (-1)^m`.  Every step of that computation is
pinned at literal numerals below BEFORE the general lemmas are stated
(`frickeEigenvalue_normalised_pin_*`, four pins, one of which lands on `-1`; and, for the slash
half, the eight `slash_eigen_pin_*` of run 11, which instantiate SDF-17b's whole implication at
three literal eigenfunctions and REFUTE the mirror constant `N · λ` at two of them).

## Status — UPDATED (run 11): all of `FRK-*` and all of `SDF-17` are PROVED; `SDF-18`…`SDF-20` are not

PROVED, sorry-free, every one of them: `FRK-11` (`frickeInvolution_sq`, the involution proper),
`FRK-12`…`FRK-18`, `FRK-19` (linearity, including the non-real-scalar instance `FRK-19c`),
`FRK-20` (`Module.End` packaging and `T * T = 1`), `FRK-21`/`FRK-22` (the two eigenspaces and
their membership criteria), `FRK-23a` (the decomposition) and `FRK-23b` (the sharp `IsCompl`
form), `FRK-24` (the odd-weight vacuity, now a theorem and not a remark), `FRK-25`…`FRK-27`
(the witness), and `FRK-42`…`FRK-47` (the `σ`-branch pins and the `σ` resolution lemma
they guard).  All decide-pins are proved.

NEW IN RUN 11, sorry-free: the FOUR `SDF-17` declarations — `etaQuotientH_frickeW_smul` (17a),
`slash_frickeW_of_eigen` (17b), `etaQuotientH_slash_frickeW_selfDual` (17c) and
`frickeEigenvalue_normalised_even` (17d) — together with the EIGHT new eigen-slash pins
`slash_eigen_pin_*` (`SDF-21`…`SDF-24`), two of which are negative controls refuting the
mirror constant `N · λ`.  NOT ONE of these twelve declarations mentions `ModularForm`: 17a and
17c are statements about the function `etaQuotientH N r : ℍ → ℂ`, 17b is about an arbitrary
`f : ℍ → ℂ`, 17d is an identity in `ℂ`.  So none of them can be quoted as saying an eta quotient
is a modular form, and none of them is a relabelling of an unproved bridge.

NEW IN RUN 14, sorry-free: `SDF-19a` (`frickeInvolution_etaQuotientModularForm`, the restricted
lift at `0 < N ≤ 4`), `SDF-19b` (`frickeMinus_ne_bot_level_four`, the first `-1`-eigenspace
nontriviality statement anywhere in this library), `SDF-19c` (the packaging conjunction), the
witness vector `rMinusWitness` and NINE new pins — four VALUE pins at `N = 4`,
`k ∈ {2, 4, 6, 10}` (one of them PLUS-side, so a uniformly-`+1` proof is refuted), four DECIDE
pins on the witness's arithmetic hypotheses, and one guard carrying three combinatorial negative
controls.  `SDF-19b` IS CONDITIONAL ON `hbd` (Ligozat (iii)) and says so in its own docstring.

STILL `sorry`, and NOT to be read as delivered: `SDF-20`
(`frickeMinus_ne_bot_of_etaQuotient`) — ONE declaration, carrying an `-- OPEN:` comment naming the
remaining work.  Nothing in the proved `FRK-*` block depends on it.

WHAT IS DELIBERATELY NOT CLAIMED ANYWHERE IN THIS FILE: that any eta quotient IS a modular form
at a level where this library has not proved Ligozat.  The `FRK-*` block never mentions eta
quotients at all; the `SDF-*` block takes modularity as an explicit hypothesis or restricts to
`0 < N ≤ 4`.
-/
import SocrateAI.ModularForms.FrickeComposite
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual
import SocrateAI.ModularForms.EtaLigozatKronecker
import Mathlib.Algebra.Module.Submodule.Ker

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm Complex
open UpperHalfPlane hiding I
open scoped MatrixGroups

/-! ## FRK-12 … FRK-15 — unfolding the slash by `W_N`

These four are PROVED (no `sorry`).  They are the syntactic bridge between the `GL(2,ℝ)`-slash
language of `FrickeComposite.lean` and the `-1/(N z)` normal form that
`etaQuotient_fricke_selfDual` states its conclusion in. -/

/-! ### FRK-28 — decide-pins on the determinant, stated BEFORE the general FRK-12 lemma

Sign discipline.  `frickeMatrix N = !![0, -1; N, 0]`, so by hand
`det = 0 * 0 - (-1) * N = +N`, and the three variants that a slip would produce
(`!![0, 1; -N, 0]` gives `+N` too, but `!![0, -1; -N, 0]` gives `-N`, and transposing the
`-1` gives `-N`) are separated by these pins: each evaluates `.det.val` at a LITERAL `N`
straight from `Matrix.det_fin_two_of`, WITHOUT going through `frickeW_det_val`, so a wrong
sign in `frickeMatrix` could not be hidden by a matching wrong sign in that lemma.
Hand values: `N = 1 -> 1`, `N = 2 -> 2`, `N = 12 -> 12`, and `N = 13 -> positive`.
PIN D is stated in the `0 < _` form FRK-12 itself has, at the largest level where this
library proves Ligozat, so the branch condition Mathlib's `σ` tests is pinned in the exact
shape the `if` scrutinee takes. -/

/-- **FRK-28 PIN A.**  `det W_1 = 1`, computed from `frickeMatrix` directly. -/
theorem frickeW_det_val_pin_one :
    ((frickeW (by norm_num : 0 < 1)).det.val : ℝ) = 1 := by
  rw [Matrix.GeneralLinearGroup.val_det_apply, frickeW_coe, frickeMatrix,
    Matrix.det_fin_two_of]
  norm_num

/-- **FRK-28 PIN B.**  `det W_2 = 2`, computed from `frickeMatrix` directly. -/
theorem frickeW_det_val_pin_two :
    ((frickeW (by norm_num : 0 < 2)).det.val : ℝ) = 2 := by
  rw [Matrix.GeneralLinearGroup.val_det_apply, frickeW_coe, frickeMatrix,
    Matrix.det_fin_two_of]
  norm_num

/-- **FRK-28 PIN C.**  `det W_12 = 12`, computed from `frickeMatrix` directly. -/
theorem frickeW_det_val_pin_twelve :
    ((frickeW (by norm_num : 0 < 12)).det.val : ℝ) = 12 := by
  rw [Matrix.GeneralLinearGroup.val_det_apply, frickeW_coe, frickeMatrix,
    Matrix.det_fin_two_of]
  norm_num

/-- **FRK-28 PIN D.**  `0 < det W_13`, in the exact `if`-scrutinee shape FRK-12 produces,
again computed from `frickeMatrix` rather than from `frickeW_det_val`. -/
theorem frickeW_det_val_pos_pin_thirteen :
    0 < ((frickeW (by norm_num : 0 < 13)).det.val : ℝ) := by
  rw [Matrix.GeneralLinearGroup.val_det_apply, frickeW_coe, frickeMatrix,
    Matrix.det_fin_two_of]
  norm_num

/-- **FRK-12.**  `det W_N = N > 0`, in the `.det.val` spelling Mathlib's `σ` and slash use.
This is the side condition that pins `σ (W_N)` to the IDENTITY branch rather than to complex
conjugation; every lemma below that resolves a `σ` uses it. -/
theorem frickeW_det_val_pos {N : ℕ} (hN : 0 < N) : 0 < ((frickeW hN).det.val : ℝ) := by
  rw [frickeW_det_val]; exact_mod_cast hN

/-! ### FRK-42 … FRK-46 — decide-pins on the `σ` BRANCH, stated BEFORE the general FRK-47

WHY THIS BLOCK EXISTS, and why it is the pin section this run actually needed.  Mathlib's slash
is `f ∣[k] g = σ g (f (g • τ)) · |det g|^(k-1) · denom g τ ^ (-k)`, and `σ g` is defined by a
LITERAL `if 0 < g.det.val then .refl ℝ ℂ else Complex.conjCAE`.  Every scalar that is pushed
through a slash is therefore pushed through `σ`, and the two branches DIFFER on non-real numbers
and AGREE on real ones.  FRK-11's own multiplier `N^(1-m)` is real, so a wrong branch there is
mathematically invisible: the involution would still close.  It becomes visible only at a non-real
scalar, which is what these pins evaluate.

Hand values, computed before the pins were written and independent of `frickeW_sigma_apply`:
`σ (W_2) I = I` (identity branch), whereas the conjugation branch gives `conj I = -I`, and
`I ≠ -I` because their imaginary parts are `1` and `-1`;
`σ (W_13) (1 + 2I) = 1 + 2I`, whereas conjugation gives `1 - 2I`, and `2 ≠ -2`.
FRK-44 and FRK-46 are the NEGATIVE CONTROLS: they evaluate the branch that FRK-42/FRK-43 do NOT
take and prove it lands somewhere else, so the branch resolution is REFUTED-IF-WRONG rather than
merely unchecked.  `N = 13` is the largest level at which this library proves Ligozat. -/

section SigmaBranchPins

/-- **FRK-42 (σ PIN 1)** (`N = 2`, `c = I`): the identity branch, at a NON-REAL scalar. -/
theorem frickeW_sigma_pin_two_I :
    σ (frickeW (by norm_num : 0 < 2)) Complex.I = Complex.I := by
  rw [σ, if_pos (frickeW_det_val_pos (by norm_num))]
  rfl

/-- **FRK-43 (σ PIN 2)** (`N = 13`, `c = 1 + 2I`): non-real with a nonzero REAL part too, at the
largest level where this library proves Ligozat. -/
theorem frickeW_sigma_pin_thirteen :
    σ (frickeW (by norm_num : 0 < 13)) (1 + 2 * Complex.I) = 1 + 2 * Complex.I := by
  rw [σ, if_pos (frickeW_det_val_pos (by norm_num))]
  rfl

/-- **FRK-44 (σ PIN 3 — NEGATIVE CONTROL for FRK-42).**  The branch NOT taken sends `I` to `-I`. -/
theorem frickeW_sigma_pin_conj_I : (Complex.conjCAE Complex.I : ℂ) = -Complex.I := by simp

/-- **FRK-45.**  Companion to FRK-44: `I ≠ -I`, so FRK-42 is a genuine discrimination between the
two branches and not a tautology. -/
theorem frickeW_sigma_pin_I_ne_neg_I : (Complex.I : ℂ) ≠ -Complex.I := by
  simp [Complex.ext_iff]
  norm_num

/-- **FRK-46 (σ PIN 4 — NEGATIVE CONTROL for FRK-43).**  The branch NOT taken sends `1 + 2I` to
`1 - 2I`, and the two differ. -/
theorem frickeW_sigma_pin_conj_thirteen :
    (Complex.conjCAE (1 + 2 * Complex.I) : ℂ) = 1 - 2 * Complex.I ∧
      (1 + 2 * Complex.I : ℂ) ≠ 1 - 2 * Complex.I := by
  refine ⟨by simp [Complex.ext_iff], ?_⟩
  simp [Complex.ext_iff]
  norm_num

end SigmaBranchPins

/-- **FRK-47.**  `σ (W_N)` is the IDENTITY automorphism of `ℂ`, so scalars pass through a slash by
`W_N` unconjugated.  This is FRK-12 turned into the exact rewrite that `ModularForm.smul_slash`
consumes, and it is the single step that makes FRK-19 and FRK-11 go through.  PROVED. -/
theorem frickeW_sigma_apply {N : ℕ} (hN : 0 < N) (c : ℂ) : σ (frickeW hN) c = c := by
  rw [σ, if_pos (frickeW_det_val_pos hN)]
  rfl

/-- **FRK-13.**  The automorphy denominator of `W_N` at `τ` is `N τ`. -/
theorem frickeW_denom {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    denom (frickeW hN) (τ : ℂ) = (N : ℂ) * (τ : ℂ) := by
  simp [denom, frickeMatrix]

/-! ### FRK-32 .. FRK-36 — decide-pins on the Möbius action, stated BEFORE the general FRK-14 lemma

Sign and index discipline for `W_N • τ = -(1 / (N τ))`.  Each pin evaluates the LEFT-hand side at
a LITERAL `N` and a LITERAL `τ`, straight from `coe_smul_of_det_pos` and `frickeMatrix`, and
compares it against a value computed FIRST by hand in exact Gaussian rationals (python
`fractions`/`complex`, this session) — never against `frickeW_smul_coe_neg_inv`, which is stated
below and which none of these proofs mentions.  So a wrong entry in `frickeMatrix` could not be
hidden by a matching wrong sign in the general lemma.

Hand values: `W₂ • i = -(1/(2i)) = i/2`;  `W₃ • i = -(1/(3i)) = i/3`;
`W₁ • (1+i) = -(1/(1+i)) = (-1+i)/2`;  `W₂ • (1+i) = -(1/(2+2i)) = (-1+i)/4`;
`W₁₂ • 2i = -(1/(24i)) = i/24`.

These are labelled M1..M5, NOT `PIN A..D`: that labelling is already taken in this file by the
eigenvalue-normalisation pins near the end, and reusing it would make the `FinalCheck` prose
ambiguous.

What each pin discriminates (every entry below recomputed numerically this run, not carried
forward).  M2 and M5 move `N`, so they catch a dropped `N` (`τ ↦ -1/τ` would give `i` and `i/2`).
M1, M2 and M5 catch the transpose `!![0, N; -1, 0]` (`τ ↦ -N/τ`, giving `2i`, `3i`, `6i`).
M3 and M4 are the only ones with a NONZERO REAL PART on both sides, so they catch a `b`-entry sign
flip (`!![0, 1; N, 0]`, i.e. `τ ↦ +1/(Nτ)`, giving `(1-i)/2` and `(1-i)/4`); in fact ALL five catch
that flip, since it negates the value.  M4 catches the transpose AND the sign flip simultaneously,
off the imaginary axis.  STATED SO IT IS NOT OVERCLAIMED: M3 discriminates NEITHER the transpose
NOR a dropped `N`, because at `N = 1` all three maps coincide — which is exactly why M3 alone would
not do, and why M1/M2/M4/M5 are at `N > 1`.
No pin can catch an inverted convention: `W_N² = -N·I` is scalar, so `W_N` and `W_N⁻¹` induce the
same map on `ℍ`.  The DETERMINANT is not pinned here — it is pinned separately at four literal
levels by FRK-28 above, which is why these proofs may pass `frickeW_det_val_pos` as the side
condition without circularity. -/

section FrickeSmulPins

/-- **FRK-32 (MÖBIUS PIN M1)** (`N = 2`, `τ = i`): `-(1/(2i)) = i/2`.  Transpose control. -/
theorem frickeW_smul_pin_two_I :
    ((frickeW (by norm_num : 0 < 2) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I / 2 := by
  rw [coe_smul_of_det_pos (frickeW_det_val_pos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  field_simp
  ring_nf
  simp [Complex.I_sq]

/-- **FRK-33 (MÖBIUS PIN M2)** (`N = 3`, `τ = i`): `-(1/(3i)) = i/3`.  Moves `N`; a dropped `N` gives `i`. -/
theorem frickeW_smul_pin_three_I :
    ((frickeW (by norm_num : 0 < 3) • (⟨Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ) = Complex.I / 3 := by
  rw [coe_smul_of_det_pos (frickeW_det_val_pos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  field_simp
  ring_nf
  simp [Complex.I_sq]

/-- **FRK-34 (MÖBIUS PIN M3)** (`N = 1`, `τ = 1 + i`): `-(1/(1+i)) = (-1+i)/2`.  Nonzero real part. -/
theorem frickeW_smul_pin_one_onePlusI :
    ((frickeW (by norm_num : 0 < 1) • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
      = (-1 + Complex.I) / 2 := by
  rw [coe_smul_of_det_pos (frickeW_det_val_pos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
  ring_nf
  simp [Complex.I_sq]
  ring

/-- **FRK-35 (MÖBIUS PIN M4)** (`N = 2`, `τ = 1 + i`): `-(1/(2+2i)) = (-1+i)/4`.  Off the imaginary axis
AND with `N ≠ 1`, so it separates the transpose and the `b`-flip at the same time. -/
theorem frickeW_smul_pin_two_onePlusI :
    ((frickeW (by norm_num : 0 < 2) • (⟨1 + Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
      = (-1 + Complex.I) / 4 := by
  rw [coe_smul_of_det_pos (frickeW_det_val_pos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  rw [div_eq_div_iff (by simp [Complex.ext_iff]) (by norm_num)]
  ring_nf
  simp [Complex.I_sq]
  ring

/-- **FRK-36 (MÖBIUS PIN M5)** (`N = 12`, `τ = 2i`): `-(1/(24i)) = i/24`.  The largest level pinned, and the
level the withdrawn extremal claim was asserted at; also the only pin where `τ ≠ i`. -/
theorem frickeW_smul_pin_twelve_twoI :
    ((frickeW (by norm_num : 0 < 12) • (⟨2 * Complex.I, by simp⟩ : ℍ) : ℍ) : ℂ)
      = Complex.I / 24 := by
  rw [coe_smul_of_det_pos (frickeW_det_val_pos (by norm_num))]
  simp only [num, denom, frickeW_coe, frickeMatrix]
  push_cast
  field_simp
  ring_nf
  simp [Complex.I_sq]
  -- residual numeral goal `24 = 12 * 2`, i.e. the hand value `i/24` CONFIRMED against the
  -- denominator `N * τ = 12 * 2i` that `denom` actually produced.
  norm_num

end FrickeSmulPins

/-- **FRK-14.**  `W_N • τ = -(1 / (N τ))`, in EXACTLY the syntactic form that
`etaQuotient_fricke_selfDual` uses for its argument.

DUPLICATION DISCLOSED (LL-22 honesty): run 5 already proved this statement, up to `neg_div`, as
`SocrateAI.StringTheory.frickeW_smul_coe` (TDUAL-M1), which states it as `-1 / (N τ)`.  That file
is NOT imported here — importing `SocrateAI.StringTheory.TDualityBridge` would pull a physics
module into a pure modular-forms file — so the two-line proof is repeated rather than reused, and
this note exists so nobody counts it twice as new content.

NAMED `..._neg_inv`, NOT `frickeW_smul_coe`, AND THAT NAME IS LOAD-BEARING.  The obvious name
collides with TDUAL-M1's on the BASE NAME, and `FinalCheck.lean:5200` guards TDUAL-M1 by the base
name `frickeW_smul_coe`.  With both declarations in scope that guard becomes ambiguous and
`#print axioms` emits BOTH footprints — which is exactly how this run's first `lake build` went
red.  Keep the names distinct. -/
theorem frickeW_smul_coe_neg_inv {N : ℕ} (hN : 0 < N) (τ : ℍ) :
    ((frickeW hN • τ : ℍ) : ℂ) = -(1 / ((N : ℂ) * (τ : ℂ))) := by
  rw [coe_smul_of_det_pos (frickeW_det_val_pos hN)]
  simp [num, denom, frickeMatrix]
  ring

/-! ### FRK-37 .. FRK-41 — the five SLASH-CONSTANT decide-pins, stated BEFORE the general FRK-15

The constant FRK-15 produces is `|det|^(k-1) * denom^(-k) = N^(k-1) * (N τ)^(-k)`, and a wrong
exponent on either factor (`k` for `k-1`, `+k` for `-k`) or a dropped `N` inside `denom` would all
survive a general proof that merely unfolds a definition.  The five pins below therefore evaluate
the LEFT-hand side `(f ∣[k] W_N) τ` at LITERAL `N`, LITERAL `k` and LITERAL `τ`, straight from
Mathlib's `slash_apply` together with `frickeMatrix`, and compare it against a value computed FIRST
by hand and then re-checked numerically in Python (`complex`, this session).  None of the five
proofs mentions `slash_frickeW_apply`, which is stated below them, so a wrong exponent there could
not be hidden by a matching wrong exponent here.

`f` is taken to be the CONSTANT function `1`, so the value of the slash IS the constant and nothing
else.  Hand values, for the record:

* P1 `(N,k,τ) = (2,4,i)`:  `2^3 · (2i)^(-4) = 8/16 = 1/2`;
* P2 `(3,2,i)`:            `3^1 · (3i)^(-2) = 3/(-9) = -1/3`   — the SIGN control;
* P3 `(2,3,i)`:            `2^2 · (2i)^(-3) = 4/(-8i) = i/2`   — ODD `k`, non-real value;
* P4 `(5,0,i)`:            `5^(-1) · (5i)^0 = 1/5`             — the NEGATIVE-exponent control;
* P5 `(12,2,2i)`:          `12^1 · (24i)^(-2) = 12/(-576) = -1/48`.

What each discriminates.  P1 separates the det exponent `k-1` from `k` (which would give `1`) and
the denominator exponent `-k` from `+k` (which would give `128`); it also catches a dropped `N` in
`denom` (`i^(-4)` would give `8`).  P2 is the only pin whose hand value is NEGATIVE, so a spurious
absolute value or a squared `i` of the wrong sign shows up there (a dropped `N` would give `-3`,
det exponent `k` would give `-1`).  P3 is at ODD weight and is the only pin whose value is NOT
REAL, so it is the one that would expose an `i`-power off by one.  P4 is the only pin at `k = 0`,
where the det exponent is NEGATIVE and the denominator factor is `1`; if the exponent were `k`
rather than `k - 1` the value would be `1` instead of `1/5`, so P4 alone pins that offset.  P5 is
the largest level pinned and the only pin with `τ ≠ i`.

STATED SO IT IS NOT OVERCLAIMED: because `f` is CONSTANT, `σ` is applied to `1` and acts trivially
whichever branch it takes, so NONE of these five pins discriminates the `σ` branch.  That branch is
pinned separately, at four literal levels, by the determinant pins FRK-28 .. FRK-31 above, which is
exactly the positivity side condition these proofs pass to `if_pos`; there is no circularity, since
those pins are computed from `frickeMatrix` and never from FRK-15. -/

section SlashConstantPins

/-- **FRK-37 (SLASH-CONSTANT PIN P1)** (`N = 2`, `k = 4`, `τ = i`): `2^3 · (2i)^(-4) = 1/2`. -/
theorem slash_frickeW_const_pin_two_four :
    ((fun _ => (1 : ℂ)) ∣[(4 : ℤ)] frickeW (by norm_num : 0 < 2))
        (⟨Complex.I, by simp⟩ : ℍ) = 1 / 2 := by
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num
  rw [mul_zpow, show (Complex.I) ^ (4:ℤ) = 1 by
    rw [show (4:ℤ) = ((4:ℕ):ℤ) by norm_num, zpow_natCast, Complex.I_pow_four]]
  norm_num

/-- **FRK-38 (SLASH-CONSTANT PIN P2)** (`N = 3`, `k = 2`, `τ = i`): `3 · (3i)^(-2) = -1/3`.
The SIGN control: a value of `+1/3` here would mean the `i^2` was mishandled. -/
theorem slash_frickeW_const_pin_three_two :
    ((fun _ => (1 : ℂ)) ∣[(2 : ℤ)] frickeW (by norm_num : 0 < 3))
        (⟨Complex.I, by simp⟩ : ℍ) = -(1 / 3) := by
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num
  rw [mul_zpow, show (Complex.I) ^ (2:ℤ) = -1 by
    rw [show (2:ℤ) = ((2:ℕ):ℤ) by norm_num, zpow_natCast, Complex.I_sq]]
  norm_num

/-- **FRK-39 (SLASH-CONSTANT PIN P3)** (`N = 2`, `k = 3`, `τ = i`): `4 · (2i)^(-3) = i/2`.
ODD weight, and the only pin whose value is not real. -/
theorem slash_frickeW_const_pin_two_three :
    ((fun _ => (1 : ℂ)) ∣[(3 : ℤ)] frickeW (by norm_num : 0 < 2))
        (⟨Complex.I, by simp⟩ : ℍ) = Complex.I / 2 := by
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num
  rw [mul_zpow, show (Complex.I) ^ (3:ℤ) = -Complex.I by
    rw [show (3:ℤ) = ((3:ℕ):ℤ) by norm_num, zpow_natCast, pow_succ, Complex.I_sq]; ring]
  field_simp
  ring_nf
  simp [Complex.I_sq]

/-- **FRK-40 (SLASH-CONSTANT PIN P4)** (`N = 5`, `k = 0`, `τ = i`): `5^(-1) · (5i)^0 = 1/5`.
The NEGATIVE-exponent control: with the det exponent `k` rather than `k - 1` this would be `1`. -/
theorem slash_frickeW_const_pin_five_zero :
    ((fun _ => (1 : ℂ)) ∣[(0 : ℤ)] frickeW (by norm_num : 0 < 5))
        (⟨Complex.I, by simp⟩ : ℍ) = 1 / 5 := by
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num

/-- **FRK-41 (SLASH-CONSTANT PIN P5)** (`N = 12`, `k = 2`, `τ = 2i`): `12 · (24i)^(-2) = -1/48`.
The largest level pinned and the only pin with `τ ≠ i`. -/
theorem slash_frickeW_const_pin_twelve_two :
    ((fun _ => (1 : ℂ)) ∣[(2 : ℤ)] frickeW (by norm_num : 0 < 12))
        (⟨2 * Complex.I, by simp⟩ : ℍ) = -(1 / 48) := by
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num
  rw [mul_zpow, mul_zpow, show (Complex.I) ^ (2:ℤ) = -1 by
    rw [show (2:ℤ) = ((2:ℕ):ℤ) by norm_num, zpow_natCast, Complex.I_sq]]
  norm_num

end SlashConstantPins

/-- **FRK-15.**  The slash by `W_N`, unfolded.  Mathlib's `|det|^(k-1) * denom^(-k)` normalisation
evaluated at the Fricke matrix, with the `σ` factor resolved to the identity by FRK-12.  Combined
with FRK-14 this reads `(f ∣[k] W_N) τ = N⁻¹ τ^(-k) f(-1/(N τ))`. -/
theorem slash_frickeW_apply {N : ℕ} (hN : 0 < N) {k : ℤ} (f : ℍ → ℂ) (τ : ℍ) :
    (f ∣[k] frickeW hN) τ
      = f (frickeW hN • τ) * ((N : ℂ)) ^ (k - 1) * ((N : ℂ) * (τ : ℂ)) ^ (-k) := by
  rw [slash_apply, frickeW_denom hN, σ, if_pos (frickeW_det_val_pos hN)]
  rw [frickeW_det_val, abs_of_nonneg (by positivity : (0:ℝ) ≤ (N:ℝ))]
  push_cast
  simp only [ContinuousAlgEquiv.refl_apply]

/-! ## The CONSTANT — decide-pins first, general lemmas after

Three expressions for the same number are in play and they must be PROVED equal, never assumed:

* `(N^2)^(k-1) * (-N)^(-k)`  — the shape `frickeW_sq_slash` (FRK-10) actually produces;
* `(-1)^k * N^(k-2)`          — the shape FRK-10's own docstring advertises (FRK-17);
* `N^(1-m)`                   — the normalising multiplier at weight `k = 2m` (FRK-16).

PINs 1-5 below evaluate the FIRST expression at literal numerals and compare it against the
SECOND, computed by hand (PINs 12-17 add four more two-sided instances, the missing right-hand
half of PIN 4, and an `N = 0` negative control on the hypothesis).  Hand values, for the record: `C(2,4) = 4^3/(-2)^4 = 64/16 = 4`;
`C(3,2) = 9/9 = 1`; `C(2,3) = 16/(-8) = -2` (the ODD-weight sign control — if this came out `+2`
the `(-1)^k` factor would be spurious); `C(6,12) = 6^22/6^12 = 6^10 = 60466176`;
`C(5,0) = 25⁻¹ · 1 = 1/25` (the NEGATIVE-exponent control).  All five are `norm_num`, none is
`sorry`, and if any of them disagreed with the hand value the STATEMENT would be wrong and this
run would stop rather than adjust it.

PINs 6-11 pin FRK-16 itself — the THIRD expression against the FIRST — at six further literal
instances, all computed by hand before the general lemma was written:
`(N,m) = (3,2)`, `(6,0)` (the `1-m = 1` end, where the normalisation MULTIPLIES),
`(2,3)` (the `1-m = -2` end, where it DIVIDES), `(5,-1)` (NEGATIVE `m`: both of FRK-10's
exponents flip sign), `(10,5)` (large numerals, where a wrong power of `N` cannot cancel by luck),
and finally `(3,2)` again with the exponent REVERSED to `m-1`, which comes out `81` — that pin
plus `81 ≠ 1` refutes the mirror-image statement outright, so the direction of `1 - m` is proved
forced rather than chosen. -/

section ConstantPins

/-- PIN 1 (`N = 2`, `k = 4`, even, positive exponent): `4^3 · (-2)^(-4) = 4 = (-1)^4 · 2^2`. -/
theorem frickeW_sq_const_pin_two_four :
    ((((2 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((4 : ℤ) - 1) * ((-((2 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(4 : ℤ))
      = (-1 : ℂ) ^ (4 : ℤ) * ((2 : ℕ) : ℂ) ^ ((4 : ℤ) - 2) := by
  norm_num

/-- PIN 2 (`N = 3`, `k = 2`): `9^1 · (-3)^(-2) = 1 = (-1)^2 · 3^0`. -/
theorem frickeW_sq_const_pin_three_two :
    ((((3 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 : ℤ) - 1) * ((-((3 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 : ℤ))
      = (-1 : ℂ) ^ (2 : ℤ) * ((3 : ℕ) : ℂ) ^ ((2 : ℤ) - 2) := by
  norm_num

/-- PIN 3 — THE SIGN CONTROL (`N = 2`, `k = 3`, ODD): `16 · (-2)^(-3) = -2 = (-1)^3 · 2^1`.
The value is NEGATIVE.  A statement that dropped the `(-1)^k` would give `+2` here. -/
theorem frickeW_sq_const_pin_two_three :
    ((((2 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((3 : ℤ) - 1) * ((-((2 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(3 : ℤ))
      = (-1 : ℂ) ^ (3 : ℤ) * ((2 : ℕ) : ℂ) ^ ((3 : ℤ) - 2) := by
  norm_num

/-- PIN 4 (`N = 6`, `k = 12`): `36^11 · (-6)^(-12) = 6^10 = 60466176`. -/
theorem frickeW_sq_const_pin_six_twelve :
    ((((6 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((12 : ℤ) - 1) * ((-((6 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(12 : ℤ))
      = (60466176 : ℂ) := by
  norm_num

/-- PIN 5 — THE NEGATIVE-EXPONENT CONTROL (`N = 5`, `k = 0`): `25^(-1) · 1 = 1/25`.
`k - 2 = -2` is negative here, so this pin is the one that would break if the identity were
stated with `pow` (ℕ-exponent) instead of `zpow`. -/
theorem frickeW_sq_const_pin_five_zero :
    ((((5 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((0 : ℤ) - 1) * ((-((5 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(0 : ℤ))
      = (-1 : ℂ) ^ (0 : ℤ) * ((5 : ℕ) : ℂ) ^ ((0 : ℤ) - 2) := by
  norm_num

/-- PIN 6 — the FRK-16 cancellation at `N = 3`, `m = 2` (weight `4`), by hand:
`(3^(-1))^2 · (9^3 · (-3)^(-4)) = (1/9) · (729/81) = (1/9) · 9 = 1`. -/
theorem frickeInvolution_const_pin_three_two :
    (((3 : ℕ) : ℂ) ^ ((1 : ℤ) - 2)) * (((3 : ℕ) : ℂ) ^ ((1 : ℤ) - 2))
      * (((((3 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((4 : ℤ) - 1)
          * ((-((3 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(4 : ℤ))) = 1 := by
  norm_num

/-- PIN 7 — the FRK-16 cancellation at `N = 6`, `m = 0` (weight `0`): `36 · (36⁻¹ · 1) = 1`.
`1 - m = 1` here, so the normalisation MULTIPLIES rather than divides; this is the pin that fixes
the DIRECTION of the exponent (FRK-10's node text records that an earlier wording did not). -/
theorem frickeInvolution_const_pin_six_zero :
    (((6 : ℕ) : ℂ) ^ ((1 : ℤ) - 0)) * (((6 : ℕ) : ℂ) ^ ((1 : ℤ) - 0))
      * (((((6 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((0 : ℤ) - 1)
          * ((-((6 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(0 : ℤ))) = 1 := by
  norm_num

/-- PIN 8 — the FRK-16 cancellation at `N = 2`, `m = 3` (weight `6`), by hand:
`2^(-2) · 2^(-2) · (4^5 · (-2)^(-6)) = (1/16) · (1024/64) = (1/16) · 16 = 1`.
Here `1 - m = -2` is NEGATIVE, so the normalisation genuinely divides; PIN 7 (`1 - m = 1`) and
this one bracket the sign of the multiplier exponent from both sides. -/
theorem frickeInvolution_const_pin_two_three :
    (((2 : ℕ) : ℂ) ^ ((1 : ℤ) - 3)) * (((2 : ℕ) : ℂ) ^ ((1 : ℤ) - 3))
      * (((((2 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((6 : ℤ) - 1)
          * ((-((2 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(6 : ℤ))) = 1 := by
  norm_num

/-- PIN 9 — the NEGATIVE-WEIGHT control (`N = 5`, `m = -1`, weight `-2`), by hand:
`5^2 · 5^2 · (25^(-3) · (-5)^2) = 625 · (25/15625) = 625/625 = 1`.
`m` itself is negative here, so `2*m - 1 = -3` and `-(2*m) = +2`: both exponents of FRK-10's
composite scalar flip sign relative to every other pin.  This is the instance that would break if
the identity had been stated with `pow` (ℕ-exponent) anywhere. -/
theorem frickeInvolution_const_pin_five_negone :
    (((5 : ℕ) : ℂ) ^ ((1 : ℤ) - (-1))) * (((5 : ℕ) : ℂ) ^ ((1 : ℤ) - (-1)))
      * (((((5 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((-2 : ℤ) - 1)
          * ((-((5 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(-2 : ℤ))) = 1 := by
  norm_num

/-- PIN 10 — a large-numeral instance (`N = 10`, `m = 5`, weight `10`), by hand:
`10^(-4) · 10^(-4) · (100^9 · (-10)^(-10)) = 10^(-8) · 10^(18-10) = 10^(-8) · 10^8 = 1`.
A wrong POWER OF `N` (as opposed to a wrong sign) survives the small pins by luck far more easily
than it survives this one: every mis-stated exponent here is off by a factor of at least `10`. -/
theorem frickeInvolution_const_pin_ten_five :
    (((10 : ℕ) : ℂ) ^ ((1 : ℤ) - 5)) * (((10 : ℕ) : ℂ) ^ ((1 : ℤ) - 5))
      * (((((10 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((10 : ℤ) - 1)
          * ((-((10 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(10 : ℤ))) = 1 := by
  norm_num

/-- PIN 11 — the NEGATIVE CONTROL, and the only pin here that does NOT evaluate to `1`.
Exactly PIN 6's numbers (`N = 3`, `m = 2`) with the multiplier exponent REVERSED to `m - 1`:
`3^1 · 3^1 · (9^3 · (-3)^(-4)) = 9 · 9 = 81`.  Together with
`frickeInvolution_const_pin_wrong_direction_ne_one` this PROVES that the direction of the exponent
in FRK-16 is forced and not a convention: the mirror-image statement is false. -/
theorem frickeInvolution_const_pin_wrong_direction :
    (((3 : ℕ) : ℂ) ^ ((2 : ℤ) - 1)) * (((3 : ℕ) : ℂ) ^ ((2 : ℤ) - 1))
      * (((((3 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((4 : ℤ) - 1)
          * ((-((3 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(4 : ℤ))) = 81 := by
  norm_num

/-- Companion to PIN 11: `81 ≠ 1`, so the reversed-exponent statement is refuted, not merely
unproved. -/
theorem frickeInvolution_const_pin_wrong_direction_ne_one : (81 : ℂ) ≠ 1 := by
  norm_num

/-! ### FRK-17 pins, part two — added when FRK-17 was actually proved

PINs 1-5 already pin the FIRST expression against the SECOND, but PIN 4 is ONE-SIDED (it names
the numeral `60466176` and never mentions the right-hand side), so it tests nothing about the
spelling `(-1)^k · N^(k-2)`.  PIN 12 repairs that by pinning the SECOND expression at the same
`(N,k) = (6,12)` to the same numeral, so PIN 4 and PIN 12 together form a two-sided instance.
PINs 13-16 are four further INDEPENDENTLY computed two-sided instances, chosen to attack the two
ways the statement could be wrong (a wrong sign, a wrong power of `N`) in regimes PINs 1-5 do not
reach: negative `k` with odd parity, a level that is not a prime power, and a large odd `k` where
the value is a big NEGATIVE numeral.  Hand values, recomputed this run in exact rationals:
`C(1,-3) = 1^(-4) · (-1)^3 = -1`; `C(12,2) = 144/144 = 1`; `C(7,-1) = 49^(-2) · (-7) = -1/343`;
`C(9,5) = 81^4 · (-9)^(-5) = -9^3 = -729`.
PIN 17 is the NEGATIVE CONTROL on the HYPOTHESIS: at `N = 0`, `k = 2` the identity is FALSE
(LHS `= 0^1 · 0^(-2) = 0`, RHS `= (-1)^2 · 0^0 = 1`), so `0 < N` is not decoration — dropping it
would make the lemma unprovable, and that is proved here rather than asserted. -/

/-- PIN 12 — the missing HALF of PIN 4 (`N = 6`, `k = 12`): the SECOND expression at the same
numerals, `(-1)^12 · 6^10 = 60466176`.  PIN 4 pinned only the first. -/
theorem frickeW_sq_const_pin_six_twelve_rhs :
    (-1 : ℂ) ^ (12 : ℤ) * ((6 : ℕ) : ℂ) ^ ((12 : ℤ) - 2) = (60466176 : ℂ) := by
  norm_num

/-- PIN 13 (`N = 1`, `k = -3`: ODD **and** NEGATIVE `k`, the degenerate level `N = 1`):
`1^(-4) · (-1)^3 = -1 = (-1)^(-3) · 1^(-5)`.  Both zpow exponents are negative here and the
`(-1)^(-k) = (-1)^k` step is the only thing producing the minus sign. -/
theorem frickeW_sq_const_pin_one_negthree :
    ((((1 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((-3 : ℤ) - 1) * ((-((1 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(-3 : ℤ))
      = (-1 : ℂ) ^ (-3 : ℤ) * ((1 : ℕ) : ℂ) ^ ((-3 : ℤ) - 2) := by
  norm_num

/-- PIN 14 (`N = 12`, `k = 2`: a COMPOSITE, non-prime-power level): `144^1 · (-12)^(-2) = 1`. -/
theorem frickeW_sq_const_pin_twelve_two :
    ((((12 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 : ℤ) - 1) * ((-((12 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 : ℤ))
      = (-1 : ℂ) ^ (2 : ℤ) * ((12 : ℕ) : ℂ) ^ ((2 : ℤ) - 2) := by
  norm_num

/-- PIN 15 (`N = 7`, `k = -1`: ODD and NEGATIVE, non-unit level): `49^(-2) · (-7)^1 = -1/343`.
Sign control and negative-exponent control simultaneously. -/
theorem frickeW_sq_const_pin_seven_negone :
    ((((7 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((-1 : ℤ) - 1) * ((-((7 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(-1 : ℤ))
      = (-1 : ℂ) ^ (-1 : ℤ) * ((7 : ℕ) : ℂ) ^ ((-1 : ℤ) - 2) := by
  norm_num

/-- PIN 16 (`N = 9`, `k = 5`: ODD `k`, large numerals): `81^4 · (-9)^(-5) = -729`.
A wrong power of `N` cannot cancel by luck at these magnitudes, and the value is NEGATIVE. -/
theorem frickeW_sq_const_pin_nine_five :
    ((((9 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((5 : ℤ) - 1) * ((-((9 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(5 : ℤ))
      = (-1 : ℂ) ^ (5 : ℤ) * ((9 : ℕ) : ℂ) ^ ((5 : ℤ) - 2) := by
  norm_num

/-- Companion to PIN 16: the common value is `-729`, so the pin is a genuine numeral check on
both sides and not a tautology between two unevaluated expressions. -/
theorem frickeW_sq_const_pin_nine_five_value :
    (-1 : ℂ) ^ (5 : ℤ) * ((9 : ℕ) : ℂ) ^ ((5 : ℤ) - 2) = (-729 : ℂ) := by
  norm_num

/-- PIN 17 — the NEGATIVE CONTROL on the hypothesis `0 < N`.  At `N = 0`, `k = 2` the identity is
FALSE: the left side is `0^1 · 0^(-2) = 0` (Lean's `0⁻¹ = 0`), the right side is `(-1)^2 · 0^0 = 1`.
So `frickeW_sq_const_simplify` is NOT over-hypothesised and `hN` may not be dropped in any
"generalisation" of it. -/
theorem frickeW_sq_const_pin_zero_two_false :
    ((((0 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 : ℤ) - 1) * ((-((0 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 : ℤ))
      ≠ (-1 : ℂ) ^ (2 : ℤ) * ((0 : ℕ) : ℂ) ^ ((2 : ℤ) - 2) := by
  norm_num


/-! ### SDF-25 pins, group (i) — the CONSTANT at the four `(N,k)` the SDF-25 node names

Added run 15.  PINs 1-17 above already bracket FRK-17's constant, but at their own instances; the
SDF-25 node states its group (i) at `(N,k) = (4,6), (2,2), (3,-2), (5,4)` and those four literals
appear nowhere above.  Each pin below is TWO-SIDED and lands on an explicit NUMERAL: FRK-10's
spelling `(N^2)^(k-1) · (-N)^(-k)` and the target spelling `(-1)^k · N^(k-2)` are each evaluated
against the hand value, so a mis-stated right-hand side is refuted rather than merely unproved.
Hand values, recomputed this run in exact rationals BEFORE the file was compiled:
`C(4,6) = 16^5 / 4^6 = 1048576/4096 = 256 = 4^4`;
`C(2,2) = 4/4 = 1 = 2^0`;
`C(3,-2) = 9^(-3) · (-3)^2 = 9/729 = 1/81 = 3^(-4)`;
`C(5,4) = 25^3 / 5^4 = 15625/625 = 25 = 5^2`.

HONEST LIMIT OF THIS GROUP, stated because the node's own text does not: all four of these `k` are
EVEN, so `(-1)^k = 1` at every one of them and NONE of them can see a dropped sign.  The sign is
pinned elsewhere and only elsewhere — `frickeW_sq_const_pin_two_three` (`k = 3`),
`frickeW_sq_const_pin_one_negthree` (`k = -3`), `frickeW_sq_const_pin_seven_negone` (`k = -1`),
`frickeW_sq_const_pin_nine_five` (`k = 5`).  What this group adds is a two-sided check on the
POWER OF `N` at four fresh levels, one of them at negative `k`. -/

/-- **SDF-25 (i)-1** (`N = 4`, `k = 6`): `16^5 · (-4)^(-6) = 256 = (-1)^6 · 4^4`, both sides
against the numeral. -/
theorem sdf25_pin_const_four_six :
    ((((4 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((6 : ℤ) - 1) * ((-((4 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(6 : ℤ))
      = (256 : ℂ)
    ∧ (-1 : ℂ) ^ (6 : ℤ) * ((4 : ℕ) : ℂ) ^ ((6 : ℤ) - 2) = (256 : ℂ) := by
  constructor <;> norm_num

/-- **SDF-25 (i)-2** (`N = 2`, `k = 2`): both spellings equal `1`.  The degenerate instance where
`k - 2 = 0`, so a wrong power of `N` shows only through the FIRST spelling. -/
theorem sdf25_pin_const_two_two :
    ((((2 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 : ℤ) - 1) * ((-((2 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 : ℤ))
      = (1 : ℂ)
    ∧ (-1 : ℂ) ^ (2 : ℤ) * ((2 : ℕ) : ℂ) ^ ((2 : ℤ) - 2) = (1 : ℂ) := by
  constructor <;> norm_num

/-- **SDF-25 (i)-3** (`N = 3`, `k = -2`: NEGATIVE `k`): both spellings equal `1/81`, and the third
conjunct is the NEGATIVE CONTROL — the same right-hand side with the exponent `k - 2` mis-stated
as `k - 1` gives `1/27`, which is refuted here.  So the power of `N` is proved forced at this
instance rather than assumed. -/
theorem sdf25_pin_const_three_neg_two :
    ((((3 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((-2 : ℤ) - 1) * ((-((3 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(-2 : ℤ))
      = (81 : ℂ)⁻¹
    ∧ (-1 : ℂ) ^ (-2 : ℤ) * ((3 : ℕ) : ℂ) ^ ((-2 : ℤ) - 2) = (81 : ℂ)⁻¹
    ∧ (-1 : ℂ) ^ (-2 : ℤ) * ((3 : ℕ) : ℂ) ^ ((-2 : ℤ) - 1) ≠ (81 : ℂ)⁻¹ := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **SDF-25 (i)-4** (`N = 5`, `k = 4`): `25^3 · (-5)^(-4) = 25 = (-1)^4 · 5^2`. -/
theorem sdf25_pin_const_five_four :
    ((((5 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((4 : ℤ) - 1) * ((-((5 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(4 : ℤ))
      = (25 : ℂ)
    ∧ (-1 : ℂ) ^ (4 : ℤ) * ((5 : ℕ) : ℂ) ^ ((4 : ℤ) - 2) = (25 : ℂ) := by
  constructor <;> norm_num

/-! ### SDF-25 pins, group (ii) — the NORMALISATION at the four `(N,m)` the SDF-25 node names

`(N,m) = (4,3), (2,1), (3,-1), (5,2)`, none of which appears in PINs 6-11.  Each states
`(N^(1-m))^2 · C(N, 2m) = 1` with the weight written in the node's own `2 * m` spelling, so the
`2 * m` never has to be normalised away by hand.  Hand values, recomputed this run:
`(4,3): (1/16)^2 · 256 = 1`; `(2,1): 1 · 1 = 1`; `(3,-1): 9^2 · (1/81) = 1`;
`(5,2): (1/5)^2 · 25 = 1`.  Group (ii) reuses group (i)'s four constants exactly, which is the
point: the same numeral is checked twice, once against the classical spelling and once against
the cancellation. -/

/-- **SDF-25 (ii)-1** (`N = 4`, `m = 3`, weight `2*3 = 6`): `(4^(-2))^2 · 256 = 1`. -/
theorem sdf25_pin_norm_four_three :
    (((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 3)) * (((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 3))
      * (((((4 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 * 3 : ℤ) - 1)
          * ((-((4 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 * 3 : ℤ))) = 1 := by
  norm_num

/-- **SDF-25 (ii)-2** (`N = 2`, `m = 1`, weight `2`): the instance where `1 - m = 0` and the
normalisation is trivial, so the constant must already be `1` on its own. -/
theorem sdf25_pin_norm_two_one :
    (((2 : ℕ) : ℂ) ^ ((1 : ℤ) - 1)) * (((2 : ℕ) : ℂ) ^ ((1 : ℤ) - 1))
      * (((((2 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 * 1 : ℤ) - 1)
          * ((-((2 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 * 1 : ℤ))) = 1 := by
  norm_num

/-- **SDF-25 (ii)-3** (`N = 3`, `m = -1`, weight `-2`): NEGATIVE `m`, so `1 - m = 2` and the
normalisation MULTIPLIES by `81` while the constant divides by it. -/
theorem sdf25_pin_norm_three_neg_one :
    (((3 : ℕ) : ℂ) ^ ((1 : ℤ) - (-1))) * (((3 : ℕ) : ℂ) ^ ((1 : ℤ) - (-1)))
      * (((((3 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 * (-1) : ℤ) - 1)
          * ((-((3 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 * (-1) : ℤ))) = 1 := by
  norm_num

/-- **SDF-25 (ii)-4** (`N = 5`, `m = 2`, weight `4`), WITH ITS OWN NEGATIVE CONTROL: the second
conjunct is the same instance with the normalising exponent reversed to `m - 1`, which gives
`5 · 5 · 25 = 625 ≠ 1`.  The direction of `1 - m` is therefore refuted-if-wrong at this instance
too, and not only at `(3,2)` (`frickeInvolution_const_pin_wrong_direction`). -/
theorem sdf25_pin_norm_five_two :
    (((5 : ℕ) : ℂ) ^ ((1 : ℤ) - 2)) * (((5 : ℕ) : ℂ) ^ ((1 : ℤ) - 2))
      * (((((5 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 * 2 : ℤ) - 1)
          * ((-((5 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 * 2 : ℤ))) = 1
    ∧ (((5 : ℕ) : ℂ) ^ ((2 : ℤ) - 1)) * (((5 : ℕ) : ℂ) ^ ((2 : ℤ) - 1))
      * (((((5 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 * 2 : ℤ) - 1)
          * ((-((5 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 * 2 : ℤ))) ≠ 1 := by
  refine ⟨by norm_num, by norm_num⟩

end ConstantPins

/-- **FRK-16.**  THE constant identity the whole involution rests on: at weight `2 * m` the square
of the normalisation `N^(1-m)` cancels FRK-10's composite scalar exactly.  No parity case split is
needed — the exponent `-(2*m)` is manifestly even, so `Even.neg_zpow` disposes of the negative
base directly.  PROVED (reproduced from `scratch_gate0/Probe11d.lean`). -/
theorem frickeInvolution_const_reconcile {N : ℕ} (hN : 0 < N) (m : ℤ) :
    ((N : ℂ) ^ (1 - m)) * ((N : ℂ) ^ (1 - m))
      * ((((N : ℝ) ^ 2 : ℝ) : ℂ) ^ (2 * m - 1) * ((-(N : ℝ) : ℝ) : ℂ) ^ (-(2 * m))) = 1 := by
  have hN0 : ((N : ℂ)) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  have e1 : ((((N : ℝ) ^ 2 : ℝ) : ℂ)) = (N : ℂ) ^ (2 : ℤ) := by
    rw [zpow_two]; push_cast; ring
  have e2 : (((-(N : ℝ) : ℝ) : ℂ)) = -(N : ℂ) := by push_cast; ring
  have heven : Even (-(2 * m)) := ⟨-m, by ring⟩
  rw [e1, e2, ← _root_.zpow_mul, heven.neg_zpow, ← zpow_add₀ hN0, ← zpow_add₀ hN0, ← zpow_add₀ hN0,
      show (1 - m + (1 - m) + (2 * (2 * m - 1) + -(2 * m))) = (0:ℤ) by ring, zpow_zero]

/-- **FRK-17.**  The spelling change promised in `frickeW_sq_slash`'s docstring but never proved
there: the composite scalar in its `(-1)^k · N^(k-2)` form, at GENERAL (not necessarily even) `k`.
Needed for the paper's prose and for any statement quantified over `k` rather than over `2*m`.
PROVED.

`hN` is load-bearing, not decoration: PIN 17 above refutes the `N = 0` instance outright.

NO PARITY SPLIT IS NEEDED, and the earlier `-- OPEN:` note here claiming otherwise was wrong.
It is true that Mathlib has no general `neg_zpow` (only `Even.neg_zpow` / `Odd.neg_zpow`, checked
by a whole-Mathlib grep), but the negative base is never raised to `-k` in isolation: `mul_zpow`
splits `(-1 · N)^(-k)` into `(-1)^(-k) · N^(-k)`, and `(-1 : ℂ)^(-k) = (-1 : ℂ)^k` follows without
any case analysis from `zpow_neg` plus `(-1)^k · (-1)^k = ((-1)·(-1))^k = 1^k = 1`, i.e. `(-1)^k`
is its own inverse.  `Int.even_or_odd` is not used anywhere below. -/
theorem frickeW_sq_const_simplify {N : ℕ} (hN : 0 < N) (k : ℤ) :
    (((N : ℝ) ^ 2 : ℝ) : ℂ) ^ (k - 1) * ((-(N : ℝ) : ℝ) : ℂ) ^ (-k)
      = (-1 : ℂ) ^ k * (N : ℂ) ^ (k - 2) := by
  have hN0 : ((N : ℂ)) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  have e1 : ((((N : ℝ) ^ 2 : ℝ) : ℂ)) = (N : ℂ) ^ (2 : ℤ) := by
    rw [zpow_two]; push_cast; ring
  have e2 : (((-(N : ℝ) : ℝ) : ℂ)) = (-1 : ℂ) * (N : ℂ) := by push_cast; ring
  have hsq : ((-1 : ℂ) ^ k) * ((-1 : ℂ) ^ k) = 1 := by
    rw [← mul_zpow]; norm_num
  have hinv : (-1 : ℂ) ^ (-k) = (-1 : ℂ) ^ k := by
    rw [_root_.zpow_neg]; exact inv_eq_of_mul_eq_one_right hsq
  rw [e1, e2, mul_zpow, hinv, ← _root_.zpow_mul,
      mul_comm ((-1 : ℂ) ^ k) ((N : ℂ) ^ (-k)), ← mul_assoc, ← zpow_add₀ hN0,
      show (2 * (k - 1) + -k) = k - 2 by ring, mul_comm]

/-! ## FRK-18 / FRK-11 — the normalised operator and its square -/

/-! ### FRK-18 pins — WHY the multiplier is `N^(1-m)`, pinned BEFORE the definition

`frickeInvolution` is a DEFINITION, so it owes no proof.  What it does owe is a reason that its
constant is the classical Atkin–Lehner one and not a convention chosen to make a later lemma
close.  That reason is an arithmetic identity, and it is pinned at literal numerals here, before
the definition, exactly as the FRK-16/FRK-17 constants are pinned above.

THE IDENTITY.  Mathlib's slash carries `|det g|^(k-1) · denom(g,τ)^(-k)`; at `g = W_N` (where
`det = N` by `frickeMatrix_det` and `denom = N·τ` by `frickeW_denom`) that is
`N^(k-1) · (N τ)^(-k) = N^(-1) · τ^(-k)`.  The classical Atkin–Lehner normalisation instead reads
`(f|W_N)(τ) = N^(-k/2) · τ^(-k) · f(-1/(N τ))`.  The factor converting one into the other is
therefore `N^(-k/2) / N^(-1) = N^(1 - k/2)`, which at `k = 2*m` is the literal `N^(1-m)` of the
definition below.  Stated with NO `Int` division anywhere — which is the whole reason the weight
is indexed as `2*m` — that is

    `N^(-m)  =  N^(1-m) · N^(-1)`      (`m : ℤ`, `N > 0`),

left side the CLASSICAL constant at weight `2*m`, right side `frickeInvolution`'s multiplier times
the `N^(-1)` Mathlib's slash already supplies.  Each pin below states that instance AND the
literal value of both sides, so no pin is a tautology between two unevaluated expressions.

Hand values, computed before the pins were written:
`(N,m) = (4,1)`: `4^(-1) = 1/4` and `4^0 · 4^(-1) = 1/4` — the `1-m = 0` end, multiplier trivial;
`(9,3)`: `9^(-3) = 1/729` and `9^(-2) · 9^(-1) = 1/729` — `1-m = -2 < 0`, multiplier DIVIDES;
`(7,0)`: `7^0 = 1` and `7^1 · 7^(-1) = 1` — `1-m = 1 > 0`, multiplier MULTIPLIES;
`(5,-2)`: `5^2 = 25` and `5^3 · 5^(-1) = 25` — NEGATIVE `m`, weight `-4`.
PIN 22 is the negative control: the mirror-image multiplier `N^(1+m)` gives `9^4 · 9^(-1) = 729`
at `(9,3)`, which is `729 ≠ 1/729`, so the sign of `m` in the exponent is FORCED, not chosen. -/

section MultiplierPins

/-- PIN 18 (`N = 4`, `m = 1`, weight `2`; `1 - m = 0`, multiplier trivial). -/
theorem frickeInvolution_mult_pin_four_one :
    ((4 : ℕ) : ℂ) ^ (-(1 : ℤ)) = ((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 1) * ((4 : ℕ) : ℂ) ^ (-(1 : ℤ))
      ∧ ((4 : ℕ) : ℂ) ^ (-(1 : ℤ)) = (1 / 4 : ℂ) := by
  norm_num

/-- PIN 19 (`N = 9`, `m = 3`, weight `6`; `1 - m = -2`, multiplier DIVIDES). -/
theorem frickeInvolution_mult_pin_nine_three :
    ((9 : ℕ) : ℂ) ^ (-(3 : ℤ)) = ((9 : ℕ) : ℂ) ^ ((1 : ℤ) - 3) * ((9 : ℕ) : ℂ) ^ (-(1 : ℤ))
      ∧ ((9 : ℕ) : ℂ) ^ (-(3 : ℤ)) = (1 / 729 : ℂ) := by
  norm_num

/-- PIN 20 (`N = 7`, `m = 0`, weight `0`; `1 - m = 1`, multiplier MULTIPLIES). -/
theorem frickeInvolution_mult_pin_seven_zero :
    ((7 : ℕ) : ℂ) ^ (-(0 : ℤ)) = ((7 : ℕ) : ℂ) ^ ((1 : ℤ) - 0) * ((7 : ℕ) : ℂ) ^ (-(1 : ℤ))
      ∧ ((7 : ℕ) : ℂ) ^ (-(0 : ℤ)) = (1 : ℂ) := by
  norm_num

/-- PIN 21 — the NEGATIVE-`m` control (`N = 5`, `m = -2`, weight `-4`).  Both exponents are
positive here, so this is the instance a `pow`/`zpow` confusion would survive nowhere else. -/
theorem frickeInvolution_mult_pin_five_neg :
    ((5 : ℕ) : ℂ) ^ (-(-2 : ℤ)) = ((5 : ℕ) : ℂ) ^ ((1 : ℤ) - (-2)) * ((5 : ℕ) : ℂ) ^ (-(1 : ℤ))
      ∧ ((5 : ℕ) : ℂ) ^ (-(-2 : ℤ)) = (25 : ℂ) := by
  norm_num

/-- PIN 22 — THE NEGATIVE CONTROL on the SIGN of `m` in the multiplier.  Replacing `N^(1-m)` by
`N^(1+m)` at PIN 19's numbers gives `9^4 · 9^(-1) = 729`, not `9^(-3) = 1/729`.  So the
mirror-image definition is REFUTED, and `1 - m` is forced rather than conventional. -/
theorem frickeInvolution_mult_pin_wrong_dir :
    ((9 : ℕ) : ℂ) ^ ((1 : ℤ) + 3) * ((9 : ℕ) : ℂ) ^ (-(1 : ℤ)) ≠ ((9 : ℕ) : ℂ) ^ (-(3 : ℤ)) := by
  norm_num

end MultiplierPins


/-- **FRK-18.**  The normalised Fricke operator on bundled modular forms.

The weight is indexed as `2 * m`, NOT as `k` with a separate `Even k` hypothesis, so that the
normalising exponent `1 - m` is a literal integer-linear expression and no `Int` division `k / 2`
ever appears.  The `ℂ`-scalar action on `ModularForm` is Mathlib's `instSMulℂ`, available because
`Gamma0GL N = (Gamma0 N).map (mapGL ℝ)` carries the `HasDetOne` instance. -/
noncomputable def frickeInvolution {N : ℕ} (hN : 0 < N) (m : ℤ) :
    ModularForm (Gamma0GL N) (2 * m) → ModularForm (Gamma0GL N) (2 * m) :=
  fun f => ((N : ℂ) ^ (1 - m)) • frickeModularOperator hN f

@[simp] theorem frickeInvolution_apply {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) (τ : ℍ) :
    frickeInvolution hN m f τ = ((N : ℂ) ^ (1 - m)) * (⇑f ∣[(2 * m : ℤ)] frickeW hN) τ := by
  -- PROVED: every step is definitional.  `frickeInvolution` is a `•`, whose `ModularForm` coe is
  -- `rfl` (`ModularForm.IsGLPos.coe_smul`), and `frickeModularOperator`'s coe is `rfl` through
  -- `frickeSlashOperator_coe`.
  rfl

/-- **FRK-11** (UPDATE of the existing open node, not a new id).  The normalised Fricke operator
squares to the identity on `ModularForm (Gamma0GL N) (2 * m)`.  This is the involution proper, and
it is what makes the `±1` eigenspace decomposition below meaningful. -/
theorem frickeInvolution_sq {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) :
    frickeInvolution hN m (frickeInvolution hN m f) = f := by
  -- PROVED.  Four steps, exactly as the node predicted:
  --  1. `ModularForm.ext` down to `ℍ → ℂ`;
  --  2. push the inner scalar past the outer slash with Mathlib's `ModularForm.smul_slash`,
  --     whose `σ (W_N)` factor is resolved to the identity by FRK-47 (pinned at the NON-REAL
  --     scalars `I` and `1 + 2I` by FRK-42…FRK-46 — the conjugating branch is invisible at the
  --     real multiplier `N^(1-m)` this proof actually uses, which is why those pins exist);
  --  3. collapse the two remaining slashes with `frickeW_sq_slash` (FRK-10);
  --  4. cancel the resulting scalar with `frickeInvolution_const_reconcile` (FRK-16).
  ext τ
  rw [frickeInvolution_apply hN m]
  show ((N : ℂ) ^ (1 - m)) * ((((N : ℂ) ^ (1 - m)) • (⇑f ∣[(2 * m : ℤ)] frickeW hN))
      ∣[(2 * m : ℤ)] frickeW hN) τ = f τ
  rw [ModularForm.smul_slash, frickeW_sigma_apply hN]
  show ((N : ℂ) ^ (1 - m)) * (((N : ℂ) ^ (1 - m)) *
      (((⇑f ∣[(2 * m : ℤ)] frickeW hN) ∣[(2 * m : ℤ)] frickeW hN) τ)) = f τ
  rw [frickeW_sq_slash hN, ← mul_assoc, ← mul_assoc,
      frickeInvolution_const_reconcile hN m, one_mul]

/-- **FRK-48 — the STATEMENT PIN on FRK-11's normalisation: it is the classical Atkin–Lehner one.**

`frickeInvolution` is defined through Mathlib's `GL(2,ℝ)`-slash, which carries
`|det g|^(k-1) · denom(g,τ)^(-k)`.  The classical Atkin–Lehner normalisation is instead written
`(f|W_N)(τ) = N^(-k/2) · τ^(-k) · f(-1/(N τ))`.  Those are two different expressions and their
agreement is a THEOREM, not a convention — this is it, at `k = 2*m`:

    `frickeInvolution hN m f τ = N^(-m) · τ^(-2m) · f (W_N • τ)`,

and `((W_N • τ : ℍ) : ℂ) = -(1 / (N τ))` is FRK-14 (`frickeW_smul_coe_neg_inv`), so the right-hand
side is literally `N^(-k/2) τ^(-k) f(-1/(N τ))`.  The exponent arithmetic is
`(1-m) + (2m-1) + (-2m) = -m`; the instance `N^(-m) = N^(1-m) · N^(-1)` is pinned at literal
numerals, with a negative control, by PINs 18-22 above.  PROVED. -/
theorem frickeInvolution_apply_classical {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) (τ : ℍ) :
    frickeInvolution hN m f τ
      = (N : ℂ) ^ (-m) * (τ : ℂ) ^ (-(2 * m)) * f (frickeW hN • τ) := by
  have hN0 : ((N : ℂ)) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  rw [frickeInvolution_apply hN m, slash_frickeW_apply hN, mul_zpow]
  rw [show ((N : ℂ) ^ (1 - m) * (f (frickeW hN • τ) * (N : ℂ) ^ (2 * m - 1)
        * ((N : ℂ) ^ (-(2 * m)) * (τ : ℂ) ^ (-(2 * m)))))
      = ((N : ℂ) ^ (1 - m) * (N : ℂ) ^ (2 * m - 1) * (N : ℂ) ^ (-(2 * m)))
        * (τ : ℂ) ^ (-(2 * m)) * f (frickeW hN • τ) by ring]
  rw [← zpow_add₀ hN0, ← zpow_add₀ hN0,
      show (1 - m + (2 * m - 1) + -(2 * m)) = -m by ring]

/-! ## FRK-19 / FRK-20 — linearity, and the operator as a `Module.End` -/

/-- **FRK-19a.**  Additivity of the raw Fricke operator. -/
theorem frickeModularOperator_add {N : ℕ} (hN : 0 < N) {k : ℤ}
    (f g : ModularForm (Gamma0GL N) k) :
    frickeModularOperator hN (f + g) = frickeModularOperator hN f + frickeModularOperator hN g := by
  -- PROVED.  Mechanical, as predicted.
  ext τ
  show ((⇑f + ⇑g) ∣[k] frickeW hN) τ = (⇑f ∣[k] frickeW hN) τ + (⇑g ∣[k] frickeW hN) τ
  rw [SlashAction.add_slash]
  rfl

/-- **FRK-19b.**  Complex homogeneity of the raw Fricke operator.

THE PLACE A WRONG BRANCH HIDES.  Mathlib's `ModularForm.smul_slash` reads
`(c • f) ∣[k] A = σ A c • f ∣[k] A`, and `σ A` is complex conjugation when `det A < 0`.  For
`A = W_N` the determinant is `+N > 0` (FRK-12), so `σ` is the identity and the scalar comes
through unconjugated — but at a REAL scalar the two branches agree, so this must be checked at a
NON-REAL `c`, which is what `frickeModularOperator_smul_pin_I` below does. -/
theorem frickeModularOperator_smul {N : ℕ} (hN : 0 < N) {k : ℤ} (c : ℂ)
    (f : ModularForm (Gamma0GL N) k) :
    frickeModularOperator hN (c • f) = c • frickeModularOperator hN f := by
  -- PROVED.  The `σ` resolution is FRK-47, whose branch is pinned at the non-real scalars
  -- `I` and `1 + 2I` by FRK-42…FRK-46.
  ext τ
  show ((c • ⇑f) ∣[k] frickeW hN) τ = c • ((⇑f ∣[k] frickeW hN) τ)
  rw [ModularForm.smul_slash, frickeW_sigma_apply hN]
  rfl

/-- **FRK-19c — the non-real pin for FRK-19b.**  At `c = I` the conjugating branch would give
`-I` and the identity branch gives `+I`; the two differ, so this pin actually tests the `σ`
resolution that a real scalar could not. -/
theorem frickeModularOperator_smul_pin_I {N : ℕ} (hN : 0 < N) {k : ℤ}
    (f : ModularForm (Gamma0GL N) k) :
    frickeModularOperator hN (Complex.I • f) = Complex.I • frickeModularOperator hN f :=
  -- PROVED as an instance of FRK-19b; kept as a separate named declaration so the non-real case
  -- has its own guard and cannot be lost if FRK-19b is ever restated at real scalars.
  frickeModularOperator_smul hN Complex.I f

/-- **FRK-20a.**  The normalised Fricke operator as a `ℂ`-linear endomorphism.  This is what makes
the eigenspaces `Submodule`s rather than bare predicates. -/
noncomputable def frickeInvolutionLM {N : ℕ} (hN : 0 < N) (m : ℤ) :
    Module.End ℂ (ModularForm (Gamma0GL N) (2 * m)) where
  toFun := frickeInvolution hN m
  -- PROVED: FRK-19a, after unfolding `frickeInvolution` and using `smul_add`.
  map_add' f g := by
    show ((N : ℂ) ^ (1 - m)) • frickeModularOperator hN (f + g) = _
    rw [frickeModularOperator_add hN, smul_add]
    rfl
  -- PROVED: FRK-19b, after unfolding `frickeInvolution` and using `smul_comm`.
  map_smul' c f := by
    show ((N : ℂ) ^ (1 - m)) • frickeModularOperator hN (c • f) = _
    rw [frickeModularOperator_smul hN, smul_comm]
    rfl

@[simp] theorem frickeInvolutionLM_apply {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) :
    frickeInvolutionLM hN m f = frickeInvolution hN m f := rfl

/-- **FRK-20b.**  The endomorphism is an involution IN `Module.End`, i.e. `T * T = 1`. -/
theorem frickeInvolutionLM_sq {N : ℕ} (hN : 0 < N) (m : ℤ) :
    (frickeInvolutionLM hN m) * (frickeInvolutionLM hN m) = 1 := by
  -- PROVED: `LinearMap.ext` then FRK-11.
  refine LinearMap.ext fun f => ?_
  show frickeInvolution hN m (frickeInvolution hN m f) = f
  exact frickeInvolution_sq hN m f

/-! ## FRK-21 / FRK-22 — the two eigenspaces -/

/-- **FRK-21a.**  The `+1` Fricke eigenspace, as a genuine `Submodule`. -/
noncomputable def frickePlus {N : ℕ} (hN : 0 < N) (m : ℤ) :
    Submodule ℂ (ModularForm (Gamma0GL N) (2 * m)) :=
  LinearMap.ker (frickeInvolutionLM hN m - 1)

/-- **FRK-21b.**  The `-1` Fricke eigenspace, as a genuine `Submodule`. -/
noncomputable def frickeMinus {N : ℕ} (hN : 0 < N) (m : ℤ) :
    Submodule ℂ (ModularForm (Gamma0GL N) (2 * m)) :=
  LinearMap.ker (frickeInvolutionLM hN m + 1)

/-- **FRK-22a.**  Membership in `frickePlus`, unfolded to the eigenvector equation. -/
theorem frickePlus_mem_iff {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) :
    f ∈ frickePlus hN m ↔ frickeInvolution hN m f = f := by
  -- PROVED: `LinearMap.mem_ker`, `LinearMap.sub_apply`, `sub_eq_zero`.  Mechanical.
  rw [frickePlus, LinearMap.mem_ker, LinearMap.sub_apply, sub_eq_zero]
  exact Iff.rfl

/-- **FRK-22b.**  Membership in `frickeMinus`, unfolded to the eigenvector equation. -/
theorem frickeMinus_mem_iff {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) :
    f ∈ frickeMinus hN m ↔ frickeInvolution hN m f = -f := by
  -- PROVED: `LinearMap.mem_ker`, `LinearMap.add_apply`, `add_eq_zero_iff_eq_neg`.  Mechanical.
  rw [frickeMinus, LinearMap.mem_ker, LinearMap.add_apply, add_eq_zero_iff_eq_neg]
  exact Iff.rfl

/-- **FRK-22c — the PACKAGING declaration, so one `lean_name` resolves the whole node.**

`FRK-22` asserts TWO theorems, but `dag/check_dag.py` verifies a node by base-name match on a
SINGLE `lean_name` field, so naming `frickePlus_mem_iff` alone left `frickeMinus_mem_iff`
unchecked by the DAG gate (a bookkeeping gap, not a mathematical one).  This conjunction is the
node's resolving name: a `#print axioms` on it reports the axioms of BOTH halves, so a `sorry` in
either one would surface here.  It adds no mathematical content beyond FRK-22a/b. -/
theorem frickeEigenspace_mem_iff {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) :
    (f ∈ frickePlus hN m ↔ frickeInvolution hN m f = f)
      ∧ (f ∈ frickeMinus hN m ↔ frickeInvolution hN m f = -f) :=
  ⟨frickePlus_mem_iff hN m f, frickeMinus_mem_iff hN m f⟩

/-! ### FRK-50 — the eigenspaces in CLASSICAL form

FRK-22 unfolds membership to `frickeInvolution hN m f = ± f`, and `frickeInvolution` is defined
through Mathlib's `GL(2,ℝ)`-slash, which carries `|det g|^(k-1) · denom(g,τ)^(-k)` — NOT the
classical Atkin–Lehner normalisation `N^(-k/2) τ^(-k) f(-1/(N τ))`.  Read on its own, FRK-22 is
therefore a statement about an operator whose normalisation is not visibly the classical one, and
calling `frickePlus` "the Atkin–Lehner `+1` eigenspace" would be an unpinned claim.

FRK-50 removes that gap by composing FRK-22 with FRK-48 (`frickeInvolution_apply_classical`):
membership in `frickePlus` / `frickeMinus` is EXACTLY the classical eigenform equation, pointwise
on `ℍ`.  With FRK-14 (`((frickeW hN • τ : ℍ) : ℂ) = -(1 / (N τ))`) the right-hand side reads
`N^(-k/2) · τ^(-k) · f(-1/(N τ)) = ± f(τ)` at `k = 2 * m`.  No new mathematics; it is the
STATEMENT PIN that makes FRK-22 mean what the prose says it means. -/

/-- **FRK-50a.**  `f ∈ frickePlus` is exactly the classical `+1` Atkin–Lehner eigenform equation
`N^(-k/2) τ^(-k) f(W_N • τ) = f τ` at `k = 2 * m`. -/
theorem frickePlus_mem_iff_classical {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) :
    f ∈ frickePlus hN m
      ↔ ∀ τ : ℍ, (N : ℂ) ^ (-m) * (τ : ℂ) ^ (-(2 * m)) * f (frickeW hN • τ) = f τ := by
  rw [frickePlus_mem_iff hN m f]
  constructor
  · intro h τ
    rw [← frickeInvolution_apply_classical hN m f τ, h]
  · intro h
    ext τ
    rw [frickeInvolution_apply_classical hN m f τ]
    exact h τ

/-- **FRK-50b.**  `f ∈ frickeMinus` is exactly the classical `-1` Atkin–Lehner eigenform equation
`N^(-k/2) τ^(-k) f(W_N • τ) = -f τ` at `k = 2 * m`. -/
theorem frickeMinus_mem_iff_classical {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) :
    f ∈ frickeMinus hN m
      ↔ ∀ τ : ℍ, (N : ℂ) ^ (-m) * (τ : ℂ) ^ (-(2 * m)) * f (frickeW hN • τ) = -(f τ) := by
  rw [frickeMinus_mem_iff hN m f]
  constructor
  · intro h τ
    rw [← frickeInvolution_apply_classical hN m f τ, h, ModularForm.neg_apply]
  · intro h
    ext τ
    rw [frickeInvolution_apply_classical hN m f τ, ModularForm.neg_apply]
    exact h τ

/-! ## FRK-23 — THE EIGENSPACE DECOMPOSITION -/

/-- **FRK-23a — the headline.**  Every modular form of weight `2 * m` on `Γ₀(N)` splits as a sum
of a `+1`-eigenform and a `-1`-eigenform of the normalised Fricke involution. -/
theorem fricke_decomposition {N : ℕ} (hN : 0 < N) (m : ℤ)
    (f : ModularForm (Gamma0GL N) (2 * m)) :
    ∃ fp ∈ frickePlus hN m, ∃ fm ∈ frickeMinus hN m, f = fp + fm := by
  -- PROVED by the explicit projections `fp = (1/2) • (f + T f)`, `fm = (1/2) • (f - T f)`, with
  -- `T = frickeInvolutionLM`.  Membership is FRK-22 + FRK-11 + FRK-19; the sum is `smul`
  -- arithmetic in characteristic zero.  Direct from FRK-11; needs no `IsCompl` machinery.
  have hTT : ∀ g : ModularForm (Gamma0GL N) (2 * m),
      frickeInvolutionLM hN m (frickeInvolutionLM hN m g) = g := fun g => frickeInvolution_sq hN m g
  refine ⟨(2⁻¹ : ℂ) • (f + frickeInvolutionLM hN m f), ?_,
          (2⁻¹ : ℂ) • (f - frickeInvolutionLM hN m f), ?_, ?_⟩
  · rw [frickePlus_mem_iff]
    show frickeInvolutionLM hN m ((2⁻¹ : ℂ) • (f + frickeInvolutionLM hN m f)) = _
    rw [map_smul, map_add, hTT, add_comm]
  · rw [frickeMinus_mem_iff]
    show frickeInvolutionLM hN m ((2⁻¹ : ℂ) • (f - frickeInvolutionLM hN m f)) = _
    rw [map_smul, map_sub, hTT, ← smul_neg, neg_sub]
  · rw [← smul_add, show (f + frickeInvolutionLM hN m f) + (f - frickeInvolutionLM hN m f)
        = (2 : ℂ) • f by rw [two_smul]; abel, smul_smul]
    norm_num

/-- **FRK-23b — the sharp form.**  The two eigenspaces are complementary. -/
theorem fricke_isCompl {N : ℕ} (hN : 0 < N) (m : ℤ) :
    IsCompl (frickePlus hN m) (frickeMinus hN m) := by
  -- PROVED.  `codisjoint` is FRK-23a; `disjoint` is `T f = f ∧ T f = -f → f = 0` in
  -- characteristic zero.  STRICTLY STRONGER than FRK-23a: do not report one as the other.
  constructor
  · rw [Submodule.disjoint_def]
    intro f hp hm
    rw [frickePlus_mem_iff] at hp
    rw [frickeMinus_mem_iff] at hm
    have h2 : (2 : ℂ) • f = 0 := by
      rw [two_smul]
      nth_rewrite 1 [← hp]
      rw [hm, neg_add_cancel]
    rcases smul_eq_zero.mp h2 with h | h
    · exact absurd h (by norm_num)
    · exact h
  · rw [codisjoint_iff, eq_top_iff]
    intro f _
    obtain ⟨fp, hfp, fm, hfm, hsum⟩ := fricke_decomposition hN m f
    exact hsum ▸ Submodule.add_mem_sup hfp hfm

/-! ### FRK-24 PINs V1…V7 — decide-pins on the VACUITY MECHANISM, stated BEFORE the general lemma

The odd-weight vanishing has exactly two moving parts, and each can fail silently:

1. `-1` really is in `Gamma0GL N`.  The lower-left entry of `(-1 : SL(2,ℤ))` is `0`, and `0 ≡ 0`
   mod every `N`; PIN V1 checks that entry by `decide`, and PINs V2/V3 re-prove membership at a
   COMPOSITE literal level (`N = 12`) and at the degenerate level `N = 0` WITHOUT invoking
   `neg_one_mem_Gamma0GL`, so a bug in the general proof could not hide behind them.
2. The automorphy factor at `-1` is `denom(-1, z)^(-k) = (-1)^k`, which is `-1` for ODD `k` and
   `+1` for EVEN `k`.  The sign is the whole content: with `+1` the argument gives `f = f` and
   there is no vanishing at all.  PIN V4 computes `denom (-1) z = -1` from the definition; PINs
   V5/V6 pin `(-1)^k = -1` at `k = 3` and at the NEGATIVE odd `k = -5`; PIN V7 is the NEGATIVE
   CONTROL at the even `k = 4`, where the value is `+1 ≠ -1` and the argument correctly fails.

Hand values: `(-1)^3 = -1`, `(-1)^(-5) = -1`, `(-1)^4 = +1`. -/

section OddWeightVacuityPins

/-- **FRK-24 PIN V1.**  The lower-left entry of `(-1 : SL(2,ℤ))` is `0`, checked by `decide`
straight from the matrix, not from any lemma about `Γ₀(N)`. -/
theorem oddWeight_pin_neg_one_entry :
    ((-1 : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ) 1 0 = 0 := by decide

/-- **FRK-24 PIN V2** (`N = 12`, a COMPOSITE non-prime-power level).  Membership re-proved from
scratch at a literal level; it does NOT call `neg_one_mem_Gamma0GL`. -/
theorem oddWeight_pin_mem_twelve : (-1 : GL (Fin 2) ℝ) ∈ Gamma0GL 12 := by
  refine ⟨-1, ?_, ?_⟩
  · show (-1 : SL(2, ℤ)) ∈ Gamma0 12
    rw [Gamma0_mem]; decide
  · ext i j; fin_cases i <;> fin_cases j <;> simp

/-- **FRK-24 PIN V3** (`N = 0`, the degenerate level the classical texts do not pose).
`Gamma0 0` is the `c = 0` subgroup and `-1` is still in it, which is why FRK-24a needs no
hypothesis on `N`.  Also proved independently of `neg_one_mem_Gamma0GL`. -/
theorem oddWeight_pin_mem_zero : (-1 : GL (Fin 2) ℝ) ∈ Gamma0GL 0 := by
  refine ⟨-1, ?_, ?_⟩
  · show (-1 : SL(2, ℤ)) ∈ Gamma0 0
    rw [Gamma0_mem]; decide
  · ext i j; fin_cases i <;> fin_cases j <;> simp

/-- **FRK-24 PIN V4 — THE DENOMINATOR.**  `denom (-1) z = -1`, computed from the definition
`denom g z = g 1 0 * z + g 1 1`.  This is the factor Mathlib's `eq_zero_of_neg_one_mem` raises to
the `-k`; if it were `+1` the whole argument would collapse to `f z = f z`. -/
theorem oddWeight_pin_denom_neg_one (z : ℂ) :
    UpperHalfPlane.denom (-1 : GL (Fin 2) ℝ) z = -1 := by
  simp [UpperHalfPlane.denom]

/-- **FRK-24 PIN V5 — THE SIGN** (`k = 3`, odd): `(-1)^3 = -1`. -/
theorem oddWeight_pin_sign_three : (-1 : ℂ) ^ (3 : ℤ) = -1 := by norm_num

/-- **FRK-24 PIN V6 — THE NEGATIVE-`k` CONTROL** (`k = -5`, odd AND negative): `(-1)^(-5) = -1`.
This is the pin that would break if the statement were read with a `ℕ`-exponent `pow` instead of
`zpow`; FRK-24 quantifies over all of `ℤ`, negative odd weights included. -/
theorem oddWeight_pin_sign_neg_five : (-1 : ℂ) ^ (-5 : ℤ) = -1 := by norm_num

/-- **FRK-24 PIN V7 — THE NEGATIVE CONTROL, and the only pin here that does NOT give `-1`**
(`k = 4`, EVEN): `(-1)^4 = +1 ≠ -1`.  So the vanishing is genuinely an ODD-weight phenomenon and
not an artifact of the argument; at even weight the same computation proves nothing, which is why
the even case needs the whole `frickeInvolution` apparatus. -/
theorem oddWeight_pin_sign_even_control : (-1 : ℂ) ^ (4 : ℤ) = 1 ∧ (1 : ℂ) ≠ -1 := by norm_num

end OddWeightVacuityPins

/-! ## FRK-24 — THE ODD-WEIGHT VACUITY, stated as a theorem and not as a remark -/

/-- **FRK-24a.**  `-1 ∈ Gamma0GL N`: the image of `-I ∈ Γ₀(N)` under `mapGL ℝ`.  This is the fact
the vacuity claim rests on, and it is checked rather than assumed. -/
theorem neg_one_mem_Gamma0GL (N : ℕ) : (-1 : GL (Fin 2) ℝ) ∈ Gamma0GL N := by
  -- PROVED: exhibit `(-1 : SL(2,ℤ))`, whose lower-left entry is `0 ≡ 0 (mod N)`, and check that
  -- `mapGL ℝ` sends it to `(-1 : GL (Fin 2) ℝ)` entrywise.
  refine ⟨-1, ?_, ?_⟩
  · show (-1 : SL(2, ℤ)) ∈ Gamma0 N
    rw [Gamma0_mem]; simp
  · ext i j; fin_cases i <;> fin_cases j <;> simp

/-- **FRK-24b.**  ODD weight: every modular form of odd weight on `Γ₀(N)` is zero. -/
theorem modularForm_odd_weight_eq_zero {N : ℕ} {k : ℤ} (hk : Odd k)
    (f : ModularForm (Gamma0GL N) k) : f = 0 := by
  -- PROVED: `ModularForm.eq_zero_of_neg_one_mem (neg_one_mem_Gamma0GL N) hk f`.  The `HasDetOne`
  -- instance it needs is the one on `(Gamma0 N).map (mapGL ℝ)`.
  exact ModularForm.eq_zero_of_neg_one_mem (neg_one_mem_Gamma0GL N) hk f

/-- **FRK-24c — THE VACUITY STATEMENT.**  For odd weight the module is a singleton, so ANY
eigenspace assertion about it is vacuously true and worth nothing.  This is why every result in
this file is indexed by the EVEN weight `2 * m`, and why the even case is the headline. -/
theorem modularForm_odd_weight_subsingleton {N : ℕ} {k : ℤ} (hk : Odd k) :
    Subsingleton (ModularForm (Gamma0GL N) k) := by
  -- PROVED.
  exact ⟨fun f g => by rw [modularForm_odd_weight_eq_zero hk f,
                           modularForm_odd_weight_eq_zero hk g]⟩

/-! ### FRK-24 PINs V8/V9 — INSTANCE pins on the general theorem

These two are stated AFTER the general lemma because they are instances OF it: they discharge
`Odd k` by `decide` at literal weights and read the conclusion back at literal levels.  They pin
that the theorem really does fire at concrete `(N, k)` rather than being unusable in practice. -/

/-- **FRK-24 PIN V8** (`N = 12`, `k = 3`). -/
theorem oddWeight_pin_instance_twelve_three (f : ModularForm (Gamma0GL 12) 3) : f = 0 :=
  modularForm_odd_weight_eq_zero (by decide) f

/-- **FRK-24 PIN V9** (`N = 1`, `k = -7`: the degenerate level and a NEGATIVE odd weight). -/
theorem oddWeight_pin_instance_one_neg_seven (f : ModularForm (Gamma0GL 1) (-7)) : f = 0 :=
  modularForm_odd_weight_eq_zero (by decide) f

/-! ## FRK-25 … FRK-27 — THE WITNESS that the two eigenspaces are different

An eigenspace decomposition with no exhibited witness is a weak result.  The witness below is
UNCONDITIONAL and holds at EVERY level `N > 0`, at weight `0` (`m = 0`).

It is also LIMITED, and the limit is stated here so it cannot be overstated downstream: it
separates the two eigenspaces by exhibiting an element of `frickePlus` that is not in
`frickeMinus`.  It does NOT produce a nonzero element of `frickeMinus`, at this or any other
level.  `frickeMinus hN 0 = ⊥` is in fact expected (weight-`0` forms on `Γ₀(N)` are constants),
but that is NOT proved here either. -/

/-! ### FRK-60 … FRK-64 — the FIVE CONSTANT decide-pins for FRK-25, stated BEFORE the general lemma

FRK-25a says the raw operator returns `N⁻¹ • const 1`, and the whole content of the node is that
scalar.  A wrong power of `N` (`N` for `N⁻¹`), a dropped `N` inside `denom`, or the CLASSICAL
Atkin–Lehner normalisation (which sends `1 ↦ 1` at weight `0`, with NO `N⁻¹`) would all survive a
general proof that merely unfolds a definition, so the scalar is pinned at literal levels first.

The five pins evaluate the BUNDLED operator `frickeModularOperator hN (ModularForm.const 1)` — the
exact left-hand side of FRK-25a, not the raw slash, which is pinned separately at FRK-37 … FRK-41 —
at LITERAL `N` and LITERAL `τ`, straight from Mathlib's `slash_apply`.  NONE of the five proofs
mentions `frickeModularOperator_const_one`, which is stated below them, so a wrong scalar there
could not be hidden by a matching wrong scalar here.

Hand values, computed before the pins were written and re-checked numerically in Python
(`complex`, this session) against `|det|^(k-1) · denom^(-k)` at `k = 0`:

* C1 `(N,τ) = (2,i)`:   `2^(-1) · (2i)^0 = 1/2`;
* C2 `(3,2i)`:          `3^(-1) · (6i)^0 = 1/3`   — the only pin with `τ ≠ i`, so a `τ`-dependence
                        leaking out of the `denom^(-k)` factor would show up here;
* C3 `(7,i)`:           `7^(-1) = 1/7`;
* C4 `(1,i)`:           `1^(-1) = 1`              — the DEGENERATE level, and the ONLY level where
                        the Mathlib scalar coincides with the classical Atkin–Lehner one;
* C5 `(5,i)`:           the NEGATIVE CONTROL — `frickeModularOperator` does NOT fix `const 1`.

C5 is the pin that matters for the prose.  Because the scalar is `N⁻¹` and not `1`, the sentence
"the Fricke operator fixes the constant `1`" is FALSE of `frickeModularOperator`; it becomes true
only after the `N^(1-m)` renormalisation of FRK-18, i.e. for `frickeInvolution` (FRK-26).  C1–C4
alone could not detect a statement that had quietly been read with the classical normalisation,
because they only assert what the value IS; C5 asserts what it is NOT. -/

section ConstantPins

/-- **FRK-60 (CONSTANT PIN C1)** (`N = 2`, `τ = i`): `2^(-1) · (2i)^0 = 1/2`. -/
theorem frickeModularOperator_const_pin_two :
    frickeModularOperator (by norm_num : 0 < 2) (ModularForm.const (Γ := Gamma0GL 2) 1)
        (⟨Complex.I, by simp⟩ : ℍ) = 1 / 2 := by
  show (⇑(ModularForm.const (Γ := Gamma0GL 2) (1 : ℂ)) ∣[(0 : ℤ)] frickeW _) _ = _
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num

/-- **FRK-61 (CONSTANT PIN C2)** (`N = 3`, `τ = 2i`): `3^(-1) · (6i)^0 = 1/3`.  The only pin with
`τ ≠ i`. -/
theorem frickeModularOperator_const_pin_three :
    frickeModularOperator (by norm_num : 0 < 3) (ModularForm.const (Γ := Gamma0GL 3) 1)
        (⟨2 * Complex.I, by simp⟩ : ℍ) = 1 / 3 := by
  show (⇑(ModularForm.const (Γ := Gamma0GL 3) (1 : ℂ)) ∣[(0 : ℤ)] frickeW _) _ = _
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num

/-- **FRK-62 (CONSTANT PIN C3)** (`N = 7`, `τ = i`): `7^(-1) = 1/7`. -/
theorem frickeModularOperator_const_pin_seven :
    frickeModularOperator (by norm_num : 0 < 7) (ModularForm.const (Γ := Gamma0GL 7) 1)
        (⟨Complex.I, by simp⟩ : ℍ) = 1 / 7 := by
  show (⇑(ModularForm.const (Γ := Gamma0GL 7) (1 : ℂ)) ∣[(0 : ℤ)] frickeW _) _ = _
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num

/-- **FRK-63 (CONSTANT PIN C4)** (`N = 1`, `τ = i`): `1^(-1) = 1`.  The DEGENERATE level, and the
only level at which the Mathlib scalar `N⁻¹` agrees with the classical Atkin–Lehner `1`. -/
theorem frickeModularOperator_const_pin_one :
    frickeModularOperator (by norm_num : 0 < 1) (ModularForm.const (Γ := Gamma0GL 1) 1)
        (⟨Complex.I, by simp⟩ : ℍ) = 1 := by
  show (⇑(ModularForm.const (Γ := Gamma0GL 1) (1 : ℂ)) ∣[(0 : ℤ)] frickeW _) _ = _
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num

/-- **FRK-64 (CONSTANT PIN C5 — THE NEGATIVE CONTROL)** (`N = 5`): the RAW operator does NOT fix
`const 1`.  So `frickeModularOperator` is NOT the classical Atkin–Lehner operator on the nose; the
`N⁻¹` is a genuine artifact of Mathlib's `|det|^(k-1) · denom^(-k)` slash, and only the normalised
`frickeInvolution` (FRK-18, FRK-26) fixes the constant. -/
theorem frickeModularOperator_const_not_fixed_five :
    frickeModularOperator (by norm_num : 0 < 5) (ModularForm.const (Γ := Gamma0GL 5) 1)
      ≠ (ModularForm.const (Γ := Gamma0GL 5) 1) := by
  intro h
  have hval : frickeModularOperator (by norm_num : 0 < 5)
      (ModularForm.const (Γ := Gamma0GL 5) 1) (⟨Complex.I, by simp⟩ : ℍ) = 1 / 5 := by
    show (⇑(ModularForm.const (Γ := Gamma0GL 5) (1 : ℂ)) ∣[(0 : ℤ)] frickeW _) _ = _
    rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
    simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
      Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
    norm_num
  rw [h] at hval
  simp only [ModularForm.const_apply] at hval
  norm_num at hval

end ConstantPins

/-- **FRK-25a.**  The raw Fricke operator on the constant `1` in weight `0`: it returns
`N⁻¹ • const 1`.  Direct from FRK-15, since `const 1` is constant so the `f (W_N • τ)` factor is
just `1`, and `k = 0` makes the two `zpow` factors collapse to `N^(-1) · (N τ)^0`. -/
theorem frickeModularOperator_const_one {N : ℕ} (hN : 0 < N) :
    frickeModularOperator hN (ModularForm.const (Γ := Gamma0GL N) 1)
      = ((N : ℂ)⁻¹) • (ModularForm.const (Γ := Gamma0GL N) 1) := by
  -- PROVED, directly from FRK-15.
  ext τ
  show (⇑(ModularForm.const (Γ := Gamma0GL N) (1 : ℂ)) ∣[(0 : ℤ)] frickeW hN) τ = _
  rw [slash_frickeW_apply hN]
  simp

/-- **FRK-25b.**  `const 1 ≠ 0`, in characteristic zero.  Without this the witness is empty. -/
theorem const_one_ne_zero {N : ℕ} :
    (ModularForm.const (Γ := Gamma0GL N) 1) ≠ 0 := by
  -- PROVED: evaluate at `⟨I, _⟩ : ℍ`.
  intro h
  have hI := congrArg (fun f => f (⟨Complex.I, by simp⟩ : ℍ)) h
  simp at hI

/-- **FRK-26.**  The normalised involution fixes the constant `1` at weight `0`, at EVERY level:
`N^(1-0) · N⁻¹ = 1`. -/
theorem frickeInvolution_const_one {N : ℕ} (hN : 0 < N) :
    frickeInvolution hN 0 (ModularForm.const (Γ := Gamma0GL N) 1)
      = (ModularForm.const (Γ := Gamma0GL N) 1) := by
  -- PROVED: unfold `frickeInvolution`, apply FRK-25a, then `N^(1-0) • (N⁻¹ • x) = x` by
  -- `smul_smul` and `zpow_one`, using `(N : ℂ) ≠ 0`.
  have hN0 : ((N : ℂ)) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  show ((N : ℂ) ^ (1 - (0 : ℤ))) • frickeModularOperator hN
      (ModularForm.const (Γ := Gamma0GL N) 1) = _
  rw [frickeModularOperator_const_one hN, smul_smul, show (1 - (0 : ℤ)) = 1 by ring, zpow_one,
      mul_inv_cancel₀ hN0, one_smul]

/-- **FRK-65 (RECONCILIATION INSTANCE PIN C6)** (`N = 12`, a composite level): the NORMALISED
involution really does fix `const 1` at a literal level.  Together with FRK-64 (`N = 5`, where the
RAW operator does not) this pins the exact place the `N^(1-m)` normalisation does its work: the
raw operator scales by `N⁻¹`, the normalisation multiplies by `N^(1-0) = N`, and `N · N⁻¹ = 1`. -/
theorem frickeInvolution_const_one_pin_twelve :
    frickeInvolution (by norm_num : 0 < 12) 0 (ModularForm.const (Γ := Gamma0GL 12) 1)
      = (ModularForm.const (Γ := Gamma0GL 12) 1) :=
  frickeInvolution_const_one _

/-- **FRK-27a.**  The witness lands in the `+1` eigenspace, at every level. -/
theorem const_one_mem_frickePlus {N : ℕ} (hN : 0 < N) :
    (ModularForm.const (Γ := Gamma0GL N) 1 : ModularForm (Gamma0GL N) (2 * 0))
      ∈ frickePlus hN 0 := by
  -- PROVED.
  exact (frickePlus_mem_iff hN 0 _).mpr (frickeInvolution_const_one hN)

/-- **FRK-27b.**  The witness does NOT land in the `-1` eigenspace: `1 = -1` fails in `ℂ`. -/
theorem const_one_not_mem_frickeMinus {N : ℕ} (hN : 0 < N) :
    (ModularForm.const (Γ := Gamma0GL N) 1 : ModularForm (Gamma0GL N) (2 * 0))
      ∉ frickeMinus hN 0 := by
  -- PROVED: from `frickeMinus_mem_iff` and FRK-26 one gets `const 1 = -const 1`, hence
  -- `(2 : ℂ) • const 1 = 0`, contradicting FRK-25b.
  intro h
  have h' : frickeInvolution hN 0 (ModularForm.const (Γ := Gamma0GL N) 1)
      = -(ModularForm.const (Γ := Gamma0GL N) 1) := (frickeMinus_mem_iff hN 0 _).mp h
  rw [frickeInvolution_const_one hN] at h'
  have h2 : (2 : ℂ) • (ModularForm.const (Γ := Gamma0GL N) 1) = 0 := by
    rw [two_smul]
    nth_rewrite 1 [h']
    rw [neg_add_cancel]
  rcases smul_eq_zero.mp h2 with hc | hc
  · exact absurd hc (by norm_num)
  · exact const_one_ne_zero hc

/-- **FRK-27c — THE NON-VACUITY WITNESS.**  At every level `N > 0` the `+1` and `-1` Fricke
eigenspaces in weight `0` are DIFFERENT submodules.  Unconditional; no eta quotient, no Ligozat,
no modularity hypothesis is used.

WHAT THIS DOES NOT SAY: it does not say `frickeMinus hN 0 = ⊥`, and it does not exhibit any
nonzero `-1`-eigenform at any level.  See SDF-20 for the only (conditional) route to one. -/
theorem frickePlus_ne_frickeMinus {N : ℕ} (hN : 0 < N) :
    frickePlus hN 0 ≠ frickeMinus hN 0 := by
  -- PROVED: FRK-27a and FRK-27b differ on `const 1`.
  intro h
  exact const_one_not_mem_frickeMinus hN (h ▸ const_one_mem_frickePlus hN)

/-- **FRK-66.**  The `+1` Fricke eigenspace in weight `0` is NOT the zero submodule, at every
level `N > 0`.  This is the statement the FRK-25 node originally asked for; it is recorded HERE,
downstream, because it is not derivable from FRK-25's own dependencies — it needs the membership
criterion FRK-22a and the fixed-point fact FRK-26 as well, and FRK-26 depends on FRK-25.

THE HONEST LIMIT: this says nothing about `frickeMinus hN 0`, which is expected to BE `⊥` and is
not proved to be either.  A nonzero `-1`-eigenform remains the next obstruction. -/
theorem frickePlus_ne_bot {N : ℕ} (hN : 0 < N) : frickePlus hN 0 ≠ ⊥ := by
  -- PROVED: `const 1` is a member (FRK-27a) and is nonzero (FRK-25b).
  rw [Submodule.ne_bot_iff]
  exact ⟨_, const_one_mem_frickePlus hN, const_one_ne_zero⟩

/-! ## SDF-17 … SDF-20 — the eta-quotient lift

READ THE FILE HEADER FIRST.  Nothing in this section asserts that an eta quotient IS a modular
form.  SDF-17 is a statement about a FUNCTION `ℍ → ℂ` and carries no modularity content at all;
SDF-18/SDF-20 take modularity as an explicit hypothesis; SDF-19 is restricted to `0 < N ≤ 4`, where
the library's own `etaQuotientModularForm` supplies the transformation law — and even there Ligozat
condition (iii) (`hbd`) remains a hypothesis this library does not discharge. -/

/-- **SDF-17a.**  Run 6's pointwise identity `etaQuotient_fricke_selfDual`, restated with the
argument written as the `GL(2,ℝ)`-action `W_N • τ` instead of `-(1/(N z))`, which is what makes it
composable with the slash.  Pure function-level statement: `etaQuotientH N r : ℍ → ℂ`, no
`ModularForm` anywhere. -/
theorem etaQuotientH_frickeW_smul {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (τ : ℍ) :
    etaQuotientH N r (frickeW hN • τ)
      = frickeEigenvalue N k * (τ : ℂ) ^ k * etaQuotientH N r τ := by
  -- PROVED (run 11).  Three steps, no new mathematics: `etaQuotientH N r τ` is by definition
  -- `etaQuotient N r (τ : ℂ)`; FRK-14 (`frickeW_smul_coe_neg_inv`) rewrites the argument
  -- `((W_N • τ : ℍ) : ℂ)` into the literal `-(1 / (N * τ))` that SDF-05 states its hypothesis
  -- in; and `τ.2` is exactly `(τ : ℂ) ∈ ℍₒ`.  Nothing here claims modularity of anything.
  unfold etaQuotientH
  rw [frickeW_smul_coe_neg_inv]
  exact etaQuotient_fricke_selfDual hN hr hk τ.2

/-! ### SDF-21 … SDF-24 — the EIGEN-SLASH pins, stated BEFORE the general SDF-17b

RESIDUAL RISK THIS SECTION CLOSES, stated plainly: until run 11, SDF-17b had NO decide-pin of its
own.  Its whole content is one constant — the slash eigenvalue is `λ / N`, and the single most
likely error is an `N` where an `N⁻¹` belongs (or the reverse).  A general proof that merely
chained `slash_frickeW_apply` with a `ring` would survive that error unchanged if the statement
carried it, because the statement is what the `ring` is asked to match.

Each pin therefore instantiates the WHOLE IMPLICATION at literal `(N, k, f, lam, τ)`:
a `..._hyp` lemma discharging SDF-17b's hypothesis `f (W_N • τ) = lam · τ^k · f τ` for that `f`
and that `lam` at EVERY `τ`, and a value lemma evaluating the conclusion's left-hand side
`(f ∣[k] W_N) τ` at a literal `τ` straight from Mathlib's `slash_apply` and `frickeMatrix`.  No
value proof mentions `slash_frickeW_of_eigen`, which is stated below them, so a wrong constant
there could not be hidden by a matching wrong constant here.

The three eigenfunctions and their hand values (recomputed in exact Gaussian rationals this run
BEFORE the Lean statements were written):

* E1 `f ≡ 1`, `N = 2`, `k = 0`, `lam = 1`, `τ = i`:
  `(f ∣[0] W_2) i = 2^(-1) · (2i)^0 = 1/2`, and `2⁻¹ · 1 · f(i) = 1/2`.
* E2 `f = τ ↦ τ`, `N = 3`, `k = -2`, `lam = -1/3`, `τ = i`:
  `f(W_3 • i) = i/3`, `3^(-3) = 1/27`, `(3i)^2 = -9`, so the slash is `-i/9`;
  and `3⁻¹ · (-1/3) · i = -i/9`.  NEGATIVE weight, non-constant `f`, non-real value.
* E3 `f = τ ↦ τ⁻¹`, `N = 2`, `k = 2`, `lam = -2`, `τ = i`:
  `f(W_2 • i) = -2i`, `2^1 = 2`, `(2i)^(-2) = -1/4`, so the slash is `i`;
  and `2⁻¹ · (-2) · i⁻¹ = -1 · (-i) = i`.  POSITIVE weight and `|lam| > 1`, so the `N⁻¹` is
  doing visible work rather than dividing a `1`.

WHY THE `τ^j` FAMILY AND NOTHING ELSE: for `f = τ ↦ τ^j` the eigen relation forces `k = -2j`, so
these elementary pins reach EVEN `k` only.  No odd-`k` instance is pinned here and none is
claimed; that is a genuine limit of numeral pinning for this lemma and is stated rather than
hidden.  It costs nothing at the point of use — SDF-17c/SDF-18 consume SDF-17b at `k = 2 * m`
only — and the general proof is parity-free (it is `mul_zpow` plus two `zpow_add₀` cancellations,
with no case split on `k`).

SDF-24 (`..._wrong_direction`) are the NEGATIVE CONTROLS: at E1's and E3's instances the
mirror-image constant `N · lam` is REFUTED, not merely unproved — `1/2 ≠ 2` and `i ≠ 4i`.  So the
direction of the `N` is forced by a proof, not chosen by convention. -/

section SlashEigenPins

/-- **SDF-21 (EIGEN-SLASH PIN E1, hypothesis half)** — `f ≡ 1` satisfies SDF-17b's hypothesis at
`N = 2`, `k = 0` with `lam = 1`, at every `τ`. -/
theorem slash_eigen_pin_const_hyp (τ : ℍ) :
    (fun _ : ℍ => (1 : ℂ)) (frickeW (by norm_num : 0 < 2) • τ)
      = (1 : ℂ) * (τ : ℂ) ^ (0 : ℤ) * (fun _ : ℍ => (1 : ℂ)) τ := by
  norm_num

/-- **SDF-21 (EIGEN-SLASH PIN E1, value half)** — `(1 ∣[0] W_2) i = 2⁻¹ · 1 · 1 = 1/2`.
Computed from `slash_apply` and `frickeMatrix`, never from `slash_frickeW_of_eigen`. -/
theorem slash_eigen_pin_const :
    ((fun _ : ℍ => (1 : ℂ)) ∣[(0 : ℤ)] frickeW (by norm_num : 0 < 2))
        (⟨Complex.I, by simp⟩ : ℍ)
      = (((2 : ℕ) : ℂ)⁻¹ * (1 : ℂ)) * (fun _ : ℍ => (1 : ℂ)) (⟨Complex.I, by simp⟩ : ℍ) := by
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num

/-- **SDF-24 (NEGATIVE CONTROL A)** — at E1's instance the constant `N · lam = 2` is FALSE.
The value is `1/2`.  This is what forces `N⁻¹` rather than `N` in SDF-17b. -/
theorem slash_eigen_pin_const_wrong_direction :
    ((fun _ : ℍ => (1 : ℂ)) ∣[(0 : ℤ)] frickeW (by norm_num : 0 < 2))
        (⟨Complex.I, by simp⟩ : ℍ)
      ≠ (((2 : ℕ) : ℂ) * (1 : ℂ)) * (fun _ : ℍ => (1 : ℂ)) (⟨Complex.I, by simp⟩ : ℍ) := by
  rw [slash_eigen_pin_const]
  norm_num

/-- **SDF-22 (EIGEN-SLASH PIN E2, hypothesis half)** — `f = τ ↦ τ` satisfies SDF-17b's hypothesis
at `N = 3`, `k = -2` with `lam = -1/3`, at every `τ`.  Uses FRK-14 and `τ ≠ 0`. -/
theorem slash_eigen_pin_id_hyp (τ : ℍ) :
    ((frickeW (by norm_num : 0 < 3) • τ : ℍ) : ℂ)
      = (-(1 / 3) : ℂ) * (τ : ℂ) ^ (-2 : ℤ) * (τ : ℂ) := by
  rw [frickeW_smul_coe_neg_inv]
  have hτ : ((τ : ℂ)) ≠ 0 := τ.ne_zero
  field_simp
  ring

/-- **SDF-22 (EIGEN-SLASH PIN E2, value half)** — `(id ∣[-2] W_3) i = 3⁻¹ · (-1/3) · i = -i/9`.
NEGATIVE weight, non-constant `f`, non-real value. -/
theorem slash_eigen_pin_id :
    ((fun τ : ℍ => (τ : ℂ)) ∣[(-2 : ℤ)] frickeW (by norm_num : 0 < 3))
        (⟨Complex.I, by simp⟩ : ℍ)
      = (((3 : ℕ) : ℂ)⁻¹ * (-(1 / 3) : ℂ)) * ((⟨Complex.I, by simp⟩ : ℍ) : ℂ) := by
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  rw [frickeW_smul_coe_neg_inv]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num
  rw [mul_zpow, show (Complex.I) ^ (2 : ℤ) = -1 by
    rw [show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq]]
  ring

/-- **SDF-23 (EIGEN-SLASH PIN E3, hypothesis half)** — `f = τ ↦ τ⁻¹` satisfies SDF-17b's
hypothesis at `N = 2`, `k = 2` with `lam = -2`, at every `τ`. -/
theorem slash_eigen_pin_inv_hyp (τ : ℍ) :
    (((frickeW (by norm_num : 0 < 2) • τ : ℍ) : ℂ))⁻¹
      = (-2 : ℂ) * (τ : ℂ) ^ (2 : ℤ) * ((τ : ℂ))⁻¹ := by
  rw [frickeW_smul_coe_neg_inv]
  have hτ : ((τ : ℂ)) ≠ 0 := τ.ne_zero
  rw [show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast]
  field_simp
  ring

/-- **SDF-23 (EIGEN-SLASH PIN E3, value half)** — `(τ⁻¹ ∣[2] W_2) i = 2⁻¹ · (-2) · i⁻¹ = i`.
POSITIVE weight and `|lam| > 1`, so the `N⁻¹` divides a number that is not `1`. -/
theorem slash_eigen_pin_inv :
    ((fun τ : ℍ => ((τ : ℂ))⁻¹) ∣[(2 : ℤ)] frickeW (by norm_num : 0 < 2))
        (⟨Complex.I, by simp⟩ : ℍ)
      = (((2 : ℕ) : ℂ)⁻¹ * (-2 : ℂ)) * (((⟨Complex.I, by simp⟩ : ℍ) : ℂ))⁻¹ := by
  rw [slash_apply, σ, if_pos (frickeW_det_val_pos (by norm_num))]
  rw [frickeW_smul_coe_neg_inv]
  simp only [ContinuousAlgEquiv.refl_apply, denom, frickeW_coe, frickeMatrix,
    Matrix.GeneralLinearGroup.val_det_apply, Matrix.det_fin_two_of]
  norm_num
  rw [mul_zpow, show (Complex.I) ^ (2 : ℤ) = -1 by
    rw [show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq]]
  norm_num
  ring

/-- **SDF-24 (NEGATIVE CONTROL B)** — at E3's instance the constant `N · lam = -4` is FALSE:
it would give `4i`, and the value is `i`. -/
theorem slash_eigen_pin_inv_wrong_direction :
    ((fun τ : ℍ => ((τ : ℂ))⁻¹) ∣[(2 : ℤ)] frickeW (by norm_num : 0 < 2))
        (⟨Complex.I, by simp⟩ : ℍ)
      ≠ (((2 : ℕ) : ℂ) * (-2 : ℂ)) * (((⟨Complex.I, by simp⟩ : ℍ) : ℂ))⁻¹ := by
  rw [slash_eigen_pin_inv]
  simp only [Complex.inv_I]
  intro h
  exact Complex.I_ne_zero (by linear_combination (-1 / 3 : ℂ) * h)

end SlashEigenPins

/-- **SDF-17b.**  THE RECONCILIATION OF THE TWO CONSTANTS, at the level of a general function.

`frickeEigenvalue`'s λ is defined by `f(-1/(N z)) = λ z^k f(z)`.  Mathlib's slash carries
`|det|^(k-1) · denom^(-k)`, which at `W_N` is `N^(k-1) · (N τ)^(-k) = N⁻¹ τ^(-k)`.  So the SLASH
eigenvalue is `λ / N`, NOT `λ`.  This is real arithmetic, not a rewrite, and getting it wrong is
the most likely way to publish a false constant. -/
theorem slash_frickeW_of_eigen {N : ℕ} (hN : 0 < N) {k : ℤ} (lam : ℂ) (f : ℍ → ℂ)
    (hf : ∀ τ : ℍ, f (frickeW hN • τ) = lam * (τ : ℂ) ^ k * f τ) :
    f ∣[k] frickeW hN = ((N : ℂ)⁻¹ * lam) • f := by
  -- PROVED (run 11), and the constant is `N⁻¹ · lam`, pinned by SDF-21 … SDF-24 above.
  -- `mul_zpow` splits `((N : ℂ) · τ)^(-k)`; the two `zpow_add₀` cancellations then need exactly
  -- the two nonvanishing facts, and nothing else — no parity case split on `k` occurs.
  funext τ
  have hN0 : ((N : ℂ)) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  have hτ : ((τ : ℂ)) ≠ 0 := τ.ne_zero
  rw [slash_frickeW_apply hN f τ, hf τ, Pi.smul_apply, smul_eq_mul, mul_zpow]
  -- THE CONSTANT: `N^(k-1) · N^(-k) = N^(-1) = N⁻¹`.  This is where the `1/N` is born, and it
  -- comes from Mathlib's `|det|^(k-1)` meeting `denom^(-k)`, not from any convention.
  have h1 : (N : ℂ) ^ (k - 1) * (N : ℂ) ^ (-k) = (N : ℂ)⁻¹ := by
    rw [← zpow_add₀ hN0, show k - 1 + -k = (-1 : ℤ) by ring, _root_.zpow_neg_one]
  have h2 : ((τ : ℂ)) ^ k * ((τ : ℂ)) ^ (-k) = 1 := by
    rw [← zpow_add₀ hτ]; simp
  calc lam * (τ : ℂ) ^ k * f τ * (N : ℂ) ^ (k - 1) * ((N : ℂ) ^ (-k) * (τ : ℂ) ^ (-k))
      = ((N : ℂ) ^ (k - 1) * (N : ℂ) ^ (-k)) * ((τ : ℂ) ^ k * (τ : ℂ) ^ (-k))
          * (lam * f τ) := by ring
    _ = (N : ℂ)⁻¹ * lam * f τ := by rw [h1, h2]; ring

/-- **SDF-17c.**  The self-dual eta quotient as an eigenvector OF THE SLASH — still purely a
statement about the function `etaQuotientH N r`, with no modularity claimed. -/
theorem etaQuotientH_slash_frickeW_selfDual {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) :
    (etaQuotientH N r) ∣[k] frickeW hN
      = ((N : ℂ)⁻¹ * frickeEigenvalue N k) • (etaQuotientH N r) := by
  -- PROVED (run 11): SDF-17b applied to the eigen relation SDF-17a supplies.  One line, and
  -- that is the point — the arithmetic is all in SDF-17b, the eta quotient content all in
  -- SDF-17a, and neither of them mentions `ModularForm`.
  exact slash_frickeW_of_eigen hN _ _ (etaQuotientH_frickeW_smul hN hr hk)

/-! ### The normalised eigenvalue at even weight — pins BEFORE the general lemma

At weight `k = 2m`, `frickeEigenvalue N (2m) = I^(-2m) · √(N^(2m)) = (-1)^m · N^m`, so
`N^(1-m) · N⁻¹ · frickeEigenvalue N (2m) = (-1)^m`.  The four pins below check that against
`frickeEigenvalue` values that were ALREADY PROVED sorry-free in
`EtaQuotientFrickeSelfDual.lean`, at three different levels and at both signs. -/

section EigenvalueNormalisationPins

/-- PIN A (`N = 6`, `k = 12`, `m = 6` EVEN): `6^(-5) · (6⁻¹ · 46656) = 6^(-5) · 6^5 = 1`. -/
theorem frickeEigenvalue_normalised_pin_six_twelve :
    ((6 : ℕ) : ℂ) ^ ((1 : ℤ) - 6) * (((6 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 6 12)
      = (-1 : ℂ) ^ (6 : ℤ) := by
  rw [frickeEigenvalue_pin_level_six]; norm_num

/-- PIN B — THE MINUS-SIDE PIN (`N = 1`, `k = 2`, `m = 1` ODD): `1^0 · (1⁻¹ · (-1)) = -1`.
The value is `-1`, not `+1`.  If the normalisation were `(-1)^k` instead of `(-1)^m`, or if the
`I^(-k)` factor were dropped, this pin would come out `+1`. -/
theorem frickeEigenvalue_normalised_pin_one_two :
    ((1 : ℕ) : ℂ) ^ ((1 : ℤ) - 1) * (((1 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 1 2)
      = (-1 : ℂ) ^ (1 : ℤ) := by
  rw [frickeEigenvalue_pin_neg_one]; norm_num

/-- PIN C (`N = 6`, `k = 0`, `m = 0`): `6^1 · (6⁻¹ · 1) = 1`.  Fixes the DIRECTION of the
normalising exponent: at `m = 0` it multiplies by `N`, it does not divide. -/
theorem frickeEigenvalue_normalised_pin_six_zero :
    ((6 : ℕ) : ℂ) ^ ((1 : ℤ) - 0) * (((6 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 6 0)
      = (-1 : ℂ) ^ (0 : ℤ) := by
  rw [frickeEigenvalue_pin_zero_weight]; norm_num

/-- PIN D — THE NEGATIVE-WEIGHT CONTROL (`N = 6`, `k = -12`, `m = -6`):
`6^7 · (6⁻¹ · 46656⁻¹) = 6^7 · 6^(-1) · 6^(-6) = 1`. -/
theorem frickeEigenvalue_normalised_pin_six_neg_twelve :
    ((6 : ℕ) : ℂ) ^ ((1 : ℤ) - (-6)) * (((6 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 6 (-12))
      = (-1 : ℂ) ^ (-6 : ℤ) := by
  rw [frickeEigenvalue_pin_level_six_neg]; norm_num

end EigenvalueNormalisationPins

/-- **SDF-17d.**  The general form of the four pins above: after the `N^(1-m)` normalisation the
self-dual Fricke eigenvalue at weight `2 * m` is exactly `(-1)^m`.  Level-independent. -/
theorem frickeEigenvalue_normalised_even {N : ℕ} (hN : 0 < N) (m : ℤ) :
    (N : ℂ) ^ (1 - m) * ((N : ℂ)⁻¹ * frickeEigenvalue N (2 * m)) = (-1 : ℂ) ^ m := by
  -- PROVED (run 11).  ROUTE ACTUALLY TAKEN, recorded because it is NOT the one the `-- OPEN:`
  -- note proposed: the `I`-power is handled by `zpow_mul` alone — `-(2*m) = (-2) * m`, so
  -- `I^(-(2*m)) = (I^(-2))^m = (-1)^m` — with no residue-mod-4 reasoning at all.  SDF-07's
  -- `I_zpow_emod` / `I_zpow_neg_eq_neg_one_iff` are therefore NOT invoked here; they are the
  -- right tool for a general `k`, and this lemma's exponent is even by construction.
  have hN0 : ((N : ℂ)) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  have hNR : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hI2 : (I : ℂ) ^ (-2 : ℤ) = -1 := by
    rw [_root_.zpow_neg, show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq]
    norm_num
  have hI : (I : ℂ) ^ (-(2 * m)) = (-1 : ℂ) ^ m := by
    rw [show (-(2 * m) : ℤ) = (-2) * m by ring, _root_.zpow_mul, hI2]
  -- The REAL square root, where `0 < N` is genuinely used: `(N:ℝ)^(2m) = ((N:ℝ)^m)^2` and the
  -- base `(N:ℝ)^m` is positive, so `√` returns it rather than its absolute value.
  have hs : Real.sqrt ((N : ℝ) ^ (2 * m)) = (N : ℝ) ^ m := by
    rw [show (2 * m : ℤ) = m * 2 by ring, _root_.zpow_mul, zpow_two]
    exact Real.sqrt_mul_self (le_of_lt (zpow_pos hNR m))
  rw [frickeEigenvalue, hI, hs]
  push_cast
  rw [show (N : ℂ)⁻¹ = (N : ℂ) ^ (-1 : ℤ) by simp]
  calc (N : ℂ) ^ (1 - m) * ((N : ℂ) ^ (-1 : ℤ) * ((-1 : ℂ) ^ m * (N : ℂ) ^ m))
      = ((N : ℂ) ^ (1 - m) * (N : ℂ) ^ (-1 : ℤ) * (N : ℂ) ^ m) * (-1 : ℂ) ^ m := by ring
    _ = (-1 : ℂ) ^ m := by
        rw [← zpow_add₀ hN0, ← zpow_add₀ hN0,
          show 1 - m + -1 + m = (0 : ℤ) by ring, zpow_zero, one_mul]

/-! ### SDF-18 pins — the eigenvalue `(-1)^m` at CONCRETE `(N, m)`, computed by hand FIRST

These pins are written BEFORE `SDF-18` and are independent of it and of `SDF-17d`: each one
recomputes `frickeEigenvalue N (2m)` from the definition `i^(-k) · √(N^k)` and then applies the
`N^(1-m)` normalisation, at four `(N, m)` pairs that appear at NO other pin in this library
(`SDF-DEF-02`'s pins live at `N ∈ {1, 2, 6}`, the `EigenvalueNormalisationPins` above at
`N ∈ {1, 6}`).  Hand computation, in full, before any Lean was written:

| `N` | `m` | `k = 2m` | `i^(-k)`               | `√(N^k)`          | `λ`     | `N^(1-m) · (N⁻¹ λ)`      | `(-1)^m` |
|-----|-----|----------|------------------------|-------------------|---------|--------------------------|----------|
| 11  | 1   | 2        | `i^(-2) = -1`          | `√121 = 11`       | `-11`   | `11^0 · (-1) = -1`       | `-1`     |
| 2   | 3   | 6        | `i^(-6) = (i^(-2))^3 = -1` | `√64 = 8`     | `-8`    | `2^(-2) · (-4) = -1`     | `-1`     |
| 4   | 4   | 8        | `i^(-8) = (i^(-2))^4 = 1`  | `√65536 = 256`| `256`   | `4^(-3) · 64 = 1`        | `1`      |
| 3   | -2  | -4       | `i^(4) = (i^(-2))^(-2) = 1`| `√(1/81) = 1/9`| `1/9`  | `3^3 · (1/27) = 1`       | `1`      |

The first two rows are the MINUS side and the last two the PLUS side, so a proof that silently
produced `+1` everywhere is refuted here.  `N = 11, m = 1` is chosen deliberately: it is the level
and weight of `η(τ)²η(11τ)²`, the one exponent vector this library gets closest to realising as a
modular form (`EtaLigozatLevelEleven.lean`), so the pin says what `SDF-18` would predict there.

TWO NEGATIVE CONTROLS are included, and they are the two spellings that would otherwise be
indistinguishable from the true one:
  * `(-1)^(2m)` instead of `(-1)^m` — refuted at `N = 11, m = 1`, where the truth is `-1` and the
    wrong spelling gives `+1`;
  * dropping the `N^(1-m)` normalisation altogether — refuted at `N = 4, m = 4`, where the
    unnormalised `N⁻¹ λ` is `64`, not `1`.
If any pin below disagreed with the table, the STATEMENT would be wrong and this run would stop. -/

section SDF18Pins

/-- PIN SDF-18-1 — **THE LEVEL-11 MINUS PIN**, `N = 11`, `m = 1`, `k = 2`.  `λ = -11` and the
normalised eigenvalue is `-1`.  The third conjunct REFUTES the `(-1)^k = (-1)^(2m)` spelling. -/
theorem sdf18_pin_level_eleven :
    frickeEigenvalue 11 2 = -11
      ∧ ((11 : ℕ) : ℂ) ^ ((1 : ℤ) - 1) * (((11 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 11 2)
          = (-1 : ℂ) ^ (1 : ℤ)
      ∧ ((11 : ℕ) : ℂ) ^ ((1 : ℤ) - 1) * (((11 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 11 2)
          ≠ (-1 : ℂ) ^ (2 * 1 : ℤ) := by
  have hv : frickeEigenvalue 11 2 = -11 := by
    rw [frickeEigenvalue, I_zpow_neg_two,
        show (((11 : ℕ) : ℝ) ^ (2 : ℤ)) = (11 : ℝ) ^ 2 by norm_num,
        Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 11)]
    push_cast
    ring
  refine ⟨hv, ?_, ?_⟩
  · rw [hv]; norm_num
  · rw [hv]; norm_num

/-- PIN SDF-18-2 — `N = 2`, `m = 3`, `k = 6`, the SECOND minus-side instance and the first at a
weight where `i^(-k)` is not directly a named lemma: `i^(-6) = (i^(-2))^3 = -1`. -/
theorem sdf18_pin_level_two_weight_six :
    frickeEigenvalue 2 6 = -8
      ∧ ((2 : ℕ) : ℂ) ^ ((1 : ℤ) - 3) * (((2 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 2 6)
          = (-1 : ℂ) ^ (3 : ℤ) := by
  have hI6 : (I : ℂ) ^ (-6 : ℤ) = -1 := by
    rw [show (-6 : ℤ) = (-2) * 3 by decide, _root_.zpow_mul, I_zpow_neg_two]
    norm_num
  have hv : frickeEigenvalue 2 6 = -8 := by
    rw [frickeEigenvalue, hI6,
        show (((2 : ℕ) : ℝ) ^ (6 : ℤ)) = (8 : ℝ) ^ 2 by norm_num,
        Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 8)]
    push_cast
    ring
  refine ⟨hv, ?_⟩
  rw [hv]; norm_num

/-- PIN SDF-18-3 — `N = 4`, `m = 4`, `k = 8`, a PLUS-side instance at a composite level.  The
second conjunct REFUTES dropping the `N^(1-m)` normalisation: unnormalised it is `64`, not `1`. -/
theorem sdf18_pin_level_four_weight_eight :
    frickeEigenvalue 4 8 = 256
      ∧ ((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 4) * (((4 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 4 8)
          = (-1 : ℂ) ^ (4 : ℤ)
      ∧ (((4 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 4 8) ≠ (-1 : ℂ) ^ (4 : ℤ) := by
  have hI8 : (I : ℂ) ^ (-8 : ℤ) = 1 := by
    rw [show (-8 : ℤ) = (-2) * 4 by decide, _root_.zpow_mul, I_zpow_neg_two]
    norm_num
  have hv : frickeEigenvalue 4 8 = 256 := by
    rw [frickeEigenvalue, hI8,
        show (((4 : ℕ) : ℝ) ^ (8 : ℤ)) = (256 : ℝ) ^ 2 by norm_num,
        Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 256)]
    push_cast
    ring
  refine ⟨hv, ?_, ?_⟩
  · rw [hv]; norm_num
  · rw [hv]; norm_num

/-- PIN SDF-18-4 — **NEGATIVE WEIGHT**, `N = 3`, `m = -2`, `k = -4`.  The radicand is the proper
fraction `1/81`, so any `k.toNat` or `pow` in place of `zpow` is false here. -/
theorem sdf18_pin_level_three_weight_neg_four :
    frickeEigenvalue 3 (-4) = (9 : ℂ)⁻¹
      ∧ ((3 : ℕ) : ℂ) ^ ((1 : ℤ) - (-2)) * (((3 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 3 (-4))
          = (-1 : ℂ) ^ (-2 : ℤ) := by
  have hI4 : (I : ℂ) ^ (4 : ℤ) = 1 := by
    rw [show (4 : ℤ) = (-2) * (-2) by decide, _root_.zpow_mul, I_zpow_neg_two]
    norm_num
  have hv : frickeEigenvalue 3 (-4) = (9 : ℂ)⁻¹ := by
    rw [frickeEigenvalue, neg_neg, hI4,
        show (((3 : ℕ) : ℝ) ^ (-4 : ℤ)) = ((9 : ℝ)⁻¹) ^ 2 by norm_num,
        Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ (9 : ℝ)⁻¹)]
    push_cast
    ring
  refine ⟨hv, ?_⟩
  rw [hv]; norm_num

end SDF18Pins

/-- **SDF-18 — THE CONDITIONAL LIFT, general `N`.**

READ THE HYPOTHESES (LL-1, LL-33).  `f` is GIVEN as a modular form and `hf` says it agrees with the
eta quotient pointwise.  This theorem does NOT prove, and must never be quoted as proving, that
`etaQuotientH N r` is a modular form — for general `N` the library cannot prove that (ETA-01 is
open, blocked behind Dedekind sums, and the Kronecker-character hypothesis it would need is FALSE
at `N = 17`).  A caller who cannot produce `f` gets nothing from this statement. -/
theorem frickeInvolution_eq_of_etaQuotient {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {m : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * (2 * m))
    (f : ModularForm (Gamma0GL N) (2 * m))
    (hf : ∀ τ : ℍ, f τ = etaQuotientH N r τ) :
    frickeInvolution hN m f = ((-1 : ℂ) ^ m) • f := by
  -- PROVED (run 13).  Exactly the route the `-- OPEN:` note predicted, and nothing more: the
  -- eigenvalue is FORCED by SDF-17c + SDF-17d, neither of which mentions `ModularForm`, so no
  -- modularity is used anywhere in this proof — only the hypothesis `f` that the caller supplies.
  have hcoe : (⇑f : ℍ → ℂ) = etaQuotientH N r := funext hf
  ext τ
  have hR : ((((-1 : ℂ) ^ m) • f : ModularForm (Gamma0GL N) (2 * m)) : ℍ → ℂ) τ
      = (-1 : ℂ) ^ m * (⇑f) τ := rfl
  rw [hR, frickeInvolution_apply hN m, hcoe,
      etaQuotientH_slash_frickeW_selfDual hN hr hk, Pi.smul_apply, smul_eq_mul, ← mul_assoc,
      frickeEigenvalue_normalised_even hN m]

/-- **SDF-18b.**  `m` even ⇒ the form is a `+1` Fricke eigenform.  Same hypotheses as SDF-18. -/
theorem mem_frickePlus_of_etaQuotient {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {m : ℤ} (hm : Even m)
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * (2 * m))
    (f : ModularForm (Gamma0GL N) (2 * m))
    (hf : ∀ τ : ℍ, f τ = etaQuotientH N r τ) :
    f ∈ frickePlus hN m := by
  -- PROVED (run 13).  `Even.neg_one_zpow` turns the scalar into `1`; `one_smul` finishes.
  rw [frickePlus_mem_iff hN m f, frickeInvolution_eq_of_etaQuotient hN hr hk f hf,
      hm.neg_one_zpow, one_smul]

/-- **SDF-18c.**  `m` odd ⇒ the form is a `-1` Fricke eigenform.  Same hypotheses as SDF-18.
This is the ONLY route in this library to a `-1`-eigenform, and its hypotheses are undischarged. -/
theorem mem_frickeMinus_of_etaQuotient {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {m : ℤ} (hm : Odd m)
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * (2 * m))
    (f : ModularForm (Gamma0GL N) (2 * m))
    (hf : ∀ τ : ℍ, f τ = etaQuotientH N r τ) :
    f ∈ frickeMinus hN m := by
  -- PROVED (run 13).  `Odd.neg_one_zpow` turns the scalar into `-1`; `neg_one_smul` finishes.
  rw [frickeMinus_mem_iff hN m f, frickeInvolution_eq_of_etaQuotient hN hr hk f hf,
      hm.neg_one_zpow, neg_one_smul]

/-- **SDF-18d — the PACKAGING declaration, so one `lean_name` resolves the whole node.**

`SDF-18` asserts THREE theorems (`frickeInvolution_eq_of_etaQuotient` and its two membership
corollaries), but `dag/check_dag.py` verifies a node by base-name match on a SINGLE `lean_name`
field, so naming the first alone would leave the other two unchecked by the DAG gate — the exact
bookkeeping gap FRK-22 had to close in run 11 (see `frickeEigenspace_mem_iff`).  This conjunction
is the node's resolving name: a `#print axioms` on it reports the axioms of ALL THREE, so a
`sorry` in any one of them would surface here.  It adds no mathematical content.

IT ALSO INHERITS EVERY HYPOTHESIS, and therefore every limitation: `f` is still GIVEN as a modular
form.  Nothing in this library discharges that hypothesis for a nontrivial `r` at any `N`. -/
theorem frickeEigen_of_etaQuotient {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {m : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * (2 * m))
    (f : ModularForm (Gamma0GL N) (2 * m))
    (hf : ∀ τ : ℍ, f τ = etaQuotientH N r τ) :
    frickeInvolution hN m f = ((-1 : ℂ) ^ m) • f
      ∧ (Even m → f ∈ frickePlus hN m)
      ∧ (Odd m → f ∈ frickeMinus hN m) :=
  ⟨frickeInvolution_eq_of_etaQuotient hN hr hk f hf,
    fun hm => mem_frickePlus_of_etaQuotient hN hr hm hk f hf,
    fun hm => mem_frickeMinus_of_etaQuotient hN hr hm hk f hf⟩

/-! ### SDF-18e — THE WITNESS GAP AT `N = 11`, made machine-checkable

The brief this run answers to demands either a witness separating `frickePlus` from `frickeMinus`
on BOTH sides, or a plain statement that none was produced.  This run produced none on the minus
side, and the two declarations below say exactly why, in Lean rather than in prose.

`drk11R11 = (r₁, r₁₁) = (2, 2)` — i.e. `η(τ)² η(11τ)²` — satisfies EVERY arithmetic hypothesis of
`SDF-18c`: it is Fricke self-dual, its exponent sum is `4 = 2·(2·1)` so `m = 1`, and `1` is odd,
which is the `frickeMinus` branch.  All three are settled below by `decide`.  The eigenvalue
`SDF-18` predicts there is `(-1)^1 = -1`, pinned numerically by `sdf18_pin_level_eleven` above.

WHAT IS STILL MISSING, AND IT IS THE ONLY THING MISSING: the modular form `f` itself.
`EtaLigozatLevelEleven.lean` proves the `Γ₀(11)` TRANSFORMATION LAW for this exponent vector
sorry-free (`ModularForm.etaProductEleven_transform`) and holomorphy is `mdiff_etaQuotientH`, but
BOUNDEDNESS AT THE CUSPS is `F3.1-OBSTRUCTED` and is not proved at any level for any nontrivial
exponent vector.  So `mem_frickeMinus_etaProductEleven` below still takes `f` as a hypothesis, and
NOTHING in this library discharges it.  CUSP BOUNDEDNESS AT `N = 11` IS THIS NODE'S NEXT
OBSTRUCTION — a named, single, actionable gap, not "no witness exists anywhere". -/

section Sdf18WitnessGap

/-- **SDF-18e.**  Every arithmetic hypothesis of `SDF-18c` holds at `N = 11`, `r = drk11R11`,
`m = 1`.  Decided, not asserted.  This is the honest measure of the remaining distance to a
`-1`-eigenform: three conditions met, one (`f` itself) open. -/
theorem sdf18_level_eleven_hypotheses :
    IsFrickeSelfDual 11 drk11R11
      ∧ (∑ δ ∈ (11 : ℕ).divisors, drk11R11 δ = 2 * (2 * (1 : ℤ)))
      ∧ Odd (1 : ℤ) :=
  ⟨by decide, by decide, ⟨0, by ring⟩⟩

/-- **SDF-18f.**  `SDF-18c` specialised to `N = 11`, `r = drk11R11`, `m = 1`: the exponent vector
of `η(τ)² η(11τ)²`.  READ THE HYPOTHESIS — `f` is GIVEN.  This does not exhibit a `-1`-eigenform;
it says that the only thing between this library and one is a modular form at level 11 with this
`q`-expansion, i.e. cusp boundedness (`F3.1-OBSTRUCTED`).  It is stated so that the day that
obstruction falls, the eigenform is one `exact` away. -/
theorem mem_frickeMinus_etaProductEleven (f : ModularForm (Gamma0GL 11) (2 * 1))
    (hf : ∀ τ : ℍ, f τ = etaQuotientH 11 drk11R11 τ) :
    f ∈ frickeMinus (by norm_num : (0 : ℕ) < 11) 1 :=
  mem_frickeMinus_of_etaQuotient _ (by decide) ⟨0, by ring⟩ (by decide) f hf

end Sdf18WitnessGap

/-! ### SDF-19 — the witness exponent vector, and the pins that must hold BEFORE the lift

`rMinusWitness` is the exponent vector of `η(2τ)^12` at `N = 4`: `r₂ = 12`, everything else `0`.
Classically this is the unique newform of `S₆(Γ₀(4))` and its Fricke eigenvalue is `-1`.  Nothing
below assumes that classical fact; it is recomputed here from this library's own definitions, and
the four value pins are stated and proved BEFORE the general lemma so that a wrong sign or a wrong
power of `N` cannot survive.

HAND COMPUTATION FIRST, at `N = 4`, `λ = frickeEigenvalue 4 k = i^(-k) · √(4^k)`:

| `m` | `k = 2m` | `i^(-k)` | `√(4^k)` | `λ`     | `4^(1-m) · (4⁻¹ λ)`        | `(-1)^m` |
|-----|----------|----------|----------|---------|----------------------------|----------|
| 1   | 2        | `-1`     | `4`      | `-4`    | `4^0 · (-1) = -1`          | `-1`     |
| 2   | 4        | `1`      | `16`     | `16`    | `4^(-1) · 4 = 1`           | `1`      |
| 3   | 6        | `-1`     | `64`     | `-64`   | `4^(-2) · (-16) = -1`      | `-1`     |
| 5   | 10       | `-1`     | `1024`   | `-1024` | `4^(-4) · (-256) = -1`     | `-1`     |

All four are at `N = 4` — the witness's OWN level — and at four weights that appear at no other
pin in this library (`SDF-18`'s four pins live at `(11,1)`, `(2,3)`, `(4,4)`, `(3,-2)`; note that
`(4, m = 4)` there is `k = 8`, disjoint from the `k ∈ {2,4,6,10}` used here).  Row 2 is the PLUS
side and rows 1, 3, 5 the MINUS side, so a proof that silently produced `+1` everywhere is refuted.

THE `m = 3` ROW IS THE ONE THE WITNESS STANDS ON, and it was checked three independent ways
before any Lean was written: (a) from the definition, `i^(-6) · √(4^6) = (-1) · 64 = -64`;
(b) from the classical eta transformation, `η(2·(-1/(4τ)))^12 = η(-1/(2τ))^12 = (-i·2τ)^6 η(2τ)^12
= (-i)^6 · 64 · τ^6 · η(2τ)^12 = -64 τ^6 η(2τ)^12`; (c) numerically, evaluating `η(2τ)^12` at
`τ = 0.3+0.9i`, `-0.17+1.4i`, `0.05+0.62i` and dividing, which gives `-64.000000000000` each time.
All three agree.  THE MUST-FAIL CONTROL is that the same proof script with `64` in place of `-64`
leaves the goal `-64 = 64` and does not compile.

TWO NEGATIVE CONTROLS ON THE CONSTANT are inside the `m = 3` pin, and they are exactly the two
spellings that would otherwise be indistinguishable from the true one:
  * `(-1)^(2m)` in place of `(-1)^m` — refuted, since the truth at `m = 3` is `-1` and the wrong
    spelling gives `+1`;
  * dropping the `N^(1-m)` normalisation — refuted, since the unnormalised `4⁻¹ λ` is `-16`.
FOUR MORE NEGATIVE CONTROLS sit on the COMBINATORIAL side (`sdf19_pin_witness_neg_controls`), so
that the `decide`s below cannot be dismissed as vacuously true of any exponent vector at all.

If any pin disagreed with the table, the STATEMENT would be wrong and this run would stop. -/

section SDF19Pins

/-- **SDF-19 witness vector.**  `r₂ = 12`, all other exponents `0`, at `N = 4`: the exponent vector
of `η(2τ)^12`.  Defined here and nowhere else in this library. -/
def rMinusWitness : EtaExp := fun δ => if δ = 2 then (12 : ℤ) else 0

/-- PIN SDF-19-1 — `N = 4`, `m = 1`, `k = 2`.  `λ = -4`, normalised `-1 = (-1)^1`. -/
theorem sdf19_pin_level_four_weight_two :
    frickeEigenvalue 4 2 = -4
      ∧ ((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 1) * (((4 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 4 2)
          = (-1 : ℂ) ^ (1 : ℤ) := by
  have hv : frickeEigenvalue 4 2 = -4 := by
    rw [frickeEigenvalue, I_zpow_neg_two,
        show (((4 : ℕ) : ℝ) ^ (2 : ℤ)) = (4 : ℝ) ^ 2 by norm_num,
        Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 4)]
    push_cast; ring
  exact ⟨hv, by rw [hv]; norm_num⟩

/-- PIN SDF-19-2 — `N = 4`, `m = 2`, `k = 4`, the PLUS-side instance at this level.
`λ = 16`, normalised `1 = (-1)^2`. -/
theorem sdf19_pin_level_four_weight_four :
    frickeEigenvalue 4 4 = 16
      ∧ ((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 2) * (((4 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 4 4)
          = (-1 : ℂ) ^ (2 : ℤ) := by
  have hI : (Complex.I : ℂ) ^ (-4 : ℤ) = 1 := by
    rw [show (-4 : ℤ) = (-2) * 2 by decide, _root_.zpow_mul, I_zpow_neg_two]; norm_num
  have hv : frickeEigenvalue 4 4 = 16 := by
    rw [frickeEigenvalue, hI,
        show (((4 : ℕ) : ℝ) ^ (4 : ℤ)) = (16 : ℝ) ^ 2 by norm_num,
        Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 16)]
    push_cast; ring
  exact ⟨hv, by rw [hv]; norm_num⟩

/-- PIN SDF-19-3 — **THE WITNESS PIN**, `N = 4`, `m = 3`, `k = 6`.  `λ = -64` and the normalised
eigenvalue is `-1 = (-1)^3`.  The third conjunct REFUTES the `(-1)^(2m)` spelling; the fourth
REFUTES dropping the `N^(1-m)` normalisation. -/
theorem sdf19_pin_level_four_weight_six :
    frickeEigenvalue 4 6 = -64
      ∧ ((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 3) * (((4 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 4 6)
          = (-1 : ℂ) ^ (3 : ℤ)
      ∧ ((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 3) * (((4 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 4 6)
          ≠ (-1 : ℂ) ^ (2 * 3 : ℤ)
      ∧ (((4 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 4 6) ≠ (-1 : ℂ) ^ (3 : ℤ) := by
  have hI : (Complex.I : ℂ) ^ (-6 : ℤ) = -1 := by
    rw [show (-6 : ℤ) = (-2) * 3 by decide, _root_.zpow_mul, I_zpow_neg_two]; norm_num
  have hv : frickeEigenvalue 4 6 = -64 := by
    rw [frickeEigenvalue, hI,
        show (((4 : ℕ) : ℝ) ^ (6 : ℤ)) = (64 : ℝ) ^ 2 by norm_num,
        Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 64)]
    push_cast; ring
  refine ⟨hv, ?_, ?_, ?_⟩
  · rw [hv]; norm_num
  · rw [hv]; norm_num
  · rw [hv]; norm_num

/-- PIN SDF-19-4 — `N = 4`, `m = 5`, `k = 10`.  A second MINUS-side instance at a weight where the
radicand `4^10 = 1048576` is large enough that a stray `pow`/`zpow` confusion would show. -/
theorem sdf19_pin_level_four_weight_ten :
    frickeEigenvalue 4 10 = -1024
      ∧ ((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 5) * (((4 : ℕ) : ℂ)⁻¹ * frickeEigenvalue 4 10)
          = (-1 : ℂ) ^ (5 : ℤ) := by
  have hI : (Complex.I : ℂ) ^ (-10 : ℤ) = -1 := by
    rw [show (-10 : ℤ) = (-2) * 5 by decide, _root_.zpow_mul, I_zpow_neg_two]; norm_num
  have hv : frickeEigenvalue 4 10 = -1024 := by
    rw [frickeEigenvalue, hI,
        show (((4 : ℕ) : ℝ) ^ (10 : ℤ)) = (1024 : ℝ) ^ 2 by norm_num,
        Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 1024)]
    push_cast; ring
  exact ⟨hv, by rw [hv]; norm_num⟩

/-- PIN SDF-19-5 — the exponent SUM, decided at the node's own spelling `2 * (2 * 3)` (so `m = 3`,
weight `6`), not merely at `2 * 6`. -/
theorem sdf19_pin_witness_sum :
    (∑ δ ∈ (4 : ℕ).divisors, rMinusWitness δ) = 2 * (2 * (3 : ℤ)) := by
  unfold rMinusWitness; decide

/-- PIN SDF-19-6 — Fricke self-duality of the witness vector.  `divisors 4 = {1, 2, 4}` and
`r₁ = r₄ = 0`, `r₂ = r₂ = 12`. -/
theorem sdf19_pin_witness_selfDual : IsFrickeSelfDual 4 rMinusWitness := by
  unfold IsFrickeSelfDual rMinusWitness; decide

/-- PIN SDF-19-7 — Ligozat congruence (i): `∑ δ r_δ = 2 · 12 = 24 ≡ 0 (mod 24)`. -/
theorem sdf19_pin_witness_congr1 : LigozatCongr1 4 rMinusWitness := by
  unfold LigozatCongr1 rMinusWitness; decide

/-- PIN SDF-19-8 — Ligozat congruence (ii). -/
theorem sdf19_pin_witness_congr2 : LigozatCongr2 4 rMinusWitness := by
  unfold LigozatCongr2 rMinusWitness; decide

/-- PIN SDF-19-9 — **NEGATIVE CONTROLS on the combinatorial side.**  The `decide`s above are not
true of every exponent vector: putting the exponent on `δ = 1` instead of `δ = 2` breaks Fricke
self-duality at `N = 4`; the exponent `11` breaks congruence (i); and the sum is NOT `2 * (2 * 2)`,
so the weight `m = 3` is forced rather than chosen. -/
theorem sdf19_pin_witness_neg_controls :
    ¬ IsFrickeSelfDual 4 (fun δ => if δ = 1 then (12 : ℤ) else 0)
      ∧ ¬ LigozatCongr1 4 (fun δ => if δ = 2 then (11 : ℤ) else 0)
      ∧ (∑ δ ∈ (4 : ℕ).divisors, rMinusWitness δ) ≠ 2 * (2 * (2 : ℤ)) := by
  refine ⟨?_, ?_, ?_⟩
  · unfold IsFrickeSelfDual; decide
  · unfold LigozatCongr1; decide
  · unfold rMinusWitness; decide

end SDF19Pins

section SDF25Pins

/-! ### SDF-25 pins, group (iii) — the EIGENVALUE BRIDGE, stated ON `frickeEigenvalue`

WHAT THIS GROUP REPAIRS, said plainly.  The SDF-25 node states its group (iii) in the form
`frickeEigenvalue N (2*m) · N⁻¹ · N^(1-m) = (-1)^m`, at `(N,m) = (4,3), (1,6), (9,2), (4,0),
(6,1)`.  The `(4,3)` instance is `sdf19_pin_level_four_weight_six` above, in exactly that form and
with two refutation conjuncts.  The other four had, until this run, been checked only with the
NUMERAL substituted for `λ` in a scratch probe — which tests the arithmetic but not the link to
`frickeEigenvalue`, and the link is the load-bearing half.  The four pins below close that gap by
rewriting through the library's own proved value pins
(`frickeEigenvalue_pin_level_one`, `_pin_level_nine_weight_four`, `_pin_level_four_weight_zero`,
`_pin_level_six_weight_two`), so no numeral is assumed to BE the eigenvalue.

They also widen the level coverage: every value pin in `SDF19Pins` sits at `N = 4`, so the power
of `N` in the normalisation was pinned at one level only.  Here `N ∈ {1, 6, 9}` as well.
Hand values, recomputed this run before compiling:
`λ(1,12) = I^(-12)·√1 = 1`, `1 · 1⁻¹ · 1^(-5) = 1 = (-1)^6`;
`λ(9,4) = I^(-4)·√(9^4) = 81`, `81 · 9⁻¹ · 9^(-1) = 1 = (-1)^2`;
`λ(4,0) = 1`, `1 · 4⁻¹ · 4^1 = 1 = (-1)^0`;
`λ(6,2) = I^(-2)·√36 = -6`, `-6 · 6⁻¹ · 6^0 = -1 = (-1)^1`.
No pin disagreed with the hand value, so no statement was adjusted.

HONEST LIMIT: `N = 1` is degenerate (every power of `1` is `1`), so `(1,6)` tests the `(-1)^m`
side and the `I^(-2m)` computation but says nothing about the power of `N`.  `(9,2)` and `(6,1)`
carry that weight, and each of them ships a refutation conjunct. -/

/-- **SDF-25 (iii)-1** (`N = 1`, `m = 6`, weight `2*6 = 12`).  Degenerate level: the normalisation
is invisible, and what is tested is `λ(1,12) = 1` against `(-1)^6 = 1`. -/
theorem sdf25_pin_bridge_one_six :
    frickeEigenvalue 1 (2 * 6) * ((1 : ℕ) : ℂ)⁻¹ * ((1 : ℕ) : ℂ) ^ ((1 : ℤ) - 6)
      = (-1 : ℂ) ^ (6 : ℤ) := by
  rw [show (2 * 6 : ℤ) = 12 by norm_num, frickeEigenvalue_pin_level_one]
  norm_num

/-- **SDF-25 (iii)-2** (`N = 9`, `m = 2`, weight `4`), with a NEGATIVE CONTROL: dropping the
`N^(1-m)` factor leaves `81 · 9⁻¹ = 9 ≠ 1`, so the normalisation is proved necessary at this
instance rather than carried along.  `N = 9` is not `4`, so this is the first level at which the
power of `N` in the bridge is pinned independently. -/
theorem sdf25_pin_bridge_nine_two :
    frickeEigenvalue 9 (2 * 2) = 81
    ∧ frickeEigenvalue 9 (2 * 2) * ((9 : ℕ) : ℂ)⁻¹ * ((9 : ℕ) : ℂ) ^ ((1 : ℤ) - 2)
      = (-1 : ℂ) ^ (2 : ℤ)
    ∧ frickeEigenvalue 9 (2 * 2) * ((9 : ℕ) : ℂ)⁻¹ ≠ (-1 : ℂ) ^ (2 : ℤ) := by
  rw [show (2 * 2 : ℤ) = 4 by norm_num, frickeEigenvalue_pin_level_nine_weight_four]
  refine ⟨rfl, by norm_num, by norm_num⟩

/-- **SDF-25 (iii)-3** (`N = 4`, `m = 0`, weight `0`).  The `1 - m = 1` end, where the
normalisation MULTIPLIES by `N`: `1 · 4⁻¹ · 4 = 1`.  Together with (iii)-1's `1 - m = -5` this
brackets the sign of the normalising exponent inside the bridge itself. -/
theorem sdf25_pin_bridge_four_zero :
    frickeEigenvalue 4 (2 * 0) * ((4 : ℕ) : ℂ)⁻¹ * ((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 0)
      = (-1 : ℂ) ^ (0 : ℤ) := by
  rw [show (2 * 0 : ℤ) = 0 by norm_num, frickeEigenvalue_pin_level_four_weight_zero]
  norm_num

/-- **SDF-25 (iii)-4 — THE MINUS-SIDE INSTANCE AT A COMPOSITE LEVEL** (`N = 6`, `m = 1`, weight
`2`).  `λ = -6` and the normalised value is `-1 = (-1)^1`: the first `-1` in this group, at a level
that is neither `4` nor a prime power.  The third conjunct REFUTES the `(-1)^(2m)` spelling, which
would read `+1` here — the same discrimination `sdf19_pin_level_four_weight_six` makes at `N = 4`,
now made at a second level. -/
theorem sdf25_pin_bridge_six_one :
    frickeEigenvalue 6 (2 * 1) = -6
    ∧ frickeEigenvalue 6 (2 * 1) * ((6 : ℕ) : ℂ)⁻¹ * ((6 : ℕ) : ℂ) ^ ((1 : ℤ) - 1)
      = (-1 : ℂ) ^ (1 : ℤ)
    ∧ frickeEigenvalue 6 (2 * 1) * ((6 : ℕ) : ℂ)⁻¹ * ((6 : ℕ) : ℂ) ^ ((1 : ℤ) - 1)
      ≠ (-1 : ℂ) ^ (2 * 1 : ℤ) := by
  rw [show (2 * 1 : ℤ) = 2 by norm_num, frickeEigenvalue_pin_level_six_weight_two]
  refine ⟨rfl, by norm_num, by norm_num⟩

/-- **SDF-25 — the packaging conjunction the DAG node resolves to.**

One declaration whose statement touches all five groups the node enumerates, so that a single
`lean_name` base-name match covers the battery and a `sorry` in any component would surface here:

* (i)   the constant at `(4,6)`, BOTH spellings against the numeral `256`;
* (ii)  the normalisation at `(4,3)`;
* (iii) the eigenvalue bridge at `(9,2)`, on `frickeEigenvalue` itself;
* (iv)  the three `decide` facts about the witness vector `η(2τ)^12` at `N = 4` — self-duality and
        Ligozat's congruences (i) and (ii).  NOTE WHAT IS ABSENT: Ligozat's condition (iii), cusp
        boundedness, is `F3.1-OBSTRUCTED` and is NOT asserted here or anywhere; nothing in this
        battery says the eta quotient IS a modular form;
* (v)   the `σ` branch at the NON-REAL scalar `I`, where the conjugating branch would give `-I`.

Every conjunct is discharged by a named pin above or earlier in this file; this declaration adds
no mathematical content of its own. -/
theorem sdf25_pin_battery :
    (((((4 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((6 : ℤ) - 1) * ((-((4 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(6 : ℤ))
        = (256 : ℂ)
      ∧ (-1 : ℂ) ^ (6 : ℤ) * ((4 : ℕ) : ℂ) ^ ((6 : ℤ) - 2) = (256 : ℂ))
    ∧ (((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 3)) * (((4 : ℕ) : ℂ) ^ ((1 : ℤ) - 3))
        * (((((4 : ℕ) : ℝ) ^ 2 : ℝ) : ℂ) ^ ((2 * 3 : ℤ) - 1)
            * ((-((4 : ℕ) : ℝ) : ℝ) : ℂ) ^ (-(2 * 3 : ℤ))) = 1
    ∧ frickeEigenvalue 9 (2 * 2) * ((9 : ℕ) : ℂ)⁻¹ * ((9 : ℕ) : ℂ) ^ ((1 : ℤ) - 2)
        = (-1 : ℂ) ^ (2 : ℤ)
    ∧ (IsFrickeSelfDual 4 rMinusWitness
        ∧ LigozatCongr1 4 rMinusWitness
        ∧ LigozatCongr2 4 rMinusWitness)
    ∧ σ (frickeW (by norm_num : 0 < 2)) Complex.I = Complex.I :=
  ⟨sdf25_pin_const_four_six,
   sdf25_pin_norm_four_three,
   sdf25_pin_bridge_nine_two.2.1,
   ⟨sdf19_pin_witness_selfDual, sdf19_pin_witness_congr1, sdf19_pin_witness_congr2⟩,
   frickeW_sigma_pin_two_I⟩

end SDF25Pins


/-- **SDF-19 — THE RESTRICTED LIFT, `0 < N ≤ 4`, no modularity hypothesis on the caller.**

Here the modular form is CONSTRUCTED by the library's own sorry-free `etaQuotientModularForm`
(`EtaQuotientModularity.lean:3494`), so no `f` has to be supplied.  `N ≤ 4` is the real bound in
the Lean sources.

STILL NOT UNCONDITIONAL, and the paper must say so: `etaQuotientModularForm` takes Ligozat's
condition (iii) as the hypothesis `hbd`, which this library discharges for no nontrivial exponent
vector.  What is unconditional at `N ≤ 4` is the TRANSFORMATION LAW, not the whole modularity. -/
theorem frickeInvolution_etaQuotientModularForm {N : ℕ} (hN : 0 < N) (hN4 : N ≤ 4)
    {r : EtaExp} (hr : IsFrickeSelfDual N r) {m : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * (2 * m))
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    (hbd : ∀ γ : SL(2, ℤ), IsBoundedAtImInfty ((etaQuotientH N r) ∣[(2 * m : ℤ)] γ)) :
    frickeInvolution hN m (etaQuotientModularForm hN hN4 r hk h1 h2 ⟨m, by ring⟩ hbd)
      = ((-1 : ℂ) ^ m) • etaQuotientModularForm hN hN4 r hk h1 h2 ⟨m, by ring⟩ hbd :=
  -- PROVED (run 14).  Exactly the route the `-- OPEN:` note predicted and nothing more: SDF-18a at
  -- `f := etaQuotientModularForm ...`, whose `hf` obligation is `etaQuotientModularForm_apply`,
  -- definitionally `rfl`.  NO new mathematics, and in particular NO new modularity: `hbd` is still
  -- the caller's, and `etaQuotientModularForm` is the library's own sorry-free packager for
  -- `N ≤ 4`.  The eigenvalue comes from SDF-17c/SDF-17d, neither of which mentions `ModularForm`.
  frickeInvolution_eq_of_etaQuotient hN hr hk _ (fun _ => rfl)

/-! ### SDF-19b — THE `-1`-EIGENSPACE WITNESS AT `N = 4`, `m = 3`, AND EXACTLY HOW CONDITIONAL IT IS

`rMinusWitness` is `r₂ = 12` at `N = 4`, i.e. `η(2τ)^12`.  Its four arithmetic hypotheses are
DECIDED above (`sdf19_pin_witness_*`), so `etaQuotientModularForm` builds an actual
`ModularForm (Gamma0GL 4) (2 * 3)` out of it, SDF-18c puts that form in `frickeMinus`, and
`etaQuotientH_ne_zero` says it is not `0`.  Hence `frickeMinus ≠ ⊥`: this is the FIRST
`-1`-eigenspace nontriviality statement anywhere in this library, and the first time the eigenspace
decomposition has any content on the minus side at all.

READ THE HYPOTHESIS BEFORE QUOTING THIS.  `hbd` — Ligozat's condition (iii), cusp boundedness — is
STILL A HYPOTHESIS, and this library discharges it for no nontrivial exponent vector at any level
(`F3.1-OBSTRUCTED`).  So `frickeMinus_ne_bot_level_four` is CONDITIONAL, and its honest reading is:
`-1`-eigenspace nontriviality at level 4 weight 6 is now reduced to ONE named, classical condition
at ONE level for ONE exponent vector.

CONDITIONAL IS NOT VACUOUS, and the distinction carries the whole weight of this node.  `hbd` is
classically TRUE here — `η(2τ)^12` is the unique newform of `S₆(Γ₀(4))`, with `q`-expansion
`q ∏ (1 - q^{2n})^{12}`, visibly vanishing at `i∞` — so this is a theorem conditional on a
true-but-unproved hypothesis, NOT a theorem whose hypothesis is false and whose content is empty.
This library does not prove that classical fact and does not use it; it is stated here so that no
reader mistakes the conditionality for vacuity, and no reader mistakes the citation for a proof.

WHAT IS STILL NOT WITNESSED, stated plainly.  The `+1` witness (FRK-27c/FRK-66,
`ModularForm.const 1`) lives at `m = 0` and this `-1` witness at `m = 3`.  NO SINGLE `(N, m)` is
shown here to have BOTH eigenspaces nonzero, and `frickePlus ≠ frickeMinus` remains proved only at
weight `0`.  The eigenspace decomposition of `M₆(Γ₀(4))` therefore has exactly ONE side witnessed,
and even that one conditionally.  That is this node's standing limitation. -/

/-- **SDF-19b.**  The `-1` Fricke eigenspace at `N = 4`, `m = 3` (weight `6`) is nontrivial,
GIVEN Ligozat's condition (iii) for `η(2τ)^12`.  See the section docstring: `hbd` is undischarged
in this library but classically true, so this is conditional, not vacuous. -/
theorem frickeMinus_ne_bot_level_four
    (hbd : ∀ γ : SL(2, ℤ), IsBoundedAtImInfty ((etaQuotientH 4 rMinusWitness) ∣[(6 : ℤ)] γ)) :
    frickeMinus (show (0 : ℕ) < 4 by norm_num) 3 ≠ ⊥ := by
  have h4 : (0 : ℕ) < 4 := by norm_num
  -- The weight literal `(6 : ℤ)` in `hbd` unifies with `2 * 3`; no coercion gap.
  set f := etaQuotientModularForm h4 (by norm_num) rMinusWitness sdf19_pin_witness_sum
    sdf19_pin_witness_congr1 sdf19_pin_witness_congr2 ⟨3, by ring⟩ hbd with hfdef
  have hf : ∀ τ : ℍ, f τ = etaQuotientH 4 rMinusWitness τ := fun _ => rfl
  have hmem : f ∈ frickeMinus h4 3 :=
    mem_frickeMinus_of_etaQuotient h4 sdf19_pin_witness_selfDual ⟨1, by ring⟩
      sdf19_pin_witness_sum f hf
  have hne : f ≠ 0 := by
    intro h
    have hval := congrArg (fun g : ModularForm (Gamma0GL 4) (2 * 3) => g UpperHalfPlane.I) h
    rw [hf UpperHalfPlane.I] at hval
    have h0 : ((0 : ModularForm (Gamma0GL 4) (2 * 3)) : ℍ → ℂ) UpperHalfPlane.I = 0 := rfl
    exact etaQuotientH_ne_zero 4 rMinusWitness UpperHalfPlane.I (hval.trans h0)
  intro hbot
  exact hne ((Submodule.mem_bot ℂ).mp (hbot ▸ hmem))

/-- **SDF-19c — the PACKAGING declaration, so one `lean_name` resolves the whole node.**

`SDF-19` asserts a `def` (`rMinusWitness`) and TWO theorems, but `dag/check_dag.py` verifies a node
by base-name match on a SINGLE `lean_name`, so naming either theorem alone would leave the other
unchecked by the DAG gate — the bookkeeping gap `FRK-22c` and `SDF-18d` each had to close.  This
conjunction is the node's resolving name: a `#print axioms` on it reports the axioms of BOTH
theorems (and, through `frickeMinus_ne_bot_level_four`, of `rMinusWitness` and all nine pins).
It adds no mathematical content, and it inherits `hbd` in both conjuncts. -/
theorem sdf19_frickeEigen_etaQuotientModularForm :
    (∀ {N : ℕ} (hN : 0 < N) (hN4 : N ≤ 4) {r : EtaExp} (_hr : IsFrickeSelfDual N r) {m : ℤ}
      (hk : ∑ δ ∈ N.divisors, r δ = 2 * (2 * m))
      (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
      (hbd : ∀ γ : SL(2, ℤ), IsBoundedAtImInfty ((etaQuotientH N r) ∣[(2 * m : ℤ)] γ)),
        frickeInvolution hN m (etaQuotientModularForm hN hN4 r hk h1 h2 ⟨m, by ring⟩ hbd)
          = ((-1 : ℂ) ^ m) • etaQuotientModularForm hN hN4 r hk h1 h2 ⟨m, by ring⟩ hbd)
    ∧ (∀ _ : ∀ γ : SL(2, ℤ), IsBoundedAtImInfty ((etaQuotientH 4 rMinusWitness) ∣[(6 : ℤ)] γ),
        frickeMinus (show (0 : ℕ) < 4 by norm_num) 3 ≠ ⊥) :=
  ⟨fun {_N} hN hN4 {_r} hr {_m} hk h1 h2 hbd =>
      frickeInvolution_etaQuotientModularForm hN hN4 hr hk h1 h2 hbd,
    fun hbd => frickeMinus_ne_bot_level_four hbd⟩

/-- **SDF-20 — THE CONDITIONAL `-1`-EIGENFORM WITNESS, and an honest statement of what is missing.**

PROVED, sorry-free (closed after the run that left it `sorry`; the argument is exactly the one the
`-- OPEN:` comment below named, `mem_frickeMinus_of_etaQuotient` + `Submodule.ne_bot_iff`).

If a self-dual eta quotient of weight `2 * m` with `m` ODD is a nonzero modular form, then
`frickeMinus` is nontrivial at that level. What this theorem does NOT give is an UNCONDITIONAL
witness: `f` and `f ≠ 0` are hypotheses, and NOTHING IN THIS LIBRARY DISCHARGES THEM
UNCONDITIONALLY AT ANY `N` — no unconditional nonzero `-1`-Fricke-eigenform is exhibited anywhere,
at any level. The unconditional witness FRK-27c separates the two eigenspaces from the `+1` side
only. SDF-19b (`frickeMinus_ne_bot_level_four`, proved above) reaches the same conclusion at
`N = 4`, `m = 3` WITHOUT taking `f` as a hypothesis — it constructs the form from
`etaQuotientModularForm` — but it still carries Ligozat's condition (iii) as `hbd`. Producing an
UNCONDITIONAL `-1`-eigenform — which needs a self-dual `r` with `∑ r δ = 4m`, `m` odd, satisfying
Ligozat (i), (ii) AND cusp-boundedness (iii) at a general level — is the real remaining obstruction
here, and it is exactly F3.1-OBSTRUCTED: no nontrivial exponent vector discharges Ligozat's
condition (iii) at any level in this library today. This theorem is not that obstruction; it is
the conditional bridge to it. -/
theorem frickeMinus_ne_bot_of_etaQuotient {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {m : ℤ} (hm : Odd m)
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * (2 * m))
    (f : ModularForm (Gamma0GL N) (2 * m))
    (hf : ∀ τ : ℍ, f τ = etaQuotientH N r τ) (hf0 : f ≠ 0) :
    frickeMinus hN m ≠ ⊥ := by
  rw [Submodule.ne_bot_iff]
  exact ⟨f, mem_frickeMinus_of_etaQuotient hN hr hm hk f hf, hf0⟩

end SocrateAI.ModularForms
