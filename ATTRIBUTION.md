# ATTRIBUTION — third-party material in this repository, declaration by declaration

This repository (`SocrateAI-Lean-Lib`) is released under the MIT licence (`LICENSE`).  This file
lists every declaration in it that was **taken or adapted from a third-party project**, names the
upstream file, states the extent, and reproduces the upstream copyright holder and author list
where the upstream file carries one.

The format follows `anthropics/fermats-last-theorem`'s own `ATTRIBUTION.md`: a table keyed by
*our* file, with the upstream path, the extent, and the upstream copyright/author line reproduced
verbatim from the upstream header.  We differ from FLT's table in one way, deliberately: because
a single file of ours can mix ported and independently derived declarations, **the unit of this
table is the declaration, not the file.**  Every declaration in a listed file is accounted for as
one of three kinds:

| Kind | Meaning |
|---|---|
| **PORTED** | The Lean text is upstream's, byte-for-byte or with mechanical adjustment only. |
| **STATEMENT-ONLY** | Upstream's *statement* is reproduced; upstream's *proof* is not used and is not usable here (it is `p2m_exact_reverting` against an FLT `P2M/Sol` solution file, and that tactic does not exist in this library).  Our proof obligation is open. |
| **INDEPENDENT** | Written here from Apostol/Mathlib primitives.  Listed only so the reader can see it was *considered* and is *not* a port — including where it ends up mathematically equivalent to something upstream. |

Nothing in this repository is claimed as original where it is not.  Conversely, a declaration
that happens to agree with an upstream one is **not** recorded as a port unless the Lean text
actually came from upstream; §3 says which is which, per declaration.

## 0. Upstream projects

| Project | URL | Licence | Verified |
|---|---|---|---|
| `anthropics/fermats-last-theorem` ("FLT") | <https://github.com/anthropics/fermats-last-theorem> | Apache License 2.0 (repository `LICENSE`, fetched 2026-09-07, HTTP 200, 11345 bytes) | 2026-09-07 |

Apache-2.0 permits redistribution in a differently licensed work provided the licence and the
attribution notices travel with the material.  This file is that notice.  The Apache-2.0 licence
text is reproduced in `licenses/APACHE-2.0-fermats-last-theorem.txt`.

### Upstream files whose material is in this repository

Copyright for all files below, absent an explicit per-file header, is Anthropic, PBC (per FLT's
repository-level `NOTICE`, reproduced at `licenses/NOTICE-fermats-last-theorem.txt`) — **not**
"the FLT repository itself" as an earlier version of this row said.

| Upstream path | Bytes | Fetched | Used for | Upstream header |
|---|---|---|---|---|
| `Definitions/Def_NumberTheory_DedekindSum.lean` | 4731 | 2026-09-07, HTTP 200 | 21/21 declarations ported verbatim (\S1) | none — not listed in FLT's own `ATTRIBUTION.md` either, i.e. FLT does not flag it as third-party material there |
| `Theorems/Thm_dedekindSum_add_dedekindSum.lean` | 391 | 2026-09-07, HTTP 200 | statement-only port (\S1) | none (3 `import` lines and one `theorem`) |
| `Theorems/Thm_rademacher_phi_step.lean` | 429 | 2026-09-07, HTTP 200 | statement-only port (\S2) | none (3 `import` lines and one `theorem`) |
| `Theorems/Thm_ModularForm_eta_specialLinearGroup_smul.lean` | 1024 | 2026-09-07, HTTP 200 | statement-only port (\S3) | none (5 `import` lines and one `theorem`) |
| `Theorems/Thm_dedekindSum_jacobiSym_mod_eight.lean` | 449 | 2026-09-08, HTTP 200 | statement-only port (\S6) | none (4 `import` lines and one `theorem`) |
| `Theorems/Thm_Complex_sqrt_mul_sqrt_eq_of_re_pos.lean` | 403 | 2026-09-08, HTTP 200 | matching-shape statement, independent proof (\S3) | none |
| `Theorems/Thm_ModularForm_etaProductEleven_transform.lean` | 936 | 2026-09-08, HTTP 200 | statement-identical comparator target, independent proof (\S11) | none |

### Upstream files fetched for comparison / proof-shape checks only (no material used here)

| Upstream path | Bytes | Fetched | Why fetched |
|---|---|---|---|
| `Theorems/Thm_exists_intCast_eq_six_mul_dedekindSum.lean` | 330 | 2026-09-08, HTTP 200 | provenance check for \S8 (see correction there) |
| `Theorems/Thm_dedekindSum_one_left.lean` | 278 | 2026-09-08, HTTP 200 | coverage sweep; no declaration here corresponds to it |
| `Theorems/Thm_dedekindSum_of_mul_modEq_one.lean` | 341 | 2026-09-08, HTTP 200 | coverage sweep; no declaration here corresponds to it |
| `P2M/Sol/S_ModularForm_eta_specialLinearGroup_smul.lean` | 9055 | 2026-09-07, HTTP 200 | sorry/admit/axiom count only (\S3); proof text not used, see \S3's correction |
| `P2M/Sol/S_dedekindSum_add_dedekindSum.lean` | 62736 | 2026-09-07, HTTP 200 | sorry/admit/axiom count only (\S1); also surfaced the \S8 correction |
| `P2M/Sol/S_rademacher_phi_step.lean` | 62787 | 2026-09-07, HTTP 200 | sorry/admit/axiom count only (\S2); proof text not used, see \S2's correction |
| `P2M/Sol/S_ModularForm_etaProductEleven_transform.lean` | 39366 | 2026-09-08, HTTP 200 | proof-shape grep only (\S11); proof text not used |
| `P2M/Sol/S_ModularForm_etaProductEleven_smul_of_apply_one_zero_eq.lean` | 40579 | 2026-09-08, HTTP 200 | fetched alongside the above; not read for proof content |

## 1. `Lean/SocrateAI/NumberTheory/DedekindSum.lean`

Upstream: `anthropics/fermats-last-theorem`, `Definitions/Def_NumberTheory_DedekindSum.lean`
(Apache-2.0; no upstream copyright header, see §0).

**Extent: 21 declarations in our file are byte-identical to upstream; everything else in the file
is ours.**  The file grew on 2026-09-07 (the `DRK-02` proof and its gate), so the old fraction
"21 of 24" no longer holds and is corrected here rather than left to rot: the ported set is still
exactly those 21 declarations and has not grown by one line.  This was
checked mechanically, not by eye: each upstream `def`/`theorem` block was extracted and compared
character-for-character against ours; 21 identical, 0 differing, 0 missing.  The only changes to
the ported material are (a) **ordering** — `def dedekindSum` is hoisted above the `dedekindSaw`
lemma block, so that the `DRK-00` sign-discipline gate can sit between the definitions and the
theory they are meant to guard — and (b) the addition of a `namespace SocrateAI.NumberTheory`
wrapper and of docstrings.  No proof text was altered.

| Declaration | Kind | Note |
|---|---|---|
| `dedekindSaw` | PORTED | byte-identical |
| `dedekindSum` | PORTED | byte-identical |
| `dedekindSaw_of_fract_eq_zero` | PORTED | byte-identical |
| `dedekindSaw_of_fract_ne_zero` | PORTED | byte-identical |
| `dedekindSaw_intCast` | PORTED | byte-identical |
| `dedekindSaw_natCast` | PORTED | byte-identical |
| `dedekindSaw_zero` | PORTED | byte-identical |
| `dedekindSaw_one` | PORTED | byte-identical |
| `dedekindSaw_add_intCast` | PORTED | byte-identical |
| `dedekindSaw_intCast_add` | PORTED | byte-identical |
| `dedekindSaw_add_natCast` | PORTED | byte-identical |
| `dedekindSaw_neg` | PORTED | byte-identical |
| `abs_dedekindSaw_lt_half` | PORTED | byte-identical |
| `dedekindSaw_half` | PORTED | byte-identical |
| `dedekindSaw_natCast_div` | PORTED | byte-identical |
| `dedekindSum_zero_right` | PORTED | byte-identical |
| `dedekindSum_one_right` | PORTED | byte-identical |
| `dedekindSum_zero_left` | PORTED | byte-identical |
| `dedekindSum_neg` | PORTED | byte-identical |
| `dedekindSum_add_mul` | PORTED | byte-identical |
| `dedekindSum_eq_sum_Ico` | PORTED | byte-identical |
| `dedekindSum_five_pin`, `dedekindSum_neg_three_seven_pin`, `dedekindSum_four_twelve_pin`, `dedekindSum_one_one_pin`, `dedekindSum_reciprocity_five_twelve_pin`, `dedekindSum_reciprocity_fails_four_twelve`, and the `DRK-00` gate `example`s | INDEPENDENT | Numeric pins.  Nothing like them exists upstream.  Their *values* were computed here, in Python (`fractions.Fraction`) and then by the Lean kernel (`decide +kernel`), and recomputed from scratch on 2026-09-07 with 0 mismatches; four of the values the run brief supplied were wrong and are corrected in the file's header.  The six *named* ones are the guarded lemmas the brief asks for (one per regime: positive `h`, negative `h`, composite `k`, degenerate `k`, a reciprocity instance, and the non-coprime negative control); each has a `#print axioms` guard in `FinalCheck.lean`. |
| `dedekindSum_add_dedekindSum` | **STATEMENT-ONLY** (statement) + **INDEPENDENT** (proof) | The *statement* is from `Theorems/Thm_dedekindSum_add_dedekindSum.lean`, with upstream's binder names, hypothesis order and shape, so a comparator can check it character-for-character.  The *proof*, landed 2026-09-07, is **not** upstream's and is **not** adapted from it: upstream's is `p2m_exact_reverting @P2MW.S_dedekindSum_add_dedekindSum.solution`, that tactic does not exist in this library, and this run's Fetch phase retrieved it, in the same batch as the other two `P2M/Sol` files below, to count `sorry`/`admit`/`axiom` occurrences (0/0/0); that content was not passed into the prompt of the agent that wrote the proof below. Structurally, upstream's proof at that theorem is the single opaque tactic call `p2m_exact_reverting @P2MW.S_dedekindSum_add_dedekindSum.solution` against its own solver infrastructure, which does not exist here, so its proof term could not have been transcribed regardless.  Ours is the classical **Rademacher–Grosswald lattice-point double count**, re-derived here against Mathlib primitives (`Finset.sum_comm`, `Finset.sum_image`, `Nat.div_add_mod`, `Nat.ModEq.cancel_left_of_coprime`, `Nat.div_lt_iff_lt_mul`).  It is also *not* Apostol's Theorem 3.11 proof, which goes through finite cotangent sums.  **Do not cite FLT for the proof.**  Sorry-free; footprint `[propext, Classical.choice, Quot.sound]`, guarded in `FinalCheck.lean`. |
| `sum_Ico_one_const`, `sum_Ico_one_id`, `sum_Ico_one_sq`, `mod_pos_of_coprime`, `sum_mod_perm`, `fibre_left`, `fibre_right`, `double_count`, `sum_expand`, `dedekindSum_eq_modSum` (all `private`) | INDEPENDENT | The scaffolding of the `dedekindSum_add_dedekindSum` proof: Gauss sums over `Ico 1 n` in `ℚ`; the fact that `r ↦ hr mod k` permutes `Ico 1 k` for coprime `h, k`; the two fibre identifications of the lattice rectangle cut by `sk = hr`; the double count itself; and `s(h,k) = (∑ r·(hr mod k))/k² − (k−1)/4`.  Nothing like them exists in the upstream files we fetched, and none was written with upstream's text in view. |
| `dedekindSum_reciprocity_seven_eleven_pin`, `..._nine_twentyfive_pin`, `..._two_fifteen_pin`, `..._four_nine_pin`, `..._eleven_thirteen_pin`, `..._three_eight_pin`, `..._one_one_pin`, `floorSum_id_seven_eleven_pin`, `floorSum_count_seven_eleven_pin`, `floorSum_count_eleven_seven_pin`, `modSum_seven_eleven_pin`, `dedekindSum_reciprocity_fails_six_nine`, `dedekindSum_reciprocity_fails_ten_fifteen`, `dedekindSum_seven_eleven_pin`, `dedekindSum_eleven_seven_pin`, `dedekindSum_nine_twentyfive_pin`, `dedekindSum_twentyfive_nine_pin` | INDEPENDENT | The `DRK-02` sign-discipline gate: seventeen `decide +kernel` pins written **before** the reciprocity proof, values computed first in Python (`fractions.Fraction`) from the definitions rather than from the reciprocity formula, then re-derived by the Lean kernel — 21 checks run, 0 disagreements.  Two of the three negative controls (`(6,9)`, `(10,15)`) are new; the third (`(4,12)`) predates this run.  Each carries a `#print axioms` guard in `FinalCheck.lean`. |

**Re-verification, 2026-09-07 (second, independent pass — commands re-run, not trusted from the
first pass).**  The upstream file was fetched again (`HTTP 200`, `4731` bytes, `4589` characters
by `python len(str)`, LL-17).  Each upstream `def`/`theorem` block was extracted by regex and
compared with `==` against the corresponding block of our file: **21 identical, 0 differing,
0 missing**, and the set difference of declaration names is empty in both directions.  The claim
"PORTED, byte-identical" in the table above is therefore accurate as written, and not overstated.

Every one of these 21 declarations now carries an axiom guard in
`Lean/SocrateAI/FinalCheck.lean` (previously eight of them did), so the *whole* port is a build
dependency of the axiom audit.

## 2. `Lean/SocrateAI/NumberTheory/RademacherPhi.lean`

| Declaration | Kind | Note |
|---|---|---|
| `rademacherPhi` | INDEPENDENT | FLT has **no** `Φ`: it writes `(a+d)/c - 12·s(d,c)` inline inside theorem statements and never names it, and it never treats the `c ≤ 0` cases.  Our definition is total on `SL(2,ℤ)` and carries the `sign(c)` normalisation, neither of which appears upstream.  The normalisation is Apostol's (Apostol, *Modular Functions and Dirichlet Series in Number Theory*, ch. 3). |
| `rademacherPsi` | INDEPENDENT | Not present upstream in any form. |
| `slOf` | INDEPENDENT | Helper for writing pins. |
| `rademacherPhi_S_pin`, `rademacherPhi_ne_rademacherPsi`, and the `DRK-00` gate `example`s | INDEPENDENT | — |
| `SL2_neg_apply` | INDEPENDENT | One-line consequence of Mathlib's `SpecialLinearGroup.coe_neg`.  No FLT counterpart. |
| `pinMatC5`, `pinMatC12`, `pinMatCneg4`, `pinMatC0`, `pinMatC1` and the eleven named `DRK-03` pins (`rademacherPhi_of_pos_pin_*`, `rademacherPhi_of_pos_fails_c_neg`, `rademacherPhi_neg_pin_*`, `rademacherPhi_pin_c_zero_value`, `rademacherPhi_T_zpow_pin_*`) | INDEPENDENT | Values recomputed in Python (`fractions.Fraction`) from the mathematical definitions before the Lean was written, then again by the Lean kernel (`decide +kernel`).  No FLT counterpart. |
| `rademacherPhi_of_pos` | INDEPENDENT (statement designed to match upstream) | The *right-hand side* is upstream's inline expression, transcribed so that the two can be compared; the lemma itself — that our named `Φ` equals it — has no upstream counterpart, because upstream has no `Φ`.  **PROVED 2026-09-07, `sorry`-free.**  The proof is four lines (`if_neg`, `Int.sign_eq_one_of_pos`, `natAbs = toNat` by `omega`, `push_cast; ring`) and was written against Lean core / Mathlib primitives only; FLT's `Thm_rademacher_phi_step` proof was not read or used, and could not have been — upstream never states this lemma. |
| `rademacherPhi_of_pos_toNat` | INDEPENDENT | **PROVED 2026-09-08, `sorry`-free.**  `rademacherPhi_of_pos` with the denominator written `((c.toNat : ℕ) : ℚ)` instead of `((c : ℤ) : ℚ)` — the form FLT's `Thm_ModularForm_eta_specialLinearGroup_smul.lean` uses.  Closes the one-step cast gap the DRK-06 comparator flagged, so the two DRK-06 phrasings are interchangeable by an actual `rw` rather than on paper.  Proof is `Int.toNat_of_nonneg` plus `exact_mod_cast`.  No FLT counterpart. |
| `rademacherPhi_neg` | INDEPENDENT | Not present upstream.  **PROVED 2026-09-07, `sorry`-free.**  Case split on `c = 0`; the `c ≠ 0` case is `Int.sign_neg` + `Int.natAbs_neg` + our own `dedekindSum_neg`, whose two sign flips cancel. |
| `rademacherPhi_T_zpow` | INDEPENDENT | Not present upstream.  **PROVED 2026-09-07, `sorry`-free.**  Mathlib's `ModularGroup.coe_T_zpow` gives the entries; the `c = 0` branch of the definition then gives `n / 1`. |
| `rademacher_phi_step` | STATEMENT-ONLY port (Apache-2.0, `anthropics/fermats-last-theorem`); **PROOF INDEPENDENT** | **Statement**: from `Theorems/Thm_rademacher_phi_step.lean` (429 bytes, Apache-2.0, fetched 2026-09-07, HTTP 200), reproduced with upstream's binder names, hypothesis order and shape; verified 2026-09-07 to be character-identical to the pre-proof text (256 chars by `python len(str)`, unchanged by this run), and equal to upstream after whitespace normalisation (242 chars both).  The upstream file carries no copyright header, so there is none to reproduce.  **Proof**: **PROVED 2026-09-07, `sorry`-free — and it is NOT a port and NOT an adaptation.**  Upstream's proof is the single tactic `p2m_exact_reverting @P2MW.S_rademacher_phi_step.solution` against a 1287-line `P2M/Sol` file; that tactic does not exist in this library, so its proof term could not be transcribed. This run's Fetch phase retrieved it, in the same batch as the other two `P2M/Sol` files listed above, to count `sorry`/`admit`/`axiom` occurrences (0/0/0); that content was not passed into the prompt of the agent that wrote the proof below.  Ours is: Bézout (`(-a)·r + (a·q-b)·c = 1`, read off `hdet` and `hrd`) for `Nat.Coprime r c` via Mathlib's `Int.isCoprime_iff_gcd_eq_one` / `Int.gcd_natCast_natCast`; then our own `dedekindSum_add_mul` and `dedekindSum_neg` (DRK-01) to rewrite `s(d,c) = -s(r,c)`; then our own `dedekindSum_add_dedekindSum` (DRK-02, itself proved by the Rademacher–Grosswald double count, not ported); then the private `phi_step_algebra`.  **Do not cite FLT for the proof.** |
| `phi_step_algebra` (private) | INDEPENDENT | The field-algebra core of `rademacher_phi_step` with both Dedekind sums eliminated.  No FLT counterpart — upstream never isolates it.  Proof is `linarith` / `subst` / `field_simp` / `ring` on Mathlib primitives. |
| the twelve `rademacher_phi_step_pin_*` and three `rademacher_phi_step_fails_*` declarations | INDEPENDENT | DRK-04 sign-discipline pins and negative controls.  Every value was recomputed in Python (`fractions.Fraction`, re-implementing `dedekindSaw`/`dedekindSum` and both sides of the identity from the mathematical definitions, **not** from this library and **not** from reciprocity) before the Lean was written, and the same sweep checked all 24 769 instances with `1 ≤ c ≤ 14`, `\|d\| ≤ 25`, `\|a\| ≤ 12`, `\|q\| ≤ 8`, `r = q·c − d > 0` with 0 counterexamples.  The Lean kernel (`decide +kernel`) then agrees on all fifteen.  Four of the twelve are the promotion to named, axiom-guarded theorems of four anonymous `example`s that were already in the `DRK-00` gate; the other eleven are new.  No FLT counterpart. |

## 3. `Lean/SocrateAI/ModularForms/EtaMultiplier.lean`

| Declaration | Kind | Note |
|---|---|---|
| `mobiusC` | INDEPENDENT | — |
| `drk05_pin_slit_*` (8), `drk05_pin_slit_pos_*` (8), `drk05_pin_defect_*` (7), `drk05_neg_control_slit_cneg`, `drk05_neg_control_plus_I` | INDEPENDENT | The DRK-05 sign gate: 25 `norm_num` pins and controls, proved from Mathlib primitives only.  Right-hand sides computed independently in `mpmath` (50 dps) and exact `fractions.Fraction` before any Lean proof existed.  No upstream counterpart. |
| `DRK05Aux.logDeriv_csqrt`, `DRK05Aux.defect_algebra`, `DRK05Aux.denom_eq`, `DRK05Aux.denom_ne`, `DRK05Aux.coe_mobiusC`, `DRK05Aux.mobiusC_mem`, `DRK05Aux.hasDerivAt_mobiusC`, `DRK05Aux.slit_mem`, `DRK05Aux.lin_ne_zero`, `DRK05Aux.csqrt_lin_ne_zero`, `DRK05Aux.hasDerivAt_lin`, `DRK05Aux.differentiableAt_csqrt_lin`, `DRK05Aux.logDeriv_csqrt_lin` | INDEPENDENT | Auxiliary lemmas for the DRK-05 proof, all written here against Mathlib.  `logDeriv_csqrt` is the `logDeriv` form of `Complex.deriv_sqrt`, which Mathlib does not carry (checked: no `logDeriv`/`sqrt` lemma anywhere in Mathlib at our pinned revision outside `Discriminant.lean`).  No FLT text was consulted for any of these. |  **Correction: `Theorems/Thm_Complex_sqrt_mul_sqrt_eq_of_re_pos.lean` (403 B, fetched, HTTP 200) is a matching-shape upstream statement, not previously listed in \S0; added there.**
| `logDeriv_eta_smul_eq_logDeriv_csqrt` | INDEPENDENT | **PROVED 2026-09-08, sorry-free.**  No FLT counterpart at all — FLT states only the closed form.  The *statement* is modelled on **Mathlib**'s `ModularForm.logDeriv_eta_comp_eq_logDeriv_csqrt_eta` (`Mathlib/NumberTheory/ModularForms/Discriminant.lean:75`), which is the `γ = S` case; ours is a strict generalisation to any `γ` with `c > 0`, and the two are equivalent at `γ = S` only modulo the constant `√(-i)` inside our radical (Mathlib uses the bare `sqrt`).  The *proof* is **not** Mathlib's `S`-case proof re-indexed: that proof leans on `ModularGroup.denom_S` and on the bare `sqrt`, and neither survives.  Written here from `logDeriv_eta_eq_E2`, `EisensteinSeries.E2_slash_action`, `riemannZeta_two`, `Complex.deriv_sqrt`, `logDeriv_comp`/`logDeriv_mul` — Mathlib primitives only.  See §4. |
| `exists_eta_smul_const` | INDEPENDENT | **PROVED 2026-09-08, sorry-free.**  Modelled on Mathlib's `eta_comp_eqOn_const_mul_csqrt_eta` (the `γ = S` case); proved from `logDeriv_eta_smul_eq_logDeriv_csqrt` plus `logDeriv_eqOn_iff` on `upperHalfPlaneSet`.  See §4.  **HONESTY (LL-1): strictly weaker than the FLT statement in the row below** — it asserts that the multiplier is *a nonzero constant*, not what the constant *is*.  FLT's theorem implies it in one line; the converse is all of DRK-06. |
| `eta_specialLinearGroup_smul_flt` | STATEMENT-ONLY port (Apache-2.0, `anthropics/fermats-last-theorem`); **PROOF INDEPENDENT (ADAPTED, NOT PORTED)** | **Statement**: from `Theorems/Thm_ModularForm_eta_specialLinearGroup_smul.lean` (1024 bytes, Apache-2.0, fetched 2026-09-07, HTTP 200), with the Dedekind sum written inline exactly as upstream writes it (`c.toNat` as the second argument, no `Φ`).  The upstream file carries no copyright header, so there is none to reproduce.  **Proof**: **PROVED 2026-09-08, `sorry`-free — NOT a port.**  Upstream's proof is the single tactic `p2m_exact_reverting @P2MW.S_ModularForm_eta_specialLinearGroup_smul.solution` against a 9054-byte `P2M/Sol` file; that tactic does not exist in this library, so its proof term could not be transcribed. This run's Fetch phase retrieved it, in the same batch as the other two `P2M/Sol` files below, to count `sorry`/`admit`/`axiom` occurrences (0/0/0); that content was not passed into the prompt of the agent that wrote the proof below.  Ours is one `rw` off `eta_smul_eq_exp_rademacherPhi` via `rademacherPhi_of_pos_toNat` (DRK-03).  **Do not cite FLT for the proof.** |
| `eta_smul_eq_exp_rademacherPhi` | **ADAPTED**: statement equivalent to upstream's; **proof INDEPENDENT** | **PROVED 2026-09-08, `sorry`-free.**  The same mathematics through our named `Φ`; not a transcription of upstream, which has no `Φ`.  The bridge to upstream's phrasing is `rademacherPhi_of_pos` + `rademacherPhi_of_pos_toNat` (DRK-03, ours).  **Proof**: strong induction on `c = γ 1 0` by Euclidean descent, written entirely against our own architecture and Mathlib.  Base `c = 1`: `γ = T^a·S·T^d` literally, then our `eta_add_int` (F3.1-B3) twice around Mathlib's `ModularForm.eta_comp_eq_csqrt_I_inv`, with `Φ(γ) = a+d` from our `rademacherPhi_of_pos` and `dedekindSum_one_right` (DRK-01).  Step `0 < r < c`: `γ = γ'·S·T^q` with `γ' = !![q·a-b, a; r, c]`, the induction hypothesis at `γ'`, our `rademacher_phi_step` (DRK-04) for `Φ(γ) = Φ(γ') + q - 3`, and the `csqrt` branch lemmas below for `√A·(√(-i)·√w) = √(-i)·√(-i(cz+d))` with `√(-i) = e^{-πi/4} = e^{πi(-3)/12}`.  This run's Fetch phase retrieved it, in the same batch as the other two `P2M/Sol` files below, to count `sorry`/`admit`/`axiom` occurrences (0/0/0); that content was not passed into the prompt of the agent that wrote the proof below. No proof step below matches or resembles upstream's proof shape (a single opaque tactic call); the induction structure, lemma names and every intermediate identity are our own.  **SCOPE (LL-1): `c > 0` only — FLT's own scope; `c = 0` and `c < 0` are not covered.**  `exists_eta_smul_const` (DRK-05) is **not** used. |
| `eta_smul_strong_induction`, `eta_smul_of_c_eq_one`, `eta_smul_descent_step` | INDEPENDENT | The three halves of the DRK-06 descent (strong induction on `(γ 1 0).toNat`; base `c = 1`; step `γ = γ'·S·T^q`).  No upstream counterpart — FLT states only the closed form and isolates none of these.  Written against Mathlib's `UpperHalfPlane.modular_S_smul` / `modular_T_zpow_smul` / `ModularGroup.coe_T_zpow` / `coe_S`, our `eta_add_int`, and `Int.emod_add_ediv_mul` for the Euclidean step. |
| `csqrt_mul_self`, `csqrt_re_nonneg`, `csqrt_re_mul_re_sub`, `csqrt_two_re_mul_im`, `abs_im_csqrt_lt_re`, `csqrt_re_pos_im_pos`, `csqrt_mul_of_re_mul_pos`, `csqrt_mul_of_re_pos`, `csqrt_neg_I_mul`, `csqrt_neg_I_eq_exp`, `csqrt_I_inv` | INDEPENDENT | The principal-branch algebra DRK-06 rests on.  `csqrt_mul_of_re_mul_pos` (`√u·√v = √(uv)` whenever `Re(√u·√v) > 0`) is the load-bearing one; Mathlib at our pinned revision has **no** multiplicativity lemma for `Complex.sqrt` (checked by name and by statement shape across `Mathlib/Analysis/RCLike/Sqrt.lean` and `Mathlib/Analysis/SpecialFunctions/Pow/`), so it is proved here from our own `csqrt_sq` (F3.2-A7) plus `Complex.cpow_inv_two_re`.  No FLT counterpart. |
| `sl2_det`, `slOf_apply`, `sl2_descent_eq`, `rademacherPhi_descent`, `coe_T_zpow_smul`, `im_pos_coe`, `eta_neg_inv`, `re_neg_I_mul_lin`, `coe_T_zpow_entry` | INDEPENDENT | Bookkeeping for the descent: the factorisation `γ = γ'·S·T^q` in `SL(2,ℤ)`, the `Φ` descent (a wrapper on our `rademacher_phi_step`), the `ℍ → ℂ` coercions, and `eta_neg_inv` (Mathlib's `eta_comp_eq_csqrt_I_inv` restated with `√(-i)` in place of `(√i)⁻¹`).  No FLT counterpart. |
| `coe_S_smul` | **Correction (this pass): a counterpart exists**, name- and statement-identical up to cosmetic parens: `Theorems/…S_ModularForm_eta_specialLinearGroup_smul.lean:46`. It is a one-line restatement of Mathlib's own `ModularGroup.S`-action definition (`S • z = -1/z`), essentially forced by that definition; independently written here, below the threshold for a port credit (the same standard applied to short coincidental statements elsewhere in this file), but the blanket "no counterpart" claim above did not extend to it and is corrected. |
| the eight `drk06_pin_descent_*`, six `drk06_pin_base_*` and two `drk06_pin_branch_im_*` declarations, and the three negative controls `drk06_neg_control_minus_two`, `drk06_neg_control_no_shift`, `drk06_neg_control_branch_sign` (with their fifteen `drk06Mat*` matrices) | INDEPENDENT | The DRK-06 sign gate.  Every `Φ` value was recomputed in Python (`fractions.Fraction`, re-implementing `dedekindSaw`/`dedekindSum`/`Φ` from the mathematical definitions, not from this library) **before** any Lean proof of this node existed; the same sweep checked the full analytic law at 8 matrices × 2 points and the branch identity `√A·√B = √(-i)·√ξ` at 6 matrices × 2 points in `cmath` (all ratios `1 ± 1e-13`).  The Lean kernel (`decide +kernel`) then agrees on all fourteen `Φ` pins.  The two branch pins and `drk06_neg_control_branch_sign` pin the sign of `√(∓i)`, i.e. that `-3` cannot be `+3`.  No FLT counterpart. |
| `etaMultiplierPhi` | INDEPENDENT | — |
| `etaMultiplierPhi_pow24` | INDEPENDENT | **`sorry`.** |
| `etaMultiplierPhi_mul_cocycle` | INDEPENDENT | **`sorry`.** |
| `ligozat_trivial_multiplier_of_twelve_dvd` (named `ligozat_general` until 2026-09-08; the name `ligozat_general` now denotes a DIFFERENT declaration, in `EtaLigozatGeneral.lean`, §10) | INDEPENDENT | Ligozat's criterion at general `N` in the *trivial-multiplier* form (congruences + `12 ∣ k` ⟹ `f(γz) = (cz+d)^k f(z)` on all of `Γ₀(N)`), phrased against *our* `etaQuotientH`/`Gamma0` architecture (run 3).  No upstream counterpart in FLT.  **REFUTED 2026-09-08, and QUARANTINED, not deleted (LL-1): the statement is FALSE.**  Witness `N = 17`, `r = (r₁, r₁₇) = (21, 3)`, `k = 12`, `γ = !![6,1;17,3] ∈ Γ₀(17)`; every hypothesis holds and the multiplier there is `-1`.  Machine-checked, `sorry`-free, by `eta01_seventeen_refutes_trivial_multiplier` (§10).  It retains its `sorry` **permanently**, with an INVERTED `FinalCheck` tripwire asserting `sorryAx` stays in its footprint, so that the refutation has a declaration to point at.  Do not attempt to prove it. |

## 4. Mathlib

The whole library is built on Mathlib (Apache-2.0), which is a dependency and not vendored; per
Mathlib's own convention that does not require per-declaration attribution.  Two places are
called out anyway because they are close enough to be worth flagging:

* `logDeriv_eta_smul_eq_logDeriv_csqrt` and `exists_eta_smul_const` (§3) are the general-`γ`
  analogues of `ModularForm.logDeriv_eta_comp_eq_logDeriv_csqrt_eta` and
  `ModularForm.eta_comp_eqOn_const_mul_csqrt_eta` in
  `Mathlib/NumberTheory/ModularForms/Discriminant.lean` (© and authors per that file's header).
  Their statements are ours; the proofs were written here and do not reproduce Mathlib's text.
* The DRK-06 base case (`eta_smul_of_c_eq_one`) and descent step (`eta_smul_descent_step`) each
  invoke Mathlib's `ModularForm.eta_comp_eq_csqrt_I_inv` (same file) once, as a cited lemma — not
  copied text.  `eta_neg_inv` (§3) is that lemma restated with `√(-i)` in place of `(√i)⁻¹`;
  the restatement and its one-line proof are ours.
* `Complex.sqrt_I` and `Complex.sqrt_neg_I` (`Mathlib/Analysis/RCLike/Sqrt.lean`, © Monica Omar,
  Apache-2.0) are cited by `csqrt_neg_I_eq_exp`, `csqrt_I_inv` and the two branch pins.  Cited,
  not copied.
* Nothing else in the run-4 files reproduces Mathlib text.

## 5. `Lean/SocrateAI/ModularForms/EtaMultiplierNeg.lean`  (DRK-08)

**Every declaration in this file is INDEPENDENT.  No port entry is owed for any of them.**

The comparator verdict on DRK-08 was **NO_REFERENCE**, not MATCH, and that is reproduced here
rather than upgraded.  The full FLT tree was enumerated (`api.github.com/repos/anthropics/
fermats-last-theorem/git/trees/main?recursive=1`, 45999 paths) and filtered on
`ModularForm_eta|_eta_|etaMult|rademacher|dedekindSum`; nothing in `Theorems/` or `Definitions/`
has the shape of either DRK-08 declaration.  FLT's own general-`Γ₀(N)` eta-quotient result
(`ModularForm.etaProductEleven_transform`, `γ ∈ Gamma0 11`, weight `2`) reaches all of `Γ₀(11)`
through `Δ`, the twelfth power, continuity/connectedness to force a twelfth root of unity, and
coset enumeration — it performs **no** `c`-sign reduction at all (its 39366-byte solution has zero
hits for `lt_trichotomy|Int.sign|natAbs|lt_or_gt`).  **No FLT text was read or used while writing
this file**, and none is cited by it.

| Declaration | Kind | Note |
|---|---|---|
| `drk08Mat`, `drk08Mat_coe`, `SL2_neg_entry`, `drk08MatCneg4`, `drk08MatC5`, `drk08MatT5`, `drk08MatNegT3` | INDEPENDENT | Local pin scaffolding.  `drk08Mat` is a deliberate local copy of our own `SocrateAI.NumberTheory.slOf` and `SL2_neg_entry` of our own `SL2_neg_apply`: importing `RademacherPhi.lean` would put a false edge into this file's dependency graph, and the import list is the receipt that DRK-08 uses no Dedekind sum, no `Φ` and no analysis.  `drk08MatCneg4` is the same matrix as `pinMatCneg4`. |
| the thirteen `drk08_pin_*` declarations | INDEPENDENT | The DRK-08 sign gate, placed before both proofs.  Every value was computed independently in python3 (integer matrix arithmetic, `T^n = !![1,n;0,1]` and `-γ` re-implemented from the definitions, not from this library) before the Lean statements were written.  `drk08_pin_T5_eq` and `drk08_pin_negT3_eq` are proved from Mathlib's `coe_T_zpow`/`coe_neg` alone, so they are independent of the two run-3 base-case lemmas that part 2 uses for the same step. |
| `drk08_neg_control_negT3_wrong_sign`, `drk08_neg_control_even_k_blind`, `drk08_neg_control_cneg4_not_T_zpow`, `drk08_neg_control_T5_not_pos_lower_left`, `drk08_neg_control_neg_S_ne_S` | INDEPENDENT | Five negative controls: the `c = 0` negative branch really has `n = -(γ 0 1)`; `(-1)^2 = 1` (even `k` is blind, so the guard must be at odd `k`); the `T^n` disjunct is FALSE at `c = -4`; the `0 < c'` disjunct is FALSE at `c = 0`; and `w(-S) = i ≠ -i = w(S)` at `k = 1`, `f = η²`. |
| `T_zpow_lower_left`, `neg_T_zpow_lower_left` | INDEPENDENT | `c(±T^n) = 0`, matrix-level, from Mathlib's `ModularGroup.coe_T_zpow`.  No upstream counterpart. |
| `exists_pos_lower_left_or_T_zpow` | INDEPENDENT | **PROVED 2026-09-08, `sorry`-free.**  No FLT counterpart (see above).  Built from our run-3 `sl_det_entries`, `eq_T_zpow_of_lower_left_zero`, `eq_neg_T_zpow_of_lower_left_zero`, `neg_one_mem_Gamma0` plus `Int.eq_one_or_neg_one_of_mul_eq_one'`.  **LL-25 note:** Mathlib's `ModularGroup.exists_eq_T_zpow_of_c_eq_zero` (`NumberTheory/Modular.lean:328`) is *not* used and must not be substituted — its conclusion is at the level of the Möbius action (`∃ n, ∀ z, g • z = T^n • z`), i.e. `PSL`, and the matrix-level facts live only inside its proof as `suffices` steps.  Using it would silently weaken this statement and destroy the `±` distinction that `etaMultiplierVal_neg` exists to record. |
| `etaMultiplierVal_neg` | INDEPENDENT | **PROVED 2026-09-08, `sorry`-free.**  `w(-γ) = (-1)^k·w(γ)`.  Two lines, from our run-3 `etaMultiplierVal_mul` (F3.2-A5) and `etaMultiplierVal_neg_one` (F3.2-A9).  No FLT counterpart.  **SCOPE (LL-1): this does NOT extend DRK-06 to `c ≤ 0`** — the single-`η` closed form is false for `c < 0` by a factor of `i` (checked numerically, 400-term `η` product in python3 `cmath`, at `γ = -S`, `z = 0.3+1.1i`); the defect collapses to `i^{2k} = (-1)^k` only after the product over divisors, which is why the statement is at the eta-QUOTIENT level. |
| `etaMultiplierVal_neg_eta_sq`, `etaMultiplierVal_eta_sq_neg_S` | INDEPENDENT | The odd-`k` guard (`N = 1`, `r ≡ 2`, `f = η²`, `k = 1`), on top of run 3's `etaMultiplierVal_eta_sq_S`.  No upstream counterpart. |

The three items the DRK-08 brief listed under `built_from` but which this file does **not** use —
`rademacherPhi_neg`, `Complex.mem_slitPlane_iff`, and `etaMultiplierVal_T_eq_one` — are recorded
as unused in the file header and in the DAG node, so that no citation is claimed for them.

## 7. `Lean/SocrateAI/ModularForms/EtaPhiSum.lean`  (DRK-09)

**Verdict for the whole file: INDEPENDENTLY RE-DERIVED, NOT A PORT.  No FLT text, tactic or
proof strategy is used, and no FLT solution file was read while writing it.  No port entry is
owed for any declaration below.**

**But the DRK-09 node's own metadata said "No FLT counterpart", and that sentence is FALSE.
It is retracted here.**  Fetched 2026-09-08, HTTP 200:

| upstream path | size | what it contains |
| --- | --- | --- |
| `P2M/Sol/S_ModularCurve_sharpUnitInvariant.lean` | 9342 B | `namespace DedekindEtaLaw`, `def phi (γ : SL(2,ℤ)) : ℚ := ((γ 0 0 + γ 1 1 : ℤ):ℚ) / (((γ 1 0 : ℤ).toNat : ℕ):ℚ) - 12 * dedekindSum (γ 1 1) (γ 1 0 : ℤ).toNat` (line 22), and at lines 163-165 `phi γ` / `phi γ'` for `γ' = γ_ℓ` with `C' = c/ℓ`.  `phi γ − phi γ'` **is** `etaPhiSum` in the two-divisor case `N = ℓ` prime, `r = (m, −m)`, weight `k = 0`. |
| `Theorems/Thm_rademacher_phi_level_congruence.lean` | 551 B | the prime-level, two-divisor form of the arithmetic `24 ∣ Φ_N(r,γ)` that DRK-09 does **not** attempt.  Statement fetched and read; the proof is `p2m_exact_reverting`, which does not exist in this library. |
| `Theorems/Thm_ModularForm_eta_specialLinearGroup_smul.lean` | (see §0) | already recorded: the DRK-06 statement, which `EtaPhiSum.lean` uses through **our** `eta_smul_eq_exp_rademacherPhi` (§3, ADAPTED: statement from FLT, proof independent). |

`ATTRIBUTION.md` §6 already warned that the "no FLT counterpart" claims rested on a name filter
(`ModularForm_eta|_eta_|etaMult|rademacher|dedekindSum`) that `sharpUnit`, `etaProductEleven` and
`EtaQuotient` do not match.  This is that caveat coming true, and it is recorded rather than
quietly dropped.

**Why DRK-09 is nonetheless a generalisation, not a restatement.**  Upstream is `N = ℓ` prime
(two divisors), `r = (m, −m)`, weight `0`.  DRK-09 is arbitrary `N`, arbitrary `r : EtaExp`,
arbitrary integer weight `k`.  At weight `0` the `√` factors cancel in a ratio — the upstream
proof does exactly that, `rw [← Complex.exp_sub, ...]` at line 176 — so FLT never performs the
`(√(-i(cz+d)))^{Σ r_δ} = (√·)^{2k} = (-i)^k (cz+d)^k` collection, which is DRK-09's real new
content and the reason the hypothesis `hk : Σ r_δ = 2k` exists.

| declaration | status | note |
| --- | --- | --- |
| `etaPhiSum` | INDEPENDENT | Written as a plain `def`, not the `noncomputable def` the node text used, so that the fifteen kernel pins below are possible.  Structurally the same rational function upstream's `DedekindEtaLaw.phi` computes at one divisor, but written over the common denominator `c` (hence the explicit `δ` in `(a+d)·δ/c`) and summed over all of `N.divisors`.  Derived from our own `rademacherPhi` (§2) and `dedekindSum` (§1, which IS a port), not transcribed. |
| the fifteen `drk09_pin_*` | INDEPENDENT | Sign-discipline gate.  Every value computed first in python3 (`fractions.Fraction`; `((x))` and `s(h,k)` re-implemented from the mathematical definition and checked against all nine `decide +kernel` pins of `DedekindSum.lean` before being trusted), then `decide +kernel` in Lean.  Eleven were additionally checked against a 4000-term `η`-product evaluation of `w(γ) = f(γi)/((ci+d)^k f(i))`; worst relative error 3.3e-14. |
| `etaPhiSumSignFlip`, `etaPhiSumNoDelta`, `etaPhiSumWrongModulus` and the four `drk09_neg_control_*` | INDEPENDENT | Three one-character mutants (`+12·s`; `(a+d)/c` without `δ`; `s(d,c)` instead of `s(d,c/δ)`), each rejected numerically with relative error of order 1, each separated from `etaPhiSum` in the kernel at two independent instances. |
| `etaPhiSum_eq_unconditional`, `etaPhiSum_eq` | INDEPENDENT | `Finset.mul_sum` + `Finset.sum_sub_distrib` + `ring`.  The node carried `hγ` and `hc` on this lemma; both are unused and the unconditional form is proved first (LL-1: a STRENGTHENING, recorded in the file header). |
| `rademacherPhi_divisorConj` | INDEPENDENT | `Φ(γ_δ) = (a+d)·δ/c − 12·s(d, c/δ)`.  Built from run 3's `divisorConj` / `divisorConj_*` (F3.2-A3) and our `rademacherPhi_of_pos` (§2, DRK-03).  Upstream's `e0`/`e1` at `sharpUnitInvariant` lines 163-165 do the corresponding step for one prime `ℓ` by `unfold phi; rw [hcNat]`; that text was read only **after** this lemma was written and proved, and none of it is used. |
| `eta_natScale_smul_eq` | INDEPENDENT | DRK-06 transported to `η(δ·(γz))` through run 3's `divisor_smul_comm_explicit` and `coe_natScale_smul`.  Upstream has no counterpart: `DedekindEtaLaw.law` is DRK-06 verbatim at `δ = 1`. |
| `etaQuotientH_smul_eq_exp_etaPhiSum`, `etaMultiplierVal_eq_exp_etaPhiSum` | INDEPENDENT | The two main theorems.  `Complex.exp_int_mul` + `Complex.exp_sum` for the exponentials, run 3's `prod_zpow_const` + `csqrt_zpow_two_mul` (F3.2-A7) for the square roots, `mul_zpow` for the split `(-i·D)^k = (-i)^k D^k`.  **No upstream counterpart at any weight ≠ 0** (see above). |
| `etaPhiSum_of_lower_left_zero`, `etaMultiplierVal_c_zero_formula_fails` | INDEPENDENT | The `c = 0` negative control: at `N = 1`, `r ≡ 2`, `k = 1`, `γ = T` the truth is `w(T) = e^{πi/6}` (run 3's `etaQuotientH_T_smul` + `denom_T`) and the formula would give `-i`.  Proves the `hc` hypothesis is not removable.  No upstream counterpart — FLT's `law` also assumes `0 < c`. |
| `rademacherPhi_eq_intCast_of_pos`, `rademacherPhi_eq_intCast`, `etaMultiplierPhi_pow24_of_intCast` | INDEPENDENT | `Φ(γ) ∈ ℤ`, obtained by comparing DRK-09 at `(N,r,k) = (1,24,12)` with run 3's `etaMultiplierVal_level_one_24` (the multiplier of `Δ` is `1`, proved from `CuspForm.discriminant` with no Dedekind sums).  This is the explicitly-named missing ingredient of DRK-07.a; `EtaMultiplier.lean`'s `sorry` there is deliberately left in place, so its inverted `FinalCheck` tripwire is now **stale**, not wrong. |

## 8. `Lean/SocrateAI/NumberTheory/DedekindSumJacobi.lean` + `Lean/SocrateAI/ModularForms/KroneckerJacobi.lean`  (DRK-10)

**Verdict: exactly ONE declaration in these two files is upstream material, and it is a
STATEMENT-ONLY port.  Everything else is INDEPENDENT.**

Upstream: `anthropics/fermats-last-theorem`,
`Theorems/Thm_dedekindSum_jacobiSym_mod_eight.lean` (Apache-2.0; no upstream copyright header,
see §0).  Fetched 2026-09-08, HTTP 200, 449 bytes.  The upstream file reads, in full body:

```
theorem dedekindSum_jacobiSym_mod_eight (h k : ℕ) (hk : Odd k) (hhk : Nat.Coprime h k) :
    ∃ t : ℤ, 12 * (k : ℚ) * dedekindSum h k
      = (k : ℚ) + 1 - 2 * ((jacobiSym h k : ℤ) : ℚ) + 8 * t := by
  p2m_exact_reverting @_root_.P2MW.S_dedekindSum_jacobiSym_mod_eight.solution
```

| declaration | kind | extent / note |
| --- | --- | --- |
| `SocrateAI.NumberTheory.dedekindSum_jacobiSym_mod_eight` | **STATEMENT-ONLY** | The *statement* is upstream's, reproduced character for character after whitespace normalisation (both are 182 characters normalised).  The *proof* is not and cannot be upstream's: upstream's is `p2m_exact_reverting @_root_.P2MW.S_dedekindSum_jacobiSym_mod_eight.solution`, and neither that tactic nor that solution file exists in this library.  Our proof is strong induction on the odd modulus, using our own `dedekindSum_add_dedekindSum` (§1/DRK-02, itself a statement-only port with an independent proof) and Mathlib's `jacobiSym.quadratic_reciprocity`.  The solution file was **not** fetched and **not** read. |
| `SocrateAI.NumberTheory.exists_intCast_eq_twelve_mul_dedekindSum` | INDEPENDENT (proof); statement coincides with an unexported upstream lemma | **Correction (this pass): §8's original "nearest neighbour" claim was wrong.** The true nearest neighbour is not the public `Theorems/Thm_exists_intCast_eq_six_mul_dedekindSum.lean` file but an *internal, unexported* lemma of the *same name and statement* inside `P2M/Sol/S_dedekindSum_add_dedekindSum.lean:494` (`theorem exists_intCast_eq_twelve_mul_dedekindSum (d : ℤ) (c : ℕ) (hc : 0 < c) : ∃ t : ℤ, (t : ℚ) = 12 * c * dedekindSum d c`), not part of upstream's public `Theorems/` API and not discoverable by the `Theorems/`-only search this run used. The statement is a one-line existential fact essentially dictated by the mathematics (12 divides a specific integer combination); we judge it below the threshold for a port attribution (same standard §7 applies to short coincidental statements), but record the coincidence rather than the wrong "different statement" claim. Our proof is independent: `12k·s = 12(∑ r·m_r)/k − 6∑ r·ε_r − 6∑ m_r + 3k∑ ε_r` with `ε_r = min (hr mod k) 1`, plus `k ∣ 6∑ r·m_r` from `m_r ≡ hr (mod k)` and `6∑_{r<k} r² = (k−1)k(2k−1)`, built on our own `dedekindSum_eq_sum_Ico` and `dedekindSaw_natCast_div`; we have not compared it step-by-step against upstream's internal proof of the same lemma. |
| `modAux`, `epsAux`, `saw_mul_div`, `six_sum_sq`, `modSum_split`, `dvd_six_modSum` | INDEPENDENT | Private scaffolding for the integrality lemma.  `saw_mul_div` and `modSum_split` overlap in content with the `private` lemmas `dedekindSum_eq_modSum` / `sum_expand` of `DedekindSum.lean`; those are **ours** (§1 lists them as ours, not as ports), and they were re-derived here rather than made public in order not to force a rebuild of the whole modular-forms tower.  `modAux`/`epsAux` exist only to stop `push_cast` from rewriting `ℕ`-`%` into `ℤ`-`%` asymmetrically. |
| `descent_mod_eight`, `reflect_mod_eight` | INDEPENDENT | The two pure-integer mod-8 case checks (four cases each).  All eight witnesses were verified in `sympy` (residual `0` in every case) before being written into Lean.  No upstream counterpart is known and none is claimed. |
| `mod_eight_aux` | INDEPENDENT | The induction itself. |
| the twelve `drk10_pin_*` | INDEPENDENT | Sign-discipline gate.  Every `s(h,k)` is a `decide +kernel` evaluation of the definition; every Jacobi symbol is `norm_num`'s quadratic-reciprocity evaluation; every witness `t` was computed first in python3 (`fractions.Fraction`, sawtooth and `s(h,k)` re-implemented from the mathematical definition and checked against all eleven existing `decide +kernel` pins of `DedekindSum.lean`).  The same Python sweep checked the statement at **3889** pairs (`k` odd `< 80`, `h < 120`, `gcd = 1`): zero violations. |
| `drk10_fails_k_even_one_two`, `drk10_fails_k_even_five_six`, `drk10_fails_gcd_three_nine`, `drk10_fails_gcd_five_fifteen` | INDEPENDENT | Four negative controls: two show `Odd k` is load-bearing, two show `Nat.Coprime h k` is. |
| `drk10_general_matches_pin_seven_eleven` | INDEPENDENT | Consistency tripwire: instantiates the **general** theorem at `(7,11)` and proves its witness is the independently computed `t = −4`. |
| everything in `KroneckerJacobi.lean` | INDEPENDENT | FLT uses Mathlib's `jacobiSym` throughout and defines **no** Kronecker symbol, so there is no upstream counterpart to port.  `kroneckerSym_eq_jacobiSym_of_odd'` is proved by unfolding run 3's own `kroneckerSym`/`kroneckerPrime` (F3.2-B3) against Mathlib's `jacobiSym`, via `List.pmap_eq_map` + `List.pmap_congr_left`.  `kroneckerSym_eq_jacobiSym_of_odd` is the DRK-10 node's binder list verbatim, including the redundant `0 < b`; `pos_of_odd_nat` proves that redundancy.  The two `kronecker_ne_jacobi_at_two_*` controls are kernel witnesses of the `χ₈`-versus-`legendreSym 2` disagreement that motivated run 3's definition. |

## 9. `Lean/SocrateAI/ModularForms/EtaLigozatKronecker.lean`  (DRK-11)

**Every declaration in this file is INDEPENDENT — re-derived, NOT ported.**  There is nothing
upstream to port: the theorem does not exist in `anthropics/fermats-last-theorem` or in Mathlib
at our pinned revision.  No FLT text, tactic or proof strategy was used, and no FLT solution file
was read while writing it.

### Receipts for "nothing upstream to port" (commands run 2026-09-08, outputs read)

* `GET https://api.github.com/repos/anthropics/fermats-last-theorem/git/trees/main?recursive=1`
  → HTTP 200, 17 425 739 B, 45 950 tree entries (`"truncated": true` — see §6).  Path-substring
  counts over those 45 950 paths: `ligozat` **0**, `Ligozat` **0**, `kroneckerSym` **0**,
  `KroneckerSym` **0**, `etaQuotient` **0**.  Case-insensitive `ronecker`: **34** paths, all of
  them Kronecker's congruence for modular polynomials
  (`S_ModularCurve_kroneckerCongruence*`, `*kroneckerRemainder*`,
  `Def_ModularCurve_KroneckerTransport.lean`) or `Matrix.kroneckerMap`
  (`S_Matrix_*_kroneckerMap_*`).  **None is the Kronecker symbol.**
* `grep -ri` over the whole pinned Mathlib tree
  (`.lake/packages/mathlib/Mathlib`, rev `905b95818e`): `ligozat` **0**, `Ligozat` **0**,
  `kroneckerSym` **0**, `etaQuotient` **0**, `dedekindSum` **0**, `dedekindSaw` **0**,
  `etaMultiplier` **0**.  `rademacher` **9**, every one of them Rademacher's *differentiability*
  theorem (`Analysis/Calculus/Rademacher.lean`, `Analysis/BoundedVariation.lean`) — unrelated.

### The one overlap, named rather than hidden (LL-25)

`"no counterpart in any form"` would be **too strong by one instance** and is not claimed here.
`Theorems/Thm_ModularForm_etaProductEleven_transform.lean` (fetched 2026-09-08, HTTP 200, 936 B)
states

```
theorem ModularForm.etaProductEleven_transform {γ : Matrix.SpecialLinearGroup (Fin 2) ℤ}
    (hγ : γ ∈ CongruenceSubgroup.Gamma0 11) (τ : UpperHalfPlane) :
    ModularForm.eta ((γ • τ : UpperHalfPlane) : ℂ) ^ 2 *
        ModularForm.eta (11 * ((γ • τ : UpperHalfPlane) : ℂ)) ^ 2 =
      UpperHalfPlane.denom (γ : Matrix.GeneralLinearGroup (Fin 2) ℝ) (τ : ℂ) ^ (2 : ℤ) *
        (ModularForm.eta (τ : ℂ) ^ 2 * ModularForm.eta (11 * (τ : ℂ)) ^ 2) := by
  p2m_exact_reverting @_root_.P2MW.S_ModularForm_etaProductEleven_transform.solution
```

which is the `N = 11`, `r = (2,2)`, `k = 2` case of Ligozat's criterion with **trivial**
character (numerator `121 = 11²`, so the symbol is `1` by `kroneckerSym_sq_of_gcd`) — and FLT
proves it on **all** of `Γ₀(11)`, with no `c > 0` restriction, which DRK-11 does not.  DRK-11 is
a generalisation in `N`, in `r` (negative exponents allowed), in `k` (any integer, including
negative and zero) and in the character (nontrivial allowed), and a restriction in domain
(`c > 0` only).  `drk11_pin_N11_even_d` is our own kernel evaluation at that `(N, r, k)`.

**UPDATE 2026-09-08 (DRK-12).**  That FLT statement is now PROVED in this repository, `sorry`-free
and by an independent route, as `ModularForm.etaProductEleven_transform`
(`EtaLigozatLevelEleven.lean`) — including the whole of `Γ₀(11)`, with no `c > 0` restriction.
See §11.  DRK-11 itself is unchanged and still open.

### Per-declaration

| declaration | kind | extent / note |
| --- | --- | --- |
| `neg_I_eq_exp_pi_div_twelve`, `neg_I_zpow_eq_exp`, `drk11_lhs_eq`, `exp_pi_div_twelve_eq_one_iff`, `exp_pi_div_twelve_eq_neg_one_iff`, `drk11_eq_one_of`, `drk11_eq_neg_one_of`, `drk11_ne_one_of`, `drk11_iff_congr` | INDEPENDENT | The exponential layer.  Built directly on Mathlib's `Complex.exp_neg_pi_div_two_mul_I`, `Complex.exp_int_mul`, `Complex.exp_eq_one_iff`, `Complex.exp_add_pi_mul_I`.  Its content is the reduction of DRK-11 to a congruence mod 24; no upstream counterpart is known and none is claimed. |
| `kroneckerSym_one_right`, `kroneckerSym_neg_one_right_of_neg`, `kroneckerSym_neg_one_right_of_pos`, `kroneckerSym_neg_three_two`, `kroneckerSym_neg_three_neg_two` | INDEPENDENT | Five unfolding lemmas for run 3's own `kroneckerSym`/`kroneckerPrime` at `d = 1, −1, 2, −2`.  The `χ₈` evaluations follow the same `pfl_two` + `kroneckerPrime` + `decide` shape as `KroneckerJacobi.lean`'s two negative controls (§8), which are also ours. |
| the eleven `drk11_pin_*` | INDEPENDENT | Sign-discipline gate.  Every `Φ` is a `decide +kernel` evaluation of `etaPhiSum`; every symbol value is reduced to `kroneckerSym_one_left` / `kroneckerSym_one_right` / `kroneckerSym_sq_of_gcd` / `kroneckerSym_eq_jacobiSym_of_odd'` + `norm_num`, or to the `χ₈` branch.  Every value was computed FIRST in python3 (`fractions.Fraction`; `Int.fract`, `dedekindSaw`, `dedekindSum`, `etaPhiSum`, `kroneckerPrime`, `kroneckerSym` and `ligozatKroneckerNum` re-implemented from the Lean SOURCE), and that re-implementation was validated by reproducing **all** existing `decide +kernel` pins of `DedekindSum.lean` (`s(1,5)`, `s(−3,7)`, `s(4,12)`, `s(7,11)`, `s(9,25)`, `s(25,9)`) and of `EtaPhiSum.lean` (`N = 2,4,5,7,9,11,13`) exactly.  The same sweep checked the node's statement at several hundred `γ ∈ Γ₀(N)` with `c > 0` for `N ∈ {1,2,3,4,5,6,7,11}`: zero mismatches. |
| `drk11_neg_control_congr_needed`, `drk11_neg_control_congr_needed_twelve` | INDEPENDENT | Ligozat's congruences are load-bearing: `N = 8`, `r = (4,4,4,−4)` (`Σ δ r_δ = −4`, `Σ (8/δ) r_δ = 52`) and `N = 12`, `r ≡ 2` (both sums `56`).  In each case `Φ − 6k ≢ 0, 12 (mod 24)` while the symbol is `1`. |
| `drk11_neg_control_c_zero` | INDEPENDENT | `hc : 0 < c` is load-bearing: at `γ = T ∈ Γ₀(3)` with `r = (−3,9)`, `k = 3` (all of `hk`, `h1`, `h2` satisfied) the left side is `(−i)³ = i` and the symbol is `1`.  This is why DRK-11 does **not** discharge `ETA-01`. |
| `drk11_neg_control_drop_sign` | INDEPENDENT | The `(−1)^k` factor of `ligozatKroneckerNum` is load-bearing: at `d = −1` the true symbol is `−1`, the sign-free mutant `∏ δ^{|r_δ|} = 19683` gives `+1`. |
| `exp_etaPhiSum_eq_kroneckerSym_of_le_four` | INDEPENDENT (composition of two of our own results) | The node's conclusion for `0 < N ≤ 4`.  It is DRK-09's `etaMultiplierVal_eq_exp_etaPhiSum` composed with run 3's F3.2-B3 `multiplier_eq_kronecker_of_le_four` through `coe_etaMultiplierHom`.  Both inputs are ours; nothing upstream is involved. |
| `drk11_general_matches_pin_N3_odd_k`, `drk11_general_matches_pin_N3_even_d` | INDEPENDENT | Consistency tripwires: run the general (`N ≤ 4`) theorem at two of the gate's own instances and prove it produces the values computed outside Lean. |
| `exp_etaPhiSum_eq_kroneckerSym` | INDEPENDENT **statement**, **UNPROVED** | The node for general `N`.  Carries a `sorry` with an `-- OPEN:` comment naming the two missing inputs (an even-modulus companion to DRK-10, and the divisor-by-divisor quadratic-reciprocity assembly).  `FinalCheck.lean` §`Drk11` holds an INVERTED tripwire certifying that it still depends on `sorryAx`. |

## 10. `Lean/SocrateAI/ModularForms/EtaLigozatGeneral.lean` — ETA-01 (Ligozat at general `N`, Kronecker-character form)

**Provenance: INDEPENDENT, every declaration.**  Nothing in this file is ported; no FLT text,
tactic or proof strategy was used, and no FLT `P2M/Sol` file was read for it.

Receipts, taken 2026-09-08 for this file (not inherited from an earlier section):

* FLT recursive tree (`GET /repos/anthropics/fermats-last-theorem/git/trees/main?recursive=1`,
  HTTP 200, 17 425 739 B, 45 950 paths, `"truncated": true`): `ligozat` 0, `Ligozat` 0,
  `kroneckerSym` 0, `KroneckerSym` 0, `etaMultiplier` 0, `trivial_multiplier` 0.
* `etaQuotient` matches **one** path, and it was fetched and read rather than assumed:
  `Definitions/Def_ModularCurve_EtaQuotient.lean` (HTTP 200, 4530 B, no copyright header).  It
  defines `sharpUnitFun ℓ τ = (η(τ)/η(ℓτ))^{24/gcd(ℓ-1,12)}` and the *proposition*
  `SharpUnitInvariant`, i.e. Γ₀(ℓ)-invariance of a **weight-zero, prime-level, two-divisor** eta
  quotient with a **trivial** character.  That is the `N = ℓ` prime, `r = (e, -e)`, `k = 0` case
  of `ligozat_general` — and its character is trivial for a reason our file makes explicit:
  FLT's own `two_dvd_sharpExp` says `2 ∣ e`, so Ligozat's numerator `(-1)^0 · 1^e · ℓ^e = ℓ^e`
  is a perfect square and the Kronecker symbol is `1`.  General `N`, general `r`, general integer
  weight and a **nontrivial** character appear nowhere upstream.
* Pinned Mathlib (`905b95818e`), whole-library `grep -ril`: `ligozat` 0 files, `kroneckerSym` 0,
  `etaQuotient` 0, `dedekindSum` 0, `etaMultiplier` 0, `Kronecker symbol` 0.

| Declaration | Kind | Note |
| --- | --- | --- |
| `eta01R17`, `eta01MatN17`, `eta01MatN3negA`, `eta01MatN3negB`, and the sixteen `eta01_pin_*` | INDEPENDENT | Sign-discipline gate.  Every value was computed FIRST in python3 (`fractions.Fraction`; `Int.fract`, `dedekindSaw`, `dedekindSum`, `etaPhiSum`, `kroneckerPrime`, `kroneckerSym`, `ligozatKroneckerNum` re-implemented from the Lean SOURCE and validated against every existing `decide +kernel` pin of `DedekindSum.lean`, `EtaPhiSum.lean` and `EtaLigozatKronecker.lean`).  The `(4913 / 3)` value goes through Mathlib's `jacobiSym` via our own `kroneckerSym_eq_jacobiSym_of_odd'` (§8). |
| `eta01_neg_control_sign_law_needs_numerator_sign`, `eta01_neg_control_sign_law_not_always_flip` | INDEPENDENT | Two mutant sign laws, each false at an explicit pin. |
| `kroneckerSym_neg_right_of_nonneg`, `kroneckerSym_neg_right_of_neg` | INDEPENDENT | Unfolding lemmas for run 3's own `kroneckerSym`, in the same style as the five in §9.  Mathlib has no Kronecker symbol at all, so there is nothing upstream to port. |
| `ligozat_prod_pos`, `ligozatKroneckerNum_pos_of_even`, `ligozatKroneckerNum_neg_of_odd`, `kroneckerSym_ligozat_neg_right` | INDEPENDENT | The sign of Ligozat's numerator is the parity of `k`; built on `Finset.prod_pos`, `Int.natAbs_even`/`Int.natAbs_odd`, `Even.neg_one_zpow`/`Odd.neg_one_zpow`.  `ligozatKroneckerNum` is run 3's definition. |
| `T_zpow_lower_right`, `neg_T_zpow_lower_right`, `T_zpow_mem_Gamma0`, `etaMultiplierVal_T_zpow`, `etaMultiplierVal_eq_kroneckerSym_T_zpow`, `etaMultiplierVal_eq_kroneckerSym_neg_T_zpow` | INDEPENDENT | The `c = 0` stratum.  Built on Mathlib's `ModularGroup.coe_T_zpow` and on run 3's `etaMultiplierHom_T_eq_one` (F3.2-A6) plus DRK-08's `etaMultiplierVal_neg`.  All inputs are ours or Mathlib's. |
| `even_of_lower_right_zero` | INDEPENDENT | `γ ∈ Γ₀(N)`, `γ₁₁ = 0`, `0 < N` ⇒ `N = 1` ⇒ (by Ligozat (i)) `12 ∣ k`.  From `sl_det_entries` and `Nat.divisors_one`. |
| **`etaMultiplierVal_eq_kroneckerSym_of_pos`** | INDEPENDENT | **The file's main new theorem**: the `c > 0` slice of ETA-01 implies ETA-01 on all of `Γ₀(N)`.  Assembled from DRK-08 (`exists_pos_lower_left_or_T_zpow`, `etaMultiplierVal_neg`) and the two blocks above.  DRK-09 and DRK-11 both list these `c ≤ 0` cases as missing; this discharges them. |
| `etaMultiplierVal_eq_kroneckerSym_of_le_four`, `eta01_reduction_matches_le_four`, `etaQuotientH_slash_of_kronecker`, `etaQuotientModularFormOfLeFour` | INDEPENDENT (composition of our own results) | ETA-01 in full for `0 < N ≤ 4`, ending in a genuine `ModularForm (Γ₀ N) k` term.  Uses run 3's `multiplier_eq_kronecker_of_le_four` (F3.2-B3), `mdiff_etaQuotientH`, `isBoundedAt_of_bdd_SL2Z` and `ligozat_kronecker_transform_of_le_four`, all ours. |
| `eta01_seventeen_kronecker_value`, `eta01_seventeen_hchi_fails`, **`eta01_seventeen_refutes_trivial_multiplier`** | INDEPENDENT | The `N = 17`, `r = (21,3)`, `k = 12` refutation of `ligozat_trivial_multiplier_of_twelve_dvd` (`EtaMultiplier.lean`, formerly `ligozat_general`).  `sorry`-free, and it uses neither of the two statements it separates. |
| `etaMultiplierVal_eq_kroneckerSym`, `ligozat_general`, `ligozat_kronecker_transform`, `etaQuotientModularFormGeneral` | INDEPENDENT **statements**, **UNPROVED** | ETA-01 at general `N`.  No `sorry` occurs in this file's source; all four inherit `sorryAx` from exactly one declaration, DRK-11's `exp_etaPhiSum_eq_kroneckerSym` (§9).  `FinalCheck.lean` §`Eta01` holds four INVERTED tripwires certifying it. |

## 11. `Lean/SocrateAI/ModularForms/EtaLigozatLevelEleven.lean` — DRK-12 (Ligozat at level 11)

**Provenance: INDEPENDENT, every declaration.  Nothing in this file is ported or adapted.**
No FLT proof text or tactic was used. **Correction (this pass): the solution file WAS
fetched** — `P2M/Sol/S_ModularForm_etaProductEleven_transform.lean` (39366 bytes) is grepped
for `lt_trichotomy|Int.sign|natAbs|lt_or_gt` in \S5 below, as negative evidence that upstream's
proof performs no `c`-sign case split (ours does). The grep is used to characterise upstream's
proof *shape*, not to source any proof text; the `Theorems/` statement remains the sole
comparator target and the sole thing our proof was checked against.

### The statement overlap, named rather than hidden (LL-25)

`ModularForm.etaProductEleven_transform` is FLT's theorem of the same name, **character for
character** after notation normalisation only.  Receipt (python3, LL-17): with all whitespace
collapsed, FLT's statement is **414** characters and ours is **304**; applying exactly six
notation substitutions to FLT's text —
`Matrix.SpecialLinearGroup (Fin 2) ℤ` → `SL(2, ℤ)`,
`CongruenceSubgroup.Gamma0` → `Gamma0`,
`UpperHalfPlane.denom` → `denom`,
`(γ : Matrix.GeneralLinearGroup (Fin 2) ℝ)` → `((γ : SL(2, ℤ)) : GL (Fin 2) ℝ)`,
`: UpperHalfPlane)` → `: ℍ)`,
`(τ : UpperHalfPlane)` → `(τ : ℍ)` —
brings it to **304** characters and the two strings compare `==` **True**.  The quantifier shape
(`{γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 11) (τ : ℍ)`) is FLT's, adopted deliberately so that the
comparison is exact rather than "up to bundling".

Upstream file: `Theorems/Thm_ModularForm_etaProductEleven_transform.lean`, fetched 2026-09-08,
HTTP 200, 936 B, Apache-2.0, `anthropics/fermats-last-theorem`.  **This is a statement overlap,
not a port**: FLT discharges the theorem with
`p2m_exact_reverting @_root_.P2MW.S_ModularForm_etaProductEleven_transform.solution`, a tactic
tied to its own solution infrastructure which does not exist in this repository.  Our proof is
`Gamma0_eq_of_schreier` (run 3, ours) + `etaMultiplierVal_eq_exp_etaPhiSum` (DRK-09, ours) +
ten `decide +kernel` evaluations of our own `etaPhiSum`.

### What FLT has here that we do NOT reproduce (LL-1)

`Theorems/Thm_CuspForm_exists_gamma0_eleven_apply_eq_eta_sq_mul_eta_sq.lean` (fetched
2026-09-08, HTTP 200, 724 B) asserts `∃ f : CuspForm (Γ₀ 11) 2, ∀ τ, f τ = η(τ)²η(11τ)²` —
slash-invariance **and** holomorphy **and vanishing at every cusp**.  We deliver the first
conjunct only (`etaQuotientH_eleven_slash`).  Vanishing at the cusps is `F3.1-OBSTRUCTED`;
`etaQuotientModularFormGeneral` still takes mere *boundedness* as a hypothesis, so not even the
`ModularForm` package is reachable at this level, let alone the `CuspForm` one.  The same applies
to `Theorems/Thm_CuspForm_exists_gamma0_four_apply_eq_eta_pow_mul.lean` (HTTP 200, 970 B), whose
hypotheses additionally include `Even b` and `4 ∣ a+b+c` and whose exponents are `ℕ` (no negative
exponents) — none of which appears in our statements.

### Receipts for "nothing else upstream, and no route was borrowed" (2026-09-08)

`GET /repos/anthropics/fermats-last-theorem/git/trees/main?recursive=1` → HTTP 200,
17 425 739 B, 45 950 entries (`"truncated": true`).  Path-substring counts:

* `ligozat` **0**, `Ligozat` **0**, `kroneckerSym` **0**, `etaQuotient` **0**,
  `etaMultiplier` **0**, `Gamma0Gens` **0**;
* `schreier` **0**; `Schreier` **1**, and it is `S_PadicAlgCl_…_artinSchreier_…` (Artin–Schreier
  theory, unrelated to Schreier's lemma or coset enumeration);
* `cosetReps` **2**, both `S_ModularCurve_*` (`exists_perm_gamma0_cosetReps`,
  `multiset_map_cosetReps_smul`) — neither was fetched or read, and neither is used: our
  transversal machinery is run 3's `subgroup_eq_of_transversal` / `Gamma0_eq_of_schreier`, proved
  in `EtaQuotientPrimeLevel.lean` from `Subgroup.closure` alone;
* `etaProductEleven` **6**, all in `P2M/Sol/` (`_add_one`, `_eq_qParam_mul_tprod`, `_fricke`,
  `_pow_twelve_smul`, `_smul_of_apply_one_zero_eq`, `_transform`). **Correction (this pass):
  two of the six were fetched** — `_transform` (39366 B) and `_smul_of_apply_one_zero_eq`
  (40579 B) — for the \S5 proof-shape grep; the other four genuinely were not fetched.

Pinned Mathlib (`905b95818e`), whole-library `grep -ri`: `ligozat` 0, `kroneckerSym` 0,
`etaQuotient` 0, `etaMultiplier` 0.

### Per-declaration

| Declaration | Kind | Note |
| --- | --- | --- |
| `drk12_pin_R11_sum`, `drk12_pin_R11_congr1_value`, `drk12_pin_R11_congr2_value`, `drk12_R11_congr1`, `drk12_R11_congr2` | INDEPENDENT | Weight and Ligozat congruences at `r = (2,2)`: `Σ r_δ = 4 = 2·2`, `Σ δ r_δ = 24`, `Σ (11/δ) r_δ = 24`.  Plain `decide` on our own definitions. |
| the ten `drk12_phi_h_*` | INDEPENDENT | `decide +kernel` evaluations of our own `etaPhiSum` at the ten Schreier generators `h_{j,j'}`, `1 ≤ j ≤ 10`.  Every value was computed FIRST in python3 (`fractions.Fraction`; `Int.fract`, `dedekindSaw`, `dedekindSum`, `etaPhiSum` re-implemented from the Lean SOURCE), and that re-implementation was validated by reproducing `drk11_phi_N11`, `drk11_phi_N3a/b/c/d` and `drk11_phi_N7` exactly before any new value was written.  The same script swept **2376** matrices of `Γ₀(11)` with `c > 0` (`c ∈ {11,…,88}`, `|a|,|d| ≤ 60`): every `Φ` is an integer `≡ 12 (mod 24)`, zero mismatches. |
| `drk12_pin_num_eleven`, `drk12_pin_sym_four`, `drk12_pin_sym_three` | INDEPENDENT | `D = 121`; `(121/4) = (121/3) = 1` through run 3's `kroneckerSym_sq_of_gcd`. |
| `drk12_neg_control_sym_eleven`, `drk12_neg_control_phi_distinct` | INDEPENDENT | `(121/11) = 0 ≠ 1`, so the coprimality side condition (`gamma0_not_dvd`) is load-bearing and not decoration; and the ten `Φ` pins are not all one constant. |
| `gamma0GensP11`, `drk12_mem_h_*`, `gamma0GensP11_subset`, **`closure_gamma0GensP11`**, `S_not_mem_closure_gensP11` | INDEPENDENT | `Γ₀(11) = ⟨-I, T, V, h₂₅, h₃₇, h₄₈, h₆₉⟩`, the `p = 11` instance of run 3's `Gamma0_eq_of_schreier`.  The six Schreier generators that are short words (`h_{1,10} = T⁻¹V⁻¹`, `h_{10,1} = (-I)VT`, `h_{j',j} = (-I)h_{j,j'}⁻¹`) are single `decide`s on `2 × 2` integer matrices.  Nothing upstream: `schreier` is 0 paths in the FLT tree. |
| `drk12_mult_h_2_5`, `_3_7`, `_4_8`, `_6_9`, **`etaMultiplierHom_eleven_eq_one`**, `etaMultiplierVal_eleven_eq_one` | INDEPENDENT | The multiplier at the four HYPERBOLIC generators, read off DRK-09 plus the kernel pins, then propagated to `Γ₀(11)` by `hom_ext_of_closure`.  **This is the step run 3 could not take**: `Γ̄₀(11)` has no elliptic elements, so `etaMultiplierVal_matH_diag` / `_matH_succ` (F3.2-C3, the technique that closed `p = 5,7,13`) supply nothing at `p = 11`. |
| `drk12_eleven_not_dvd`, `kroneckerSym_eleven_eq_one` | INDEPENDENT | `11 ∤ γ₁₁` from run 3's `gamma0_not_dvd`, hence `(11²/γ₁₁) = 1` from run 3's `kroneckerSym_sq_of_gcd`. |
| **`etaMultiplierVal_eq_kroneckerSym_eleven`**, **`exp_etaPhiSum_eq_kroneckerSym_eleven`** | INDEPENDENT | ETA-01's and DRK-11's exact conclusions at `N = 11`, `r = (2,2)`, `k = 2`.  `N = 11` is OUTSIDE `DRK-11A`'s `0 < N ≤ 4`, and the proof does not go through `DRK-11A`.  Neither declaration closes its node: both are quantified over all `N` and all `r`. |
| `etaQuotientH_eleven_eq` | INDEPENDENT | `∏_{δ ∣ 11} η(δτ)^{r_δ} = η(τ)²η(11τ)²`, from `Nat.divisors 11 = {1,11}` and `Finset.prod_pair`. |
| **`ModularForm.etaProductEleven_transform`** | INDEPENDENT proof, **statement identical to FLT's** (see above) | Apache-2.0 upstream `Theorems/Thm_ModularForm_etaProductEleven_transform.lean`, `anthropics/fermats-last-theorem` — recorded here because the STATEMENT coincides, **not** because anything was ported.  `sorry`-free; `FinalCheck.lean` §`Drk12` guards the footprint. |
| `etaQuotientH_transform_p11`, `etaQuotientH_eleven_slash` | INDEPENDENT | The library-idiom form and the `slash_action_eq'` field.  Holomorphy and cusp behaviour are NOT supplied; see the paragraph above on FLT's `CuspForm` statement. |
| `drk12_matN11_mem`, `drk12_matN11_pos`, `drk12_matches_pin_N11_even_d`, `drk12_pin_N11_value` | INDEPENDENT | Tripwire: the generation route must reproduce `drk11_pin_N11_even_d`, a value fixed by a Python computation at a matrix (`!![3,1;11,4]`) that appears nowhere in the generation proof. |
| `drk12_R4_sum`, `drk12_R4_congr1`, `drk12_R4_congr2`, `drk12_matN4_mem`, `drk12_matN4_pos`, `drk12_le_four_routeA`, `drk12_le_four_routeB` | INDEPENDENT | The `N ≤ 4` value comparator: run 3's F3.2-B3 route and the DRK-09 + kernel-`Φ` route both land on the numeral `1` at `N = 4`, `r = (-8,32,-8)`, `k = 8`, `γ = !![1,0;4,1]`.  They are two proofs of one numeric statement; **no `Eq` between proof terms is written**, because that comparator is `rfl` under proof irrelevance and would carry no information (see the file's part-5 docstring). |
| `etaProductEleven_via_ligozat_general` | INDEPENDENT **statement**, **NOT `sorry`-free** | The same level-11 statement derived from `ligozat_general` instead.  It inherits `sorryAx` from DRK-11 (§9) and is guarded in `FinalCheck.lean` §`Drk12` as an INVERTED tripwire.  It exists only so that "level 11 is closed, ETA-01 is not" is machine-checked rather than asserted. |

## 6. What we are not certain of

* The FLT upstream files used here carry **no copyright header**, so no author list can be
  reproduced verbatim — there is none to reproduce.  We attribute to the repository.  If FLT
  later adds headers to these files, this table should be updated with them.
* We fetched the four upstream files from the `main` branch on 2026-09-07 and recorded their byte
  sizes (§0) but **not** a commit hash.  A later `main` may differ.
* "Byte-identical" in §1 was computed after extracting each declaration block by a regexp on
  `^(theorem|def) name`; it does not cover upstream's `import` lines or `set_option`, which we did
  not copy.
* §2 and §3 assert that certain things have "no FLT counterpart".  That rests on reading the four
  upstream files listed in §0 and on FLT's published file index; we did not clone the whole FLT
  repository, so a counterpart could exist in a file we did not read.

* §5 asserts that DRK-08 has "no FLT counterpart".  That rests on the recursive tree listing of
  the FLT repository (45999 paths, fetched 2026-09-07) plus the four upstream files read in §0 and
  the `etaProductEleven` solution file; we did not read every file in the repository, so a
  counterpart could in principle exist under a name that the filter
  `ModularForm_eta|_eta_|etaMult|rademacher|dedekindSum` does not match.

* §7 asserts that DRK-09's *proofs* are independent.  The receipt is negative and therefore
  weaker than a positive one: `P2M/Sol/S_ModularCurve_sharpUnitInvariant.lean` and
  `Theorems/Thm_rademacher_phi_level_congruence.lean` were fetched and read **after** the Lean
  file was written and building, in order to correct the node's "no FLT counterpart" claim; the
  DRK-09 tactic scripts predate that reading.  What can be checked externally is that the
  upstream proofs use `p2m_exact_reverting`, a tactic that does not exist in this library, and
  that `EtaPhiSum.lean` contains no `p2m_*` identifier.
* §7's claim that DRK-09 has no upstream counterpart **at weight ≠ 0** rests on the two files
  named in its table plus the recursive tree listing of 2026-09-07.  A counterpart at general
  weight could exist in a file we did not read.
* §8 asserts that `KroneckerJacobi.lean` has no FLT counterpart.  That rests on the same
  evidence as §5/§7 (the recursive tree listing of 2026-09-07 and the files read in §0 and §7)
  plus the fact that FLT's Dedekind-sum theorems are stated with Mathlib's `jacobiSym`.  We did
  not read every file in the repository.
* §8's character count for the `dedekindSum_jacobiSym_mod_eight` statement (182 normalised
  characters on both sides) was computed by the DRK-10 comparator, not re-computed here.

* §9's "nothing upstream to port" rests on a `"truncated": true` recursive tree listing (45 950
  of an unknown larger number of paths) plus the one upstream file it quotes.  A counterpart
  could exist under a path the listing omitted or under a name that none of the substrings
  `ligozat`, `kronecker`, `etaQuotient` matches.  The claim is a **path-name** search, not a
  content search: FLT's file bodies were not grepped.
* §9 asserts that the DRK-11 *proofs* are independent.  The positive receipt is that the `Theorems/`
  statement file used as comparator target — `Thm_ModularForm_etaProductEleven_transform.lean`
  — was fetched **after** `EtaLigozatKronecker.lean` was written and building (the `P2M/Sol/`
  solution file was fetched separately, for the \S5 proof-shape grep, not as a proof source), and that its proof is
  `p2m_exact_reverting`, a tactic that does not exist in this library.  `grep -rn "p2m_" Lean/`
  returns **10** lines, every one of them prose inside a docstring or comment naming the upstream
  tactic (`RademacherPhi.lean` ×2, `DedekindSumJacobi.lean` ×3, `DedekindSum.lean` ×2,
  `EtaMultiplier.lean` ×2, `EtaLigozatKronecker.lean` ×1); **zero** are tactic invocations.

* §10's FLT search is again a **path-name** search over a `"truncated": true` tree listing, plus
  the one upstream file it quotes (`Def_ModularCurve_EtaQuotient.lean`, read in full).  FLT file
  *bodies* were not grepped, so a counterpart could exist under a path none of `ligozat`,
  `kronecker`, `etaQuotient`, `etaMultiplier`, `trivial_multiplier` matches.
* §10's claim that the `N = 17` counterexample makes `ligozat_trivial_multiplier_of_twelve_dvd`
  **false** (rather than merely incompatible with ETA-01) rests on numerics, not on a Lean proof:
  a 4000-term `η`-product evaluation of `f(γz)/((cz+d)¹² f(z))` at
  `z = -3/17 + (0.37 + i)/17` returning `-1.0000000000000 - 1.1e-14 i`, cross-checked against
  the Kronecker value `-1`.  What is proved in Lean is only that the two statements cannot both
  hold.  Deciding which is false *inside* Lean needs DRK-11 at `N = 17`.
