/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

# QUARANTINE — a machine-refuted statement, kept for the refutation to point at

**This module is deliberately NOT imported by `Lean/SocrateAI.lean` and is not part of the
default build target.** It exists so that `sorryAx` has a permanent, documented declaration to
be asserted of, matching this project's "quarantine, don't delete" convention (see
`QUARANTINE.md`-style handling elsewhere in the SocrateAI programme).

`ligozat_trivial_multiplier_of_twelve_dvd` (named `ligozat_general` before 2026-09-08) asserts
Ligozat's criterion at general `N` in a *trivial-multiplier* form. **That statement is FALSE**,
not merely open: `eta01_seventeen_refutes_trivial_multiplier`
(`Lean/SocrateAI/ModularForms/EtaLigozatGeneral.lean`) proves, `sorry`-free and using neither of
the two statements it separates, that this theorem's conclusion is incompatible with Ligozat's
correct (Kronecker-character) conclusion at one explicit witness (`N=17`, `r=(21,3)`, `k=12`,
`γ=!![6,1;17,3] ∈ Γ₀(17)`). See that file and `ATTRIBUTION.md` \S3 for the full account.

**Do not import this module from `Lean/SocrateAI.lean`. Do not attempt to prove this theorem.**
-/
import SocrateAI.ModularForms.EtaQuotientModularity

open Matrix CongruenceSubgroup ModularForm Complex
open UpperHalfPlane hiding I
open scoped MatrixGroups Real

namespace SocrateAI.ModularForms

/-- **ETA-01 (OPEN).**  Ligozat's criterion at **general** `N`: under Ligozat's congruences (i)
and (ii) and `24 ∣ ...`-type divisibility on `k`, the eta quotient `f = ∏_{δ ∣ N} η(δz)^{r_δ}`
transforms with **trivial** multiplier on all of `Γ₀(N)`.

This is the statement that `EtaQuotientModularity.multiplier_trivial_of_congr` currently only
gets for `N ≤ 4` (via `{-I, T, V}` generation) and `EtaQuotientPrimeLevel` only for
`N ∈ {5, 7, 13}` (via coset enumeration plus elliptic fixed points).  Neither route generalises;
`DRK-06` is the route that does, because it evaluates the multiplier directly instead of
evaluating it on a generating set.

HONESTY (LL-1): the hypothesis `hkdvd` is stated as `12 ∣ k` because that is the threshold the
prime-level results needed (`4 ∣ k` at `p = 5`, `6 ∣ k` at `p = 7`, `12 ∣ k` at `p = 13`), and
because `not_multiplier_trivial_p5` proves that `Even k` is NOT enough.  Whether `12 ∣ k` is
sharp at general `N` is **not** claimed here; the classical statement uses a Kronecker character
`χ(d)` rather than a divisibility hypothesis, and identifying our multiplier with `χ(d)` is a
further open node (the `F3.2-B3` analogue).

**REFUTED 2026-09-08 — THIS STATEMENT IS FALSE, NOT MERELY OPEN (LL-1).**  It was called
`ligozat_general` until this run; it has been RENAMED (not deleted) because a counterexample is
now on file.  Take `N = 17`, `r = (r₁, r₁₇) = (21, 3)`, `k = 12`, `γ = !![6, 1; 17, 3] ∈ Γ₀(17)`.
Every hypothesis holds — `Σ_δ r_δ = 24 = 2k`, `Σ_δ δ r_δ = 72 = 24·3`,
`Σ_δ (17/δ) r_δ = 360 = 24·15`, `12 ∣ 12` — yet Ligozat's character value there is
`(17³ / 3) = (4913 / 3) = J(2 | 3) = -1`, and a 4000-term `η`-product evaluation of
`f(γz)/((cz+d)¹² f(z))` returns `-1.0000000000000 - 1.1e-14 i`.  So the conclusion `f(γz) =
(cz+d)^k f(z)` fails at that `γ`.  See `EtaLigozatGeneral.lean`:
`eta01_seventeen_refutes_trivial_multiplier` makes the incompatibility machine-checked and
`sorry`-free.  **Do not spend time trying to prove this.**  The correct general-`N` statement is
`SocrateAI.ModularForms.ligozat_general` in `EtaLigozatGeneral.lean`, with the Kronecker
character in place of the `12 ∣ k` hypothesis. -/
theorem ligozat_trivial_multiplier_of_twelve_dvd (N : ℕ) (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r) (hkdvd : (12 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) (z : ℍ) :
    etaQuotientH N r (γ • z) = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH N r z := by
  -- OPEN: PERMANENTLY.  This statement is FALSE — see the docstring and
  -- OPEN: `eta01_seventeen_refutes_trivial_multiplier` (N = 17, r = (21,3), k = 12,
  -- OPEN: γ = !![6,1;17,3], where the multiplier is -1 and not 1).  The `sorry` is kept, and the
  -- OPEN: declaration quarantined rather than deleted, so that the refutation has something to
  -- OPEN: point at; the correct statement is `ligozat_general` in `EtaLigozatGeneral.lean`.
  sorry

/-- info: 'SocrateAI.ModularForms.ligozat_trivial_multiplier_of_twelve_dvd' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_trivial_multiplier_of_twelve_dvd

end SocrateAI.ModularForms
