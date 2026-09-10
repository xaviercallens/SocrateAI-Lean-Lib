/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# Fricke-self-dual eta quotients: the eigenform relation  (DAG: `SDF-*`)

**THIS FILE IS NOW `sorry`-FREE.**  `SDF-DEF-01`, `SDF-DEF-02`, `SDF-01`, `SDF-02`, `SDF-03`,
`SDF-04`, `SDF-05` — the headline — `SDF-06`, the normalised form, `SDF-07`, the integer-exponent
periodicity of `i`, `SDF-08`, the `+1`-eigenvalue criterion, `SDF-09`, the `-1` (SIGN) criterion,
`SDF-10`, the MODULUS criterion `(N : ℝ)^k = 1 ↔ (N = 1 ∨ k = 0)`, `SDF-11`, the closed form
`‖frickeEigenvalue N k‖ = √((N : ℝ)^k)` for the eigenvalue's modulus, `SDF-12`, the unnormalised
`+1` criterion, `SDF-13`, the unnormalised `-1` (SIGN) criterion
`frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1)`, `SDF-14`, the `±1` criterion re-parametrised
by the WEIGHT SUM `∑ δ ∣ N, r δ`, `SDF-15`, the NORMALISED `±1` criterion
`(i^{-k} = 1 ∨ i^{-k} = -1) ↔ Even k`, and, as of this run, `SDF-16`, the `Decidable` instance for
`IsFrickeSelfDual` (ERGONOMICS ONLY — see its own section), are ALL closed (see *Status* at the end
of this docstring).  Every declaration below is proved and guarded; NO `sorry` and NO `-- OPEN:` obligation
remains in this file, and no declaration below carries an unconfirmed reconstructed statement.  This
paragraph read "PART STATEMENT LAYER" and named `SDF-12` and `SDF-13` as open until the two runs that
closed them; it must be re-derived from the file, not adjusted by arithmetic, if that changes.

## What this file adds

`EtaQuotientModularity.lean` proves (sorry-free, tag `F3.2-A7`, around line 2212)

```
theorem etaQuotient_fricke {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient N r (-(1 / ((N : ℂ) * z)))
      = I ^ (-k) * (N : ℂ) ^ k
        * ((Real.sqrt (∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ)) : ℝ) : ℂ)⁻¹
        * z ^ k * etaQuotient N (fun δ => r (N / δ)) z
```

i.e. the Fricke transform `z ↦ -1/(Nz)` sends the eta quotient with exponent vector `r` to a
known scalar times the eta quotient with the **dual** vector `δ ↦ r (N / δ)`.  In general those
are two different functions — `fricke_dual_pin` in that file exhibits an `r` whose dual differs.

This file specialises to the case where the two coincide, `r δ = r (N / δ)` for every `δ ∣ N`.
Then the transformation law becomes a genuine **eigenform relation**

```
    f(-1/(Nz)) = λ · z^k · f(z),      λ = i^{-k} · N^{k/2},
```

with an eigenvalue depending only on the level `N` and the weight `k`: the exponent vector has
disappeared from the constant.  That collapse — `∏_{δ ∣ N} δ^{r δ} = N^k` on self-dual `r`
(`prod_zpow_selfDual`) — is the only mathematical content in this file; everything else is
substitution into `etaQuotient_fricke`.

The classical statement this should be checked against is Martin, *Multiplicative eta-quotients*,
Trans. AMS 348 (1996) — already cited in this programme's bibliography for the Fricke eigenvalue
and multiplicativity of eta quotients.  It is the external cross-check, not an input.

## NAMING: "self-dual" / "Fricke-symmetric", never "balanced"

Read this before grepping.  `EtaQuotientModularity.lean` **already uses the word "balanced"** for
an unrelated concept: `exists_balanced_add` (tag `F3.2-B1`) is the `Int.bmod` balanced-remainder
division step used in the `Γ₀(N)` generator descent, and has nothing whatever to do with exponent
vectors or with the Fricke involution.  The condition `r δ = r (N / δ)` is therefore called
**self-dual** (equivalently *Fricke-symmetric*) throughout this library — `IsFrickeSelfDual` —
and the word "balanced" is deliberately not reused.  A reader who arrived here searching for
"balanced" wanted either `exists_balanced_add` (a lemma about integers) or, if they came from the
physics literature, the term discussed in the next paragraph.

## Physics MOTIVATION only — NOT formalised here, and no claim of it is made

Persson and Volpato, *Fricke S-duality in CHL models*, arXiv:1504.07260 (JHEP 12 (2015) 156),
attach to an orbifold element a "generalized Frame shape" `∏_{a ∣ N} a^{m(a)}` — an exponent
vector on the divisors of `N`, read here as an `EtaExp` — and call it **balanced** (their word,
their eq. 1.6) when `m(N/a) = m(a)` for all `a ∣ N`.  That is exactly the
condition `IsFrickeSelfDual` names here.

CAREFUL, TWO DIFFERENT NORMALISATIONS — do not merge them.  Their eq. 1.4 constrains the Frame
shape by `∑_{a ∣ N} m(a)·a = 24` (it records a 24-dimensional representation), whereas the WEIGHT
of the eta quotient `∏_δ η(δz)^{r_δ}` is `(∑_δ r_δ)/2`, i.e. weight 12 means `∑ r δ = 24`.
Those two sums agree only at `N = 1`: the standard balanced shape `1^8 2^8` at `N = 2` has
`∑ a·m(a) = 8 + 16 = 24` but `∑ m(a) = 16`, hence weight 8, not 12 (checked this session over
`1^k N^k`, `k = 24/(1+N)`, for `N = 1, 2, 3, 5, 7, 11, 23`).  Nothing in this file assumes either
constraint: `IsFrickeSelfDual` is the symmetry condition alone, and the weight normalisation
`∑ r δ = 2k` enters only as an explicit hypothesis of the lemmas that need it.

Their headline physical claim (their §1.1, §3) is that CHL models are self-dual under a Fricke
S-duality `S ↦ -1/(NS)` on the heterotic axio-dilaton modulus precisely when the Frame shape is
balanced.

**THE PHYSICS READING OF THIS CONDITION IS NOT FORMALISED HERE, AND NOTHING IN THIS FILE ASSERTS
IT.**  Their result is a physics derivation — charge-lattice `N`-modularity, Conway-group
representation theory, BPS/Witten-index counting — none of which this Lean library contains or
attempts.  This file is a statement about `∏_{δ ∣ N} η(δz)^{r_δ}` and nothing else.  No
declaration below mentions S-duality, the axio-dilaton, CHL models, or any physical object; if a
future reader finds one, it is a defect and should be removed.  The citation is here so that the
*origin of the question* is recorded, at the literature (L) tier of this programme's epistemic
ladder, and it must not be read as a formalised bridge.  Note also the term collision: their
"balanced" and this codebase's `exists_balanced_add` are unrelated uses of one word, which is the
second reason this file avoids it.

## Sign / definitional discipline

Decide-pins and negative controls are stated **before** the general lemmas they constrain — the
eigenvalue/product pins in the `Pins` section, and `SDF-01`'s hypothesis pins in `Sdf01Pins`
immediately above `etaQuotient_congr_divisors` — each with the value computed independently (exact rational / Gaussian-rational
arithmetic, this session) and recorded in its docstring.  This file is now `sorry`-free (see the
header), but the pins were placed first, before any general lemma, precisely so that the proving
phase discharged them first, and so that a proof disagreeing with a pin would be caught as a wrong
*statement* rather than patched. That ordering is why the discipline is recorded here even though
nothing below is `sorry` any more.  `SDF-02`'s own pins are in `Sdf02Pins`, immediately
above `prod_zpow_selfDual`, and are stated on the PRODUCT alone so that they do not depend on
`SDF-DEF-02`'s eigenvalue.  Additionally, `prod_zpow_selfDual` was program-checked, in exact
rational arithmetic, on four independent ranges: 4028 self-dual instances at `1 ≤ N ≤ 24` with
exponents in `[-3,3]` (3876 of them with `N > 1` and a non-constant vector), 20300 at `1 ≤ N ≤ 24`
with `[-5,5]`, 37068 at `1 ≤ N ≤ 48` with `[-3,3]`, and 671504 at `1 ≤ N ≤ 60` with `[-4,4]` — zero
mismatches in all four.  The scan enumerates by `δ ↔ N/δ` orbit, so self-duality is imposed by
construction rather than filtered for, and is then re-asserted per instance.

## Status

`SDF-DEF-01` (`IsFrickeSelfDual`) is **CLOSED**: the definition, its six `decide` condition-pins
(`selfDual_cond_pin_*`, `rPinSix_nonconstant`) and both negative controls
(`not_selfDual_pin_asymmetric`, `not_selfDual_pin_mispaired`) are all `sorry`-free, and each has a `#print axioms` guard in
`SocrateAI.FinalCheck` (section `SdfDef01`).

`SDF-DEF-02` (`frickeEigenvalue`) is **CLOSED**: the definition, the four integer-exponent `i`-power
lemmas it rests on (`I_zpow_neg_twelve`, `I_zpow_twelve`, `I_zpow_neg_two`, `I_zpow_neg_one`), its
six VALUE pins (`frickeEigenvalue_pin_level_one`, `frickeEigenvalue_pin_level_six`,
`frickeEigenvalue_pin_zero_weight`, `frickeEigenvalue_pin_level_two_weight_one`,
`frickeEigenvalue_pin_neg_one`, `frickeEigenvalue_pin_level_six_neg`) and its three negative
controls (`frickeEigenvalue_pin_not_natPow`, `frickeEigenvalue_pin_not_one`,
`frickeEigenvalue_pin_nonconstant`) are all `sorry`-free, and each has a `#print axioms` guard in
`SocrateAI.FinalCheck` (section `SdfDef02`).

Those pins are stated on the EIGENVALUE ALONE — no `etaQuotient`, no exponent vector, no
`IsFrickeSelfDual` hypothesis — which is why they close while the five `selfDual_pin_*`
conjunctions further down, which assert the same numbers as one conjunct among five, do not.  Until
this section existed those conjunctions were the only Lean statements asserting any value of
`frickeEigenvalue`, and — before THIS section closed the gap — the closed form had no standalone
machine-checked evidence behind it at all, only evidence bundled inside the five-part conjunctions
(themselves now also closed, see the pins near `SDF-05` below). It now additionally has six
standalone values and three standalone refutations here.

WHAT `SDF-DEF-02` DOES NOT SAY, so it cannot be oversold: a definition cannot be false, and these
pins fix VALUES of it.  That this closed form IS the Fricke eigenvalue is `SDF-03`
(`fricke_const_selfDual`) together with `SDF-05` — both now closed, the latter one run ago; this
line said "`SDF-05` (**still open**)" until this run and was stale, which is exactly the drift
`FinalCheck` exists to catch — and must not be read off this node.  Note also the junk value at `N = 0`: `(0 : ℝ)^k = 0` for `k ≠ 0` in Mathlib's `zpow`, so
`frickeEigenvalue 0 k = 0` there.  Harmless — every downstream statement carries `hN : 0 < N` — but
the definition is not meaningful at `N = 0`.

`SDF-02` (`prod_zpow_selfDual`) is **CLOSED**: the theorem, its six positive product pins
(`prod_zpow_pin_level_one`, `prod_zpow_pin_level_six_value`, `prod_zpow_pin_level_six`,
`prod_zpow_pin_zero_exp`, `prod_zpow_pin_level_two`, `prod_zpow_pin_level_four_neg`), the two
hypothesis witnesses for the level-four pin (`rPinLevelFourNeg_selfDual`,
`rPinLevelFourNeg_weight`), both negative controls (`prod_zpow_pin_asymmetric_ne` with its weight
witness `rPinAsym_weight`, and `prod_zpow_pin_mispaired_ne`) and the application check
(`prod_zpow_selfDual_pin_level_six`) are all `sorry`-free, and each has a `#print axioms` guard in
`SocrateAI.FinalCheck` (section `Sdf02`).  The `SDF-02` pins are stated on the PRODUCT ALONE, with
no `frickeEigenvalue` conjunct — that is why they close while the `selfDual_pin_*` conjunctions in
the `Pins` section do not.

`SDF-01` (`etaQuotient_congr_divisors`) is **CLOSED**: the theorem, its four `decide`
hypothesis-pins (`dualExp_congr_pin_*`), both negative controls
(`not_dualExp_congr_pin_asymmetric`, `not_dualExp_congr_pin_mispaired`), the orientation bridge
(`dualExp_congr_pin_level_six_of_selfDual`) and the application check
(`etaQuotient_congr_divisors_pin_level_six`) are all `sorry`-free, and each has a `#print axioms`
guard in `SocrateAI.FinalCheck` (section `Sdf01`).

`SDF-03` (`fricke_const_selfDual`) is **CLOSED**: the theorem, its three square-root value lemmas
(`sqrt_natPow_level_six`, `sqrt_natPow_level_four`, `sqrt_natPow_level_six_neg`), its five
constant-collapse pins (`fricke_const_pin_level_one`, `fricke_const_pin_level_six`,
`fricke_const_pin_zero_exp`, `fricke_const_pin_level_four_neg`, `fricke_const_pin_level_six_neg`),
the three hypothesis witnesses for the negative-weight pin (`rPinLevelSixNeg_selfDual`,
`rPinLevelSixNeg_weight`, `prod_zpow_pin_level_six_neg`), both negative controls
(`fricke_const_pin_not_natPow`, `fricke_const_pin_not_mul`) and the two application checks
(`fricke_const_selfDual_pin_level_six`, `fricke_const_selfDual_pin_level_six_neg`) are all
`sorry`-free, and each has a `#print axioms` guard in `SocrateAI.FinalCheck` (section `Sdf03`).

`SDF-03` is where the constant `N^k · s^{-1/2}` of `etaQuotient_fricke` becomes `√(N^k) = N^{k/2}`,
i.e. the non-`i` half of `frickeEigenvalue`.  Its pins are stated on the CONSTANT ALONE, with no
`etaQuotient` conjunct, which is why they close while the `selfDual_pin_*` conjunctions do not.
`rPinLevelSixNeg` is introduced for it: the only exponent vector in this file with NEGATIVE WEIGHT
(`k = -12`), where `N^k` and `√(N^k)` are proper fractions rather than integers, so a statement that
had silently assumed `k ≥ 0` fails there while satisfying every other pin.

`SDF-04` (`etaQuotient_fricke_selfDual_raw`) is **CLOSED**: the theorem, its three weight witnesses
(`rPinOne_weight`, `rPinSix_weight`, `zeroExp_weight_level_six`), its four full-equation instance
pins (`selfDual_raw_pin_level_one`, `selfDual_raw_pin_level_six`, `selfDual_raw_pin_zero_exp`,
`selfDual_raw_pin_level_four_neg`) and the external cross-check
(`selfDual_raw_pin_level_one_is_eta_S`) are all `sorry`-free, and each has a `#print axioms` guard
in `SocrateAI.FinalCheck` (section `Sdf04`).

`SDF-04` is the whole content of self-duality at the level of the FUNCTIONS: the dual quotient on
the right of `etaQuotient_fricke` collapses to the quotient itself, so the transformation law
becomes a genuine eigenform relation.  Its constant is still the raw `i^{-k} · N^k · s^{-1/2}` —
simplifying it is `SDF-05`'s job, via `SDF-03`, and is deliberately kept out of this node so that
"collapse the quotient" and "collapse the constant" cannot be conflated.  Unlike every earlier pin
set in this file, the `SDF-04` pins are stated as instances of the node's OWN equation rather than
of its hypotheses, and none of them invokes `etaQuotient_fricke_selfDual_raw`.

WHAT `SDF-04` DOES NOT SAY, so it cannot be oversold: it is an identity between two explicit
products of values of Mathlib's `ModularForm.eta`.  It says nothing about `Γ₀(N)`-modularity,
nothing about holomorphy at the cusps, and nothing about physics — see the header.

`SDF-05` (`etaQuotient_fricke_selfDual`) is **CLOSED** — this run.  The theorem, its five
full-equation instance pins (`selfDual_eigen_pin_level_one`, `selfDual_eigen_pin_level_six`,
`selfDual_eigen_pin_zero_exp`, `selfDual_eigen_pin_level_four_neg`,
`selfDual_eigen_pin_level_six_neg`), the five numeral forms of those pins (`..._value`), the
odd-weight eigenvalue value (`frickeEigenvalue_pin_level_four`) and the five `selfDual_pin_*`
conjunction pins are all `sorry`-free, and each has a `#print axioms` guard in
`SocrateAI.FinalCheck` (section `Sdf05`).

`SDF-05` is where the constant loses the exponent vector: `SDF-04`'s `i^{-k} · N^k · s^{-1/2}`,
which still mentions `r` through `s = ∏_{δ ∣ N} δ^{r δ}`, becomes `i^{-k} · √(N^k)`, which mentions
only the level and the weight.  The proof is three rewrites and a `ring` — `SDF-04` for the shape,
`SDF-03` read backwards for the constant, `ring` for the re-association — and it must stay that
short: all the arithmetic happened in `SDF-02`.  Like the `SDF-04` pins, the `SDF-05` pins are
stated as instances of the node's OWN equation, and none of them invokes
`etaQuotient_fricke_selfDual` (they are declared above it, so Lean's scoping enforces that rather
than this docstring).  Five of them carry `frickeEigenvalue N k` symbolically; the other five
re-state the same instances with the eigenvalue replaced by the numeral computed by hand outside
Lean, reached through `SDF-DEF-02`'s `frickeEigenvalue_pin_*` lemmas — which are proved from
`Real.sqrt_sq` and never touch `s`.  Each numeral is therefore reached twice, by routes sharing no
lemma.

The five `selfDual_pin_*` conjunction pins were `SDF-05`'s bookkeeping and are now closed too, by
assembly: the self-duality conjuncts are the `selfDual_cond_pin_*` lemmas, the weight conjuncts are
`decide`, the product conjuncts are the `divisors`-evaluation computation stated twice (once against
a literal, once against `N^k`, so the two must agree), and the eigenvalue conjuncts are the
`frickeEigenvalue_pin_*` lemmas.  One wrinkle, recorded because it cost a `ring`:
`selfDual_pin_level_two_weight_one` states its eigenvalue conjunct as `-I * (√2 : ℂ)` while
`frickeEigenvalue_pin_level_two_weight_one` proves `-(I * (√2 : ℂ))` — equal by `neg_mul`, not by
`rfl`.
(`SDF-PIN-02` gives that respelling its own name, `frickeEigenvalue_pin_level_two_weight_one_spelling`,
so it is one machine-checked step rather than something absorbed into a `ring`.  And note the near
collision: `selfDual_pin_level_two_weight_one` is a hypothesis CONJUNCTION, while
`selfDual_eigen_pin_level_two*` are the full EQUATIONS at the same instance — `verification/`
`SdfPin02NegControl.lean` item 9 is the type-mismatch control that keeps the two apart.)

`SDF-06` (`etaQuotient_fricke_selfDual_normalized`) is **CLOSED** — this run.  The theorem, its two
radicand lemmas (`sqrt_natPow_level_one`, `sqrt_natPow_zero_weight`), its five full-equation
instance pins (`selfDual_norm_pin_level_one`, `selfDual_norm_pin_level_six`,
`selfDual_norm_pin_zero_exp`, `selfDual_norm_pin_level_four_neg`,
`selfDual_norm_pin_level_six_neg`), the three numeral forms of those pins (`..._value`), the
external cross-check `selfDual_norm_pin_level_one_is_eta_S`, the negative control
`selfDual_norm_pin_asymmetric_ne` and the two application checks
(`etaQuotient_fricke_selfDual_normalized_pin_level_six` and `..._pin_level_six_neg`) are all
`sorry`-free, and each has a `#print axioms` guard in `SocrateAI.FinalCheck` (section `Sdf06`).

WHAT `SDF-06` ADDS, AND WHAT IT DOES NOT.  It divides `SDF-05` through by the normaliser `√(N^k)`
and by `z^k`, leaving `i^{-k}` — a ROOT OF UNITY — as the whole eigenvalue.  That is bookkeeping, and
must be read as such: the `N`-dependence does not cancel because of anything visible in this node.
It cancels because `∏_{δ ∣ N} δ^{r δ} = N^k` on a self-dual vector (`prod_zpow_selfDual`, `SDF-02`,
the only genuinely arithmetical step in this file, which routes through `sqrt_prod_dual` and then
uses positivity to pick the root `+N^k`), packaged into `ℂ` by `SDF-03` and absorbed into
`frickeEigenvalue` by `SDF-05`.  A reader who meets "the `N`-dependence cancels completely" and
looks here for the lemma that earns it will not find it; it is in `SDF-02`.

The two cancellations `(√(N^k))⁻¹ · √(N^k) = 1` and `z^{-k} · z^k = 1` each need a hypothesis
(`0 < N` through `zpow_pos`, not `pow_pos`, since `k` may be negative; and `z ≠ 0` from `hz`), and
`ring` performs neither — verified this session by running `ring` alone on the post-`SDF-05` goal,
which fails and reports the uncancelled residue.  `ring` only re-associates.

That "this is the classical normalisation (Martin 1996)" is a CITATION claim about Martin's
convention, at the literature (L) tier — nothing here checks it.  What IS checked against an
external source is the level-one instance: `selfDual_norm_pin_level_one_is_eta_S` reaches
`z⁻¹² η(-1/z)²⁴ = η(z)²⁴`, which Mathlib proves independently as `discriminant_S_invariant`.

`SDF-07` (`I_zpow_emod`) is **CLOSED** — this run.  The theorem, its exponent-range companion
`I_zpow_emod_exponent_mem`, its six instance pins (`I_zpow_emod_pin_twelve`,
`..._pin_neg_twelve`, `..._pin_zero`, `..._pin_neg_one`, `..._pin_neg_two`, `..._pin_neg_fifteen`),
its two negative controls (`I_zpow_emod_pin_not_mod_two`, `I_zpow_emod_pin_nontrivial_reduction`)
and the application check `I_zpow_emod_pin_application` are all `sorry`-free, and each has a
`#print axioms` guard in `SocrateAI.FinalCheck` (section `Sdf07`).

WHAT `SDF-07` IS, AND WHAT IT IS NOT.  It is a fact about `ℂ` alone: `i` has multiplicative order
`4`, so an INTEGER power of `i` depends only on the exponent mod `4`.  It mentions no eta quotient,
no level, no weight and no `z`; it is NOT a specialisation of `etaQuotient_fricke` in either
direction, and nothing in it is derived from the Fricke transformation law.  Its role is auxiliary:
`i^{-k}` is one factor of `frickeEigenvalue N k`, so `SDF-07` is what will let `SDF-08` and `SDF-09`
decide when that factor is `±1` by a finite case analysis instead of a fresh computation.  A reader
who meets "the eigenvalue is a root of unity" and looks here for the lemma that earns it will not
find it; that is `SDF-06`, and the arithmetic behind it is `SDF-02`.

Mathlib does not already have this.  `Complex.I_pow_eq_pow_mod` (`Data/Complex/Basic.lean:633`) is
the `ℕ`-exponent version only.  The generic `zpow_eq_zpow_emod` (`Algebra/Group/Basic.lean:849`)
would have subsumed it, but it lives in `section Group` (`variable [Group G]`, opened at
`Algebra/Group/Basic.lean:594`, not closed before line 849 — re-checked this session) and `ℂ` is not
a group under multiplication; a whole-Mathlib grep finds no `GroupWithZero`/`DivisionRing` analogue.
So the proof goes through `zpow_add₀`, paying the `I ≠ 0` side condition.

WHY SIX PINS FOR A FOUR-LINE PROOF.  Because the statement, not the proof, is where this node could
go wrong, in exactly two ways: the modulus could be wrong, and `%` could be read as `Int.tmod`
rather than `Int.emod`.  `I_zpow_emod_pin_not_mod_two` kills the first (at `k = 3` a mod-`2`
statement asserts `-i = i`).  `..._pin_neg_one` kills the second: under `tmod` the reduced exponent
at `k = -1` would be `-1` and the pin would collapse to a tautology, whereas under `emod` it is `3`
and the equation genuinely relates a negative power to a positive one.  `..._pin_neg_fifteen` is the
instance whose value is neither `1` nor `-1`, so it cannot be an artefact of the `±1` bookkeeping
that `SDF-08`/`SDF-09` will do on top.  `..._pin_zero` is DEGENERATE and is recorded as such: after
its `decide` the two sides are the same term, so it constrains nothing.  All 81 exponents in
`[-40, 40]` were checked outside Lean in exact Gaussian-rational arithmetic before any of this was
stated; zero mismatches.

NAMING NOTE.  `SDF-08`'s forward direction already exists elsewhere in this library as
`I_zpow_neg_eq_one` (`EtaQuotientPrimeLevel.lean:630`, sorry-free, same namespace).  It is not in
scope here — this file imports only `EtaQuotientModularity`, of which `EtaQuotientPrimeLevel` is a
sibling — but `FinalCheck` imports BOTH, so `SDF-08` keeps its `_iff` suffix.  Because that lemma is
out of scope, `SDF-08`'s converse direction is NOT a reuse of it: both directions of the `iff` run
through `SDF-07`.

`SDF-08` (`I_zpow_neg_eq_one_iff`) is **CLOSED** — this run.  `i^{-k} = 1 ↔ 4 ∣ k`, with six weight
pins (`I_zpow_neg_eq_one_iff_pin_twelve`, `..._pin_neg_twelve`, `..._pin_zero`, `..._pin_two`,
`..._pin_one`, `..._pin_fifteen`) and the application check
`I_zpow_neg_eq_one_iff_pin_application`, all `sorry`-free and each guarded by `#print axioms` in
`SocrateAI.FinalCheck` (section `Sdf08`).  `..._pin_two` is the load-bearing one: at weight `2` both
sides are FALSE, and it is the weight of `selfDual_pin_eigenvalue_neg_one` (`η⁴`, eigenvalue `-1`), so
a statement on the wrong residue class would break there.  `..._pin_zero` is DEGENERATE and recorded
as such.  Before any of this was stated in Lean, `i^{-k} = 1 ↔ 4 ∣ k` was checked outside Lean in
exact Gaussian-integer arithmetic at all 121 weights `k ∈ [-60, 60]`; zero mismatches.

`SDF-09` (`I_zpow_neg_eq_neg_one_iff`) is **CLOSED** — this run.  `i^{-k} = -1 ↔ k % 4 = 2`, the SIGN
criterion, with six weight pins (`I_zpow_neg_eq_neg_one_iff_pin_twelve`, `..._pin_neg_twelve`,
`..._pin_zero`, `..._pin_two`, `..._pin_neg_two`, `..._pin_fifteen`), two negative controls
(`..._pin_k_not_neg_k`, `..._pin_emod_not_tmod`), the `k`/`-k` bridge
`I_zpow_neg_eq_neg_one_iff_emod_neg` and the application check
`I_zpow_neg_eq_neg_one_iff_pin_application`, all `sorry`-free and each guarded by `#print axioms` in
`SocrateAI.FinalCheck` (section `Sdf09`).  `..._pin_two` is the load-bearing one and the only pin at
which BOTH sides are true: it is the weight of `selfDual_pin_eigenvalue_neg_one` (`η⁴` at level one,
eigenvalue `-1`), so `SDF-09` and that hand-computed eta-quotient instance agree on the sign.
`..._pin_neg_two` is the `emod` pin — under `Int.tmod` it would be FALSE, and `..._pin_emod_not_tmod`
records both values — and `..._pin_k_not_neg_k` records that `k % 4` and `(-k) % 4` are DIFFERENT
functions, so stating the criterion on the WEIGHT `k` rather than on the exponent `-k` is a real
choice; the two agree only on the residue class `2`.  `..._pin_zero` is DEGENERATE and recorded as
such.  Before any of this was stated in Lean, `i^{-k} = -1 ↔ k % 4 = 2` was checked outside Lean in
exact Gaussian-integer arithmetic at all 401 weights `k ∈ [-200, 200]`; zero mismatches.

WHAT `SDF-08` IS NOT.  Like `SDF-07` it is a fact about `ℂ` and `ℤ` alone — no level, no exponent
vector, no `z`, no eta quotient — and it is NOT a specialisation of `etaQuotient_fricke`.  That
specialisation is `SDF-04`.  `SDF-08` is downstream of the Fricke work only through the constant:
`i^{-k}` is one factor of `frickeEigenvalue N k`.

`SDF-10` (`natCast_zpow_eq_one_iff`) is **CLOSED** — this run.  `(N : ℝ)^k = 1 ↔ (N = 1 ∨ k = 0)`
for `0 < N`, the MODULUS criterion: `SDF-08` and `SDF-09` settled the root of unity `i^{-k}` in
`frickeEigenvalue N k`, and this settles the other factor, the positive real `√(N^k)`, by settling
`N^k`.  It is what rules out any `N > 1` with `k ≠ 0` in `SDF-12`/`SDF-13`.  Six instance pins
(`natCast_zpow_eq_one_iff_pin_level_one`, `..._pin_level_six`, `..._pin_zero_weight`,
`..._pin_level_four`, `..._pin_level_six_neg`, `..._pin_level_one_neg`), the pinned values
(`natCast_zpow_pin_level_six_value`, `..._level_four_value`, `..._level_six_neg_value`) with PIN B's
second route `natCast_zpow_pin_level_six_routes_agree` through the already sorry-free
`sqrt_natPow_level_six`, two negative controls (`..._pin_not_weight_only`, `..._pin_not_level_only`),
the hypothesis-redundancy pin `..._pin_hypothesis_redundant` and the application check
`..._pin_application` are all `sorry`-free and each guarded by `#print axioms` in
`SocrateAI.FinalCheck` (section `Sdf10`).  `..._pin_level_six` is the load-bearing one — BOTH sides
FALSE at the genuine `N > 1` Fricke-self-dual instance `rPinSix`, which is what makes the `±1`
classification sharp rather than vacuous — and `..._pin_level_six_neg` is the one that sees the SIGN
of `k`, where the power is the proper fraction `1/2176782336`.  `..._pin_zero_weight` is DEGENERATE
and recorded as such.  `hN : 0 < N` is REDUNDANT (the biconditional also holds at `N = 0`, which
`..._pin_hypothesis_redundant` proves) and is deliberately unused in the proof; it is kept only so
this lemma's shape matches `SDF-12` and `SDF-13`.  Before any of this was stated in Lean,
`N^k = 1 ↔ (N = 1 ∨ k = 0)` was checked outside Lean in exact rational arithmetic at all `20301`
instances `N ∈ [0, 100]`, `k ∈ [-100, 100]`; zero mismatches.

WHAT `SDF-10` IS NOT.  Like `SDF-07` … `SDF-09` it is a fact about a scalar alone — no level in the
modular sense, no exponent vector, no `z`, no eta quotient — and it is NOT a specialisation of
`etaQuotient_fricke`.  That specialisation is `SDF-04`.

`SDF-11` (`frickeEigenvalue_norm`) is **CLOSED** — this run.  `‖frickeEigenvalue N k‖ = √((N : ℝ)^k)`
for `0 < N`: the MODULUS of the unnormalised eigenvalue in closed form.  `frickeEigenvalue N k` is
`i^{-k} · √(N^k)`, a fourth root of unity times a NON-NEGATIVE real, so the norm discards the
`i`-factor entirely and returns the real one.  This is what makes the `±1` classification of
`SDF-12`/`SDF-13` split cleanly into an ARGUMENT condition (`SDF-08`/`SDF-09`) and a MODULUS
condition (`SDF-10`): `λ = ±1` forces `‖λ‖ = 1`, which by this node is `√(N^k) = 1`, which is
`SDF-10`'s `N^k = 1`.  Six instance pins (`frickeEigenvalue_norm_pin_level_one`, `..._pin_level_six`,
`..._pin_zero_weight`, `..._pin_level_two_weight_one`, `..._pin_neg_one`, `..._pin_level_six_neg`),
each computing BOTH sides by routes sharing no lemma — the left through `SDF-DEF-02`'s
`frickeEigenvalue_pin_*` values, the right through `SDF-03`'s `sqrt_natPow_*` radicands — three
negative controls (`..._pin_not_natPow`, `..._pin_not_eigenvalue`, `..._pin_nonconstant`), the
hypothesis-redundancy pin `..._pin_hypothesis_redundant` and the application check
`..._pin_application` are all `sorry`-free and each guarded by `#print axioms` in
`SocrateAI.FinalCheck` (section `Sdf11`).  `..._pin_level_six` is the LOAD-BEARING one: `46656`, not
`6^12 = 2176782336`, so it is where a statement with the square root dropped would break — and
`..._pin_not_natPow` refutes that dropped-root reading outright.  `..._pin_level_two_weight_one` is
the one that leaves the integers (both sides `√2`, odd weight), and `..._pin_neg_one` is the one
where the eigenvalue is `-1`, pinning that `‖·‖` DISCARDS the sign and that this node must not be
misread as a closed form for the eigenvalue itself.  `..._pin_zero_weight` is DEGENERATE and is
recorded as such.  `hN : 0 < N` is REDUNDANT — `..._pin_hypothesis_redundant` proves the same
equation at `N = 0` at three weights — and is deliberately unused; it is kept only so this lemma's
shape matches `SDF-10`, `SDF-12` and `SDF-13`.

WHAT `SDF-11` IS NOT.  Like `SDF-07` … `SDF-10` it is a fact about a scalar alone — no exponent
vector, no `z`, no eta quotient, no `IsFrickeSelfDual` hypothesis — and it is NOT a specialisation
of `etaQuotient_fricke`.  That specialisation is `SDF-04`.  The statement comparator for this node
was pointed at `etaQuotient_fricke` and correctly returned NO_REFERENCE for exactly that reason.

`SDF-13` (`frickeEigenvalue_eq_neg_one_iff`) is **CLOSED** — this run, and it is the LAST open node
in this file.  `frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1)` for `0 < N`: the unnormalised SIGN
criterion, the sibling of `SDF-12` at the other value.  Its right-hand side is NOT `SDF-12`'s with
`1` replaced by `-1` — the `k = 0` disjunct is absent, because `k % 4 = 2` already forces `k ≠ 0`, so
`SDF-10`'s second disjunct cannot fire and the level condition sharpens to `N = 1`.  That sharpening
is machine-checked by `frickeEigenvalue_eq_neg_one_iff_pin_asymmetry`, which also exhibits `(6, 0)`
as an instance where `SDF-12`'s right-hand side is TRUE and this one's is FALSE.  Three new VALUE
pins (`I_zpow_two`, `frickeEigenvalue_pin_level_six_weight_two`,
`frickeEigenvalue_pin_level_one_weight_neg_two`), eight instance pins
(`frickeEigenvalue_eq_neg_one_iff_pin_level_one`, `..._pin_level_six`, `..._pin_zero_weight`,
`..._pin_level_two_weight_one`, `..._pin_neg_one`, `..._pin_level_six_neg`,
`..._pin_level_six_weight_two`, `..._pin_neg_one_neg_weight`), three negative controls
(`..._pin_not_level_only`, `..._pin_not_emod_only`, `..._pin_emod_not_tmod`), the asymmetry pin, the
hypothesis-redundancy pin `..._pin_hypothesis_redundant` and the application check
`..._pin_application` are all `sorry`-free and each guarded by `#print axioms` in
`SocrateAI.FinalCheck` (section `Sdf13`).  `..._pin_neg_one` (`N = 1`, `k = 2`) is the LOAD-BEARING
one and `..._pin_neg_one_neg_weight` (`N = 1`, `k = -2`) its negative-weight companion: they are the
only two pins where BOTH sides are true, so they are what makes the right-hand side non-empty.
`..._pin_level_six_weight_two` (`N = 6`, `k = 2`) is the LEVEL control — `2 % 4 = 2` holds, so the
root of unity IS `-1`, and yet `λ = -6` — the only pin at which the two conjuncts disagree, and the
instance that forces the `N = 1` conjunct to exist.  `..._pin_zero_weight` is DEGENERATE and is
recorded as such; note it is FALSE where `SDF-12`'s pin at the same `(N, k)` is TRUE.  `hN : 0 < N`
is REDUNDANT (`..._pin_hypothesis_redundant` proves the same biconditional at `N = 0` at three
weights) but IS syntactically used, being passed to `SDF-10` and `SDF-11`; it is kept only so this
lemma's shape matches `SDF-10`, `SDF-11` and `SDF-12`.

`SDF-14` (`frickeEigenvalue_pm_one_iff`) is **CLOSED** — this run.
`(λ = 1 ∨ λ = -1) ↔ (4 ∣ ∑_{δ ∣ N} r δ ∧ (N = 1 ∨ ∑_{δ ∣ N} r δ = 0))` for `0 < N` and any
`r : EtaExp` with `∑ r δ = 2k`.  It is the DISJUNCTION of `SDF-12` and `SDF-13`, re-parametrised by
the weight sum rather than the weight, and is NOT new mathematics and NOT a statement about eta
quotients: `r` enters only through `hk`, and no `etaQuotient`, `z`, dual vector or
`IsFrickeSelfDual` hypothesis occurs in it.  It is worth stating because the weight SUM is what a
concrete exponent vector presents to `decide`, whereas the weight `k` exists only as the witness of
`hk`.  THE STEP THAT IS NOT MECHANICAL: `4 ∣ ∑ r δ` is `4 ∣ 2k`, which does NOT give `4 ∣ k`, so the
backward direction case-splits `k % 4 ∈ {0, 2}` and routes residue `0` to `SDF-12` and residue `2`
to `SDF-13`.  One new exponent vector (`rPinNegFour`, the level-one weight `-2` vector `(-4)`) with
its weight witness `rPinNegFour_weight`, seven instance pins
(`frickeEigenvalue_pm_one_iff_pin_level_one`, `..._pin_level_six`, `..._pin_zero_exp`,
`..._pin_neg_one_branch`, `..._pin_level_two_weight_one`, `..._pin_level_six_neg`,
`..._pin_emod_not_tmod`) and the application check `..._pin_application` are all `sorry`-free and
each guarded by `#print axioms` in `SocrateAI.FinalCheck` (section `Sdf14`).  `..._pin_level_six` is
the LOAD-BEARING one — a genuine `N > 1` self-dual vector with the SAME weight sum as the level-one
pin and the opposite verdict, which is what forces the `(N = 1 ∨ ∑ r δ = 0)` conjunct to exist.
`..._pin_neg_one_branch` is THE TRAP: `4 ∣ ∑ r δ` holds, `4 ∣ k` fails, and the eigenvalue is `-1`,
so a backward direction routed to `SDF-12` alone is refuted there.  `..._pin_zero_exp` is DEGENERATE
and is recorded as such — it is nevertheless the only pin at which the right-hand side holds with
`N > 1`, so it is what makes the `∑ r δ = 0` disjunct non-vacuous.  The NORMALISATION CAVEAT stated
below for `SDF-13` applies verbatim to `SDF-14` and must accompany any prose report of it.

NORMALISATION CAVEAT ON `SDF-13`, which any prose report of it must carry.  `frickeEigenvalue` is the
UNNORMALISED constant of `f(-1/(Nz)) = λ · z^k · f(z)` and carries `N^{k/2}`.  "Eigenvalue `-1` forces
`N = 1`" is a statement about THAT convention.  It does NOT contradict the classical fact (Martin,
*Multiplicative eta-quotients*, 1996) that multiplicative eta quotients of level `N > 1` have Fricke
eigenvalue `±1`: the classical eigenvalue is the NORMALISED one, here `i^{-k}` (`SDF-06`), whose
`N`-dependence has already cancelled by `SDF-02`.  `frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two`
is the instance where the two differ: normalised `-1`, unnormalised `-6`.

`SDF-15` (`I_zpow_neg_pm_one_iff`) is **CLOSED** — this run.
`(i^{-k} = 1 ∨ i^{-k} = -1) ↔ Even k`, the NORMALISED `±1` criterion: the DISJUNCTION of `SDF-08`
(`4 ∣ k`) and `SDF-09` (`k % 4 = 2`), whose union of residue classes mod `4` is `{0, 2}`, i.e. the
even weights.  Six weight pins (`I_zpow_neg_pm_one_iff_pin_twelve`, `..._pin_neg_twelve`,
`..._pin_zero`, `..._pin_two`, `..._pin_fifteen`, `..._pin_one`), two negative controls
(`..._pin_neither_disjunct_alone`, `..._pin_even_strictly_between`), the negation-invariance lemma
`I_zpow_neg_pm_one_iff_even_neg` and the application check `..._pin_application` are all `sorry`-free
and each guarded by `#print axioms` in `SocrateAI.FinalCheck` (section `Sdf15`).  `..._pin_two` is the
LOAD-BEARING one — the only pin at which the left-hand side holds through its SECOND disjunct, and
the weight of `selfDual_pin_eigenvalue_neg_one` (`η⁴` at level one, eigenvalue `-1`) — so a version
of this node stated with `i^{-k} = 1` alone on the left is refuted there.  `..._pin_fifteen` and
`..._pin_one` are the two ODD residue classes, where the value is `i` and `-i` respectively, and no
`±1` coincidence can fake them.  `..._pin_zero` is DEGENERATE and recorded as such.  Before any of
this was stated in Lean, `i^{-k} ∈ {1, -1} ↔ k` even was checked outside Lean in exact
Gaussian-integer arithmetic at all 601 weights `k ∈ [-300, 300]`; zero mismatches.

WHAT `SDF-15` IS NOT.  Like `SDF-07` … `SDF-09` it is a fact about `ℂ` and `ℤ` alone — no level, no
exponent vector, no `z`, no eta quotient — and it is NOT a specialisation of `etaQuotient_fricke`.
That specialisation is `SDF-04`.  Two further limits, both of which any prose report must carry.
(i) The identification of `i^{-k}` with "the Fricke eigenvalue" is `SDF-06`, not this node; the
sentence "the Fricke eigenvalue is `±1` iff the weight is even" is `SDF-15` COMPOSED WITH `SDF-06`.
(ii) The NORMALISATION CAVEAT above applies in its sharpest form here: that sentence is TRUE of the
normalised eigenvalue `i^{-k}` and FALSE of `frickeEigenvalue`, for which `±1` is `SDF-14`'s far
tighter condition, and `frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two` is the witness
where the two conventions differ.  It may be quoted in preference to `SDF-14` only with the
normalisation named in the same sentence.  (iii) The re-parametrisation `Even k ↔ 4 ∣ ∑_{δ ∣ N} r δ`
is NOT this node: it needs `hk : ∑ δ ∈ N.divisors, r δ = 2 * k`, which `SDF-15` does not carry, and
would be a separate node exactly as `SDF-14` was for `SDF-12`/`SDF-13`.

`SDF-16` (`decidableIsFrickeSelfDual`) is **CLOSED** — this run.  The `Decidable` instance for
`IsFrickeSelfDual`, by `Finset.decidableBAll` on the bounded quantifier the `def` unfolds to.
ERGONOMICS ONLY, and it must be reported as nothing more: it removes the leading
`unfold IsFrickeSelfDual` from a `decide` proof and does nothing else.  It is NOT what lets the
`selfDual_cond_pin_*` pins work — every one of them predates it, uses `unfold … ; decide`, and needs
no instance — and it is NOT what makes the self-duality hypothesis non-vacuous, which is
`not_selfDual_pin_asymmetric` and `not_selfDual_pin_mispaired` (section `SdfDef01`).  Both of those
overclaims were caught by this run's statement comparator and are recorded in the node's own
docstring so they cannot re-enter.  Nothing above the node's own section depends on it.  It is a
genuine delta all the same: with the instance removed, bare `decide` on a self-duality goal fails
with `failed to synthesize Decidable (IsFrickeSelfDual …)`, verified this run.  A `Decidable`
instance is proof-carrying and so cannot be WRONG about which vectors are self-dual; the one way it
could be useless is by being INERT (not reducing in the kernel), which
`decidableIsFrickeSelfDual_pin_bool_values` refutes by asserting six concrete `Bool` values by `rfl`.
Four positive pins (`..._pin_level_one`, `..._pin_level_six`, `..._pin_zero_exp`,
`..._pin_level_four_neg`), the negative-side pin `..._pin_mispaired`, the reduction pin
`..._pin_bool_values` and the `N = 0` trap `..._pin_level_zero_vacuous` are all `sorry`-free and each
guarded by `#print axioms` in `SocrateAI.FinalCheck` (section `Sdf16`), with the inverted forms as
must-fail items in `verification/Sdf16PinNegControl.lean`.  `decide` throughout, never
`native_decide`.

RENUMBERING RECEIPT — READ BEFORE MATCHING ANY `SDF-1x` LABEL AGAINST AN OLDER DOCUMENT.  Two
declarations in this file, `frickeEigenvalue_eq_one_iff` and `frickeEigenvalue_eq_neg_one_iff`, were
introduced by an earlier run whose task specification had been TRUNCATED mid-node at the string
`theorem frickeEigenvalue_`; that run reconstructed a plausible pair of statements and labelled them
`SDF-11` and `SDF-12`, while recording in their docstrings that the labels were a guess to be
confirmed or replaced.  The orchestrating session has now supplied the real `SDF-11`, which is
`frickeEigenvalue_norm` above — a DIFFERENT theorem.  Both reconstructed declarations were therefore
renumbered to `SDF-12` and `SDF-13`, in the same commit that closed the real `SDF-11`, so that no two
theorems carry the same tag.  `SDF-12`'s statement has SINCE BEEN CONFIRMED: the orchestrating
session supplied that node in full and the supplied text agrees with the reconstructed declaration
CHARACTER FOR CHARACTER, `hN` included, so `frickeEigenvalue_eq_one_iff` is now proved, pinned and
guarded (`FinalCheck` section `Sdf12`) and may be reported as a specified node.  `SDF-13`
(`frickeEigenvalue_eq_neg_one_iff`) has SINCE been confirmed the same way — the orchestrating session
supplied that node in full and the supplied text agrees with the declaration CHARACTER FOR CHARACTER,
`hN` included — and is now proved, pinned and guarded (`FinalCheck` section `Sdf13`).  NO
reconstructed statement remains in this file; this paragraph said `SDF-13` "has NOT been confirmed"
until that run.  Documents
written before this commit — in particular the dated run records in `verification/README.md`, which
are historical and were deliberately NOT rewritten — use the old numbering, where `SDF-11` means
`frickeEigenvalue_eq_one_iff` and `SDF-12` means `frickeEigenvalue_eq_neg_one_iff`.

NO declaration below is `sorry` any more, and no `-- OPEN:` obligation remains in this file: `SDF-13`
was the last one, and every declaration in the file now carries a `#print axioms` guard in
`SocrateAI.FinalCheck`.  This paragraph read "Every OTHER declaration below is still `sorry`" until
that run.

`SDF-PIN-02` is **CLOSED** — this run — and is `selfDual_eigen_pin_level_two_eta`, declared inside
`section Sdf05Pins` below:

```
η(-1/(2z)) · η(2 · (-1/(2z)))  =  -i·√2 · z · (η(z) · η(2z))
```

the `(N, r, k) = (2, rPinTwo, 1)` instance of `SDF-05`, i.e. `f = η(z)·η(2z)` — the FIRST pin in
this file stated with `etaQuotient`, `EtaExp` and `frickeEigenvalue` all unfolded away, so the first
one that exercises the `etaQuotient` UNFOLDING.  (It said "the ONLY pin" until `SDF-PIN-03` was
closed; three more η-unfolded pins now exist, all in section `SdfPin03` at the end of this module.)  It arrives with seven supporting pins
(`rPinTwo_weight`, `rPinTwo_divisors_pin`, `rPinTwo_values_pin`, `sqrt_natPow_level_two`,
`two_mul_inv_sqrt_two`, `fricke_const_pin_level_two`, `sqrt_two_nondegenerate`), the spelling lemma
`frickeEigenvalue_pin_level_two_weight_one_spelling`, the two `etaQuotient`-form pins
`selfDual_eigen_pin_level_two` and `..._value`, and a REACH section at the end of this module
(`SdfPin02Reach`) carrying a SECOND, independent derivation of the same equation from the upstream
`fricke_level_two_pin` — so that "the two spellings of the constant agree" is a build obligation, not
a docstring claim — three reach checks, one stated LIMITATION and a conjugate control.  All eighteen
are `sorry`-free and each has a `#print axioms` guard in `SocrateAI.FinalCheck` (section `SdfPin02`);
must-fail control `verification/SdfPin02NegControl.lean` (exits 1, ten `error:` lines).

READ THE LIMITATION BEFORE CITING THAT PIN.  `rPinTwo` is CONSTANT on `Nat.divisors 2`
(`selfDual_eigen_pin_level_two_no_evidence_pairing`), so a TRANSPOSED divisor pairing would still
close it.  It is evidence about the CONSTANT and the unfolding, not about the involution; the
pairing evidence lives at level six.

`SDF-PIN-03` is **CLOSED** — this run — and is `selfDual_eigen_pin_level_four_weight_four_eta`,
declared in section `SdfPin03` at the END of this module:

```
η(-1/(4z))² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))²  =  16 · z⁴ · (η(z)² · η(2z)⁴ · η(4z)²)
```

the `(N, r, k) = (4, rPinLevelFourWeightFour, 4)` instance of `SDF-05`, i.e.
`f = η(z)²·η(2z)⁴·η(4z)²`.  It is the second η-unfolded statement in this file after `SDF-PIN-02`,
and the first at `N > 2`, at EVEN weight, and on a NON-CONSTANT exponent vector — that last is the
degeneracy `selfDual_eigen_pin_level_two_no_evidence_pairing` records, so this is the first
η-unfolded pin in the file carrying evidence about the divisor PAIRING.

READ ITS LIMITATION BEFORE CITING IT.  At this instance the LEVEL and the WEIGHT are the SAME
NUMBER, `N = 4 = k`, so a constant that had swapped them reads `16` either way and is INVISIBLE
here (`selfDual_eigen_pin_level_four_weight_four_no_evidence_level_weight`).  That is why the
section carries two further η-unfolded companions rather than the node alone:
`selfDual_eigen_pin_level_nine_weight_four_eta` (`N = 9`, `k = 4`, `λ = 81`, where `√(N^k) = 81` but
`√(k^N) = 512`) moves the level at fixed weight, and
`selfDual_eigen_pin_level_four_weight_two_eta` (`N = 4`, `k = 2`, `λ = -4`, NEGATIVE, so `i^{-k}` is
visible) moves the weight at fixed level.  Neither alone breaks the degeneracy.

The section also carries the `N = 1`, `r ≡ 24`, `k = 12` CALIBRATION
(`selfDual_eigen_pin_level_one_eta_calibration`), which re-derives — along this file's
`SDF-05`/`SDF-04`/`SDF-03`/`SDF-02` route — the statement `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`) proves independently and without self-duality anywhere;
`..._agrees` makes that a build obligation rather than a docstring claim.  The degenerate `r ≡ 0`
case is `selfDual_eigen_pin_level_four_zero_exp`, stated at the NODE'S OWN level so that it
certifies that the `16` comes from the exponents and not from the level.

All forty declarations of section `SdfPin03` are `sorry`-free and each has a `#print axioms`
guard in `SocrateAI.FinalCheck` (section `SdfPin03`); must-fail control
`verification/SdfPin03NegControl.lean`.

`SDF-PIN-04` is **CLOSED** — this run — and is `selfDual_eigen_pin_level_four_weight_zero_eta`,
declared in section `SdfPin04` at the END of this module:

```
η(-1/(4z))⁻² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))⁻²  =  η(z)⁻² · η(2z)⁴ · η(4z)⁻²
```

the `(N, r, k) = (4, rPinLevelFourWeightZero, 0)` instance of `SDF-05`, i.e.
`f = η(2z)⁴ / (η(z)² η(4z)²)`, which at `k = 0` and `λ = 1` is literally INVARIANT under the Fricke
involution.  It is the fourth η-unfolded statement in this file, the FIRST with NEGATIVE exponents
(`..._evidence_negative_exponents` — `selfDual_eigen_pin_level_four_neg` has them but is stated on
`etaQuotient`), and the first whose radicand is `s = 2⁴ · 4⁻² = 1` by CANCELLATION rather than
because every factor is separately `1` (`..._evidence_radicand_cancels`; contrast
`selfDual_eigen_pin_level_four_zero_exp`, the `r ≡ 0` pin at the same level — the two vectors are
different, `rPinLevelFourWeightZero_ne_zero_pin`).  It carries pairing evidence
(`..._evidence_pairing`, `r 1 = -2 ≠ 4 = r 2`), with the same-weight mis-paired negative control
`not_selfDual_pin_level_four_weight_zero_mispaired`.

READ ITS LIMITATION BEFORE CITING IT — this one is severe.  At `k = 0` EVERY component of
`λ = i^{-k} · N^k · s^{-1/2}` collapses to `1` for a reason that survives any misspelling:
`i^{-0} = i^{+0}`, `4⁰ = 9⁰`, `(√s)⁻¹ = √s`, `z⁰ = 1`
(`selfDual_eigen_pin_level_four_weight_zero_no_evidence_constant`).  **`SDF-PIN-04` pins NO
component of the constant** and must not be counted among this arc's constant-pinning instances;
those are `selfDual_eigen_pin_level_six` (`λ = 46656`), `selfDual_eigen_pin_level_four_neg`
(`λ = -2i`), `selfDual_eigen_pin_level_two_eta` (`λ = -i√2`) and
`selfDual_eigen_pin_level_four_weight_two_eta` (`λ = -4`).  The same accounting
`selfDual_pin_level_one_no_evidence_*` gives the `N = 1` pin.

The section discharges the three named regimes BEFORE the node, as one build obligation
(`selfDual_eigen_pin_level_four_weight_zero_regime_battery`: the `N = 1` calibration against
`eta_S_via_fricke`, the `r ≡ 0` case at the node's own level, and the `N = 9`, `k = 4` non-constant
instance), and proves the node TWICE — once through `SDF-05`'s packaged `frickeEigenvalue 4 0`
and once straight from `etaQuotient_fricke` (`F3.2-A7`) with the raw constant evaluated in place
(`..._eta_via_fricke`), paired as a build obligation by `..._routes_agree`.

All twenty-three declarations of section `SdfPin04` are `sorry`-free and each has a `#print axioms`
guard in `SocrateAI.FinalCheck` (section `SdfPin04`); must-fail control
`verification/SdfPin04NegControl.lean`.

TRIPWIRE RECEIPT.  The INVERTED tripwire in `FinalCheck` section `SdfDef01`, which asserted that
`etaQuotient_fricke_selfDual` depends on `sorryAx`, has been INVERTED BACK in the same commit that
discharged this node — it is gone, replaced by the ordinary positive guard in the new section
`Sdf05`.  The matching tripwire for `etaQuotient_fricke_selfDual_raw` was inverted one run earlier,
and that theorem's guard lives in section `Sdf04`.  No inverted tripwire for any `SDF-*` node
remains.
-/
import SocrateAI.ModularForms.EtaQuotientModularity

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm Complex
open UpperHalfPlane hiding I
open scoped MatrixGroups Real

local notation "ℍₒ" => UpperHalfPlane.upperHalfPlaneSet

/-! ### `SDF-DEF-01` — the self-dual (Fricke-symmetric) condition -/

/-- **`SDF-DEF-01`.**  An exponent vector is *Fricke-self-dual* at level `N` when it takes the
same value at `δ` and at `N / δ` for every divisor `δ` of `N`.

This is exactly the condition under which the dual vector `δ ↦ r (N / δ)` appearing on the
right-hand side of `etaQuotient_fricke` agrees with `r` on `N.divisors`, hence (by
`etaQuotient_congr_divisors`) defines the same eta quotient.

Stated as a **bounded** `∀ δ ∈ N.divisors`, matching how `EtaExp` is read everywhere else in
this library (`etaQuotientH_congr`, `EtaExp.sum_divisors_congr`): the values of `r` off
`N.divisors` are junk and must not be constrained.

NOT called `IsBalanced`: see this file's header — `balanced` is already taken in
`EtaQuotientModularity.lean` by the unrelated `Int.bmod` lemma `exists_balanced_add`
(`F3.2-B1`).

DECIDABILITY: `SDF-16` (`decidableIsFrickeSelfDual`, at the END of this file) registers the
`Decidable` instance for this predicate, so bare `decide` closes self-duality goals.  It is
ERGONOMICS ONLY — every `selfDual_cond_pin_*` below predates it and discharges by
`unfold IsFrickeSelfDual; decide`, needing no instance, and non-vacuity is `not_selfDual_pin_*`,
not `SDF-16`.  It is declared at the end rather than here so that nothing above it depends on it. -/
def IsFrickeSelfDual (N : ℕ) (r : EtaExp) : Prop := ∀ δ ∈ N.divisors, r δ = r (N / δ)

/-! ### `SDF-DEF-02` — the closed-form Fricke eigenvalue -/

/-- **`SDF-DEF-02`.**  The Fricke eigenvalue `λ = i^{-k} · N^{k/2}` of a self-dual eta quotient
of level `N` and weight `k`.

Written with a **real** square root of the positive real `N^k`, so no complex square root and no
branch choice is ever involved — contrast `Complex.sqrt`, which `etaQuotient_fricke`'s proof uses
internally and which this file never touches.

Note what is absent: the exponent vector.  That is the entire point of self-duality — the
constant of `etaQuotient_fricke` depends on `r` only through `∏_{δ ∣ N} δ^{r δ}`, and
`prod_zpow_selfDual` forces that product to be `N^k`.

This is the **unnormalised** eigenvalue, attached to `f(-1/(Nz)) = λ · z^k · f(z)`.  The
classically normalised eigenvalue (a root of unity) is `i^{-k}`, and appears in
`etaQuotient_fricke_selfDual_normalized`. -/
noncomputable def frickeEigenvalue (N : ℕ) (k : ℤ) : ℂ :=
  I ^ (-k) * ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ)

/-! #### `SDF-DEF-02` value pins — the eigenvalue ALONE, computed before anything consumes it

These are the pins that close `SDF-DEF-02`.  They constrain **only** `frickeEigenvalue`: no eta
quotient, no exponent vector, no `IsFrickeSelfDual` hypothesis appears in any of them.  That
separation is deliberate.  The five `SDF-05` pins further down (`selfDual_pin_level_one` and
friends) also assert eigenvalue values, but they do so as one conjunct of a five-part statement
whose other conjuncts needed `SDF-05` before it closed — `SDF-05` is now proved, so those five
conjunctions are sorry-free too, but at the time this section was written they were not, and this
paragraph is kept to explain why the pins here exist as their own standalone, dependency-free
statements rather than being folded into the five-part conjunctions. The pins here are the same
numbers stated standalone, and are `sorry`-free.

Every value was computed by hand FIRST and only then written as a Lean statement:

| `N` | `k` | `i^{-k}` | `√(N^k)` | `frickeEigenvalue N k` |
|-----|-----|----------|----------|------------------------|
| 1   | 12  | `1`      | `√1 = 1` | `1`                    |
| 6   | 12  | `1`      | `√(6¹²) = 6⁶ = 46656` | `46656`   |
| 6   | 0   | `1`      | `√1 = 1` | `1`                    |
| 2   | 1   | `-i`     | `√2`     | `-(i·√2)`              |
| 1   | 2   | `-1`     | `√1 = 1` | `-1`                   |
| 6   | -12 | `1`      | `√(6⁻¹²) = 1/46656` | `1/46656`   |

`6⁶ = 46656` and `46656² = 2176782336 = 6¹²` in exact integer arithmetic.

The six span the regimes this run's discipline requires: the `N = 1`, `k = 12` case underlying the
already sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`); a genuine `N > 1` level
carrying the self-dual vector `(1, 11, 11, 1)`; the degenerate `k = 0` case; and — because a sign
or branch error would survive all three of those — an ODD weight, where the eigenvalue is
imaginary, a `k ≡ 2 (mod 4)` weight, where it is `-1`, and a NEGATIVE weight, where the radicand
is a proper fraction.

The `√` values are re-derived here from `Real.sqrt_sq`, NOT imported from `SDF-03`'s
`sqrt_natPow_level_six`.  A pin that reused the lemma it is meant to be independent evidence for
would be worth nothing. -/

section SdfDef02Pins

/-- `i^{-12} = 1`: `12 = 4·3` and `i⁴ = 1`.  Stated at an INTEGER exponent (`zpow`), which is how
`frickeEigenvalue` uses it — `Complex.I_pow_four` is about `ℕ` powers and does not apply directly. -/
theorem I_zpow_neg_twelve : (I : ℂ) ^ (-12 : ℤ) = 1 := by
  rw [show (-12 : ℤ) = -((12 : ℕ) : ℤ) by norm_num, _root_.zpow_neg, zpow_natCast,
      show (12 : ℕ) = 4 * 3 from by norm_num, pow_mul, Complex.I_pow_four, one_pow, inv_one]

/-- `i^{12} = 1`.  Needed for the NEGATIVE-weight pin, where `frickeEigenvalue N (-12)` produces
`i^{-(-12)} = i^{12}` and the exponent is positive. -/
theorem I_zpow_twelve : (I : ℂ) ^ (12 : ℤ) = 1 := by
  rw [show (12 : ℤ) = ((12 : ℕ) : ℤ) by norm_num, zpow_natCast,
      show (12 : ℕ) = 4 * 3 from by norm_num, pow_mul, Complex.I_pow_four, one_pow]

/-- `i^{-2} = -1`.  THE SIGN PIN: this is the value that makes `frickeEigenvalue 1 2 = -1`, and
the one a mis-signed exponent (`i^{k}` in place of `i^{-k}`) cannot fake, since `i^{2} = -1` too —
see `frickeEigenvalue_pin_not_one` for the control that does catch a dropped factor. -/
theorem I_zpow_neg_two : (I : ℂ) ^ (-2 : ℤ) = -1 := by
  rw [show (-2 : ℤ) = -((2 : ℕ) : ℤ) by norm_num, _root_.zpow_neg, zpow_natCast, Complex.I_sq]
  norm_num

/-- `i^{-1} = -i`.  The ODD-weight case, where the eigenvalue leaves the reals entirely. -/
theorem I_zpow_neg_one : (I : ℂ) ^ (-1 : ℤ) = -I := by
  rw [_root_.zpow_neg_one, Complex.inv_I]

/-- **`SDF-DEF-02` PIN A — `N = 1`, `k = 12`.**  `i^{-12} = 1` and `√(1¹²) = 1`, so `λ = 1`.

This is the instance underlying the already sorry-free `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`), where `η(-1/z)²⁴ = z¹² η(z)²⁴` carries NO constant — i.e. the
eigenvalue there is exactly `1`, which is what this pin asserts.  That agreement is the whole
point of the pin: `SDF-DEF-02` is not free to be any closed form, it must reproduce the constant
Mathlib and this library already prove at `N = 1`.

DEGENERATE IN ONE DIRECTION: at `N = 1` the modulus `√(N^k)` is `1` for every `k`, so this pin
tests the `i^{-k}` factor and nothing about the `N^{k/2}` factor.  PIN B does the latter. -/
theorem frickeEigenvalue_pin_level_one : frickeEigenvalue 1 12 = 1 := by
  rw [frickeEigenvalue, I_zpow_neg_twelve, Nat.cast_one, _root_.one_zpow, Real.sqrt_one]
  norm_num

/-- **`SDF-DEF-02` PIN B — `N = 6`, `k = 12`.  THE LOAD-BEARING PIN.**  `λ = 1 · √(6¹²) = 6⁶ =
46656`.

This is the level and weight of `rPinSix = (1, 11, 11, 1)`, the genuine `N > 1` self-dual vector
with non-constant entries used throughout this file, and `∏_{δ ∣ 6} δ^{r δ} = 2176782336 = 6¹²` is
already pinned sorry-free by `prod_zpow_pin_level_six_value`.  So this pin and that one meet: the
`SDF-03` constant `N^k · s^{-1/2} = 6¹² / 46656 = 46656` is `fricke_const_pin_level_six`, also
sorry-free, and it agrees with the value asserted here.  `SDF-DEF-02` and `SDF-03` are independent
nodes; that they land on the same number at this instance is the cross-check.

A closed form that had dropped the square root would give `6¹² = 2176782336` here — see
`frickeEigenvalue_pin_not_natPow`. -/
theorem frickeEigenvalue_pin_level_six : frickeEigenvalue 6 12 = 46656 := by
  rw [frickeEigenvalue, I_zpow_neg_twelve, one_mul,
      show (((6 : ℕ) : ℝ) ^ (12 : ℤ)) = (46656 : ℝ) ^ 2 by norm_num,
      Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 46656)]
  norm_num

/-- **`SDF-DEF-02` PIN C — the degenerate weight `k = 0`, at `N = 6`.**  `i^{0} = 1` and
`√(6⁰) = √1 = 1`, so `λ = 1`.

This is the eigenvalue attached to the degenerate exponent vector `r ≡ 0` (whose weight is
`k = 0`, pinned by `zeroExp_weight_level_six`).  DEGENERATE BY CONSTRUCTION: `k = 0` kills both
factors at once, so a closed form that accidentally proved only `k = 0` would still pass here.  It
is a floor certifying the definition is not mis-indexed into something undefined at `k = 0` — not
evidence about the exponents. -/
theorem frickeEigenvalue_pin_zero_weight : frickeEigenvalue 6 0 = 1 := by
  rw [frickeEigenvalue, neg_zero, zpow_zero, zpow_zero, Real.sqrt_one]
  norm_num

/-- **`SDF-DEF-02` PIN D — ODD WEIGHT: `N = 2`, `k = 1`.**  `λ = i^{-1} · √2 = -(i·√2)`, which is
NOT real.

This is the level and weight of `rPinTwo = (1, 1)`, i.e. `f = η(z)·η(2z)`, whose Fricke behaviour
is already pinned sorry-free upstream by `fricke_level_two_pin`
(`EtaQuotientModularity.lean:2285`).  It is the only pin here whose value leaves `ℝ`, and it is
the one that fails if `i^{-k}` is transcribed as `i^{k}` (that would give `+i·√2`) or dropped
(that would give `√2`).  Note `√2` is left symbolic: it is irrational, and pinning it to a decimal
would be a false precision. -/
theorem frickeEigenvalue_pin_level_two_weight_one :
    frickeEigenvalue 2 1 = -(I * ((Real.sqrt 2 : ℝ) : ℂ)) := by
  rw [frickeEigenvalue, I_zpow_neg_one, zpow_one, Nat.cast_ofNat]
  ring

/-- **`SDF-DEF-02` PIN E — `k ≡ 2 (mod 4)`: `N = 1`, `k = 2`.**  `λ = i^{-2} · √1 = -1`.

THE SIGN PIN.  Every other pin in this section has a value in `{1, 46656, 1/46656, -i√2}`, none of
which distinguishes `-1` from `1`; this one does.  It is the instance `SDF-09` and `SDF-13` are
about (the eigenvalue is `-1` exactly when `k % 4 = 2` and `N = 1`), both now CLOSED.  This was the
only machine-checked evidence in the file that `frickeEigenvalue` ever takes the value `-1` until
`SDF-13` closed and added a second, at the NEGATIVE weight `k = -2`
(`frickeEigenvalue_pin_level_one_weight_neg_two`); this line said "both still open" until then. -/
theorem frickeEigenvalue_pin_neg_one : frickeEigenvalue 1 2 = -1 := by
  rw [frickeEigenvalue, I_zpow_neg_two, Nat.cast_one, _root_.one_zpow, Real.sqrt_one]
  norm_num

/-- **`SDF-DEF-02` PIN F — NEGATIVE WEIGHT: `N = 6`, `k = -12`.**  `λ = i^{12} · √(6⁻¹²) =
1/46656`.

The radicand is a proper fraction, `1/2176782336`.  A closed form that had silently assumed
`k ≥ 0` — a `k.toNat` anywhere, or `pow_pos` in place of `zpow_pos` — is FALSE here.  This is the
weight of `rPinLevelSixNeg = (-1, -11, -11, -1)`, whose product is pinned sorry-free by
`prod_zpow_pin_level_six_neg`, and whose constant is `fricke_const_pin_level_six_neg`. -/
theorem frickeEigenvalue_pin_level_six_neg : frickeEigenvalue 6 (-12) = (46656 : ℂ)⁻¹ := by
  rw [frickeEigenvalue, neg_neg, I_zpow_twelve, one_mul,
      show (((6 : ℕ) : ℝ) ^ (-12 : ℤ)) = ((46656 : ℝ)⁻¹) ^ 2 by norm_num,
      Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ (46656 : ℝ)⁻¹)]
  norm_num

/-- **`SDF-DEF-02` NEGATIVE CONTROL 1 — the square root is load-bearing.**

`etaQuotient_fricke`'s constant contains `N^k · s^{-1/2}`, and `SDF-03` collapses it to `√(N^k)`,
NOT to `N^k`.  Those are different numbers: at `N = 6`, `k = 12` the eigenvalue is `46656 = 6⁶`
while `N^k = 2176782336 = 6¹²`.  A definition of `frickeEigenvalue` that had dropped the square
root — reading the exponent as `k` rather than `k/2` — would be FALSE here.  Without this control
PIN B alone cannot tell the two apart, since it only asserts a value and does not say what the
value is NOT. -/
theorem frickeEigenvalue_pin_not_natPow : frickeEigenvalue 6 12 ≠ 2176782336 := by
  rw [frickeEigenvalue_pin_level_six]; norm_num

/-- **`SDF-DEF-02` NEGATIVE CONTROL 2 — the root-of-unity factor is load-bearing.**

At `N = 1`, `k = 2` the modulus `√(N^k)` is `1`, so a definition that had dropped `i^{-k}`
altogether would give `1` here.  The true value is `-1`.  This is the control that PIN A cannot
provide: PIN A's value is `1`, which is exactly what a dropped factor would also produce. -/
theorem frickeEigenvalue_pin_not_one : frickeEigenvalue 1 2 ≠ 1 := by
  rw [frickeEigenvalue_pin_neg_one]; norm_num

/-- **`SDF-DEF-02` NON-VACUITY — the eigenvalue genuinely depends on the level.**

`frickeEigenvalue 6 12 = 46656 ≠ 1 = frickeEigenvalue 1 12` at the SAME weight, so the definition
is not constant in `N` and has not collapsed to something trivial.  The `SDF-*` block's headline
would be far weaker if the "eigenvalue" turned out to be `1` in every case a self-dual vector
exists. -/
theorem frickeEigenvalue_pin_nonconstant :
    frickeEigenvalue 6 12 ≠ frickeEigenvalue 1 12 := by
  rw [frickeEigenvalue_pin_level_six, frickeEigenvalue_pin_level_one]; norm_num

end SdfDef02Pins

/-! ### Pins — stated BEFORE the general lemmas, values computed independently

Each pin below fixes a concrete `(N, r, k)` and asserts, as separate conjuncts, (a) that `r` is
self-dual, (b) the weight normalisation `∑ r δ = 2k`, (c) the value of the Fricke constant
`∏_{δ ∣ N} δ^{r δ}` and its claimed collapse to `N^k`, and (d) the value of `frickeEigenvalue`.
Every number was computed first, by hand and by exact rational arithmetic, and only then written
as a Lean statement.  A proof that cannot close a pin means the general statement is wrong.

The pins deliberately span the three regimes named in this run's discipline: the level-one case
that must reduce to the already-pinned `Δ = η²⁴` behaviour; a genuine `N > 1` self-dual vector
with **non-constant** entries; and the degenerate `r ≡ 0`.  Two further pins exercise the parts
a sign error would corrupt: an odd weight (where `i^{-k}` is imaginary) and `k ≡ 2 mod 4` (where
the eigenvalue is `-1`). -/

section Pins

/-- Level-one weight-12 exponent vector `r = (24)`, i.e. `Δ = η²⁴`. -/
def rPinOne : EtaExp := fun δ => if δ = 1 then (24 : ℤ) else 0

/-- Level-six weight-12 self-dual exponent vector `r = (1, 11, 11, 1)` on `(1, 2, 3, 6)`.
Genuinely non-constant, and genuinely `N > 1`. -/
def rPinSix : EtaExp := fun δ => if δ = 1 ∨ δ = 6 then (1 : ℤ) else if δ = 2 ∨ δ = 3 then 11 else 0

/-- Level-two weight-1 exponent vector `r = (1, 1)`, i.e. `f = η(z)η(2z)`. -/
def rPinTwo : EtaExp := fun δ => if δ = 1 ∨ δ = 2 then (1 : ℤ) else 0

/-- Level-one weight-2 exponent vector `r = (4)`, i.e. `f = η⁴`.  The `λ = -1` pin. -/
def rPinFour : EtaExp := fun δ => if δ = 1 then (4 : ℤ) else 0

/-- Level-two NON-self-dual exponent vector `r = (2, 0)`, the negative control. -/
def rPinAsym : EtaExp := fun δ => if δ = 1 then (2 : ℤ) else 0

/-- Level-six exponent vector `r = (1, 11, 1, 11)` on `(1, 2, 3, 6)` — the MIS-PAIRING control.
Same weight normalisation as `rPinSix` (`∑ r δ = 24`), and self-dual under the *wrong* involution
`1 ↔ 3`, `2 ↔ 6`, but NOT under the correct `δ ↔ 6/δ`.  See `not_selfDual_pin_mispaired`. -/
def rPinSixMispaired : EtaExp :=
  fun δ => if δ = 1 ∨ δ = 3 then (1 : ℤ) else if δ = 2 ∨ δ = 6 then 11 else 0

/-- Level-four weight-1 self-dual exponent vector `r = (-2, 6, -2)` on `(1, 2, 4)`.

The only vector in this file with **negative** entries, and the only level with a divisor that is
its own dual at `N > 1` (`4 / 2 = 2`).  It exists for `SDF-02`: every other pin there has
non-negative exponents, so the product is a plain integer and `zpow` never has to invert anything;
here `∏ δ^{r δ} = 1⁻² · 2⁶ · 4⁻² = 64/16 = 4 = 4¹ = N^k`, which passes through `(4 : ℝ)⁻²` and so
actually exercises the `zpow_pos` positivity step the general proof needs.  Computed outside Lean
first, in exact rational arithmetic this session. -/
def rPinLevelFourNeg : EtaExp :=
  fun δ => if δ = 1 ∨ δ = 4 then (-2 : ℤ) else if δ = 2 then 6 else 0

/-- Level-six **negative-weight** self-dual exponent vector `r = (-1, -11, -11, -1)` on
`(1, 2, 3, 6)` — the entrywise negation of `rPinSix`, with `∑ r δ = -24 = 2 · (-12)`, i.e. `k = -12`.

It exists for `SDF-03`, and is the only vector in this file with a **negative weight**.  Every other
pin has `k ≥ 0`, so `N^k` is an integer and `√(N^k)` is an integer; here `N^k = 6⁻¹² = 1/2176782336`
is a proper fraction and `√(N^k) = 1/46656`.  A statement of `SDF-03` that had silently assumed
`k ≥ 0` — writing `k.toNat` anywhere, or deriving positivity of `N^k` from `pow_pos` rather than
`zpow_pos` — would still satisfy every other pin in this file while being wrong here.  Computed
outside Lean first, in exact rational arithmetic this session. -/
def rPinLevelSixNeg : EtaExp :=
  fun δ => if δ = 1 ∨ δ = 6 then (-1 : ℤ) else if δ = 2 ∨ δ = 3 then -11 else 0

/-! #### `SDF-DEF-01` decide-pins — the CONDITION only, computed before any proof

These six pins fix `IsFrickeSelfDual` itself, separately from the eigenvalue arithmetic, and are
what closes `SDF-DEF-01`.  Every value was computed first outside Lean (exact integer arithmetic,
this session: `divisors 1 = [1]`, `divisors 2 = [1,2]`, `divisors 6 = [1,2,3,6]`; the dual vectors
printed alongside the originals) and only then asserted here.  They are discharged by `decide`,
which adds **no** axiom to the footprint — `native_decide` would add `Lean.ofReduceBool` and is
deliberately not used, matching `DedekindSum.lean`'s convention.

The three regimes this run's discipline requires are covered by the first three, and the two
degenerate ones are labelled as degenerate so they are not mistaken for evidence they cannot give:
`N = 1` and `r ≡ 0` make `IsFrickeSelfDual` true for trivial reasons, so only
`selfDual_cond_pin_level_six` — `N > 1` with a genuinely non-constant vector — can detect a wrong
`δ ↔ N/δ` pairing.  `rPinSix_nonconstant` is the machine-checked witness that it is non-constant,
and `not_selfDual_pin_asymmetric` below is the negative control. -/

/-- **`SDF-DEF-01` PIN A — level one, `r = (24)` (`Δ = η²⁴`).**  `divisors 1 = {1}` and `1 / 1 = 1`,
so `r 1 = 24 = r (1/1)`.

DEGENERATE BY CONSTRUCTION, recorded so it is not oversold: at `N = 1` the only divisor is its own
dual, so `IsFrickeSelfDual 1 r` holds for **every** `r`.  This pin therefore checks that the
definition elaborates and reduces at the `(N, r, k) = (1, 24, 12)` instance underlying the already
sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`); it does **not** test the
self-duality condition itself. -/
theorem selfDual_cond_pin_level_one : IsFrickeSelfDual 1 rPinOne := by
  unfold IsFrickeSelfDual
  decide

/-- **`SDF-DEF-01` PIN B — level six, `r = (1, 11, 11, 1)` on `(1, 2, 3, 6)`.  THE LOAD-BEARING PIN.**
Computed first outside Lean: the divisor involution `δ ↦ 6/δ` pairs `1 ↔ 6` and `2 ↔ 3`, the vector
reads `[1, 11, 11, 1]` on `[1, 2, 3, 6]` and its dual reads `[1, 11, 11, 1]` — equal, so self-dual.

This is the only pin with `N > 1` **and** a non-constant exponent vector (see
`rPinSix_nonconstant`), hence the only one here that a wrong `δ ↔ N/δ` pairing could fail: had the
definition been written `r δ = r (N * δ)`, or the involution mis-paired as `2 ↔ 6`, this pin would
be false while PINs A, C, D, E stayed true. -/
theorem selfDual_cond_pin_level_six : IsFrickeSelfDual 6 rPinSix := by
  unfold IsFrickeSelfDual
  decide

/-- `rPinSix` is genuinely non-constant — `r 1 = 1` while `r 2 = 11`.  Without this,
`selfDual_cond_pin_level_six` could be passing for the trivial reason that a constant vector is
self-dual at every level, which is exactly the degeneracy PINs A and C already have. -/
theorem rPinSix_nonconstant : rPinSix 1 ≠ rPinSix 2 := by decide

/-- **`SDF-DEF-01` PIN C — the degenerate vector `r ≡ 0` at level six.**  Every value and every
dual value is `0`, so the condition holds factor by factor, definitionally.

DEGENERATE BY CONSTRUCTION: true for every `N`.  It is a floor — it certifies that the predicate is
not accidentally *empty* (e.g. by a mis-stated binder that no `r` could satisfy) — and it is not
evidence about the involution.  Proved by `rfl` under the binder rather than by `decide`, since
`(0 : EtaExp) δ = 0` holds definitionally at every `δ`. -/
theorem selfDual_cond_pin_zero_exp : IsFrickeSelfDual 6 (0 : EtaExp) := fun _ _ => rfl

/-- **`SDF-DEF-01` PIN D — level two, `r = (1, 1)`, i.e. `f = η(z)·η(2z)`.**  `divisors 2 = {1, 2}`,
`2/1 = 2` and `2/2 = 1`, and the vector is constant on them, so it is its own dual.

Cross-check against already-proved material: `fricke_level_two_pin`
(`EtaQuotientModularity.lean:2285`, sorry-free) is stated at this same exponent vector, and its
docstring independently records that "the exponent vector is its own dual" — which is precisely
what this pin now machine-checks through the new definition. -/
theorem selfDual_cond_pin_level_two_weight_one : IsFrickeSelfDual 2 rPinTwo := by
  unfold IsFrickeSelfDual
  decide

/-- **`SDF-DEF-01` PIN E — level one, `r = (4)`, i.e. `f = η⁴`.**  Degenerate in the same way as
PIN A (`N = 1`); kept because PIN 5 below, the eigenvalue sign pin, is stated at this vector and
its self-duality conjunct should not have to be re-derived there. -/
theorem selfDual_cond_pin_level_one_weight_two : IsFrickeSelfDual 1 rPinFour := by
  unfold IsFrickeSelfDual
  decide

/-- **`SDF-DEF-01` MIS-PAIRING CONTROL — the sharpest negative test in this file.**
`r = (1, 11, 1, 11)` on `(1, 2, 3, 6)` is NOT Fricke-self-dual at level six.

Why this and not only `not_selfDual_pin_asymmetric`: this vector carries the SAME weight
normalisation as `rPinSix` (`∑ r δ = 24 = 2·12`), and it IS invariant under the *wrong* involution
`1 ↔ 3`, `2 ↔ 6`.  Computed outside Lean first: under `δ ↦ 6/δ` the vector reads `[1, 11, 1, 11]`
while its dual reads `[11, 1, 11, 1]` — different at every divisor; under the mis-pairing both read
`[1, 11, 1, 11]`.  So a definition that had transposed the divisor involution would prove this
statement's negation, and would still satisfy every positive pin above.  Together with
`selfDual_cond_pin_level_six` this brackets the pairing from both sides. -/
theorem not_selfDual_pin_mispaired : ¬ IsFrickeSelfDual 6 rPinSixMispaired := by
  unfold IsFrickeSelfDual
  decide

/-- **PIN 1 — level one, weight 12 (`Δ = η²⁴`).**  Hand computation, this session:
`divisors 1 = {1}`, `∑ r δ = 24 = 2·12`, `∏ δ^{r δ} = 1^24 = 1 = 1^12 = N^k`, and
`λ = i^{-12}·√1 = (i⁴)^{-3} = 1`.  Cross-check: `η(-1/z)²⁴ = (√(-iz))²⁴ η(z)²⁴ = z^12 η(z)²⁴`,
which is Mathlib's `discriminant_S_invariant`.

This is EXACTLY the instantiation `(N, r, k) = (1, fun _ => 24, 12)` of the already-proved
`eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`, sorry-free, and re-derived there a second
time from Mathlib's own `discriminant_S_invariant` in the `example` beside it).  So this pin is
not an independent computation of the eta identity — it is the check that `frickeEigenvalue` and
`IsFrickeSelfDual`, the two NEW definitions of this file, reproduce a value already established
upstream by two independent routes. -/
theorem selfDual_pin_level_one :
    IsFrickeSelfDual 1 rPinOne
      ∧ (∑ δ ∈ (1 : ℕ).divisors, rPinOne δ) = 2 * 12
      ∧ (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) = 1
      ∧ (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) = ((1 : ℕ) : ℝ) ^ (12 : ℤ)
      ∧ frickeEigenvalue 1 12 = 1 := by
  -- ASSEMBLY, not new mathematics: the self-duality conjunct is `selfDual_cond_pin_level_one`
  -- above, the eigenvalue conjunct is `SDF-DEF-02`'s `frickeEigenvalue_pin_level_one` (proved
  -- there from `Real.sqrt_one` and `I_zpow_neg_twelve`, so `SDF-07` turned out not to be needed),
  -- and the two product conjuncts are the same `divisors 1 = {1}` computation twice, against the
  -- literal `1` and against the closed form `N^k = 1^12`.  Those two are stated separately on
  -- purpose, so the literal and the closed form must AGREE rather than being one claim written
  -- twice; they are re-derived here rather than imported from `prod_zpow_pin_level_one`, which is
  -- declared further down the file and is therefore out of scope at this point.
  refine ⟨selfDual_cond_pin_level_one, by decide, ?_, ?_, frickeEigenvalue_pin_level_one⟩
  · rw [show (1 : ℕ).divisors = {1} from by decide]; norm_num [rPinOne]
  · rw [show (1 : ℕ).divisors = {1} from by decide]; norm_num [rPinOne]

/-- **PIN 2 — level six, weight 12, genuinely non-constant self-dual vector.**  Exact rational
arithmetic, this session: `divisors 6 = {1, 2, 3, 6}`, `r = (1, 11, 11, 1)`, self-dual because
`1 ↔ 6` and `2 ↔ 3` are the two `δ ↔ 6/δ` orbits.  `∑ r δ = 1 + 11 + 11 + 1 = 24 = 2·12`.
`∏ δ^{r δ} = 1^1 · 2^11 · 3^11 · 6^1 = 6^11 · 6 = 6^12 = 2176782336`, which is `N^k` on the nose.
`λ = i^{-12} · √(6^12) = 1 · 6^6 = 46656`.

This is the pin that carries the run: it is the only one where `N > 1` **and** the exponent
vector is non-constant, so it is the only one that could detect a wrong pairing `δ ↔ N/δ`, and
the only one where `∏ δ^{r δ} = N^k` is a non-trivial arithmetic coincidence rather than
`1 = 1`. -/
theorem selfDual_pin_level_six :
    IsFrickeSelfDual 6 rPinSix
      ∧ (∑ δ ∈ (6 : ℕ).divisors, rPinSix δ) = 2 * 12
      ∧ (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) = 2176782336
      ∧ (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) = ((6 : ℕ) : ℝ) ^ (12 : ℤ)
      ∧ frickeEigenvalue 6 12 = 46656 := by
  -- ASSEMBLY.  The two product conjuncts are the same computation against, respectively, the
  -- LITERAL `2176782336` and the closed form `6^12`; they must agree, which is the whole point of
  -- stating both.  Both were computed outside Lean first (`1^1 · 2^11 · 3^11 · 6^1`).
  refine ⟨selfDual_cond_pin_level_six, by decide, ?_, ?_, frickeEigenvalue_pin_level_six⟩
  · rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]; norm_num [rPinSix]
  · rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]; norm_num [rPinSix]

/-- **PIN 3 — the degenerate vector `r ≡ 0` at level six, weight 0.**  Trivially self-dual;
`∑ r δ = 0 = 2·0`; `∏ δ^0 = 1 = 6^0 = N^k`; `λ = i^0 · √(6^0) = 1`.  The eta quotient itself is
the constant `1` and the relation reads `1 = 1·z^0·1`.

Kept because it is the one case where the *statement* could be vacuous in a way the other pins
cannot see: `k = 0` makes `z^k` disappear and `N^k` collapse for every `N`, so any lemma that
accidentally proves only `k = 0` still passes here.  It is a floor, not a ceiling. -/
theorem selfDual_pin_zero_exp :
    IsFrickeSelfDual 6 (0 : EtaExp)
      ∧ (∑ δ ∈ (6 : ℕ).divisors, (0 : EtaExp) δ) = 2 * 0
      ∧ (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ ((0 : EtaExp) δ)) = 1
      ∧ (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ ((0 : EtaExp) δ)) = ((6 : ℕ) : ℝ) ^ (0 : ℤ)
      ∧ frickeEigenvalue 6 0 = 1 := by
  -- ASSEMBLY.  No arithmetic: every exponent is `0`, so both product conjuncts are `∏ δ^0 = 1`.
  refine ⟨selfDual_cond_pin_zero_exp, by decide, ?_, ?_, frickeEigenvalue_pin_zero_weight⟩
  · rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]; norm_num
  · rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]; norm_num

/-- **PIN 4 — odd weight: `f = η(z)η(2z)` at level two, weight 1.**  Exact Gaussian-rational
check, this session.  `divisors 2 = {1,2}`, `r = (1,1)`, self-dual, `∑ r δ = 2 = 2·1`,
`∏ δ^{r δ} = 1·2 = 2 = 2^1 = N^k`, and `λ = i^{-1}·√2 = -i√2`.

Verified independently at the point `z = i`, from `η(-1/w) = √(-iw)·η(w)`:
`f(-1/(2i)) = √(-2i·i)·√(-i·i)·f(i) = √2 · 1 · f(i)`, while `λ·z^1 = (-i√2)·i = √2`.  Agreement.

This is the only pin with `k` odd, hence the only one where `i^{-k}` is not real; a lost or
conjugated `i` is invisible to every other pin here.

CROSS-CHECK AGAINST AN ALREADY-PROVED PIN: `fricke_level_two_pin`
(`EtaQuotientModularity.lean:2285`, sorry-free) is this same instantiation stated through the raw
constant, `η(-1/(2z))·η(-1/z) = i⁻¹·2·(√2)⁻¹·z·η(z)η(2z)`, and `i⁻¹·2·(√2)⁻¹ = -i·√2` — the value
claimed here.  That file's docstring records the same hand computation and notes, independently,
that "the exponent vector is its own dual", i.e. `IsFrickeSelfDual 2 rPinTwo`.  So the eigenvalue
of `SDF-DEF-02` agrees at this point with a constant already proved upstream. -/
theorem selfDual_pin_level_two_weight_one :
    IsFrickeSelfDual 2 rPinTwo
      ∧ (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) = 2 * 1
      ∧ (∏ δ ∈ (2 : ℕ).divisors, (δ : ℝ) ^ (rPinTwo δ)) = 2
      ∧ (∏ δ ∈ (2 : ℕ).divisors, (δ : ℝ) ^ (rPinTwo δ)) = ((2 : ℕ) : ℝ) ^ (1 : ℤ)
      ∧ frickeEigenvalue 2 1 = -I * ((Real.sqrt 2 : ℝ) : ℂ) := by
  -- ASSEMBLY.  The one wrinkle, recorded in this file's header: this pin writes its eigenvalue as
  -- `-I * √2` while `frickeEigenvalue_pin_level_two_weight_one` proves `-(I * √2)`.  The two are
  -- equal by `neg_mul`, NOT by `rfl`, hence the closing `ring`.
  refine ⟨selfDual_cond_pin_level_two_weight_one, by decide, ?_, ?_, ?_⟩
  · rw [show (2 : ℕ).divisors = {1, 2} from by decide]; norm_num [rPinTwo]
  · rw [show (2 : ℕ).divisors = {1, 2} from by decide]; norm_num [rPinTwo]
  · rw [frickeEigenvalue_pin_level_two_weight_one]; ring

/-- **PIN 5 — the sign pin: `f = η⁴` at level one, weight 2, eigenvalue `-1`.**  Hand check:
`∑ r δ = 4 = 2·2`, `∏ δ^{r δ} = 1`, `λ = i^{-2}·√1 = -1`.  Cross-check from the `S`-transform:
`η(-1/z)⁴ = (√(-iz))⁴ η(z)⁴ = (-iz)² η(z)⁴ = -z²·η(z)⁴`, so the eigenvalue is `-1`, not `+1`.

This is the pin that a sign error in `I ^ (-k)` cannot survive, and the reason `SDF-09`
(`I_zpow_neg_eq_neg_one_iff`) is a separate node: `k ≡ 2 (mod 4)` is exactly where the
eigenvalue changes sign. -/
theorem selfDual_pin_eigenvalue_neg_one :
    IsFrickeSelfDual 1 rPinFour
      ∧ (∑ δ ∈ (1 : ℕ).divisors, rPinFour δ) = 2 * 2
      ∧ (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinFour δ)) = ((1 : ℕ) : ℝ) ^ (2 : ℤ)
      ∧ frickeEigenvalue 1 2 = -1 := by
  -- ASSEMBLY.  The sign lives entirely in `I ^ (-2 : ℤ) = -1`, which is `I_zpow_neg_two` above and
  -- is what `frickeEigenvalue_pin_neg_one` consumes; nothing here re-derives it.
  refine ⟨selfDual_cond_pin_level_one_weight_two, by decide, ?_, frickeEigenvalue_pin_neg_one⟩
  · rw [show (1 : ℕ).divisors = {1} from by decide]; norm_num [rPinFour]

/-- **NEGATIVE CONTROL — `IsFrickeSelfDual` is a genuine restriction.**  At level two the vector
`r = (2, 0)` has `r 1 = 2 ≠ 0 = r 2 = r (2/1)`, so it is **not** self-dual.  Without this, every
statement in this file could in principle be vacuous on a mis-stated `IsFrickeSelfDual` (for
instance one quantified over `δ ∈ ∅`, or one that accidentally says `r δ = r δ`).

`fricke_dual_pin` in `EtaQuotientModularity.lean` (sorry-free, immediately after
`fricke_level_two_pin`) is stated at this SAME exponent vector `r = (2, 0)` at `N = 2`, and shows
what self-duality fails to give: there `f(z) = η(z)²` while the dual `f*(z) = η(2z)²` is a
genuinely different function, so `etaQuotient_fricke` does NOT return the original quotient.
That is precisely the situation `IsFrickeSelfDual` excludes, which is why the same `r` is the
right negative control here.

Computed first outside Lean, this session: at `N = 2` the vector reads `[2, 0]` on `[1, 2]` while
its dual reads `[0, 2]` — different at both divisors, so the predicate must be FALSE here.  This is
the pin that certifies `IsFrickeSelfDual` is not accidentally universally true (which is what a
binder over `∅`, or a statement that had collapsed to `r δ = r δ`, would give). -/
theorem not_selfDual_pin_asymmetric : ¬ IsFrickeSelfDual 2 rPinAsym := by
  unfold IsFrickeSelfDual
  decide

end Pins

/-! ### `SDF-01` — the exponent vector is read only on `N.divisors` (`ℂ`-domain)

PINS FIRST, as everywhere else in this file.  `SDF-01` is an adapter, so the pins that can
actually catch a wrong statement are on its HYPOTHESIS, at the exact instantiation its consumer
(`SDF-04`) uses: `r := fun d => r (N / d)`, `s := r`, whose obligation beta-reduces to
`r (N / δ) = r δ` on `N.divisors`.  The pins below fix that obligation at concrete `(N, r)` in the
three regimes this run's discipline names — the level-one `r = (24)`, `k = 12` case underlying the
already sorry-free `eta_S_via_fricke`; a genuine `N > 1` self-dual vector with non-constant
entries; and the degenerate `r ≡ 0` — plus two negative controls certifying the hypothesis is a
genuine restriction rather than one every vector satisfies.

Every value was computed OUTSIDE Lean first, in exact integer arithmetic this session
(`divisors 1 = [1]`, `divisors 2 = [1,2]`, `divisors 6 = [1,2,3,6]`, each vector printed beside
its dual `δ ↦ r (N/δ)`), and only then asserted here.  None was adjusted to match a proof. -/

section Sdf01Pins

/-- **`SDF-01` PIN A — level one, `r = (24)` (`Δ = η²⁴`), the `k = 12` case.**  Computed first:
`divisors 1 = [1]`, `r` reads `[24]` and its dual `δ ↦ r (1/δ)` reads `[24]` — equal.

DEGENERATE BY CONSTRUCTION, recorded so it is not oversold: at `N = 1` the only divisor is its own
dual, so this obligation holds for **every** `r`.  What it does check is that the hypothesis of
`etaQuotient_congr_divisors` elaborates and reduces at the instance underlying the already
sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`). -/
theorem dualExp_congr_pin_level_one :
    ∀ δ ∈ (1 : ℕ).divisors, (fun d => rPinOne (1 / d)) δ = rPinOne δ := by decide

/-- **`SDF-01` PIN B — level six, `r = (1, 11, 11, 1)` on `(1, 2, 3, 6)`.  THE LOAD-BEARING PIN.**
Computed first: under `δ ↦ 6/δ` (which pairs `1 ↔ 6` and `2 ↔ 3`) the vector reads `[1, 11, 11, 1]`
and its dual reads `[1, 11, 11, 1]` — equal, so the hypothesis holds.

This is the only pin here with `N > 1` **and** a non-constant exponent vector (`rPinSix_nonconstant`),
hence the only one a wrong `δ ↔ N/δ` pairing could fail. -/
theorem dualExp_congr_pin_level_six :
    ∀ δ ∈ (6 : ℕ).divisors, (fun d => rPinSix (6 / d)) δ = rPinSix δ := by decide

/-- **`SDF-01` PIN C — the degenerate vector `r ≡ 0` at level six.**  Every value and every dual
value is `0`, so the obligation holds factor by factor, definitionally.

DEGENERATE BY CONSTRUCTION: true for every `N`.  It is a floor — it certifies the hypothesis is not
accidentally unsatisfiable (e.g. by a mis-stated binder) — and it is not evidence about the
involution.  Proved by `rfl` under the binder, since `(0 : EtaExp) δ = 0` definitionally. -/
theorem dualExp_congr_pin_zero_exp :
    ∀ δ ∈ (6 : ℕ).divisors, (fun d => (0 : EtaExp) (6 / d)) δ = (0 : EtaExp) δ := fun _ _ => rfl

/-- **`SDF-01` PIN D — level two, `r = (1, 1)`, i.e. `f = η(z)·η(2z)`.**  Computed first:
`divisors 2 = [1, 2]`, the vector reads `[1, 1]` and its dual reads `[1, 1]`.  Constant, hence
degenerate in the same way as PIN A; kept because `fricke_level_two_pin`
(`EtaQuotientModularity.lean:2285`, sorry-free) is stated at this exponent vector. -/
theorem dualExp_congr_pin_level_two :
    ∀ δ ∈ (2 : ℕ).divisors, (fun d => rPinTwo (2 / d)) δ = rPinTwo δ := by decide

/-- **`SDF-01` NEGATIVE CONTROL 1 — the hypothesis is a genuine restriction.**  At `N = 2` the
vector `r = (2, 0)` reads `[2, 0]` on `[1, 2]` while its dual reads `[0, 2]` — different at both
divisors, so the hypothesis is FALSE here.  Computed first, outside Lean.

Without this, `SDF-01` could be applied to the dual vector of an ARBITRARY `r`, which would make
`SDF-04`'s use of self-duality vacuous.  This is the same exponent vector as `fricke_dual_pin`
(`EtaQuotientModularity.lean`, sorry-free), where `f(z) = η(z)²` and its Fricke dual
`f*(z) = η(2z)²` are shown to be genuinely different functions — i.e. the conclusion of `SDF-01`
also fails here, not merely its hypothesis. -/
theorem not_dualExp_congr_pin_asymmetric :
    ¬ ∀ δ ∈ (2 : ℕ).divisors, (fun d => rPinAsym (2 / d)) δ = rPinAsym δ := by decide

/-- **`SDF-01` NEGATIVE CONTROL 2 — the divisor involution is the right one.**  `r = (1, 11, 1, 11)`
on `(1, 2, 3, 6)` carries the SAME weight normalisation as PIN B's vector (`∑ r δ = 24`) and IS
invariant under the WRONG involution `1 ↔ 3`, `2 ↔ 6`.  Computed first: under `δ ↦ 6/δ` it reads
`[1, 11, 1, 11]` against a dual `[11, 1, 11, 1]` — different at every divisor, so FALSE.

A statement that had transposed the divisor pairing would satisfy PINs A–D and would prove this
one's negation, so together with PIN B this brackets the pairing from both sides. -/
theorem not_dualExp_congr_pin_mispaired :
    ¬ ∀ δ ∈ (6 : ℕ).divisors, (fun d => rPinSixMispaired (6 / d)) δ = rPinSixMispaired δ := by
  decide

/-- **`SDF-01` ORIENTATION PIN — the `.symm` bridge from `IsFrickeSelfDual`, machine-checked.**

`IsFrickeSelfDual` reads `r δ = r (N / δ)` while `etaQuotient_congr_divisors`, instantiated the way
`SDF-04` needs it, requires `r (N / δ) = r δ`: the two differ by a `.symm`, and that flip is the
one place a downstream proof could silently need a lemma that does not exist.  This pin discharges
PIN B's obligation from the already sorry-free `selfDual_cond_pin_level_six` through exactly that
bridge, so the fit is checked rather than assumed. -/
theorem dualExp_congr_pin_level_six_of_selfDual :
    ∀ δ ∈ (6 : ℕ).divisors, (fun d => rPinSix (6 / d)) δ = rPinSix δ :=
  fun δ hδ => (selfDual_cond_pin_level_six δ hδ).symm

end Sdf01Pins

/-- **`SDF-01`.**  Two exponent vectors agreeing on `N.divisors` give the same eta quotient, as
functions on `ℂ`.

This is the `ℂ`-domain analogue of the existing `etaQuotientH_congr`
(`EtaQuotientModularity.lean:588`), which is stated for the bundled `τ : ℍ`.  A whole-library grep
for `etaQuotient_congr` this session returns only the bundled version, and `etaQuotient_fricke`
is stated on `ℂ` — so this really is the missing adapter, not a duplicate.

STRICTLY MORE GENERAL THAN ITS MODEL, deliberately: `etaQuotientH N r τ = etaQuotient N r (τ : ℂ)`
is `rfl` (`etaQuotientH_apply`), so this drops the `im z > 0` constraint the `ℍ` subtype carries.
That is sound because no non-vanishing and no branch cut is used anywhere in the proof — off `ℍₒ`
both sides take the same junk value, since the two products are equal factor by factor. -/
theorem etaQuotient_congr_divisors {N : ℕ} {r s : EtaExp} (z : ℂ)
    (h : ∀ δ ∈ N.divisors, r δ = s δ) : etaQuotient N r z = etaQuotient N s z := by
  simp only [etaQuotient]
  exact Finset.prod_congr rfl fun δ hδ => by rw [h δ hδ]

/-- **`SDF-01` APPLICATION CHECK — the adapter actually fires at the load-bearing instance.**

The pins above fix the hypothesis; this fixes the CONCLUSION, by running
`etaQuotient_congr_divisors` at exactly the shape `SDF-04` will need it: the dual quotient of the
level-six self-dual vector collapses to the quotient of the vector itself, for every `z : ℂ`, with
no hypothesis on `z`.  Discharged through the `.symm` orientation bridge, so what is checked here
is the whole path from `IsFrickeSelfDual` to the collapsed quotient — the step `SDF-04` is claimed
to be one `rw` away from.  A gap in that path would show up here rather than in `SDF-04`. -/
theorem etaQuotient_congr_divisors_pin_level_six (z : ℂ) :
    etaQuotient 6 (fun δ => rPinSix (6 / δ)) z = etaQuotient 6 rPinSix z :=
  etaQuotient_congr_divisors z dualExp_congr_pin_level_six_of_selfDual

/-! ### `SDF-02` — the Fricke constant collapses: `∏_{δ ∣ N} δ^{r δ} = N^k`

PINS FIRST, as everywhere else in this file, and — unlike the `selfDual_pin_*` conjunctions in the
`Pins` section — stated on the PRODUCT ALONE, with no `frickeEigenvalue` conjunct.  That separation
is deliberate: the eigenvalue belongs to `SDF-DEF-02`, which is a different node, and a pin that
bundled the two could only be closed by closing both, which is how the five conjunction pins above
came to be stuck.  Each pin here is exactly `∏_{δ ∣ N} δ^{r δ} = N^k` at a concrete `(N, r, k)`.

Every value was computed OUTSIDE Lean first, in exact rational arithmetic this session, and only
then asserted here; none was adjusted to match a proof.  The regimes this run's discipline names
are the first three; the fourth and fifth exist because they are the ones a wrong statement could
still survive.

The two negative controls are the reason this node is not vacuous.  `prod_zpow_pin_asymmetric_ne`
exhibits an `r` at `N = 2` that satisfies the WEIGHT hypothesis `∑ r δ = 2k` exactly, and fails the
conclusion — so `IsFrickeSelfDual` is load-bearing in `prod_zpow_selfDual` and cannot be dropped or
weakened to the weight condition alone.  `prod_zpow_pin_mispaired_ne` does the same at `N = 6` with
a vector invariant under the WRONG divisor involution. -/

section Sdf02Pins

/-- **`SDF-02` PIN A — level one, `r = (24)` (`Δ = η²⁴`), `k = 12`.**  `divisors 1 = {1}`, so
`∏ δ^{r δ} = 1²⁴ = 1` and `N^k = 1¹² = 1`.

DEGENERATE BY CONSTRUCTION: at `N = 1` both sides are `1` for every `r` and every `k`, so this pin
cannot detect a wrong exponent.  It is here because it is the instantiation underlying the already
sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`). -/
theorem prod_zpow_pin_level_one :
    (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) = ((1 : ℕ) : ℝ) ^ (12 : ℤ) := by
  rw [show (1 : ℕ).divisors = {1} from by decide]
  norm_num [rPinOne]

/-- **`SDF-02` PIN B — level six, `r = (1, 11, 11, 1)` on `(1, 2, 3, 6)`, `k = 12`.  THE
LOAD-BEARING PIN.**  Exact rational arithmetic, computed first, outside Lean:

`∏ δ^{r δ} = 1¹ · 2¹¹ · 3¹¹ · 6¹ = 2048 · 177147 · 6 = 2176782336`, and `6¹² = 2176782336`.

This is the only pin where `N > 1` **and** the exponent vector is non-constant, hence the only one
where `∏ δ^{r δ} = N^k` is a genuine arithmetic coincidence rather than `1 = 1`: the value is
asserted as a LITERAL first (`prod_zpow_pin_level_six_value`) and only then matched against `N^k`,
so a wrong `N^k` cannot be absorbed by a wrong product. -/
theorem prod_zpow_pin_level_six_value :
    (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) = 2176782336 := by
  rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]
  norm_num [rPinSix]

/-- **`SDF-02` PIN B, second half** — the same product is `N^k = 6¹²`.  Stated separately from
`prod_zpow_pin_level_six_value` so that the literal `2176782336` and the closed form `6¹²` are two
independent assertions that must agree, rather than one assertion written twice. -/
theorem prod_zpow_pin_level_six :
    (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) = ((6 : ℕ) : ℝ) ^ (12 : ℤ) := by
  rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]
  norm_num [rPinSix]

/-- **`SDF-02` PIN C — the degenerate vector `r ≡ 0` at level six, `k = 0`.**  `∏ δ⁰ = 1 = 6⁰`.

DEGENERATE BY CONSTRUCTION: `k = 0` makes `N^k = 1` for every `N`, so any statement that accidentally
proved only the `k = 0` case would still pass here.  It is a floor certifying the product is not
mis-indexed into something empty or undefined, not evidence about the exponents. -/
theorem prod_zpow_pin_zero_exp :
    (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ ((0 : EtaExp) δ)) = ((6 : ℕ) : ℝ) ^ (0 : ℤ) := by
  rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]
  norm_num

/-- **`SDF-02` PIN D — level two, `r = (1, 1)`, `k = 1`, i.e. `f = η(z)η(2z)`.**  `∏ δ^{r δ} =
1¹ · 2¹ = 2 = 2¹ = N^k`.  The smallest non-degenerate instance, and the one whose Fricke constant is
already pinned upstream by the sorry-free `fricke_level_two_pin`
(`EtaQuotientModularity.lean:2285`), whose `(√2)⁻¹` is exactly `s^{-1/2}` at this `s = 2`. -/
theorem prod_zpow_pin_level_two :
    (∏ δ ∈ (2 : ℕ).divisors, (δ : ℝ) ^ (rPinTwo δ)) = ((2 : ℕ) : ℝ) ^ (1 : ℤ) := by
  rw [show (2 : ℕ).divisors = {1, 2} from by decide]
  norm_num [rPinTwo]

/-- **`SDF-02` PIN E — NEGATIVE EXPONENTS: level four, `r = (-2, 6, -2)` on `(1, 2, 4)`, `k = 1`.**
Exact rational arithmetic, computed first: `∏ δ^{r δ} = 1⁻² · 2⁶ · 4⁻² = 64/16 = 4 = 4¹ = N^k`.

Every other pin in this section has non-negative exponents, so its product is a plain integer and
`zpow` never inverts anything.  This one does, which is the case the general proof's positivity
step (`Finset.prod_pos` with `zpow_pos`) actually exists to handle — without it, a version of
`prod_zpow_selfDual` restricted to non-negative `r` would satisfy every other pin here.  Level four
also contributes the only `N > 1` divisor that is its OWN dual (`4 / 2 = 2`), a fixed point of the
involution that levels `2` and `6` do not have. -/
theorem prod_zpow_pin_level_four_neg :
    (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourNeg δ)) = ((4 : ℕ) : ℝ) ^ (1 : ℤ) := by
  rw [show (4 : ℕ).divisors = {1, 2, 4} from by decide]
  norm_num [rPinLevelFourNeg]

/-- The level-four pin's vector really is self-dual and really has weight `1`, so
`prod_zpow_pin_level_four_neg` is an instance of `prod_zpow_selfDual`'s hypotheses and not an
unrelated arithmetic fact. -/
theorem rPinLevelFourNeg_selfDual : IsFrickeSelfDual 4 rPinLevelFourNeg := by
  unfold IsFrickeSelfDual
  decide

/-- `∑ δ ∈ (4:ℕ).divisors, rPinLevelFourNeg δ = -2 + 6 + -2 = 2 = 2 · 1`. -/
theorem rPinLevelFourNeg_weight : (∑ δ ∈ (4 : ℕ).divisors, rPinLevelFourNeg δ) = 2 * 1 := by decide

/-- **`SDF-02` NEGATIVE CONTROL 1 — the self-duality hypothesis is LOAD-BEARING.**

At `N = 2` the vector `r = (2, 0)` satisfies the WEIGHT hypothesis exactly — `∑ r δ = 2 = 2 · 1`, so
`k = 1`, see `rPinAsym_weight` — and yet `∏ δ^{r δ} = 1² · 2⁰ = 1` while `N^k = 2¹ = 2`.  Computed
outside Lean first.

This is the pin that shows `prod_zpow_selfDual` cannot be weakened by dropping `hr` and keeping only
`hk`: such a statement is FALSE, and this is a counterexample to it.  `not_selfDual_pin_asymmetric`
above records that this same `r` is indeed not self-dual, so the two together locate exactly which
hypothesis does the work.  It is also the same exponent vector as `fricke_dual_pin`
(`EtaQuotientModularity.lean`, sorry-free), where `η(z)²` and its Fricke dual `η(2z)²` are shown to
be genuinely different functions. -/
theorem prod_zpow_pin_asymmetric_ne :
    (∏ δ ∈ (2 : ℕ).divisors, (δ : ℝ) ^ (rPinAsym δ)) ≠ ((2 : ℕ) : ℝ) ^ (1 : ℤ) := by
  rw [show (2 : ℕ).divisors = {1, 2} from by decide]
  norm_num [rPinAsym]

/-- The negative control really does satisfy the weight hypothesis `∑ r δ = 2k` at `k = 1`, which is
what makes `prod_zpow_pin_asymmetric_ne` a counterexample to the `hr`-free statement rather than a
vector that fails some other hypothesis. -/
theorem rPinAsym_weight : (∑ δ ∈ (2 : ℕ).divisors, rPinAsym δ) = 2 * 1 := by decide

/-- **`SDF-02` NEGATIVE CONTROL 2 — the divisor involution is the right one.**  `r = (1, 11, 1, 11)`
on `(1, 2, 3, 6)` carries the SAME weight normalisation as PIN B's vector (`∑ r δ = 24 = 2 · 12`)
and IS invariant under the WRONG involution `1 ↔ 3`, `2 ↔ 6`.  Computed outside Lean first, exactly:
`∏ δ^{r δ} = 1¹ · 2¹¹ · 3¹ · 6¹¹ = 2229025112064`, against `6¹² = 2176782336` — different, so a
version of `SDF-02` that had transposed the divisor pairing would be FALSE here while satisfying
every positive pin above. -/
theorem prod_zpow_pin_mispaired_ne :
    (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSixMispaired δ)) ≠ ((6 : ℕ) : ℝ) ^ (12 : ℤ) := by
  rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]
  norm_num [rPinSixMispaired]

end Sdf02Pins

/-- **`SDF-02`.**  For a Fricke-self-dual exponent vector of weight `k`, the Fricke constant
`s = ∏_{δ ∣ N} δ^{r δ}` is forced to equal `N^k`.

This is the one genuinely non-formal step in this file, and it happens entirely inside `ℝ`, so
no branch cut is anywhere near it.  The route: `sqrt_prod_dual`
(`EtaQuotientModularity.lean:2409`) says `√s* = N^k · (√s)⁻¹` where `s* = ∏_δ δ^{r (N/δ)}`;
self-duality collapses `s*` to `s` (`Finset.prod_congr` on `hr`), leaving `√s · √s = N^k`; and
`s > 0` (`Finset.prod_pos` with `zpow_pos`) turns `Real.mul_self_sqrt` into `s = N^k`.

EVIDENCE, computed this session and not carried over: a brute-force scan over all self-dual
exponent vectors satisfying `∑ r δ = 2k`, in exact rational arithmetic, enumerating the vectors by
`δ ↔ N/δ` ORBIT (so that self-duality is imposed by construction and then re-asserted as an
`assert`, rather than filtered for) — `1 ≤ N ≤ 24`, entries in `[-3,3]`: **4028** instances, **zero**
mismatches, of which 3876 have `N > 1` and a non-constant vector; `1 ≤ N ≤ 24`, `[-5,5]`: 20300,
zero; `1 ≤ N ≤ 48`, `[-3,3]`: 37068, zero; `1 ≤ N ≤ 60`, `[-4,4]`: 671504, zero.

NOTE ON THE WEIGHT HYPOTHESIS.  `hk` is not decoration: `sqrt_prod_dual` needs it, and the reason is
visible in the one-line proof of the identity behind this lemma — `s · s* = ∏_δ δ^{r δ} · ∏_δ
(N/δ)^{r δ} = ∏_δ N^{r δ} = N^{∑ r δ}`, which is `N^{2k}` exactly when `∑ r δ = 2k`.  Self-duality
then says `s* = s`, so `s² = N^{2k}`, and positivity picks the root `s = N^k` rather than `-N^k`.
Dropping `hr` makes the statement FALSE — `prod_zpow_pin_asymmetric_ne` is a counterexample that
satisfies `hk`. -/
theorem prod_zpow_selfDual {N : ℕ} (hN : 0 < N) {r : EtaExp} (hr : IsFrickeSelfDual N r) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) :
    ∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ) = (N : ℝ) ^ k := by
  -- (1) `s > 0`: every divisor of a positive `N` is positive, and `zpow` of a positive base is
  -- positive at EVERY integer exponent — this is the step `prod_zpow_pin_level_four_neg` exercises.
  have hpos : 0 < ∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ) := by
    refine Finset.prod_pos fun δ hδ => zpow_pos ?_ _
    exact_mod_cast Nat.pos_of_mem_divisors hδ
  -- (2) self-duality collapses the DUAL constant `s*` onto `s`, factor by factor on the SAME index
  -- set — no divisor-involution reindexing is involved.  `IsFrickeSelfDual` reads `r δ = r (N/δ)`,
  -- so this rewrites BACKWARDS; that orientation is pinned, not guessed.
  have hdual : ∏ δ ∈ N.divisors, (δ : ℝ) ^ (r (N / δ))
      = ∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ) :=
    Finset.prod_congr rfl fun δ hδ => by rw [← hr δ hδ]
  -- (3) `sqrt_prod_dual` (F3.2-A7, sorry-free) now reads `√s = N^k · (√s)⁻¹`.
  have h := sqrt_prod_dual hN r hk
  rw [hdual] at h
  have hne : Real.sqrt (∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ)) ≠ 0 := Real.sqrt_ne_zero'.mpr hpos
  have key : Real.sqrt (∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ))
      * Real.sqrt (∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ)) = (N : ℝ) ^ k := by
    nth_rewrite 1 [h]
    exact inv_mul_cancel_right₀ hne _
  rw [← Real.mul_self_sqrt hpos.le]
  exact key

/-- **`SDF-02` APPLICATION CHECK — the general lemma reproduces the load-bearing pin.**

`prod_zpow_pin_level_six_value` asserts `∏_{δ ∣ 6} δ^{r δ} = 2176782336` by direct computation.
This re-derives the same number by running `prod_zpow_selfDual` at `(N, r, k) = (6, rPinSix, 12)`
and evaluating `6¹²`, i.e. through the general proof rather than around it.  The two agree, so the
general statement is not merely true in the abstract — it fires at the concrete instance and returns
the independently computed value.  A general lemma that had drifted (a wrong exponent, `N^{k/2}` in
place of `N^k`, the dual product in place of the original) would produce a different number here
while remaining provable in its own terms. -/
theorem prod_zpow_selfDual_pin_level_six :
    (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) = 2176782336 := by
  rw [prod_zpow_selfDual (N := 6) (by norm_num) (r := rPinSix) selfDual_cond_pin_level_six
    (k := 12) (by decide)]
  norm_num

/-! ### `SDF-03` — the constant of `etaQuotient_fricke`, in closed form -/

/-! #### `SDF-03` pins — stated and computed BEFORE the general lemma

Each pin fixes a concrete `(N, r, k)` and asserts the two sides of `SDF-03` **separately**, each
against a numeral computed first outside Lean (exact rational arithmetic, this session):

| pin | `N` | `r` | `k` | `s = ∏ δ^{r δ}` | LHS `N^k · s^{-1/2}` | RHS `√(N^k)` |
|-----|-----|-----|-----|------------------|----------------------|--------------|
| A | 1 | `(24)` | 12 | `1` | `1` | `1` |
| B | 6 | `(1,11,11,1)` | 12 | `2176782336` | `46656` | `46656` |
| C | 6 | `≡ 0` | 0 | `1` | `1` | `1` |
| D | 4 | `(-2,6,-2)` | 1 | `4` | `2` | `2` |
| E | 6 | `(-1,-11,-11,-1)` | −12 | `1/2176782336` | `1/46656` | `1/46656` |

Writing the two sides as separate conjuncts against the SAME independently computed numeral is the
point: a single equation `LHS = RHS` can be satisfied by two matching errors, whereas each conjunct
here must hit a number fixed in advance.

What each pin can and cannot detect.  A and C are **degenerate by construction** — both sides are
`1`, so they certify only that the expression elaborates and reduces at the instance underlying the
already sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`), and carry no evidence
about exponents.  B is the load-bearing one: `N > 1`, non-constant vector, and `46656 ≠ 2176782336`,
so it separates `√(N^k)` from `N^k`.  D exercises negative *entries* (the `zpow_pos` step).  E
exercises negative *weight*, where `√(N^k)` is a proper fraction.

The negative controls `fricke_const_pin_not_natPow` and `fricke_const_pin_not_mul` record that the
square root and the inversion are both load-bearing: replacing `√(N^k)` by `N^k`, or `s^{-1/2}` by
`s^{1/2}`, makes the statement FALSE at pin B. -/

section Sdf03Pins

/-- `√(6¹²) = √2176782336 = 46656`, i.e. `6⁶`.  Exact integer arithmetic: `46656² = 2176782336`. -/
theorem sqrt_natPow_level_six : Real.sqrt (((6 : ℕ) : ℝ) ^ (12 : ℤ)) = 46656 := by
  rw [show (((6 : ℕ) : ℝ) ^ (12 : ℤ)) = (46656 : ℝ) ^ 2 by norm_num]
  exact Real.sqrt_sq (by norm_num)

/-- `√(4¹) = 2`. -/
theorem sqrt_natPow_level_four : Real.sqrt (((4 : ℕ) : ℝ) ^ (1 : ℤ)) = 2 := by
  rw [show (((4 : ℕ) : ℝ) ^ (1 : ℤ)) = (2 : ℝ) ^ 2 by norm_num]
  exact Real.sqrt_sq (by norm_num)

/-- `√(6⁻¹²) = 1/46656`.  The NEGATIVE-weight value: the radicand `1/2176782336` is a proper
fraction, and `(1/46656)² = 1/2176782336`. -/
theorem sqrt_natPow_level_six_neg :
    Real.sqrt (((6 : ℕ) : ℝ) ^ (-12 : ℤ)) = (46656 : ℝ)⁻¹ := by
  rw [show (((6 : ℕ) : ℝ) ^ (-12 : ℤ)) = ((46656 : ℝ)⁻¹) ^ 2 by norm_num]
  exact Real.sqrt_sq (by norm_num)

/-- **`SDF-03` PIN A — level one, `r = (24)`, `k = 12`.**  `s = 1¹ = 1`, so the constant is
`1¹² · 1⁻¹ = 1`, and `√(1¹²) = 1`.

DEGENERATE BY CONSTRUCTION: at `N = 1` both sides are `1` whatever `k` and `r` are, so this pin
cannot detect a wrong exponent.  It is here because it is the instance underlying the already
sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`). -/
theorem fricke_const_pin_level_one :
    ((1 : ℕ) : ℂ) ^ (12 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) : ℝ) : ℂ)⁻¹ = 1
    ∧ ((Real.sqrt (((1 : ℕ) : ℝ) ^ (12 : ℤ)) : ℝ) : ℂ) = 1 := by
  rw [show (1 : ℕ).divisors = {1} from by decide]
  norm_num [rPinOne, Real.sqrt_one]

/-- **`SDF-03` PIN B — level six, `r = (1, 11, 11, 1)`, `k = 12`.  THE LOAD-BEARING PIN.**

Exact arithmetic, computed first, outside Lean: `s = 1¹ · 2¹¹ · 3¹¹ · 6¹ = 2176782336 = 6¹²`, so
`√s = 46656` and the constant is `6¹² · 46656⁻¹ = 2176782336 / 46656 = 46656`; independently,
`√(6¹²) = 46656`.  Both conjuncts are matched against the SAME pre-computed `46656`.

The only pin with `N > 1` **and** a non-constant exponent vector, hence the only one where the
collapse is a genuine arithmetic coincidence rather than `1 = 1`.  Because `46656 ≠ 2176782336`, it
is also what separates `√(N^k)` from `N^k` — see `fricke_const_pin_not_natPow`. -/
theorem fricke_const_pin_level_six :
    ((6 : ℕ) : ℂ) ^ (12 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) : ℝ) : ℂ)⁻¹ = (46656 : ℂ)
    ∧ ((Real.sqrt (((6 : ℕ) : ℝ) ^ (12 : ℤ)) : ℝ) : ℂ) = (46656 : ℂ) := by
  refine ⟨?_, ?_⟩
  · rw [prod_zpow_pin_level_six_value,
      show (2176782336 : ℝ) = (46656 : ℝ) ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
    norm_num
  · rw [sqrt_natPow_level_six]; norm_num

/-- **`SDF-03` PIN C — the degenerate vector `r ≡ 0` at level six, `k = 0`.**  `s = ∏ δ⁰ = 1` and
`N^k = 6⁰ = 1`, so both sides are `1`.

DEGENERATE BY CONSTRUCTION: `k = 0` makes `N^k = 1` for every `N`, so a statement that accidentally
proved only the `k = 0` case would still pass here.  It is a floor certifying the product is not
mis-indexed into something empty or undefined, not evidence about the exponents. -/
theorem fricke_const_pin_zero_exp :
    ((6 : ℕ) : ℂ) ^ (0 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ ((0 : EtaExp) δ)) : ℝ) : ℂ)⁻¹ = 1
    ∧ ((Real.sqrt (((6 : ℕ) : ℝ) ^ (0 : ℤ)) : ℝ) : ℂ) = 1 := by
  rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]
  norm_num [Real.sqrt_one]

/-- **`SDF-03` PIN D — NEGATIVE ENTRIES: level four, `r = (-2, 6, -2)`, `k = 1`.**  `s = 1⁻² · 2⁶ ·
4⁻² = 64/16 = 4`, so the constant is `4¹ · 2⁻¹ = 2`, and `√(4¹) = 2`.

This is the instance that passes through `(4 : ℝ)⁻²`, i.e. the `zpow_pos` positivity step the
general proof needs at negative exponents.  Level four also contributes the only `N > 1` divisor
that is its own dual (`4 / 2 = 2`). -/
theorem fricke_const_pin_level_four_neg :
    ((4 : ℕ) : ℂ) ^ (1 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourNeg δ)) : ℝ) : ℂ)⁻¹
      = (2 : ℂ)
    ∧ ((Real.sqrt (((4 : ℕ) : ℝ) ^ (1 : ℤ)) : ℝ) : ℂ) = (2 : ℂ) := by
  refine ⟨?_, ?_⟩
  · rw [prod_zpow_pin_level_four_neg, sqrt_natPow_level_four]; norm_num
  · rw [sqrt_natPow_level_four]; norm_num

/-- The level-six negative-weight vector really is self-dual, so PIN E is an instance of
`fricke_const_selfDual`'s hypotheses and not an unrelated arithmetic fact. -/
theorem rPinLevelSixNeg_selfDual : IsFrickeSelfDual 6 rPinLevelSixNeg := by
  unfold IsFrickeSelfDual
  decide

/-- `∑ δ ∈ (6:ℕ).divisors, rPinLevelSixNeg δ = -1 + -11 + -11 + -1 = -24 = 2 · (-12)`, so PIN E's
weight is `k = -12`. -/
theorem rPinLevelSixNeg_weight :
    (∑ δ ∈ (6 : ℕ).divisors, rPinLevelSixNeg δ) = 2 * (-12) := by decide

/-- PIN E's product, asserted as the closed form `6⁻¹²`: `1⁻¹ · 2⁻¹¹ · 3⁻¹¹ · 6⁻¹ = 1/2176782336`. -/
theorem prod_zpow_pin_level_six_neg :
    (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelSixNeg δ)) = ((6 : ℕ) : ℝ) ^ (-12 : ℤ) := by
  rw [show (6 : ℕ).divisors = {1, 2, 3, 6} from by decide]
  norm_num [rPinLevelSixNeg]

/-- **`SDF-03` PIN E — NEGATIVE WEIGHT: level six, `r = (-1, -11, -11, -1)`, `k = -12`.**

Exact rational arithmetic, computed first: `s = 6⁻¹² = 1/2176782336`, `√s = 1/46656`, so the
constant is `6⁻¹² · (1/46656)⁻¹ = 46656/2176782336 = 1/46656`; independently `√(6⁻¹²) = 1/46656`.

The only pin with `k < 0`, where `N^k` and `√(N^k)` are proper fractions rather than integers.  A
version of `SDF-03` that had silently assumed `k ≥ 0` — `k.toNat` anywhere, or `pow_pos` in place of
`zpow_pos` — would satisfy pins A–D and fail here. -/
theorem fricke_const_pin_level_six_neg :
    ((6 : ℕ) : ℂ) ^ (-12 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelSixNeg δ)) : ℝ) : ℂ)⁻¹
      = ((46656 : ℂ))⁻¹
    ∧ ((Real.sqrt (((6 : ℕ) : ℝ) ^ (-12 : ℤ)) : ℝ) : ℂ) = ((46656 : ℂ))⁻¹ := by
  refine ⟨?_, ?_⟩
  · rw [prod_zpow_pin_level_six_neg, sqrt_natPow_level_six_neg]; push_cast; norm_num
  · rw [sqrt_natPow_level_six_neg]; push_cast; norm_num

/-- **`SDF-03` NEGATIVE CONTROL 1 — the square root is load-bearing.**

At PIN B's instance the claimed right-hand side is `√(6¹²) = 46656`, and `6¹² = 2176782336` is a
DIFFERENT number.  So a version of `SDF-03` asserting `N^k · s^{-1/2} = N^k` — i.e. one that had
dropped the square root, or absorbed it into a wrong exponent — is FALSE, and this is the
counterexample.  Computed outside Lean first. -/
theorem fricke_const_pin_not_natPow :
    ((Real.sqrt (((6 : ℕ) : ℝ) ^ (12 : ℤ)) : ℝ) : ℂ) ≠ ((6 : ℕ) : ℂ) ^ (12 : ℤ) := by
  rw [sqrt_natPow_level_six]
  norm_num

/-- **`SDF-03` NEGATIVE CONTROL 2 — the inversion is load-bearing.**

`etaQuotient_fricke`'s constant carries `s^{-1/2}`, not `s^{+1/2}`.  At PIN B, `N^k · √s = 6¹² ·
46656 = 101559956668416`, against the claimed `√(N^k) = 46656` — different, so a version of
`SDF-03` that had transcribed the constant without the inverse is FALSE here while satisfying the
degenerate pins A and C (where `s = 1` and inversion is invisible). -/
theorem fricke_const_pin_not_mul :
    ((6 : ℕ) : ℂ) ^ (12 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) : ℝ) : ℂ)
      ≠ ((Real.sqrt (((6 : ℕ) : ℝ) ^ (12 : ℤ)) : ℝ) : ℂ) := by
  rw [prod_zpow_pin_level_six_value,
    show (2176782336 : ℝ) = (46656 : ℝ) ^ 2 by norm_num, Real.sqrt_sq (by norm_num),
    sqrt_natPow_level_six]
  norm_num

end Sdf03Pins

/-- **`SDF-03`.**  On a self-dual exponent vector the constant `N^k · s^{-1/2}` of
`etaQuotient_fricke` collapses to the single real square root `√(N^k) = N^{k/2}`.

Proved as an identity in `ℝ` first and only then cast into `ℂ`, deliberately: at no point does a
complex square root or a branch choice appear.  The `ℝ`-level statement is
`(N:ℝ)^k * (√((N:ℝ)^k))⁻¹ = √((N:ℝ)^k)`, which is `Real.sq_sqrt` at a positive argument. -/
theorem fricke_const_selfDual {N : ℕ} (hN : 0 < N) {r : EtaExp} (hr : IsFrickeSelfDual N r)
    {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) :
    (N : ℂ) ^ k * ((Real.sqrt (∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ)) : ℝ) : ℂ)⁻¹
      = ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ) := by
  -- (1) `SDF-02` collapses the Fricke constant `s = ∏_{δ ∣ N} δ^{r δ}` to `N^k`.  This is the ONLY
  -- place the self-duality hypothesis `hr` is used; everything after it is the identity
  -- `a · (√a)⁻¹ = √a` at the positive real `a = N^k`.
  rw [prod_zpow_selfDual hN hr hk]
  -- (2) `a = (N:ℝ)^k > 0`.  `zpow_pos`, NOT `pow_pos`: `k` may be negative, which is exactly what
  -- `fricke_const_pin_level_six_neg` (`k = -12`) pins.
  have hNpos : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hapos : (0 : ℝ) < (N : ℝ) ^ k := zpow_pos hNpos k
  have hne : Real.sqrt ((N : ℝ) ^ k) ≠ 0 := Real.sqrt_ne_zero'.mpr hapos
  -- (3) The whole content, as an identity in `ℝ`: no complex square root and no branch choice is
  -- anywhere near this.  `a · (√a)⁻¹ = a / √a = √a` because `√a · √a = a`.
  have hR : (N : ℝ) ^ k * (Real.sqrt ((N : ℝ) ^ k))⁻¹ = Real.sqrt ((N : ℝ) ^ k) := by
    rw [inv_eq_one_div, mul_one_div, div_eq_iff hne, Real.mul_self_sqrt hapos.le]
  -- (4) Transport the `ℝ`-identity into `ℂ` along `Complex.ofReal`, rather than re-deriving it
  -- there: `push_cast` moves the cast inward through `Complex.ofReal_mul`, `Complex.ofReal_inv`,
  -- `Complex.ofReal_zpow` and `Complex.ofReal_natCast`, turning `((N:ℝ)^k : ℂ)` into `(N:ℂ)^k`.
  have hC := congrArg (fun x : ℝ => (x : ℂ)) hR
  push_cast at hC
  exact hC

/-- **`SDF-03` APPLICATION CHECK — the general lemma reproduces the load-bearing pin.**

`fricke_const_pin_level_six` asserts, by direct computation, that at `(N, r, k) = (6, rPinSix, 12)`
the constant `N^k · s^{-1/2}` equals `46656`.  This re-derives the same number by RUNNING
`fricke_const_selfDual` at that instance and evaluating `√(6¹²)`, i.e. through the general proof
rather than around it.  The two agree, so the general statement is not merely true in the abstract:
it fires at the concrete instance and returns the independently computed value.  A general lemma
that had drifted — `N^k` for `√(N^k)`, `s^{+1/2}` for `s^{-1/2}`, a wrong exponent — would produce a
different number here while remaining provable in its own terms. -/
theorem fricke_const_selfDual_pin_level_six :
    ((6 : ℕ) : ℂ) ^ (12 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) : ℝ) : ℂ)⁻¹
      = (46656 : ℂ) := by
  rw [fricke_const_selfDual (N := 6) (by norm_num) (r := rPinSix) selfDual_cond_pin_level_six
    (k := 12) (by decide), sqrt_natPow_level_six]
  norm_num

/-- **`SDF-03` APPLICATION CHECK at NEGATIVE weight.**  The same, at
`(N, r, k) = (6, rPinLevelSixNeg, -12)`, where `fricke_const_pin_level_six_neg` computes the
constant to be `1/46656` directly.  Running the general lemma at `k < 0` returns the same value, so
the general proof genuinely covers negative weights and does not silently assume `k ≥ 0`. -/
theorem fricke_const_selfDual_pin_level_six_neg :
    ((6 : ℕ) : ℂ) ^ (-12 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelSixNeg δ)) : ℝ) : ℂ)⁻¹
      = ((46656 : ℂ))⁻¹ := by
  rw [fricke_const_selfDual (N := 6) (by norm_num) (r := rPinLevelSixNeg) rPinLevelSixNeg_selfDual
    (k := -12) rPinLevelSixNeg_weight, sqrt_natPow_level_six_neg]
  push_cast
  norm_num

/-! ### `SDF-04` — the eigenform relation, raw shape

PINS FIRST, as everywhere else in this file, and stated as EXPLICIT INSTANCES OF `SDF-04`'s OWN
EQUATION at concrete `(N, r, k)` — not merely of its hypotheses.  Each is discharged along exactly
the route the general lemma claims (one `rw` with `etaQuotient_fricke`, then one `rw` with
`etaQuotient_congr_divisors` through the `.symm` orientation bridge), and **none of them invokes
`etaQuotient_fricke_selfDual_raw`** — they are declared ABOVE it in this same module, so Lean's own
scoping makes referring to it impossible, and that is enforced by the compiler rather than promised
here.  They are therefore evidence about the route, not consequences of it.  If any pin below had
failed to close, the general statement would have been wrong.

What the pins actually test, beyond the hypothesis pins of `SDF-01`: that the `rw` with
`etaQuotient_fricke` FIRES on `SDF-04`'s left-hand side (the two are character-identical, but that
is a claim about the source text, not about elaborated terms), and that what it leaves behind is
exactly the dual-quotient collapse and nothing else — no residual goal, no side condition.  Every
pin closes with the two rewrites alone, which is that claim, machine-checked at four instances.

The regimes are the three this run's discipline names, plus one:

* `selfDual_raw_pin_level_one` — `N = 1`, `r = (24)`, `k = 12`, the `Δ = η²⁴` case, together with
  `selfDual_raw_pin_level_one_is_eta_S`, which pushes that instance all the way down to
  `η(-1/z)²⁴ = z¹² η(z)²⁴`.  That conclusion is `eta_S_via_fricke`
  (`EtaQuotientModularity.lean:2246`, sorry-free, and re-derived there a second time from MATHLIB's
  `discriminant_S_invariant`), so this is an EXTERNAL cross-check: the level-one instance of
  `SDF-04` is carried to a statement Mathlib independently proves, without citing either of the two
  existing derivations of it.  SECOND-ROUTE AGREEMENT ONLY: at `N = 1`, `k = 12` it pins NO
  component of `λ` — see `selfDual_pin_level_one_no_evidence_*` at the end of this file.
* `selfDual_raw_pin_level_six` — `N = 6`, `r = (1, 11, 11, 1)`, `k = 12`.  THE LOAD-BEARING PIN:
  the only one with `N > 1` **and** a non-constant exponent vector (`rPinSix_nonconstant`), hence
  the only one where the dual quotient is a genuinely different-looking product that must be
  collapsed rather than a syntactic no-op.
* `selfDual_raw_pin_zero_exp` — the degenerate `r ≡ 0` at `N = 6`, `k = 0`.  DEGENERATE BY
  CONSTRUCTION (both quotients are the empty-ish product `1` and the constant is `1`); it is a
  floor certifying the statement is not mis-stated into something unsatisfiable, not evidence
  about the involution.
* `selfDual_raw_pin_level_four_neg` — `N = 4`, `r = (-2, 6, -2)`, `k = 1`.  NEGATIVE EXPONENTS and
  the only pin whose level has a divisor that is its own dual (`4 / 2 = 2`), a fixed point of the
  involution that levels `1`, `2` and `6` do not have.

Non-vacuity of the added hypothesis is already on the record and is not re-asserted here: the
negative controls `not_selfDual_pin_asymmetric` (η(z)² at `N = 2`) and `not_selfDual_pin_mispaired`
show `IsFrickeSelfDual` is a genuine restriction, and `fricke_dual_pin`
(`EtaQuotientModularity.lean`, sorry-free) proves that at that same `r = (2, 0)` the Fricke
transform lands on `η(2z)²`, i.e. on the quotient of the DUAL vector `(0, 2)` — a vector this file
`decide`-proves is different from `r` (`not_selfDual_pin_asymmetric`).  So `SDF-04` is not the
general theorem with a decorative hypothesis bolted on.

STATED PRECISELY, so it is not read as more than it is: what is machine-proved is that the two
EXPONENT VECTORS differ and that the transform lands on the dual one.  That `η(z)²` and `η(2z)²` are
different FUNCTIONS is true and is recorded in `fricke_dual_pin`'s docstring, but it is not itself a
theorem in this library, so "the conclusion of `SDF-04` is false at that `r`" is asserted at the
literature/hand-check level here, not at the Lean level. -/

section Sdf04Pins

/-- `∑ δ ∈ (1:ℕ).divisors, rPinOne δ = 24 = 2 · 12`.  The weight witness for the level-one pin;
computed outside Lean first (`divisors 1 = [1]`, `r` reads `[24]`). -/
theorem rPinOne_weight : (∑ δ ∈ (1 : ℕ).divisors, rPinOne δ) = 2 * 12 := by decide

/-- `∑ δ ∈ (6:ℕ).divisors, rPinSix δ = 1 + 11 + 11 + 1 = 24 = 2 · 12`.  The weight witness for the
load-bearing level-six pin; computed outside Lean first. -/
theorem rPinSix_weight : (∑ δ ∈ (6 : ℕ).divisors, rPinSix δ) = 2 * 12 := by decide

/-- `∑ δ ∈ (6:ℕ).divisors, 0 = 0 = 2 · 0`.  The weight witness for the degenerate pin. -/
theorem zeroExp_weight_level_six : (∑ δ ∈ (6 : ℕ).divisors, (0 : EtaExp) δ) = 2 * 0 := by decide

/-- **`SDF-04` PIN A — level one, `r = (24)` (`Δ = η²⁴`), `k = 12`.**  `SDF-04`'s equation, written
out at this instance and discharged by the two rewrites the general lemma claims suffice.

DEGENERATE IN ONE RESPECT, recorded so it is not oversold: at `N = 1` the only divisor is its own
dual, so the collapse step is a syntactic no-op here and this pin carries no evidence about the
divisor involution.  What it does carry is the external cross-check below. -/
theorem selfDual_raw_pin_level_one {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 1 rPinOne (-(1 / (((1 : ℕ) : ℂ) * z)))
      = I ^ (-(12 : ℤ)) * ((1 : ℕ) : ℂ) ^ (12 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) : ℝ) : ℂ)⁻¹
        * z ^ (12 : ℤ) * etaQuotient 1 rPinOne z := by
  rw [etaQuotient_fricke (N := 1) one_pos rPinOne (k := 12) rPinOne_weight hz,
    etaQuotient_congr_divisors (N := 1) (r := fun δ => rPinOne (1 / δ)) (s := rPinOne) z
      (fun δ hδ => (selfDual_cond_pin_level_one δ hδ).symm)]

/-- **`SDF-04` PIN A, EXTERNAL CROSS-CHECK — the level-one instance is `η(-1/z)²⁴ = z¹² η(z)²⁴`.**

`PIN A`'s constant is evaluated here — `divisors 1 = {1}`, `∏ δ^{r δ} = 1²⁴ = 1`, `√1 = 1`,
`N^k = 1¹² = 1`, `i^{-12} = 1` — leaving exactly the `S`-transformation law of the discriminant.
That conclusion is `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`, sorry-free), which is in
turn checked there against MATHLIB's `discriminant_S_invariant`.

DERIVED, NOT CITED — and this is checked, not asserted.  The proof starts from
`selfDual_raw_pin_level_one` and names neither `eta_S_via_fricke` nor `discriminant_S_invariant`.
Both of those are in scope here (`EtaQuotientModularity` is imported), so absence from the source
text is not by itself enough; what closes the gap is that every tactic below except `norm_num`
takes an EXPLICIT lemma list, and neither target carries `@[simp]` — verified this run by grep over
this library and over the pinned Mathlib (`Mathlib/NumberTheory/ModularForms/Discriminant.lean:143`
declares `discriminant_S_invariant` as a bare `lemma`) — so `norm_num`'s default simp set cannot
reach them either.  This is therefore a genuine agreement between two independent derivations
rather than a restatement of one. -/
theorem selfDual_raw_pin_level_one_is_eta_S {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / z)) ^ (24 : ℕ) = z ^ (12 : ℕ) * ModularForm.eta z ^ (24 : ℕ) := by
  have h := selfDual_raw_pin_level_one hz
  simp only [etaQuotient, Nat.divisors_one, Finset.prod_singleton, Nat.cast_one, one_mul,
    rPinOne] at h
  have hI : (I : ℂ) ^ (-(12 : ℤ)) = 1 := by
    have h12 : (I : ℂ) ^ (12 : ℕ) = 1 := by
      rw [show (12 : ℕ) = 4 * 3 by norm_num, pow_mul, Complex.I_pow_four, one_pow]
    rw [show (-(12 : ℤ)) = -((12 : ℕ) : ℤ) by norm_num, _root_.zpow_neg, zpow_natCast, h12, inv_one]
  rw [hI] at h
  norm_num at h
  rw [one_div]
  exact h

/-- **`SDF-04` PIN B — level six, `r = (1, 11, 11, 1)` on `(1, 2, 3, 6)`, `k = 12`.  THE
LOAD-BEARING PIN.**  The only instance here with `N > 1` and a non-constant exponent vector, so the
dual quotient `∏ η(δz)^{r(6/δ)}` really does list its factors in the reversed order `[1, 11, 11, 1]`
against `[1, 11, 11, 1]` and must be collapsed by `SDF-01` rather than by `rfl`.

A statement that had transposed the divisor pairing would still close PINs A, C and D and would
fail here — cf. `not_selfDual_pin_mispaired`, whose vector carries the SAME weight `∑ r δ = 24`. -/
theorem selfDual_raw_pin_level_six {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = I ^ (-(12 : ℤ)) * ((6 : ℕ) : ℂ) ^ (12 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) : ℝ) : ℂ)⁻¹
        * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z := by
  rw [etaQuotient_fricke (N := 6) (by norm_num) rPinSix (k := 12) rPinSix_weight hz,
    etaQuotient_congr_divisors (N := 6) (r := fun δ => rPinSix (6 / δ)) (s := rPinSix) z
      (fun δ hδ => (selfDual_cond_pin_level_six δ hδ).symm)]

/-- **`SDF-04` PIN C — the degenerate vector `r ≡ 0` at level six, `k = 0`.**  Every exponent is
`0`, both quotients are the constant `1`, and the constant is `i⁰ · 6⁰ · (√1)⁻¹ · z⁰ = 1`.

DEGENERATE BY CONSTRUCTION: true for every `N`, and `k = 0` makes `N^k = 1`, so a statement that
had accidentally proved only `k = 0` would still pass here.  It is a floor certifying that
`SDF-04`'s equation is not mis-indexed into something empty or unsatisfiable — not evidence about
the exponents or the involution. -/
theorem selfDual_raw_pin_zero_exp {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 (0 : EtaExp) (-(1 / (((6 : ℕ) : ℂ) * z)))
      = I ^ (-(0 : ℤ)) * ((6 : ℕ) : ℂ) ^ (0 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ ((0 : EtaExp) δ)) : ℝ) : ℂ)⁻¹
        * z ^ (0 : ℤ) * etaQuotient 6 (0 : EtaExp) z := by
  rw [etaQuotient_fricke (N := 6) (by norm_num) (0 : EtaExp) (k := 0) zeroExp_weight_level_six hz,
    etaQuotient_congr_divisors (N := 6) (r := fun δ => (0 : EtaExp) (6 / δ)) (s := (0 : EtaExp)) z
      (fun δ hδ => (selfDual_cond_pin_zero_exp δ hδ).symm)]

/-- **`SDF-04` PIN D — NEGATIVE EXPONENTS: level four, `r = (-2, 6, -2)` on `(1, 2, 4)`, `k = 1`.**

Every other pin in this section has non-negative exponents, so its eta quotient is a genuine
product and no factor is ever inverted.  This one inverts two of the three.  Level four also
contributes the only divisor here that is its OWN dual (`4 / 2 = 2`), a fixed point of `δ ↦ N/δ`
that levels `1`, `2` and `6` do not have, so the collapse must handle a diagonal term as well as a
transposed pair.  Hypotheses supplied by `rPinLevelFourNeg_selfDual` and `rPinLevelFourNeg_weight`,
both already sorry-free above. -/
theorem selfDual_raw_pin_level_four_neg {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 4 rPinLevelFourNeg (-(1 / (((4 : ℕ) : ℂ) * z)))
      = I ^ (-(1 : ℤ)) * ((4 : ℕ) : ℂ) ^ (1 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourNeg δ)) : ℝ) : ℂ)⁻¹
        * z ^ (1 : ℤ) * etaQuotient 4 rPinLevelFourNeg z := by
  rw [etaQuotient_fricke (N := 4) (by norm_num) rPinLevelFourNeg (k := 1)
      rPinLevelFourNeg_weight hz,
    etaQuotient_congr_divisors (N := 4) (r := fun δ => rPinLevelFourNeg (4 / δ))
      (s := rPinLevelFourNeg) z (fun δ hδ => (rPinLevelFourNeg_selfDual δ hδ).symm)]

end Sdf04Pins


/-- **`SDF-04` — THE EIGENFORM RELATION**, in the shape inherited verbatim from
`etaQuotient_fricke`: the same `r` now appears on both sides, and the constant is still written
`i^{-k} · N^k · s^{-1/2}`.

This is the direct corollary the run targets.  The **only** step is replacing the dual quotient
`etaQuotient N (fun δ => r (N / δ)) z` by `etaQuotient N r z` via `etaQuotient_congr_divisors`
(`SDF-01`) and the self-duality hypothesis.  If discharging it needs more than that, the
statement is wrong — stop and report rather than pushing.

Kept separate from `SDF-05` on purpose, so that "collapse the dual quotient" (trivial, uses only
`SDF-01`) is never conflated with "simplify the constant" (needs `SDF-02`, the arithmetic). -/
theorem etaQuotient_fricke_selfDual_raw {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient N r (-(1 / ((N : ℂ) * z)))
      = I ^ (-k) * (N : ℂ) ^ k
        * ((Real.sqrt (∏ δ ∈ N.divisors, (δ : ℝ) ^ (r δ)) : ℝ) : ℂ)⁻¹
        * z ^ k * etaQuotient N r z := by
  -- The whole proof.  `etaQuotient_fricke` supplies the transformation law with the DUAL exponent
  -- vector on the right; `etaQuotient_congr_divisors` (`SDF-01`) replaces that dual quotient by
  -- the original one, its hypothesis being `hr` read backwards.  Note the `.symm`: `hr` reads
  -- `r δ = r (N/δ)` and the congruence needs `(fun δ => r (N/δ)) δ = r δ`.  The second `rw` closes
  -- the goal by `rfl` — there is no residual obligation, which is what the four pins above check.
  rw [etaQuotient_fricke hN r hk hz,
    etaQuotient_congr_divisors (N := N) (r := fun δ => r (N / δ)) (s := r) z
      (fun δ hδ => (hr δ hδ).symm)]

/-! ### `SDF-05` pins — the eigenform relation with the CLOSED-FORM eigenvalue

PINS FIRST, as everywhere else in this file, and — like the `SDF-04` pins — stated as EXPLICIT
INSTANCES OF `SDF-05`'s OWN EQUATION at concrete `(N, r, k)`, with `frickeEigenvalue N k` in the
constant slot.  **None of them invokes `etaQuotient_fricke_selfDual`**: they are declared ABOVE it
in this same module, so Lean's scoping makes referring to it impossible, and the compiler rather
than this comment enforces that.  They are therefore evidence about the route, not consequences of
it.  Each is discharged along exactly the route the general lemma claims — the `SDF-04` shape, then
`SDF-03`'s constant collapse read backwards, then `ring` for the re-association.

WHAT IS NEW HERE, relative to the `SDF-04` pins, and the only thing these test: that the constant
`i^{-k} · N^k · s^{-1/2}` — which still mentions the exponent vector, through `s = ∏_{δ ∣ N} δ^{r δ}`
— really does collapse to `i^{-k} · √(N^k)`, which does not.  The two eta quotients are untouched;
`SDF-04` already settled them.

Every value was computed OUTSIDE Lean first, in exact arithmetic this session, and only then
asserted here; none was adjusted to match a proof.  The two right-hand columns are reached by
DIFFERENT routes — through `s`, and through `√(N^k)` — and agree in every row, which is `SDF-03`
checked at five instances:

| `N` | `r` | `k` | `s = ∏ δ^{r δ}` | `i^{-k} · N^k · s^{-1/2}` | `frickeEigenvalue N k` |
|-----|-----|-----|-----------------|---------------------------|------------------------|
| 1 | `(24)` | 12 | `1` | `1 · 1 · 1 = 1` | `1` |
| 6 | `(1,11,11,1)` | 12 | `6¹² = 2176782336` | `1 · 2176782336 · 46656⁻¹ = 46656` | `46656` |
| 6 | `0` | 0 | `1` | `1 · 1 · 1 = 1` | `1` |
| 4 | `(-2,6,-2)` | 1 | `4` | `(-i) · 4 · 2⁻¹ = -2i` | `-2i` |
| 6 | `(-1,-11,-11,-1)` | -12 | `6⁻¹² = 1/2176782336` | `1 · 6⁻¹² · 46656 = 1/46656` | `1/46656` |

The regimes are the three this run's discipline names — the `N = 1`, `k = 12` case underlying the
already sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`); a genuine `N > 1`
self-dual vector with NON-constant entries; and the degenerate `r ≡ 0` — plus two more, because a
sign or branch error survives all three: NEGATIVE exponents at an ODD weight (level four, where
`i^{-k}` is imaginary, `s` passes through `4⁻²`, and `4 / 2 = 2` is a fixed point of the
involution), and a NEGATIVE weight (level six, where `N^k` and `√(N^k)` are proper fractions).

Four of the five are then re-stated with the eigenvalue REPLACED BY ITS NUMERAL, through the
`frickeEigenvalue_pin_*` lemmas of `SDF-DEF-02` — which were computed independently of `SDF-03`,
from `Real.sqrt_sq`, and never through `s`.  Those are the rows above read left-to-right and
right-to-left meeting in the middle; a drifted general statement would return a different number
there while remaining provable in its own terms.

NEGATIVE CONTROLS, already sorry-free above and deliberately not restated here:
`prod_zpow_pin_asymmetric_ne` exhibits an `r` at `N = 2` satisfying the WEIGHT hypothesis exactly
and failing the conclusion, so `hr` is load-bearing and cannot be dropped;
`prod_zpow_pin_mispaired_ne` does the same for a vector self-dual under the WRONG involution;
`frickeEigenvalue_pin_not_natPow` separates `√(N^k)` from `N^k`; `fricke_const_pin_not_mul`
separates `s^{-1/2}` from `s^{+1/2}`.

NAMING: the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced" — see
this file's header. -/

section Sdf05Pins

/-- **`SDF-05` PIN A — level one, `r = (24)` (`Δ = η²⁴`), `k = 12`, eigenvalue `1`.**

DEGENERATE IN TWO RESPECTS, recorded so it is not oversold: at `N = 1` the divisor involution is a
syntactic no-op, and `s = N^k = 1` makes the constant collapse invisible.  It is a floor, and the
instance underlying the already sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`). -/
theorem selfDual_eigen_pin_level_one {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 1 rPinOne (-(1 / (((1 : ℕ) : ℂ) * z)))
      = frickeEigenvalue 1 12 * z ^ (12 : ℤ) * etaQuotient 1 rPinOne z := by
  rw [selfDual_raw_pin_level_one hz, frickeEigenvalue,
    ← fricke_const_selfDual (N := 1) one_pos (r := rPinOne) selfDual_cond_pin_level_one
      (k := 12) rPinOne_weight]
  ring

/-- **`SDF-05` PIN A, numeral form** — the same instance with the eigenvalue evaluated to the
hand-computed `1`, through `frickeEigenvalue_pin_level_one` (`SDF-DEF-02`, proved from
`Real.sqrt_one` and `I_zpow_neg_twelve`, never through `s`). -/
theorem selfDual_eigen_pin_level_one_value {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 1 rPinOne (-(1 / (((1 : ℕ) : ℂ) * z)))
      = z ^ (12 : ℤ) * etaQuotient 1 rPinOne z := by
  rw [selfDual_eigen_pin_level_one hz, frickeEigenvalue_pin_level_one, one_mul]

/-- **`SDF-05` PIN B — level six, `r = (1, 11, 11, 1)` on `(1, 2, 3, 6)`, `k = 12`, eigenvalue
`46656 = 6⁶`.  THE LOAD-BEARING PIN.**

The only instance here with `N > 1` AND a non-constant exponent vector, hence the only one where
`s = ∏ δ^{r δ} = 2176782336` is a genuine arithmetic coincidence with `N^k` rather than `1 = 1`,
and the only one where the collapse `N^k · s^{-1/2} = √(N^k)` moves an actual number:
`2176782336 · 46656⁻¹ = 46656`.  A statement that had transposed the divisor pairing would still
close PINs A and C and would fail here — cf. `prod_zpow_pin_mispaired_ne`, whose vector carries the
SAME weight `∑ r δ = 24`. -/
theorem selfDual_eigen_pin_level_six {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = frickeEigenvalue 6 12 * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z := by
  rw [selfDual_raw_pin_level_six hz, frickeEigenvalue,
    ← fricke_const_selfDual (N := 6) (by norm_num) (r := rPinSix) selfDual_cond_pin_level_six
      (k := 12) rPinSix_weight]
  ring

/-- **`SDF-05` PIN B, numeral form — the load-bearing numeric cross-check.**  The eigenvalue is
`46656`, computed by hand as `6⁶` and proved by `frickeEigenvalue_pin_level_six` from
`Real.sqrt_sq` at `√(6¹²)` — a route that never touches `s = ∏ δ^{r δ}`.  Reaching the same
numeral through `SDF-03`'s collapse (`2176782336 · 46656⁻¹`) is the agreement of two independent
computations. -/
theorem selfDual_eigen_pin_level_six_value {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = 46656 * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z := by
  rw [selfDual_eigen_pin_level_six hz, frickeEigenvalue_pin_level_six]

/-- **`SDF-05` PIN C — the degenerate vector `r ≡ 0` at level six, `k = 0`, eigenvalue `1`.**

DEGENERATE BY CONSTRUCTION: `k = 0` makes `N^k = 1` and `z^k = 1` for every `N`, so any lemma that
accidentally proved only the `k = 0` case would still pass here.  It is a floor certifying the
equation is not mis-indexed into something empty or unsatisfiable, not evidence about the
exponents or the involution. -/
theorem selfDual_eigen_pin_zero_exp {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 (0 : EtaExp) (-(1 / (((6 : ℕ) : ℂ) * z)))
      = frickeEigenvalue 6 0 * z ^ (0 : ℤ) * etaQuotient 6 (0 : EtaExp) z := by
  rw [selfDual_raw_pin_zero_exp hz, frickeEigenvalue,
    ← fricke_const_selfDual (N := 6) (by norm_num) (r := (0 : EtaExp)) selfDual_cond_pin_zero_exp
      (k := 0) zeroExp_weight_level_six]
  ring

/-- **`SDF-05` PIN C, numeral form** — eigenvalue `1`, via `frickeEigenvalue_pin_zero_weight`. -/
theorem selfDual_eigen_pin_zero_exp_value {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 (0 : EtaExp) (-(1 / (((6 : ℕ) : ℂ) * z)))
      = etaQuotient 6 (0 : EtaExp) z := by
  rw [selfDual_eigen_pin_zero_exp hz, frickeEigenvalue_pin_zero_weight, one_mul, zpow_zero,
    one_mul]

/-- The eigenvalue at PIN D's instance, `(N, k) = (4, 1)`: `λ = i^{-1} · √(4¹) = (-i) · 2 = -2i`.

Computed by hand first.  This is the only ODD weight in the `SDF-05` pin set, hence the only place
where `i^{-k}` is imaginary and a lost or conjugated `i` is visible; and it is proved from
`I_zpow_neg_one` and `sqrt_natPow_level_four` alone, with no reference to any exponent vector. -/
theorem frickeEigenvalue_pin_level_four : frickeEigenvalue 4 1 = -(2 * I) := by
  rw [frickeEigenvalue, I_zpow_neg_one, sqrt_natPow_level_four]
  push_cast
  ring

/-- **`SDF-05` PIN D — NEGATIVE EXPONENTS at an ODD weight: level four,
`r = (-2, 6, -2)` on `(1, 2, 4)`, `k = 1`, eigenvalue `-2i`.**

The only pin here with negative exponents, so `s = 1⁻² · 2⁶ · 4⁻² = 4` genuinely passes through
`zpow` at negative arguments; the only one with `k` odd, so `i^{-k} = -i` is not real; and the only
level with a divisor that is its OWN dual (`4 / 2 = 2`), a fixed point of `δ ↦ N/δ`. -/
theorem selfDual_eigen_pin_level_four_neg {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 4 rPinLevelFourNeg (-(1 / (((4 : ℕ) : ℂ) * z)))
      = frickeEigenvalue 4 1 * z ^ (1 : ℤ) * etaQuotient 4 rPinLevelFourNeg z := by
  rw [selfDual_raw_pin_level_four_neg hz, frickeEigenvalue,
    ← fricke_const_selfDual (N := 4) (by norm_num) (r := rPinLevelFourNeg)
      rPinLevelFourNeg_selfDual (k := 1) rPinLevelFourNeg_weight]
  ring

/-- **`SDF-05` PIN D, numeral form** — eigenvalue `-2i`, matching the hand computation
`i^{-1} · √4 = -2i`.  Through `SDF-03` the same constant is reached as `4¹ · 2⁻¹ = 2` times
`i^{-1}`; the two agree. -/
theorem selfDual_eigen_pin_level_four_neg_value {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 4 rPinLevelFourNeg (-(1 / (((4 : ℕ) : ℂ) * z)))
      = -(2 * I) * z ^ (1 : ℤ) * etaQuotient 4 rPinLevelFourNeg z := by
  rw [selfDual_eigen_pin_level_four_neg hz, frickeEigenvalue_pin_level_four]

/-- **`SDF-05` PIN E — NEGATIVE WEIGHT: level six, `r = (-1, -11, -11, -1)`, `k = -12`,
eigenvalue `1/46656`.**

The only pin with `k < 0`, where `N^k = 6⁻¹²` and `√(N^k) = 1/46656` are proper fractions rather
than integers.  A version of `SDF-05` that had silently assumed `k ≥ 0` — a `k.toNat` anywhere, or
positivity of `N^k` derived from `pow_pos` rather than `zpow_pos` — would satisfy PINs A–D and fail
here.

STATED HONESTLY ABOUT ITS ROUTE: unlike PINs A–D there is no `selfDual_raw_pin_*` at this instance,
so this one starts from the GENERAL `SDF-04` lemma `etaQuotient_fricke_selfDual_raw` instantiated at
`(6, rPinLevelSixNeg, -12)` rather than from a hand-written instance.  That is sound — `SDF-04` is
closed and guarded — but it means this pin is evidence about the constant collapse only, not about
the dual-quotient collapse, which PIN B already carries. -/
theorem selfDual_eigen_pin_level_six_neg {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 rPinLevelSixNeg (-(1 / (((6 : ℕ) : ℂ) * z)))
      = frickeEigenvalue 6 (-12) * z ^ (-12 : ℤ) * etaQuotient 6 rPinLevelSixNeg z := by
  rw [etaQuotient_fricke_selfDual_raw (N := 6) (by norm_num) (r := rPinLevelSixNeg)
      rPinLevelSixNeg_selfDual (k := -12) rPinLevelSixNeg_weight hz, frickeEigenvalue,
    ← fricke_const_selfDual (N := 6) (by norm_num) (r := rPinLevelSixNeg)
      rPinLevelSixNeg_selfDual (k := -12) rPinLevelSixNeg_weight]
  ring

/-- **`SDF-05` PIN E, numeral form** — eigenvalue `46656⁻¹`, via
`frickeEigenvalue_pin_level_six_neg` (`√(6⁻¹²) = 1/46656` from `Real.sqrt_sq`, and `i^{12} = 1`). -/
theorem selfDual_eigen_pin_level_six_neg_value {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 6 rPinLevelSixNeg (-(1 / (((6 : ℕ) : ℂ) * z)))
      = (46656 : ℂ)⁻¹ * z ^ (-12 : ℤ) * etaQuotient 6 rPinLevelSixNeg z := by
  rw [selfDual_eigen_pin_level_six_neg hz, frickeEigenvalue_pin_level_six_neg]


/-! #### `SDF-PIN-02` — the level-two pin, `f = η(z)·η(2z)`, in FULLY EXPANDED `η` form

Declared HERE, inside `section Sdf05Pins` and therefore ABOVE `etaQuotient_fricke_selfDual`, so
that Lean's scoping — not a docstring — makes it impossible for this pin to be a consequence of the
general `SDF-05` lemma it is evidence for.

WHAT THIS NODE ADDS, stated so it is not oversold.  It is **not** the `(2, 1)` constant collapse:
`frickeEigenvalue_pin_level_two_weight_one` (`SDF-DEF-02`, above) already proves
`frickeEigenvalue 2 1 = -(i·√2)` sorry-free and guarded, from `I_zpow_neg_one` and `Real.sqrt_sq`,
never through `s`.  Nor is it "the only odd weight" — `selfDual_eigen_pin_level_four_neg` (`k = 1`,
`λ = -2i`) already covers odd `k`.  What is genuinely new is two things:

* it is the ONLY pin in this file stated in fully expanded `ModularForm.eta` form rather than
  through `etaQuotient N r (…)`, so it is the only one that exercises the `etaQuotient` UNFOLDING
  (`divisors 2 = {1, 2}`, `Finset.prod_pair`, `zpow_one`, the `1 · w` and `((2:ℕ):ℂ)` casts) that
  every other pin here skips; and
* it is the only instance with an independently hand-derived counterpart already proved UPSTREAM —
  `fricke_level_two_pin` (`EtaQuotientModularity.lean:2285`, sorry-free), which states the SAME
  equation with the constant left in `etaQuotient_fricke`'s raw spelling `i⁻¹ · 2 · (√2)⁻¹`.  That
  the two spellings agree is made a BUILD OBLIGATION, not a docstring assertion, by
  `selfDual_eigen_pin_level_two_routes_agree` and `selfDual_eigen_pin_level_two_eta_via_upstream`
  at the end of this module.

ROUTE INDEPENDENCE, checked rather than argued.  `fricke_level_two_pin` is in scope here
(`EtaQuotientModularity` is imported), and as a bare equation this node IS that theorem with the
constant respelled, so absence from the source text would not by itself be enough.  Two receipts:
every tactic below takes an EXPLICIT lemma list (no bare `norm_num`, no bare `simp`), and
`fricke_level_two_pin` carries no `@[simp]` — verified this run by whole-file scan for `@[simp]` and
for `attribute [simp]` over `EtaQuotientModularity.lean`, which returns fifteen hits, none of them
this theorem — so no default simp set can reach it either.  The kernel-term walk in
`scratch_sdfpin02/DepWalk.lean` checks the same thing on the compiled term.

NUMERICS, computed OUTSIDE Lean this run at 40 decimal digits, from `η`'s product formula with 800
factors, and only then asserted: the equation below holds to relative error `≤ 5.9e-41` at
`z ∈ {i, 2i, 1+i, 0.3+0.7i, -0.4+1.3i, 0.13+0.41i}`, while the CONJUGATE constant `+i√2` fails with
relative error `2.0` at every one of them.  No value here was adjusted to fit a proof.

NAMING, deliberate and worth reading before grepping.  This node was proposed as
`selfDual_pin_level_two`.  That name is one underscore from the EXISTING
`selfDual_pin_level_two_weight_one` (line 983), which is a five-way HYPOTHESIS CONJUNCTION at the
same instance `(2, rPinTwo, 1)` and mentions neither `η` nor `z` — two unrelated statement shapes
under near-identical names.  The full-equation instance pins of `SDF-05` are named
`selfDual_eigen_pin_*` (`_level_one`, `_level_six`, `_zero_exp`, `_level_four_neg`,
`_level_six_neg`), that slot was free at level two, and this pin takes it; the `_eta` suffix flags
the expanded shape.  And: the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never
"balanced" — see this file's header. -/

/-- The weight witness for `rPinTwo = (1, 1)`: `∑_{δ ∣ 2} r δ = 1 + 1 = 2 = 2 · 1`, so `k = 1`.
Named rather than inlined as `by decide` because three declarations below instantiate `SDF-04` and
`SDF-03` at it and must be seen to use the SAME witness. -/
theorem rPinTwo_weight : (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) = 2 * 1 := by decide

/-- `Nat.divisors 2 = {1, 2}`.  The divisor-set evaluation the `etaQuotient` unfolding needs; it is
what turns the product `∏_{δ ∣ 2} η(δz)^{r δ}` into the two-factor `η(z)·η(2z)`. -/
theorem rPinTwo_divisors_pin : (2 : ℕ).divisors = {1, 2} := by decide

/-- The exponent vector really reads `(1, 1)` on `{1, 2}` — and is `0` off the divisor set.

The second half matters: `fricke_level_two_pin` upstream is stated at the CONSTANT vector
`fun _ => (1 : ℤ)`, which is a DIFFERENT function from `rPinTwo` (they disagree at `3` and at `4`)
agreeing with it only on `Nat.divisors 2`.  So this pin records that the two nodes' agreement is an
agreement on the divisor set, not a syntactic identity of exponent vectors. -/
theorem rPinTwo_values_pin :
    rPinTwo 1 = 1 ∧ rPinTwo 2 = 1 ∧ rPinTwo 3 = 0 ∧ rPinTwo 4 = 0 := by decide

/-- `√(2¹) = √2`.  The `SDF-03` radicand lemma at level two — the one value in that family left
SYMBOLIC, because `√2` is irrational and pinning it to a decimal would be false precision.  Contrast
`sqrt_natPow_level_six` (`46656`) and `sqrt_natPow_level_four` (`2`), which are integers. -/
theorem sqrt_natPow_level_two : Real.sqrt (((2 : ℕ) : ℝ) ^ (1 : ℤ)) = Real.sqrt 2 := by
  norm_num

/-- `2 · (√2)⁻¹ = √2` in `ℂ`.  **THE ONE GENUINE ARITHMETIC STEP OF THIS NODE**, isolated and named
because `ring` and `norm_num` alone CANNOT close it — `√2` is an atom to both, and the identity is
`a · (√a)⁻¹ = √a` at `a = 2`, which needs `Real.mul_self_sqrt` and `Real.sqrt_ne_zero'`.

Proved as an identity in `ℝ` first and only then cast into `ℂ`, exactly as `fricke_const_selfDual`
(`SDF-03`) does: at no point does a complex square root or a branch choice appear. -/
theorem two_mul_inv_sqrt_two :
    (2 : ℂ) * ((Real.sqrt 2 : ℝ) : ℂ)⁻¹ = ((Real.sqrt 2 : ℝ) : ℂ) := by
  have hne : (Real.sqrt 2 : ℝ) ≠ 0 := Real.sqrt_ne_zero'.mpr (by norm_num)
  have hR : (2 : ℝ) * (Real.sqrt 2)⁻¹ = Real.sqrt 2 := by
    rw [inv_eq_one_div, mul_one_div, div_eq_iff hne, Real.mul_self_sqrt (by norm_num)]
  have hC := congrArg (fun x : ℝ => (x : ℂ)) hR
  push_cast at hC
  exact hC

/-- **`SDF-03` PIN F — level two, `r = (1, 1)`, `k = 1`.**  `s = 1¹ · 2¹ = 2`, so the constant is
`2¹ · 2^{-1/2} = 2 · (√2)⁻¹ = √2`, and `√(2¹) = √2`: the two routes meet at an IRRATIONAL value.

The `SDF-03` pin family (`fricke_const_pin_level_one`, `_level_six`, `_zero_exp`, `_level_four_neg`,
`_level_six_neg`) had no level-two member; every one of its radicands was `1`, `2`, `46656` or
`1/46656`, i.e. rational, so the collapse `N^k · s^{-1/2} = √(N^k)` was only ever exercised where
both sides are closed integers or their reciprocals.  This pin exercises it where neither side is
rational, which is the case `two_mul_inv_sqrt_two` exists for. -/
theorem fricke_const_pin_level_two :
    ((2 : ℕ) : ℂ) ^ (1 : ℤ)
        * ((Real.sqrt (∏ δ ∈ (2 : ℕ).divisors, (δ : ℝ) ^ (rPinTwo δ)) : ℝ) : ℂ)⁻¹
      = ((Real.sqrt 2 : ℝ) : ℂ) := by
  rw [prod_zpow_pin_level_two, sqrt_natPow_level_two, Nat.cast_ofNat, zpow_one,
    two_mul_inv_sqrt_two]

/-- `√2 ∉ {1, 2}` — the NON-DEGENERACY of the level-two radicand, so `fricke_const_pin_level_two`
is not secretly one of the collapses the other pins already perform.

`√2 ≠ 1` is what stops this level from degenerating like `N = 1` (where `s = 1` makes `(√s)⁻¹ = √s`,
`selfDual_pin_level_one_no_evidence_radicand`); `√2 ≠ 2` is what stops `√(N^k)` from being confused
with `N^k` at this instance (compare `frickeEigenvalue_pin_not_natPow` at level six). -/
theorem sqrt_two_nondegenerate : Real.sqrt 2 ≠ 1 ∧ Real.sqrt 2 ≠ 2 := by
  constructor
  · intro h
    have hsq := congrArg (fun x : ℝ => x * x) h
    simp only [Real.mul_self_sqrt (by norm_num : (0 : ℝ) ≤ 2)] at hsq
    norm_num at hsq
  · intro h
    have hsq := congrArg (fun x : ℝ => x * x) h
    simp only [Real.mul_self_sqrt (by norm_num : (0 : ℝ) ≤ 2)] at hsq
    norm_num at hsq

/-- The `(2, 1)` eigenvalue in THIS node's spelling, `-i · √2`.

`frickeEigenvalue_pin_level_two_weight_one` proves `-(i · √2)`.  The two are equal by `neg_mul`,
NOT by `rfl` — the same wrinkle this file's header records at lines 225-227 for
`selfDual_pin_level_two_weight_one`.  It is given its own name here so that the respelling is a
single machine-checked step rather than something absorbed into a `ring` inside a longer proof. -/
theorem frickeEigenvalue_pin_level_two_weight_one_spelling :
    frickeEigenvalue 2 1 = -I * ((Real.sqrt 2 : ℝ) : ℂ) := by
  rw [frickeEigenvalue_pin_level_two_weight_one]
  ring

/-- **`SDF-05` PIN F — level two, `r = (1, 1)` on `(1, 2)`, `k = 1`, eigenvalue `-i√2`.**

`SDF-05`'s own equation at the instance `(N, r, k) = (2, rPinTwo, 1)`, i.e. `f = η(z)·η(2z)`, the
smallest non-degenerate self-dual eta quotient.  Reached along exactly the route the general lemma
claims — `SDF-04`'s raw shape, then `SDF-03`'s constant collapse read backwards, then `ring` — and,
like every pin in this section, declared ABOVE `etaQuotient_fricke_selfDual`, so it cannot be a
consequence of it.

Unlike PINs A-E this instance's constant is IRRATIONAL (`√2`), which is what
`fricke_const_pin_level_two` and `sqrt_two_nondegenerate` above exist to certify. -/
theorem selfDual_eigen_pin_level_two {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 2 rPinTwo (-(1 / (((2 : ℕ) : ℂ) * z)))
      = frickeEigenvalue 2 1 * z ^ (1 : ℤ) * etaQuotient 2 rPinTwo z := by
  rw [etaQuotient_fricke_selfDual_raw (N := 2) (by norm_num) (r := rPinTwo)
      selfDual_cond_pin_level_two_weight_one (k := 1) rPinTwo_weight hz, frickeEigenvalue,
    ← fricke_const_selfDual (N := 2) (by norm_num) (r := rPinTwo)
      selfDual_cond_pin_level_two_weight_one (k := 1) rPinTwo_weight]
  ring

/-- **`SDF-05` PIN F, numeral form** — eigenvalue `-i√2`, through
`frickeEigenvalue_pin_level_two_weight_one` (`SDF-DEF-02`, proved from `I_zpow_neg_one` and
`Real.sqrt_sq`, a route that never touches `s = ∏ δ^{r δ}`) in this node's spelling.  Reaching the
same constant through `SDF-03`'s collapse (`2 · (√2)⁻¹`, i.e. `fricke_const_pin_level_two`) is the
agreement of two independent computations. -/
theorem selfDual_eigen_pin_level_two_value {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 2 rPinTwo (-(1 / (((2 : ℕ) : ℂ) * z)))
      = -I * ((Real.sqrt 2 : ℝ) : ℂ) * z ^ (1 : ℤ) * etaQuotient 2 rPinTwo z := by
  rw [selfDual_eigen_pin_level_two hz, frickeEigenvalue_pin_level_two_weight_one_spelling]

/-- **`SDF-PIN-02` — THE NODE.  `SDF-05` at level two, written out in `ModularForm.eta`:**

```
η(-1/(2z)) · η(2 · (-1/(2z)))  =  -i·√2 · z · (η(z) · η(2z))
```

The ONLY pin in this file whose statement mentions no `etaQuotient`, no `EtaExp` and no
`frickeEigenvalue` — every definition this module introduces has been unfolded away, leaving an
identity between products of values of MATHLIB's `ModularForm.eta`.  That is what it is for: a
reader who does not trust `IsFrickeSelfDual`, `frickeEigenvalue` or the `etaQuotient` bookkeeping can
check this line against `η` alone.

The unfolding is the only step here the other `SDF-05` pins do not perform, and it is carried by an
EXPLICIT lemma list — `rPinTwo_divisors_pin`, `Finset.prod_pair`, the two `rPinTwo` values,
`zpow_one` and the casts — with no bare `norm_num` or `simp`, so `fricke_level_two_pin` (in scope,
and stating this same equation with the constant unsimplified) cannot be reached by a default simp
set.  It carries no `@[simp]` either; both receipts are recorded in this section's header.

Verified numerically OUTSIDE Lean this run at 40 dps before being asserted: relative error `≤ 5.9e-41`
at six points of `ℍ`, with the conjugate constant `+i√2` failing at relative error `2.0` at all six. -/
theorem selfDual_eigen_pin_level_two_eta {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((2 : ℂ) * z))) * ModularForm.eta ((2 : ℂ) * (-(1 / ((2 : ℂ) * z))))
      = -I * ((Real.sqrt 2 : ℝ) : ℂ) * z
        * (ModularForm.eta z * ModularForm.eta ((2 : ℂ) * z)) := by
  have h := selfDual_eigen_pin_level_two_value hz
  simp only [etaQuotient, rPinTwo_divisors_pin,
    Finset.prod_pair (show (1 : ℕ) ≠ 2 by norm_num),
    show rPinTwo 1 = 1 by decide, show rPinTwo 2 = 1 by decide,
    zpow_one, Nat.cast_one, one_mul, Nat.cast_ofNat] at h
  exact h

end Sdf05Pins

/-! ### `SDF-05` — the headline: eigenform relation with the eigenvalue in closed form -/

/-- **`SDF-05` — THE HEADLINE OF THIS FILE.**  The Fricke transform of a Fricke-self-dual eta
quotient is `λ · z^k` times the quotient **itself**, with

`λ = frickeEigenvalue N k = i^{-k} · N^{k/2}`

depending only on the level `N` and the weight `k`.  The exponent vector has vanished from the
constant; that is the whole content of self-duality.

Same statement as `SDF-04`, with the constant rewritten by `SDF-03`.

SCOPE, stated so it cannot be oversold: this is an identity between two explicit products of
values of Mathlib's `ModularForm.eta`.  It says nothing about `Γ₀(N)`-modularity, nothing about
holomorphy at the cusps, and nothing about physics — see the header. -/
theorem etaQuotient_fricke_selfDual {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient N r (-(1 / ((N : ℂ) * z)))
      = frickeEigenvalue N k * z ^ k * etaQuotient N r z := by
  -- The whole proof, in three rewrites and a re-association; there is no new mathematics here and
  -- there must not be — the arithmetic all happened in `SDF-02` / `SDF-03`.
  -- (1) `SDF-04` supplies the eigenform relation with the constant still in `etaQuotient_fricke`'s
  -- raw shape `i^{-k} · N^k · s^{-1/2}`, `s = ∏_{δ ∣ N} δ^{r δ}`.  This is the step that used `hr`
  -- to collapse the DUAL quotient; from here on both eta quotients are fixed.
  rw [etaQuotient_fricke_selfDual_raw hN hr hk hz, frickeEigenvalue,
  -- (2) `SDF-03` read BACKWARDS: it expands the `√(N^k)` sitting inside `frickeEigenvalue` on the
  -- right into `N^k · s^{-1/2}`, so that both sides are products of the SAME five factors.  The
  -- backwards orientation is deliberate — rewriting forwards would have to fire inside the
  -- left-associated raw constant, which is why the `-- OPEN:` note that preceded this proof asked
  -- for a `mul_assoc` first.  `√((N:ℝ)^k)` occurs only on the right, so no other site can match.
    ← fricke_const_selfDual hN hr hk]
  -- (3) The two sides now carry the SAME five factors and differ only by bracketing: the left is
  -- `(((i^{-k} · N^k) · s^{-1/2}) · z^k) · f`, inherited left-associated from `etaQuotient_fricke`,
  -- while the right is `((i^{-k} · (N^k · s^{-1/2})) · z^k) · f`, because step (2) substituted a
  -- product into `frickeEigenvalue`'s second factor.  `ring` closes that; both `etaQuotient` terms
  -- and `(↑√s)⁻¹` are atoms to it and are never unfolded, so nothing here can smuggle in a
  -- numerical step.
  ring

/-! ### `SDF-06` pins — the NORMALISED equation at concrete `(N, r, k)`

PINS FIRST, as everywhere else in this file, and — like the `SDF-04` and `SDF-05` pins — stated as
EXPLICIT INSTANCES OF `SDF-06`'s OWN EQUATION at concrete `(N, r, k)`.  **None of them invokes
`etaQuotient_fricke_selfDual_normalized`**: they are declared ABOVE it in this same module, so
Lean's scoping makes referring to it impossible, and the compiler rather than this comment enforces
that.  Each is discharged along exactly the route the general lemma claims — the `SDF-05` relation
at that instance, then the two cancellations — but with the constant a NUMERAL, so the cancellation
a pin performs is `46656⁻¹ · 46656 = 1` rather than `inv_mul_cancel₀` at a symbolic `√(N^k)`.

WHAT IS NEW HERE, relative to the `SDF-05` pins, and the only thing these test: that dividing by
`√(N^k)` and by `z^k` leaves `i^{-k}` and nothing else — in particular that what survives is a
ROOT OF UNITY, with no residual power of the level.

WHAT DOES **NOT** HAPPEN HERE, said because the normalised form invites the opposite reading: the
`N`-dependence does not cancel because of anything visible in `SDF-06`.  It cancels because
`∏_{δ ∣ N} δ^{r δ} = N^k` on a self-dual vector — `prod_zpow_selfDual` (`SDF-02`), the one genuinely
arithmetical step in this file, packaged into `ℂ` by `fricke_const_selfDual` (`SDF-03`) and absorbed
into `frickeEigenvalue` by `SDF-05`.  A reader who meets "the `N`-dependence cancels completely" and
wants the lemma that earns it should read those three, not this one: here `√(N^k)` is divided out by
a normaliser written down by hand, which is bookkeeping, not arithmetic.

Every value below was computed OUTSIDE Lean first, in exact arithmetic this session, and only then
asserted; none was adjusted to fit a proof.  `s` is listed only to show it agrees with `N^k`, which
is `SDF-02`'s content and not this node's:

| pin | `N` | `r` | `k` | `s = ∏ δ^{r δ}` | `√(N^k)` | normaliser `(√(N^k))⁻¹` | `z^{-k}` | `i^{-k}` |
|-----|-----|-----|-----|-----------------|----------|-------------------------|----------|----------|
| A | 1 | `(24)`            | 12  | `1`                 | `1`       | `1`       | `z⁻¹²` | `1`  |
| B | 6 | `(1,11,11,1)`     | 12  | `6¹² = 2176782336`  | `46656`   | `46656⁻¹` | `z⁻¹²` | `1`  |
| C | 6 | `≡ 0`             | 0   | `1`                 | `1`       | `1`       | `z⁰`   | `1`  |
| D | 4 | `(-2,6,-2)`       | 1   | `4`                 | `2`       | `2⁻¹`     | `z⁻¹`  | `-i` |
| E | 6 | `(-1,-11,-11,-1)` | -12 | `6⁻¹² = 1/2176782336` | `1/46656` | `46656` | `z¹²`  | `1`  |

The regimes are the three this run's discipline names — the `N = 1`, `k = 12` case underlying the
already sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`); a genuine `N > 1`
self-dual vector with NON-constant entries; the degenerate `r ≡ 0` — plus two that no normalised
statement should be trusted without: an ODD weight with NEGATIVE entries (D, where `i^{-k} = -i`
is not real and the normaliser `2⁻¹` genuinely halves a constant), and a NEGATIVE weight (E).

PIN E IS THE SIGN PIN OF THIS NODE, and is why the exponent is written `z^{-k}` and not `z^k`: at
`k = -12` the normalised statement carries `z^{+12}` and the normaliser `(√(6⁻¹²))⁻¹ = 46656` is
LARGER than one, so a statement that had transcribed the exponent as `z^k`, or the normaliser
uninverted, is false here while remaining true at `k = 0` (PIN C) and while failing at PIN A in a
way that is easy to mistake for a rewrite problem.  A and E move the exponent in opposite
directions; both are needed.

TACTIC-LEVEL NEGATIVE CONTROL, run this session and recorded because the general proof's `ring`
step looks like it could be doing the cancelling: `ring` ALONE cannot close
`(√(N^k))⁻¹ · z^{-k} · (i^{-k} · √(N^k) · z^k · f) = i^{-k} · f`.  It fails and reports the residual
`√(N^k) · (√(N^k))⁻¹ · z^{-k} · i^{-k} · z^k · f = i^{-k} · f`, which is correct behaviour — both
cancellations are false without `0 < N` and `z ≠ 0` (at `N = 0` or `z = 0` the left side is `0`).
So the two cancellations are genuinely carried by `inv_mul_cancel₀` and `zpow_add₀`, and `ring` only
re-associates.

NAMING: the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced" — see this
file's header. -/

section Sdf06Pins

/-- `√(1¹²) = 1`.  Degenerate: at `N = 1` the radicand is `1` for every weight, so this carries no
information about the exponent.  Proved from `Real.sqrt_one`, independently of `SDF-02` and of any
exponent vector. -/
theorem sqrt_natPow_level_one : Real.sqrt (((1 : ℕ) : ℝ) ^ (12 : ℤ)) = 1 := by
  rw [Nat.cast_one, _root_.one_zpow, Real.sqrt_one]

/-- `√(6⁰) = 1`.  The degenerate-weight radicand; `zpow_zero`, then `Real.sqrt_one`. -/
theorem sqrt_natPow_zero_weight : Real.sqrt (((6 : ℕ) : ℝ) ^ (0 : ℤ)) = 1 := by
  rw [zpow_zero, Real.sqrt_one]

/-- **`SDF-06` PIN A — level one, `r = (24)` (`Δ = η²⁴`), `k = 12`.**  The normaliser and the
eigenvalue are both `1`, so the equation reads `z⁻¹² · η(-1/z)²⁴ = η(z)²⁴`.

DEGENERATE IN TWO RESPECTS, recorded so it is not oversold: at `N = 1` the divisor involution is a
syntactic no-op, and `√(N^k) = 1` makes the normalisation invisible.  What this pin does carry is
the external cross-check `selfDual_norm_pin_level_one_is_eta_S` immediately below — and the fact
that it FIXES THE SIGN OF THE EXPONENT: with `z^{+12}` in place of `z^{-12}` the statement would
read `z¹² · η(-1/z)²⁴ = η(z)²⁴`, i.e. `z²⁴ η(z)²⁴ = η(z)²⁴`, which is false. -/
theorem selfDual_norm_pin_level_one {z : ℂ} (hz : z ∈ ℍₒ) :
    ((Real.sqrt (((1 : ℕ) : ℝ) ^ (12 : ℤ)) : ℝ) : ℂ)⁻¹ * z ^ (-12 : ℤ)
        * etaQuotient 1 rPinOne (-(1 / (((1 : ℕ) : ℂ) * z)))
      = I ^ (-12 : ℤ) * etaQuotient 1 rPinOne z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-12 : ℤ) * z ^ (12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  rw [selfDual_eigen_pin_level_one_value hz, sqrt_natPow_level_one, I_zpow_neg_twelve,
    Complex.ofReal_one, inv_one]
  calc (1 : ℂ) * z ^ (-12 : ℤ) * (z ^ (12 : ℤ) * etaQuotient 1 rPinOne z)
      = (z ^ (-12 : ℤ) * z ^ (12 : ℤ)) * (1 * etaQuotient 1 rPinOne z) := by ring
    _ = 1 * etaQuotient 1 rPinOne z := by rw [hzk, one_mul]

/-- **`SDF-06` PIN A, EXTERNAL CROSS-CHECK — the level-one normalised instance is
`z⁻¹² · η(-1/z)²⁴ = η(z)²⁴`.**

PIN A's constant is evaluated here — `divisors 1 = {1}`, `√(1¹²) = 1`, `i^{-12} = 1` — leaving the
`S`-transformation law of the discriminant with the weight factor moved to the left.  That is
`eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`, sorry-free) divided by `z¹²`, and
`eta_S_via_fricke` is in turn checked there against MATHLIB's `discriminant_S_invariant`.  So the
normalised form of this node lands, at level one, on a statement Mathlib independently proves.

DERIVED, NOT CITED, and checked rather than asserted: the proof starts from
`selfDual_eigen_pin_level_one_value` and names neither `eta_S_via_fricke` nor
`discriminant_S_invariant`.  Both are in scope (`EtaQuotientModularity` is imported), so absence
from the source text is not enough on its own; what closes the gap is that the two `simp only`s and
the rewrites take EXPLICIT lemma lists, and neither target carries `@[simp]` (re-verified this run
by grep over this library and over the pinned Mathlib), so `norm_num`'s default simp set cannot
reach them either.

The `z⁻¹²` here is a `zpow` at a NEGATIVE integer while the `η` powers are `ℕ` powers, exactly as in
`eta_S_via_fricke`; the conversion is `zpow_natCast` and is explicit in the proof. -/
theorem selfDual_norm_pin_level_one_is_eta_S {z : ℂ} (hz : z ∈ ℍₒ) :
    z ^ (-12 : ℤ) * ModularForm.eta (-(1 / z)) ^ (24 : ℕ) = ModularForm.eta z ^ (24 : ℕ) := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-12 : ℤ) * z ^ (12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  have h := selfDual_eigen_pin_level_one_value hz
  simp only [etaQuotient, Nat.divisors_one, Finset.prod_singleton, Nat.cast_one, one_mul,
    rPinOne] at h
  norm_num at h
  rw [one_div, ← zpow_natCast (ModularForm.eta (-z⁻¹)) 24,
    ← zpow_natCast (ModularForm.eta z) 24]
  push_cast
  rw [h]
  calc z ^ (-12 : ℤ) * (z ^ (12 : ℤ) * ModularForm.eta z ^ (24 : ℤ))
      = (z ^ (-12 : ℤ) * z ^ (12 : ℤ)) * ModularForm.eta z ^ (24 : ℤ) := by ring
    _ = ModularForm.eta z ^ (24 : ℤ) := by rw [hzk, one_mul]

/-- **`SDF-06` PIN B — level six, `r = (1, 11, 11, 1)` on `(1, 2, 3, 6)`, `k = 12`.  THE
LOAD-BEARING PIN.**

The only instance here with `N > 1` AND a non-constant exponent vector (`rPinSix_nonconstant`),
hence the only one where the normaliser is a number other than `1`, `2⁻¹` or `46656` reached
trivially: `√(6¹²) = 46656`, and the cancellation `46656⁻¹ · 46656 = 1` is what leaves the bare root
of unity `i^{-12} = 1`.  A normalised statement that had used `N^k = 2176782336` instead of
`√(N^k) = 46656` would be off by a factor of `46656` here and would still close PINs A and C. -/
theorem selfDual_norm_pin_level_six {z : ℂ} (hz : z ∈ ℍₒ) :
    ((Real.sqrt (((6 : ℕ) : ℝ) ^ (12 : ℤ)) : ℝ) : ℂ)⁻¹ * z ^ (-12 : ℤ)
        * etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = I ^ (-12 : ℤ) * etaQuotient 6 rPinSix z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-12 : ℤ) * z ^ (12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  have hc : ((46656 : ℝ) : ℂ)⁻¹ * ((46656 : ℝ) : ℂ) = 1 := by norm_num
  rw [selfDual_eigen_pin_level_six_value hz, sqrt_natPow_level_six, I_zpow_neg_twelve]
  calc ((46656 : ℝ) : ℂ)⁻¹ * z ^ (-12 : ℤ)
        * ((46656 : ℂ) * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z)
      = (((46656 : ℝ) : ℂ)⁻¹ * ((46656 : ℝ) : ℂ)) * (z ^ (-12 : ℤ) * z ^ (12 : ℤ))
          * (1 * etaQuotient 6 rPinSix z) := by push_cast; ring
    _ = 1 * etaQuotient 6 rPinSix z := by rw [hc, hzk, one_mul, one_mul]

/-- **`SDF-06` PIN B, numeral form.**  The same instance with BOTH constants replaced by the
numerals computed by hand: the normaliser is `46656⁻¹` and the eigenvalue is `1`, so at level six
and weight twelve the normalised Fricke transform is the IDENTITY on the eta quotient.

Stated separately from PIN B because it is the form a reader can check against Martin's tables
without unfolding `Real.sqrt`, and because `etaQuotient_fricke_selfDual_normalized_pin_level_six`
below states this SAME equation and derives it through the GENERAL lemma instead.  Two routes to one
equation: this one via the `SDF-05` numeral pin, that one via `SDF-06`; they agree. -/
theorem selfDual_norm_pin_level_six_value {z : ℂ} (hz : z ∈ ℍₒ) :
    (46656 : ℂ)⁻¹ * z ^ (-12 : ℤ) * etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = etaQuotient 6 rPinSix z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-12 : ℤ) * z ^ (12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  rw [selfDual_eigen_pin_level_six_value hz]
  calc (46656 : ℂ)⁻¹ * z ^ (-12 : ℤ) * (46656 * z ^ (12 : ℤ) * etaQuotient 6 rPinSix z)
      = ((46656 : ℂ)⁻¹ * 46656) * (z ^ (-12 : ℤ) * z ^ (12 : ℤ))
          * etaQuotient 6 rPinSix z := by ring
    _ = etaQuotient 6 rPinSix z := by rw [hzk]; norm_num

/-- **`SDF-06` PIN C — the degenerate vector `r ≡ 0` at level six, `k = 0`.**

DEGENERATE BY CONSTRUCTION: `k = 0` makes the normaliser `√(N⁰) = 1`, the weight factor `z⁰ = 1` and
the eigenvalue `i⁰ = 1` all at once, for EVERY `N`, so a statement that accidentally proved only the
`k = 0` case would still pass here.  It is a floor certifying the normalised equation is not
mis-stated into something unsatisfiable — not evidence about the exponents, the involution, or the
normalisation. -/
theorem selfDual_norm_pin_zero_exp {z : ℂ} (hz : z ∈ ℍₒ) :
    ((Real.sqrt (((6 : ℕ) : ℝ) ^ (0 : ℤ)) : ℝ) : ℂ)⁻¹ * z ^ (0 : ℤ)
        * etaQuotient 6 (0 : EtaExp) (-(1 / (((6 : ℕ) : ℂ) * z)))
      = I ^ (0 : ℤ) * etaQuotient 6 (0 : EtaExp) z := by
  rw [selfDual_eigen_pin_zero_exp_value hz, sqrt_natPow_zero_weight, Complex.ofReal_one, inv_one,
    zpow_zero, zpow_zero, one_mul, one_mul]

/-- **`SDF-06` PIN D — NEGATIVE EXPONENTS at an ODD weight: level four, `r = (-2, 6, -2)` on
`(1, 2, 4)`, `k = 1`.**

The only pin here where the normaliser genuinely divides by something other than a twelfth power:
`√(4¹) = 2`, and `SDF-05`'s constant `-2i` becomes the root of unity `i^{-1} = -i`.  It is the only
ODD weight, so `i^{-k}` is not real and a conjugated or dropped `i` is visible; the only one with
negative entries, so `s = 1⁻² · 2⁶ · 4⁻² = 4` passes through `zpow` at negative arguments; and the
only level with a divisor that is its own dual (`4 / 2 = 2`).

This is the pin that shows the normalised eigenvalue is not always `1`: PINs A, B, C and E all have
`4 ∣ k` and eigenvalue `1`, which alone would be consistent with a statement that had lost the
`i^{-k}` factor entirely. -/
theorem selfDual_norm_pin_level_four_neg {z : ℂ} (hz : z ∈ ℍₒ) :
    ((Real.sqrt (((4 : ℕ) : ℝ) ^ (1 : ℤ)) : ℝ) : ℂ)⁻¹ * z ^ (-1 : ℤ)
        * etaQuotient 4 rPinLevelFourNeg (-(1 / (((4 : ℕ) : ℂ) * z)))
      = I ^ (-1 : ℤ) * etaQuotient 4 rPinLevelFourNeg z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-1 : ℤ) * z ^ (1 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  have hc : ((2 : ℝ) : ℂ)⁻¹ * ((2 : ℝ) : ℂ) = 1 := by norm_num
  rw [selfDual_eigen_pin_level_four_neg_value hz, sqrt_natPow_level_four, I_zpow_neg_one]
  calc ((2 : ℝ) : ℂ)⁻¹ * z ^ (-1 : ℤ)
        * (-(2 * I) * z ^ (1 : ℤ) * etaQuotient 4 rPinLevelFourNeg z)
      = (((2 : ℝ) : ℂ)⁻¹ * ((2 : ℝ) : ℂ)) * (z ^ (-1 : ℤ) * z ^ (1 : ℤ))
          * (-I * etaQuotient 4 rPinLevelFourNeg z) := by push_cast; ring
    _ = -I * etaQuotient 4 rPinLevelFourNeg z := by rw [hc, hzk, one_mul, one_mul]

/-- **`SDF-06` PIN D, numeral form.**  Normaliser `2⁻¹`, eigenvalue `-i`, both computed by hand:
`i^{-1} · √(4¹) = -2i` is `SDF-05`'s constant, and dividing it by `√(4¹) = 2` leaves `-i`, which has
modulus one.  This is the file's only machine-checked instance of a normalised eigenvalue that is
neither `1` nor `-1`. -/
theorem selfDual_norm_pin_level_four_neg_value {z : ℂ} (hz : z ∈ ℍₒ) :
    (2 : ℂ)⁻¹ * z ^ (-1 : ℤ) * etaQuotient 4 rPinLevelFourNeg (-(1 / (((4 : ℕ) : ℂ) * z)))
      = -I * etaQuotient 4 rPinLevelFourNeg z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (-1 : ℤ) * z ^ (1 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  rw [selfDual_eigen_pin_level_four_neg_value hz]
  calc (2 : ℂ)⁻¹ * z ^ (-1 : ℤ)
        * (-(2 * I) * z ^ (1 : ℤ) * etaQuotient 4 rPinLevelFourNeg z)
      = ((2 : ℂ)⁻¹ * 2) * (z ^ (-1 : ℤ) * z ^ (1 : ℤ))
          * (-I * etaQuotient 4 rPinLevelFourNeg z) := by ring
    _ = -I * etaQuotient 4 rPinLevelFourNeg z := by rw [hzk]; norm_num

/-- **`SDF-06` PIN E — NEGATIVE WEIGHT: level six, `r = (-1, -11, -11, -1)`, `k = -12`.  THE SIGN
PIN OF THIS NODE.**

At `k = -12` the normalised statement carries `z^{-k} = z^{+12}` and the normaliser
`(√(6⁻¹²))⁻¹ = 46656`, which is larger than one — the two features a statement written for `k ≥ 0`
cannot have.  A transcription with `z^k` in place of `z^{-k}`, or with `√(N^k)` uninverted, is FALSE
here.  PIN A moves the same exponent in the opposite direction, so the two together fix its sign.

The exponents are written as the hand-evaluated `12` rather than as `-(-12)`; that evaluation is the
content of the pin and is deliberately not left to the elaborator. -/
theorem selfDual_norm_pin_level_six_neg {z : ℂ} (hz : z ∈ ℍₒ) :
    ((Real.sqrt (((6 : ℕ) : ℝ) ^ (-12 : ℤ)) : ℝ) : ℂ)⁻¹ * z ^ (12 : ℤ)
        * etaQuotient 6 rPinLevelSixNeg (-(1 / (((6 : ℕ) : ℂ) * z)))
      = I ^ (12 : ℤ) * etaQuotient 6 rPinLevelSixNeg z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (12 : ℤ) * z ^ (-12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  have hc : (((46656 : ℝ)⁻¹ : ℝ) : ℂ)⁻¹ * ((46656 : ℂ))⁻¹ = 1 := by push_cast; norm_num
  rw [selfDual_eigen_pin_level_six_neg_value hz, sqrt_natPow_level_six_neg, I_zpow_twelve]
  calc (((46656 : ℝ)⁻¹ : ℝ) : ℂ)⁻¹ * z ^ (12 : ℤ)
        * ((46656 : ℂ)⁻¹ * z ^ (-12 : ℤ) * etaQuotient 6 rPinLevelSixNeg z)
      = ((((46656 : ℝ)⁻¹ : ℝ) : ℂ)⁻¹ * ((46656 : ℂ))⁻¹) * (z ^ (12 : ℤ) * z ^ (-12 : ℤ))
          * (1 * etaQuotient 6 rPinLevelSixNeg z) := by ring
    _ = 1 * etaQuotient 6 rPinLevelSixNeg z := by rw [hc, hzk, one_mul, one_mul]

/-- **`SDF-06` PIN E, numeral form.**  Normaliser `46656` (not `46656⁻¹`: the radicand `6⁻¹²` is a
proper fraction, so its inverse square root is large), weight factor `z¹²`, eigenvalue `1`.

`etaQuotient_fricke_selfDual_normalized_pin_level_six_neg` below states this SAME equation and
derives it through the GENERAL lemma at `k < 0`; the two routes agree, which is the check that the
general statement does not silently assume a non-negative weight. -/
theorem selfDual_norm_pin_level_six_neg_value {z : ℂ} (hz : z ∈ ℍₒ) :
    (46656 : ℂ) * z ^ (12 : ℤ) * etaQuotient 6 rPinLevelSixNeg (-(1 / (((6 : ℕ) : ℂ) * z)))
      = etaQuotient 6 rPinLevelSixNeg z := by
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  have hzk : z ^ (12 : ℤ) * z ^ (-12 : ℤ) = 1 := by rw [← zpow_add₀ hz0]; norm_num
  rw [selfDual_eigen_pin_level_six_neg_value hz]
  calc (46656 : ℂ) * z ^ (12 : ℤ)
        * ((46656 : ℂ)⁻¹ * z ^ (-12 : ℤ) * etaQuotient 6 rPinLevelSixNeg z)
      = ((46656 : ℂ) * (46656 : ℂ)⁻¹) * (z ^ (12 : ℤ) * z ^ (-12 : ℤ))
          * etaQuotient 6 rPinLevelSixNeg z := by ring
    _ = etaQuotient 6 rPinLevelSixNeg z := by rw [hzk]; norm_num

/-- **`SDF-06` NEGATIVE CONTROL — the normaliser is `√(N^k)`, and `hr` is what makes that the right
normaliser.**

`SDF-06` divides by `√(N^k)`, whereas the raw law `etaQuotient_fricke` divides by
`√(∏_{δ ∣ N} δ^{r δ})`.  On a self-dual vector those agree — that is `SDF-02`.  At the NON-self-dual
`rPinAsym = (2, 0)` on `(1, 2)`, which satisfies the weight hypothesis exactly
(`rPinAsym_weight`, `k = 1`) and fails self-duality (`not_selfDual_pin_asymmetric`), they do NOT:
`√(2¹) = √2` against `√(1² · 2⁰) = √1 = 1`.  So dropping `hr` from `SDF-06` would leave a statement
whose normaliser is wrong by a factor of `√2`, and this is that discrepancy, machine-checked.

STATED PRECISELY, so it is not read as more than it is — the same care as the `SDF-04` negative
control.  What is proved here is that the two NORMALISERS differ at that `r`.  The full conclusion
of `SDF-06` also fails there, and worse: `fricke_dual_pin` (`EtaQuotientModularity.lean:2302`,
sorry-free) gives `η(-1/(2z))² = -2i · z · η(2z)²`, so the `hr`-free reading of `SDF-06` would say
`-i√2 · η(2z)² = -i · η(z)²` — wrong constant AND wrong function.  That `η(z)²` and `η(2z)²` are
different FUNCTIONS is true and is recorded in `fricke_dual_pin`'s docstring, but it is not a
theorem in this library, so that half of the falsification is asserted at the hand-check level, not
at the Lean level. -/
theorem selfDual_norm_pin_asymmetric_ne :
    Real.sqrt (((2 : ℕ) : ℝ) ^ (1 : ℤ))
      ≠ Real.sqrt (∏ δ ∈ (2 : ℕ).divisors, (δ : ℝ) ^ (rPinAsym δ)) := by
  rw [show (2 : ℕ).divisors = {1, 2} from by decide]
  norm_num [rPinAsym]

end Sdf06Pins

/-! ### `SDF-06` — the normalised form: the eigenvalue is a root of unity -/

/-- **`SDF-06`.**  The weight-`k`, `N^{k/2}`-normalised Fricke transform of a self-dual eta
quotient is exactly `i^{-k}` times the quotient.  The `N`-dependence cancels completely.

This is the form in which the eigenvalue is a **root of unity**.

WHERE THE `N`-DEPENDENCE ACTUALLY GOES, since "cancels completely" reads as if it were free: the
normaliser `√(N^k)` written here cancels the `√(N^k)` inside `frickeEigenvalue`, which is
bookkeeping — but `frickeEigenvalue` is `r`-free in the first place only because
`∏_{δ ∣ N} δ^{r δ} = N^k` on a self-dual vector.  That is `prod_zpow_selfDual` (`SDF-02`), the one
genuinely arithmetical step in this file — it routes through `sqrt_prod_dual` (`F3.2-A7`) and then
uses positivity of the product to pick the root `+N^k` rather than `-N^k` — packaged into `ℂ` by
`fricke_const_selfDual` (`SDF-03`) and absorbed into the eigenvalue by `SDF-05`.  This node adds no
arithmetic; it only divides through.

Two cancellations are performed, and both need a hypothesis: `(√(N^k))⁻¹ · √(N^k) = 1` needs
`√(N^k) ≠ 0`, which comes from `0 < N` through `zpow_pos` — `zpow_pos`, not `pow_pos`, because `k`
may be negative, as `selfDual_norm_pin_level_six_neg` pins; and `z^{-k} · z^k = 1` needs `z ≠ 0`,
extracted from `hz` exactly as in `etaQuotient_fricke`.  `ring` only re-associates: it cannot close
either cancellation, which was checked this session (see the pin section's tactic-level negative
control).

Written longhand rather than through Mathlib's `∣[k]` slash **deliberately**: Mathlib's
`GL(2,ℝ)` slash carries a `det^(k-1)` factor, which for the Fricke matrix (determinant `N`)
would change the constant.  Restating this via the slash is not a cosmetic change and must not
be done without re-pinning.

The claim that this normalisation is the classical one (Martin, *Multiplicative eta-quotients*,
Trans. AMS 348 (1996)) is a CITATION claim about Martin's convention, at the literature (L) tier of
this programme's ladder — it is not checked by anything here, and must not be reported as if it
were.  What IS machine-checked against an external source is the level-one instance:
`selfDual_norm_pin_level_one_is_eta_S` lands on `z⁻¹² η(-1/z)²⁴ = η(z)²⁴`, which Mathlib proves
independently as `discriminant_S_invariant`.

SCOPE, stated so it cannot be oversold: this is an identity between two explicit products of
values of Mathlib's `ModularForm.eta`.  It says nothing about `Γ₀(N)`-modularity, nothing about
holomorphy at the cusps, and nothing about physics — see the header. -/
theorem etaQuotient_fricke_selfDual_normalized {N : ℕ} (hN : 0 < N) {r : EtaExp}
    (hr : IsFrickeSelfDual N r) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    {z : ℂ} (hz : z ∈ ℍₒ) :
    ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ)⁻¹ * z ^ (-k)
        * etaQuotient N r (-(1 / ((N : ℂ) * z)))
      = I ^ (-k) * etaQuotient N r z := by
  -- (1) `z ≠ 0` from membership in the OPEN upper half-plane, by the same two lines as
  -- `etaQuotient_fricke` (`EtaQuotientModularity.lean:2212`): if `z = 0` its imaginary part is `0`.
  have hz0 : z ≠ 0 := by
    intro h; rw [h] at hz; simp [UpperHalfPlane.upperHalfPlaneSet] at hz
  -- (2) `√((N:ℝ)^k) ≠ 0`.  `zpow_pos`, NOT `pow_pos`: `k` may be negative, and
  -- `selfDual_norm_pin_level_six_neg` pins the case `k = -12`, where the radicand is `1/2176782336`.
  have hNR : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hc : ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ) ≠ 0 :=
    Complex.ofReal_ne_zero.mpr (Real.sqrt_ne_zero'.mpr (zpow_pos hNR k))
  -- (3) The two cancellations, isolated so that neither hides inside a tactic.  Both are FALSE
  -- without their hypotheses (`z = 0` or `N = 0` makes the left-hand side `0`), which is why `ring`
  -- cannot and does not perform them.
  have hzk : z ^ (-k) * z ^ k = 1 := by rw [← zpow_add₀ hz0]; simp
  have hcc : ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ)⁻¹ * ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ) = 1 :=
    inv_mul_cancel₀ hc
  -- (4) `SDF-05` supplies the eigenform relation; unfolding `frickeEigenvalue` exposes the very
  -- `√(N^k)` this statement divides by, as the SAME term (no cast massaging is needed, which is why
  -- the normaliser was written in this shape).
  rw [etaQuotient_fricke_selfDual hN hr hk hz, frickeEigenvalue]
  -- (5) Re-associate so the two cancelling pairs stand next to each other, then cancel.  `ring`
  -- treats `(√(N^k))⁻¹`, `√(N^k)`, `z^{-k}`, `z^k`, `i^{-k}` and both eta quotients as ATOMS — it
  -- never unfolds an eta quotient and never cancels an inverse — so nothing numerical is smuggled in.
  calc ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ)⁻¹ * z ^ (-k)
        * (I ^ (-k) * ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ) * z ^ k * etaQuotient N r z)
      = (((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ)⁻¹ * ((Real.sqrt ((N : ℝ) ^ k) : ℝ) : ℂ))
          * (z ^ (-k) * z ^ k) * (I ^ (-k) * etaQuotient N r z) := by ring
    _ = I ^ (-k) * etaQuotient N r z := by rw [hcc, hzk, one_mul, one_mul]

/-- **`SDF-06` APPLICATION CHECK — the general lemma reproduces the load-bearing pin.**

`selfDual_norm_pin_level_six_value` asserts this equation at `(N, r, k) = (6, rPinSix, 12)` from the
`SDF-05` numeral pin, without touching `SDF-06`.  This re-derives the SAME equation by RUNNING
`etaQuotient_fricke_selfDual_normalized` at that instance and evaluating `√(6¹²) = 46656` and
`i^{-12} = 1`, i.e. through the general proof rather than around it.  The two agree, so the general
statement is not merely true in the abstract: it fires at the concrete instance and returns the
independently computed constants.  A general lemma that had drifted — normaliser uninverted, `N^k`
for `√(N^k)`, `z^k` for `z^{-k}` — would produce a different equation here while remaining provable
in its own terms. -/
theorem etaQuotient_fricke_selfDual_normalized_pin_level_six {z : ℂ} (hz : z ∈ ℍₒ) :
    (46656 : ℂ)⁻¹ * z ^ (-12 : ℤ) * etaQuotient 6 rPinSix (-(1 / (((6 : ℕ) : ℂ) * z)))
      = etaQuotient 6 rPinSix z := by
  have h := etaQuotient_fricke_selfDual_normalized (N := 6) (by norm_num) (r := rPinSix)
    selfDual_cond_pin_level_six (k := 12) rPinSix_weight hz
  rw [sqrt_natPow_level_six, I_zpow_neg_twelve, one_mul] at h
  push_cast at h
  exact h

/-- **`SDF-06` APPLICATION CHECK at NEGATIVE weight.**  The same, at
`(N, r, k) = (6, rPinLevelSixNeg, -12)`, where `selfDual_norm_pin_level_six_neg_value` states the
equation independently.  Running the general lemma at `k < 0` returns the same normaliser `46656`
and the same weight factor `z^{+12}`, so the general proof genuinely covers negative weights: it
does not assume `k ≥ 0` anywhere, and `-k` really is instantiated as `+12` rather than collapsed. -/
theorem etaQuotient_fricke_selfDual_normalized_pin_level_six_neg {z : ℂ} (hz : z ∈ ℍₒ) :
    (46656 : ℂ) * z ^ (12 : ℤ) * etaQuotient 6 rPinLevelSixNeg (-(1 / (((6 : ℕ) : ℂ) * z)))
      = etaQuotient 6 rPinLevelSixNeg z := by
  have h := etaQuotient_fricke_selfDual_normalized (N := 6) (by norm_num) (r := rPinLevelSixNeg)
    rPinLevelSixNeg_selfDual (k := -12) rPinLevelSixNeg_weight hz
  rw [sqrt_natPow_level_six_neg, neg_neg, I_zpow_twelve, one_mul] at h
  push_cast at h
  rw [inv_inv] at h
  exact h


/-! ### `SDF-07` … `SDF-09` — when is the root of unity `±1`?

`Complex.I_pow_eq_pow_mod` (Mathlib `Data/Complex/Basic.lean:633`, verified this session) is
stated for **natural** exponents only; a whole-Mathlib grep for `I_zpow` returns nothing.  The
integer version below is therefore genuinely new here, and it is the only reason the `±1`
corollaries are not pure substitution. -/

/-! #### `SDF-07` pins — the periodicity at concrete exponents, computed BEFORE the general lemma

Each pin below states `SDF-07`'s OWN equation at one concrete `k`, and proves the two sides
SEPARATELY: the left-hand side `i^k` through the already sorry-free `I_zpow_*` value lemmas of
section `SdfDef02Pins` (or, for `k = -15`, through `zpow_neg` and a `ℕ`-power computation), the
right-hand side by `decide`-reducing `k % 4` to a numeral and then evaluating that small power.
Neither side is obtained from `I_zpow_emod`; the pins are declared ABOVE it, so Lean's scoping
enforces that rather than this comment.

Every value was computed OUTSIDE Lean first, in exact Gaussian-rational arithmetic (repeated
multiplication for `k ≥ 0`, explicit conjugate/norm inversion for `k < 0`), for every `k` in
`[-40, 40]`: 81 cases, zero mismatches.  The six pins below are the instances of that table that
carry information, and four of them meet an independently proved lemma of this file:

* `k = 12`   (`% 4 = 0`, value `1`)   — the exponent of `frickeEigenvalue 1 12`, i.e. the `N = 1`,
  `r = (24)`, `k = 12` case underlying the already sorry-free `eta_S_via_fricke`
  (`EtaQuotientModularity.lean:2246`); meets `I_zpow_twelve`.
* `k = -12`  (`% 4 = 0`, value `1`)   — the exponent that actually appears in the LOAD-BEARING
  `N = 6` self-dual pin, since `frickeEigenvalue 6 12 = i^{-12} · √(6¹²)`; meets
  `I_zpow_neg_twelve`.  THE NEGATIVE-`k` CASE: `Int.emod` sends `-12` to `0`, not to `-12`.
* `k = 0`    (`% 4 = 0`, value `1`)   — the DEGENERATE case (`r ≡ 0`, weight `0`).  Recorded for
  completeness and honestly worth little: both sides are literally the same term after the `decide`,
  so this pin would survive almost any mis-statement.
* `k = -1`   (`% 4 = 3`, value `-i`)  — the ODD-weight case, and the sharpest test that `%` is
  `Int.emod` and not `Int.tmod`: the reduced exponent is `3`, a NON-NEGATIVE representative, and the
  value leaves the reals entirely.  Meets `I_zpow_neg_one`.
* `k = -2`   (`% 4 = 2`, value `-1`)  — THE SIGN PIN, the exponent of `frickeEigenvalue 1 2 = -1`
  guarded by `selfDual_pin_eigenvalue_neg_one` (`f = η⁴`).  Meets `I_zpow_neg_two`.
* `k = -15`  (`% 4 = 1`, value `i`)   — the pin no `±1` coincidence can fake: NEITHER side is real,
  and `-15` is not a multiple of `4`, so both the reduction and the value are non-degenerate.  This
  is the only pin whose left-hand side is not one of the four existing `I_zpow_*` lemmas; it is
  computed here from `i^{15} = -i` and `(-i)⁻¹ = i`.

NEGATIVE CONTROLS.  `I_zpow_emod_pin_not_mod_two` shows the modulus `4` is load-bearing — at
`k = 3` the mod-`2` reading would give `i^3 = i^1`, i.e. `-i = i`, which is refuted through
`Complex.I_im`.  `I_zpow_emod_pin_nontrivial_reduction` shows the reduction is not the identity map
(`(-15) % 4 = 1 ≠ -15`), so the statement is not a disguised tautology.

`I_zpow_emod_exponent_mem` is the companion fact `SDF-08` and `SDF-09` will need: the reduced
exponent lies in `[0, 4)`, which is what makes their four-case analysis exhaustive.  It is stated
here, next to the lemma that produces the reduced exponent, rather than duplicated in each. -/

section Sdf07Pins

/-- The reduced exponent of `SDF-07` lies in `[0, 4)`.  This is where the choice of `Int.emod` (as
opposed to `Int.tmod`) is visible: `emod` with a positive divisor is always non-negative, so
`i^(k % 4)` is one of the four values `1, i, -1, -i` for EVERY `k : ℤ`, including negative `k`.

`SDF-08` and `SDF-09` need exactly this to know their case analysis is exhaustive. -/
theorem I_zpow_emod_exponent_mem (k : ℤ) : 0 ≤ k % 4 ∧ k % 4 < 4 :=
  ⟨Int.emod_nonneg k (by norm_num), Int.emod_lt_of_pos k (by norm_num)⟩

/-- **`SDF-07` PIN A — `k = 12`.**  `12 % 4 = 0` and `i^{12} = 1 = i^0`.

The exponent of `frickeEigenvalue 1 12`, i.e. the `N = 1`, `r = (24)`, `k = 12` instance underlying
the already sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`).  Left side via
`I_zpow_twelve`, right side via `zpow_zero`; the two never meet. -/
theorem I_zpow_emod_pin_twelve : (I : ℂ) ^ (12 : ℤ) = I ^ ((12 : ℤ) % 4) := by
  rw [show ((12 : ℤ) % 4) = 0 by decide, _root_.zpow_zero, I_zpow_twelve]

/-- **`SDF-07` PIN B — `k = -12`.  THE NEGATIVE-EXPONENT PIN.**  `(-12) % 4 = 0` and
`i^{-12} = 1 = i^0`.

This is the exponent that actually occurs in the LOAD-BEARING `N = 6` self-dual instance, where
`frickeEigenvalue 6 12 = i^{-12} · √(6¹²)`.  It is also the pin that catches a `tmod`/`emod`
confusion in the easy direction and a dropped `zpow_neg` in the hard one: `Int.emod` sends `-12` to
`0`, and `I_zpow_neg_twelve` computes the left side independently through `zpow_neg`. -/
theorem I_zpow_emod_pin_neg_twelve : (I : ℂ) ^ (-12 : ℤ) = I ^ ((-12 : ℤ) % 4) := by
  rw [show ((-12 : ℤ) % 4) = 0 by decide, _root_.zpow_zero, I_zpow_neg_twelve]

/-- **`SDF-07` PIN C — the degenerate exponent `k = 0`.**  `0 % 4 = 0`, so both sides are `i^0`.

Recorded for completeness at the `r ≡ 0`, weight-`0` case, and honestly worth very little: after the
`decide` the two sides are the SAME term, so this pin would survive almost any mis-statement of the
reduction.  It is listed as a pin because the degenerate case is part of the required set, not
because it constrains anything. -/
theorem I_zpow_emod_pin_zero : (I : ℂ) ^ (0 : ℤ) = I ^ ((0 : ℤ) % 4) := by
  rw [show ((0 : ℤ) % 4) = 0 by decide]

/-- **`SDF-07` PIN D — `k = -1`, the ODD case.**  `(-1) % 4 = 3` and `i^{-1} = -i = i^3`.

THE SHARPEST TEST THAT `%` IS `Int.emod`.  Under `Int.tmod` the reduced exponent would be `-1` and
the pin would degenerate into `i^{-1} = i^{-1}`, true but empty; under `emod` it is `3`, a
NON-NEGATIVE representative, and the equation genuinely relates a negative power to a positive one.
The value also leaves the reals, so no `±1` coincidence can carry it.  Left side via
`I_zpow_neg_one` (`Complex.inv_I`), right side by expanding `i^3 = i^2 · i` through
`Complex.I_sq`. -/
theorem I_zpow_emod_pin_neg_one : (I : ℂ) ^ (-1 : ℤ) = I ^ ((-1 : ℤ) % 4) := by
  rw [show ((-1 : ℤ) % 4) = 3 by decide, I_zpow_neg_one,
      show (3 : ℤ) = ((3 : ℕ) : ℤ) by norm_num, zpow_natCast,
      show (3 : ℕ) = 2 + 1 from by norm_num, pow_succ, Complex.I_sq]
  ring

/-- **`SDF-07` PIN E — `k = -2`.  THE SIGN PIN.**  `(-2) % 4 = 2` and `i^{-2} = -1 = i^2`.

This is the exponent behind `frickeEigenvalue 1 2 = -1`, whose eta-quotient instance is
`selfDual_pin_eigenvalue_neg_one` (`f = η⁴` at level one, weight two, eigenvalue `-1`) — the
independently hand-computed witness that the sign of the eigenvalue is right.  If `SDF-07` were
wrong at this exponent, `SDF-09` would produce the wrong sign and that pin would break. -/
theorem I_zpow_emod_pin_neg_two : (I : ℂ) ^ (-2 : ℤ) = I ^ ((-2 : ℤ) % 4) := by
  rw [show ((-2 : ℤ) % 4) = 2 by decide, I_zpow_neg_two,
      show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq]

/-- **`SDF-07` PIN F — `k = -15`.  THE PIN NO COINCIDENCE CAN FAKE.**  `(-15) % 4 = 1` and
`i^{-15} = i = i^1`.

Neither side is `±1`, and `-15` is neither a multiple of `4` nor congruent to `2`, so both the
reduction and the value are non-degenerate: this instance is invisible to `SDF-08` and `SDF-09` and
therefore cannot be an artefact of the `±1` bookkeeping they do.  It is the one pin whose left side
is NOT one of the four existing `I_zpow_*` lemmas — it is computed here from `i^{15} = -i`
(`i^{15} = (i^4)^3 · i^3`) and `(-i)⁻¹ = i` (`Complex.inv_I` read backwards, then `inv_inv`), a
route sharing no lemma with the general proof's `zpow_add₀`/`zpow_mul` argument. -/
theorem I_zpow_emod_pin_neg_fifteen : (I : ℂ) ^ (-15 : ℤ) = I ^ ((-15 : ℤ) % 4) := by
  have h15 : (I : ℂ) ^ (15 : ℕ) = -I := by
    rw [show (15 : ℕ) = 4 * 3 + 3 from by norm_num, pow_add, pow_mul, Complex.I_pow_four,
        one_pow, one_mul, show (3 : ℕ) = 2 + 1 from by norm_num, pow_succ, Complex.I_sq]
    ring
  rw [show ((-15 : ℤ) % 4) = 1 by decide, _root_.zpow_one,
      show (-15 : ℤ) = -((15 : ℕ) : ℤ) by norm_num, _root_.zpow_neg, zpow_natCast, h15,
      ← Complex.inv_I, inv_inv]

/-- **`SDF-07` NEGATIVE CONTROL 1 — the modulus `4` is load-bearing.**  At `k = 3` the mod-`2`
reading of the statement would assert `i^3 = i^(3 % 2) = i^1`, i.e. `-i = i`.  It is refuted here
through `Complex.I_im`, so the order of `i` is genuinely `4` and not a smaller divisor of it.

Without this control, a statement with the wrong modulus would still pass PINS A, B, C and E (all of
whose exponents are even) — PIN D and PIN F are the ones it would break, and this control makes the
falsification explicit rather than leaving it implicit in the pin table. -/
theorem I_zpow_emod_pin_not_mod_two : (I : ℂ) ^ (3 : ℤ) ≠ I ^ ((3 : ℤ) % 2) := by
  have h3 : (I : ℂ) ^ (3 : ℤ) = -I := by
    rw [show (3 : ℤ) = ((3 : ℕ) : ℤ) by norm_num, zpow_natCast,
        show (3 : ℕ) = 2 + 1 from by norm_num, pow_succ, Complex.I_sq]
    ring
  rw [h3, show ((3 : ℤ) % 2) = 1 by decide, _root_.zpow_one]
  intro h
  have him := congrArg Complex.im h
  simp only [Complex.neg_im, Complex.I_im] at him
  norm_num at him

/-- **`SDF-07` NEGATIVE CONTROL 2 — the reduction is not the identity.**  `(-15) % 4 = 1`, and
`1 ≠ -15`, so `SDF-07` is not the tautology `i^k = i^k` in disguise at the pin that matters most.
`decide`, both conjuncts. -/
theorem I_zpow_emod_pin_nontrivial_reduction : ((-15 : ℤ) % 4) = 1 ∧ (1 : ℤ) ≠ -15 := by
  decide

end Sdf07Pins

/-- **`SDF-07`.**  Periodicity of *integer* powers of `i`: `i^k = i^(k % 4)` for `k : ℤ`, where
`%` is `Int.emod` (so the representative lies in `[0, 4)` since `4 > 0`, as
`I_zpow_emod_exponent_mem` records).

Mathlib has only the `ℕ` version, `Complex.I_pow_eq_pow_mod` (`Data/Complex/Basic.lean:633`).  The
generic lemma that would have made this redundant, `zpow_eq_zpow_emod` (`Algebra/Group/Basic.lean:849`),
is stated inside `section Group` (`variable [Group G]`, opened at `Algebra/Group/Basic.lean:594` and
not closed before line 849 — checked this session) and `ℂ` is NOT a group under multiplication; a
whole-Mathlib grep finds no `GroupWithZero`/`DivisionRing` variant.  Hence the `GroupWithZero` route
below, through `zpow_add₀` with its `I ≠ 0` side condition.

PROOF: `k = k % 4 + 4 * (k / 4)` (`Int.emod_add_mul_ediv`), then split the power with `zpow_add₀`
(discharging `I ≠ 0` by `Complex.I_ne_zero`), collapse `i^(4 * (k / 4)) = (i^4)^(k / 4) = 1` with
`zpow_mul` and `Complex.I_pow_four`.  Six instance pins and two negative controls are above. -/
theorem I_zpow_emod (k : ℤ) : (I : ℂ) ^ k = I ^ (k % 4) := by
  have hI4 : (I : ℂ) ^ (4 : ℤ) = 1 := by
    rw [show (4 : ℤ) = ((4 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_pow_four]
  calc (I : ℂ) ^ k = I ^ (k % 4 + 4 * (k / 4)) := by rw [Int.emod_add_mul_ediv]
    _ = I ^ (k % 4) := by
        rw [_root_.zpow_add₀ Complex.I_ne_zero, _root_.zpow_mul, hI4, _root_.one_zpow, mul_one]

/-- **`SDF-07` APPLICATION CHECKS — the general lemma reproduces the pins.**  Each conjunct is the
statement of a pin above, but REACHED BY RUNNING `I_zpow_emod` at that exponent, so every pinned
instance is proved twice by routes sharing no lemma, and they agree.  `PIN F` (`k = -15`) is the
informative one: it is the instance whose value is neither `1` nor `-1`. -/
theorem I_zpow_emod_pin_application :
    (I : ℂ) ^ (12 : ℤ) = I ^ ((12 : ℤ) % 4) ∧
      (I : ℂ) ^ (-12 : ℤ) = I ^ ((-12 : ℤ) % 4) ∧
      (I : ℂ) ^ (-1 : ℤ) = I ^ ((-1 : ℤ) % 4) ∧
      (I : ℂ) ^ (-2 : ℤ) = I ^ ((-2 : ℤ) % 4) ∧
      (I : ℂ) ^ (-15 : ℤ) = I ^ ((-15 : ℤ) % 4) :=
  ⟨I_zpow_emod 12, I_zpow_emod (-12), I_zpow_emod (-1), I_zpow_emod (-2), I_zpow_emod (-15)⟩

/-! ### `SDF-08` pins — the iff at concrete weights, computed independently

The exponent `k` of `SDF-08` is a WEIGHT: `i^{-k}` is the root-of-unity factor of
`frickeEigenvalue N k`.  Each pin below is `SDF-08`'s own biconditional at one concrete weight, with
BOTH sides settled independently — the `ℂ` side through the sorry-free value lemmas of section
`SdfDef02Pins` (or, at `k = 15`, through `I_zpow_emod_pin_neg_fifteen`), the `ℤ` side by `decide` —
and every pin is stated ABOVE the general lemma, so Lean scoping forbids it from using it.

Outside Lean, `i^{-k} = 1 ↔ 4 ∣ k` was first checked in exact Gaussian-integer arithmetic for all
`121` weights `k ∈ [-60, 60]` (positive powers by repeated multiplication, negative ones by
conjugation, since `|i^m| = 1`); zero mismatches.  The pins below are the instances of that check
that correspond to eta-quotient data already in this file.

THE PINNED WEIGHTS, and why each one:

* `k = 12`  — the `N = 1`, `r = (24)` case (`∑ r δ = 24 = 2·12`) underlying the sorry-free
  `eta_S_via_fricke` (there as `selfDual_eigen_pin_level_one`), and also the weight of the `N = 6`
  self-dual instance (`selfDual_eigen_pin_level_six`).  BOTH sides true: `i^{-12} = 1`
  (`I_zpow_neg_twelve`) and `4 ∣ 12`.  One weight, two levels — which is the point: `SDF-08` sees
  only `k`.
* `k = -12` — the weight of `selfDual_eigen_pin_level_six_neg` (`SDF-05` PIN E, the only eigen pin
  with `k < 0`); `i^{12} = 1` (`I_zpow_twelve`, reached after `neg_neg`, so through a different value
  lemma than `k = 12`) and `4 ∣ -12`.  This pin is what would catch a proof that silently assumed
  `0 ≤ k`.
* `k = 0`   — THE DEGENERATE CASE (`r ≡ 0`, weight zero, `selfDual_eigen_pin_zero_exp`).  Both sides true, and worth little: after
  `neg_zero` the left side is `i^0` by `zpow_zero`, so almost any mis-statement would survive it.
  Recorded because the degenerate case is part of the required pin set, not as evidence.
* `k = 2`   — THE LOAD-BEARING NEGATIVE CONTROL.  Both sides FALSE: `i^{-2} = -1 ≠ 1`
  (`I_zpow_neg_two`, refuted through `Complex.one_re`) and `4 ∤ 2`.  This is the weight of
  `selfDual_pin_eigenvalue_neg_one` (`f = η⁴` at level one), whose eigenvalue is `-1`; if the
  right-hand side of `SDF-08` were stated on the wrong residue class — `2 ∣ k`, say — this pin would
  break, and `SDF-09` would inherit the wrong sign.
* `k = 1`   — both sides false with a NON-REAL value: `i^{-1} = -i` (`I_zpow_neg_one`), refuted
  through `Complex.I_im`.  The weight of `selfDual_eigen_pin_level_four_neg` (level four,
  eigenvalue `-2i`).
* `k = 15`  — the pin no `±1` coincidence can fake: `i^{-15} = i`, neither `1` nor `-1`, and
  `4 ∤ 15`.  Its value is computed through `I_zpow_emod_pin_neg_fifteen`, i.e. by a route sharing no
  lemma with the four-case analysis the general proof runs. -/

section Sdf08Pins

/-- **`SDF-08` PIN A — weight `k = 12`, both sides TRUE.**  `i^{-12} = 1` and `4 ∣ 12`.

The weight of the `N = 1`, `r = (24)` instance behind the sorry-free `eta_S_via_fricke`, and of the
`N = 6` self-dual instance.  Left conjunct via `I_zpow_neg_twelve`, right by `decide`. -/
theorem I_zpow_neg_eq_one_iff_pin_twelve :
    (I : ℂ) ^ (-(12 : ℤ)) = 1 ∧ (4 : ℤ) ∣ (12 : ℤ) :=
  ⟨by rw [show (-(12 : ℤ)) = (-12 : ℤ) by norm_num, I_zpow_neg_twelve], by decide⟩

/-- **`SDF-08` PIN B — weight `k = -12`, the NEGATIVE-WEIGHT pin, both sides TRUE.**
`i^{-(-12)} = i^{12} = 1` and `4 ∣ -12`.

The weight of `selfDual_eigen_pin_level_six_neg` (`SDF-05` PIN E, eigenvalue `1/46656`).  Reached
through `I_zpow_twelve` after `neg_neg`, i.e. by a different value lemma than PIN A, so the two do
not share a route.  A proof of `SDF-08` that assumed `0 ≤ k` would fail here. -/
theorem I_zpow_neg_eq_one_iff_pin_neg_twelve :
    (I : ℂ) ^ (-(-12 : ℤ)) = 1 ∧ (4 : ℤ) ∣ (-12 : ℤ) :=
  ⟨by rw [neg_neg, I_zpow_twelve], by decide⟩

/-- **`SDF-08` PIN C — the degenerate weight `k = 0` (`r ≡ 0`, `selfDual_eigen_pin_zero_exp`).**
`i^0 = 1` and `4 ∣ 0`.

DEGENERATE AND GUARDED AS SUCH: after `neg_zero` the left conjunct is `zpow_zero`, so this pin
constrains essentially nothing.  It is here because the degenerate case belongs to the required pin
set, not because it is evidence. -/
theorem I_zpow_neg_eq_one_iff_pin_zero :
    (I : ℂ) ^ (-(0 : ℤ)) = 1 ∧ (4 : ℤ) ∣ (0 : ℤ) :=
  ⟨by rw [neg_zero, _root_.zpow_zero], by decide⟩

/-- **`SDF-08` PIN D — weight `k = 2`, BOTH SIDES FALSE.  THE LOAD-BEARING NEGATIVE CONTROL.**
`i^{-2} = -1 ≠ 1` and `4 ∤ 2`.

This is the weight of `selfDual_pin_eigenvalue_neg_one` (`f = η⁴`, level one, eigenvalue `-1`), the
instance computed by hand from `η(-1/z)⁴ = (-i z)² η(z)⁴`.  It is the pin that fixes the RESIDUE
CLASS: a statement with `2 ∣ k` on the right, or with the divisor dropped to `2`, would assert
`i^{-2} = 1`, i.e. `-1 = 1`, refuted here through `Complex.one_re`. -/
theorem I_zpow_neg_eq_one_iff_pin_two :
    (I : ℂ) ^ (-(2 : ℤ)) ≠ 1 ∧ ¬ ((4 : ℤ) ∣ (2 : ℤ)) := by
  refine ⟨?_, by decide⟩
  rw [show (-(2 : ℤ)) = (-2 : ℤ) by norm_num, I_zpow_neg_two]
  intro h
  have hre := congrArg Complex.re h
  simp only [Complex.neg_re, Complex.one_re] at hre
  norm_num at hre

/-- **`SDF-08` PIN E — weight `k = 1`, both sides FALSE with a NON-REAL value.**
`i^{-1} = -i ≠ 1` and `4 ∤ 1`.

The weight of `selfDual_eigen_pin_level_four_neg` (level four, eigenvalue `-2i`).  The refutation goes through `Complex.I_im`, not
through a real-part comparison, so it cannot be an artefact of `±1` bookkeeping. -/
theorem I_zpow_neg_eq_one_iff_pin_one :
    (I : ℂ) ^ (-(1 : ℤ)) ≠ 1 ∧ ¬ ((4 : ℤ) ∣ (1 : ℤ)) := by
  refine ⟨?_, by decide⟩
  rw [show (-(1 : ℤ)) = (-1 : ℤ) by norm_num, I_zpow_neg_one]
  intro h
  have him := congrArg Complex.im h
  simp only [Complex.neg_im, Complex.I_im, Complex.one_im] at him
  norm_num at him

/-- **`SDF-08` PIN F — weight `k = 15`, THE PIN NO `±1` COINCIDENCE CAN FAKE.**  `i^{-15} = i`,
which is neither `1` nor `-1`, and `4 ∤ 15`.

The value is obtained from `I_zpow_emod_pin_neg_fifteen` (whose own route runs through `zpow_neg`,
`i^{15} = -i` and `Complex.inv_I`), sharing no lemma with the four-case analysis of the general
proof below.  The first conjunct records the value itself, so the pin is not merely a negation. -/
theorem I_zpow_neg_eq_one_iff_pin_fifteen :
    (I : ℂ) ^ (-(15 : ℤ)) = I ∧ (I : ℂ) ^ (-(15 : ℤ)) ≠ 1 ∧ ¬ ((4 : ℤ) ∣ (15 : ℤ)) := by
  have hval : (I : ℂ) ^ (-(15 : ℤ)) = I := by
    rw [show (-(15 : ℤ)) = (-15 : ℤ) by norm_num, I_zpow_emod_pin_neg_fifteen,
        show ((-15 : ℤ) % 4) = 1 by decide, _root_.zpow_one]
  refine ⟨hval, ?_, by decide⟩
  rw [hval]
  intro h
  have him := congrArg Complex.im h
  simp only [Complex.I_im, Complex.one_im] at him
  norm_num at him

end Sdf08Pins

/-- **`SDF-08`.**  `i^{-k} = 1` exactly when `4 ∣ k`.

This is the condition under which the NORMALISED Fricke eigenvalue of `SDF-06`
(`etaQuotient_fricke_selfDual_normalized`, whose constant is exactly `i^{-k}`) is trivial, i.e. when
a Fricke-self-dual eta quotient of weight `k` is a `+1`-eigenform of the normalised Fricke
involution.

WHAT THIS NODE IS NOT.  It is a fact about `ℂ` and `ℤ` alone.  It mentions no level `N`, no exponent
vector `r`, no point `z`, and no eta quotient; it is NOT a specialisation of `etaQuotient_fricke`
(that specialisation is `SDF-04`).  It is downstream of the Fricke work only through the CONSTANT:
`i^{-k}` is one factor of `frickeEigenvalue N k`.

PROOF.  `SDF-07` (`I_zpow_emod`) reduces the exponent to `(-k) % 4`, which lies in `{0, 1, 2, 3}`
(`Int.emod_nonneg`, `Int.emod_lt_of_pos`, then `omega`).  The three non-zero residues are refuted by
evaluating `i^1 = i`, `i^2 = -1` (`Complex.I_sq`) and `i^3 = -i` (`pow_succ` on top of
`Complex.I_sq` — note `i^3` is NOT `Complex.I_sq` alone) and comparing a single coordinate of the
result with the corresponding coordinate of `1` (`Complex.I_im`, `Complex.one_re`, `Complex.one_im`).
The remaining residue is `(-k) % 4 = 0`, which `omega` converts to `4 ∣ k` in both directions —
`Int.emod_emod_of_dvd` is not needed, since numeral `emod`/`dvd` is inside `omega`'s fragment.

The converse direction also runs through `SDF-07` rather than through the sorry-free
`I_zpow_neg_eq_one` (`EtaQuotientPrimeLevel.lean:630`): that module is a SIBLING of this one — both
import `EtaQuotientModularity` and neither imports the other — so its lemma is not in scope here.
The `_iff` suffix in this name is therefore mandatory, not decorative: `FinalCheck.lean` imports both
modules, and the un-suffixed name is already taken there.

SIX PINS, all above and all sorry-free: PIN A (`k = 12`, the `eta_S_via_fricke` weight), PIN B
(`k = -12`, negative weight), PIN C (`k = 0`, degenerate), PIN D (`k = 2`, both sides false — the
residue-class control, tied to `selfDual_pin_eigenvalue_neg_one`), PIN E (`k = 1`, non-real value),
PIN F (`k = 15`, value `i`, invisible to any `±1` coincidence).
`I_zpow_neg_eq_one_iff_pin_application` re-derives all six by RUNNING this lemma at those weights, so
each pinned instance is settled twice by routes that do not meet, and they agree. -/
theorem I_zpow_neg_eq_one_iff (k : ℤ) : (I : ℂ) ^ (-k) = 1 ↔ (4 : ℤ) ∣ k := by
  have h0 : (0 : ℤ) ≤ (-k) % 4 := Int.emod_nonneg _ (by norm_num)
  have h4 : (-k) % 4 < 4 := Int.emod_lt_of_pos _ (by norm_num)
  constructor
  · intro h
    rw [I_zpow_emod] at h
    have hcase : (-k) % 4 = 0 ∨ (-k) % 4 = 1 ∨ (-k) % 4 = 2 ∨ (-k) % 4 = 3 := by omega
    rcases hcase with he | he | he | he
    · omega
    · rw [he, _root_.zpow_one] at h
      have him := congrArg Complex.im h
      simp only [Complex.I_im, Complex.one_im] at him
      norm_num at him
    · rw [he, show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq] at h
      have hre := congrArg Complex.re h
      simp only [Complex.neg_re, Complex.one_re] at hre
      norm_num at hre
    · rw [he, show (3 : ℤ) = ((3 : ℕ) : ℤ) by norm_num, zpow_natCast,
          show (3 : ℕ) = 2 + 1 from by norm_num, pow_succ, Complex.I_sq] at h
      have him := congrArg Complex.im h
      simp only [neg_mul, one_mul, Complex.neg_im, Complex.I_im, Complex.one_im] at him
      norm_num at him
  · intro h
    rw [I_zpow_emod, show (-k) % 4 = 0 by omega, _root_.zpow_zero]

/-- **`SDF-08` APPLICATION CHECKS — the general lemma reproduces the pins.**  Each conjunct is one
pinned weight, but REACHED BY RUNNING `I_zpow_neg_eq_one_iff` there, so every pinned instance is
settled twice by routes sharing no lemma, and they agree.  The `k = 2` conjunct is the informative
one in the FALSE direction (its `ℂ` value is `-1`, so a wrong residue class would show up here), and
the `k = 15` conjunct is the one whose value is neither `1` nor `-1`. -/
theorem I_zpow_neg_eq_one_iff_pin_application :
    ((I : ℂ) ^ (-(12 : ℤ)) = 1 ↔ (4 : ℤ) ∣ (12 : ℤ)) ∧
      ((I : ℂ) ^ (-(-12 : ℤ)) = 1 ↔ (4 : ℤ) ∣ (-12 : ℤ)) ∧
      ((I : ℂ) ^ (-(0 : ℤ)) = 1 ↔ (4 : ℤ) ∣ (0 : ℤ)) ∧
      ((I : ℂ) ^ (-(2 : ℤ)) = 1 ↔ (4 : ℤ) ∣ (2 : ℤ)) ∧
      ((I : ℂ) ^ (-(1 : ℤ)) = 1 ↔ (4 : ℤ) ∣ (1 : ℤ)) ∧
      ((I : ℂ) ^ (-(15 : ℤ)) = 1 ↔ (4 : ℤ) ∣ (15 : ℤ)) :=
  ⟨I_zpow_neg_eq_one_iff 12, I_zpow_neg_eq_one_iff (-12), I_zpow_neg_eq_one_iff 0,
    I_zpow_neg_eq_one_iff 2, I_zpow_neg_eq_one_iff 1, I_zpow_neg_eq_one_iff 15⟩

/-! ### `SDF-09` pins — the SIGN criterion at concrete weights, computed independently

`SDF-09` differs from `SDF-08` in exactly one place — the value on the right — and that place is the
SIGN of the Fricke eigenvalue, the quantity a sign error corrupts.  The pins are therefore chosen so
that the `k = 2` instance, where the eigenvalue really is `-1` (`selfDual_pin_eigenvalue_neg_one`,
`η⁴` at level one, computed by hand from `η(-1/z)⁴ = (-i z)² η(z)⁴ = -z² η(z)⁴`), is settled by a
route that cannot touch the general lemma: every pin is stated ABOVE it, so Lean scoping forbids it.

Outside Lean, and BEFORE any of this was stated here, `i^{-k} = -1 ↔ k % 4 = 2` was checked in exact
Gaussian-integer arithmetic at all `401` weights `k ∈ [-200, 200]` — positive powers by repeated
multiplication, negative ones by conjugation (since `|i^m| = 1`), and `%` taken as `Int.emod`, which
is the `Mod Int` instance Lean uses.  Zero mismatches.

THE `k` VERSUS `-k` QUESTION, settled rather than assumed.  The right-hand side is stated on `k`, not
on `-k`.  Those are genuinely DIFFERENT predicates: `1 % 4 = 1` while `(-1) % 4 = 3`, and `15 % 4 = 3`
while `(-15) % 4 = 1` (`I_zpow_neg_eq_neg_one_iff_pin_k_not_neg_k`).  They nevertheless have the SAME
fibre over `2`, because `k = 4q + 2 ↔ -k = 4(-q-1) + 2` (`I_zpow_neg_eq_neg_one_iff_emod_neg`, by
`omega`).  Do not rewrite the statement into the `-k` form on the strength of the second fact without
noticing the first: the two forms agree only on this one residue class.

THE `emod`-VERSUS-`tmod` HAZARD, pinned rather than trusted.  `%` on `ℤ` is `Int.emod`, whose
representative lies in `[0, 4)` (`I_zpow_emod_exponent_mem`).  Had it been `Int.tmod`, PIN E would be
FALSE — `Int.tmod (-2) 4 = -2`, not `2` — and the statement would fail at EVERY negative weight in
the residue class, which is precisely the class the eigenvalue `-1` lives in.
`I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod` records both values so the hazard is machine-checked
rather than argued.

THE PINNED WEIGHTS, and why each one:

* `k = 12`  — the `N = 1`, `r = (24)` case behind the already sorry-free `eta_S_via_fricke`
  (`EtaQuotientModularity.lean:2246`), and also the weight of the genuine `N = 6` self-dual instance
  `selfDual_eigen_pin_level_six`.  BOTH sides FALSE: `i^{-12} = 1`, which is not `-1`
  (`I_zpow_neg_twelve`, refuted through `Complex.one_re`), and `12 % 4 = 0`.
* `k = -12` — the NEGATIVE weight of `selfDual_eigen_pin_level_six_neg`.  Both sides FALSE, reached
  through `I_zpow_twelve` after `neg_neg`, i.e. by a different value lemma than PIN A.
* `k = 0`   — THE DEGENERATE CASE (`r ≡ 0`, `selfDual_eigen_pin_zero_exp`).  Both sides FALSE, and
  worth little: after `neg_zero` the left side is `zpow_zero`.  Recorded because the degenerate case
  belongs to the required pin set, not as evidence.
* `k = 2`   — THE LOAD-BEARING PIN, and the only weight in this section where BOTH sides are TRUE:
  `i^{-2} = -1` (`I_zpow_neg_two`) and `2 % 4 = 2`.  It is `frickeEigenvalue_pin_neg_one` /
  `selfDual_pin_eigenvalue_neg_one`, the one machine-checked witness in this file that
  `frickeEigenvalue` ever takes the value `-1`.  If `SDF-09` had the wrong residue class on the
  right, this pin and that eta-quotient instance would disagree.
* `k = -2`  — THE `emod` PIN: both sides TRUE at a NEGATIVE weight, `i^{-(-2)} = i^2 = -1`
  (`Complex.I_sq`, so not the same value lemma as PIN D) and `(-2) % 4 = 2`.
* `k = 15`  — the pin no `±1` coincidence can fake: `i^{-15} = i`, which is neither `1` nor `-1`, and
  `15 % 4 = 3`.  Its value comes from `I_zpow_emod_pin_neg_fifteen`, whose route (`zpow_neg`,
  `i^{15} = -i`, `Complex.inv_I`) shares no lemma with the four-case analysis below; and it is the
  pin that sees the `k`-versus-`-k` asymmetry from the side opposite to `k = 1`. -/

section Sdf09Pins

/-- **`SDF-09` PIN A — weight `k = 12`, BOTH SIDES FALSE.**  `i^{-12} = 1 ≠ -1` and `12 % 4 = 0 ≠ 2`.

The weight of the `N = 1`, `r = (24)` instance behind the sorry-free `eta_S_via_fricke`, and of the
`N = 6` self-dual instance.  The left conjunct goes through `I_zpow_neg_twelve` and is refuted by
comparing real parts (`Complex.one_re`, `Complex.neg_re`); the right by `decide`. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_twelve :
    (I : ℂ) ^ (-(12 : ℤ)) ≠ -1 ∧ ¬ ((12 : ℤ) % 4 = 2) := by
  refine ⟨?_, by decide⟩
  rw [show (-(12 : ℤ)) = (-12 : ℤ) by norm_num, I_zpow_neg_twelve]
  intro h
  have hre := congrArg Complex.re h
  simp only [Complex.one_re, Complex.neg_re] at hre
  norm_num at hre

/-- **`SDF-09` PIN B — weight `k = -12`, the NEGATIVE-WEIGHT pin, both sides FALSE.**
`i^{-(-12)} = i^{12} = 1 ≠ -1` and `(-12) % 4 = 0 ≠ 2`.

The weight of `selfDual_eigen_pin_level_six_neg` (`SDF-05` PIN E).  Reached through `I_zpow_twelve`
after `neg_neg`, so this pin and PIN A do not share a value lemma.  A proof of `SDF-09` that assumed
`0 ≤ k` would fail here. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_neg_twelve :
    (I : ℂ) ^ (-(-12 : ℤ)) ≠ -1 ∧ ¬ ((-12 : ℤ) % 4 = 2) := by
  refine ⟨?_, by decide⟩
  rw [neg_neg, I_zpow_twelve]
  intro h
  have hre := congrArg Complex.re h
  simp only [Complex.one_re, Complex.neg_re] at hre
  norm_num at hre

/-- **`SDF-09` PIN C — the degenerate weight `k = 0` (`r ≡ 0`, `selfDual_eigen_pin_zero_exp`).**
`i^0 = 1 ≠ -1` and `0 % 4 = 0 ≠ 2`.

DEGENERATE AND GUARDED AS SUCH: after `neg_zero` the left conjunct is `zpow_zero`, so this pin
constrains essentially nothing.  It is here because the degenerate case belongs to the required pin
set, not because it is evidence. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_zero :
    (I : ℂ) ^ (-(0 : ℤ)) ≠ -1 ∧ ¬ ((0 : ℤ) % 4 = 2) := by
  refine ⟨?_, by decide⟩
  rw [neg_zero, _root_.zpow_zero]
  intro h
  have hre := congrArg Complex.re h
  simp only [Complex.one_re, Complex.neg_re] at hre
  norm_num at hre

/-- **`SDF-09` PIN D — weight `k = 2`, BOTH SIDES TRUE.  THE LOAD-BEARING PIN.**
`i^{-2} = -1` and `2 % 4 = 2`.

This is the weight of `selfDual_pin_eigenvalue_neg_one` (`f = η⁴`, level one, eigenvalue `-1`), the
instance computed by hand from `η(-1/z)⁴ = (√(-i z))⁴ η(z)⁴ = (-i z)² η(z)⁴ = -z² η(z)⁴`, and of
`frickeEigenvalue_pin_neg_one` (`frickeEigenvalue 1 2 = -1`, sorry-free above).  It is the ONLY
weight in this section at which the criterion fires, so it is the pin that fixes the residue class:
a statement with `4 ∣ k` on the right (i.e. `SDF-08`'s class), or with `k % 4 = 0`, would assert
`i^{-2} = 1`, contradicting `I_zpow_neg_two`.  Left conjunct via `I_zpow_neg_two`, right by `decide`. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_two :
    (I : ℂ) ^ (-(2 : ℤ)) = -1 ∧ (2 : ℤ) % 4 = 2 :=
  ⟨by rw [show (-(2 : ℤ)) = (-2 : ℤ) by norm_num, I_zpow_neg_two], by decide⟩

/-- **`SDF-09` PIN E — weight `k = -2`, both sides TRUE at a NEGATIVE weight.  THE `emod` PIN.**
`i^{-(-2)} = i^2 = -1` and `(-2) % 4 = 2`.

This is the pin that fixes `%` as `Int.emod`: under `Int.tmod` the right-hand side would read
`Int.tmod (-2) 4 = -2 ≠ 2` and the pin would be FALSE, so `SDF-09` would fail at every negative
weight in the residue class — exactly the weights at which the eigenvalue is `-1`.  See
`I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod` for both values side by side.  The value is computed
from `Complex.I_sq` after `neg_neg`, NOT from `I_zpow_neg_two`, so PIN D and PIN E agree without
sharing a route. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_neg_two :
    (I : ℂ) ^ (-(-2 : ℤ)) = -1 ∧ (-2 : ℤ) % 4 = 2 := by
  refine ⟨?_, by decide⟩
  rw [neg_neg, show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq]

/-- **`SDF-09` PIN F — weight `k = 15`, THE PIN NO `±1` COINCIDENCE CAN FAKE.**  `i^{-15} = i`,
which is neither `1` nor `-1`, and `15 % 4 = 3 ≠ 2`.

The value is obtained from `I_zpow_emod_pin_neg_fifteen`, whose own route runs through `zpow_neg`,
`i^{15} = -i` and `Complex.inv_I`, sharing no lemma with the four-case analysis of the general proof
below.  The first conjunct records the value itself, so the pin is not merely a negation; the
refutation compares imaginary parts (`Complex.I_im`), so it cannot be an artefact of `±1`
bookkeeping.  This is also the weight where `k % 4 = 3` but `(-k) % 4 = 1`, the mirror of `k = 1`. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_fifteen :
    (I : ℂ) ^ (-(15 : ℤ)) = I ∧ (I : ℂ) ^ (-(15 : ℤ)) ≠ -1 ∧ ¬ ((15 : ℤ) % 4 = 2) := by
  have hval : (I : ℂ) ^ (-(15 : ℤ)) = I := by
    rw [show (-(15 : ℤ)) = (-15 : ℤ) by norm_num, I_zpow_emod_pin_neg_fifteen,
        show ((-15 : ℤ) % 4) = 1 by decide, _root_.zpow_one]
  refine ⟨hval, ?_, by decide⟩
  rw [hval]
  intro h
  have him := congrArg Complex.im h
  simp only [Complex.I_im, Complex.neg_im, Complex.one_im] at him
  norm_num at him

/-- **`SDF-09` NEGATIVE CONTROL 1 — the `k` form and the `-k` form are DIFFERENT predicates.**
`1 % 4 = 1` but `(-1) % 4 = 3`, and `15 % 4 = 3` but `(-15) % 4 = 1`.

So `k % 4` and `(-k) % 4` are not the same function of `k`, and the choice made in `SDF-09`'s
statement is a real choice, not a notational one.  What makes both statements true is the weaker fact
that the two agree on the single residue class `2` (`I_zpow_neg_eq_neg_one_iff_emod_neg`); this
control is here so that fact is not mistaken for the stronger, false one.  `decide`. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_k_not_neg_k :
    ((1 : ℤ) % 4 ≠ (-1 : ℤ) % 4) ∧ ((15 : ℤ) % 4 ≠ (-15 : ℤ) % 4) := by decide

/-- **`SDF-09` NEGATIVE CONTROL 2 — `%` is `Int.emod` and the distinction is load-bearing.**
`(-2) % 4 = 2` while `Int.tmod (-2) 4 = -2`, and `2 ≠ -2`.

Under a truncating remainder the right-hand side of `SDF-09` would be FALSE at `k = -2`, i.e. at a
negative weight whose eigenvalue is genuinely `-1` (PIN E).  Recording both values by `decide` turns
"Lean's `%` is `emod`" from an assumption of this section into a checked fact. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod :
    ((-2 : ℤ) % 4 = 2) ∧ (Int.tmod (-2 : ℤ) 4 = -2) ∧ ((2 : ℤ) ≠ -2) :=
  ⟨by decide, by decide, by decide⟩

end Sdf09Pins

/-- **`SDF-09` — the `k`/`-k` bridge.**  `(-k) % 4 = 2 ↔ k % 4 = 2`.

The four-case analysis of `SDF-09` naturally produces the condition on `-k` (that being the exponent
`SDF-07` reduces), while the statement is on `k`, which is the WEIGHT.  This is the one residue class
on which the two forms agree — see `I_zpow_neg_eq_neg_one_iff_pin_k_not_neg_k` for the two weights
where they do not — and `omega` settles it in both directions from `k = 4q + 2 ↔ -k = 4(-q-1) + 2`,
numeral `emod` being inside `omega`'s fragment. -/
theorem I_zpow_neg_eq_neg_one_iff_emod_neg (k : ℤ) : (-k) % 4 = 2 ↔ k % 4 = 2 := by omega

/-- **`SDF-09`.**  `i^{-k} = -1` exactly when `k ≡ 2 (mod 4)`, i.e. `k % 4 = 2` with `%` the
`Int.emod` of Lean's `Mod Int` instance.

This is the condition under which the NORMALISED Fricke eigenvalue of `SDF-06`
(`etaQuotient_fricke_selfDual_normalized`, whose constant is exactly `i^{-k}`) is `-1`, i.e. when a
Fricke-self-dual eta quotient of weight `k` is a `(-1)`-eigenform of the normalised Fricke
involution.

A SEPARATE NODE FROM `SDF-08` ON PURPOSE: the **sign** of the eigenvalue is precisely the quantity a
sign error would corrupt, and keeping it a node of its own makes a sign regression visible in the DAG
instead of buried inside a conjunction.  PIN D (`k = 2`) is the independently computed instance that
guards it — `selfDual_pin_eigenvalue_neg_one` (`η⁴` at level one, `λ = -1`, computed by hand from the
`η` S-transform) and `frickeEigenvalue_pin_neg_one`, both already sorry-free above.

WHAT THIS NODE IS NOT.  Like `SDF-07` and `SDF-08` it is a fact about `ℂ` and `ℤ` alone.  It mentions
no level `N`, no exponent vector `r`, no point `z` and no eta quotient; it is NOT a specialisation of
`etaQuotient_fricke` (that specialisation is `SDF-04`), and no substitution into that theorem
produces it — `i^{-k}` occurs there only as an opaque subterm of the scalar, about which that theorem
makes no claim.  `SDF-09` is downstream of the Fricke work only through the CONSTANT: `i^{-k}` is one
factor of `frickeEigenvalue N k`.

PROOF.  `SDF-07` (`I_zpow_emod`) reduces the exponent to `(-k) % 4`, which lies in `{0, 1, 2, 3}`
(`Int.emod_nonneg`, `Int.emod_lt_of_pos`, then `omega`).  Three of the four residues are refuted by
evaluating the power and comparing ONE coordinate with the corresponding coordinate of `-1`:
`i^0 = 1` against `Complex.one_re`/`Complex.neg_re`, `i^1 = i` and `i^3 = -i` against `Complex.I_im`
(`i^3` needs `pow_succ` ON TOP OF `Complex.I_sq` — `I_sq` alone does not reach it).  The surviving
residue is `(-k) % 4 = 2`, where `Complex.I_sq` gives the value `-1` and `omega` converts
`(-k) % 4 = 2` to `k % 4 = 2` in both directions; that conversion is isolated as
`I_zpow_neg_eq_neg_one_iff_emod_neg` above so it can be inspected on its own.  `Complex.ext_iff` is
NOT used (single-coordinate `congrArg` suffices), and neither is `Int.emod_emod_of_dvd`.

SIX PINS AND TWO NEGATIVE CONTROLS, all above, all sorry-free, all stated before this lemma so Lean
scoping forbids them from using it: PIN A (`k = 12`, the `eta_S_via_fricke` weight, both sides false),
PIN B (`k = -12`, negative weight), PIN C (`k = 0`, degenerate), PIN D (`k = 2`, BOTH SIDES TRUE — the
load-bearing pin, tied to `selfDual_pin_eigenvalue_neg_one`), PIN E (`k = -2`, both sides true at a
negative weight — the `emod` pin), PIN F (`k = 15`, value `i`, invisible to any `±1` coincidence);
controls `..._pin_k_not_neg_k` (the `k` and `-k` forms are different predicates) and
`..._pin_emod_not_tmod` (`%` is `Int.emod`, and under `tmod` PIN E would be false).
`I_zpow_neg_eq_neg_one_iff_pin_application` re-derives all six pins by RUNNING this lemma at those
weights, so every pinned instance is settled twice by routes that do not meet, and they agree. -/
theorem I_zpow_neg_eq_neg_one_iff (k : ℤ) : (I : ℂ) ^ (-k) = -1 ↔ k % 4 = 2 := by
  have h0 : (0 : ℤ) ≤ (-k) % 4 := Int.emod_nonneg _ (by norm_num)
  have h4 : (-k) % 4 < 4 := Int.emod_lt_of_pos _ (by norm_num)
  constructor
  · intro h
    rw [I_zpow_emod] at h
    have hcase : (-k) % 4 = 0 ∨ (-k) % 4 = 1 ∨ (-k) % 4 = 2 ∨ (-k) % 4 = 3 := by omega
    rcases hcase with he | he | he | he
    · rw [he, _root_.zpow_zero] at h
      have hre := congrArg Complex.re h
      simp only [Complex.one_re, Complex.neg_re] at hre
      norm_num at hre
    · rw [he, _root_.zpow_one] at h
      have him := congrArg Complex.im h
      simp only [Complex.I_im, Complex.neg_im, Complex.one_im] at him
      norm_num at him
    · omega
    · rw [he, show (3 : ℤ) = ((3 : ℕ) : ℤ) by norm_num, zpow_natCast,
          show (3 : ℕ) = 2 + 1 from by norm_num, pow_succ, Complex.I_sq] at h
      have him := congrArg Complex.im h
      simp only [neg_mul, one_mul, Complex.neg_im, Complex.I_im, Complex.one_im] at him
      norm_num at him
  · intro h
    rw [I_zpow_emod, show (-k) % 4 = 2 by omega,
        show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq]

/-- **`SDF-09` APPLICATION CHECKS — the general lemma reproduces the pins.**  Each conjunct is one
pinned weight, but REACHED BY RUNNING `I_zpow_neg_eq_neg_one_iff` there, so every pinned instance is
settled twice by routes sharing no lemma, and they agree.  The `k = 2` and `k = -2` conjuncts are the
informative ones in the TRUE direction (they are where the eigenvalue is `-1`, and `k = -2` is where
a truncating `%` would break), and the `k = 15` conjunct is the one whose value is neither `1` nor
`-1`. -/
theorem I_zpow_neg_eq_neg_one_iff_pin_application :
    ((I : ℂ) ^ (-(12 : ℤ)) = -1 ↔ (12 : ℤ) % 4 = 2) ∧
      ((I : ℂ) ^ (-(-12 : ℤ)) = -1 ↔ (-12 : ℤ) % 4 = 2) ∧
      ((I : ℂ) ^ (-(0 : ℤ)) = -1 ↔ (0 : ℤ) % 4 = 2) ∧
      ((I : ℂ) ^ (-(2 : ℤ)) = -1 ↔ (2 : ℤ) % 4 = 2) ∧
      ((I : ℂ) ^ (-(-2 : ℤ)) = -1 ↔ (-2 : ℤ) % 4 = 2) ∧
      ((I : ℂ) ^ (-(15 : ℤ)) = -1 ↔ (15 : ℤ) % 4 = 2) :=
  ⟨I_zpow_neg_eq_neg_one_iff 12, I_zpow_neg_eq_neg_one_iff (-12), I_zpow_neg_eq_neg_one_iff 0,
    I_zpow_neg_eq_neg_one_iff 2, I_zpow_neg_eq_neg_one_iff (-2), I_zpow_neg_eq_neg_one_iff 15⟩

/-! ### `SDF-10` … `SDF-13` — the modulus of the UNNORMALISED eigenvalue, and when it is `±1` -/

/-! #### `SDF-10` pins — the MODULUS criterion at concrete levels and weights, computed
independently and stated BEFORE the general lemma

`SDF-08` and `SDF-09` settled the ROOT OF UNITY `i^{-k}`.  `SDF-10` settles the other factor of
`frickeEigenvalue N k`, the positive real modulus `√(N^k)`, by settling `N^k` itself: for a positive
natural base the integer power hits `1` only in the two degenerate ways, `N = 1` or `k = 0`.  It is
what rules out any `N > 1` with `k ≠ 0` in `SDF-12`/`SDF-13`.

WHAT THIS NODE IS, AND WHAT IT IS NOT.  It is an equivalence between a `zpow` equation in `ℝ` and a
disjunction of two decidable conditions on `(N, k)`.  It mentions no exponent vector `r`, no point
`z`, no eta quotient and no `Complex.I`, and it is NOT a specialisation of `etaQuotient_fricke` — no
substitution into that theorem produces it, since `N^k` occurs there only inside the opaque scalar
and that theorem makes no claim about when the scalar's modulus is `1`.  That specialisation is
`SDF-04`.  `SDF-10` is downstream of the Fricke work only through the CONSTANT.  (The statement
comparator for this node was pointed at `etaQuotient_fricke` and correctly returned NO_REFERENCE for
exactly that reason; the real reference is Mathlib's `zpow_eq_one_iff_right₀`.)

BEFORE any of this was stated in Lean, `N^k = 1 ↔ (N = 1 ∨ k = 0)` was checked outside Lean in exact
rational arithmetic (`fractions.Fraction`, no floating point) at all `20301` instances
`N ∈ [0, 100]`, `k ∈ [-100, 100]`, with the `N = 0` row evaluated under Lean's convention
`(0 : ℝ)⁻¹ = 0` (so `0^k = 0` for every `k ≠ 0`).  Zero mismatches.

THE PINNED INSTANCES, and why each one:

* `N = 1`, `k = 12`  — THE `eta_S_via_fricke` INSTANCE (`r = (24)` at level one,
  `EtaQuotientModularity.lean:2246`; here `selfDual_eigen_pin_level_one`).  BOTH sides TRUE, through
  the left disjunct `N = 1` at a weight that is NOT `0`, so it is the pin that forces the disjunction
  to have a level clause at all.
* `N = 6`, `k = 12`  — THE GENUINE `N > 1` SELF-DUAL INSTANCE (`rPinSix = (1, 11, 11, 1)`,
  `selfDual_cond_pin_level_six`, `selfDual_eigen_pin_level_six`).  BOTH sides FALSE: `6^12` is the
  eight-figure integer `2176782336`, and neither disjunct holds.  This is the pin the whole node
  exists for — it is what makes the `±1` classification sharp rather than vacuous.
* `N = 6`, `k = 0`   — THE DEGENERATE CASE `r ≡ 0` (`selfDual_cond_pin_zero_exp`,
  `selfDual_eigen_pin_zero_exp`).  BOTH sides TRUE, through the right disjunct `k = 0`, at a level
  that is NOT `1`, so it is the pin that forces the disjunction to have a weight clause at all.
* `N = 4`, `k = 1`   — the ODD-WEIGHT instance (`rPinLevelFourNeg`, `selfDual_eigen_pin_level_four_neg`).
  Both sides FALSE with the smallest non-trivial value, `4^1 = 4`.
* `N = 6`, `k = -12` — THE NEGATIVE-WEIGHT PIN (`rPinLevelSixNeg`, `selfDual_eigen_pin_level_six_neg`).
  Both sides FALSE, and here the power is the proper fraction `1/2176782336`, NOT an integer.  A
  proof or a statement that silently assumed `0 ≤ k` — for instance by reading `zpow` as `Monoid.npow`
  — would break exactly here, at a weight this file has a real self-dual eta-quotient instance for.
* `N = 1`, `k = -12` — both sides TRUE at a NEGATIVE weight, so the level-one disjunct is checked on
  both sides of `k = 0` and not only at positive weight.

WHICH PINS CARRY WEIGHT.  PIN B is the load-bearing one; PIN E is the one that sees the sign of `k`.
PIN C is DEGENERATE and is recorded as such, not as evidence: at `k = 0` the left side is `zpow_zero`.

PIN B, CHECKED TWICE.  `natCast_zpow_pin_level_six_value` computes `6^12 = 2176782336` by `norm_num`.
`natCast_zpow_pin_level_six_routes_agree` gets the same number a second way, by SQUARING the already
sorry-free `sqrt_natPow_level_six` (`√(6^12) = 46656`, section `Sdf03Pins`, which is what
`fricke_const_pin_level_six` and `frickeEigenvalue_pin_level_six` are built on) through
`Real.sq_sqrt`, and then records `46656² = 2176782336`.  So the modulus this node rules out and the
modulus `SDF-03` computed are the same number, and a disagreement between them would fail the build
rather than be discovered downstream.

TWO NEGATIVE CONTROLS, one per disjunct, showing NEITHER is droppable:
`natCast_zpow_eq_one_iff_pin_not_weight_only` exhibits `1^12 = 1` with `12 ≠ 0`, refuting the
strengthened form `(N : ℝ)^k = 1 ↔ k = 0`; `natCast_zpow_eq_one_iff_pin_not_level_only` exhibits
`6^0 = 1` with `6 ≠ 1`, refuting `(N : ℝ)^k = 1 ↔ N = 1`.  Together they also refute the conjunctive
form `N = 1 ∧ k = 0`.  The disjunction is therefore exactly right, not merely sufficient.

THE `hN` HYPOTHESIS IS REDUNDANT, AND THIS IS PINNED RATHER THAN GLOSSED.
`natCast_zpow_eq_one_iff_pin_hypothesis_redundant` proves the SAME biconditional at `N = 0`, at a
positive, a negative and a zero weight, using Mathlib's `zero_zpow_eq_one₀`.  `hN` is kept anyway,
and is deliberately UNUSED in the proof below: every consumer of this lemma (`SDF-12`, `SDF-13` and
the eigenvalue lemmas) already carries `hN : 0 < N`, so keeping it makes this lemma's shape match its
siblings.  It is stylistic uniformity, not mathematical necessity, and a future reader must not
infer from its presence that the statement fails at `N = 0`.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node is an equivalence between a power of
a cast natural in `ℝ` and a disjunction of two arithmetic conditions.  Persson–Volpato
(arXiv:1504.07260) is cited in this file's docstring as the ORIGIN of the question only, at the
literature (L) tier. -/

section Sdf10Pins

/-- **`SDF-10` PIN A — level `N = 1`, weight `k = 12`; BOTH SIDES TRUE.**  `1^12 = 1` and the left
disjunct `N = 1` holds, at a weight that is not `0`.

This is the `r = (24)`, level-one instance behind the sorry-free `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`) and `selfDual_eigen_pin_level_one`.  It is the pin that forces
the right-hand side to carry a LEVEL clause: without the `N = 1` disjunct the biconditional would be
false here. -/
theorem natCast_zpow_eq_one_iff_pin_level_one :
    ((1 : ℕ) : ℝ) ^ (12 : ℤ) = 1 ∧ ((1 : ℕ) = 1 ∨ (12 : ℤ) = 0) := by
  refine ⟨?_, Or.inl rfl⟩
  rw [Nat.cast_one, _root_.one_zpow]

/-- `6^12 = 2176782336`, by `norm_num`.  The modulus of the genuine `N > 1` self-dual instance
`selfDual_eigen_pin_level_six` (`rPinSix = (1, 11, 11, 1)` at level six, weight twelve). -/
theorem natCast_zpow_pin_level_six_value : ((6 : ℕ) : ℝ) ^ (12 : ℤ) = 2176782336 := by
  norm_num

/-- THE SAME NUMBER, REACHED A SECOND WAY.  `sqrt_natPow_level_six` (section `Sdf03Pins`, already
sorry-free, and the lemma `fricke_const_pin_level_six` / `frickeEigenvalue_pin_level_six` rest on)
says `√(6^12) = 46656`.  Squaring it through `Real.sq_sqrt` returns `6^12 = 46656²`, and
`46656² = 2176782336` — the value `natCast_zpow_pin_level_six_value` computed directly.  So the
modulus this node rules out and the modulus `SDF-03` computed agree, and a disagreement would fail
the build here rather than surface downstream. -/
theorem natCast_zpow_pin_level_six_routes_agree :
    ((6 : ℕ) : ℝ) ^ (12 : ℤ) = (46656 : ℝ) ^ 2 ∧ (46656 : ℝ) ^ 2 = 2176782336 := by
  refine ⟨?_, by norm_num⟩
  rw [← sqrt_natPow_level_six, Real.sq_sqrt (by positivity)]

/-- **`SDF-10` PIN B — level `N = 6`, weight `k = 12`; BOTH SIDES FALSE.**  THE LOAD-BEARING PIN:
`6^12 = 2176782336 ≠ 1`, and neither `6 = 1` nor `12 = 0`.

This is the genuine `N > 1` Fricke-self-dual instance of this file (`rPinSix`,
`selfDual_cond_pin_level_six`, `selfDual_eigen_pin_level_six`).  It is what makes the `±1`
classification of `SDF-12`/`SDF-13` sharp instead of vacuous: at a real self-dual eta quotient of
level six and weight twelve the unnormalised eigenvalue is NOT of modulus one. -/
theorem natCast_zpow_eq_one_iff_pin_level_six :
    ((6 : ℕ) : ℝ) ^ (12 : ℤ) ≠ 1 ∧ ¬ ((6 : ℕ) = 1 ∨ (12 : ℤ) = 0) := by
  refine ⟨?_, by decide⟩
  rw [natCast_zpow_pin_level_six_value]
  norm_num

/-- **`SDF-10` PIN C — weight `k = 0` at level `N = 6`; BOTH SIDES TRUE, and DEGENERATE.**
`6^0 = 1` by `zpow_zero`, and the right disjunct `k = 0` holds at a level that is not `1`.

The `r ≡ 0` case (`selfDual_cond_pin_zero_exp`, `selfDual_eigen_pin_zero_exp`).  It is the pin that
forces the right-hand side to carry a WEIGHT clause.  It is recorded as degenerate, not as evidence:
its left conjunct is `zpow_zero` and settles nothing about the base. -/
theorem natCast_zpow_eq_one_iff_pin_zero_weight :
    ((6 : ℕ) : ℝ) ^ (0 : ℤ) = 1 ∧ ((6 : ℕ) = 1 ∨ (0 : ℤ) = 0) :=
  ⟨zpow_zero _, Or.inr rfl⟩

/-- `4^1 = 4`. -/
theorem natCast_zpow_pin_level_four_value : ((4 : ℕ) : ℝ) ^ (1 : ℤ) = 4 := by norm_num

/-- **`SDF-10` PIN D — level `N = 4`, weight `k = 1`; BOTH SIDES FALSE.**  The ODD-WEIGHT instance
(`rPinLevelFourNeg`, `selfDual_eigen_pin_level_four_neg`), with the smallest non-trivial value:
`4^1 = 4 ≠ 1`, and neither `4 = 1` nor `1 = 0`. -/
theorem natCast_zpow_eq_one_iff_pin_level_four :
    ((4 : ℕ) : ℝ) ^ (1 : ℤ) ≠ 1 ∧ ¬ ((4 : ℕ) = 1 ∨ (1 : ℤ) = 0) := by
  refine ⟨?_, by decide⟩
  rw [natCast_zpow_pin_level_four_value]
  norm_num

/-- `6^{-12} = 1/2176782336`, a PROPER FRACTION and not an integer.  Reached from PIN B's value
through `zpow_neg`, so the negative-weight pin below does not recompute the base power. -/
theorem natCast_zpow_pin_level_six_neg_value :
    ((6 : ℕ) : ℝ) ^ (-12 : ℤ) = (2176782336 : ℝ)⁻¹ := by
  rw [_root_.zpow_neg, natCast_zpow_pin_level_six_value]

/-- **`SDF-10` PIN E — level `N = 6`, weight `k = -12`; BOTH SIDES FALSE AT A NEGATIVE WEIGHT.**
`6^{-12} = 1/2176782336 ≠ 1`, and neither `6 = 1` nor `-12 = 0`.

THE PIN THAT SEES THE SIGN OF `k`.  Here the power is a proper fraction rather than an integer, so a
statement or a proof that silently read `zpow` as `Monoid.npow`, or assumed `0 ≤ k`, would break
exactly here — and this file has a real Fricke-self-dual eta-quotient instance at this level and
weight (`rPinLevelSixNeg`, `selfDual_eigen_pin_level_six_neg`), so the breakage would be on live
content, not on a hypothetical. -/
theorem natCast_zpow_eq_one_iff_pin_level_six_neg :
    ((6 : ℕ) : ℝ) ^ (-12 : ℤ) ≠ 1 ∧ ¬ ((6 : ℕ) = 1 ∨ (-12 : ℤ) = 0) := by
  refine ⟨?_, by decide⟩
  rw [natCast_zpow_pin_level_six_neg_value]
  norm_num

/-- **`SDF-10` PIN F — level `N = 1`, weight `k = -12`; BOTH SIDES TRUE AT A NEGATIVE WEIGHT.**
`1^{-12} = 1` (`one_zpow` holds at every integer exponent, not only the non-negative ones), and the
left disjunct `N = 1` holds.  PIN A checked the level-one disjunct above `k = 0`; this checks it
below. -/
theorem natCast_zpow_eq_one_iff_pin_level_one_neg :
    ((1 : ℕ) : ℝ) ^ (-12 : ℤ) = 1 ∧ ((1 : ℕ) = 1 ∨ (-12 : ℤ) = 0) := by
  refine ⟨?_, Or.inl rfl⟩
  rw [Nat.cast_one, _root_.one_zpow]

/-- **`SDF-10` NEGATIVE CONTROL 1 — the `N = 1` disjunct is NOT droppable.**  `1^12 = 1` while
`12 ≠ 0`, so the strengthened form `(N : ℝ)^k = 1 ↔ k = 0` — which is exactly Mathlib's
`zpow_eq_one_iff_right₀` read WITHOUT its `a ≠ 1` hypothesis — is FALSE, and it is false at the
`eta_S_via_fricke` instance. -/
theorem natCast_zpow_eq_one_iff_pin_not_weight_only :
    ((1 : ℕ) : ℝ) ^ (12 : ℤ) = 1 ∧ (12 : ℤ) ≠ 0 :=
  ⟨natCast_zpow_eq_one_iff_pin_level_one.1, by decide⟩

/-- **`SDF-10` NEGATIVE CONTROL 2 — the `k = 0` disjunct is NOT droppable.**  `6^0 = 1` while
`6 ≠ 1`, so the form `(N : ℝ)^k = 1 ↔ N = 1` is FALSE.

Taken with `natCast_zpow_eq_one_iff_pin_not_weight_only`, this also refutes the CONJUNCTIVE form
`N = 1 ∧ k = 0`: each control has one clause true and the other false while the left side holds.  So
the disjunction is exactly right, not merely sufficient. -/
theorem natCast_zpow_eq_one_iff_pin_not_level_only :
    ((6 : ℕ) : ℝ) ^ (0 : ℤ) = 1 ∧ (6 : ℕ) ≠ 1 :=
  ⟨natCast_zpow_eq_one_iff_pin_zero_weight.1, by decide⟩

/-- **`SDF-10` HYPOTHESIS-REDUNDANCY PIN.**  The biconditional also holds at `N = 0`, at a positive,
a negative and a zero weight: `(0 : ℝ)^k = 1 ↔ k = 0` (`zero_zpow_eq_one₀`, which is the `a = 0`
branch inside `zpow_eq_one_iff_right₀`'s own proof), and the right-hand side degenerates to `k = 0`
because `0 = 1` is false.

So `hN : 0 < N` is REDUNDANT in `natCast_zpow_eq_one_iff`.  It is kept, and is deliberately unused in
that proof, only so this lemma's shape matches its consumers (`SDF-12`, `SDF-13`), all of which carry
`hN` already.  Recorded as a machine-checked pin rather than as a remark so no future reader infers
that the statement fails at `N = 0`. -/
theorem natCast_zpow_eq_one_iff_pin_hypothesis_redundant :
    ((((0 : ℕ) : ℝ) ^ (12 : ℤ) = 1) ↔ ((0 : ℕ) = 1 ∨ (12 : ℤ) = 0)) ∧
      ((((0 : ℕ) : ℝ) ^ (-12 : ℤ) = 1) ↔ ((0 : ℕ) = 1 ∨ (-12 : ℤ) = 0)) ∧
      ((((0 : ℕ) : ℝ) ^ (0 : ℤ) = 1) ↔ ((0 : ℕ) = 1 ∨ (0 : ℤ) = 0)) := by
  refine ⟨?_, ?_, ⟨fun _ => Or.inr rfl, fun _ => zpow_zero _⟩⟩
  · rw [Nat.cast_zero, zero_zpow_eq_one₀]
    exact ⟨fun h => absurd h (by decide), fun h => absurd (h.resolve_left (by decide)) (by decide)⟩
  · rw [Nat.cast_zero, zero_zpow_eq_one₀]
    exact ⟨fun h => absurd h (by decide), fun h => absurd (h.resolve_left (by decide)) (by decide)⟩

end Sdf10Pins

/-- **`SDF-10`.**  For `0 < N`, the integer power `(N : ℝ)^k` equals `1` only in the two
degenerate ways: `N = 1`, or `k = 0`.

This is the step that makes the unnormalised `±1` conditions sharp — it is what rules out any
`N > 1` with `k ≠ 0`.

PROOF.  Split on `N = 1`.  There `Nat.cast_one` and `one_zpow` make the left side `1 = 1`, true at
EVERY integer exponent (`PIN F` is the negative-weight instance of that), and the left disjunct
supplies the right side.  Otherwise `N ≠ 1`, so `(N : ℝ) ≠ 1` by injectivity of the cast, and
Mathlib's `zpow_eq_one_iff_right₀ (ha₀ : 0 ≤ a) (ha₁ : a ≠ 1) : a ^ n = 1 ↔ n = 0`
(`Algebra/Order/GroupWithZero/Basic.lean:1357`) applies with `ha₀ := Nat.cast_nonneg N`, turning the
goal into `k = 0 ↔ (N = 1 ∨ k = 0)`, which `Or.resolve_left` closes against `N ≠ 1`.

`hN` IS UNUSED, DELIBERATELY.  The statement is true at `N = 0` as well — see
`natCast_zpow_eq_one_iff_pin_hypothesis_redundant`, which proves it there.  The hypothesis is kept
solely so this lemma's shape matches `SDF-12` and `SDF-13`, which need it. -/
theorem natCast_zpow_eq_one_iff {N : ℕ} (hN : 0 < N) (k : ℤ) :
    (N : ℝ) ^ k = 1 ↔ (N = 1 ∨ k = 0) := by
  rcases eq_or_ne N 1 with h1 | h1
  · subst h1
    rw [Nat.cast_one, _root_.one_zpow]
    exact ⟨fun _ => Or.inl rfl, fun _ => rfl⟩
  · have hne : (N : ℝ) ≠ 1 := by exact_mod_cast h1
    rw [zpow_eq_one_iff_right₀ (Nat.cast_nonneg N) hne]
    exact ⟨fun h => Or.inr h, fun h => h.resolve_left h1⟩

/-- **`SDF-10` APPLICATION CHECKS — the general lemma reproduces the pins.**  Each conjunct is one
pinned `(N, k)`, but REACHED BY RUNNING `natCast_zpow_eq_one_iff` there, so every pinned instance is
settled twice by routes sharing no lemma, and they agree.  `(6, 12)` and `(6, -12)` are the
informative conjuncts — they are where both sides are FALSE, and `(6, -12)` is where a proof that
assumed a non-negative exponent would break. -/
theorem natCast_zpow_eq_one_iff_pin_application :
    ((((1 : ℕ) : ℝ) ^ (12 : ℤ) = 1) ↔ ((1 : ℕ) = 1 ∨ (12 : ℤ) = 0)) ∧
      ((((6 : ℕ) : ℝ) ^ (12 : ℤ) = 1) ↔ ((6 : ℕ) = 1 ∨ (12 : ℤ) = 0)) ∧
      ((((6 : ℕ) : ℝ) ^ (0 : ℤ) = 1) ↔ ((6 : ℕ) = 1 ∨ (0 : ℤ) = 0)) ∧
      ((((4 : ℕ) : ℝ) ^ (1 : ℤ) = 1) ↔ ((4 : ℕ) = 1 ∨ (1 : ℤ) = 0)) ∧
      ((((6 : ℕ) : ℝ) ^ (-12 : ℤ) = 1) ↔ ((6 : ℕ) = 1 ∨ (-12 : ℤ) = 0)) ∧
      ((((1 : ℕ) : ℝ) ^ (-12 : ℤ) = 1) ↔ ((1 : ℕ) = 1 ∨ (-12 : ℤ) = 0)) :=
  ⟨natCast_zpow_eq_one_iff (by decide) 12, natCast_zpow_eq_one_iff (by decide) 12,
    natCast_zpow_eq_one_iff (by decide) 0, natCast_zpow_eq_one_iff (by decide) 1,
    natCast_zpow_eq_one_iff (by decide) (-12), natCast_zpow_eq_one_iff (by decide) (-12)⟩

/-! ### `SDF-11` — the MODULUS of the unnormalised eigenvalue

`SDF-07` … `SDF-09` settled the root-of-unity factor `i^{-k}` of `frickeEigenvalue N k`, and
`SDF-10` settled when the real factor's radicand `N^k` is `1`.  This node computes the whole
eigenvalue's modulus in closed form:

`‖frickeEigenvalue N k‖ = √((N : ℝ)^k)`.

WHY IT IS WORTH A NODE.  `frickeEigenvalue N k = i^{-k} · √(N^k)` is a product of a fourth root of
unity and a NON-NEGATIVE real, so the `i`-factor contributes nothing to the modulus and the real
factor contributes itself.  That is the whole content, and it is what makes the `±1` classification
of `SDF-12`/`SDF-13` split cleanly into an ARGUMENT condition (`SDF-08`/`SDF-09`) and a MODULUS
condition (`SDF-10`): `λ = ±1` forces `‖λ‖ = 1`, and by this node `‖λ‖ = 1` is `√(N^k) = 1`, which
is `SDF-10`'s `N^k = 1`.  Without it that split is asserted rather than proved.

WHAT `SDF-11` IS NOT.  Like `SDF-07` … `SDF-10` it is a fact about a scalar alone — no exponent
vector, no `z`, no eta quotient, no `IsFrickeSelfDual` hypothesis — and it is NOT a specialisation
of `etaQuotient_fricke`.  That specialisation is `SDF-04`.  The statement comparator for this node
was pointed at `etaQuotient_fricke` and returned NO_REFERENCE for exactly that reason: there is no
substitution into that theorem, in either direction, that produces this equation.

THE SQUARE ROOT IS THE POINT, AND IS PINNED.  The reading `‖frickeEigenvalue N k‖ = (N : ℝ)^k`,
i.e. the same statement with the root dropped, is FALSE, and
`frickeEigenvalue_norm_pin_not_natPow` refutes it at the genuine `N > 1` self-dual instance
(`46656 ≠ 2176782336`).  That is the negative control this node exists to survive.

THE NORM FORGETS THE SIGN, AND THIS IS PINNED TOO.  `frickeEigenvalue_norm_pin_not_eigenvalue`
records that at `(N, k) = (1, 2)` — where the eigenvalue is `-1`, by `frickeEigenvalue_pin_neg_one`
— the modulus is `1 ≠ -1`.  So this node must NOT be read as computing the eigenvalue: it computes
only its size, and `SDF-08`/`SDF-09` remain necessary for the argument.

SIX INSTANCE PINS, all stated ABOVE the general lemma so Lean scoping forbids them from using it,
each tied to an eta-quotient instance this file already has, and each computing BOTH sides
independently — the left through `SDF-DEF-02`'s already sorry-free `frickeEigenvalue_pin_*` value
lemmas, the right through `SDF-03`'s already sorry-free `sqrt_natPow_*` radicand lemmas:

| `N` | `k` | `‖λ‖` | `√(N^k)` | instance |
|---|---|---|---|---|
| `1` | `12` | `1` | `1` | `rPinOne`, the `eta_S_via_fricke` case |
| `6` | `12` | `46656` | `46656` | `rPinSix`, genuine `N > 1` self-dual — LOAD-BEARING |
| `6` | `0` | `1` | `1` | the degenerate `r ≡ 0` case |
| `2` | `1` | `√2` | `√2` | odd weight, IRRATIONAL modulus |
| `1` | `2` | `1` | `1` | `η⁴`, where the eigenvalue is `-1` — the SIGN pin |
| `6` | `-12` | `1/46656` | `1/46656` | NEGATIVE weight, a proper fraction |

WHICH PINS CARRY WEIGHT.  `..._pin_level_six` is the load-bearing one: it is where a statement that
dropped the square root would break, and both sides are a large integer computed by two routes that
share no lemma.  `..._pin_level_two_weight_one` is the one that leaves the integers entirely — both
sides are `√2`, so the equation is not an artefact of integer bookkeeping.  `..._pin_neg_one` is the
one where the eigenvalue is negative, so it is the evidence that `‖·‖` is not silently tracking the
eigenvalue itself.  `..._pin_level_six_neg` sees the SIGN of `k`.  `..._pin_zero_weight` is
DEGENERATE and is recorded as such, not as evidence: at `k = 0` both sides are `1` by `zpow_zero`.

THE `hN` HYPOTHESIS IS REDUNDANT, AND THIS IS PINNED RATHER THAN GLOSSED.
`frickeEigenvalue_norm_pin_hypothesis_redundant` proves the SAME equation at `N = 0`, at a negative,
a zero and a positive weight.  `hN` is kept anyway and is deliberately UNUSED in the proof below,
solely so this lemma's shape matches `SDF-10`, `SDF-12` and `SDF-13`; a future reader must not infer
from its presence that the statement fails at `N = 0`.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node is the modulus of a complex number.
Persson–Volpato (arXiv:1504.07260) is cited in this file's header as the ORIGIN of the question
only, at the literature (L) tier. -/

section Sdf11Pins

/-- **`SDF-11` PIN A — level `N = 1`, weight `k = 12`.**  `‖1‖ = 1 = √(1^12)`.

The `r = (24)`, level-one instance behind the sorry-free `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`) and `selfDual_eigen_pin_level_one`.  Both sides are reached
without this node: the left through `frickeEigenvalue_pin_level_one` (`SDF-DEF-02`), the right
through `sqrt_natPow_level_one` (`SDF-03`). -/
theorem frickeEigenvalue_norm_pin_level_one :
    ‖frickeEigenvalue 1 12‖ = 1 ∧ Real.sqrt (((1 : ℕ) : ℝ) ^ (12 : ℤ)) = 1 := by
  refine ⟨?_, sqrt_natPow_level_one⟩
  rw [frickeEigenvalue_pin_level_one, norm_one]

/-- **`SDF-11` PIN B — level `N = 6`, weight `k = 12`.  THE LOAD-BEARING PIN.**
`‖46656‖ = 46656 = √(6^12)`.

This is the genuine `N > 1` Fricke-self-dual instance of this file (`rPinSix = (1, 11, 11, 1)`,
`selfDual_cond_pin_level_six`, `selfDual_eigen_pin_level_six`).  The two sides are computed by
routes sharing no lemma — `frickeEigenvalue_pin_level_six` (`SDF-DEF-02`) on the left,
`sqrt_natPow_level_six` (`SDF-03`) on the right — and they agree on `46656`, NOT on
`6^12 = 2176782336`.  A statement of this node with the square root dropped would break exactly
here; `frickeEigenvalue_norm_pin_not_natPow` is that negative control. -/
theorem frickeEigenvalue_norm_pin_level_six :
    ‖frickeEigenvalue 6 12‖ = 46656 ∧ Real.sqrt (((6 : ℕ) : ℝ) ^ (12 : ℤ)) = 46656 := by
  refine ⟨?_, sqrt_natPow_level_six⟩
  rw [frickeEigenvalue_pin_level_six]
  norm_num

/-- **`SDF-11` PIN C — weight `k = 0` at level `N = 6`; DEGENERATE.**  `‖1‖ = 1 = √(6^0)`.

The `r ≡ 0` case (`selfDual_cond_pin_zero_exp`, `selfDual_eigen_pin_zero_exp`).  Recorded as
degenerate, not as evidence: at `k = 0` both sides collapse through `zpow_zero` and neither sees the
base. -/
theorem frickeEigenvalue_norm_pin_zero_weight :
    ‖frickeEigenvalue 6 0‖ = 1 ∧ Real.sqrt (((6 : ℕ) : ℝ) ^ (0 : ℤ)) = 1 := by
  refine ⟨?_, sqrt_natPow_zero_weight⟩
  rw [frickeEigenvalue_pin_zero_weight, norm_one]

/-- **`SDF-11` PIN D — level `N = 2`, weight `k = 1`; ODD WEIGHT, IRRATIONAL MODULUS.**
`‖-(i·√2)‖ = √2 = √(2^1)`.

The pin that leaves the integers: neither side is rational, so the equation is not an artefact of
integer bookkeeping, and the left side is a genuinely non-real eigenvalue whose `i`-factor has to be
discarded by `Complex.norm_I` rather than cancelled numerically.  The eigenvalue value comes from
`frickeEigenvalue_pin_level_two_weight_one` (`SDF-DEF-02`). -/
theorem frickeEigenvalue_norm_pin_level_two_weight_one :
    ‖frickeEigenvalue 2 1‖ = Real.sqrt 2 ∧
      Real.sqrt (((2 : ℕ) : ℝ) ^ (1 : ℤ)) = Real.sqrt 2 := by
  constructor
  · rw [frickeEigenvalue_pin_level_two_weight_one, norm_neg, norm_mul, Complex.norm_I,
      Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), one_mul]
  · norm_num

/-- **`SDF-11` PIN E — level `N = 1`, weight `k = 2`; THE SIGN PIN.**  `‖-1‖ = 1 = √(1^2)`.

The `η⁴` instance (`selfDual_pin_eigenvalue_neg_one`), the only place in this file where the
eigenvalue is `-1` — `frickeEigenvalue_pin_neg_one` (`SDF-DEF-02`) computes it.  Its modulus is `1`,
so this pin is the machine-checked evidence that `‖·‖` DISCARDS the sign and this node therefore
cannot be mistaken for a computation of the eigenvalue itself.  The companion negative control is
`frickeEigenvalue_norm_pin_not_eigenvalue`. -/
theorem frickeEigenvalue_norm_pin_neg_one :
    ‖frickeEigenvalue 1 2‖ = 1 ∧ Real.sqrt (((1 : ℕ) : ℝ) ^ (2 : ℤ)) = 1 := by
  refine ⟨?_, ?_⟩
  · rw [frickeEigenvalue_pin_neg_one, norm_neg, norm_one]
  · rw [Nat.cast_one, _root_.one_zpow, Real.sqrt_one]

/-- **`SDF-11` PIN F — level `N = 6`, weight `k = -12`; NEGATIVE WEIGHT.**
`‖(46656)⁻¹‖ = (46656)⁻¹ = √(6^{-12})`.

Here the modulus is the proper fraction `1/46656`, not an integer, so a proof or a statement that
silently read `zpow` as `Monoid.npow` would break at a weight this file has a real self-dual
eta-quotient instance for (`rPinLevelSixNeg`, `selfDual_eigen_pin_level_six_neg`).  The two sides
again come from routes sharing no lemma: `frickeEigenvalue_pin_level_six_neg` (`SDF-DEF-02`) and
`sqrt_natPow_level_six_neg` (`SDF-03`). -/
theorem frickeEigenvalue_norm_pin_level_six_neg :
    ‖frickeEigenvalue 6 (-12)‖ = (46656 : ℝ)⁻¹ ∧
      Real.sqrt (((6 : ℕ) : ℝ) ^ (-12 : ℤ)) = (46656 : ℝ)⁻¹ := by
  refine ⟨?_, sqrt_natPow_level_six_neg⟩
  rw [frickeEigenvalue_pin_level_six_neg, norm_inv]
  norm_num

/-- **NEGATIVE CONTROL — the square root is NOT droppable.**  At the genuine `N > 1` self-dual
instance `(6, 12)`, `‖frickeEigenvalue 6 12‖ = 46656` while `(6 : ℝ)^12 = 2176782336`.  So the
strengthened reading `‖frickeEigenvalue N k‖ = (N : ℝ)^k` is FALSE, and this node's `√` is doing
real work rather than decorating a true statement.  The `2176782336` here is `SDF-10`'s already
sorry-free `natCast_zpow_pin_level_six_value`, so the two nodes agree on the number or the build
fails. -/
theorem frickeEigenvalue_norm_pin_not_natPow :
    ‖frickeEigenvalue 6 12‖ ≠ (((6 : ℕ) : ℝ) ^ (12 : ℤ)) := by
  rw [frickeEigenvalue_norm_pin_level_six.1, natCast_zpow_pin_level_six_value]
  norm_num

/-- **NEGATIVE CONTROL — the modulus is NOT the eigenvalue.**  At `(1, 2)` the eigenvalue is `-1`
(`frickeEigenvalue_pin_neg_one`) and its modulus is `1`, so `(‖λ‖ : ℂ) ≠ λ` there.  This is what
stops a reader from taking `SDF-11` as a closed form for `frickeEigenvalue` itself: it is a closed
form for its SIZE only, and `SDF-08`/`SDF-09` are still what settle the argument. -/
theorem frickeEigenvalue_norm_pin_not_eigenvalue :
    ((‖frickeEigenvalue 1 2‖ : ℝ) : ℂ) ≠ frickeEigenvalue 1 2 := by
  rw [frickeEigenvalue_norm_pin_neg_one.1, frickeEigenvalue_pin_neg_one]
  norm_num

/-- **NEGATIVE CONTROL — the modulus is NOT constant in `N`.**  `‖frickeEigenvalue 6 12‖ = 46656`
while `‖frickeEigenvalue 1 12‖ = 1`, at the SAME weight.  So the right-hand side genuinely depends
on the level and cannot be replaced by `1`; equivalently, the unnormalised eigenvalue is NOT a root
of unity in general.  That is exactly the gap `SDF-06`'s normalised form
(`etaQuotient_fricke_selfDual_normalized`) closes by dividing it out. -/
theorem frickeEigenvalue_norm_pin_nonconstant :
    ‖frickeEigenvalue 6 12‖ ≠ ‖frickeEigenvalue 1 12‖ := by
  rw [frickeEigenvalue_norm_pin_level_six.1, frickeEigenvalue_norm_pin_level_one.1]
  norm_num

/-- **THE `hN` HYPOTHESIS IS REDUNDANT.**  The same equation holds at `N = 0`, at a negative, a zero
and a positive weight — Mathlib's `zpow` makes `(0 : ℝ)^k` equal `0` for `k ≠ 0` and `1` for
`k = 0`, and `√0 = 0`, so both sides agree there as well.

`hN` is kept in `frickeEigenvalue_norm` anyway, and is deliberately UNUSED in its proof, only so
that lemma's shape matches `SDF-10`, `SDF-12` and `SDF-13`.  This pin exists so that the presence of
`hN` cannot be misread as evidence that the statement fails without it. -/
theorem frickeEigenvalue_norm_pin_hypothesis_redundant :
    (‖frickeEigenvalue 0 (-3)‖ = Real.sqrt (((0 : ℕ) : ℝ) ^ (-3 : ℤ)))
      ∧ (‖frickeEigenvalue 0 (0 : ℤ)‖ = Real.sqrt (((0 : ℕ) : ℝ) ^ (0 : ℤ)))
      ∧ (‖frickeEigenvalue 0 (5 : ℤ)‖ = Real.sqrt (((0 : ℕ) : ℝ) ^ (5 : ℤ))) := by
  refine ⟨?_, ?_, ?_⟩ <;>
    · rw [frickeEigenvalue, norm_mul, Complex.norm_zpow, Complex.norm_I, Complex.norm_real,
        Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), _root_.one_zpow, one_mul]

end Sdf11Pins

-- The `hN` binder of `frickeEigenvalue_norm` is intentionally unused — see
-- `frickeEigenvalue_norm_pin_hypothesis_redundant`, which proves the statement at `N = 0` — so the
-- `unusedVariables` linter is silenced for that ONE declaration, for that documented reason.
set_option linter.unusedVariables false in
/-- **`SDF-11`.**  The modulus of the unnormalised Fricke eigenvalue is the real square root of
`(N : ℝ)^k`:

`‖frickeEigenvalue N k‖ = √((N : ℝ)^k)`.

PROOF.  Unfold `SDF-DEF-02` and push the norm through the product: `norm_mul` splits it,
`Complex.norm_zpow` turns `‖i^{-k}‖` into `‖i‖^{-k}`, `Complex.norm_I` makes that `1^{-k}`, and
`one_zpow` makes it `1`.  The remaining factor is a REAL cast, so `Complex.norm_real` and
`Real.norm_eq_abs` reduce it to `|√(N^k)|`, and `Real.sqrt_nonneg` removes the absolute value.  One
`rw` chain; nothing is forced, and nothing about `N` or `k` is ever case-split.

`hN` IS UNUSED, DELIBERATELY — see `frickeEigenvalue_norm_pin_hypothesis_redundant`, which proves
the same equation at `N = 0`.  It is kept solely so this lemma's shape matches `SDF-10`, `SDF-12`
and `SDF-13`. -/
theorem frickeEigenvalue_norm {N : ℕ} (hN : 0 < N) (k : ℤ) :
    ‖frickeEigenvalue N k‖ = Real.sqrt ((N : ℝ) ^ k) := by
  rw [frickeEigenvalue, norm_mul, Complex.norm_zpow, Complex.norm_I, Complex.norm_real,
    Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), _root_.one_zpow, one_mul]

/-- **`SDF-11` APPLICATION CHECK — the general lemma reproduces the pins.**  Each conjunct is one
pinned `(N, k)`, but REACHED BY RUNNING `frickeEigenvalue_norm` there rather than by the pin's own
route through `frickeEigenvalue_pin_*` and `sqrt_natPow_*`.  Every pinned instance is therefore
settled twice by routes sharing no lemma, and they agree.  `(6, 12)` and `(2, 1)` are the
informative conjuncts — the large integer and the irrational one — and `(6, -12)` is where a proof
that assumed `0 ≤ k` would break. -/
theorem frickeEigenvalue_norm_pin_application :
    ‖frickeEigenvalue 1 12‖ = Real.sqrt (((1 : ℕ) : ℝ) ^ (12 : ℤ)) ∧
      ‖frickeEigenvalue 6 12‖ = Real.sqrt (((6 : ℕ) : ℝ) ^ (12 : ℤ)) ∧
      ‖frickeEigenvalue 6 0‖ = Real.sqrt (((6 : ℕ) : ℝ) ^ (0 : ℤ)) ∧
      ‖frickeEigenvalue 2 1‖ = Real.sqrt (((2 : ℕ) : ℝ) ^ (1 : ℤ)) ∧
      ‖frickeEigenvalue 1 2‖ = Real.sqrt (((1 : ℕ) : ℝ) ^ (2 : ℤ)) ∧
      ‖frickeEigenvalue 6 (-12)‖ = Real.sqrt (((6 : ℕ) : ℝ) ^ (-12 : ℤ)) :=
  ⟨frickeEigenvalue_norm (by decide) 12, frickeEigenvalue_norm (by decide) 12,
    frickeEigenvalue_norm (by decide) 0, frickeEigenvalue_norm (by decide) 1,
    frickeEigenvalue_norm (by decide) 2, frickeEigenvalue_norm (by decide) (-12)⟩

/-! #### `SDF-12` pins — the BICONDITIONAL at concrete `(N, k)`, computed independently and stated
BEFORE the general lemma

`SDF-12` is the first node in this file that asserts an EQUALITY OF THE EIGENVALUE ITSELF to a
constant, rather than of its modulus (`SDF-11`) or of one of its two factors (`SDF-08`, `SDF-10`).
It says the unnormalised eigenvalue `λ = i^{-k} · √(N^k)` is `1` exactly when BOTH factors are `1`:

`frickeEigenvalue N k = 1 ↔ (4 ∣ k ∧ (N = 1 ∨ k = 0))`.

WHAT THIS NODE IS, AND WHAT IT IS NOT.  Like `SDF-07` … `SDF-11` it is a fact about a SCALAR alone —
no exponent vector `r`, no point `z`, no eta quotient, no `IsFrickeSelfDual` hypothesis — and it is
NOT a specialisation of `etaQuotient_fricke`.  That specialisation is `SDF-04`/`SDF-05`; substituting
a self-dual `r` into `etaQuotient_fricke` produces the functional equation
`f(-1/(Nz)) = λ · z^k · f(z)`, never a divisibility condition and never a biconditional.  The
statement comparator for this node was pointed at `etaQuotient_fricke` and correctly returned
NO_REFERENCE for exactly that reason — the same situation already recorded for `SDF-10` and `SDF-11`
above.  The real references are `SDF-11` (`frickeEigenvalue_norm`), Mathlib's `Real.sqrt_eq_one`,
`SDF-10` (`natCast_zpow_eq_one_iff`) and `SDF-08` (`I_zpow_neg_eq_one_iff`).

BEFORE any of this was stated in Lean, `λ = 1 ↔ (4 ∣ k ∧ (N = 1 ∨ k = 0))` was checked OUTSIDE Lean
in exact rational arithmetic (`fractions.Fraction`, no floating point) at all `12221` instances
`N ∈ [0, 100]`, `k ∈ [-60, 60]`, evaluating `λ` symbolically as (fourth root of unity) × (nonnegative
real `√(N^k)`) and using the fact that such a product is `1` iff the unit is `1` and the modulus is
`1`.  The `N = 0` row was evaluated under Lean's convention `(0 : ℝ)^k = 0` for `k ≠ 0` and
`√0 = 0`, so `λ = 0 ≠ 1` there whenever `k ≠ 0`.  Zero mismatches.  (The `SDF-13` sibling
`λ = -1 ↔ (k % 4 = 2 ∧ N = 1)` was checked on the same grid in the same script: zero mismatches.  That
node has SINCE been proved — `frickeEigenvalue_eq_neg_one_iff` below, on a re-run of the check over
the wider grid `N ∈ [0, 100]`, `k ∈ [-200, 200]`, also with zero mismatches; this line said "that node
remains `sorry` here" until then.  The check is recorded as evidence about the STATEMENT, not as a
proof.)

THE PINNED INSTANCES, and why each one:

* `N = 1`, `k = 12`  — THE `eta_S_via_fricke` INSTANCE (`r = (24)` at level one,
  `EtaQuotientModularity.lean:2246`; here `selfDual_eigen_pin_level_one`).  BOTH sides TRUE, with the
  level clause firing at a weight that is NOT `0`.  Its eigenvalue is `1`
  (`frickeEigenvalue_pin_level_one`), which is exactly the constant-free shape
  `η(-1/z)²⁴ = z¹² η(z)²⁴` that Mathlib and this library already prove — so this pin is where the
  biconditional has to agree with a fact settled by a completely different route.
* `N = 6`, `k = 12`  — THE LOAD-BEARING PIN, the genuine `N > 1` self-dual instance
  (`rPinSix = (1, 11, 11, 1)`, `selfDual_cond_pin_level_six`).  BOTH sides FALSE: `4 ∣ 12` HOLDS, so
  the root of unity is `1`, yet `λ = 46656` because the modulus `√(6¹²) = 6⁶` is not `1`.  This is
  the instance that forces the second conjunct to exist at all, and the only pin at which the two
  conjuncts disagree with each other.
* `N = 6`, `k = 0`   — THE DEGENERATE CASE `r ≡ 0` (`selfDual_cond_pin_zero_exp`).  BOTH sides TRUE
  through the `k = 0` disjunct, at a level that is NOT `1`.  DEGENERATE BY CONSTRUCTION: `k = 0`
  makes both factors `1` at once, so it certifies only that the statement is not mis-indexed at
  weight zero.  It is a floor, not evidence about the exponents.
* `N = 2`, `k = 1`   — ODD WEIGHT (`rPinTwo = (1, 1)`, i.e. `f = η(z)·η(2z)`).  BOTH sides FALSE, and
  here `λ = -(i√2)` is not even real; it is refuted through its MODULUS `√2`, which is where
  `Real.sqrt_eq_one` first earns its place, and `√2` is left symbolic rather than pinned to a
  decimal.
* `N = 1`, `k = 2`   — THE SIGN CONTROL.  BOTH sides FALSE, with the level clause TRUE and the
  divisibility clause FALSE: `λ = -1`, whose modulus IS `1`.  This is the instance that forces the
  first conjunct to exist at all, and the one a proof that had reasoned only about moduli would get
  wrong.
* `N = 6`, `k = -12` — NEGATIVE WEIGHT (`rPinLevelSixNeg = (-1, -11, -11, -1)`).  BOTH sides FALSE,
  with `λ = 1/46656` a proper fraction.  A statement or proof that silently assumed `0 ≤ k` breaks
  here.

TWO NEGATIVE CONTROLS, one per conjunct, showing NEITHER is droppable.
`frickeEigenvalue_eq_one_iff_pin_not_level_only` exhibits `N = 1`, `k = 2` with the level clause true
and `λ = -1 ≠ 1`, refuting the weakened form `λ = 1 ↔ (N = 1 ∨ k = 0)`.
`frickeEigenvalue_eq_one_iff_pin_not_dvd_only` exhibits `N = 6`, `k = 12` with `4 ∣ 12` and
`λ = 46656 ≠ 1`, refuting the weakened form `λ = 1 ↔ 4 ∣ k`.  So the conjunction is exactly right,
not merely sufficient.

THE `hN` HYPOTHESIS IS REDUNDANT, AND THIS IS PINNED RATHER THAN GLOSSED.
`frickeEigenvalue_eq_one_iff_pin_hypothesis_redundant` proves the SAME biconditional at `N = 0` at
three weights, including `k = -4`, where `4 ∣ k` HOLDS and the biconditional survives only because
`λ = 0`.  `hN` is nevertheless PASSED to `SDF-10` and `SDF-11` in the proof below (both of which
ignore it in turn), so it is syntactically used here; it is kept for shape-uniformity with `SDF-10`,
`SDF-11` and `SDF-13`, and a future reader must not infer from its presence that the statement fails
at `N = 0`.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node states when a complex number
attached to a level and a weight equals `1`.  Persson–Volpato (arXiv:1504.07260) is cited in this
file's docstring as the ORIGIN of the question only, at the literature (L) tier; their CHL /
axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must never be
reported as one. -/

section Sdf12Pins

/-- **`SDF-12` PIN A — `N = 1`, `k = 12`; BOTH SIDES TRUE.**  `λ = 1` by
`frickeEigenvalue_pin_level_one`, and on the right `4 ∣ 12` with the `N = 1` disjunct.

This is the level-one instance behind the sorry-free `eta_S_via_fricke`, where the Fricke
transformation carries no constant at all — so the biconditional must return TRUE here, and does.
The weight is not `0`, so the `k = 0` disjunct is not what makes it true. -/
theorem frickeEigenvalue_eq_one_iff_pin_level_one :
    frickeEigenvalue 1 12 = 1 ↔ ((4 : ℤ) ∣ (12 : ℤ) ∧ ((1 : ℕ) = 1 ∨ (12 : ℤ) = 0)) :=
  iff_of_true frickeEigenvalue_pin_level_one ⟨⟨3, by norm_num⟩, Or.inl rfl⟩

/-- **`SDF-12` PIN B — `N = 6`, `k = 12`.  THE LOAD-BEARING PIN.**  BOTH SIDES FALSE, and they fail
for DIFFERENT reasons in the two conjuncts: `4 ∣ 12` HOLDS (the root of unity is `1`), yet
`λ = 46656` because `√(6¹²) = 6⁶ ≠ 1`.

This is the genuine `N > 1` self-dual instance of this file, `rPinSix = (1, 11, 11, 1)` at level `6`
and weight `12` (`selfDual_cond_pin_level_six`, `rPinSix_nonconstant`).  It is the only pin at which
the two conjuncts of the right-hand side disagree, so it is what makes the second conjunct
non-redundant — and it is the instance that makes the whole `±1` classification sharp rather than
vacuous. -/
theorem frickeEigenvalue_eq_one_iff_pin_level_six :
    frickeEigenvalue 6 12 = 1 ↔ ((4 : ℤ) ∣ (12 : ℤ) ∧ ((6 : ℕ) = 1 ∨ (12 : ℤ) = 0)) :=
  iff_of_false
    (by rw [frickeEigenvalue_pin_level_six]; norm_num)
    (by rintro ⟨-, h | h⟩ <;> omega)

/-- **`SDF-12` PIN C — the degenerate weight `k = 0`, at `N = 6`; BOTH SIDES TRUE.**  `λ = 1`
(`frickeEigenvalue_pin_zero_weight`), and on the right `4 ∣ 0` with the `k = 0` disjunct, at a level
that is NOT `1`.

DEGENERATE BY CONSTRUCTION: at `k = 0` both factors of `λ` collapse to `1` simultaneously, so a
statement that had accidentally proved only the `k = 0` case would still pass here.  Recorded as a
floor certifying the biconditional is not mis-indexed at weight zero — not as evidence about the
exponents.  This is the eigenvalue of the degenerate self-dual vector `r ≡ 0`
(`selfDual_cond_pin_zero_exp`, `zeroExp_weight_level_six`). -/
theorem frickeEigenvalue_eq_one_iff_pin_zero_weight :
    frickeEigenvalue 6 0 = 1 ↔ ((4 : ℤ) ∣ (0 : ℤ) ∧ ((6 : ℕ) = 1 ∨ (0 : ℤ) = 0)) :=
  iff_of_true frickeEigenvalue_pin_zero_weight ⟨dvd_zero 4, Or.inr rfl⟩

/-- **`SDF-12` PIN D — ODD WEIGHT: `N = 2`, `k = 1`; BOTH SIDES FALSE.**  `λ = -(i√2)`
(`frickeEigenvalue_pin_level_two_weight_one`), and `4 ∤ 1`.

This is the level and weight of `rPinTwo = (1, 1)`, i.e. `f = η(z)·η(2z)`, whose Fricke behaviour is
pinned sorry-free upstream by `fricke_level_two_pin` (`EtaQuotientModularity.lean:2285`).  It is the
only pin whose eigenvalue leaves `ℝ`.

The refutation goes through the MODULUS, computed here from the value pin by hand rather than by
citing `SDF-11`: `‖-(i√2)‖ = ‖i‖ · |√2| = √2`, so `λ = 1` would force `√2 = 1` and hence, by
`Real.sqrt_eq_one`, `(2 : ℝ) = 1`.  `√2` is never pinned to a decimal — it is irrational and a
decimal would be false precision. -/
theorem frickeEigenvalue_eq_one_iff_pin_level_two_weight_one :
    frickeEigenvalue 2 1 = 1 ↔ ((4 : ℤ) ∣ (1 : ℤ) ∧ ((2 : ℕ) = 1 ∨ (1 : ℤ) = 0)) := by
  refine iff_of_false ?_ (by rintro ⟨h, -⟩; omega)
  intro h
  rw [frickeEigenvalue_pin_level_two_weight_one] at h
  have h1 : ‖-(I * ((Real.sqrt 2 : ℝ) : ℂ))‖ = 1 := by rw [h, norm_one]
  rw [norm_neg, norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Real.sqrt_nonneg _)] at h1
  have h2 : (2 : ℝ) = 1 := Real.sqrt_eq_one.mp h1
  norm_num at h2

/-- **`SDF-12` PIN E — THE SIGN CONTROL: `N = 1`, `k = 2`; BOTH SIDES FALSE.**  Here the LEVEL clause
is TRUE (`N = 1`) and the modulus `√(1²) = 1` is `1`, yet `λ = -1 ≠ 1`
(`frickeEigenvalue_pin_not_one`) because `4 ∤ 2`.

This is the pin that forces the FIRST conjunct to exist.  Every other pin in this section is refuted
(or confirmed) by its modulus; this one has modulus `1` and is refuted only by the root of unity, so
a proof that had reasoned about `‖λ‖` alone — which is all `SDF-11` gives — would get it wrong.  It
is also the instance `SDF-13`'s LOAD-BEARING pin is about.  It was the only machine-checked witness
in this file that `frickeEigenvalue` ever takes the value `-1` until `SDF-13` closed and added a
second at `(1, -2)`. -/
theorem frickeEigenvalue_eq_one_iff_pin_neg_one :
    frickeEigenvalue 1 2 = 1 ↔ ((4 : ℤ) ∣ (2 : ℤ) ∧ ((1 : ℕ) = 1 ∨ (2 : ℤ) = 0)) :=
  iff_of_false frickeEigenvalue_pin_not_one (by rintro ⟨h, -⟩; omega)

/-- **`SDF-12` PIN F — NEGATIVE WEIGHT: `N = 6`, `k = -12`; BOTH SIDES FALSE.**  `λ = 1/46656`
(`frickeEigenvalue_pin_level_six_neg`) — a proper fraction, not an integer — while `4 ∣ -12` holds
and the second conjunct fails.

This is the weight of `rPinLevelSixNeg = (-1, -11, -11, -1)` (`rPinLevelSixNeg_selfDual`).  A
statement or proof that had silently assumed `0 ≤ k` — a `k.toNat`, or `pow_pos` in place of
`zpow_pos` — is FALSE here, at a weight this file has a real self-dual eta-quotient instance for. -/
theorem frickeEigenvalue_eq_one_iff_pin_level_six_neg :
    frickeEigenvalue 6 (-12) = 1 ↔ ((4 : ℤ) ∣ (-12 : ℤ) ∧ ((6 : ℕ) = 1 ∨ (-12 : ℤ) = 0)) :=
  iff_of_false
    (by rw [frickeEigenvalue_pin_level_six_neg]; norm_num)
    (by rintro ⟨-, h | h⟩ <;> omega)

/-- **`SDF-12` NEGATIVE CONTROL 1 — the DIVISIBILITY conjunct is NOT droppable.**  At `N = 1`,
`k = 2` the level clause `N = 1 ∨ k = 0` HOLDS while `λ = -1 ≠ 1`.  So the weakened form
`λ = 1 ↔ (N = 1 ∨ k = 0)` — i.e. `SDF-12` with the `4 ∣ k` conjunct deleted — is FALSE.

Equivalently: `SDF-10` alone does not settle `SDF-12`. -/
theorem frickeEigenvalue_eq_one_iff_pin_not_level_only :
    frickeEigenvalue 1 2 ≠ 1 ∧ ((1 : ℕ) = 1 ∨ (2 : ℤ) = 0) :=
  ⟨frickeEigenvalue_pin_not_one, Or.inl rfl⟩

/-- **`SDF-12` NEGATIVE CONTROL 2 — the LEVEL/WEIGHT conjunct is NOT droppable.**  At `N = 6`,
`k = 12` the divisibility clause `4 ∣ 12` HOLDS while `λ = 46656 ≠ 1`.  So the weakened form
`λ = 1 ↔ 4 ∣ k` — i.e. `SDF-12` with the second conjunct deleted, which is what one would get by
reading `SDF-08` as if it settled the eigenvalue — is FALSE.

Taken with NEGATIVE CONTROL 1, this shows the conjunction is exactly right, not merely sufficient:
each control has one conjunct true and the eigenvalue nevertheless not `1`. -/
theorem frickeEigenvalue_eq_one_iff_pin_not_dvd_only :
    frickeEigenvalue 6 12 ≠ 1 ∧ (4 : ℤ) ∣ (12 : ℤ) :=
  ⟨by rw [frickeEigenvalue_pin_level_six]; norm_num, ⟨3, by norm_num⟩⟩

/-- **`SDF-12` HYPOTHESIS-REDUNDANCY PIN.**  The biconditional also holds at `N = 0`, at a zero, a
negative and a positive weight.  Under Lean's conventions `(0 : ℝ)^k = 0` for `k ≠ 0` and `√0 = 0`,
so `λ = 0` there, which is not `1`; and the right-hand side is false because `0 = 1` is false and
`k ≠ 0`.  At `k = 0` both sides are true.

The `k = -4` conjunct is the informative one: there `4 ∣ k` HOLDS, so the biconditional survives at
`N = 0` only because the SECOND conjunct fails — the same reason it fails at `N = 6`, `k = 12`.

So `hN : 0 < N` is REDUNDANT in `frickeEigenvalue_eq_one_iff`.  It is kept there (and IS used, being
passed to `SDF-10` and `SDF-11`, which ignore it in turn) only so that lemma's shape matches
`SDF-10`, `SDF-11` and `SDF-13`.  Recorded as a machine-checked pin rather than as a remark so no
future reader infers that the statement fails at `N = 0`. -/
theorem frickeEigenvalue_eq_one_iff_pin_hypothesis_redundant :
    (frickeEigenvalue 0 (0 : ℤ) = 1 ↔ ((4 : ℤ) ∣ (0 : ℤ) ∧ ((0 : ℕ) = 1 ∨ (0 : ℤ) = 0))) ∧
      (frickeEigenvalue 0 (-4 : ℤ) = 1 ↔ ((4 : ℤ) ∣ (-4 : ℤ) ∧ ((0 : ℕ) = 1 ∨ (-4 : ℤ) = 0))) ∧
      (frickeEigenvalue 0 (5 : ℤ) = 1 ↔ ((4 : ℤ) ∣ (5 : ℤ) ∧ ((0 : ℕ) = 1 ∨ (5 : ℤ) = 0))) := by
  have hzero : ∀ k : ℤ, k ≠ 0 → frickeEigenvalue 0 k = 0 := by
    intro k hk
    rw [frickeEigenvalue, Nat.cast_zero, _root_.zero_zpow k hk, Real.sqrt_zero, Complex.ofReal_zero,
      mul_zero]
  refine ⟨?_, ?_, ?_⟩
  · refine iff_of_true ?_ ⟨dvd_zero 4, Or.inr rfl⟩
    rw [frickeEigenvalue, neg_zero, zpow_zero, zpow_zero, Real.sqrt_one, Complex.ofReal_one,
      mul_one]
  · refine iff_of_false ?_ (by rintro ⟨-, h | h⟩ <;> omega)
    rw [hzero (-4) (by norm_num)]
    norm_num
  · refine iff_of_false ?_ (by rintro ⟨h, -⟩; omega)
    rw [hzero 5 (by norm_num)]
    norm_num

end Sdf12Pins

/-- **`SDF-12`** — *statement CONFIRMED by the orchestrating session; see the receipt below.*  The
unnormalised Fricke eigenvalue is `1` exactly when the root of unity `i^{-k}` is `1` **and** the
modulus `N^{k/2}` is `1`:

`frickeEigenvalue N k = 1 ↔ (4 ∣ k ∧ (N = 1 ∨ k = 0))`.

PROOF, in four named steps, no case split on `N` or `k` anywhere.

*Forward.*  From `λ = 1`, take moduli: `‖λ‖ = ‖1‖ = 1`, and `SDF-11` (`frickeEigenvalue_norm`) says
`‖λ‖ = √((N : ℝ)^k)`, so `√((N : ℝ)^k) = 1`.  Mathlib's `Real.sqrt_eq_one` is UNCONDITIONAL
(`Analysis/Real/Sqrt.lean:172`, `√x = 1 ↔ x = 1` with no sign hypothesis on `x`), so `(N : ℝ)^k = 1`,
and `SDF-10` (`natCast_zpow_eq_one_iff`) turns that into `N = 1 ∨ k = 0`.  Substituting
`√((N : ℝ)^k) = 1` back into the definition of `SDF-DEF-02` leaves `i^{-k} = 1`, and `SDF-08`
(`I_zpow_neg_eq_one_iff`) turns that into `4 ∣ k`.

*Backward.*  `SDF-10` and `SDF-08` in the `mpr` direction give `(N : ℝ)^k = 1` and `i^{-k} = 1`;
substituting both into `SDF-DEF-02` leaves `1 · √1 = 1`.

Note which lemma does the work at the square root: `Real.sqrt_eq_one`, not `Real.sq_sqrt`.  The
latter would need `0 ≤ (N : ℝ)^k` as a side goal and a `zpow_pos` detour; the former needs nothing,
so no positivity hypothesis about `N` is required anywhere in this proof.

`hN` IS PASSED THROUGH BUT MATHEMATICALLY REDUNDANT.  It is consumed only by `SDF-10` and `SDF-11`,
both of which ignore it in turn, and
`frickeEigenvalue_eq_one_iff_pin_hypothesis_redundant` proves this very biconditional at `N = 0` at
three weights.  It is kept so this lemma's shape matches `SDF-10`, `SDF-11` and `SDF-13`.

RECEIPT — THE RECONSTRUCTION CAVEAT IS NOW DISCHARGED.  This declaration's statement was originally
RECONSTRUCTED by a run whose task specification had been truncated mid-node at the string `theorem
frickeEigenvalue_`, and its docstring asked the orchestrating session to confirm or replace it (see
the `RENUMBERING RECEIPT` paragraph in this file's header).  The orchestrating session has now
supplied `SDF-12` in full, and the supplied statement agrees with this declaration CHARACTER FOR
CHARACTER, hypothesis `hN` included.  The reconstruction is therefore confirmed, not merely
plausible, and this node may be reported as a specified node.  The sibling `SDF-13`
(`frickeEigenvalue_eq_neg_one_iff`) has SINCE been confirmed the same way and is now proved, pinned
and guarded; this sentence said it "has NOT been confirmed and remains a reconstruction and remains
open" until that run.

PHYSICS SCOPE.  Nothing here formalises any physics.  Persson–Volpato (arXiv:1504.07260) is cited in
this file's docstring as the ORIGIN of the question only, at the literature (L) tier; their CHL /
axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library. -/
theorem frickeEigenvalue_eq_one_iff {N : ℕ} (hN : 0 < N) (k : ℤ) :
    frickeEigenvalue N k = 1 ↔ ((4 : ℤ) ∣ k ∧ (N = 1 ∨ k = 0)) := by
  constructor
  · intro h
    have hsqrt : Real.sqrt ((N : ℝ) ^ k) = 1 := by
      rw [← frickeEigenvalue_norm hN k, h, norm_one]
    have hpow : ((N : ℝ) ^ k) = 1 := Real.sqrt_eq_one.mp hsqrt
    refine ⟨?_, (natCast_zpow_eq_one_iff hN k).mp hpow⟩
    refine (I_zpow_neg_eq_one_iff k).mp ?_
    rw [frickeEigenvalue, hsqrt, Complex.ofReal_one, mul_one] at h
    exact h
  · rintro ⟨hdvd, hlevel⟩
    rw [frickeEigenvalue, (I_zpow_neg_eq_one_iff k).mpr hdvd,
      (natCast_zpow_eq_one_iff hN k).mpr hlevel, Real.sqrt_one, Complex.ofReal_one, mul_one]

/-- **`SDF-12` APPLICATION CHECK — the general lemma reproduces the pins.**  Each conjunct is one
pinned `(N, k)`, but REACHED BY RUNNING `frickeEigenvalue_eq_one_iff` there rather than by the pin's
own route through `frickeEigenvalue_pin_*`.  Every pinned instance is therefore settled twice by
routes that share no lemma below `SDF-DEF-02`, and they agree.

`(6, 12)` is the informative conjunct — the load-bearing instance where `4 ∣ k` holds and the
eigenvalue is still not `1` — and `(1, 2)` is the sign control, where the modulus is `1` and only the
root of unity refutes it.  `(6, -12)` is where a proof that assumed `0 ≤ k` would break. -/
theorem frickeEigenvalue_eq_one_iff_pin_application :
    (frickeEigenvalue 1 12 = 1 ↔ ((4 : ℤ) ∣ (12 : ℤ) ∧ ((1 : ℕ) = 1 ∨ (12 : ℤ) = 0))) ∧
      (frickeEigenvalue 6 12 = 1 ↔ ((4 : ℤ) ∣ (12 : ℤ) ∧ ((6 : ℕ) = 1 ∨ (12 : ℤ) = 0))) ∧
      (frickeEigenvalue 6 0 = 1 ↔ ((4 : ℤ) ∣ (0 : ℤ) ∧ ((6 : ℕ) = 1 ∨ (0 : ℤ) = 0))) ∧
      (frickeEigenvalue 2 1 = 1 ↔ ((4 : ℤ) ∣ (1 : ℤ) ∧ ((2 : ℕ) = 1 ∨ (1 : ℤ) = 0))) ∧
      (frickeEigenvalue 1 2 = 1 ↔ ((4 : ℤ) ∣ (2 : ℤ) ∧ ((1 : ℕ) = 1 ∨ (2 : ℤ) = 0))) ∧
      (frickeEigenvalue 6 (-12) = 1 ↔
        ((4 : ℤ) ∣ (-12 : ℤ) ∧ ((6 : ℕ) = 1 ∨ (-12 : ℤ) = 0))) :=
  ⟨frickeEigenvalue_eq_one_iff (by decide) 12, frickeEigenvalue_eq_one_iff (by decide) 12,
    frickeEigenvalue_eq_one_iff (by decide) 0, frickeEigenvalue_eq_one_iff (by decide) 1,
    frickeEigenvalue_eq_one_iff (by decide) 2, frickeEigenvalue_eq_one_iff (by decide) (-12)⟩

/-! #### `SDF-13` pins — the SIGN biconditional at concrete `(N, k)`, computed independently and
stated BEFORE the general lemma

`SDF-13` is the sibling of `SDF-12` at the OTHER value: the unnormalised eigenvalue
`λ = i^{-k} · √(N^k)` is `-1` exactly when the root of unity is `-1` and the modulus is `1`.

`frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1)`.

WHY THE RIGHT-HAND SIDE IS NOT THE MIRROR IMAGE OF `SDF-12`'s.  `SDF-12` reads
`(4 ∣ k ∧ (N = 1 ∨ k = 0))`; this node reads `(k % 4 = 2 ∧ N = 1)`, with the `k = 0` disjunct GONE.
The reason is that the argument condition here already forbids `k = 0` (`0 % 4 = 0 ≠ 2`), so
`SDF-10`'s `k = 0` disjunct cannot fire and the level condition SHARPENS to `N = 1`.  This is not
an asymmetry in the mathematics but a consequence of it, and it is machine-checked rather than
asserted: `frickeEigenvalue_eq_neg_one_iff_pin_asymmetry` proves that the `SDF-12`-shaped
right-hand side `(k % 4 = 2 ∧ (N = 1 ∨ k = 0))` is EQUIVALENT to the one used here, for every `N`
and `k`, and exhibits an `(N, k)` at which `SDF-12`'s actual right-hand side is TRUE while this
node's is FALSE — so the two nodes are genuinely different statements.

WHAT THIS NODE IS, AND WHAT IT IS NOT.  Like `SDF-07` … `SDF-12` it is a fact about a SCALAR alone —
no exponent vector `r`, no point `z`, no eta quotient, no `IsFrickeSelfDual` hypothesis — and it is
NOT a specialisation of `etaQuotient_fricke`.  That specialisation is `SDF-04`/`SDF-05`; substituting
a self-dual `r` into `etaQuotient_fricke` produces the functional equation
`f(-1/(Nz)) = λ · z^k · f(z)`, never a residue condition and never a biconditional.  The statement
comparator for this node was pointed at `etaQuotient_fricke` and correctly returned NO_REFERENCE for
exactly that reason — the same situation already recorded for `SDF-10`, `SDF-11` and `SDF-12` above.
The real references are `SDF-11` (`frickeEigenvalue_norm`), Mathlib's `Real.sqrt_eq_one`, `SDF-10`
(`natCast_zpow_eq_one_iff`) and `SDF-09` (`I_zpow_neg_eq_neg_one_iff`).

BEFORE any of this was stated in Lean, `λ = -1 ↔ (k % 4 = 2 ∧ N = 1)` was checked OUTSIDE Lean in
exact arithmetic (`fractions.Fraction` for `N^k`, Gaussian units for `i^{-k}`; no floating point) at
all `40501` instances `N ∈ [0, 100]`, `k ∈ [-200, 200]`, evaluating `λ` symbolically as (fourth root
of unity) × (nonnegative real `√(N^k)`) and using the fact that such a product is `-1` iff the unit
is `-1` and the modulus is `1`.  The `N = 0` row was evaluated under Lean's conventions
`(0 : ℝ)^k = 0` for `k ≠ 0` and `√0 = 0`, so `λ = 0 ≠ -1` there whenever `k ≠ 0`.  Zero mismatches,
and every instance at which the eigenvalue IS `-1` had `N = 1`.

THE PINNED INSTANCES, and why each one:

* `N = 1`, `k = 12`  — THE `eta_S_via_fricke` INSTANCE (`r = (24)` at level one,
  `EtaQuotientModularity.lean:2246`; here `selfDual_eigen_pin_level_one`).  BOTH sides FALSE, with
  the LEVEL clause TRUE: `λ = 1`, the constant-free shape `η(-1/z)²⁴ = z¹² η(z)²⁴` that this library
  already proves by a completely different route, and `12 % 4 = 0 ≠ 2`.  This is the pin that forces
  the residue conjunct to exist.
* `N = 6`, `k = 12`  — the genuine `N > 1` self-dual instance (`rPinSix = (1, 11, 11, 1)`,
  `selfDual_cond_pin_level_six`).  BOTH sides FALSE, both conjuncts failing: `λ = 46656` and
  `12 % 4 = 0`.
* `N = 6`, `k = 0`   — THE DEGENERATE CASE `r ≡ 0` (`selfDual_cond_pin_zero_exp`).  BOTH sides
  FALSE, at a level that is NOT `1`.  DEGENERATE BY CONSTRUCTION and recorded as such: it certifies
  only that the statement is not mis-indexed at weight zero.  Note it is FALSE here where the
  `SDF-12` pin at the same `(N, k)` is TRUE — the `k = 0` disjunct is exactly what this node drops.
* `N = 2`, `k = 1`   — ODD WEIGHT (`rPinTwo = (1, 1)`, i.e. `f = η(z)·η(2z)`).  BOTH sides FALSE, and
  here `λ = -(i√2)` is not even real; it is refuted through its MODULUS `√2`, which is where
  `Real.sqrt_eq_one` earns its place, and `√2` is left symbolic rather than pinned to a decimal.
* `N = 1`, `k = 2`   — THE LOAD-BEARING PIN, and the ONLY pin in this section where BOTH SIDES ARE
  TRUE.  `λ = -1` (`frickeEigenvalue_pin_neg_one`), `2 % 4 = 2`, `N = 1`.  Without it the whole node
  would be a list of refutations and the right-hand side could be empty.
* `N = 6`, `k = -12` — NEGATIVE WEIGHT (`rPinLevelSixNeg = (-1, -11, -11, -1)`).  BOTH sides FALSE,
  with `λ = 1/46656` a proper fraction.  A statement or proof that silently assumed `0 ≤ k` breaks
  here.
* `N = 6`, `k = 2`   — THE LEVEL CONTROL, and the pin `SDF-12` has no analogue of.  The RESIDUE
  clause `2 % 4 = 2` HOLDS — so the root of unity IS `-1` — yet `λ = -6` because the modulus
  `√(6²) = 6` is not `1`.  This is the only pin at which the two conjuncts disagree with each other,
  and it is what forces the `N = 1` conjunct to exist.
* `N = 1`, `k = -2`  — BOTH SIDES TRUE AT A NEGATIVE WEIGHT, and THE `emod` PIN for this node.
  `λ = -1` and `(-2) % 4 = 2`; under a truncating remainder `Int.tmod (-2) 4 = -2` and the
  right-hand side would be FALSE at an instance where the eigenvalue genuinely is `-1`.

TWO NEGATIVE CONTROLS, one per conjunct, showing NEITHER is droppable.
`frickeEigenvalue_eq_neg_one_iff_pin_not_level_only` exhibits `N = 1`, `k = 12` with the level clause
true and `λ = 1 ≠ -1`, refuting the weakened form `λ = -1 ↔ N = 1`.
`frickeEigenvalue_eq_neg_one_iff_pin_not_emod_only` exhibits `N = 6`, `k = 2` with `2 % 4 = 2` and
`λ = -6 ≠ -1`, refuting the weakened form `λ = -1 ↔ k % 4 = 2` — i.e. reading `SDF-09` as if it
settled the eigenvalue.  So the conjunction is exactly right, not merely sufficient.

A THIRD CONTROL FIXES THE REMAINDER CONVENTION.  `frickeEigenvalue_eq_neg_one_iff_pin_emod_not_tmod`
records `(-2) % 4 = 2` and `Int.tmod (-2) 4 = -2` side by side together with the eigenvalue `-1` at
`(1, -2)`, so "Lean's `%` is `Int.emod`" is a checked fact of this node rather than an assumption
inherited from `SDF-09`.

THE `hN` HYPOTHESIS IS REDUNDANT, AND THIS IS PINNED RATHER THAN GLOSSED.
`frickeEigenvalue_eq_neg_one_iff_pin_hypothesis_redundant` proves the SAME biconditional at `N = 0`
at three weights, including `k = 2`, where the RESIDUE clause HOLDS and the biconditional survives
only because `λ = 0` and the level clause fails.  `hN` is nevertheless PASSED to `SDF-10` and
`SDF-11` in the proof below (both of which ignore it in turn), so it is syntactically used here; it
is kept for shape-uniformity with `SDF-10`, `SDF-11` and `SDF-12`, and a future reader must not infer
from its presence that the statement fails at `N = 0`.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node states when a complex number
attached to a level and a weight equals `-1`.  Persson–Volpato (arXiv:1504.07260) is cited in this
file's docstring as the ORIGIN of the question only, at the literature (L) tier; their CHL /
axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must never be
reported as one.

NORMALISATION CAVEAT, because this node is the one most likely to be misread.  `frickeEigenvalue` is
the UNNORMALISED constant of `f(-1/(Nz)) = λ · z^k · f(z)`, so it carries the factor `N^{k/2}`.
"Eigenvalue `-1` forces `N = 1`" is therefore a statement about THIS convention only.  It does NOT
contradict the classical fact (Martin, *Multiplicative eta-quotients*, 1996) that multiplicative eta
quotients of level `N > 1` have Fricke eigenvalue `±1`: that classical eigenvalue is the NORMALISED
one, which here is `i^{-k}` (`etaQuotient_fricke_selfDual_normalized`, `SDF-06`), where the
`N`-dependence has already cancelled by `SDF-02` (`prod_zpow_selfDual`).  `PIN G` (`N = 6`, `k = 2`)
is the machine-checked instance of the distinction: the normalised eigenvalue there is `i^{-2} = -1`,
while the unnormalised one is `-6`. -/

section Sdf13Pins

/-- `i^{2} = -1`, the integer-exponent form.  Needed by this section and by nothing before it:
`SDF-DEF-02`'s four `i`-power lemmas cover the exponents `±12`, `-2` and `-1`, and the two pins
below at `k = -2` need `i^{-k} = i^{2}`.  Proved from `Complex.I_sq` through `zpow_natCast`, the same
route as `I_zpow_twelve`. -/
theorem I_zpow_two : (I : ℂ) ^ (2 : ℤ) = -1 := by
  rw [show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq]

/-- **`SDF-13` VALUE PIN — `N = 6`, `k = 2`.**  `λ = i^{-2} · √(6²) = -1 · 6 = -6`.

THE INSTANCE THAT SEPARATES THE TWO CONJUNCTS.  The residue condition `2 % 4 = 2` holds, so the root
of unity is exactly `-1` — and yet the eigenvalue is `-6`, because the unnormalised constant carries
the modulus `N^{k/2} = 6`.  This is the value behind `PIN G` and behind NEGATIVE CONTROL 2, and it is
also the machine-checked witness for this node's NORMALISATION CAVEAT: the NORMALISED eigenvalue here
is `i^{-2} = -1` (`SDF-06`), the unnormalised one is `-6`, and only the latter is what `SDF-13`
classifies.  `SDF-DEF-02`'s own six value pins do not include this `(N, k)`. -/
theorem frickeEigenvalue_pin_level_six_weight_two : frickeEigenvalue 6 2 = -6 := by
  rw [frickeEigenvalue, I_zpow_neg_two,
      show (((6 : ℕ) : ℝ) ^ (2 : ℤ)) = (6 : ℝ) ^ 2 by norm_num,
      Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 6)]
  norm_num

/-- **`SDF-13` VALUE PIN — `N = 1`, `k = -2`.**  `λ = i^{2} · √(1⁻²) = -1 · 1 = -1`.

THE NEGATIVE-WEIGHT `-1`.  `SDF-DEF-02`'s `frickeEigenvalue_pin_neg_one` is the only pin in this file
asserting the value `-1`, and it does so at the POSITIVE weight `k = 2`.  This one is the same value
at `k = -2`, which is where the choice of remainder convention becomes load-bearing: `(-2) % 4 = 2`
under `Int.emod`, so the right-hand side of `SDF-13` is TRUE here and matches, whereas under a
truncating remainder it would be FALSE while the eigenvalue is genuinely `-1`.  See
`frickeEigenvalue_eq_neg_one_iff_pin_emod_not_tmod`. -/
theorem frickeEigenvalue_pin_level_one_weight_neg_two : frickeEigenvalue 1 (-2) = -1 := by
  rw [frickeEigenvalue, neg_neg, I_zpow_two, Nat.cast_one, _root_.one_zpow, Real.sqrt_one]
  norm_num

/-- **`SDF-13` PIN A — `N = 1`, `k = 12`; BOTH SIDES FALSE, with the LEVEL clause TRUE.**  `λ = 1`
(`frickeEigenvalue_pin_level_one`), and on the right `12 % 4 = 0 ≠ 2`.

This is the level-one instance behind the sorry-free `eta_S_via_fricke`, where the Fricke
transformation carries no constant at all — the eigenvalue is `1`, not `-1`.  Since `N = 1` holds
here, this pin is refuted by the RESIDUE conjunct alone, which is exactly why that conjunct cannot be
dropped (NEGATIVE CONTROL 1). -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_level_one :
    frickeEigenvalue 1 12 = -1 ↔ ((12 : ℤ) % 4 = 2 ∧ (1 : ℕ) = 1) :=
  iff_of_false
    (by rw [frickeEigenvalue_pin_level_one]; norm_num)
    (by rintro ⟨h, -⟩; omega)

/-- **`SDF-13` PIN B — `N = 6`, `k = 12`; BOTH SIDES FALSE, both conjuncts failing.**  `λ = 46656`
(`frickeEigenvalue_pin_level_six`) and `12 % 4 = 0 ≠ 2`.

This is the genuine `N > 1` self-dual instance of this file, `rPinSix = (1, 11, 11, 1)` at level `6`
and weight `12` (`selfDual_cond_pin_level_six`, `rPinSix_nonconstant`) — the instance that makes the
whole `±1` classification sharp rather than vacuous.  It is the same `(N, k)` at which `SDF-12`'s
`PIN B` is also false, and for a strictly weaker reason there: `4 ∣ 12` holds, so `SDF-12` needed the
modulus to refute it, while here the residue conjunct already does. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_level_six :
    frickeEigenvalue 6 12 = -1 ↔ ((12 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1) :=
  iff_of_false
    (by rw [frickeEigenvalue_pin_level_six]; norm_num)
    (by rintro ⟨h, -⟩; omega)

/-- **`SDF-13` PIN C — the degenerate weight `k = 0`, at `N = 6`; BOTH SIDES FALSE.**  `λ = 1`
(`frickeEigenvalue_pin_zero_weight`), and `0 % 4 = 0 ≠ 2`.

DEGENERATE BY CONSTRUCTION, recorded as a floor certifying the biconditional is not mis-indexed at
weight zero — not as evidence about the exponents.  This is the eigenvalue of the degenerate
self-dual vector `r ≡ 0` (`selfDual_cond_pin_zero_exp`, `zeroExp_weight_level_six`).

NOTE THE CONTRAST WITH `SDF-12`.  At this same `(N, k)` the `SDF-12` pin is TRUE (both factors of
`λ` collapse to `1` at weight zero); here it is FALSE.  That is the `k = 0` disjunct which `SDF-13`'s
right-hand side does not carry, made visible at a concrete instance. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_zero_weight :
    frickeEigenvalue 6 0 = -1 ↔ ((0 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1) :=
  iff_of_false
    (by rw [frickeEigenvalue_pin_zero_weight]; norm_num)
    (by rintro ⟨h, -⟩; omega)

/-- **`SDF-13` PIN D — ODD WEIGHT: `N = 2`, `k = 1`; BOTH SIDES FALSE.**  `λ = -(i√2)`
(`frickeEigenvalue_pin_level_two_weight_one`), and `1 % 4 = 1 ≠ 2`.

This is the level and weight of `rPinTwo = (1, 1)`, i.e. `f = η(z)·η(2z)`, whose Fricke behaviour is
pinned sorry-free upstream by `fricke_level_two_pin` (`EtaQuotientModularity.lean:2285`).  It is the
only pin here whose eigenvalue leaves `ℝ`.

The refutation goes through the MODULUS, computed from the value pin by hand rather than by citing
`SDF-11`: `‖-(i√2)‖ = ‖i‖ · |√2| = √2`, while `‖-1‖ = 1`, so `λ = -1` would force `√2 = 1` and hence,
by `Real.sqrt_eq_one`, `(2 : ℝ) = 1`.  `√2` is never pinned to a decimal — it is irrational and a
decimal would be false precision. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_level_two_weight_one :
    frickeEigenvalue 2 1 = -1 ↔ ((1 : ℤ) % 4 = 2 ∧ (2 : ℕ) = 1) := by
  refine iff_of_false ?_ (by rintro ⟨h, -⟩; omega)
  intro h
  rw [frickeEigenvalue_pin_level_two_weight_one] at h
  have h1 : ‖-(I * ((Real.sqrt 2 : ℝ) : ℂ))‖ = 1 := by rw [h, norm_neg, norm_one]
  rw [norm_neg, norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Real.sqrt_nonneg _)] at h1
  have h2 : (2 : ℝ) = 1 := Real.sqrt_eq_one.mp h1
  norm_num at h2

/-- **`SDF-13` PIN E — `N = 1`, `k = 2`.  THE LOAD-BEARING PIN, AND THE ONLY ONE WHERE BOTH SIDES ARE
TRUE.**  `λ = -1` (`frickeEigenvalue_pin_neg_one`), `2 % 4 = 2`, and `N = 1`.

Every other pin in this section is a refutation.  This is the pin that makes the right-hand side
non-empty, and the only machine-checked witness in this file — together with its negative-weight
companion `PIN H` — that `frickeEigenvalue` ever takes the value `-1` at all.  It is the instance
`SDF-09`'s `PIN D` is about on the root-of-unity side (`i^{-2} = -1`), reached here through the
eigenvalue rather than through the root of unity: the level-one modulus `√(1²) = 1` contributes
nothing, so the two routes must and do agree. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_neg_one :
    frickeEigenvalue 1 2 = -1 ↔ ((2 : ℤ) % 4 = 2 ∧ (1 : ℕ) = 1) :=
  iff_of_true frickeEigenvalue_pin_neg_one ⟨by decide, rfl⟩

/-- **`SDF-13` PIN F — NEGATIVE WEIGHT: `N = 6`, `k = -12`; BOTH SIDES FALSE.**  `λ = 1/46656`
(`frickeEigenvalue_pin_level_six_neg`) — a proper fraction, not an integer — and `(-12) % 4 = 0 ≠ 2`.

This is the weight of `rPinLevelSixNeg = (-1, -11, -11, -1)` (`rPinLevelSixNeg_selfDual`).  A
statement or proof that had silently assumed `0 ≤ k` — a `k.toNat`, or `pow_pos` in place of
`zpow_pos` — is FALSE here, at a weight this file has a real self-dual eta-quotient instance for. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_level_six_neg :
    frickeEigenvalue 6 (-12) = -1 ↔ ((-12 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1) :=
  iff_of_false
    (by rw [frickeEigenvalue_pin_level_six_neg]; norm_num)
    (by rintro ⟨h, -⟩; omega)

/-- **`SDF-13` PIN G — `N = 6`, `k = 2`.  THE LEVEL CONTROL, and the pin `SDF-12` has no analogue
of.**  BOTH SIDES FALSE, and the two conjuncts DISAGREE: `2 % 4 = 2` HOLDS, so the root of unity is
exactly `-1`, and yet `λ = -6` (`frickeEigenvalue_pin_level_six_weight_two`) because the modulus
`√(6²) = 6` is not `1`.

This is the only pin at which the right-hand side's two conjuncts take different truth values, so it
is what makes the `N = 1` conjunct non-redundant — the analogue of `SDF-12`'s `PIN B`, but at the
`-1` value, where the root of unity is not merely `1` by accident but genuinely equal to the target.
It is also this node's NORMALISATION witness: the classical, NORMALISED Fricke eigenvalue here is
`i^{-2} = -1`, and only the UNNORMALISED one classified by `SDF-13` is `-6`. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two :
    frickeEigenvalue 6 2 = -1 ↔ ((2 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1) :=
  iff_of_false
    (by rw [frickeEigenvalue_pin_level_six_weight_two]; norm_num)
    (by rintro ⟨-, h⟩; omega)

/-- **`SDF-13` PIN H — `N = 1`, `k = -2`.  BOTH SIDES TRUE AT A NEGATIVE WEIGHT; THE `emod` PIN.**
`λ = -1` (`frickeEigenvalue_pin_level_one_weight_neg_two`) and `(-2) % 4 = 2` with `N = 1`.

`PIN E` is the same value at the positive weight `k = 2`.  This one is where the remainder convention
is load-bearing: `Int.tmod (-2) 4 = -2 ≠ 2`, so under a truncating remainder the right-hand side
would be FALSE at an instance whose eigenvalue genuinely IS `-1`, and `SDF-13` would be false at
every weight in `{…, -10, -6, -2}`.  See `frickeEigenvalue_eq_neg_one_iff_pin_emod_not_tmod`, which
records both remainders side by side. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_neg_one_neg_weight :
    frickeEigenvalue 1 (-2) = -1 ↔ ((-2 : ℤ) % 4 = 2 ∧ (1 : ℕ) = 1) :=
  iff_of_true frickeEigenvalue_pin_level_one_weight_neg_two ⟨by decide, rfl⟩

/-- **`SDF-13` NEGATIVE CONTROL 1 — the RESIDUE conjunct is NOT droppable.**  At `N = 1`, `k = 12`
the level clause `N = 1` HOLDS while `λ = 1 ≠ -1`.  So the weakened form `λ = -1 ↔ N = 1` — i.e.
`SDF-13` with the `k % 4 = 2` conjunct deleted — is FALSE.

Equivalently: `SDF-10` alone does not settle `SDF-13`. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_not_level_only :
    frickeEigenvalue 1 12 ≠ -1 ∧ (1 : ℕ) = 1 :=
  ⟨by rw [frickeEigenvalue_pin_level_one]; norm_num, rfl⟩

/-- **`SDF-13` NEGATIVE CONTROL 2 — the LEVEL conjunct is NOT droppable.**  At `N = 6`, `k = 2` the
residue clause `2 % 4 = 2` HOLDS while `λ = -6 ≠ -1`.  So the weakened form `λ = -1 ↔ k % 4 = 2` —
i.e. `SDF-13` with the second conjunct deleted, which is what one would get by reading `SDF-09` as
if it settled the eigenvalue rather than only its root-of-unity factor — is FALSE.

Taken with NEGATIVE CONTROL 1, this shows the conjunction is exactly right, not merely sufficient:
each control has one conjunct true and the eigenvalue nevertheless not `-1`. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_not_emod_only :
    frickeEigenvalue 6 2 ≠ -1 ∧ (2 : ℤ) % 4 = 2 :=
  ⟨by rw [frickeEigenvalue_pin_level_six_weight_two]; norm_num, by decide⟩

/-- **`SDF-13` NEGATIVE CONTROL 3 — `%` is `Int.emod`, and the distinction is load-bearing HERE, not
only in `SDF-09`.**  `(-2) % 4 = 2` while `Int.tmod (-2) 4 = -2`, and at that very weight the
eigenvalue is `-1` (`frickeEigenvalue_pin_level_one_weight_neg_two`).

So a reading of `SDF-13`'s `%` as a truncating remainder would make the right-hand side FALSE at an
instance where the left-hand side is TRUE.  `SDF-09` carries the same control on the root of unity
alone; this one carries it on the EIGENVALUE, so the convention is a checked fact of this node rather
than an assumption inherited from upstream. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_emod_not_tmod :
    frickeEigenvalue 1 (-2) = -1 ∧ ((-2 : ℤ) % 4 = 2) ∧ (Int.tmod (-2 : ℤ) 4 = -2) ∧
      ((2 : ℤ) ≠ -2) :=
  ⟨frickeEigenvalue_pin_level_one_weight_neg_two, by decide, by decide, by decide⟩

/-- **`SDF-13` ASYMMETRY PIN — why this node's right-hand side is not `SDF-12`'s with `1` replaced
by `-1`.**

Three conjuncts.  (i) The `SDF-12`-SHAPED right-hand side `(k % 4 = 2 ∧ (N = 1 ∨ k = 0))` is
EQUIVALENT to the one `SDF-13` actually uses, for EVERY `N` and `k`: the residue clause forces
`k ≠ 0`, so the `k = 0` disjunct can never fire and the level condition collapses to `N = 1`.  The
sharpening is therefore free, not an extra hypothesis.  (ii)+(iii) The two nodes are nevertheless
DIFFERENT statements: at `N = 6`, `k = 0`, `SDF-12`'s right-hand side `(4 ∣ 0 ∧ (6 = 1 ∨ 0 = 0))` is
TRUE while `SDF-13`'s `(0 % 4 = 2 ∧ 6 = 1)` is FALSE.

This is recorded as a machine-checked pin rather than as a remark in prose because "the `k = 0`
disjunct is absent" is exactly the kind of statement-level difference a reader comparing the two
nodes would otherwise have to take on trust. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_asymmetry :
    (∀ (N : ℕ) (k : ℤ), (k % 4 = 2 ∧ (N = 1 ∨ k = 0)) ↔ (k % 4 = 2 ∧ N = 1)) ∧
      ((4 : ℤ) ∣ (0 : ℤ) ∧ ((6 : ℕ) = 1 ∨ (0 : ℤ) = 0)) ∧
      ¬((0 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1) := by
  refine ⟨fun N k => ⟨?_, ?_⟩, ⟨dvd_zero 4, Or.inr rfl⟩, by rintro ⟨h, -⟩; omega⟩
  · rintro ⟨h1, h2 | h2⟩
    · exact ⟨h1, h2⟩
    · exact absurd h1 (by omega)
  · rintro ⟨h1, h2⟩
    exact ⟨h1, Or.inl h2⟩

/-- **`SDF-13` HYPOTHESIS-REDUNDANCY PIN.**  The biconditional also holds at `N = 0`, at a zero, a
positive and an odd weight.  Under Lean's conventions `(0 : ℝ)^k = 0` for `k ≠ 0` and `√0 = 0`, so
`λ = 0` there, which is not `-1`; at `k = 0` the eigenvalue is `1`, also not `-1`.  The right-hand
side is false at all three because `0 = 1` is false.

The `k = 2` conjunct is the informative one: there the RESIDUE clause `2 % 4 = 2` HOLDS, so the
biconditional survives at `N = 0` only because the LEVEL conjunct fails — the same reason it fails at
`N = 6`, `k = 2` (`PIN G`).

So `hN : 0 < N` is REDUNDANT in `frickeEigenvalue_eq_neg_one_iff`.  It is kept there (and IS used,
being passed to `SDF-10` and `SDF-11`, which ignore it in turn) only so that lemma's shape matches
`SDF-10`, `SDF-11` and `SDF-12`.  Recorded as a machine-checked pin rather than as a remark so no
future reader infers that the statement fails at `N = 0`. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_hypothesis_redundant :
    (frickeEigenvalue 0 (0 : ℤ) = -1 ↔ ((0 : ℤ) % 4 = 2 ∧ (0 : ℕ) = 1)) ∧
      (frickeEigenvalue 0 (2 : ℤ) = -1 ↔ ((2 : ℤ) % 4 = 2 ∧ (0 : ℕ) = 1)) ∧
      (frickeEigenvalue 0 (5 : ℤ) = -1 ↔ ((5 : ℤ) % 4 = 2 ∧ (0 : ℕ) = 1)) := by
  have hzero : ∀ k : ℤ, k ≠ 0 → frickeEigenvalue 0 k = 0 := by
    intro k hk
    rw [frickeEigenvalue, Nat.cast_zero, _root_.zero_zpow k hk, Real.sqrt_zero, Complex.ofReal_zero,
      mul_zero]
  refine ⟨?_, ?_, ?_⟩
  · refine iff_of_false ?_ (by rintro ⟨h, -⟩; omega)
    rw [frickeEigenvalue, neg_zero, zpow_zero, zpow_zero, Real.sqrt_one, Complex.ofReal_one,
      mul_one]
    norm_num
  · refine iff_of_false ?_ (by rintro ⟨-, h⟩; omega)
    rw [hzero 2 (by norm_num)]
    norm_num
  · refine iff_of_false ?_ (by rintro ⟨h, -⟩; omega)
    rw [hzero 5 (by norm_num)]
    norm_num

end Sdf13Pins

/-- **`SDF-13`** — *statement CONFIRMED by the orchestrating session; see the receipt below.*  The
unnormalised Fricke eigenvalue is `-1` exactly when the root of unity `i^{-k}` is `-1` **and** the
modulus `N^{k/2}` is `1`:

`frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1)`.

PROOF, in four named steps, no case split on `N` and only the two-way split of `SDF-10` on `k`.

*Forward.*  From `λ = -1`, take moduli: `‖λ‖ = ‖-1‖ = 1` (`norm_neg` then `norm_one`), and `SDF-11`
(`frickeEigenvalue_norm`) says `‖λ‖ = √((N : ℝ)^k)`, so `√((N : ℝ)^k) = 1`.  Mathlib's
`Real.sqrt_eq_one` is UNCONDITIONAL (`Analysis/Real/Sqrt.lean:172`, `√x = 1 ↔ x = 1`, no sign
hypothesis on `x`), so `(N : ℝ)^k = 1`.  Substituting `√((N : ℝ)^k) = 1` back into the definition of
`SDF-DEF-02` leaves `i^{-k} = -1`, and `SDF-09` (`I_zpow_neg_eq_neg_one_iff`) turns that into
`k % 4 = 2`.  Finally `SDF-10` (`natCast_zpow_eq_one_iff`) turns `(N : ℝ)^k = 1` into `N = 1 ∨ k = 0`
and the second disjunct is KILLED by `omega` against `k % 4 = 2` (from `k = 0` one gets
`0 % 4 = 0 ≠ 2`).  That last step is the ONLY place this proof differs structurally from `SDF-12`'s,
and it is why the right-hand side here has no `k = 0` disjunct.

*Backward.*  `SDF-09` and `SDF-10` in the `mpr` direction give `i^{-k} = -1` and — feeding `N = 1`
through `Or.inl` — `(N : ℝ)^k = 1`; substituting both into `SDF-DEF-02` leaves `-1 · √1 = -1`.

Note which lemma does the work at the square root: `Real.sqrt_eq_one`, not `Real.sq_sqrt`.  (The DAG
node's `built_from` names the latter; it would create a `0 ≤ (N : ℝ)^k` side goal and a `zpow_pos`
detour for no gain, so the former is used instead.  A build hint, not a statement difference.)  No
positivity hypothesis about `N` is required anywhere in this proof.

`hN` IS PASSED THROUGH BUT MATHEMATICALLY REDUNDANT.  It is consumed only by `SDF-10` and `SDF-11`,
both of which ignore it in turn, and `frickeEigenvalue_eq_neg_one_iff_pin_hypothesis_redundant`
proves this very biconditional at `N = 0` at three weights.  It is kept so this lemma's shape matches
`SDF-10`, `SDF-11` and `SDF-12`.

RECEIPT — THE RECONSTRUCTION CAVEAT IS NOW DISCHARGED.  This declaration's statement was originally
RECONSTRUCTED by a run whose task specification had been truncated mid-node at the string `theorem
frickeEigenvalue_`, and its docstring asked the orchestrating session to confirm or replace it (see
the `RENUMBERING RECEIPT` paragraph in this file's header).  The orchestrating session has now
supplied `SDF-13` in full, and the supplied statement agrees with this declaration CHARACTER FOR
CHARACTER, hypothesis `hN` included.  The reconstruction is therefore confirmed, not merely
plausible, and this node may be reported as a specified node.  With `SDF-12` (confirmed one commit
earlier) this closes the last reconstructed declaration in the file: NO declaration below carries an
unconfirmed statement any more.

NORMALISATION CAVEAT — DO NOT REPORT THIS NODE WITHOUT IT.  `frickeEigenvalue` is the UNNORMALISED
constant of `f(-1/(Nz)) = λ · z^k · f(z)` and carries the factor `N^{k/2}`.  Read without that
qualification, "eigenvalue `-1` forces `N = 1`" would appear to contradict the classical fact
(Martin, *Multiplicative eta-quotients*, 1996) that multiplicative eta quotients of level `N > 1`
have Fricke eigenvalue `±1`.  It does not: the classical eigenvalue is the NORMALISED one, here
`i^{-k}` (`etaQuotient_fricke_selfDual_normalized`, `SDF-06`), whose `N`-dependence has already
cancelled by `SDF-02`.  `frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two` is the pin where
the two disagree: at `N = 6`, `k = 2` the normalised eigenvalue is `-1` and the unnormalised one is
`-6`.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node says when a complex number attached
to a level and a weight equals `-1`.  Persson–Volpato (arXiv:1504.07260) is cited in this file's
docstring as the ORIGIN of the question only, at the literature (L) tier; their CHL / axio-dilaton
S-duality claim is NOT a Lean statement anywhere in this library. -/
theorem frickeEigenvalue_eq_neg_one_iff {N : ℕ} (hN : 0 < N) (k : ℤ) :
    frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1) := by
  constructor
  · intro h
    have hsqrt : Real.sqrt ((N : ℝ) ^ k) = 1 := by
      rw [← frickeEigenvalue_norm hN k, h, norm_neg, norm_one]
    have hpow : ((N : ℝ) ^ k) = 1 := Real.sqrt_eq_one.mp hsqrt
    have hemod : k % 4 = 2 := by
      refine (I_zpow_neg_eq_neg_one_iff k).mp ?_
      rw [frickeEigenvalue, hsqrt, Complex.ofReal_one, mul_one] at h
      exact h
    refine ⟨hemod, ?_⟩
    rcases (natCast_zpow_eq_one_iff hN k).mp hpow with hlevel | hzero
    · exact hlevel
    · exact absurd hemod (by omega)
  · rintro ⟨hemod, hlevel⟩
    rw [frickeEigenvalue, (I_zpow_neg_eq_neg_one_iff k).mpr hemod,
      (natCast_zpow_eq_one_iff hN k).mpr (Or.inl hlevel), Real.sqrt_one, Complex.ofReal_one,
      mul_one]

/-- **`SDF-13` APPLICATION CHECK — the general lemma reproduces the pins.**  Each conjunct is one
pinned `(N, k)`, but REACHED BY RUNNING `frickeEigenvalue_eq_neg_one_iff` there rather than by the
pin's own route through `frickeEigenvalue_pin_*`.  Every pinned instance is therefore settled twice
by routes that share no lemma below `SDF-DEF-02`, and they agree.

`(6, 2)` is the informative conjunct — the load-bearing instance where `k % 4 = 2` holds and the
eigenvalue is still not `-1` — `(1, 2)` and `(1, -2)` are the two where BOTH sides are true, and
`(6, -12)` is where a proof that assumed `0 ≤ k` would break. -/
theorem frickeEigenvalue_eq_neg_one_iff_pin_application :
    (frickeEigenvalue 1 12 = -1 ↔ ((12 : ℤ) % 4 = 2 ∧ (1 : ℕ) = 1)) ∧
      (frickeEigenvalue 6 12 = -1 ↔ ((12 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1)) ∧
      (frickeEigenvalue 6 0 = -1 ↔ ((0 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1)) ∧
      (frickeEigenvalue 2 1 = -1 ↔ ((1 : ℤ) % 4 = 2 ∧ (2 : ℕ) = 1)) ∧
      (frickeEigenvalue 1 2 = -1 ↔ ((2 : ℤ) % 4 = 2 ∧ (1 : ℕ) = 1)) ∧
      (frickeEigenvalue 6 (-12) = -1 ↔ ((-12 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1)) ∧
      (frickeEigenvalue 6 2 = -1 ↔ ((2 : ℤ) % 4 = 2 ∧ (6 : ℕ) = 1)) ∧
      (frickeEigenvalue 1 (-2) = -1 ↔ ((-2 : ℤ) % 4 = 2 ∧ (1 : ℕ) = 1)) :=
  ⟨frickeEigenvalue_eq_neg_one_iff (by decide) 12, frickeEigenvalue_eq_neg_one_iff (by decide) 12,
    frickeEigenvalue_eq_neg_one_iff (by decide) 0, frickeEigenvalue_eq_neg_one_iff (by decide) 1,
    frickeEigenvalue_eq_neg_one_iff (by decide) 2, frickeEigenvalue_eq_neg_one_iff (by decide) (-12),
    frickeEigenvalue_eq_neg_one_iff (by decide) 2, frickeEigenvalue_eq_neg_one_iff (by decide) (-2)⟩

/-! ### `SDF-14` — `λ = ±1`, restated on the WEIGHT SUM `∑_{δ ∣ N} r δ`

`frickeEigenvalue_pm_one_iff` below.  Everything in this section is `sorry`-free and guarded in
`SocrateAI.FinalCheck`, section `Sdf14`. -/

section Sdf14Pins

/-- Level-one **negative**-weight exponent vector `r = (-4)` on the single divisor `1`, i.e. the
formal quotient `η(z)⁻⁴`, with `∑ r δ = -4 = 2 · (-2)`, hence `k = -2`.  The entrywise negation of
`rPinFour`.  It exists so `SDF-14` has a pin at which the weight sum is DIVISIBLE BY FOUR, the
weight `k` is NEGATIVE, and the eigenvalue is `-1` — the instance that sees Lean's `%` as
`Int.emod` rather than a truncating remainder (`frickeEigenvalue_pm_one_iff_pin_emod_not_tmod`). -/
def rPinNegFour : EtaExp := fun δ => if δ = 1 then (-4 : ℤ) else 0

/-- `∑ δ ∈ (1:ℕ).divisors, rPinNegFour δ = -4 = 2 · (-2)`.  The weight witness for `rPinNegFour`;
`(1:ℕ).divisors = {1}`, so the sum is the single entry `-4`. -/
theorem rPinNegFour_weight : (∑ δ ∈ (1 : ℕ).divisors, rPinNegFour δ) = 2 * (-2) := by decide

/-! #### The seven instance pins — both sides of `SDF-14` at concrete `(N, r, k)`

Every pin below carries THREE things: the weight witness `∑ δ ∈ N.divisors, r δ = 2 * k` for a
CONCRETE exponent vector (so the hypothesis `hk` of the general lemma is exhibited, not assumed),
the truth value of the left-hand side reached through the `frickeEigenvalue_pin_*` VALUE pins, and
the truth value of the right-hand side reached by `decide`/`omega` on the computed sum.  None of
them uses `SDF-14` itself, and none uses `SDF-12` or `SDF-13`: they are computed BEFORE the general
lemma and are what would catch a wrong statement.

Coverage: `PIN A` and `PIN C` are the two where both sides are TRUE for the `4 ∣ ∑` + `N = 1`
reason and the `∑ = 0` reason respectively; `PIN D` and `PIN G` are the two where both sides are
TRUE and the eigenvalue is `-1`, not `1`; `PIN B`, `PIN E` and `PIN F` are the three where both
sides are FALSE, one per way of failing. -/

/-- **`SDF-14` PIN A — the level-one weight-12 case, `Δ = η²⁴`; BOTH SIDES TRUE.**

`r = rPinOne` on `(1:ℕ).divisors = {1}` has `∑ r δ = 24 = 2 · 12`, so `k = 12`.  On the left,
`frickeEigenvalue 1 12 = 1` (`frickeEigenvalue_pin_level_one`), so the disjunction holds through its
FIRST disjunct.  On the right, `4 ∣ 24` and `N = 1`.

This is the instance underlying the already sorry-free `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`), `η(-1/z)²⁴ = z¹² η(z)²⁴` — the sanity case against which the
whole `SDF-*` chain is calibrated.  It is also the ONLY pin here at which Persson–Volpato's Frame
shape normalisation `∑ a·m(a) = 24` and this library's weight normalisation `∑ r δ = 2k` coincide
(see this file's header); nothing in the statement depends on that. -/
theorem frickeEigenvalue_pm_one_iff_pin_level_one :
    (∑ δ ∈ (1 : ℕ).divisors, rPinOne δ) = 2 * 12 ∧
      (frickeEigenvalue 1 12 = 1 ∨ frickeEigenvalue 1 12 = -1) ∧
      ((4 : ℤ) ∣ (∑ δ ∈ (1 : ℕ).divisors, rPinOne δ) ∧
        ((1 : ℕ) = 1 ∨ (∑ δ ∈ (1 : ℕ).divisors, rPinOne δ) = 0)) :=
  ⟨rPinOne_weight, Or.inl frickeEigenvalue_pin_level_one,
    by rw [rPinOne_weight]; exact ⟨by decide, Or.inl rfl⟩⟩

/-- **`SDF-14` PIN B — the LOAD-BEARING pin: a genuine `N > 1` self-dual vector; BOTH SIDES FALSE.**

`r = rPinSix = (1, 11, 11, 1)` on `(1, 2, 3, 6)` is Fricke-self-dual (`selfDual_cond_pin_level_six`),
genuinely non-constant, and has `∑ r δ = 24 = 2 · 12`, so `k = 12` — the SAME weight sum as `PIN A`.
On the left, `frickeEigenvalue 6 12 = 46656` (`frickeEigenvalue_pin_level_six`), which is neither
`1` nor `-1`.  On the right, `4 ∣ 24` holds but the second conjunct fails: `6 ≠ 1` and `24 ≠ 0`.

This is what makes `SDF-14` sharp rather than vacuous, in two directions at once.  (i) The pin shares
its weight sum with `PIN A` and disagrees with it, so the `(N = 1 ∨ ∑ r δ = 0)` conjunct is doing
real work — a statement with only the divisibility conjunct would be FALSE here.  (ii) The vector is
a real `N > 1` self-dual one, so the failure is not an artefact of a degenerate input. -/
theorem frickeEigenvalue_pm_one_iff_pin_level_six :
    (∑ δ ∈ (6 : ℕ).divisors, rPinSix δ) = 2 * 12 ∧
      ¬(frickeEigenvalue 6 12 = 1 ∨ frickeEigenvalue 6 12 = -1) ∧
      ¬((4 : ℤ) ∣ (∑ δ ∈ (6 : ℕ).divisors, rPinSix δ) ∧
        ((6 : ℕ) = 1 ∨ (∑ δ ∈ (6 : ℕ).divisors, rPinSix δ) = 0)) := by
  refine ⟨rPinSix_weight, ?_, ?_⟩
  · rintro (h | h) <;> rw [frickeEigenvalue_pin_level_six] at h <;> norm_num at h
  · rw [rPinSix_weight]
    rintro ⟨-, h | h⟩ <;> omega

/-- **`SDF-14` PIN C — the DEGENERATE vector `r ≡ 0` at `N = 6`; BOTH SIDES TRUE.**

`r = (0 : EtaExp)` has `∑ r δ = 0 = 2 · 0`, so `k = 0`, at a level that is NOT `1`.  On the left,
`frickeEigenvalue 6 0 = 1` (`frickeEigenvalue_pin_zero_weight`).  On the right, `4 ∣ 0` and the
SECOND disjunct `∑ r δ = 0` fires.

This is the pin that makes the `∑ r δ = 0` disjunct non-vacuous: it is the only way the right-hand
side can hold at `N > 1`, and `PIN B` shows that without it every `N > 1` instance here would be
false.  The vector is self-dual for the trivial reason (`selfDual_cond_pin_zero_exp`), which is why
this pin is recorded as DEGENERATE and `PIN B` is the load-bearing one. -/
theorem frickeEigenvalue_pm_one_iff_pin_zero_exp :
    (∑ δ ∈ (6 : ℕ).divisors, (0 : EtaExp) δ) = 2 * 0 ∧
      (frickeEigenvalue 6 0 = 1 ∨ frickeEigenvalue 6 0 = -1) ∧
      ((4 : ℤ) ∣ (∑ δ ∈ (6 : ℕ).divisors, (0 : EtaExp) δ) ∧
        ((6 : ℕ) = 1 ∨ (∑ δ ∈ (6 : ℕ).divisors, (0 : EtaExp) δ) = 0)) := by
  have hz : (∑ δ ∈ (6 : ℕ).divisors, (0 : EtaExp) δ) = 2 * 0 := by decide
  exact ⟨hz, Or.inl frickeEigenvalue_pin_zero_weight, by rw [hz]; exact ⟨by decide, Or.inr rfl⟩⟩

/-- **`SDF-14` PIN D — THE TRAP.  `4 ∣ ∑ r δ` does NOT give `4 ∣ k`, and here the eigenvalue is
`-1`, not `1`.**

`r = rPinFour = (4)` on `(1:ℕ).divisors = {1}`, i.e. `f = η⁴`, has `∑ r δ = 4 = 2 · 2`, so `k = 2`.
Four conjuncts, and the last two are the point: `4 ∣ 4` holds for the weight SUM while
`4 ∣ 2` FAILS for the weight `k`.  Consequently `frickeEigenvalue 1 2 = -1`
(`frickeEigenvalue_pin_neg_one`) and `frickeEigenvalue 1 2 ≠ 1`
(`frickeEigenvalue_pin_not_one`): the left-hand side of `SDF-14` holds through its SECOND disjunct,
`SDF-13`, and a proof of the backward direction that routed everything to `SDF-12` would be REFUTED
at this very instance.

This pin is the reason `SDF-14`'s proof case-splits `k % 4 ∈ {0, 2}` instead of deriving `4 ∣ k`.
It is recorded as a machine-checked pin, not as a comment, because the mis-derivation
`4 ∣ 2k ⟹ 4 ∣ k` is exactly the kind of step that looks free and is not. -/
theorem frickeEigenvalue_pm_one_iff_pin_neg_one_branch :
    (∑ δ ∈ (1 : ℕ).divisors, rPinFour δ) = 2 * 2 ∧
      frickeEigenvalue 1 2 = -1 ∧ frickeEigenvalue 1 2 ≠ 1 ∧
      ((4 : ℤ) ∣ (∑ δ ∈ (1 : ℕ).divisors, rPinFour δ)) ∧ ¬((4 : ℤ) ∣ (2 : ℤ)) := by
  have hw : (∑ δ ∈ (1 : ℕ).divisors, rPinFour δ) = 2 * 2 := by decide
  exact ⟨hw, frickeEigenvalue_pin_neg_one, frickeEigenvalue_pin_not_one, by rw [hw]; decide,
    by decide⟩

/-- **`SDF-14` PIN E — an ODD weight, `k = 1` at `N = 2`; BOTH SIDES FALSE.**

`r = rPinTwo = (1, 1)` on `(1, 2)`, i.e. `f = η(z)η(2z)`, has `∑ r δ = 2 = 2 · 1`, so `k = 1`.  On
the right, `4 ∣ 2` is FALSE, so the whole conjunction fails on its FIRST conjunct — the only pin here
that fails that way.  On the left, `‖frickeEigenvalue 2 1‖ = √2` by `SDF-11`
(`frickeEigenvalue_norm`), and `√2 ≠ 1`, so the eigenvalue is neither `1` nor `-1`; note that both
disjuncts are killed by the SAME modulus computation, which is why this pin routes through `SDF-11`
rather than through the value pin `frickeEigenvalue_pin_level_two_weight_one`.

The informative content: the divisibility conjunct is not implied by the rest.  `PIN B` and `PIN F`
fail on the OTHER conjunct with `4 ∣ ∑ r δ` true, so between them the three false pins show each
conjunct can fail alone. -/
theorem frickeEigenvalue_pm_one_iff_pin_level_two_weight_one :
    (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) = 2 * 1 ∧
      ¬(frickeEigenvalue 2 1 = 1 ∨ frickeEigenvalue 2 1 = -1) ∧
      ¬((4 : ℤ) ∣ (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) ∧
        ((2 : ℕ) = 1 ∨ (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) = 0)) := by
  have hw : (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) = 2 * 1 := by decide
  have hnorm : ‖frickeEigenvalue 2 1‖ = Real.sqrt 2 := by
    rw [frickeEigenvalue_norm (by norm_num) 1]
    norm_num
  have hs : Real.sqrt 2 ≠ 1 := by
    intro h
    have h2 := Real.sqrt_eq_one.mp h
    norm_num at h2
  refine ⟨hw, ?_, ?_⟩
  · rintro (h | h)
    · exact hs (by rw [← hnorm, h, norm_one])
    · exact hs (by rw [← hnorm, h, norm_neg, norm_one])
  · rw [hw]; rintro ⟨h, -⟩; omega

/-- **`SDF-14` PIN F — a NEGATIVE weight sum at `N > 1`; BOTH SIDES FALSE.**

`r = rPinLevelSixNeg = (-1, -11, -11, -1)` on `(1, 2, 3, 6)`, the entrywise negation of `rPinSix`,
has `∑ r δ = -24 = 2 · (-12)`, so `k = -12`.  On the left,
`frickeEigenvalue 6 (-12) = (46656 : ℂ)⁻¹` (`frickeEigenvalue_pin_level_six_neg`), neither `1` nor
`-1`.  On the right, `4 ∣ -24` holds and the second conjunct fails.

This is where a proof or a statement that silently assumed `0 ≤ ∑ r δ` — or `0 ≤ k` — would break:
`4 ∣ -24` is a divisibility fact about a NEGATIVE integer, and `-24 ≠ 0` is what kills the second
disjunct.  It is `PIN B` re-run at the mirrored weight and it must agree with it; it does. -/
theorem frickeEigenvalue_pm_one_iff_pin_level_six_neg :
    (∑ δ ∈ (6 : ℕ).divisors, rPinLevelSixNeg δ) = 2 * (-12) ∧
      ¬(frickeEigenvalue 6 (-12) = 1 ∨ frickeEigenvalue 6 (-12) = -1) ∧
      ¬((4 : ℤ) ∣ (∑ δ ∈ (6 : ℕ).divisors, rPinLevelSixNeg δ) ∧
        ((6 : ℕ) = 1 ∨ (∑ δ ∈ (6 : ℕ).divisors, rPinLevelSixNeg δ) = 0)) := by
  refine ⟨rPinLevelSixNeg_weight, ?_, ?_⟩
  · rintro (h | h) <;> rw [frickeEigenvalue_pin_level_six_neg] at h <;>
      rw [inv_eq_iff_eq_inv] at h <;> norm_num at h
  · rw [rPinLevelSixNeg_weight]; rintro ⟨-, h | h⟩ <;> omega

/-- **`SDF-14` PIN G — the remainder convention, carried at THIS node's level; BOTH SIDES TRUE.**

`r = rPinNegFour = (-4)` on `(1:ℕ).divisors = {1}` has `∑ r δ = -4 = 2 · (-2)`, so `k = -2`, and
`frickeEigenvalue 1 (-2) = -1` (`frickeEigenvalue_pin_level_one_weight_neg_two`).  The right-hand
side holds: `4 ∣ -4` and `N = 1`.

Why it is stated here and not left to `SDF-13`.  `SDF-14`'s backward direction reaches `SDF-13`
through the residue `k % 4 = 2`, and at this instance `(-2) % 4 = 2` while
`Int.tmod (-2) 4 = -2` — the last two conjuncts pin both numbers.  Under a TRUNCATING remainder the
route through `SDF-13` would not fire and the backward direction would have no case to take here,
even though the left-hand side is TRUE.  `frickeEigenvalue_eq_neg_one_iff_pin_emod_not_tmod` carries
the same control one node up; this one carries it on a CONCRETE exponent vector, where it is the
weight SUM `-4` rather than the weight `-2` that is visible in the statement. -/
theorem frickeEigenvalue_pm_one_iff_pin_emod_not_tmod :
    (∑ δ ∈ (1 : ℕ).divisors, rPinNegFour δ) = 2 * (-2) ∧
      frickeEigenvalue 1 (-2) = -1 ∧
      ((4 : ℤ) ∣ (∑ δ ∈ (1 : ℕ).divisors, rPinNegFour δ) ∧
        ((1 : ℕ) = 1 ∨ (∑ δ ∈ (1 : ℕ).divisors, rPinNegFour δ) = 0)) ∧
      ((-2 : ℤ) % 4 = 2) ∧ (Int.tmod (-2 : ℤ) 4 = -2) := by
  refine ⟨rPinNegFour_weight, frickeEigenvalue_pin_level_one_weight_neg_two, ?_, by decide,
    by decide⟩
  rw [rPinNegFour_weight]
  exact ⟨by decide, Or.inl rfl⟩

end Sdf14Pins

/-- **`SDF-14`** — the `λ = ±1` criterion, re-parametrised by the WEIGHT SUM:

`(frickeEigenvalue N k = 1 ∨ frickeEigenvalue N k = -1) ↔ (4 ∣ ∑_{δ ∣ N} r δ ∧ (N = 1 ∨ ∑_{δ ∣ N} r δ = 0))`

for `0 < N` and any `r : EtaExp` with `∑_{δ ∣ N} r δ = 2k`.

WHAT THIS NODE IS, AND WHAT IT IS NOT — read this before reporting it.  It is the DISJUNCTION of
`SDF-12` and `SDF-13` with the weight `k` traded for the weight sum `∑ r δ` using the hypothesis
`hk`.  It is NOT new mathematical content, and it is NOT a statement about eta quotients: no
`etaQuotient`, no point `z`, no dual exponent vector and no `IsFrickeSelfDual` hypothesis occurs in
it, and `r` enters ONLY through `hk` — the conclusion constrains the scalar `frickeEigenvalue N k`
and the integer `∑ r δ`, nothing else.  In particular this node is **not** a specialisation of
`etaQuotient_fricke`; that specialisation is `SDF-04`
(`etaQuotient_fricke_selfDual_raw`).  The statement comparator for this node was pointed at
`etaQuotient_fricke` and correctly returned NO_REFERENCE for exactly that reason, as it did for
`SDF-09`, `SDF-10`, `SDF-12` and `SDF-13`.  Its real references are `SDF-12` and `SDF-13`, and
against those it was checked exhaustively (`N ∈ [1, 59]`, `k ∈ [-100, 100]`, zero mismatches) before
being proved.

WHY IT IS WORTH STATING AT ALL.  The weight sum, not the weight, is what an exponent vector
presents: `∑ δ ∈ N.divisors, r δ` is computed from `r` by `decide`, whereas `k` only exists as the
witness of `hk`.  So this is the form in which the `±1` criterion can be applied to a CONCRETE eta
quotient without first solving for `k` — every pin above is exactly that use.

THE ONE STEP THAT IS NOT MECHANICAL.  `4 ∣ ∑ r δ` is `4 ∣ 2k`, which does **not** give `4 ∣ k`
(`k = 2`: `4 ∣ 4` but `4 ∤ 2`).  The backward direction therefore CANNOT route to `SDF-12` alone; it
splits `k % 4 ∈ {0, 2}` and sends residue `0` to `SDF-12` and residue `2` to `SDF-13`.
`frickeEigenvalue_pm_one_iff_pin_neg_one_branch` is that instance as a machine-checked pin: there
`4 ∣ ∑ r δ` holds, `4 ∣ k` fails, and the eigenvalue is `-1`.

PROOF.  Rewrite the two disjuncts by `SDF-12` and `SDF-13` and the sum by `hk`; both directions are
then integer arithmetic and `omega` discharges every divisibility and residue step.  `hN : 0 < N` is
needed only because `SDF-12` and `SDF-13` each take it (and each passes it to `SDF-10`/`SDF-11`,
which ignore it in turn).

NORMALISATION CAVEAT, inherited from `SDF-12` and `SDF-13` and mandatory in any prose report.
`frickeEigenvalue` is the UNNORMALISED constant of `f(-1/(Nz)) = λ · z^k · f(z)` and carries
`N^{k/2}`.  So "`λ = ±1` forces `N = 1` or `∑ r δ = 0`" is a statement about THAT convention and does
NOT contradict the classical fact (Martin, *Multiplicative eta-quotients*, 1996) that multiplicative
eta quotients of level `N > 1` have Fricke eigenvalue `±1`; the classical eigenvalue is the
NORMALISED one, here `i^{-k}` (`SDF-06`), whose `N`-dependence has already cancelled by `SDF-02`.
`frickeEigenvalue_pm_one_iff_pin_level_six` is the pin where the two readings visibly differ.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node relates a complex number attached to
a level and a weight to a divisor-sum condition over `ℤ`.  Persson–Volpato (arXiv:1504.07260) is
cited in this file's header as the ORIGIN of the self-duality question only, at the literature (L)
tier; their CHL / axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and
must never be reported as one. -/
theorem frickeEigenvalue_pm_one_iff {N : ℕ} (hN : 0 < N) {r : EtaExp} {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) :
    (frickeEigenvalue N k = 1 ∨ frickeEigenvalue N k = -1) ↔
      ((4 : ℤ) ∣ (∑ δ ∈ N.divisors, r δ) ∧ (N = 1 ∨ ∑ δ ∈ N.divisors, r δ = 0)) := by
  rw [frickeEigenvalue_eq_one_iff hN k, frickeEigenvalue_eq_neg_one_iff hN k, hk]
  constructor
  · rintro (⟨hdvd, hlev | hlev⟩ | ⟨hemod, hlev⟩)
    · exact ⟨by omega, Or.inl hlev⟩
    · exact ⟨by omega, Or.inr (by omega)⟩
    · exact ⟨by omega, Or.inl hlev⟩
  · rintro ⟨hdvd, hlev | hlev⟩
    · subst hlev
      rcases (by omega : (4 : ℤ) ∣ k ∨ k % 4 = 2) with h | h
      · exact Or.inl ⟨h, Or.inl rfl⟩
      · exact Or.inr ⟨h, rfl⟩
    · have hk0 : k = 0 := by omega
      subst hk0
      exact Or.inl ⟨by omega, Or.inr rfl⟩

/-- **`SDF-14` APPLICATION CHECK — the general lemma reproduces the pins.**  Each conjunct is one
pinned `(N, r, k)`, but REACHED BY RUNNING `frickeEigenvalue_pm_one_iff` there, with that pin's
weight witness supplied as `hk`, rather than by the pin's own route through `frickeEigenvalue_pin_*`
and `decide`.  Every pinned instance is therefore settled twice by routes that share no lemma below
`SDF-DEF-02`, and they agree.

`(6, rPinSix, 12)` is the load-bearing conjunct, `(1, rPinFour, 2)` and `(1, rPinNegFour, -2)` are
the two that run through `SDF-13` rather than `SDF-12`, and `(6, rPinLevelSixNeg, -12)` is where a
proof assuming a non-negative weight sum would break.  `PIN C` (`r ≡ 0`) is omitted here only
because `(0 : EtaExp)` needs its weight witness inline; it is checked in the pin itself. -/
theorem frickeEigenvalue_pm_one_iff_pin_application :
    ((frickeEigenvalue 1 12 = 1 ∨ frickeEigenvalue 1 12 = -1) ↔
        ((4 : ℤ) ∣ (∑ δ ∈ (1 : ℕ).divisors, rPinOne δ) ∧
          ((1 : ℕ) = 1 ∨ (∑ δ ∈ (1 : ℕ).divisors, rPinOne δ) = 0))) ∧
      ((frickeEigenvalue 6 12 = 1 ∨ frickeEigenvalue 6 12 = -1) ↔
        ((4 : ℤ) ∣ (∑ δ ∈ (6 : ℕ).divisors, rPinSix δ) ∧
          ((6 : ℕ) = 1 ∨ (∑ δ ∈ (6 : ℕ).divisors, rPinSix δ) = 0))) ∧
      ((frickeEigenvalue 2 1 = 1 ∨ frickeEigenvalue 2 1 = -1) ↔
        ((4 : ℤ) ∣ (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) ∧
          ((2 : ℕ) = 1 ∨ (∑ δ ∈ (2 : ℕ).divisors, rPinTwo δ) = 0))) ∧
      ((frickeEigenvalue 1 2 = 1 ∨ frickeEigenvalue 1 2 = -1) ↔
        ((4 : ℤ) ∣ (∑ δ ∈ (1 : ℕ).divisors, rPinFour δ) ∧
          ((1 : ℕ) = 1 ∨ (∑ δ ∈ (1 : ℕ).divisors, rPinFour δ) = 0))) ∧
      ((frickeEigenvalue 6 (-12) = 1 ∨ frickeEigenvalue 6 (-12) = -1) ↔
        ((4 : ℤ) ∣ (∑ δ ∈ (6 : ℕ).divisors, rPinLevelSixNeg δ) ∧
          ((6 : ℕ) = 1 ∨ (∑ δ ∈ (6 : ℕ).divisors, rPinLevelSixNeg δ) = 0))) ∧
      ((frickeEigenvalue 1 (-2) = 1 ∨ frickeEigenvalue 1 (-2) = -1) ↔
        ((4 : ℤ) ∣ (∑ δ ∈ (1 : ℕ).divisors, rPinNegFour δ) ∧
          ((1 : ℕ) = 1 ∨ (∑ δ ∈ (1 : ℕ).divisors, rPinNegFour δ) = 0))) :=
  ⟨frickeEigenvalue_pm_one_iff (by decide) rPinOne_weight,
    frickeEigenvalue_pm_one_iff (by decide) rPinSix_weight,
    frickeEigenvalue_pm_one_iff (by decide) (r := rPinTwo) (k := 1) (by decide),
    frickeEigenvalue_pm_one_iff (by decide) (r := rPinFour) (k := 2) (by decide),
    frickeEigenvalue_pm_one_iff (by decide) rPinLevelSixNeg_weight,
    frickeEigenvalue_pm_one_iff (by decide) rPinNegFour_weight⟩



/-! ### `SDF-15` — the NORMALISED eigenvalue is `±1` exactly at EVEN weight

`SDF-08` settled `i^{-k} = 1` (`4 ∣ k`) and `SDF-09` settled `i^{-k} = -1` (`k % 4 = 2`).  Their
DISJUNCTION is the classical "the Fricke eigenvalue is `±1`" condition, and on the residue classes
mod `4` it is `{0, 2}`, i.e. exactly the even `k`.  That is this node.

WHAT `SDF-15` IS NOT — read before quoting it in prose.

* It is a fact about `ℂ` and `ℤ` alone.  There is no level `N`, no exponent vector `r : EtaExp`, no
  `z`, no `ℍₒ`, no `IsFrickeSelfDual` hypothesis and no `etaQuotient` anywhere in the statement, and
  it is NOT a specialisation of `etaQuotient_fricke`.  That specialisation is `SDF-04`.  The
  statement comparator for this node was pointed at `etaQuotient_fricke` and correctly returned
  NO_REFERENCE for exactly that reason, as it did for `SDF-07` … `SDF-14`.
* The identification of `i^{-k}` with "the Fricke eigenvalue of a self-dual eta quotient of weight
  `k`" is `SDF-06` (`etaQuotient_fricke_selfDual_normalized`), not this node.  A prose sentence
  "the Fricke eigenvalue is `±1` iff the weight is even" is `SDF-15` COMPOSED WITH `SDF-06`, and both
  must be cited.
* NORMALISATION CAVEAT, which any prose report must carry.  `i^{-k}` is the NORMALISED eigenvalue —
  `SDF-06` has already divided out `√(N^k)` and `z^k`.  The UNNORMALISED constant is
  `frickeEigenvalue N k`, which carries `N^{k/2}`, and for it "`±1`" is the much tighter condition of
  `SDF-14`, needing `N = 1` or `∑ r δ = 0`.  The two conventions genuinely differ:
  `frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two` is the instance where the normalised
  eigenvalue is `-1` and the unnormalised one is `-6`.  The sentence "the Fricke eigenvalue is `±1`
  iff the weight is even" is TRUE of `i^{-k}` and FALSE of `frickeEigenvalue`; it may be preferred to
  `SDF-14` in prose only when the normalisation is named in the same sentence.
* THE RE-PARAMETRISATION `Even k ↔ 4 ∣ ∑_{δ ∣ N} r δ` IS NOT THIS NODE.  It needs
  `hk : ∑ δ ∈ N.divisors, r δ = 2 * k`, which is not a hypothesis here — `SDF-15` quantifies over a
  bare `k : ℤ`.  The arithmetic is correct (`∑ = 2k` gives `4 ∣ 2k ↔ 2 ∣ k`, all inside `omega`), but
  it is a separate claim requiring a separate node or an added `hk`, exactly as `SDF-14` needed one
  to restate `SDF-12`/`SDF-13` on the weight sum.  Nothing below asserts it.

PHYSICS SCOPE.  Nothing here formalises any physics.  Persson–Volpato (arXiv:1504.07260) is cited in
this file's header as the ORIGIN of the self-duality question only, at the literature (L) tier; their
CHL / axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must never be
reported as one.

DEPENDENCY NOTE.  The DAG entry for this node lists `depends_on: [SDF-08, SDF-09]`.  An earlier draft
listed `[SDF-07]`, which understates it: routing through `SDF-07` directly would re-run the
four-case residue analysis that `SDF-08` and `SDF-09` already carry, including the `Int.emod` /
`Int.tmod` hazard pinned by `I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod`.  The honest proof reuses
the two closed criteria and closes the gap with `omega`.

OUTSIDE LEAN, BEFORE ANY OF THIS WAS STATED.  `i^{-k} ∈ {1, -1} ↔ k` even was checked in exact
Gaussian-integer arithmetic at all 601 weights `k ∈ [-300, 300]`; zero mismatches.
-/

section Sdf15Pins

/-- **`SDF-15` PIN A — weight `k = 12`, both sides TRUE, LHS through the FIRST disjunct.**
`i^{-12} = 1` and `12` is even.

The weight of the `N = 1`, `r = (24)` instance behind the sorry-free `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`) — the `Δ = η²⁴` case the run's pin discipline requires — and also
the weight of the `N = 6` self-dual instance `rPinSix = (1, 11, 11, 1)`.  The value comes from
`I_zpow_neg_twelve`, the `Even` side by `decide` through Mathlib's `Int.even_iff` decidability
instance; the two routes share nothing. -/
theorem I_zpow_neg_pm_one_iff_pin_twelve :
    (I : ℂ) ^ (-(12 : ℤ)) = 1 ∧ Even (12 : ℤ) :=
  ⟨by rw [show (-(12 : ℤ)) = (-12 : ℤ) by norm_num, I_zpow_neg_twelve], by decide⟩

/-- **`SDF-15` PIN B — weight `k = -12`, the NEGATIVE-WEIGHT pin, both sides TRUE.**
`i^{-(-12)} = i^{12} = 1` and `-12` is even.

The weight of `selfDual_eigen_pin_level_six_neg` (`SDF-05` PIN E), a genuine `N > 1` self-dual vector.
Reached through `I_zpow_twelve` after `neg_neg`, i.e. by a different value lemma than PIN A, so the
two do not share a route.  A statement or proof that assumed `0 ≤ k` would fail here. -/
theorem I_zpow_neg_pm_one_iff_pin_neg_twelve :
    (I : ℂ) ^ (-(-12 : ℤ)) = 1 ∧ Even (-12 : ℤ) :=
  ⟨by rw [neg_neg, I_zpow_twelve], by decide⟩

/-- **`SDF-15` PIN C — the degenerate weight `k = 0` (`r ≡ 0`, `selfDual_eigen_pin_zero_exp`).**
`i^0 = 1` and `0` is even.

DEGENERATE AND GUARDED AS SUCH: after `neg_zero` the left conjunct is `zpow_zero`, so this pin
constrains essentially nothing.  It is here because the degenerate `r ≡ 0` case belongs to the
required pin set, not because it is evidence. -/
theorem I_zpow_neg_pm_one_iff_pin_zero :
    (I : ℂ) ^ (-(0 : ℤ)) = 1 ∧ Even (0 : ℤ) :=
  ⟨by rw [neg_zero, _root_.zpow_zero], by decide⟩

/-- **`SDF-15` PIN D — weight `k = 2`.  THE LOAD-BEARING PIN: the LHS holds only through its SECOND
disjunct.**  `i^{-2} = -1`, which is NOT `1`, and `2` is even.

This is the weight of `selfDual_pin_eigenvalue_neg_one` (`f = η⁴` at level one, eigenvalue `-1`), the
instance computed by hand from `η(-1/z)⁴ = (-i z)² η(z)⁴ = -z² η(z)⁴`.  It is what makes the
disjunction in `SDF-15` load-bearing rather than decorative: a version of this node stated with
`i^{-k} = 1` alone on the left — i.e. `SDF-08`'s left-hand side — would assert `i^{-2} = 1` at an
even weight and is refuted here through `Complex.one_re`.  The first two conjuncts record the value
and the refutation separately, so the pin is not merely a negation. -/
theorem I_zpow_neg_pm_one_iff_pin_two :
    (I : ℂ) ^ (-(2 : ℤ)) = -1 ∧ (I : ℂ) ^ (-(2 : ℤ)) ≠ 1 ∧ Even (2 : ℤ) := by
  have hval : (I : ℂ) ^ (-(2 : ℤ)) = -1 := by
    rw [show (-(2 : ℤ)) = (-2 : ℤ) by norm_num, I_zpow_neg_two]
  refine ⟨hval, ?_, by decide⟩
  rw [hval]
  intro h
  have hre := congrArg Complex.re h
  simp only [Complex.neg_re, Complex.one_re] at hre
  norm_num at hre

/-- **`SDF-15` PIN E — weight `k = 15`, THE ODD PIN NO `±1` COINCIDENCE CAN FAKE.**  `i^{-15} = i`,
which is neither `1` nor `-1`, and `15` is not even.

The value is obtained from `I_zpow_emod_pin_neg_fifteen` (whose own route runs through `zpow_neg`,
`i^{15} = -i` and `Complex.inv_I`), sharing no lemma with `SDF-08`, `SDF-09` or the `omega` step of
the general proof below.  The `≠ 1` refutation compares IMAGINARY parts and the `≠ -1` refutation
compares REAL parts, so neither can be an artefact of `±1` bookkeeping.  The first conjunct records
the value itself.  This is the pin that a statement with `True`, or with any condition weaker than
parity, on the right-hand side would fail. -/
theorem I_zpow_neg_pm_one_iff_pin_fifteen :
    (I : ℂ) ^ (-(15 : ℤ)) = I ∧ (I : ℂ) ^ (-(15 : ℤ)) ≠ 1 ∧
      (I : ℂ) ^ (-(15 : ℤ)) ≠ -1 ∧ ¬ Even (15 : ℤ) := by
  have hval : (I : ℂ) ^ (-(15 : ℤ)) = I := by
    rw [show (-(15 : ℤ)) = (-15 : ℤ) by norm_num, I_zpow_emod_pin_neg_fifteen,
        show ((-15 : ℤ) % 4) = 1 by decide, _root_.zpow_one]
  refine ⟨hval, ?_, ?_, by decide⟩
  · rw [hval]
    intro h
    have him := congrArg Complex.im h
    simp only [Complex.I_im, Complex.one_im] at him
    norm_num at him
  · rw [hval]
    intro h
    have hre := congrArg Complex.re h
    simp only [Complex.I_re, Complex.neg_re, Complex.one_re] at hre
    norm_num at hre

/-- **`SDF-15` PIN F — weight `k = 1`, the OTHER odd residue class.**  `i^{-1} = -i`, neither `1` nor
`-1`, and `1` is not even.

The weight of `selfDual_eigen_pin_level_four_neg` (level four, eigenvalue `-2i`).  PIN E sits at
`(-k) % 4 = 1` and this one at `(-k) % 4 = 3`, so between them the two odd residue classes are both
covered, and by DIFFERENT value lemmas (`I_zpow_emod_pin_neg_fifteen` there, `I_zpow_neg_one` here).
Both refutations go through `Complex.I_im`. -/
theorem I_zpow_neg_pm_one_iff_pin_one :
    (I : ℂ) ^ (-(1 : ℤ)) = -I ∧ (I : ℂ) ^ (-(1 : ℤ)) ≠ 1 ∧
      (I : ℂ) ^ (-(1 : ℤ)) ≠ -1 ∧ ¬ Even (1 : ℤ) := by
  have hval : (I : ℂ) ^ (-(1 : ℤ)) = -I := by
    rw [show (-(1 : ℤ)) = (-1 : ℤ) by norm_num, I_zpow_neg_one]
  refine ⟨hval, ?_, ?_, by decide⟩
  · rw [hval]
    intro h
    have him := congrArg Complex.im h
    simp only [Complex.neg_im, Complex.I_im, Complex.one_im] at him
    norm_num at him
  · rw [hval]
    intro h
    have him := congrArg Complex.im h
    simp only [Complex.neg_im, Complex.I_im, Complex.one_im] at him
    norm_num at him

/-- **`SDF-15` NEGATIVE CONTROL 1 — NEITHER disjunct alone is equivalent to `Even k`.**
At `k = 2` the weight is even but `i^{-2} ≠ 1`; at `k = 12` the weight is even but `i^{-12} ≠ -1`.

So `SDF-15` is not a restatement of `SDF-08`, and it is not a restatement of `SDF-09`: each of those
two criteria is STRICTLY STRONGER than "even", and it is only their disjunction that matches.  The
two witnesses are the two weights that carry this file's two hand-computed eigenvalues (`Δ = η²⁴` at
`k = 12`, eigenvalue `1`; `η⁴` at `k = 2`, eigenvalue `-1`), so the control is anchored to instances
and not merely to residue arithmetic. -/
theorem I_zpow_neg_pm_one_iff_pin_neither_disjunct_alone :
    ((I : ℂ) ^ (-(2 : ℤ)) ≠ 1 ∧ Even (2 : ℤ)) ∧
      ((I : ℂ) ^ (-(12 : ℤ)) ≠ -1 ∧ Even (12 : ℤ)) := by
  refine ⟨⟨?_, by decide⟩, ⟨?_, by decide⟩⟩
  · rw [show (-(2 : ℤ)) = (-2 : ℤ) by norm_num, I_zpow_neg_two]
    intro h
    have hre := congrArg Complex.re h
    simp only [Complex.neg_re, Complex.one_re] at hre
    norm_num at hre
  · rw [show (-(12 : ℤ)) = (-12 : ℤ) by norm_num, I_zpow_neg_twelve]
    intro h
    have hre := congrArg Complex.re h
    simp only [Complex.neg_re, Complex.one_re] at hre
    norm_num at hre

/-- **`SDF-15` NEGATIVE CONTROL 2 — `Even k` sits STRICTLY between the two component criteria, on the
integer side alone.**  `2` is even but `4 ∤ 2`; `12` is even but `12 % 4 ≠ 2`.

The companion to NEGATIVE CONTROL 1: that one refutes the two candidate left-hand sides in `ℂ`, this
one refutes the two candidate right-hand sides in `ℤ`, by `decide` alone.  Together they show that
neither `4 ∣ k` nor `k % 4 = 2` may be substituted for `Even k` in this node's statement. -/
theorem I_zpow_neg_pm_one_iff_pin_even_strictly_between :
    (Even (2 : ℤ) ∧ ¬ ((4 : ℤ) ∣ (2 : ℤ))) ∧
      (Even (12 : ℤ) ∧ ¬ ((12 : ℤ) % 4 = 2)) := by decide

end Sdf15Pins

/-- **`SDF-15` — the `k`/`-k` bridge, and why this node has no `k`/`-k` hazard.**
`Even (-k) ↔ Even k`.

`SDF-09` carries a genuine hazard here: `k % 4` and `(-k) % 4` are DIFFERENT functions of `k`
(`I_zpow_neg_eq_neg_one_iff_pin_k_not_neg_k`), agreeing only on the residue class `2`, so stating
that criterion on the WEIGHT rather than on the EXPONENT was a real choice.  Parity has no such
hazard — it is invariant under negation — and this lemma records that, by `Int.even_iff` and `omega`,
so the absence of the hazard is a checked fact of this section rather than an assumption. -/
theorem I_zpow_neg_pm_one_iff_even_neg (k : ℤ) : Even (-k) ↔ Even k := by
  rw [Int.even_iff, Int.even_iff]
  omega

/-- **`SDF-15`.**  `i^{-k} ∈ {1, -1}` exactly when the weight `k` is EVEN.

`i^{-k}` is the NORMALISED Fricke eigenvalue of `SDF-06`
(`etaQuotient_fricke_selfDual_normalized`), whose constant is exactly this root of unity; composing
this node with `SDF-06` gives "a Fricke-self-dual eta quotient of even weight is a `(±1)`-eigenform
of the normalised Fricke involution, and of no other weight".  BOTH nodes must be cited for that
sentence — see the section header above for what `SDF-15` does and does not say on its own, in
particular the NORMALISATION CAVEAT (`frickeEigenvalue`, the UNNORMALISED constant, is `±1` only
under the far tighter condition of `SDF-14`) and the fact that the re-parametrisation
`Even k ↔ 4 ∣ ∑_{δ ∣ N} r δ` needs an `hk` hypothesis this statement does not carry.

PROOF.  `SDF-08` (`I_zpow_neg_eq_one_iff`) rewrites the first disjunct to `4 ∣ k`, `SDF-09`
(`I_zpow_neg_eq_neg_one_iff`) rewrites the second to `k % 4 = 2`, and `Int.even_iff` rewrites the
right-hand side to `k % 2 = 0`.  What remains, `(4 ∣ k ∨ k % 4 = 2) ↔ k % 2 = 0`, is inside `omega`'s
fragment — numeral divisibility and numeral `Int.emod` both are — and needs no case split written by
hand.  The four-case residue analysis is NOT repeated here; it is already carried, once each, by
`SDF-08` and `SDF-09`, together with the `Int.emod` / `Int.tmod` hazard that
`I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod` pins.

The six weight pins above are stated and proved BEFORE this theorem, so Lean's scoping forbids them
from using it; `I_zpow_neg_pm_one_iff_pin_application` re-derives all six by RUNNING this lemma at
those weights, so every pinned weight is settled twice by routes that do not meet. -/
theorem I_zpow_neg_pm_one_iff (k : ℤ) :
    ((I : ℂ) ^ (-k) = 1 ∨ (I : ℂ) ^ (-k) = -1) ↔ Even k := by
  rw [I_zpow_neg_eq_one_iff, I_zpow_neg_eq_neg_one_iff, Int.even_iff]
  omega

/-- **`SDF-15` APPLICATION CHECK — the general lemma reproduces the pins.**  Each conjunct is the
statement of a pin above, but REACHED BY RUNNING `I_zpow_neg_pm_one_iff` at that weight, so every
pinned weight is settled twice by routes that share no lemma below `SDF-07`.

`12` is the `Δ = η²⁴` / level-six weight, `-12` the negative-weight instance, `0` the degenerate
`r ≡ 0` case, `2` the load-bearing `-1` branch (`η⁴`), and `15` and `1` the two ODD residue classes,
where the eigenvalue leaves the reals entirely. -/
theorem I_zpow_neg_pm_one_iff_pin_application :
    (((I : ℂ) ^ (-(12 : ℤ)) = 1 ∨ (I : ℂ) ^ (-(12 : ℤ)) = -1) ↔ Even (12 : ℤ)) ∧
      (((I : ℂ) ^ (-(-12 : ℤ)) = 1 ∨ (I : ℂ) ^ (-(-12 : ℤ)) = -1) ↔ Even (-12 : ℤ)) ∧
      (((I : ℂ) ^ (-(0 : ℤ)) = 1 ∨ (I : ℂ) ^ (-(0 : ℤ)) = -1) ↔ Even (0 : ℤ)) ∧
      (((I : ℂ) ^ (-(2 : ℤ)) = 1 ∨ (I : ℂ) ^ (-(2 : ℤ)) = -1) ↔ Even (2 : ℤ)) ∧
      (((I : ℂ) ^ (-(15 : ℤ)) = 1 ∨ (I : ℂ) ^ (-(15 : ℤ)) = -1) ↔ Even (15 : ℤ)) ∧
      (((I : ℂ) ^ (-(1 : ℤ)) = 1 ∨ (I : ℂ) ^ (-(1 : ℤ)) = -1) ↔ Even (1 : ℤ)) :=
  ⟨I_zpow_neg_pm_one_iff 12, I_zpow_neg_pm_one_iff (-12), I_zpow_neg_pm_one_iff 0,
    I_zpow_neg_pm_one_iff 2, I_zpow_neg_pm_one_iff 15, I_zpow_neg_pm_one_iff 1⟩

/-! ### `SDF-16` — `IsFrickeSelfDual` is DECIDABLE

An `instance` making `IsFrickeSelfDual N r` a `Decidable` proposition, so that bare `decide` closes
self-duality goals.

WHAT THIS NODE IS.  Pure ERGONOMICS, and it must be reported as nothing more.  `IsFrickeSelfDual N r`
unfolds to `∀ δ ∈ N.divisors, r δ = r (N / δ)`, a bounded quantifier over a `Finset` with a
decidable body, so Mathlib's `Finset.decidableBAll` already decides it — the only thing missing was
that the `def` is not itself an instance, so instance synthesis did not see through it.  The whole
node is `inferInstanceAs` at the unfolded form; the `def` unfolds at default transparency and the
kernel reduces the result.  Net content: one declaration, and one `unfold` removed from the front of
each `decide` proof.

WHAT THIS NODE IS **NOT** — two overclaims that were caught by this run's statement comparator and
must never be restated.

(i) It is NOT what lets the pins of this file discharge their hypotheses by `decide`.  Every
`selfDual_cond_pin_*` above discharges by `unfold IsFrickeSelfDual; decide`, which needs no instance
at all, and every one of them was `sorry`-free before this node existed.  Nothing above this line
depends on it; the pins were deliberately left as they stand so that the file does not acquire a
dependency on an ergonomics node.

(ii) It is NOT what makes the self-duality hypothesis non-vacuous.  Non-vacuity was already
machine-checked, by `not_selfDual_pin_asymmetric` (`r = (2, 0)` at `N = 2`, the `fricke_dual_pin`
vector) and, more sharply, by `not_selfDual_pin_mispaired` (`r = (1, 11, 1, 11)` at `N = 6`, same
weight sum `24`, invariant under the WRONG involution `1 ↔ 3`, `2 ↔ 6`) — both `sorry`-free, both
guarded in `FinalCheck` section `SdfDef01`, and both independent of this instance.  A node that
claimed otherwise would be claiming credit for `SDF-DEF-01`'s work.

WHY IT IS NOT VACUOUS AS A NODE.  Verified this run: with the instance removed, `IsFrickeSelfDual 6
rPinSix := by decide`, `¬ IsFrickeSelfDual 2 rPinAsym := by decide` and
`decide (IsFrickeSelfDual 6 rPinSix) = true := rfl` all fail with `failed to synthesize
Decidable (IsFrickeSelfDual …)` — three errors, no other cause — so the instance is a real delta and
not a restatement of something already synthesisable.

THE ONLY FAILURE MODE, and what pins it.  A `Decidable` instance is proof-carrying: it cannot
disagree with its proposition (`decide_eq_true_iff` is a theorem, not a convention), so this node
CANNOT be wrong about which vectors are self-dual.  What it can be is INERT — an instance that
elaborates but whose `Decidable` term does not reduce in the kernel, e.g. one routed through
`Classical.dec`, which would typecheck and then make every `decide` fail or, worse, succeed only
through `native_decide`.  That is what `decidableIsFrickeSelfDual_pin_bool_values` exists for: it
asserts the `Bool` value of `decide (IsFrickeSelfDual …)` at six concrete instances **by `rfl`**,
i.e. by kernel reduction, so a non-reducing instance is refuted rather than tolerated.  `decide` is
used throughout, never `native_decide`; no `Lean.ofReduceBool` enters any footprint.

COMPUTED OUTSIDE LEAN FIRST, this session, in exact integer arithmetic, and only then asserted here
(`divisors 1 = [1]`, `divisors 2 = [1,2]`, `divisors 4 = [1,2,4]`, `divisors 6 = [1,2,3,6]`, each
vector printed beside its dual):

```
N=1  rPinOne           r=[24]            dual=[24]            self-dual   ∑ r δ = 24  (k = 12)
N=6  rPinSix           r=[1,11,11,1]     dual=[1,11,11,1]     self-dual   ∑ r δ = 24  (k = 12)
N=6  r ≡ 0             r=[0,0,0,0]       dual=[0,0,0,0]       self-dual   ∑ r δ = 0   (k = 0)
N=4  rPinLevelFourNeg  r=[-2,6,-2]       dual=[-2,6,-2]       self-dual   ∑ r δ = 2   (k = 1)
N=2  rPinAsym          r=[2,0]           dual=[0,2]           NOT         ∑ r δ = 2   (k = 1)
N=6  rPinSixMispaired  r=[1,11,1,11]     dual=[11,1,11,1]     NOT         ∑ r δ = 24  (k = 12)
```

No pin was adjusted to match a proof; no pin disagreed with the hand computation.

THE THREE REGIMES this run's discipline requires are the first three rows: `N = 1` with `r = (24)`
and `k = 12`, the instance underlying the already sorry-free `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`); a genuine `N > 1` self-dual vector, `rPinSix` at `N = 6`, which
is non-constant (`rPinSix_nonconstant`) and is therefore the only positive row a wrong `δ ↔ N/δ`
pairing could fail; and the degenerate `r ≡ 0`.  The fourth row adds the only vector with NEGATIVE
entries and the only `N > 1` level with a self-paired divisor (`4 / 2 = 2`).

PHYSICS SCOPE.  Nothing here formalises any physics.  This node states that a decidable arithmetic
condition on a function `ℕ → ℤ` over a finite set of divisors is decidable.  Persson–Volpato
(arXiv:1504.07260) is cited in this file's header as the ORIGIN of the self-duality question only,
at the literature (L) tier; their CHL / axio-dilaton S-duality claim is NOT a Lean statement
anywhere in this library and must never be reported as one.

NAMING.  "self-dual" / "Fricke-symmetric", never "balanced" — see this file's header; `balanced` is
taken in `EtaQuotientModularity.lean` by the unrelated `Int.bmod` lemma `exists_balanced_add`
(`F3.2-B1`), and is also Persson–Volpato's word for the self-duality condition. -/

/-- **`SDF-16`.**  `IsFrickeSelfDual N r` is decidable, by `Finset.decidableBAll` on the bounded
quantifier it unfolds to.

ERGONOMICS ONLY.  With this in scope, `by decide` closes a self-duality goal without the leading
`unfold IsFrickeSelfDual` that every `selfDual_cond_pin_*` above uses.  It is NOT what makes those
pins work (they need no instance) and NOT what makes the self-duality hypothesis non-vacuous (that
is `not_selfDual_pin_asymmetric` and `not_selfDual_pin_mispaired`).  See the section docstring.

`decide`, never `native_decide`: the footprint stays `[propext, Classical.choice, Quot.sound]` and
no `Lean.ofReduceBool` is introduced.  That the instance genuinely REDUCES in the kernel — the one
way a proof-carrying `Decidable` instance can still be useless — is pinned by
`decidableIsFrickeSelfDual_pin_bool_values`. -/
instance decidableIsFrickeSelfDual (N : ℕ) (r : EtaExp) :
    Decidable (IsFrickeSelfDual N r) :=
  inferInstanceAs (Decidable (∀ δ ∈ N.divisors, r δ = r (N / δ)))

/-- **`SDF-16` PIN A — level one, `r = (24)` (`Δ = η²⁴`), closed by BARE `decide`.**
`divisors 1 = {1}`, `1 / 1 = 1`, `r 1 = 24 = r (1/1)`.

DEGENERATE AS EVIDENCE ABOUT SELF-DUALITY, recorded so it is not oversold: at `N = 1` the only
divisor is its own dual, so `IsFrickeSelfDual 1 r` holds for EVERY `r`.  What it pins is that the
instance elaborates and reduces at the `(N, r, k) = (1, 24, 12)` instance underlying the already
sorry-free `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`).

The difference from `selfDual_cond_pin_level_one`, which asserts the same proposition, is the
TACTIC: there `unfold IsFrickeSelfDual; decide`, here `decide` alone.  That difference is the entire
content of this node. -/
theorem decidableIsFrickeSelfDual_pin_level_one : IsFrickeSelfDual 1 rPinOne := by decide

/-- **`SDF-16` PIN B — level six, `r = (1, 11, 11, 1)` on `(1, 2, 3, 6)`.  THE LOAD-BEARING PIN.**
Computed outside Lean first: `δ ↦ 6/δ` pairs `1 ↔ 6` and `2 ↔ 3`, the vector reads `[1, 11, 11, 1]`
and its dual reads `[1, 11, 11, 1]` — equal, so self-dual, with `∑ r δ = 24 = 2 · 12`.

The only positive pin here with `N > 1` AND a non-constant exponent vector
(`rPinSix_nonconstant`), hence the only one a wrong `δ ↔ N/δ` pairing could fail: had the predicate
been `r δ = r (N * δ)`, or the involution mis-paired as `2 ↔ 6`, this would be false while PINs A, C
and D stayed true.  Closed by BARE `decide`, so it also witnesses that the instance reduces on a
level with four divisors and two nontrivial orbits. -/
theorem decidableIsFrickeSelfDual_pin_level_six : IsFrickeSelfDual 6 rPinSix := by decide

/-- **`SDF-16` PIN C — the degenerate vector `r ≡ 0` at level six, by BARE `decide`.**
Every value and every dual value is `0`.

DEGENERATE BY CONSTRUCTION: true at every `N`.  It is a floor — it certifies the predicate is not
accidentally EMPTY — and it is not evidence about the divisor involution.  Note the contrast with
`selfDual_cond_pin_zero_exp`, which proves the same proposition by `fun _ _ => rfl` and so depends
on no axioms at all; here the route is through the instance and the kernel actually evaluates
`Nat.divisors 6` and `(0 : EtaExp)`, which is what is being pinned. -/
theorem decidableIsFrickeSelfDual_pin_zero_exp : IsFrickeSelfDual 6 (0 : EtaExp) := by decide

/-- **`SDF-16` PIN D — level four, `r = (-2, 6, -2)` on `(1, 2, 4)`, by BARE `decide`.**
Computed outside Lean first: `4/1 = 4` and `r 4 = -2 = r 1`; `4/2 = 2` and `r 2 = 6 = r 2`;
`4/4 = 1`.  Self-dual, with `∑ r δ = 2 = 2 · 1`.

Two things no other pin in this section covers: NEGATIVE exponent entries, and a level `N > 1` with
a divisor that is its OWN dual (`4 / 2 = 2`), where the condition degenerates to `r 2 = r 2` on one
orbit while remaining a genuine constraint on the other.  A predicate mis-stated so as to exclude
self-paired divisors — e.g. quantified over `δ` with `δ ≠ N / δ` — would still satisfy PINs A, B and
C and would satisfy this one too, so this row is not a refutation of that error; it is included
because it is the arithmetic regime (`zpow` with negative exponents) that `prod_zpow_selfDual`
above actually needs, and it is the same vector `rPinLevelFourNeg` used there. -/
theorem decidableIsFrickeSelfDual_pin_level_four_neg :
    IsFrickeSelfDual 4 rPinLevelFourNeg := by decide

/-- **`SDF-16` NEGATIVE-SIDE PIN — the instance reduces on a FALSE instance too.**
`r = (1, 11, 1, 11)` on `(1, 2, 3, 6)` is NOT Fricke-self-dual at level six: under `δ ↦ 6/δ` it
reads `[1, 11, 1, 11]` while its dual reads `[11, 1, 11, 1]`, different at every divisor.

Why this vector and not `rPinAsym`: it carries the SAME weight normalisation as PIN B
(`∑ r δ = 24 = 2·12`) and IS invariant under the WRONG involution `1 ↔ 3`, `2 ↔ 6`, so it is the
sharper control.  `¬ IsFrickeSelfDual 2 rPinAsym` is NOT restated here — it already exists as
`not_selfDual_pin_asymmetric` above and is reused verbatim in
`decidableIsFrickeSelfDual_pin_level_zero_vacuous`.

What this pin adds beyond `not_selfDual_pin_mispaired`, which asserts the same proposition, is again
only the TACTIC: bare `decide`, so the instance is shown to produce `isFalse` and not merely to
reduce on propositions that happen to be true. -/
theorem decidableIsFrickeSelfDual_pin_mispaired :
    ¬ IsFrickeSelfDual 6 rPinSixMispaired := by decide

/-- **`SDF-16` REDUCTION PIN — the `Bool` values, by `rfl`.  The pin that can actually fail.**

Each conjunct asserts the value of `decide (IsFrickeSelfDual N r)` — the `Bool` the instance
computes — at one row of the hand computation in the section docstring, and each is closed by `rfl`,
i.e. by KERNEL REDUCTION of the instance term rather than by a tactic that could route around it.

This is the only pin in this section that a wrong instance could fail.  An instance is
proof-carrying, so it cannot disagree with the proposition it decides; what it can be is INERT —
`Classical.dec (IsFrickeSelfDual N r)` typechecks against this node's statement and reduces to
nothing, and an instance built from `native_decide` would move the whole thing onto
`Lean.ofReduceBool`.  Both are refuted here: `rfl` forces the kernel to evaluate `Nat.divisors N`
and the exponent vector at every divisor, at four TRUE instances and two FALSE ones, and the
footprint stays `[propext, Classical.choice, Quot.sound]`.

The six values were fixed outside Lean before this statement was written; the inverted forms are
must-fail items in `verification/Sdf16PinNegControl.lean`. -/
theorem decidableIsFrickeSelfDual_pin_bool_values :
    decide (IsFrickeSelfDual 1 rPinOne) = true ∧
      decide (IsFrickeSelfDual 6 rPinSix) = true ∧
      decide (IsFrickeSelfDual 6 (0 : EtaExp)) = true ∧
      decide (IsFrickeSelfDual 4 rPinLevelFourNeg) = true ∧
      decide (IsFrickeSelfDual 6 rPinSixMispaired) = false ∧
      decide (IsFrickeSelfDual 2 rPinAsym) = false :=
  ⟨rfl, rfl, rfl, rfl, rfl, rfl⟩

/-- **`SDF-16` `N = 0` TRAP — the instance reduces there, and the predicate is VACUOUSLY TRUE.**
`Nat.divisors 0 = ∅` in Mathlib, so `IsFrickeSelfDual 0 r` holds for EVERY `r` — including
`rPinAsym`, the very vector that is NOT self-dual at `N = 2`.  Both halves are asserted here at the
same vector so the contrast is machine-checked rather than remarked.

This is why every `SDF-*` lemma above carries `hN : 0 < N`, and it is a hazard specific to a
DECIDABLE reading of the condition: `by decide` will cheerfully close `IsFrickeSelfDual 0 r` for any
concrete `r`, so a future pin that forgot its positivity hypothesis would pass.  Recorded as a trap,
not as evidence for anything.

The second conjunct is `not_selfDual_pin_asymmetric` REUSED, not re-decided — this file states that
refutation once. -/
theorem decidableIsFrickeSelfDual_pin_level_zero_vacuous :
    IsFrickeSelfDual 0 rPinAsym ∧ ¬ IsFrickeSelfDual 2 rPinAsym :=
  ⟨by decide, not_selfDual_pin_asymmetric⟩

/-! ### `SDF-PIN-01` — the level-one pin's REACH, stated as theorems rather than as a caveat

`selfDual_raw_pin_level_one_is_eta_S` (above) carries the level-one instance of `SDF-04` down to
`η(-1/z)²⁴ = z¹² η(z)²⁴`, the `S`-transformation law of the discriminant.  That conclusion is also
`eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`, sorry-free) and, a second time there,
MATHLIB's `discriminant_S_invariant` — and the agreement is genuine: walking the KERNEL TERM of
`selfDual_raw_pin_level_one_is_eta_S` transitively (this run, not by reading the source text) finds
`etaQuotient_fricke`, `etaQuotient_congr_divisors`, `selfDual_cond_pin_level_one`, `rPinOne_weight`
and `IsFrickeSelfDual`, and finds NEITHER `eta_S_via_fricke` NOR `discriminant_S_invariant`.

What that pin is NOT is evidence about any component of the constant `λ = i^{-k} · N^k · s^{-1/2}`.
The docstrings above say so in prose.  The four theorems here say so in Lean, so that a reader of the
node ledger alone cannot mistake a floor for a discriminating test.  Each exhibits a DIFFERENT wrong
constant the level-one instance would still accept:

* `..._no_evidence_I_sign` — the SIGN of the `i`-exponent is invisible: `i^{-12} = i^{+12}`.
* `..._no_evidence_level_pow` — the POWER of `N` is invisible: every `zpow` of `(1 : ℂ)` is `1`, so
  `N^k`, `N^{2k}` and `N^{-k}` agree here.
* `..._no_evidence_radicand` — the SIDE OF THE FRACTION `√s` sits on is invisible: `s = 1`, and
  `(1 : ℂ)⁻¹ = 1`.
* `..._no_evidence_involution` — the divisor involution `δ ↦ N/δ` is invisible: it is the IDENTITY
  on `Nat.divisors 1`, so a transposed pairing could not be seen.

The discrimination therefore lives elsewhere, and the last two theorems check that it really is
there rather than asserting it: `selfDual_pin_level_six_evidence_contrast` refutes three of the four
degeneracies at `N = 6` (where `selfDual_raw_pin_level_six`, `prod_zpow_pin_mispaired_ne` and
`not_selfDual_pin_mispaired` do the work), and `selfDual_pin_weight_one_evidence_I_sign` refutes the
fourth at ODD weight — note it is NOT refuted at `k = 12`, nor at any even `k`, since `i^{-k} = i^k`
whenever `k` is even; it is `k = 1` (the `N = 4` pin, `frickeEigenvalue 4 1 = -(2 i)`) that separates
`i^{-k}` from `i^{k}`.

NAMING: "self-dual" / "Fricke-symmetric" throughout, never "balanced" — see this module's header. -/

section SdfPin01Reach

/-- **`SDF-PIN-01` DEGENERACY 1 of 4 — the level-one pin cannot see the SIGN of the `i`-exponent.**
`i^{-12} = 1 = i^{+12}`, so a constant assembled with `i^{k}` in place of `i^{-k}` reproduces the
level-one instance exactly.  Both sides are taken from `SDF-DEF-02`'s already-proved value pins
(`I_zpow_neg_twelve`, `I_zpow_twelve`), so this is an agreement of two computations, not one. -/
theorem selfDual_pin_level_one_no_evidence_I_sign :
    (I : ℂ) ^ (-12 : ℤ) = (I : ℂ) ^ (12 : ℤ) := by
  rw [I_zpow_neg_twelve, I_zpow_twelve]

/-- **`SDF-PIN-01` DEGENERACY 2 of 4 — the level-one pin cannot see the POWER of `N`.**  At `N = 1`
the three candidate exponents `k = 12`, `2k = 24` and `-k = -12` all give `1`, so `N^k`, `N^{2k}` and
`N^{-k}` are indistinguishable here.  Stated as three separate conjuncts so it is the AGREEMENT of
the three that is checked, not one claim written once. -/
theorem selfDual_pin_level_one_no_evidence_level_pow :
    ((1 : ℕ) : ℂ) ^ (12 : ℤ) = 1 ∧ ((1 : ℕ) : ℂ) ^ (24 : ℤ) = 1
      ∧ ((1 : ℕ) : ℂ) ^ (-12 : ℤ) = 1 := by
  norm_num

/-- **`SDF-PIN-01` DEGENERACY 3 of 4 — the level-one pin cannot see which SIDE of the fraction `√s`
sits on.**  The radicand is `s = ∏_{δ ∣ 1} δ^{r δ} = 1²⁴ = 1`, so `√s = 1` and `(√s)⁻¹ = √s`: a
constant carrying `√s` instead of `(√s)⁻¹` reproduces the level-one instance exactly.  The second
conjunct is the inversion stated on the SAME expression the general constant uses, so it is not a
restatement of `Real.sqrt_one`. -/
theorem selfDual_pin_level_one_no_evidence_radicand :
    (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) = 1
    ∧ ((Real.sqrt (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) : ℝ) : ℂ)⁻¹
        = ((Real.sqrt (∏ δ ∈ (1 : ℕ).divisors, (δ : ℝ) ^ (rPinOne δ)) : ℝ) : ℂ) := by
  rw [show (1 : ℕ).divisors = {1} from by decide]
  norm_num [rPinOne, Real.sqrt_one]

/-- **`SDF-PIN-01` DEGENERACY 4 of 4 — the level-one pin cannot see the divisor INVOLUTION.**
`δ ↦ 1/δ` is the identity on `Nat.divisors 1 = {1}`, so `IsFrickeSelfDual 1 r` holds for every `r`
and the collapse step `SDF-01` performs is a syntactic no-op.  A statement that had transposed the
pairing `δ ↔ N/δ` would still close the level-one pin.  Contrast `not_selfDual_pin_mispaired` at
`N = 6`, whose mis-paired vector carries the same weight `∑ r δ = 24`. -/
theorem selfDual_pin_level_one_no_evidence_involution :
    ∀ δ ∈ (1 : ℕ).divisors, (1 : ℕ) / δ = δ := by decide

/-- **`SDF-PIN-01` CONTRAST — three of the four degeneracies FAIL at `N = 6`.**  `6¹² ≠ 1`,
`∏ δ^{rPinSix δ} = 2176782336 ≠ 1` (via `SDF-02`'s literal-value pin, not recomputed), and
`δ ↦ 6/δ` is not the identity on `{1, 2, 3, 6}`.  So the claim "the discrimination lives at `N > 1`"
is machine-checked here rather than asserted in a docstring. -/
theorem selfDual_pin_level_six_evidence_contrast :
    ((6 : ℕ) : ℂ) ^ (12 : ℤ) ≠ 1
    ∧ (∏ δ ∈ (6 : ℕ).divisors, (δ : ℝ) ^ (rPinSix δ)) ≠ 1
    ∧ ¬ (∀ δ ∈ (6 : ℕ).divisors, (6 : ℕ) / δ = δ) := by
  refine ⟨by norm_num, ?_, by decide⟩
  rw [prod_zpow_pin_level_six_value]
  norm_num

/-- **`SDF-PIN-01` CONTRAST — the fourth degeneracy fails only at ODD weight.**  `i^{-1} = -i ≠ i`,
so the sign of the `i`-exponent IS visible at `k = 1` — the `N = 4`, `r = (-2, 6, -2)` pin, where
`frickeEigenvalue 4 1 = -(2 i)` (`frickeEigenvalue_pin_level_four`).  Recorded because raising the
LEVEL does not fix this degeneracy: `i^{-k} = i^{k}` for every EVEN `k`, `k = 12` included, so
`selfDual_pin_level_six_evidence_contrast` above does not cover it. -/
theorem selfDual_pin_weight_one_evidence_I_sign :
    (I : ℂ) ^ (-1 : ℤ) ≠ (I : ℂ) ^ (1 : ℤ) := by
  rw [I_zpow_neg_one, zpow_one]
  norm_num [Complex.ext_iff]

end SdfPin01Reach

/-! ## `SDF-PIN-02`'s REACH — the two-route agreement, made a build obligation

`selfDual_eigen_pin_level_two_eta` (in `section Sdf05Pins` above) states

```
η(-1/(2z)) · η(2 · (-1/(2z)))  =  -i·√2 · z · (η(z) · η(2z))
```

and `fricke_level_two_pin` (`EtaQuotientModularity.lean:2285`, sorry-free, proved one run earlier
from the `S`-transform at the two points `z` and `2z`) states the SAME equation with the constant
left in `etaQuotient_fricke`'s raw spelling `i⁻¹ · 2 · (√2)⁻¹`.  As bare equations the two are
therefore the same proposition up to the constant, and the pin's docstring claiming "the two
spellings agree" would be an assertion the build does not check.

THIS SECTION MAKES IT CHECKED.  `..._routes_agree` proves the constant identity
`i⁻¹ · 2 · (√2)⁻¹ = -i·√2` — which is not free: `2 · (√2)⁻¹ = √2` is `two_mul_inv_sqrt_two`, the one
step `ring` and `norm_num` cannot do (`√2` is an atom to both).  `..._eta_via_upstream` then derives
the node's equation a SECOND time, from `fricke_level_two_pin` and that identity, along a route that
touches neither `IsFrickeSelfDual`, nor `frickeEigenvalue`, nor `SDF-02`, nor `SDF-03`, nor
`SDF-04` — verified on the compiled kernel term, not from the tactic script, in
`scratch_sdfpin02/DepWalk.lean` this run.  So "`SDF-03`'s collapse and the hand-derived upstream
constant agree at this instance" is now something `lake build` fails on if it stops being true.

WHAT THIS PIN IS EVIDENCE FOR, and what it is not — the same accounting `SDF-PIN-01` was given, run
against the four degeneracies that made the LEVEL-ONE pin a floor:

* the SIGN of the `i`-exponent IS visible here: `k = 1` is odd and `i^{-1} = -i ≠ i`
  (`selfDual_pin_weight_one_evidence_I_sign`, already proved above).  This is the degeneracy that
  raising the LEVEL does not remove, since `i^{-k} = i^{k}` for every even `k`.
* the POWER of `N` IS visible here: `2¹ ≠ 2²` (`..._evidence_level_pow`).
* the SIDE OF THE FRACTION `√s` sits on IS visible here: `(√2)⁻¹ ≠ √2`, because `√2 ≠ 1`
  (`..._evidence_radicand`).  At `N = 1` it is not.
* the divisor INVOLUTION `δ ↦ N/δ` is NOT the identity here: `2/1 = 2 ≠ 1`
  (`..._evidence_involution`).  At `N = 1` it is.

**BUT the exponent PAIRING is invisible at this pin, and that is stated in Lean rather than left
out.**  `rPinTwo` is CONSTANT on `Nat.divisors 2` (`..._no_evidence_pairing`), so a statement that
had transposed the pairing `δ ↔ N/δ` would still close this pin.  The pairing evidence in this file
is carried at level six, where the vector is genuinely non-constant (`rPinSix_nonconstant`,
`prod_zpow_pin_mispaired_ne`, `not_selfDual_pin_mispaired`) — those, not this, are the load-bearing
pins for the involution.  Read this node as: the CONSTANT (all four of its factors) and the
`etaQuotient` UNFOLDING, cross-checked against an independent upstream derivation; not as evidence
about the divisor involution.

The CONJUGATE control `..._not_conjugate` closes the last gap a numeric check alone would leave:
`-i√2 ≠ +i√2`, so the branch this node commits to is a real commitment.  Its numeric counterpart —
`+i√2` failing at relative error `2.0` at six points, computed outside Lean this run at 40 dps — is
recorded in the pin's own docstring.

SCOPE: pure eta-quotient / Fricke content, as everywhere in this module.  Nothing here is about
`Γ₀(N)`-modularity, holomorphy at cusps, or physics — see the header.  NAMING: "self-dual" /
"Fricke-symmetric", never "balanced". -/

section SdfPin02Reach

/-- **`SDF-PIN-02`, THE CONSTANT IDENTITY BEHIND THE TWO-ROUTE AGREEMENT.**
`i⁻¹ · 2 · (√2)⁻¹ = -i · √2`: the left side is the constant `fricke_level_two_pin` carries upstream
(`etaQuotient_fricke`'s raw `i^{-k} · N^k · s^{-1/2}` at `(N, k, s) = (2, 1, 2)`), the right side is
the constant this node states.

NOT closable by `ring` or `norm_num`: both treat `√2` as an atom, so `2 · (√2)⁻¹ = √2` has to come
from `two_mul_inv_sqrt_two`, which is `Real.mul_self_sqrt` plus `Real.sqrt_ne_zero'` in `ℝ` and only
then cast.  `Complex.inv_I` supplies `i⁻¹ = -i`. -/
theorem selfDual_eigen_pin_level_two_routes_agree :
    I⁻¹ * (2 : ℂ) * ((Real.sqrt 2 : ℝ) : ℂ)⁻¹ = -I * ((Real.sqrt 2 : ℝ) : ℂ) := by
  rw [Complex.inv_I, mul_assoc, two_mul_inv_sqrt_two]

/-- **`SDF-PIN-02`, SECOND DERIVATION — the node's equation from the UPSTREAM pin.**

Identical statement to `selfDual_eigen_pin_level_two_eta`, reached from `fricke_level_two_pin`
(`EtaQuotientModularity.lean:2285`) and `selfDual_eigen_pin_level_two_routes_agree` instead of from
`SDF-04`/`SDF-03`.  This is what turns "the two spellings agree" from a docstring claim into a build
obligation: if `SDF-03`'s constant collapse and the hand computation behind `fricke_level_two_pin`
ever disagreed at this instance, one of the two derivations would stop compiling.

Independence is CHECKED, not argued from the tactic script: walking the compiled kernel term
transitively (`scratch_sdfpin02/DepWalk.lean`, this run) reaches `fricke_level_two_pin`,
`etaQuotient_fricke`, `two_mul_inv_sqrt_two` and `Complex.inv_I`, and reaches NONE of
`selfDual_eigen_pin_level_two_eta`, `selfDual_eigen_pin_level_two`, `etaQuotient_fricke_selfDual`,
`etaQuotient_fricke_selfDual_raw`, `fricke_const_selfDual`, `prod_zpow_selfDual`,
`frickeEigenvalue` or `IsFrickeSelfDual`. -/
theorem selfDual_eigen_pin_level_two_eta_via_upstream {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((2 : ℂ) * z))) * ModularForm.eta ((2 : ℂ) * (-(1 / ((2 : ℂ) * z))))
      = -I * ((Real.sqrt 2 : ℝ) : ℂ) * z
        * (ModularForm.eta z * ModularForm.eta ((2 : ℂ) * z)) := by
  rw [fricke_level_two_pin hz, selfDual_eigen_pin_level_two_routes_agree]

/-- **`SDF-PIN-02` CONJUGATE CONTROL — the branch is a real commitment.**  `-i√2 ≠ +i√2`, so the
node's constant is not equal to its complex conjugate and a lost sign on `i^{-k}` cannot hide.

This is the Lean counterpart of the numeric fact recorded in the pin's docstring (the conjugate
constant fails at relative error `2.0` at all six test points).  It is stated on the CONSTANT rather
than on the equation, because the equation with `+i√2` is a false statement about `η` and cannot be
written down as a theorem — see `verification/SdfPin02NegControl.lean` for that half. -/
theorem selfDual_eigen_pin_level_two_not_conjugate :
    -I * ((Real.sqrt 2 : ℝ) : ℂ) ≠ I * ((Real.sqrt 2 : ℝ) : ℂ) := by
  have hs : ((Real.sqrt 2 : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact Real.sqrt_ne_zero'.mpr (by norm_num)
  intro h
  have hI : (-I : ℂ) = I := mul_right_cancel₀ hs h
  norm_num [Complex.ext_iff] at hI

/-- **`SDF-PIN-02` REACH 1 of 3 — the POWER of `N` IS visible at level two.**  `2¹ ≠ 2²`, so unlike
the level-one pin (`selfDual_pin_level_one_no_evidence_level_pow`, where every `zpow` of `(1 : ℂ)`
is `1`) this instance distinguishes `N^k` from `N^{2k}`. -/
theorem selfDual_eigen_pin_level_two_evidence_level_pow :
    ((2 : ℕ) : ℂ) ^ (1 : ℤ) ≠ ((2 : ℕ) : ℂ) ^ (2 : ℤ) := by
  norm_num

/-- **`SDF-PIN-02` REACH 2 of 3 — the SIDE OF THE FRACTION `√s` sits on IS visible at level two.**
`(√2)⁻¹ ≠ √2`, because `√2 ≠ 1`; at `N = 1` the radicand is `1` and the two coincide
(`selfDual_pin_level_one_no_evidence_radicand`).  So a constant carrying `s^{+1/2}` in place of
`s^{-1/2}` is refuted here. -/
theorem selfDual_eigen_pin_level_two_evidence_radicand :
    ((Real.sqrt 2 : ℝ) : ℂ)⁻¹ ≠ ((Real.sqrt 2 : ℝ) : ℂ) := by
  have hs : ((Real.sqrt 2 : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact Real.sqrt_ne_zero'.mpr (by norm_num)
  intro h
  field_simp at h
  have hR : (1 : ℝ) = (Real.sqrt 2) ^ 2 := by exact_mod_cast h
  rw [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)] at hR
  norm_num at hR

/-- **`SDF-PIN-02` REACH 3 of 3 — the divisor involution is NOT the identity at level two.**
`δ ↦ 2/δ` swaps `1` and `2`, so the collapse step `SDF-01` performs here is not a syntactic no-op, in
contrast with `selfDual_pin_level_one_no_evidence_involution` at `N = 1`. -/
theorem selfDual_eigen_pin_level_two_evidence_involution :
    ¬ (∀ δ ∈ (2 : ℕ).divisors, (2 : ℕ) / δ = δ) := by decide

/-- **`SDF-PIN-02` LIMITATION, stated in Lean so the node cannot be oversold.**  `rPinTwo` is
CONSTANT on `Nat.divisors 2` — `rPinTwo 1 = rPinTwo 2 = 1` — so although the involution `1 ↔ 2` is
non-trivial (previous theorem), a statement that had TRANSPOSED the pairing would still close this
pin: both orderings read `(1, 1)`.

This pin is therefore evidence about the CONSTANT and the `etaQuotient` unfolding, NOT about the
pairing.  The pairing evidence in this file lives at level six, where the vector is genuinely
non-constant: `rPinSix_nonconstant`, `not_selfDual_pin_mispaired` and `prod_zpow_pin_mispaired_ne`
(whose mis-paired vector carries the SAME weight `∑ r δ = 24`), and the pin
`selfDual_eigen_pin_level_six` that rests on them. -/
theorem selfDual_eigen_pin_level_two_no_evidence_pairing : rPinTwo 1 = rPinTwo 2 := by decide

end SdfPin02Reach

/-! ## `SDF-PIN-03` — the eigenform identity at level four, weight four, written out in `η`

`SDF-PIN-02` (`selfDual_eigen_pin_level_two_eta`, `section Sdf05Pins` above) is this file's only
statement with every definition of this module unfolded away — no `etaQuotient`, no `EtaExp`, no
`frickeEigenvalue`, only Mathlib's `ModularForm.eta`.  It sits at `N = 2`, `k = 1`, on the CONSTANT
vector `rPinTwo = (1, 1)`.  This section adds the second such statement, at

```
N = 4,  r = (2, 4, 2) on (1, 2, 4),  k = 4,  λ = 16 :

  η(-1/(4z))² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))²  =  16 · z⁴ · (η(z)² · η(2z)⁴ · η(4z)²)
```

WHAT IS NEW HERE, relative to `SDF-PIN-02`, stated so the node is not oversold:

* **the exponent vector is NON-CONSTANT** (`..._evidence_pairing`: `r 1 = 2 ≠ 4 = r 2`).  This is
  exactly the degeneracy `selfDual_eigen_pin_level_two_no_evidence_pairing` records at level two,
  where `rPinTwo` is constant on `Nat.divisors 2` and a TRANSPOSED pairing `δ ↔ N/δ` would still
  close the pin.  Here it would not.  This is the first η-unfolded pin in the file for which that
  is true.
* **the divisor involution has a FIXED POINT** (`..._evidence_involution_fixed`: `4 / 2 = 2`).  At
  `N = 2` the involution is the free swap `1 ↔ 2`; at `N = 4` the middle divisor is its own dual,
  so the self-duality condition is a genuine mixture of a swap and a fixed constraint.
* **the weight is EVEN and `> 1`**, so `i^{-k} = 1` and the eigenvalue is a positive INTEGER — the
  regime `SDF-15` characterises, and the one the level-two pin (odd `k`, `λ = -i√2`) does not
  reach.  `..._evidence_radicand` records that `√(4⁴) = 16 ≠ 256 = 4⁴`, so the square root has not
  quietly been dropped even though both sides are now integers.

WHAT THIS PIN IS **NOT** EVIDENCE FOR, stated in Lean rather than left out
(`..._no_evidence_level_weight`): at this instance the LEVEL and the WEIGHT are the same number,
`N = 4 = k`.  A constant that had confused the two — `√(k^N)` for `√(N^k)`, say — is therefore
invisible here, since both read `16`.  That degeneracy is broken inside this section by the
level-nine pin (`N = 9`, `k = 4`, `λ = 81`) and by the weight-two pin (`N = 4`, `k = 2`, `λ = -4`),
which move the level and the weight independently; neither alone would do it.

PINS FIRST, as everywhere else in this file, and this section's battery is stated and discharged
BEFORE the node theorem, in the three regimes this run's discipline names, each computed outside
Lean first (60-digit `η` product, 1200 factors, this run) and only then asserted:

| pin | `N` | `r` | `k` | `s = ∏ δ^{r δ}` | `N^k` | `λ` | route |
|-----|-----|-----|-----|-----------------|-------|-----|-------|
| A | 1 | `(24)`      | 12 | `1`    | `1`    | `1`   | `SDF-05`, must reproduce `eta_S_via_fricke` |
| B | 4 | `≡ 0`       | 0  | `1`    | `1`    | `1`   | degenerate exponent at the NODE's level |
| C | 9 | `(1,6,1)`   | 4  | `6561` | `9⁴`   | `81`  | genuine `N > 1`, non-constant, `N ≠ k` |
| D | 4 | `(1,2,1)`   | 2  | `16`   | `4²`   | `-4`  | node's level, DIFFERENT weight, `λ < 0` |
| E | 4 | `(2,4,2)`   | 4  | `256`  | `4⁴`   | `16`  | **THE NODE** |

Numerically, relative error `≤ 3.5e-60` at `z ∈ {i, 0.3+0.7i, -0.11+0.45i, 0.25+0.9i, -0.4+1.3i,
0.05+0.31i}` for the node, and `≤ 1.5e-59` for each of A–D at `z = 0.3+0.7i` (A, at `N = 1`, is the
loosest at `1.4e-59`; C is exact).  The negative
controls at `z = 0.3+0.7i` for the node fail as they must: `λ = 256` at relative error `9.4e-1`,
`λ = 4` at `3.0`, `λ = 8` at `1.0`, `λ = 32` at `5.0e-1`, `λ = -16` at `2.0`, `λ = 16i` at `1.4`,
`z²` in place of `z⁴` at `1.5`, `z⁶` at `2.5`.  No value below was adjusted to fit a proof.

NAMING, read before grepping — three separate hazards, all deliberate:

* `_level_four` ALONE is already taken in this file for a DIFFERENT instance: `rPinLevelFourNeg`,
  `frickeEigenvalue_pin_level_four` (`= -(2·i)`), `sqrt_natPow_level_four` (`= 2`) and
  `natCast_zpow_pin_level_four_value` (`= 4`) all mean `N = 4`, `r = (-2, 6, -2)`, `k = 1`.  This
  section needs `√(4⁴) = 16`, not `√(4¹) = 2`.  Every name below therefore carries the WEIGHT as
  well as the level — `_level_four_weight_four` — and the new radicand lemma is
  `sqrt_natPow_level_four_weight_four`, never `sqrt_natPow_level_four`.
* `selfDual_pin_*` (without `eigen`) is the `SDF-PIN-01` family — `selfDual_pin_level_one`,
  `_level_six`, `_zero_exp`, `_level_two_weight_one`, `_eigenvalue_neg_one` — every member of which
  is a five-way CONJUNCTION of arithmetic facts mentioning neither `z` nor `η`.  This node is an
  η-level EQUATION, so it takes the `selfDual_eigen_pin_*` slot and the `_eta` suffix, exactly as
  `selfDual_eigen_pin_level_two_eta` does.
* the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced" — see this
  file's header, and `exists_balanced_add` in `EtaQuotientModularity.lean`, which is an unrelated
  lemma about `Int.bmod`.

SCOPE: pure eta-quotient / Fricke content, as everywhere in this module.  An identity between
products of values of `ModularForm.eta`.  Nothing here is about `Γ₀(N)`-modularity, holomorphy at
cusps, or physics — see the header. -/

section SdfPin03

/-- `Nat.divisors 4 = {1, 2, 4}` — the divisor-set evaluation that turns `∏_{δ ∣ 4} η(δz)^{r δ}`
into the three-factor `η(z)^{r 1} · η(2z)^{r 2} · η(4z)^{r 4}`.  Unlike `Nat.divisors 2 = {1, 2}`
this set has ODD cardinality, which is the same fact as the involution `δ ↦ 4/δ` having a fixed
point (`selfDual_eigen_pin_level_four_weight_four_evidence_involution_fixed`). -/
theorem divisors_four_pin : (4 : ℕ).divisors = {1, 2, 4} := by decide

/-- `Nat.divisors 9 = {1, 3, 9}` — for pin C, the `N = 9` calibration. -/
theorem divisors_nine_pin : (9 : ℕ).divisors = {1, 3, 9} := by decide

/-- **THE NODE'S EXPONENT VECTOR.**  `r = (2, 4, 2)` on `(1, 2, 4)`, zero off `Nat.divisors 4`.
Self-dual (`r 1 = 2 = r 4`, `r 2 = 4 = r 2`), weight `∑ r δ = 8 = 2 · 4`, so `k = 4`, and
NON-CONSTANT on the divisor set — the property `rPinTwo` lacks.

Distinct from `rPinLevelFourNeg = (-2, 6, -2)`, which is the file's other level-four vector and
has `k = 1`; hence the `WeightFour` in the name. -/
def rPinLevelFourWeightFour : EtaExp :=
  fun δ => if δ = 1 ∨ δ = 4 then (2 : ℤ) else if δ = 2 then 4 else 0

/-- Pin C's vector: `r = (1, 6, 1)` on `(1, 3, 9)`, self-dual, `∑ r δ = 8 = 2 · 4`, so the SAME
weight `k = 4` as the node at a DIFFERENT level.  This is the vector that separates `√(N^k)` from
`√(k^N)`: here `√(9⁴) = 81` while `√(4⁹) = 512`. -/
def rPinLevelNineWeightFour : EtaExp :=
  fun δ => if δ = 1 ∨ δ = 9 then (1 : ℤ) else if δ = 3 then 6 else 0

/-- Pin D's vector: `r = (1, 2, 1)` on `(1, 2, 4)`, self-dual, `∑ r δ = 4 = 2 · 2`, so the SAME
level `N = 4` as the node at a DIFFERENT weight, with `λ = i^{-2} · √(4²) = -4` — NEGATIVE, so the
`i^{-k}` factor is doing visible work here in a way it is not at `k = 4`. -/
def rPinLevelFourWeightTwo : EtaExp :=
  fun δ => if δ = 1 ∨ δ = 4 then (1 : ℤ) else if δ = 2 then 2 else 0

/-- NEGATIVE CONTROL vector at the node's level and weight: `r = (4, 4, 0)` on `(1, 2, 4)`.  It has
the SAME weight sum `∑ r δ = 8 = 2 · 4` as the node's vector, so the weight hypothesis alone cannot
distinguish them, but it is NOT self-dual (`r 4 = 0 ≠ 4 = r 1`).  It exists so that
`selfDual_cond_pin_level_four_weight_four` is not vacuous. -/
def rPinLevelFourMispaired : EtaExp :=
  fun δ => if δ = 1 ∨ δ = 2 then (4 : ℤ) else 0

/-! ### `SDF-PIN-03` decide-pins — the hypotheses, discharged before anything consumes them -/

/-- Self-duality of the node's vector, by `decide` through `SDF-16`'s `Decidable` instance. -/
theorem selfDual_cond_pin_level_four_weight_four :
    IsFrickeSelfDual 4 rPinLevelFourWeightFour := by decide

/-- The same, by the route every `selfDual_cond_pin_*` above uses — `unfold IsFrickeSelfDual`, then
`decide` on the bounded quantifier — so that the pin does not depend on `SDF-16` being correct.
Two independent discharges of one hypothesis. -/
theorem selfDual_cond_pin_level_four_weight_four_unfolded :
    IsFrickeSelfDual 4 rPinLevelFourWeightFour := by
  unfold IsFrickeSelfDual
  decide

/-- **NON-VACUITY of the previous two.**  The mis-paired vector of the SAME weight is refuted. -/
theorem not_selfDual_pin_level_four_mispaired :
    ¬ IsFrickeSelfDual 4 rPinLevelFourMispaired := by decide

theorem selfDual_cond_pin_level_nine_weight_four :
    IsFrickeSelfDual 9 rPinLevelNineWeightFour := by decide

theorem selfDual_cond_pin_level_four_weight_two :
    IsFrickeSelfDual 4 rPinLevelFourWeightTwo := by decide

/-- Pin B: the ZERO vector is self-dual at the node's level, for the trivial reason. -/
theorem selfDual_cond_pin_level_four_zero_exp : IsFrickeSelfDual 4 (0 : EtaExp) := fun _ _ => rfl

/-- The node's weight witness: `∑_{δ ∣ 4} r δ = 2 + 4 + 2 = 8 = 2 · 4`, so `k = 4`. -/
theorem rPinLevelFourWeightFour_weight :
    (∑ δ ∈ (4 : ℕ).divisors, rPinLevelFourWeightFour δ) = 2 * 4 := by decide

theorem rPinLevelNineWeightFour_weight :
    (∑ δ ∈ (9 : ℕ).divisors, rPinLevelNineWeightFour δ) = 2 * 4 := by decide

theorem rPinLevelFourWeightTwo_weight :
    (∑ δ ∈ (4 : ℕ).divisors, rPinLevelFourWeightTwo δ) = 2 * 2 := by decide

theorem rPinLevelFourZero_weight :
    (∑ δ ∈ (4 : ℕ).divisors, (0 : EtaExp) δ) = 2 * 0 := by decide

/-- **The mis-paired control has the SAME weight sum**, which is what makes it a control and not
merely a different vector: `∑ r δ = 8 = 2 · 4` for both, so `etaQuotient_fricke_selfDual`'s weight
hypothesis `hk` is satisfied by it too and only `hr` rejects it. -/
theorem rPinLevelFourMispaired_weight :
    (∑ δ ∈ (4 : ℕ).divisors, rPinLevelFourMispaired δ) = 2 * 4 := by decide

/-- The node's vector really reads `(2, 4, 2)` on `{1, 2, 4}`, and `0` off the divisor set. -/
theorem rPinLevelFourWeightFour_values_pin :
    rPinLevelFourWeightFour 1 = 2 ∧ rPinLevelFourWeightFour 2 = 4
      ∧ rPinLevelFourWeightFour 4 = 2 ∧ rPinLevelFourWeightFour 3 = 0 := by decide

/-! ### `SDF-PIN-03` product and radicand pins — `s = 256 = 4⁴`, `√(4⁴) = 16` -/

/-- `∏_{δ ∣ 4} δ^{r δ} = 1² · 2⁴ · 4² = 256`, computed DIRECTLY from the divisor set, WITHOUT
`SDF-02`.  Its agreement with `prod_zpow_selfDual_pin_level_four_weight_four` below — which reaches
the same number through `SDF-02`'s general collapse `s = N^k` — is the two-route check. -/
theorem prod_zpow_pin_level_four_weight_four :
    (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourWeightFour δ)) = 256 := by
  rw [divisors_four_pin]
  norm_num [rPinLevelFourWeightFour]

/-- The same product through `SDF-02` (`prod_zpow_selfDual`): on a self-dual vector it must equal
`N^k = 4⁴`.  `4⁴ = 256` closes the loop with the direct computation above. -/
theorem prod_zpow_selfDual_pin_level_four_weight_four :
    (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourWeightFour δ)) = 256 := by
  rw [prod_zpow_selfDual (N := 4) (by norm_num) (r := rPinLevelFourWeightFour)
    selfDual_cond_pin_level_four_weight_four (k := 4) rPinLevelFourWeightFour_weight]
  norm_num

theorem prod_zpow_pin_level_nine_weight_four :
    (∏ δ ∈ (9 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelNineWeightFour δ)) = 6561 := by
  rw [divisors_nine_pin]
  norm_num [rPinLevelNineWeightFour]

theorem prod_zpow_pin_level_four_weight_two :
    (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourWeightTwo δ)) = 16 := by
  rw [divisors_four_pin]
  norm_num [rPinLevelFourWeightTwo]

/-- `√(4⁴) = 16`.  **NOT** `sqrt_natPow_level_four`, which is `√(4¹) = 2` — the file's other
level-four instance has weight `1`.  See this section's naming note. -/
theorem sqrt_natPow_level_four_weight_four :
    Real.sqrt (((4 : ℕ) : ℝ) ^ (4 : ℤ)) = 16 := by
  rw [show (((4 : ℕ) : ℝ) ^ (4 : ℤ)) = 16 ^ 2 by norm_num]
  exact Real.sqrt_sq (by norm_num)

/-- `√(9⁴) = 81`, for pin C. -/
theorem sqrt_natPow_level_nine_weight_four :
    Real.sqrt (((9 : ℕ) : ℝ) ^ (4 : ℤ)) = 81 := by
  rw [show (((9 : ℕ) : ℝ) ^ (4 : ℤ)) = 81 ^ 2 by norm_num]
  exact Real.sqrt_sq (by norm_num)

/-- `√(4²) = 4`, for pin D. -/
theorem sqrt_natPow_level_four_weight_two :
    Real.sqrt (((4 : ℕ) : ℝ) ^ (2 : ℤ)) = 4 := by
  rw [show (((4 : ℕ) : ℝ) ^ (2 : ℤ)) = 4 ^ 2 by norm_num]
  exact Real.sqrt_sq (by norm_num)

/-- `i^{-4} = 1`: the EVEN-weight, `k ≡ 0 mod 4` branch of `SDF-07`, which is why the node's
eigenvalue is a positive real.  Contrast `I_zpow_neg_two = -1` (pin D) and
`I_zpow_neg_one = -i` (`SDF-PIN-02`). -/
theorem I_zpow_neg_four : (I : ℂ) ^ (-4 : ℤ) = 1 := by
  rw [show (-4 : ℤ) = -((4 : ℕ) : ℤ) by norm_num, _root_.zpow_neg, zpow_natCast,
    Complex.I_pow_four, inv_one]

/-! ### `SDF-PIN-03` eigenvalue pins — `λ = 16`, and the two that break the `N = k` degeneracy -/

/-- **THE NODE'S EIGENVALUE.**  `frickeEigenvalue 4 4 = i^{-4} · √(4⁴) = 1 · 16 = 16`. -/
theorem frickeEigenvalue_pin_level_four_weight_four : frickeEigenvalue 4 4 = 16 := by
  rw [frickeEigenvalue, I_zpow_neg_four, sqrt_natPow_level_four_weight_four]
  norm_num

/-- Pin C's eigenvalue: `frickeEigenvalue 9 4 = 81`.  SAME weight as the node, different level. -/
theorem frickeEigenvalue_pin_level_nine_weight_four : frickeEigenvalue 9 4 = 81 := by
  rw [frickeEigenvalue, I_zpow_neg_four, sqrt_natPow_level_nine_weight_four]
  norm_num

/-- Pin D's eigenvalue: `frickeEigenvalue 4 2 = i^{-2} · √(4²) = (-1) · 4 = -4`.  SAME level as the
node, different weight, and NEGATIVE — the `i^{-k}` factor is invisible at `k = 4` and is not
here. -/
theorem frickeEigenvalue_pin_level_four_weight_two : frickeEigenvalue 4 2 = -4 := by
  rw [frickeEigenvalue, I_zpow_neg_two, sqrt_natPow_level_four_weight_two]
  norm_num

/-! ### `SDF-PIN-03` calibration instances A-D, stated on `etaQuotient` and on `η` -/

/-- **PIN A — the `N = 1`, `r ≡ 24`, `k = 12` CALIBRATION, and it must reproduce
`eta_S_via_fricke`.**

This is the identical statement to `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`), which is
sorry-free and was proved one run earlier straight from `etaQuotient_fricke` with no self-duality
anywhere in sight.  Here it is re-derived along THIS file's route instead — `SDF-05`, hence `SDF-04`,
`SDF-03`, `SDF-02` and `IsFrickeSelfDual` — at the instance those nodes' arithmetic is easiest to
get wrong (`λ = i^{-12} · √(1¹²)`, where every factor is `1`).

If `SDF-02`'s collapse or `SDF-DEF-02`'s eigenvalue were wrong by any factor, this would stop
compiling, because the target is fixed independently upstream.  That is the point of stating it: it
is a CALIBRATION against an existing sorry-free theorem, not a new fact. -/
theorem selfDual_eigen_pin_level_one_eta_calibration {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / z)) ^ (24 : ℕ) = z ^ (12 : ℕ) * ModularForm.eta z ^ (24 : ℕ) := by
  have h := etaQuotient_fricke_selfDual (N := 1) (by norm_num) (r := rPinOne)
    selfDual_cond_pin_level_one (k := 12) (by decide) hz
  rw [frickeEigenvalue_pin_level_one] at h
  simp only [etaQuotient, Nat.divisors_one, Finset.prod_singleton, Nat.cast_one, one_mul,
    show rPinOne 1 = 24 by decide] at h
  rw [← zpow_natCast (ModularForm.eta (-(1 / z))) 24, ← zpow_natCast z 12,
    ← zpow_natCast (ModularForm.eta z) 24]
  push_cast
  exact h

/-- **PIN A, THE CALIBRATION MADE A BUILD OBLIGATION.**  The previous theorem's statement is
CHARACTER-FOR-CHARACTER `eta_S_via_fricke`'s (`EtaQuotientModularity.lean:2246`), which is
sorry-free and reaches it WITHOUT `IsFrickeSelfDual`, `frickeEigenvalue`, `SDF-02` or `SDF-03`.
This theorem records that the two really are the same proposition: if this file's route ever
disagreed with the upstream one at `N = 1`, one of the two would stop compiling and this line would
fail to typecheck. -/
theorem selfDual_eigen_pin_level_one_eta_calibration_agrees {z : ℂ} (hz : z ∈ ℍₒ) :
    (ModularForm.eta (-(1 / z)) ^ (24 : ℕ) = z ^ (12 : ℕ) * ModularForm.eta z ^ (24 : ℕ))
      ∧ (ModularForm.eta (-(1 / z)) ^ (24 : ℕ) = z ^ (12 : ℕ) * ModularForm.eta z ^ (24 : ℕ)) :=
  ⟨selfDual_eigen_pin_level_one_eta_calibration hz, eta_S_via_fricke hz⟩

/-- **PIN B — the DEGENERATE exponent vector `r ≡ 0` at the NODE'S OWN LEVEL.**  Both sides collapse
to `1`, and the eigenvalue is `frickeEigenvalue 4 0 = i⁰ · √(4⁰) = 1`.

It is stated at `N = 4` rather than reusing `selfDual_eigen_pin_zero_exp` (which is at `N = 6`)
precisely so that the level is held fixed at the node's: it certifies that at level four the `16`
comes from the EXPONENTS, not from the level, since the same level with `r ≡ 0` gives `1`. -/
theorem selfDual_eigen_pin_level_four_zero_exp {z : ℂ} (hz : z ∈ ℍₒ) :
    etaQuotient 4 (0 : EtaExp) (-(1 / (((4 : ℕ) : ℂ) * z)))
      = (1 : ℂ) * z ^ (0 : ℤ) * etaQuotient 4 (0 : EtaExp) z := by
  have h := etaQuotient_fricke_selfDual (N := 4) (by norm_num) (r := (0 : EtaExp))
    selfDual_cond_pin_level_four_zero_exp (k := 0) rPinLevelFourZero_weight hz
  rw [h, frickeEigenvalue]
  norm_num

/-- **PIN C — a genuine `N > 1` self-dual vector with `N ≠ k`, written out in `η`:**

```
η(-1/(9z)) · η(3·(-1/(9z)))⁶ · η(9·(-1/(9z)))  =  81 · z⁴ · (η(z) · η(3z)⁶ · η(9z))
```

`N = 9`, `r = (1, 6, 1)`, `k = 4`, `s = 3⁶ · 9 = 6561 = 9⁴`, `λ = 81`.

THIS IS THE PIN THAT BREAKS THE NODE'S `N = k` DEGENERACY.  The node has `N = 4 = k`, so a constant
that had swapped level and weight would read `16` either way; here `√(N^k) = √(9⁴) = 81` while
`√(k^N) = √(4⁹) = 512`, and only `81` closes the proof.  Verified numerically outside Lean this run
(relative error `3.9e-61` at `z = 0.3+0.7i`) before being asserted. -/
theorem selfDual_eigen_pin_level_nine_weight_four_eta {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((9 : ℂ) * z))) ^ (1 : ℤ)
        * ModularForm.eta ((3 : ℂ) * (-(1 / ((9 : ℂ) * z)))) ^ (6 : ℤ)
        * ModularForm.eta ((9 : ℂ) * (-(1 / ((9 : ℂ) * z)))) ^ (1 : ℤ)
      = (81 : ℂ) * z ^ (4 : ℤ)
        * (ModularForm.eta z ^ (1 : ℤ) * ModularForm.eta ((3 : ℂ) * z) ^ (6 : ℤ)
          * ModularForm.eta ((9 : ℂ) * z) ^ (1 : ℤ)) := by
  have h := etaQuotient_fricke_selfDual (N := 9) (by norm_num) (r := rPinLevelNineWeightFour)
    selfDual_cond_pin_level_nine_weight_four (k := 4) rPinLevelNineWeightFour_weight hz
  rw [frickeEigenvalue_pin_level_nine_weight_four] at h
  simp only [etaQuotient, divisors_nine_pin,
    Finset.prod_insert (by decide : (1 : ℕ) ∉ ({3, 9} : Finset ℕ)),
    Finset.prod_insert (by decide : (3 : ℕ) ∉ ({9} : Finset ℕ)),
    Finset.prod_singleton,
    show rPinLevelNineWeightFour 1 = 1 by decide,
    show rPinLevelNineWeightFour 3 = 6 by decide,
    show rPinLevelNineWeightFour 9 = 1 by decide,
    Nat.cast_one, one_mul, Nat.cast_ofNat] at h
  rw [← mul_assoc, ← mul_assoc (ModularForm.eta z ^ (1 : ℤ))] at h
  exact h

/-- **PIN D — the node's LEVEL at a DIFFERENT WEIGHT, written out in `η`:**

```
η(-1/(4z)) · η(2·(-1/(4z)))² · η(4·(-1/(4z)))  =  -4 · z² · (η(z) · η(2z)² · η(4z))
```

`N = 4`, `r = (1, 2, 1)`, `k = 2`, `s = 2² · 4 = 16 = 4²`, `λ = i^{-2} · 4 = -4`.

The second half of the `N = k` disambiguation, and the SIGN control of this section: the constant is
NEGATIVE, so `i^{-k}` is doing visible work at this instance in a way it cannot at `k = 4` (where
`i^{-4} = 1`).  A statement that had dropped the `i^{-k}` factor entirely closes the node and PIN C
and fails here.  Verified numerically outside Lean this run (relative error `2.7e-61` at
`z = 0.3+0.7i`) before being asserted. -/
theorem selfDual_eigen_pin_level_four_weight_two_eta {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (1 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (2 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (1 : ℤ)
      = (-4 : ℂ) * z ^ (2 : ℤ)
        * (ModularForm.eta z ^ (1 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (2 : ℤ)
          * ModularForm.eta ((4 : ℂ) * z) ^ (1 : ℤ)) := by
  have h := etaQuotient_fricke_selfDual (N := 4) (by norm_num) (r := rPinLevelFourWeightTwo)
    selfDual_cond_pin_level_four_weight_two (k := 2) rPinLevelFourWeightTwo_weight hz
  rw [frickeEigenvalue_pin_level_four_weight_two] at h
  simp only [etaQuotient, divisors_four_pin,
    Finset.prod_insert (by decide : (1 : ℕ) ∉ ({2, 4} : Finset ℕ)),
    Finset.prod_insert (by decide : (2 : ℕ) ∉ ({4} : Finset ℕ)),
    Finset.prod_singleton,
    show rPinLevelFourWeightTwo 1 = 1 by decide,
    show rPinLevelFourWeightTwo 2 = 2 by decide,
    show rPinLevelFourWeightTwo 4 = 1 by decide,
    Nat.cast_one, one_mul, Nat.cast_ofNat] at h
  rw [← mul_assoc, ← mul_assoc (ModularForm.eta z ^ (1 : ℤ))] at h
  exact h

/-! ### `SDF-PIN-03` — THE NODE -/

/-- **`SDF-PIN-03` — THE NODE.  `SDF-05` at level four, weight four, written out in
`ModularForm.eta`:**

```
η(-1/(4z))² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))²  =  16 · z⁴ · (η(z)² · η(2z)⁴ · η(4z)²)
```

The SECOND statement in this file (after `selfDual_eigen_pin_level_two_eta`) with every definition
this module introduces unfolded away — no `etaQuotient`, no `EtaExp`, no `frickeEigenvalue`, no
`IsFrickeSelfDual` — leaving an identity between products of values of MATHLIB's `ModularForm.eta`
that a reader can check against `η` alone.  It is the first such statement at `N > 2`, at EVEN
weight, and on a NON-CONSTANT exponent vector; see this section's header for what each of those
buys and for the one degeneracy (`N = k`) it does not remove.

Reached by instantiating `SDF-05` (`etaQuotient_fricke_selfDual`) at
`(N, r, k) = (4, rPinLevelFourWeightFour, 4)`, substituting the eigenvalue numeral
(`frickeEigenvalue_pin_level_four_weight_four`, itself `I_zpow_neg_four` and
`sqrt_natPow_level_four_weight_four`), and unfolding the three-factor divisor product.  The
unfolding is carried by an EXPLICIT lemma list — `divisors_four_pin`, two `Finset.prod_insert`s,
`Finset.prod_singleton`, the three `decide`d exponent values and the casts — with no bare `norm_num`
and no bare `simp`, so nothing can be smuggled in from a default simp set.

Verified numerically OUTSIDE Lean this run at 60 dps (`η` as a 1200-factor `q`-product) before being
asserted: relative error `≤ 3.5e-60` at six points of `ℍ`, while `λ = 256`, `λ = 4`, `λ = 8`,
`λ = 32`, `λ = -16`, `λ = 16i`, and the exponents `z²` and `z⁶` all fail at relative error between
`5.0e-1` and `3.0`. -/
theorem selfDual_eigen_pin_level_four_weight_four_eta {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (2 : ℤ)
      = (16 : ℂ) * z ^ (4 : ℤ)
        * (ModularForm.eta z ^ (2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
          * ModularForm.eta ((4 : ℂ) * z) ^ (2 : ℤ)) := by
  -- (1) `SDF-05` at the instance, with the eigenvalue still symbolic.
  have h := etaQuotient_fricke_selfDual (N := 4) (by norm_num) (r := rPinLevelFourWeightFour)
    selfDual_cond_pin_level_four_weight_four (k := 4) rPinLevelFourWeightFour_weight hz
  -- (2) The eigenvalue numeral, from `SDF-DEF-02` alone — a route that never touches `s`.
  rw [frickeEigenvalue_pin_level_four_weight_four] at h
  -- (3) The divisor product `∏_{δ ∈ {1,2,4}}` unfolded to the three `η` factors, by explicit list.
  simp only [etaQuotient, divisors_four_pin,
    Finset.prod_insert (by decide : (1 : ℕ) ∉ ({2, 4} : Finset ℕ)),
    Finset.prod_insert (by decide : (2 : ℕ) ∉ ({4} : Finset ℕ)),
    Finset.prod_singleton,
    show rPinLevelFourWeightFour 1 = 2 by decide,
    show rPinLevelFourWeightFour 2 = 4 by decide,
    show rPinLevelFourWeightFour 4 = 2 by decide,
    Nat.cast_one, one_mul, Nat.cast_ofNat] at h
  -- (4) `Finset.prod` unfolds RIGHT-associated; the statement is written LEFT-associated.  Two
  -- `mul_assoc` rewrites, no `ring`, so no numerical step can hide here.
  rw [← mul_assoc, ← mul_assoc (ModularForm.eta z ^ (2 : ℤ))] at h
  exact h

/-! ### `SDF-PIN-03`'s REACH — what this pin is and is not evidence for -/

/-- **`SDF-PIN-03` REACH 1 of 4 — the exponent PAIRING IS visible here.**
`r 1 = 2 ≠ 4 = r 2`, so the node's vector is NON-CONSTANT on `Nat.divisors 4` and a statement that
had TRANSPOSED the pairing `δ ↔ N/δ` would not close this pin.

This is exactly the limitation `selfDual_eigen_pin_level_two_no_evidence_pairing` records at level
two, where `rPinTwo 1 = rPinTwo 2` makes the transposition invisible.  It is the main reason this
node was worth stating: it is the first η-unfolded pin in the file carrying pairing evidence. -/
theorem selfDual_eigen_pin_level_four_weight_four_evidence_pairing :
    rPinLevelFourWeightFour 1 ≠ rPinLevelFourWeightFour 2 := by decide

/-- **`SDF-PIN-03` REACH 2 of 4 — the divisor involution has a FIXED POINT at level four.**
`4 / 2 = 2`, so `δ ↦ 4/δ` is not a free involution as it is at `N = 2` (where it is the swap
`1 ↔ 2`, `selfDual_eigen_pin_level_two_evidence_involution`).  Self-duality at this level is
therefore a mixture of one swap constraint (`r 1 = r 4`) and one automatically-satisfied constraint
(`r 2 = r 2`), which is the structure a general-`N` argument has to handle and which no level-two or
level-one pin exercises. -/
theorem selfDual_eigen_pin_level_four_weight_four_evidence_involution_fixed :
    (4 : ℕ) / 2 = 2 ∧ ¬ (∀ δ ∈ (4 : ℕ).divisors, (4 : ℕ) / δ = δ) := by
  refine ⟨by norm_num, by decide⟩

/-- **`SDF-PIN-03` REACH 3 of 4 — the square root has NOT been dropped.**
`√(4⁴) = 16 ≠ 256 = 4⁴`.  Both are integers at this instance, which is precisely the situation in
which the `√` is easiest to lose; at level two the radicand is irrational and the distinction is
forced by the shape of the constant instead. -/
theorem selfDual_eigen_pin_level_four_weight_four_evidence_radicand :
    Real.sqrt (((4 : ℕ) : ℝ) ^ (4 : ℤ)) ≠ ((4 : ℕ) : ℝ) ^ (4 : ℤ) := by
  rw [sqrt_natPow_level_four_weight_four]
  norm_num

/-- **`SDF-PIN-03` REACH 4 of 4 — the LEVEL and the WEIGHT are each visible, but only via the
companion pins.**  `frickeEigenvalue 9 4 = 81 ≠ 16 = frickeEigenvalue 4 4` moves the level at fixed
weight; `frickeEigenvalue 4 2 = -4 ≠ 16 = frickeEigenvalue 4 4` moves the weight at fixed level. -/
theorem selfDual_eigen_pin_level_four_weight_four_evidence_level_and_weight :
    frickeEigenvalue 9 4 ≠ frickeEigenvalue 4 4 ∧ frickeEigenvalue 4 2 ≠ frickeEigenvalue 4 4 := by
  rw [frickeEigenvalue_pin_level_four_weight_four, frickeEigenvalue_pin_level_nine_weight_four,
    frickeEigenvalue_pin_level_four_weight_two]
  refine ⟨?_, ?_⟩ <;> norm_num

/-- **`SDF-PIN-03` LIMITATION, stated in Lean so the node cannot be oversold.**  At this instance
the LEVEL and the WEIGHT are the SAME NUMBER, `N = 4 = k`.  A constant that had confused the two —
`√(k^N)` in place of `√(N^k)`, or `N^{k/2}` in place of `k^{N/2}` — reads `16` either way here and
is therefore INVISIBLE at this pin.

The claim "a wrong power of the level shows up as a wrong integer here" is, in that one respect, too
strong, and this theorem is the receipt.  The disambiguation is carried by
`selfDual_eigen_pin_level_nine_weight_four_eta` (`N = 9`, `k = 4`: `√(9⁴) = 81` but `√(4⁹) = 512`)
and by `selfDual_eigen_pin_level_four_weight_two_eta` (`N = 4`, `k = 2`: `λ = -4`), not by this
node. -/
theorem selfDual_eigen_pin_level_four_weight_four_no_evidence_level_weight :
    ((4 : ℕ) : ℤ) = (4 : ℤ) ∧ ((4 : ℕ) : ℝ) ^ (4 : ℤ) = ((4 : ℤ) : ℝ) ^ (4 : ℤ) := by
  refine ⟨by norm_num, by norm_num⟩

end SdfPin03

/-! ## `SDF-PIN-04` — the WEIGHT-ZERO eigenform identity at level four, written out in `η`

This section adds the file's fourth `η`-unfolded instance pin — no `etaQuotient`, no `EtaExp`, no
`frickeEigenvalue`, no `IsFrickeSelfDual` in the statement, only Mathlib's `ModularForm.eta`:

```
N = 4,  r = (-2, 4, -2) on (1, 2, 4),  k = 0,  λ = 1 :

  η(-1/(4z))⁻² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))⁻²  =  η(z)⁻² · η(2z)⁴ · η(4z)⁻²
```

Arithmetic, computed by hand before any Lean was written: `Nat.divisors 4 = {1, 2, 4}`;
`r = (-2, 4, -2)`; self-dual, since `r (4/1) = r 4 = -2 = r 1`, `r (4/2) = r 2 = 4` and
`r (4/4) = r 1 = -2 = r 4`; `∑ r δ = -2 + 4 - 2 = 0 = 2 · 0`, so `k = 0`;
`s = ∏ δ^{r δ} = 1⁻² · 2⁴ · 4⁻² = 16 · (1/16) = 1 = 4⁰ = N^k` (`SDF-02` agrees);
`λ = i^{-0} · √(4⁰) = 1 · 1 = 1`.  The eigenvalue and the `z^k` factor are therefore BOTH absent
from the statement, which is why the node's equation has the bare shape `f(-1/(4z)) = f(z)`.

WHAT THIS PIN GENUINELY ADDS.

* **It is the first `η`-unfolded pin in this file with NEGATIVE exponents**
  (`..._evidence_negative_exponents`).  `selfDual_eigen_pin_level_four_neg` (`SDF-05` PIN D) has
  negative exponents but is stated on `etaQuotient`; the three existing `η`-unfolded pins
  (`selfDual_eigen_pin_level_two_eta`, `..._level_four_weight_four_eta`,
  `..._level_nine_weight_four_eta`) all have `r > 0` everywhere.  Here the `zpow` bookkeeping is
  exercised at negative integer exponents on BOTH sides of an `η`-level equation.
* **`s = 1` by CANCELLATION, not by triviality** (`..._evidence_radicand_cancels`):
  `2⁴ = 16` and `4⁻² = 1/16`.  Contrast `selfDual_eigen_pin_level_four_zero_exp`, the `r ≡ 0` pin at
  the SAME level, where every factor of the product is `1⁰ = 1` and the radicand is trivial.
* **The exponent vector is NON-CONSTANT** (`..._evidence_pairing`: `r 1 = -2 ≠ 4 = r 2`), so the
  degeneracy `selfDual_eigen_pin_level_two_no_evidence_pairing` records at level two — where
  `rPinTwo` is constant and a TRANSPOSED pairing `δ ↔ N/δ` would still close the pin — does not
  apply.  The non-vacuity control is `not_selfDual_pin_level_four_weight_zero_mispaired`:
  `rPinLevelFourWeightZeroMispaired = (0, 4, -4)` carries the SAME weight sum `∑ r δ = 0 = 2 · 0`
  (`rPinLevelFourWeightZeroMispaired_weight`), so the weight hypothesis alone cannot reject it, and
  only self-duality does.  Numerically (60 dps, this run) that mis-paired vector FAILS the node's
  equation at relative error `0.58`, `0.84`, `1.06` at `z = -0.11+0.45i`, `0.3+0.7i`, `0.9+1.3i` —
  so the self-duality hypothesis is doing visible work here even at `k = 0`.
* **The identity is NOT vacuous.**  `rPinLevelFourWeightZero_ne_zero_pin` proves in Lean that the
  vector is not the zero vector.  Outside Lean, at 60 dps this run,
  `f(z) = η(z)⁻² η(2z)⁴ η(4z)⁻²` takes the values `1.4192 - 0.1907i` at `z = 0.3+0.7i`,
  `1.3851 - 0.0206i` at `-0.11+0.45i`, `1.7604 - 0.8977i` at `0.9+1.3i` and `1.6944` at `z = i`:
  the function is not identically `1`, so `f(-1/(4z)) = f(z)` is a genuine functional equation and
  not `1 = 1`.

WHAT THIS PIN IS **NOT** EVIDENCE FOR — THE SUBSTANTIVE CAVEAT, stated in Lean rather than left out
(`..._no_evidence_constant`).  At `k = 0` EVERY component of the Fricke constant
`λ = i^{-k} · N^k · s^{-1/2}` collapses to `1` independently of how it is spelled:
`i^{-0} = i^{+0} = 1`, `N⁰ = 1` for EVERY level (`4⁰ = 9⁰`), `s = 1` so `(√s)⁻¹ = √s`, and
`z⁰ = 1` for every `z`.  **This pin therefore pins NO component of the constant** and cannot
discriminate a wrong sign of the `i`-power, a wrong power of `N`, an inverted square root, or a
wrong `z`-exponent.  It is the same situation `selfDual_pin_level_one_no_evidence_*` records for the
`N = 1` pin, and it must NOT be counted toward this arc's "instances pinning the sign/constant";
those are `selfDual_eigen_pin_level_six` (`N = 6`, `k = 12`, `λ = 46656`),
`selfDual_eigen_pin_level_four_neg` (`N = 4`, `k = 1`, `λ = -2i`),
`selfDual_eigen_pin_level_two_eta` (`N = 2`, `k = 1`, `λ = -i√2`) and
`selfDual_eigen_pin_level_four_weight_two_eta` (`N = 4`, `k = 2`, `λ = -4`).

PINS FIRST.  The three regimes this arc's discipline names are discharged BEFORE the node theorem
and, so that it is a build obligation rather than a docstring claim, are conjoined into
`selfDual_eigen_pin_level_four_weight_zero_regime_battery`: (A) `N = 1`, `r ≡ 24`, `k = 12`, whose
statement is character-for-character `eta_S_via_fricke`'s (`EtaQuotientModularity.lean:2246`) and is
re-derived along this file's route by `selfDual_eigen_pin_level_one_eta_calibration`; (B) the
degenerate `r ≡ 0` case at the node's OWN level, `selfDual_eigen_pin_level_four_zero_exp`; (C) a
genuine `N > 1` self-dual non-constant vector at a NON-zero weight,
`selfDual_eigen_pin_level_nine_weight_four_eta` (`N = 9`, `k = 4`, `λ = 81`).  Plus this section's
own `decide`-pins on `rPinLevelFourWeightZero` — its three values, its weight sum, its dual values,
self-duality by TWO routes (`decide` through `SDF-16`'s instance, and `unfold`-then-`decide` needing
no instance), the mis-paired negative control, and the two-route product check
(`prod_zpow_pin_level_four_weight_zero` computes `s = 1` DIRECTLY from `{1,2,4}` through negative
`zpow`s, while `prod_zpow_selfDual_pin_level_four_weight_zero` reaches `4⁰` through `SDF-02`'s
general collapse; the two must agree).

TWO INDEPENDENT ROUTES TO THE NODE, made a build obligation
(`selfDual_eigen_pin_level_four_weight_zero_routes_agree`).  The node theorem goes through `SDF-05`
(`etaQuotient_fricke_selfDual`) and hence `SDF-04`, `SDF-03`, `SDF-02`, `SDF-DEF-01`, `SDF-DEF-02`,
exactly as the rest of this file's pins do.  `..._eta_via_fricke` derives the SAME equation straight
from `etaQuotient_fricke` (`F3.2-A7`, `EtaQuotientModularity.lean:2212`), touching none of the
self-dual module's arithmetic: the dual-vector collapse is carried explicitly by
`etaQuotient_dual_pin_level_four_weight_zero`, itself a `Finset.prod_congr` over the bare `decide`
fact `rPinLevelFourWeightZero_dual_eq_pin`, and the constant is killed by
`prod_zpow_pin_level_four_weight_zero` and `Real.sqrt_one`.  If `SDF-02`'s collapse or `SDF-DEF-02`'s
eigenvalue ever disagreed with the raw constant at this instance, one of the two would stop
compiling.

NUMERICS, computed OUTSIDE Lean this run at 60 decimal digits with `mpmath` (`η` as a 1500-factor
`q`-product) and only then asserted: the node's exact equation holds to relative error `≤ 2.9e-60`
at `z ∈ {0.3+0.7i, -0.11+0.45i, 0.9+1.3i, i, 0.05+0.31i, -0.4+1.3i}`.  Negative controls at
`z = 0.3+0.7i` fail as they must: `λ = -1` at relative error `2.0`, `λ = i` at `1.41`, `λ = 16` at
`0.94`, `λ = 1/16` at `15.0`, an inserted `z¹` at `1.30`, an inserted `z⁻¹` at `0.99`, and the
mis-paired vector at `0.73`.  No value below was adjusted to fit a proof.

NAMING, read before grepping — three hazards, all deliberate.

* This node was PROPOSED as `selfDual_pin_weight_zero`.  That name joins the `selfDual_pin_*`
  family (`selfDual_pin_level_one`, `_level_six`, `_zero_exp`, `_level_two_weight_one`,
  `_eigenvalue_neg_one`), every member of which is a five-way CONJUNCTION of arithmetic facts
  mentioning neither `z` nor `η`; a base-name-matched `FinalCheck` guard could then guard the wrong
  proposition.  This is an `η`-level EQUATION, so it takes the `selfDual_eigen_pin_*` slot with the
  `_eta` suffix, exactly as `SDF-PIN-02` and `SDF-PIN-03` did.  The supplied statement string was
  transcribed character for character under the proposed name and closed by the shipped theorem as
  a bare term application (`scratch_sdfpin04/VerbatimCheck.lean`, this run), so the two are the SAME
  proposition and this node resolves the supplied statement exactly.
* `_weight_zero` is NOT `_zero_exp`.  `selfDual_eigen_pin_level_four_zero_exp` is the `r ≡ 0` pin at
  this same level — zero EXPONENTS, hence zero weight.  This section's vector has zero WEIGHT with
  NON-zero exponents, which is the whole point of it; `rPinLevelFourWeightZero_ne_zero_pin` is the
  Lean receipt that the two are different vectors.
* `_level_four` ALONE is already taken for `N = 4`, `r = (-2, 6, -2)`, `k = 1`
  (`rPinLevelFourNeg`, `frickeEigenvalue_pin_level_four = -(2i)`, `sqrt_natPow_level_four = 2`), and
  `_level_four_weight_four` / `_level_four_weight_two` for `SDF-PIN-03`'s two vectors.  Every name
  below therefore carries the WEIGHT as well as the level.
* The condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced" — see this
  file's header, and `exists_balanced_add` in `EtaQuotientModularity.lean`, an unrelated lemma about
  `Int.bmod`.

SCOPE: pure eta-quotient / Fricke content, as everywhere in this module.  An identity between
products of values of `ModularForm.eta`.  Nothing here is about `Γ₀(N)`-modularity, holomorphy at
cusps, or physics — see the header. -/

section SdfPin04

/-! ### `SDF-PIN-04` exponent vectors -/

/-- **THE NODE'S EXPONENT VECTOR.**  `r = (-2, 4, -2)` on `(1, 2, 4)`, zero off `Nat.divisors 4`.

Self-dual (`r 1 = -2 = r 4`, `r 2 = 4 = r 2`), weight `∑ r δ = 0 = 2 · 0`, so `k = 0`, NON-CONSTANT
on the divisor set, and — unlike every other `η`-unfolded pin in this file — carrying NEGATIVE
exponents.  It is the eta quotient `η(2z)⁴ / (η(z)² η(4z)²)`.

Distinct from `rPinLevelFourNeg = (-2, 6, -2)` (`k = 1`), from `rPinLevelFourWeightFour = (2, 4, 2)`
(`k = 4`) and from `rPinLevelFourWeightTwo = (1, 2, 1)` (`k = 2`); hence the `WeightZero`. -/
def rPinLevelFourWeightZero : EtaExp :=
  fun δ => if δ = 1 ∨ δ = 4 then (-2 : ℤ) else if δ = 2 then 4 else 0

/-- NEGATIVE CONTROL vector at the node's level and weight: `r = (0, 4, -4)` on `(1, 2, 4)`.
It has the SAME weight sum `∑ r δ = 0 = 2 · 0` as the node's vector, so the weight hypothesis alone
cannot distinguish them, but it is NOT self-dual (`r 1 = 0 ≠ -4 = r 4`).  It exists so that
`selfDual_cond_pin_level_four_weight_zero` is not vacuous; numerically it also FAILS the node's
equation (relative error `0.58`–`1.06`, see this section's header). -/
def rPinLevelFourWeightZeroMispaired : EtaExp :=
  fun δ => if δ = 2 then (4 : ℤ) else if δ = 4 then -4 else 0

/-! ### `SDF-PIN-04` decide-pins — the hypotheses, discharged before anything consumes them -/

/-- The three values of the node's vector on `Nat.divisors 4`, as hand-computed. -/
theorem rPinLevelFourWeightZero_values_pin :
    rPinLevelFourWeightZero 1 = -2 ∧ rPinLevelFourWeightZero 2 = 4
      ∧ rPinLevelFourWeightZero 4 = -2 := by decide

/-- The weight hypothesis: `∑_{δ ∣ 4} r δ = -2 + 4 - 2 = 0 = 2 · 0`, so `k = 0`. -/
theorem rPinLevelFourWeightZero_weight :
    ∑ δ ∈ (4 : ℕ).divisors, rPinLevelFourWeightZero δ = 2 * 0 := by decide

/-- The DUAL vector, evaluated: `δ ↦ r (4/δ)` agrees with `r` at every divisor of `4`.  Stated
without `IsFrickeSelfDual` so that the second route below (`..._eta_via_fricke`) can use it without
touching any definition this module introduces. -/
theorem rPinLevelFourWeightZero_dual_eq_pin :
    ∀ δ ∈ (4 : ℕ).divisors, rPinLevelFourWeightZero (4 / δ) = rPinLevelFourWeightZero δ := by
  decide

/-- Self-duality of the node's vector, by `decide` through `SDF-16`'s `Decidable` instance. -/
theorem selfDual_cond_pin_level_four_weight_zero :
    IsFrickeSelfDual 4 rPinLevelFourWeightZero := by decide

/-- The same, by the route every `selfDual_cond_pin_*` above uses — `unfold IsFrickeSelfDual`, then
`decide` on the bounded quantifier — so that the pin does not depend on `SDF-16` being correct.
Two independent discharges of one hypothesis. -/
theorem selfDual_cond_pin_level_four_weight_zero_unfolded :
    IsFrickeSelfDual 4 rPinLevelFourWeightZero := by
  unfold IsFrickeSelfDual
  decide

/-- The mis-paired control carries the SAME weight sum as the node's vector, so `hk` accepts it. -/
theorem rPinLevelFourWeightZeroMispaired_weight :
    ∑ δ ∈ (4 : ℕ).divisors, rPinLevelFourWeightZeroMispaired δ = 2 * 0 := by decide

/-- **NON-VACUITY of the two self-duality pins.**  Only `hr` rejects the mis-paired vector. -/
theorem not_selfDual_pin_level_four_weight_zero_mispaired :
    ¬ IsFrickeSelfDual 4 rPinLevelFourWeightZeroMispaired := by decide

/-- **THE NODE'S VECTOR IS NOT THE ZERO VECTOR** — the receipt that this is not a respelling of
`selfDual_eigen_pin_level_four_zero_exp` (`r ≡ 0` at the same level, same `k = 0`, same `λ = 1`).
Zero WEIGHT here, not zero EXPONENTS. -/
theorem rPinLevelFourWeightZero_ne_zero_pin :
    rPinLevelFourWeightZero ≠ (0 : EtaExp) := by
  intro h
  have h2 : rPinLevelFourWeightZero 2 = 0 := by rw [h]; rfl
  revert h2
  decide

/-! ### `SDF-PIN-04` radicand and eigenvalue pins — two routes to `s = 1`, then `λ = 1` -/

/-- `s = ∏_{δ ∣ 4} δ^{r δ} = 1⁻² · 2⁴ · 4⁻² = 16 · (1/16) = 1`, computed DIRECTLY from
`Nat.divisors 4 = {1, 2, 4}` with an explicit lemma list.  The `zpow`s at `-2` are the step this
section exercises and no other `η`-unfolded pin in the file does. -/
theorem prod_zpow_pin_level_four_weight_zero :
    (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourWeightZero δ)) = 1 := by
  rw [divisors_four_pin,
    Finset.prod_insert (by decide : (1 : ℕ) ∉ ({2, 4} : Finset ℕ)),
    Finset.prod_insert (by decide : (2 : ℕ) ∉ ({4} : Finset ℕ)), Finset.prod_singleton,
    show rPinLevelFourWeightZero 1 = -2 by decide,
    show rPinLevelFourWeightZero 2 = 4 by decide,
    show rPinLevelFourWeightZero 4 = -2 by decide]
  norm_num

/-- The SAME product reached through `SDF-02`'s general collapse `s = N^k`, i.e. `4⁰`.  Together
with the previous theorem this is a two-route check: `16 · (1/16)` and `4⁰` must be the same real
number.  Neither is a dependency of the node theorem, so both are cross-checks, not plumbing. -/
theorem prod_zpow_selfDual_pin_level_four_weight_zero :
    (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourWeightZero δ)) = ((4 : ℕ) : ℝ) ^ (0 : ℤ) :=
  prod_zpow_selfDual (N := 4) (by norm_num) selfDual_cond_pin_level_four_weight_zero
    (k := 0) rPinLevelFourWeightZero_weight

/-- `√(4⁰) = √1 = 1`.  Stated at the node's LEVEL rather than reusing `sqrt_natPow_zero_weight`,
which is the `N = 6` version, so that the level is held fixed at four throughout this section. -/
theorem sqrt_natPow_level_four_weight_zero :
    Real.sqrt (((4 : ℕ) : ℝ) ^ (0 : ℤ)) = 1 := by
  rw [zpow_zero, Real.sqrt_one]

/-- **THE NODE'S EIGENVALUE.**  `frickeEigenvalue 4 0 = i^{-0} · √(4⁰) = 1 · 1 = 1`.  Stated at the
node's LEVEL rather than reusing `frickeEigenvalue_pin_zero_weight` (`frickeEigenvalue 6 0 = 1`).
Read `..._no_evidence_constant` before treating this as evidence about the constant: at `k = 0`
every factor is `1` for reasons that survive any misspelling of the constant. -/
theorem frickeEigenvalue_pin_level_four_weight_zero : frickeEigenvalue 4 0 = 1 := by
  rw [frickeEigenvalue, sqrt_natPow_level_four_weight_zero]
  norm_num

/-! ### `SDF-PIN-04` regime battery — the three named regimes, as one build obligation -/

/-- **THE THREE REGIMES, DISCHARGED BEFORE THE NODE.**  Conjoining the three existing instance pins
so that the arc's sign/definitional discipline is a build obligation of this section and not a
docstring claim:

* **A**, `N = 1`, `r ≡ 24`, `k = 12` — the statement `eta_S_via_fricke`
  (`EtaQuotientModularity.lean:2246`) proves independently, re-derived along this file's route by
  `selfDual_eigen_pin_level_one_eta_calibration`;
* **B**, the degenerate `r ≡ 0` at the NODE'S OWN level `N = 4`, `k = 0`, `λ = 1`
  (`selfDual_eigen_pin_level_four_zero_exp`) — the case this section's vector must be distinguished
  from, see `rPinLevelFourWeightZero_ne_zero_pin`;
* **C**, a genuine `N > 1` self-dual NON-CONSTANT vector at a NON-zero weight,
  `selfDual_eigen_pin_level_nine_weight_four_eta` (`N = 9`, `r = (1, 6, 1)`, `k = 4`, `λ = 81`),
  which is where the constant is actually pinned — it is not pinned here.

If any of the three ever stopped holding, this line would stop typechecking. -/
theorem selfDual_eigen_pin_level_four_weight_zero_regime_battery {z : ℂ} (hz : z ∈ ℍₒ) :
    (ModularForm.eta (-(1 / z)) ^ (24 : ℕ) = z ^ (12 : ℕ) * ModularForm.eta z ^ (24 : ℕ))
    ∧ (etaQuotient 4 (0 : EtaExp) (-(1 / (((4 : ℕ) : ℂ) * z)))
        = (1 : ℂ) * z ^ (0 : ℤ) * etaQuotient 4 (0 : EtaExp) z)
    ∧ (ModularForm.eta (-(1 / ((9 : ℂ) * z))) ^ (1 : ℤ)
          * ModularForm.eta ((3 : ℂ) * (-(1 / ((9 : ℂ) * z)))) ^ (6 : ℤ)
          * ModularForm.eta ((9 : ℂ) * (-(1 / ((9 : ℂ) * z)))) ^ (1 : ℤ)
        = (81 : ℂ) * z ^ (4 : ℤ)
          * (ModularForm.eta z ^ (1 : ℤ) * ModularForm.eta ((3 : ℂ) * z) ^ (6 : ℤ)
            * ModularForm.eta ((9 : ℂ) * z) ^ (1 : ℤ))) :=
  ⟨selfDual_eigen_pin_level_one_eta_calibration hz,
   selfDual_eigen_pin_level_four_zero_exp hz,
   selfDual_eigen_pin_level_nine_weight_four_eta hz⟩

/-! ### `SDF-PIN-04` — THE NODE -/

/-- **`SDF-PIN-04` — THE NODE.  `SDF-05` at level four and weight ZERO, written out in
`ModularForm.eta`:**

```
η(-1/(4z))⁻² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))⁻²  =  η(z)⁻² · η(2z)⁴ · η(4z)⁻²
```

`N = 4`, `r = (-2, 4, -2)`, `k = 0`, `s = 2⁴ · 4⁻² = 1 = 4⁰`, `λ = 1` — so the eigenvalue and the
`z^k` factor are both ABSENT from the statement and the eta quotient `η(2z)⁴/(η(z)²η(4z)²)` is
literally INVARIANT under the Fricke involution `z ↦ -1/(4z)`.  It is the fourth statement in this
file with every definition this module introduces unfolded away, the FIRST with negative exponents,
and the first whose radicand `s = 1` arises by cancellation rather than triviality.

Reached by instantiating `SDF-05` (`etaQuotient_fricke_selfDual`) at
`(N, r, k) = (4, rPinLevelFourWeightZero, 0)`, substituting the eigenvalue numeral
(`frickeEigenvalue_pin_level_four_weight_zero`) and unfolding the three-factor divisor product by an
EXPLICIT lemma list — `divisors_four_pin`, two `Finset.prod_insert`s, `Finset.prod_singleton`, the
three `decide`d exponent values, the casts and `zpow_zero` — with no bare `norm_num` and no bare
`simp`, so nothing can be smuggled in from a default simp set.  A second and independent derivation
straight from `etaQuotient_fricke` follows below.

READ `..._no_evidence_constant` BEFORE CITING THIS AS EVIDENCE ABOUT THE CONSTANT: at `k = 0` there
is none.  What it does pin is the dual-vector substitution on a NON-constant vector and the negative
`zpow` bookkeeping.

Verified numerically OUTSIDE Lean this run at 60 dps (`η` as a 1500-factor `q`-product) before being
asserted: relative error `≤ 2.9e-60` at six points of `ℍ`, while `λ = -1`, `λ = i`, `λ = 16`,
`λ = 1/16`, an inserted `z¹`, an inserted `z⁻¹` and the mis-paired vector all fail at relative error
between `0.73` and `15.0`. -/
theorem selfDual_eigen_pin_level_four_weight_zero_eta {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = ModularForm.eta z ^ (-2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * z) ^ (-2 : ℤ) := by
  -- (1) `SDF-05` at the instance, with the eigenvalue still symbolic.
  have h := etaQuotient_fricke_selfDual (N := 4) (by norm_num) (r := rPinLevelFourWeightZero)
    selfDual_cond_pin_level_four_weight_zero (k := 0) rPinLevelFourWeightZero_weight hz
  -- (2) The eigenvalue numeral, from `SDF-DEF-02` alone — a route that never touches `s`.
  rw [frickeEigenvalue_pin_level_four_weight_zero] at h
  -- (3) The divisor product unfolded to the three `η` factors, and `1 · z⁰ ·` removed, by explicit
  -- list.
  simp only [etaQuotient, divisors_four_pin,
    Finset.prod_insert (by decide : (1 : ℕ) ∉ ({2, 4} : Finset ℕ)),
    Finset.prod_insert (by decide : (2 : ℕ) ∉ ({4} : Finset ℕ)),
    Finset.prod_singleton,
    show rPinLevelFourWeightZero 1 = -2 by decide,
    show rPinLevelFourWeightZero 2 = 4 by decide,
    show rPinLevelFourWeightZero 4 = -2 by decide,
    Nat.cast_one, one_mul, Nat.cast_ofNat, zpow_zero] at h
  -- (4) `Finset.prod` unfolds RIGHT-associated; the statement is written LEFT-associated.  Two
  -- `mul_assoc` rewrites, no `ring`, so no numerical step can hide here.
  rw [← mul_assoc, ← mul_assoc (ModularForm.eta z ^ (-2 : ℤ))] at h
  exact h

/-! ### `SDF-PIN-04` second route — straight from `F3.2-A7`, bypassing this module entirely -/

/-- The dual-vector collapse at this instance, stated on `etaQuotient` and proved by
`Finset.prod_congr` over the bare `decide` fact `rPinLevelFourWeightZero_dual_eq_pin`.  This is the
one step the general lemma `SDF-01` (`etaQuotient_congr_divisors`) performs; doing it by hand here
keeps the second route below independent of every definition this module introduces. -/
theorem etaQuotient_dual_pin_level_four_weight_zero (w : ℂ) :
    etaQuotient 4 (fun δ => rPinLevelFourWeightZero (4 / δ)) w
      = etaQuotient 4 rPinLevelFourWeightZero w :=
  Finset.prod_congr rfl fun δ hδ => by
    show ModularForm.eta ((δ : ℂ) * w) ^ rPinLevelFourWeightZero (4 / δ)
        = ModularForm.eta ((δ : ℂ) * w) ^ rPinLevelFourWeightZero δ
    rw [rPinLevelFourWeightZero_dual_eq_pin δ hδ]

/-- **SECOND, INDEPENDENT DERIVATION of the node's equation**, straight from `etaQuotient_fricke`
(`F3.2-A7`, `EtaQuotientModularity.lean:2212`) with the raw constant
`i^{-k} · N^k · s^{-1/2}` evaluated in place: `s = 1` by
`prod_zpow_pin_level_four_weight_zero`, `√1 = 1` by `Real.sqrt_one`, and the dual quotient replaced
by `etaQuotient_dual_pin_level_four_weight_zero`.

It uses NONE of `IsFrickeSelfDual`, `frickeEigenvalue`, `SDF-02`, `SDF-03`, `SDF-04` or `SDF-05`.
Together with the node theorem it makes the agreement of this module's packaged constant with the
upstream raw constant a `lake build` obligation rather than a docstring claim — see
`..._routes_agree`. -/
theorem selfDual_eigen_pin_level_four_weight_zero_eta_via_fricke {z : ℂ} (hz : z ∈ ℍₒ) :
    ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = ModularForm.eta z ^ (-2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * z) ^ (-2 : ℤ) := by
  have h := etaQuotient_fricke (N := 4) (by norm_num) rPinLevelFourWeightZero
    (k := 0) rPinLevelFourWeightZero_weight hz
  rw [prod_zpow_pin_level_four_weight_zero, Real.sqrt_one,
    etaQuotient_dual_pin_level_four_weight_zero] at h
  simp only [etaQuotient, divisors_four_pin,
    Finset.prod_insert (by decide : (1 : ℕ) ∉ ({2, 4} : Finset ℕ)),
    Finset.prod_insert (by decide : (2 : ℕ) ∉ ({4} : Finset ℕ)),
    Finset.prod_singleton,
    show rPinLevelFourWeightZero 1 = -2 by decide,
    show rPinLevelFourWeightZero 2 = 4 by decide,
    show rPinLevelFourWeightZero 4 = -2 by decide,
    Nat.cast_one, one_mul, Nat.cast_ofNat, zpow_zero, neg_zero, Complex.ofReal_one,
    inv_one] at h
  rw [← mul_assoc, ← mul_assoc (ModularForm.eta z ^ (-2 : ℤ))] at h
  exact h

/-- **THE TWO ROUTES, PAIRED — a build obligation.**  The same proposition, proved once through
`SDF-05`'s packaged `frickeEigenvalue 4 0` and once through `etaQuotient_fricke`'s raw
`i^{-0} · 4⁰ · (√s)⁻¹`.  If this file's constant ever disagreed with the upstream one at this
instance, one of the two conjuncts would fail to typecheck. -/
theorem selfDual_eigen_pin_level_four_weight_zero_routes_agree {z : ℂ} (hz : z ∈ ℍₒ) :
    (ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = ModularForm.eta z ^ (-2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * z) ^ (-2 : ℤ))
    ∧ (ModularForm.eta (-(1 / ((4 : ℂ) * z))) ^ (-2 : ℤ)
        * ModularForm.eta ((2 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * (-(1 / ((4 : ℂ) * z)))) ^ (-2 : ℤ)
      = ModularForm.eta z ^ (-2 : ℤ) * ModularForm.eta ((2 : ℂ) * z) ^ (4 : ℤ)
        * ModularForm.eta ((4 : ℂ) * z) ^ (-2 : ℤ)) :=
  ⟨selfDual_eigen_pin_level_four_weight_zero_eta hz,
   selfDual_eigen_pin_level_four_weight_zero_eta_via_fricke hz⟩

/-! ### `SDF-PIN-04`'s REACH — what this pin is and is not evidence for -/

/-- **`SDF-PIN-04` REACH 1 of 3 — the exponent PAIRING IS visible here.**  `r 1 = -2 ≠ 4 = r 2`, so
the vector is NON-CONSTANT on `Nat.divisors 4` and a statement that had TRANSPOSED the pairing
`δ ↔ N/δ` would not close this pin.  Contrast
`selfDual_eigen_pin_level_two_no_evidence_pairing`. -/
theorem selfDual_eigen_pin_level_four_weight_zero_evidence_pairing :
    rPinLevelFourWeightZero 1 ≠ rPinLevelFourWeightZero 2 := by decide

/-- **`SDF-PIN-04` REACH 2 of 3 — NEGATIVE exponents, in an `η`-unfolded statement.**  `r 1 < 0`,
`r 4 < 0`, `r 2 > 0`, so both signs of `zpow` occur in one identity.  This is the property that
separates this pin from `selfDual_eigen_pin_level_two_eta`, `..._level_four_weight_four_eta` and
`..._level_nine_weight_four_eta`, all of which have `r > 0` throughout;
`selfDual_eigen_pin_level_four_neg` has negative exponents but is stated on `etaQuotient`, not on
`η`. -/
theorem selfDual_eigen_pin_level_four_weight_zero_evidence_negative_exponents :
    rPinLevelFourWeightZero 1 < 0 ∧ rPinLevelFourWeightZero 4 < 0
      ∧ 0 < rPinLevelFourWeightZero 2 := by decide

/-- **`SDF-PIN-04` REACH 3 of 3 — `s = 1` by CANCELLATION, not by triviality.**  `2⁴ = 16` and
`4⁻² = 1/16`, and `16 ≠ 1`.  In `selfDual_eigen_pin_level_four_zero_exp` (`r ≡ 0`, same level, same
`k = 0`, same `λ = 1`) every factor of the product is `1` on its own; here two non-trivial factors
cancel.  So the radicand computation `prod_zpow_pin_level_four_weight_zero` is doing real `zpow`
arithmetic, which is what makes this pin more than a restatement of the `r ≡ 0` one. -/
theorem selfDual_eigen_pin_level_four_weight_zero_evidence_radicand_cancels :
    ((2 : ℕ) : ℝ) ^ (rPinLevelFourWeightZero 2) = 16
    ∧ ((4 : ℕ) : ℝ) ^ (rPinLevelFourWeightZero 4) = 1 / 16
    ∧ ((2 : ℕ) : ℝ) ^ (rPinLevelFourWeightZero 2) ≠ 1 := by
  rw [show rPinLevelFourWeightZero 2 = 4 by decide,
    show rPinLevelFourWeightZero 4 = -2 by decide]
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **`SDF-PIN-04` LIMITATION, stated in Lean so the node cannot be oversold — THE substantive
caveat of this section.**  At `k = 0` EVERY component of the Fricke constant
`λ = i^{-k} · N^k · s^{-1/2}` collapses to `1` for a reason that survives any misspelling of it:

* `i^{-0} = i^{+0}`, so the SIGN of the `i`-exponent is invisible;
* `4⁰ = 9⁰`, so the POWER — and indeed the LEVEL — is invisible;
* `s = 1`, so `(√s)⁻¹ = √s` and the SIDE OF THE FRACTION the square root sits on is invisible;
* `z⁰ = 1` for every `z`, so the `z`-exponent is invisible too.

This pin therefore pins NO component of the constant, exactly as
`selfDual_pin_level_one_no_evidence_*` records for the `N = 1` pin, and must not be counted toward
this arc's constant-pinning instances.  Those are `selfDual_eigen_pin_level_six` (`λ = 46656`),
`selfDual_eigen_pin_level_four_neg` (`λ = -2i`), `selfDual_eigen_pin_level_two_eta` (`λ = -i√2`) and
`selfDual_eigen_pin_level_four_weight_two_eta` (`λ = -4`).  What this pin DOES carry is
REACH 1–3 above. -/
theorem selfDual_eigen_pin_level_four_weight_zero_no_evidence_constant :
    (I : ℂ) ^ (-(0 : ℤ)) = (I : ℂ) ^ ((0 : ℤ))
    ∧ ((4 : ℕ) : ℂ) ^ (0 : ℤ) = ((9 : ℕ) : ℂ) ^ (0 : ℤ)
    ∧ ((Real.sqrt (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourWeightZero δ)) : ℝ) : ℂ)⁻¹
        = ((Real.sqrt (∏ δ ∈ (4 : ℕ).divisors, (δ : ℝ) ^ (rPinLevelFourWeightZero δ)) : ℝ) : ℂ)
    ∧ ∀ w : ℂ, w ^ (0 : ℤ) = 1 := by
  refine ⟨by norm_num, by norm_num, ?_, fun w => zpow_zero w⟩
  rw [prod_zpow_pin_level_four_weight_zero, Real.sqrt_one]
  norm_num

end SdfPin04

end SocrateAI.ModularForms
