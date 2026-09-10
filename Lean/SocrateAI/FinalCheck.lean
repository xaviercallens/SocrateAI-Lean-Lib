/-
FinalCheck — axiom-footprint gate, adopted from anthropics/fermats-last-theorem.

The FLT repository makes its axiom audit a BUILD TARGET: `#guard_msgs in #print axioms`
turns the expected footprint into part of compilation, so a footprint that drifts fails
the build instead of going silently stale (the failure mode recorded in
SocrateAI-Mathesis LL-2: "a declared axiom footprint went stale one edit after it was
written").  Mathesis HARDNESS.md H1: the check is `#print axioms`, never the source text.

Every headline theorem of the library gets a guard here.  Add a guard when you add a
headline theorem; a PR that widens a footprint must edit this file to say so.
-/
import SocrateAI.ModularForms.FrickeInvolution
import SocrateAI.ModularForms.FrickeSlash
import SocrateAI.ModularForms.FrickeModular
import SocrateAI.ModularForms.FrickeComposite
import SocrateAI.ModularForms.EtaQuotient
-- F3.1-B1 lives in the ANALYTIC file (it mentions `ModularForm.eta_q`), not in the arithmetic
-- `EtaQuotient`.  This import also puts the still-`sorry` F3.2 statement (as of F3.2-A8 there
-- is exactly ONE: the terminal `multiplier_trivial_of_congr`) in FinalCheck's cone, which is
-- deliberate: the tripwire guard below pins that terminal one as UNPROVED.
import SocrateAI.ModularForms.EtaQuotientModularity
-- F3.1-B13 and the F3.1-OBSTRUCTED record.  Importing it here puts `meromorphicOrderAt` and
-- Mathlib's cusp-function API in FinalCheck's cone, so the "Mathlib has no order at a cusp"
-- claim that F3.1-OBSTRUCTED refutes cannot silently come back: the guards below would fail.
-- F3.2-C3: Ligozat at the genus-zero primes p = 5, 7, 13.  Generation of Gamma0(p) by
-- {-I, T, V} plus explicit ELLIPTIC elements, and the multiplier evaluated on all of them.
import SocrateAI.ModularForms.EtaQuotientPrimeLevel
import SocrateAI.ModularForms.EtaQuotientCuspOrder
-- F3.2-C2: Ligozat's cusp order as a Θ-asymptotic at every cusp.  Importing it here also puts
-- Mathlib's `exp_isBigO_discriminant` in FinalCheck's cone, which is what the external pin
-- `exp_isBigO_discriminant_of_cusp_order` is checked against.
import SocrateAI.ModularForms.EtaQuotientCuspTheta
-- Run 4 (DRK-*).  Importing these HERE is what makes the run-4 axiom audit a build dependency:
-- the DRK-00 sign-discipline pins, the DRK-01 port, and the INVERTED tripwires certifying that
-- DRK-02/03/04/05/06/07 and ETA-01 are still UNPROVED, all fail the build if they drift.
import SocrateAI.NumberTheory.DedekindSum
import SocrateAI.NumberTheory.RademacherPhi
import SocrateAI.ModularForms.EtaMultiplier
import SocrateAI.ModularForms.EtaMultiplierNeg
import SocrateAI.ModularForms.EtaPhiSum
import SocrateAI.NumberTheory.DedekindSumJacobi
import SocrateAI.ModularForms.KroneckerJacobi
import SocrateAI.ModularForms.EtaLigozatKronecker
-- ETA-01 (run 5): the c <= 0 reduction, the N <= 4 package, and the N = 17 refutation of the
-- `12 | k` form.  Importing it here makes the ETA-01 audit -- including the two INVERTED
-- tripwires certifying that ETA-01 general-N is still open -- a build dependency.
import SocrateAI.ModularForms.EtaLigozatGeneral
-- DRK-12 (run 6): Ligozat at level 11.  Importing it here makes the level-11 audit a build
-- dependency -- including the INVERTED tripwire on `etaProductEleven_via_ligozat_general`, which
-- is what keeps "ETA-01 is still open" machine-checked rather than asserted.
import SocrateAI.ModularForms.EtaLigozatLevelEleven
-- F3.1-B0 build gate: these two Mathlib modules are the analytic prerequisite for every F3.2
-- node.  Importing them HERE is deliberate — it makes the gate a build dependency of the axiom
-- audit, so the gate cannot silently regress.
import Mathlib.NumberTheory.ModularForms.Discriminant
import Mathlib.NumberTheory.ModularForms.DedekindEta
-- Run 5 (TDUAL-*).  Importing this HERE makes the run-5 axiom audit a build dependency: the
-- TDUAL-M0 sign-discipline pins, and the INVERTED tripwires certifying that TDUAL-M1 and TDUAL-01
-- are still UNPROVED, all fail the build if they drift.
import SocrateAI.StringTheory.TDualityBridge
-- Run 11 (SDF-*).  Importing this HERE makes the SDF axiom audit a build dependency: the six
-- `SDF-DEF-01` condition pins, the non-constancy witness and the negative control all fail the
-- build if their footprints drift.  It also puts the still-`sorry` SDF-01 … SDF-13 statements in
-- FinalCheck's cone, which is what the INVERTED tripwires at the end of section `SdfDef01` pin.
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms

/-- info: 'SocrateAI.ModularForms.frickeMatrix_det' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeMatrix_det

/-- info: 'SocrateAI.ModularForms.frickeW_mem_GLPos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_mem_GLPos

/-- info: 'SocrateAI.ModularForms.frickeW_sq_coe' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_sq_coe

/-- info: 'SocrateAI.ModularForms.gamma0_dvd_lower_left' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms gamma0_dvd_lower_left

/-- info: 'SocrateAI.ModularForms.frickeConj_mem_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeConj_mem_Gamma0

/-- info: 'SocrateAI.ModularForms.frickeW_intertwine' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_intertwine

/-- info: 'SocrateAI.ModularForms.frickeW_conj_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_conj_eq

/-- info: 'SocrateAI.ModularForms.frickeW_normalizes_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_normalizes_Gamma0

-- FRK-08 (FrickeSlash)
/-- info: 'SocrateAI.ModularForms.slash_frickeW_invariant' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms slash_frickeW_invariant

-- FRK-09 (FrickeModular)
/-- info: 'SocrateAI.ModularForms.frickeW_conjAct_le' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_conjAct_le
/-- info: 'SocrateAI.ModularForms.isCusp_frickeW_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms isCusp_frickeW_smul
/-- info: 'SocrateAI.ModularForms.frickeModularOperator' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeModularOperator

-- FRK-10 core (FrickeComposite)
/-- info: 'SocrateAI.ModularForms.frickeW_sq_det' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_sq_det
/-- info: 'SocrateAI.ModularForms.frickeW_sq_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_sq_smul
/-- info: 'SocrateAI.ModularForms.frickeW_sq_slash' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_sq_slash

-- F3.1-A0 (EtaQuotient) — the exponent-vector type and the divisor-restriction principle
-- that licenses carrying it as a total function `ℕ → ℤ`.
/-- info: 'SocrateAI.ModularForms.EtaExp' does not depend on any axioms -/
#guard_msgs in #print axioms EtaExp
/-- info: 'SocrateAI.ModularForms.EtaExp.trunc' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms EtaExp.trunc
/-- info: 'SocrateAI.ModularForms.EtaExp.sum_divisors_congr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms EtaExp.sum_divisors_congr
/-- info: 'SocrateAI.ModularForms.EtaExp.sum_divisors_trunc' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms EtaExp.sum_divisors_trunc
/-- info: 'SocrateAI.ModularForms.EtaExp.trunc_trunc' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms EtaExp.trunc_trunc

-- F3.1-A1 (EtaQuotient) — the weight `k = (1/2) Σ_δ r_δ`, its additivity in the exponent
-- vector, and the integrality predicate `HasIntegralWeight` together with the proof that the
-- predicate really characterises integrality of the weight.
/-- info: 'SocrateAI.ModularForms.etaQuotientWeight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientWeight
/-- info: 'SocrateAI.ModularForms.HasIntegralWeight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms HasIntegralWeight
/-- info: 'SocrateAI.ModularForms.etaQuotientWeight_add' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientWeight_add
/-- info: 'SocrateAI.ModularForms.hasIntegralWeight_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms hasIntegralWeight_iff

-- F3.1-A2 (EtaQuotient) — Ligozat's cusp-order expression.  A *definition*: nothing in the
-- library claims it is an order of vanishing of anything (that claim needs the eta multiplier
-- system on Γ₀(N), absent from Mathlib — see F3.1-OBSTRUCTED and the EtaQuotient docstring).
-- What is guarded here is that it elaborates with the standard footprint and no `sorryAx`.
-- Its transcription fidelity is guarded separately, by the kernel-decided `#guard` block that
-- sits next to the definition in EtaQuotient.lean (valence identity at levels 1, 2, 4, 6, 9).
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder

-- F3.1-A3 (EtaQuotient) — the cusp `∞` (denominator `d = N`).  A theorem *about* the
-- transcribed definition: `gcd(N,δ) = δ` on divisors and `gcd(N, N/N) = 1` collapse the
-- general expression to `(1/24) Σ_δ δ·r_δ`.  `_num` is the cleared-denominator form, the
-- integer `Σ_δ δ·r_δ` that Ligozat's first congruence constrains mod 24.
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_infty' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder_infty
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_infty_num' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder_infty_num

-- F3.1-A4 (EtaQuotient) — the cusp `0` (denominator `d = 1`).  The companion of A3 at the other
-- distinguished cusp: `gcd(1,δ) = 1` and `gcd(1, N/1) = 1` collapse the general expression to
-- `(N/24) Σ_δ r_δ/δ`.  The stated hypothesis `N ≠ 0` is not used by the proof (the collapse is
-- unconditional at `d = 1`); the binder is retained for uniformity with `_infty`, and the build
-- emits an unused-variable warning to that effect.
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder_zero

-- F3.1-A5 (EtaQuotient) — the cusp `0`, second form.  The same value rewritten as
-- `(1/24) Σ_δ (N/δ)·r_δ`, the integer combination Ligozat's *second* congruence constrains
-- mod 24.  The step that needs `δ ∣ N` is `Nat.cast_div`: `((N/δ : ℕ) : ℚ) = (N : ℚ)/(δ : ℚ)`
-- holds only on the divisors, so it is applied pointwise under `Finset.sum_congr`.
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_zero_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder_zero_eq

-- F3.1-A6 (EtaQuotient) — `ℤ`-linearity of the cusp-order expression in the exponent vector:
-- additive, homogeneous, zero on the zero vector.  This is what makes the order compositional
-- (read off one η-factor at a time) and makes Ligozat's holomorphy hypothesis a system of
-- *linear* inequalities in `r`.  Like A3/A4/A5 these are theorems *about* the transcribed
-- definition: identities of rational numbers, claiming nothing about `η`.  Note that neither
-- `_add` nor `_smul` needs a hypothesis on `N` or `d` — the identities hold termwise even
-- where the denominator `gcd(d, N/d)·d·δ` vanishes, because `x/0 = 0` in `ℚ`.
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_add' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder_add
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder_smul
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder_zero_exp

-- F3.1-A7 (EtaQuotient) — Ligozat's hypotheses as predicates on `(N, r)` alone, and the two
-- bridge lemmas identifying each congruence with integrality of a cusp order.  Note what is and
-- is not guarded here: `ligozatCongr1_iff` is the equivalence
--   `24 ∣ Σ_δ δ·r_δ  ↔  etaQuotientCuspOrder N r N ∈ ℤ`
-- between a divisibility in `ℤ` and an integrality in `ℚ`, and `ligozatCongr2_iff` the same at
-- `d = 1` with `Σ_δ (N/δ)·r_δ`.  Neither is the assertion that the eta quotient is invariant
-- under `T` or under `W_N` — those readings need the eta multiplier system (F3.2-A6, F3.2-A8)
-- and are nowhere claimed in EtaQuotient.lean.  `dvd24_iff_isInt_of_mul_eq` is the shared
-- engine (`ℤ ↪ ℚ` arithmetic, no divisor sum in it) and `etaQuotientCuspOrder_zero_num` the
-- cleared-denominator form of A5 that feeds the `d = 1` instance.
/-- info: 'SocrateAI.ModularForms.LigozatCongr1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms LigozatCongr1
/-- info: 'SocrateAI.ModularForms.LigozatCongr2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms LigozatCongr2
/-- info: 'SocrateAI.ModularForms.LigozatHolomorphic' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms LigozatHolomorphic
/-- info: 'SocrateAI.ModularForms.dvd24_iff_isInt_of_mul_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dvd24_iff_isInt_of_mul_eq
/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_zero_num' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientCuspOrder_zero_num
/-- info: 'SocrateAI.ModularForms.ligozatCongr1_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozatCongr1_iff
/-- info: 'SocrateAI.ModularForms.ligozatCongr2_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozatCongr2_iff

-- F3.1-A8 (EtaQuotient) — the Dedekind psi function and the cusp-count divisor sum, with the
-- two identities that determine `ψ` on every `N` (multiplicativity on coprimes and the
-- prime-power value) and the multiplicativity of the cusp count.  What is guarded here is
-- ARITHMETIC ONLY: `dedekindPsi N = (∏_{p ∣ N}(p+1)) · (N / ∏_{p ∣ N} p)` and
-- `numCusps N = Σ_{d ∣ N} φ(gcd(d, N/d))` are definitions of natural-number-valued arithmetic
-- functions.  The classical readings "`ψ(N)` is the index `[SL(2,ℤ) : Γ₀(N)]`" and "`numCusps N`
-- is the number of cusps of `Γ₀(N)`" are NOT proved — Mathlib has no `Γ₀(N)` index formula and
-- no cusp-count theorem, and nothing in EtaQuotient.lean claims either.  The numerics are pinned
-- by eight kernel-decided `#guard`s in the file itself (`ψ(1) = 1`, `ψ(5) = 6`, `ψ(8) = 12`,
-- `ψ(12) = 24`, `numCusps 12 = 6` and two multiplicativity instances).
/-- info: 'SocrateAI.ModularForms.dedekindPsi' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dedekindPsi
/-- info: 'SocrateAI.ModularForms.numCusps' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms numCusps
/-- info: 'SocrateAI.ModularForms.dedekindPsi_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dedekindPsi_mul
/-- info: 'SocrateAI.ModularForms.dedekindPsi_prime_pow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dedekindPsi_prime_pow
/-- info: 'SocrateAI.ModularForms.numCusps_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms numCusps_mul

-- F3.1-A9 (EtaQuotient) — the per-δ core identity
--   `Σ_{d ∣ N} φ(gcd(d, N/d)) · gcd(d,δ)² / (gcd(d, N/d) · d) = δ · ψ(N) / N`   (δ ∣ N, N ≠ 0),
-- proved by `Nat.recOnPosPrimePosCoprime`: multiplicative in the pair `(N, δ)`
-- (`ligozatCuspSum_mul`), explicit finite geometric sum on prime powers
-- (`ligozatCuspSum_prime_pow`).  ARITHMETIC ONLY, again: this is an identity between rational
-- numbers built from `Nat.divisors`, `Nat.totient` and `Nat.gcd`.  The classical reading — that
-- it is the valence identity for eta quotients, summed over the cusps of `Γ₀(N)` — is a reading
-- and is NOT proved here, for the same reason A8's readings are not: Mathlib has no `Γ₀(N)` cusp
-- theory and no eta multiplier system.  The statement itself is pinned by a kernel-checked
-- numeric instance at `(N, δ) = (12, 4)` in EtaQuotient.lean, and was program-checked outside
-- Lean for every `N < 400` and every `δ ∣ N`.
/-- info: 'SocrateAI.ModularForms.ligozatCuspSum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozatCuspSum
/-- info: 'SocrateAI.ModularForms.ligozatCuspSum_prime_pow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozatCuspSum_prime_pow
/-- info: 'SocrateAI.ModularForms.ligozatCuspSum_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozatCuspSum_mul
/-- info: 'SocrateAI.ModularForms.ligozatCuspSum_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozatCuspSum_eq
/-- info: 'SocrateAI.ModularForms.sum_totient_gcd_sq_div' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sum_totient_gcd_sq_div

-- F3.1-A10 (EtaQuotient) — the valence identity for eta quotients, as pure arithmetic:
--   `Σ_{d ∣ N} φ(gcd(d, N/d)) · ord(N, r, d) = k · ψ(N) / 12`,  `k = (1/2) Σ_δ r_δ`,
-- for every `N ≠ 0` and EVERY exponent vector `r` (no Ligozat congruence is assumed).  Proved
-- from A9 by `Finset.sum_comm` plus the cancellation of `δ` and `N`; contains no analysis and
-- uses no multiplier system, which is why it is provable here while F3.2 is obstructed.
-- SCOPE, since the name invites over-reading: this is an identity of RATIONAL NUMBERS about the
-- transcribed definition A2 and the arithmetic function A8.  It does NOT assert that
-- `etaQuotientCuspOrder` is an order of vanishing, that `numCusps` counts cusps of `Γ₀(N)`, or
-- that `dedekindPsi N = [SL(2,ℤ) : Γ₀(N)]`; none of the three is proved anywhere in this
-- development.  Its value is that the NUMERICAL PREDICTION of the analytic valence theorem is
-- now a theorem, which independently checks A2's transcription.  Statement pinned by
-- kernel-decided guards at `N = 16` and `N = 36` (levels with cusps of multiplicity 2), each
-- side guarded separately, and program-checked outside Lean on 4000 random `(N, r)`.
/-- info: 'SocrateAI.ModularForms.sum_etaQuotientCuspOrder' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sum_etaQuotientCuspOrder

-- ---------------------------------------------------------------------------------------------
-- F3.1-B0 gate witness declaration.
--
-- READ THE NAME LITERALLY: `etaAnalyticCone_available` asserts that the eta analytic cone IS
-- AVAILABLE in this workspace, and nothing else.  It is a one-line re-export of MATHLIB's
-- `ModularForm.eta_comp_eq_csqrt_I_inv`.  SocrateAI did not prove the S-transformation and does
-- not claim to; the declaration exists so the F3.1-B0 DAG node has a `lean_name` that resolves
-- (dag/check_dag.py rule 3), and so that losing the `.olean`s breaks the build loudly.
section GateWitness
open Complex
open UpperHalfPlane hiding I

/-- **F3.1-B0 build-gate witness — NOT a SocrateAI result.**  Mathlib's eta S-transformation
`η(-1/z) = (√I)⁻¹ · √z · η(z)`, re-exported verbatim.  F3.2 must USE this, never reprove it. -/
theorem SocrateAI.ModularForms.etaAnalyticCone_available :
    upperHalfPlaneSet.EqOn (ModularForm.eta ∘ (-1 / ·))
      ((sqrt I)⁻¹ • (sqrt * ModularForm.eta)) :=
  ModularForm.eta_comp_eq_csqrt_I_inv

end GateWitness

-- ---------------------------------------------------------------------------------------------
-- F3.1-B0 (BUILD GATE, not a theorem of ours) — the Dedekind-eta analytic cone is available.
--
-- This node proves NOTHING mathematical.  It records that
-- `Mathlib.NumberTheory.ModularForms.DedekindEta` and `.Discriminant` are built and importable
-- in this workspace, which every F3.2 node is gated on.  The guards below are the machine-checked
-- witness: they are `#print axioms` on MATHLIB's declarations, not ours, so they succeed only if
-- the modules genuinely elaborate here.  If the shared package pool ever loses these `.olean`s,
-- FinalCheck stops compiling instead of the gate going quietly stale (LL-2).
--
-- Nothing here is a SocrateAI result.  In particular `eta_comp_eq_csqrt_I_inv` is Mathlib's
-- S-transformation `η(-1/z) = (√I)⁻¹ · √z · η(z)`; F3.2 is required to USE it, never to reprove it.
/-- info: 'ModularForm.eta' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ModularForm.eta
/-- info: 'ModularForm.eta_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ModularForm.eta_ne_zero
/-- info: 'ModularForm.logDeriv_eta_eq_E2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ModularForm.logDeriv_eta_eq_E2
/-- info: 'ModularForm.eta_comp_eq_csqrt_I_inv' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ModularForm.eta_comp_eq_csqrt_I_inv
/-- info: 'ModularForm.discriminant_T_invariant' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ModularForm.discriminant_T_invariant
/-- info: 'ModularForm.discriminant_S_invariant' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ModularForm.discriminant_S_invariant
/-- info: 'SocrateAI.ModularForms.etaAnalyticCone_available' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaAnalyticCone_available

-- ---------------------------------------------------------------------------------------------
-- F3.1-B1 — `eta_q n (z+1) = eta_q n z`, the `1`-periodicity of the `q`-product factors.
--
-- A SocrateAI theorem (unlike the B0 re-export above): Mathlib performs this step inline inside
-- `discriminant_T_invariant` but never states it, so `F3.2-A1` had nothing to cite.  Sorry-free:
-- the footprint below is the three standard axioms, with NO `sorryAx`.
/-- info: 'SocrateAI.ModularForms.eta_q_add_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_q_add_one

-- STATEMENT PIN (LL-1: "a green build can prove the WRONG theorem").  The axiom guard above
-- certifies the PROOF; this ascription certifies the STATEMENT, and fails to elaborate if
-- `eta_q_add_one` ever drifts from what F3.1-B1 scoped -- in particular if a `z ∈ ℍₒ` hypothesis
-- or a level other than `eta_q`'s own is silently introduced.  `eta_q` is MATHLIB's, not ours.
example : ∀ (n : ℕ) (z : ℂ), ModularForm.eta_q n (z + 1) = ModularForm.eta_q n z :=
  fun n z => SocrateAI.ModularForms.eta_q_add_one n z

-- ---------------------------------------------------------------------------------------------
-- F3.1-B2 -- `eta_add_one`: the eta T-transformation as a STANDALONE theorem,
--   `η(z + 1) = e^{2πi/24} · η(z)`   for EVERY `z : ℂ`.
--
-- A SocrateAI theorem, not a re-export.  Mathlib has the 24th power of it
-- (`discriminant_T_invariant`, `Δ = η^24`) and nothing else: greps for `eta_T`, `eta_add_one`,
-- `eta_periodic`, `eta_translate` return no relevant hit, and a 24th-power identity cannot be
-- inverted to recover the first power (24th roots of unity).  Proof: the `q`-product definition
-- `eta z = 𝕢 24 z * ∏' n, (1 - eta_q n z)`, with `Complex.exp_add` on the prefactor and F3.1-B1
-- (`eta_q_add_one`) under `tprod_congr` on the product.  Sorry-free -- the footprint below is the
-- three standard axioms, with NO `sorryAx`.
--
-- SCOPE, since this sits one inch from the F3.2 frontier: `eta_add_one` is a statement about `η`
-- under the single matrix `T`.  It is NOT the eta multiplier system, NOT a statement about
-- `Γ₀(N)`, and NOT Ligozat's criterion.  F3.2-A1 (`eta_T_transform`) is the SAME statement with
-- `2πi/24` rewritten as `πi/12` and an unused `z ∈ ℍₒ` hypothesis; it is now proved FROM this
-- lemma and guarded below.  The F3.2 ladder proper begins after it and is still `sorry`.
/-- info: 'SocrateAI.ModularForms.eta_add_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_add_one

-- LL-1 CROSS-CHECK, machine-checked: `eta_add_one` raised to the 24th power must kill the root
-- of unity and reproduce the CONTENT of Mathlib's `discriminant_T_invariant`, `Δ(z+1) = Δ(z)`.
-- A wrong constant in `eta_add_one` (say `/12` instead of `/24`) still elaborates but fails HERE.
/-- info: 'SocrateAI.ModularForms.eta_pow_24_add_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_pow_24_add_one

-- STATEMENT PIN (LL-1).  The guards above certify the PROOFS; these ascriptions certify the
-- STATEMENTS, and fail to elaborate if either theorem drifts from what F3.1-B2 scoped -- in
-- particular if a `z ∈ ℍₒ` hypothesis is silently added (the point of the node is that NONE is
-- needed) or if the constant `2πi/24` moves.
example : ∀ z : ℂ, ModularForm.eta (z + 1)
    = Complex.exp (2 * (Real.pi : ℂ) * Complex.I / 24) * ModularForm.eta z :=
  fun z => SocrateAI.ModularForms.eta_add_one z

example : ∀ z : ℂ, ModularForm.eta (z + 1) ^ 24 = ModularForm.eta z ^ 24 :=
  fun z => SocrateAI.ModularForms.eta_pow_24_add_one z

-- ---------------------------------------------------------------------------------------------
-- F3.1-B3 -- `eta_add_int`: INTEGER translations,
--   `η(z + m) = e^{2πi·m/24} · η(z)`   for EVERY `m : ℤ` and EVERY `z : ℂ`.
--
-- Needed downstream because `Γ₀(N)` contains every power `T^m`, not just `T`; the negative half
-- is not a formality, since `T⁻¹` appears when an element of `Γ₀(N)` is written as a word.
-- Proof: `Int.induction_on` with F3.1-B2 (`eta_add_one`) as the single step in BOTH directions --
-- upwards applied at `z + i`, downwards applied at `z - i - 1` and then INVERTED, which is legal
-- because `Complex.exp` is nowhere zero (`mul_left_cancel₀` on `Complex.exp_ne_zero`).  No new
-- machinery and no analytic input beyond B2 (LL-11).  Sorry-free -- footprints below are the
-- three standard axioms, with NO `sorryAx`.
--
-- SCOPE: this is `η` under the translation subgroup `⟨T⟩` alone.  It is NOT the eta multiplier
-- system, NOT a statement about `Γ₀(N)`, and NOT Ligozat's criterion.  F3.2-A1
-- (`eta_T_transform`) and its iterate `eta_T_transform_nat` are corollaries of this lemma and of
-- F3.1-B2, guarded below; the rest of the F3.2 ladder remains `sorry`.
/-- info: 'SocrateAI.ModularForms.eta_add_int' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_add_int

-- LL-1 CROSS-CHECKS for `eta_add_int`, machine-checked, three independent instances plus the
-- 24th power.  Each states the classically correct value INDEPENDENTLY and derives it THROUGH
-- `eta_add_int`, so a wrong constant, a wrong sign or a dropped `m` fails HERE rather than
-- silently elaborating above.
--   `eta_sub_one`       -- the `m = -1` instance: the direction the induction proves by inversion.
--   `eta_add_two`       -- the `m = 2` instance, written as `eta_add_one` applied twice: pins the
--                          SCALING in `m` (an exponent `2πi·m/48` fails this one).
--   `eta_pow_24_add_int`-- the 24th power for EVERY `m`, reproducing the content of Mathlib's
--                          `discriminant_T_invariant` along the whole translation subgroup.
/-- info: 'SocrateAI.ModularForms.eta_sub_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_sub_one

/-- info: 'SocrateAI.ModularForms.eta_add_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_add_two

/-- info: 'SocrateAI.ModularForms.eta_pow_24_add_int' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_pow_24_add_int

-- STATEMENT PINS (LL-1).  The guards above certify the PROOFS; these ascriptions certify the
-- STATEMENTS, and fail to elaborate if `eta_add_int` drifts from what F3.1-B3 scoped -- in
-- particular if `m` is silently narrowed from `ℤ` to `ℕ` (which would drop exactly the `T⁻¹`
-- half the node exists for), if a `z ∈ ℍₒ` hypothesis is added, or if the constant moves.
example : ∀ (m : ℤ) (z : ℂ), ModularForm.eta (z + (m : ℂ))
    = Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (m : ℂ) / 24) * ModularForm.eta z :=
  fun m z => SocrateAI.ModularForms.eta_add_int m z

example : ∀ z : ℂ, ModularForm.eta (z - 1)
    = Complex.exp (-(2 * (Real.pi : ℂ) * Complex.I) / 24) * ModularForm.eta z :=
  fun z => SocrateAI.ModularForms.eta_sub_one z

example : ∀ (m : ℤ) (z : ℂ), ModularForm.eta (z + (m : ℂ)) ^ 24 = ModularForm.eta z ^ 24 :=
  fun m z => SocrateAI.ModularForms.eta_pow_24_add_int m z

-- CONSISTENCY PIN between B2 and B3: `eta_add_int` at `m = 1` must be `eta_add_one` on the nose.
example : ∀ z : ℂ, ModularForm.eta (z + 1)
    = Complex.exp (2 * (Real.pi : ℂ) * Complex.I / 24) * ModularForm.eta z := by
  intro z
  simpa using SocrateAI.ModularForms.eta_add_int 1 z

-- ---------------------------------------------------------------------------------------------
-- F3.1-B4 -- LL-1 GUARD on F3.1-B2.  NOT A NEW RESULT: this node exists only to make a wrong
-- constant in `eta_add_one` fail to compile, by landing on a proposition MATHLIB proves
-- independently.
--
-- Why B2 needed an external pin.  `eta_add_one` is self-consistent: it was proved from the
-- `q`-product with `Complex.exp_add` + `tprod_congr`, and `congr 1; push_cast; ring` would have
-- closed the prefactor step for whatever `exp` argument the two sides actually had.  Nothing
-- INSIDE B2 pins `2πi/24` against an outside authority.  `Δ = η²⁴` is that authority: Mathlib's
-- `discriminant_T_invariant` is proved straight from `discriminant_eq_q_prod`, with no reference
-- to any `η`-level `T`-transform.
--
-- The guard is deliberately TWO-SIDED, because the 24th power alone is not enough: `e^{2πi/12}`
-- also has trivial 24th power, so `eta_pow_24_add_one` (guarded under B2 above) would survive that
-- particular corruption.  Landing on Mathlib's PROPOSITION is what rules it out.
--   `discriminant_T_of_eta_add_one`           -- `Δ(z+1) = Δ(z)` on `ℍ`, from B2 alone.  Verified
--                                                load-bearing: `simp [ModularForm.discriminant]`
--                                                reduces to `η(↑z+1)^24 = η ↑z^24` and then FAILS
--                                                (`unsolved goals`), so B2 is what closes it.
--   `discriminant_T_invariant_of_eta_add_one` -- Mathlib's own statement `Δ ∣[12] T = Δ`,
--                                                re-derived WITHOUT citing Mathlib's lemma.
-- Sorry-free; footprints below are the three standard axioms, with NO `sorryAx`.
/-- info: 'SocrateAI.ModularForms.discriminant_T_of_eta_add_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.discriminant_T_of_eta_add_one

/--
info: 'SocrateAI.ModularForms.discriminant_T_invariant_of_eta_add_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
-/
#guard_msgs in #print axioms SocrateAI.ModularForms.discriminant_T_invariant_of_eta_add_one

-- STATEMENT PINS (LL-1) for F3.1-B4.  The point of the second pair is that the SAME written-out
-- proposition `Δ ∣[12] ModularGroup.T = Δ` is inhabited twice -- once by MATHLIB's proof and once
-- by ours-through-`eta_add_one`.  If either statement drifts, one of the two ascriptions stops
-- elaborating, and the guard has done its job.
section B4Pins
open ModularForm UpperHalfPlane
open scoped MatrixGroups

example : ∀ z : ℍ, ModularForm.discriminant ⟨(z : ℂ) + 1, by simpa using z.2⟩
    = ModularForm.discriminant z :=
  fun z => SocrateAI.ModularForms.discriminant_T_of_eta_add_one z

example : (ModularForm.discriminant ∣[(12 : ℤ)] ModularGroup.T) = ModularForm.discriminant :=
  ModularForm.discriminant_T_invariant

example : (ModularForm.discriminant ∣[(12 : ℤ)] ModularGroup.T) = ModularForm.discriminant :=
  SocrateAI.ModularForms.discriminant_T_invariant_of_eta_add_one

end B4Pins

-- ---------------------------------------------------------------------------------------------
-- F3.2-A1 -- `eta_T_transform`: the `η` `T`-transformation in the form F3.2 scoped it,
--   `η(z + 1) = e^{πi/12} · η(z)`   for `z ∈ ℍₒ`.
--
-- STATUS CHANGE.  This slot previously held an INVERTED tripwire asserting `sorryAx` in the
-- footprint, so that discharging the `sorry` would break the build and force the DAG node and
-- the honesty labels to move in the same commit.  That is what happened: the `sorry` is gone,
-- the tripwire fired, and it is replaced here by an ordinary axiom guard.  The DAG node F3.2-A1
-- moved `open -> proved` in the same change.
--
-- WHAT WAS ACTUALLY PROVED, in English (LL-1).  For every complex `z` with `0 < im z`,
-- `η(z + 1) = e^{iπ/12} η(z)`.  Nothing more.  This is `η` under the SINGLE matrix `T`; it is
-- NOT the eta multiplier system, NOT a statement about `Γ₀(N)`, and NOT Ligozat's criterion.
-- The F3.2 obstruction (`multiplier_trivial_of_congr`, F3.2-OBSTRUCTED) is untouched.  As of
-- F3.2-A8 the F3.2 block of `EtaQuotientModularity.lean` carries exactly ONE `sorry` --
-- `multiplier_trivial_of_congr` -- and it is downstream of this node, not implied by it.
-- (`etaQuotient_pow_24` and `etaQuotient_pow24_slash` were discharged with
-- F3.2-A4, `etaQuotient_multiplier` with F3.2-A5, `T_mem_Gamma0` /
-- `etaQuotient_T_transform` / `multiplier_T_eq_one` with F3.2-A6, `etaQuotient_fricke` with
-- F3.2-A7 and `matV_mem_Gamma0` / `multiplier_V_eq_one` with F3.2-A8; see the `F32A4Pins`,
-- `F32A5Pins`, `F32A6Pins`, `F32A7Pins` and `F32A8Pins` sections below.)
--
-- WHERE THE CONTENT LIVES.  Not here.  `eta_T_transform` is a corollary of F3.1-B2
-- (`eta_add_one`, guarded above), which proves the same identity with the constant written
-- `e^{2πi/24}` and with NO hypothesis on `z`; the whole of the remaining proof is the numeral
-- identity `2πi/24 = πi/12` (`congr 2; ring`).  The `hz : z ∈ ℍₒ` hypothesis of F3.2-A1 is
-- therefore UNUSED -- kept only because it is verbatim the scoped signature, and pinned longhand
-- below so that its removal (which would be a different, stronger theorem) cannot pass silently.
-- Downstream work should cite `eta_add_one`, the hypothesis-free form.
/-- info: 'SocrateAI.ModularForms.eta_T_transform' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_T_transform

-- The iterate `η(z + n) = e^{πin/12} η(z)` for `n : ℕ`, which is what the divisor-indexed product
-- downstream consumes.  Also a corollary, of F3.1-B3 (`eta_add_int`) at `(n : ℤ)`, not a new
-- induction.  Same unused `hz`, same reason.
/-- info: 'SocrateAI.ModularForms.eta_T_transform_nat' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_T_transform_nat

-- STATEMENT PINS (LL-1).  The guards above certify the PROOFS; these ascriptions certify the
-- STATEMENTS.  They fail to elaborate if the constant `πi/12` drifts, if the `z ∈ ℍₒ` hypothesis
-- is dropped or strengthened, or if the `n`-scaling of the iterate changes.
section F32A1Pins
open ModularForm UpperHalfPlane

example : ∀ {z : ℂ}, z ∈ UpperHalfPlane.upperHalfPlaneSet →
    ModularForm.eta (z + 1)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12) * ModularForm.eta z :=
  fun {_} hz => SocrateAI.ModularForms.eta_T_transform hz

example : ∀ {z : ℂ}, z ∈ UpperHalfPlane.upperHalfPlaneSet → ∀ n : ℕ,
    ModularForm.eta (z + n)
      = Complex.exp ((Real.pi : ℂ) * Complex.I * n / 12) * ModularForm.eta z :=
  fun {_} hz n => SocrateAI.ModularForms.eta_T_transform_nat hz n

-- LL-1 CROSS-CHECK: F3.2-A1's constant, written `πi/12`, must agree with F3.1-B2's, written
-- `2πi/24`, as COMPLEX NUMBERS and not merely as numerals -- the two nodes are cited separately
-- in the paper, and a drift in either would otherwise show up only as two incompatible lemmas.
example : Complex.exp ((Real.pi : ℂ) * Complex.I / 12)
    = Complex.exp (2 * (Real.pi : ℂ) * Complex.I / 24) := by
  congr 1
  ring

-- LL-1 CROSS-CHECK: the iterate at `n = 1` must reproduce F3.2-A1 itself, constant included.
example {z : ℂ} (hz : z ∈ UpperHalfPlane.upperHalfPlaneSet) :
    ModularForm.eta (z + 1)
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12) * ModularForm.eta z := by
  have h := SocrateAI.ModularForms.eta_T_transform_nat hz 1
  simpa using h

end F32A1Pins

-- TRIPWIRE UPDATED BY F3.2-B2 (LL-2, LL-7).  This slot used to assert that
-- `multiplier_trivial_of_congr` still carried `sorryAx`.  F3.2-B2 discharged it -- with the
-- hypothesis `Even k` ADDED, because the statement it used to carry is FALSE without it (see
-- `not_multiplier_trivial_odd` below).  The guard is therefore updated, not deleted, and the
-- clean footprint below is the claim that the terminal node of the F3.2 ladder for `N <= 4` is
-- now proved.  What remains OPEN is `N >= 5`, where `<-I, T, V> = Gamma0 N` is false and the
-- Dedekind-sum obstruction still bites; nothing in this file claims otherwise.
/-- info: 'SocrateAI.ModularForms.multiplier_trivial_of_congr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_trivial_of_congr


-- ---------------------------------------------------------------------------------------------
-- F3.1-B5 -- `etaQuotientH`: THE ETA QUOTIENT `f(τ) = ∏_{δ ∣ N} η(δτ)^{r_δ}` AS A DEFINITION
-- OVER `ℍ`, together with the structural lemmas that make it usable.  All sorry-free.
--
-- WHAT THE NODE IS.  A definition plus its algebra -- not a modularity statement.  Mathlib has
-- NO eta quotients (greps for `EtaQuotient`, `Ligozat`, `Fricke`, `AtkinLehner`, `DedekindSum`,
-- `etaMultiplier` all return zero files at commit 905b95818e), so the object has to be built.
--
-- THE DESIGN DECISION BEING GUARDED.  `ModularForm.eta : ℂ → ℂ` but `ModularForm.discriminant :
-- ℍ → ℂ` and the whole `SlashAction`/`denom` API is on the bundled `ℍ`.  B5 takes `τ : ℍ` and
-- feeds the coercion to `η`.  The pins below write that signature out longhand so it cannot
-- drift to the `ℂ`-domain form (which also exists, as `etaQuotient`) unnoticed.
--
-- THE JUNK-VALUE QUESTION.  `r δ : ℤ` may be negative, so the power is a `zpow` and its value at
-- base `0` is junk; `etaQuotientH_add` / `_neg` / `_zsmul` are all FALSE at a vanishing base.
-- `eta_natCast_mul_ne_zero` is what rules that out, factor by factor: `0 < δ` on `N.divisors`
-- (`Nat.pos_of_mem_divisors`) puts `δ·τ` back in `ℍₒ`, where `ModularForm.eta_ne_zero` applies.
-- Its footprint is guarded below because the zpow algebra is only as sound as it is.

/-- info: 'SocrateAI.ModularForms.etaQuotient' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient

/-- info: 'SocrateAI.ModularForms.etaQuotientH' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH

/-- info: 'SocrateAI.ModularForms.etaQuotientH_apply' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_apply

/-- info: 'SocrateAI.ModularForms.natCast_mul_mem_upperHalfPlaneSet' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.natCast_mul_mem_upperHalfPlaneSet

/-- info: 'SocrateAI.ModularForms.eta_natCast_mul_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_natCast_mul_ne_zero

/-- info: 'SocrateAI.ModularForms.etaQuotientH_congr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_congr

/-- info: 'SocrateAI.ModularForms.etaQuotientH_trunc' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_trunc

/-- info: 'SocrateAI.ModularForms.etaQuotientH_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_zero_exp

/-- info: 'SocrateAI.ModularForms.etaQuotientH_add' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_add

/-- info: 'SocrateAI.ModularForms.etaQuotientH_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_neg

/-- info: 'SocrateAI.ModularForms.etaQuotientH_zsmul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_zsmul

/-- info: 'SocrateAI.ModularForms.etaQuotientH_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_level_one

/-- info: 'SocrateAI.ModularForms.etaQuotientH_level_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_level_one_24

/-- info: 'SocrateAI.ModularForms.etaQuotientH_eq_etaQuotient' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_eq_etaQuotient

-- STATEMENT PINS (LL-1) for F3.1-B5.  A clean axiom footprint proves only that SOMETHING was
-- proved; these write out the propositions independently, so a drifting signature (a `pow` where
-- a `zpow` was meant, `Nat.properDivisors` for `Nat.divisors`, the scaling moved outside `η`,
-- or the domain silently reverting from `ℍ` to `ℂ`) stops elaborating HERE.
section B5Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- the defining equation, in the exact shape F3.1-B5 was scoped in: `τ : ℍ`, index set
-- `N.divisors`, base `η(δ · τ)` with the scaling INSIDE `η`, exponent a `zpow` by `r δ : ℤ`,
-- and the exponent vector typed as the bare `ℕ → ℤ` rather than the `EtaExp` abbreviation.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (τ : ℍ),
    SocrateAI.ModularForms.etaQuotientH N r τ
      = ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ) :=
  fun N r τ => SocrateAI.ModularForms.etaQuotientH_apply N r τ

-- PIN 2 -- THE EXTERNAL PIN.  At `N = 1` with constant exponent `24` the eta quotient must be
-- MATHLIB's modular discriminant, whose definition we did not write: `∏_{δ ∣ 1} η(δτ)^24 = Δ(τ)`.
-- This is the check that the index set, the scaling and the zpow are all simultaneously right.
example : ∀ τ : ℍ,
    SocrateAI.ModularForms.etaQuotientH 1 (fun _ => (24 : ℤ)) τ = ModularForm.discriminant τ :=
  fun τ => SocrateAI.ModularForms.etaQuotientH_level_one_24 τ

-- PIN 3 -- multiplicativity in the exponent vector, written out.  This is the statement that
-- consumes the non-vanishing (`zpow_add₀`); it is the analytic mirror of the ARITHMETIC
-- additivity `etaQuotientCuspOrder_add` / `etaQuotientWeight_add` guarded under F3.1-A6.
example : ∀ (N : ℕ) (r s : ℕ → ℤ) (τ : ℍ),
    SocrateAI.ModularForms.etaQuotientH N (r + s) τ
      = SocrateAI.ModularForms.etaQuotientH N r τ * SocrateAI.ModularForms.etaQuotientH N s τ :=
  fun N r s τ => SocrateAI.ModularForms.etaQuotientH_add N r s τ

-- PIN 4 -- non-vanishing at the level of a single FACTOR (not the product: that is F3.1-B7).
example : ∀ {δ : ℕ}, 0 < δ → ∀ τ : ℍ, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ≠ 0 :=
  fun hδ τ => SocrateAI.ModularForms.eta_natCast_mul_ne_zero hδ τ

end B5Pins

-- TRIPWIRE RETIRED, AND WHY -- read this before assuming the guard was simply deleted.
-- Up to F3.1-B6 this spot held a guard asserting that `etaQuotient_ne_zero` still depended on
-- `sorryAx`: the PRODUCT-level non-vanishing was deliberately left open so that flipping it
-- would be its own commit, and the guard existed so B5's clean footprints could not be read as
-- if the eta quotient were already known nowhere-zero.  F3.1-B7 discharged that `sorry`, the
-- tripwire failed exactly as designed, and it is replaced below by the POSITIVE guards.  The
-- statement it protected is unchanged; only its axiom footprint moved from
-- [propext, sorryAx, Classical.choice, Quot.sound] to [propext, Classical.choice, Quot.sound].


-- ---------------------------------------------------------------------------------------------
-- F3.1-B6 -- `mem_upperHalfPlaneSet_divisor_smul`: THE SIDE CONDITION OF B7/B8, IN DIVISOR FORM.
-- Sorry-free.
--
-- WHAT THE NODE IS, WITHOUT OVERSELL.  It is a WRAPPER.  The mathematical content
-- (`im (δ·τ) = δ · im τ > 0` for `0 < δ`) is `natCast_mul_mem_upperHalfPlaneSet`, landed under
-- F3.1-B5 above and guarded there.  B6 restates it with the hypothesis `δ ∈ N.divisors` -- the
-- form every consumer indexed over `N.divisors` actually carries -- via `Nat.pos_of_mem_divisors`.
-- One line of proof.  Guarded here anyway because it is the side condition that F3.1-B7
-- (`etaQuotient_ne_zero`, still a `sorry`, tripwired above) and the factorwise F3.1-B8 rewrites
-- will discharge, so a drift in its statement would silently widen what those proofs assume.
--
-- WHAT IT IS NOT.  It says nothing about `η`, nothing about `Γ₀(N)`, and nothing about the
-- multiplier system.  In particular the B5 tripwire immediately above -- asserting that
-- `etaQuotient_ne_zero` is still UNPROVED -- is untouched by this node and must stay failing-on-
-- discharge.

/-- info: 'SocrateAI.ModularForms.mem_upperHalfPlaneSet_divisor_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.mem_upperHalfPlaneSet_divisor_smul

-- STATEMENT PIN (LL-1) for F3.1-B6.  The proposition written out longhand, with
-- `upperHalfPlaneSet` fully qualified and the hypothesis in MEMBERSHIP form: if the signature
-- ever weakens back to `0 < δ`, or the scaling `(δ : ℂ) * (τ : ℂ)` is written with the coercion
-- on the wrong side, this stops elaborating HERE.
section B6Pin
open UpperHalfPlane

example : ∀ {N δ : ℕ}, δ ∈ N.divisors → ∀ τ : ℍ,
    (δ : ℂ) * (τ : ℂ) ∈ UpperHalfPlane.upperHalfPlaneSet :=
  fun hδ τ => SocrateAI.ModularForms.mem_upperHalfPlaneSet_divisor_smul hδ τ

end B6Pin


-- ---------------------------------------------------------------------------------------------
-- F3.1-B7 -- `etaQuotient_ne_zero` / `etaQuotientH_ne_zero`: AN ETA QUOTIENT NEVER VANISHES ON
-- THE UPPER HALF-PLANE.  Sorry-free.  This is the node that retires the B5 tripwire above.
--
-- WHAT IS PROVED: `∏_{δ ∣ N} η(δz)^{r_δ} ≠ 0` for every level `N`, every INTEGER exponent vector
-- `r : ℕ → ℤ` (positive, negative or mixed), and every point of the OPEN upper half-plane -- in
-- the `ℂ`-domain form with hypothesis `z ∈ upperHalfPlaneSet`, and in the `ℍ`-domain form with
-- no hypothesis at all.
--
-- WHAT IS NEW, WITHOUT OVERSELL: no mathematics.  `ModularForm.eta_ne_zero` is the entire
-- analytic content and it is MATHLIB's; `Finset.prod_ne_zero_iff` reduces the finite product to
-- its factors and `zpow_ne_zero` strips the possibly-negative exponent.  What the node buys is
-- that every later `zpow` manipulation of `f` AS ONE NUMBER (as opposed to factor by factor,
-- which is all F3.1-B5 needed) is now legal: `0 ^ (-1) = 0` is a junk value and every `zpow`
-- identity is FALSE at a vanishing base.
--
-- WHAT IT IS NOT.  It is NOT non-vanishing at the cusps -- `upperHalfPlaneSet` is OPEN and the
-- cusps are not in it; cusp orders are the separate arithmetic `etaQuotientCuspOrder` (F3.1-A).
-- It is not holomorphy -- that is F3.1-B8 (`differentiableAt_etaQuotient`), guarded separately
-- below, which CONSUMES this node to discharge the `zpow` side condition.  B7 says nothing
-- about `Γ₀(N)` or the multiplier system, and the F3.2 Dedekind-sum obstruction is untouched.

-- (This one name is long enough that Lean wraps the axiom list at its 120-column pretty-printer
-- width, so the expected message is written wrapped.  Same footprint as every other guard here.)
/-- info: 'SocrateAI.ModularForms.natCast_mul_mem_upperHalfPlaneSet_of_mem' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.natCast_mul_mem_upperHalfPlaneSet_of_mem

/-- info: 'SocrateAI.ModularForms.eta_natCast_mul_ne_zero_of_mem' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_natCast_mul_ne_zero_of_mem

/-- info: 'SocrateAI.ModularForms.etaQuotient_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_ne_zero

/-- info: 'SocrateAI.ModularForms.etaQuotientH_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_ne_zero

-- STATEMENT PINS (LL-1) for F3.1-B7.  A clean footprint proves only that SOMETHING was proved.
-- These write the propositions out longhand with the exponent vector typed as the bare `ℕ → ℤ`
-- (not the `EtaExp` abbreviation), `upperHalfPlaneSet` fully qualified, and NO extra hypothesis
-- on `r`: if the statement ever weakens to nonnegative exponents, to a `pow` instead of a
-- `zpow`, or acquires a side condition, it stops elaborating HERE.
section B7Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- the node exactly as scoped: `(N : ℕ) (r : ℕ → ℤ) (τ : ℍ)`, no hypotheses.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (τ : ℍ), SocrateAI.ModularForms.etaQuotientH N r τ ≠ 0 :=
  fun N r τ => SocrateAI.ModularForms.etaQuotientH_ne_zero N r τ

-- PIN 2 -- the `ℂ`-domain form, hypothesis in set-membership shape, quantified over ALL `r`.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    SocrateAI.ModularForms.etaQuotient N r z ≠ 0 :=
  fun _ r _ hz => SocrateAI.ModularForms.etaQuotient_ne_zero r hz

-- PIN 3 -- the product, written out rather than hidden behind the definition: this is what
-- non-vanishing MEANS, and it fails to elaborate if the index set, the `δ·` scaling inside `η`
-- or the `zpow` ever drift.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (τ : ℍ),
    (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ)) ≠ 0 :=
  fun N r τ => (SocrateAI.ModularForms.etaQuotientH_apply N r τ) ▸
    SocrateAI.ModularForms.etaQuotientH_ne_zero N r τ

-- PIN 4 -- THE NEGATIVE-EXPONENT INSTANCE, which is the whole point of the node: at `r ≡ -1`
-- the quotient is a product of INVERSES, whose non-vanishing is exactly what licenses the
-- `zpow` algebra downstream.  A proof that secretly assumed `0 ≤ r δ` dies here.
example : ∀ (N : ℕ) (τ : ℍ),
    SocrateAI.ModularForms.etaQuotientH N (fun _ => (-1 : ℤ)) τ ≠ 0 :=
  fun N τ => SocrateAI.ModularForms.etaQuotientH_ne_zero N _ τ

end B7Pins


-- ---------------------------------------------------------------------------------------------
-- F3.1-B8 -- `differentiableAt_etaQuotient`: AN ETA QUOTIENT IS HOLOMORPHIC ON THE OPEN UPPER
-- HALF-PLANE.  Sorry-free.  The last node of the `F3.1-B` ladder.
--
-- WHAT IS PROVED: `DifferentiableAt ℂ (fun w => ∏_{δ ∣ N} η(δw)^{r_δ}) z` for every level `N`,
-- every INTEGER exponent vector `r : ℕ → ℤ` (positive, negative or mixed) and every `z` in the
-- OPEN upper half-plane.  No hypothesis on `r` of any kind.
--
-- WHAT IS NEW, WITHOUT OVERSELL: no analysis.  Mathlib's
-- `differentiableAt_eta_of_mem_upperHalfPlaneSet` is the entire analytic content;
-- `DifferentiableAt.comp` is the chain rule through the `ℂ`-linear scaling `w ↦ δw`,
-- `DifferentiableAt.fun_finsetProd` reduces the finite product over `N.divisors` to its factors,
-- and `DifferentiableAt.zpow` strips the possibly-negative exponent.
--
-- WHERE F3.1-B7 IS ACTUALLY USED, and why the dependency is not decorative.
-- `DifferentiableAt.zpow` carries the side condition `f a ≠ 0 ∨ 0 ≤ m`.  For a NEGATIVE `r δ`
-- the right disjunct is unavailable, so the proof supplies the LEFT one at every factor, from
-- B7's `eta_natCast_mul_ne_zero_of_mem`.  That is exactly why no sign hypothesis on `r` appears
-- in the statement.  PIN 4 below is the `r ≡ -1` instance that dies if this ever regresses.
--
-- WHAT IT IS NOT.  Differentiability AT POINTS OF THE OPEN upper half-plane and nothing else.
-- It is NOT holomorphy near a cusp (`upperHalfPlaneSet` is open; the cusps are not in it), NOT
-- meromorphy on `X₀(N)`, and NOT any statement about `Γ₀(N)`, the slash action or the multiplier
-- system.  The F3.2 Dedekind-sum obstruction is untouched.

/-- info: 'SocrateAI.ModularForms.differentiableAt_eta_natCast_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.differentiableAt_eta_natCast_mul

/-- info: 'SocrateAI.ModularForms.differentiableAt_etaQuotient' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.differentiableAt_etaQuotient

/-- info: 'SocrateAI.ModularForms.differentiableAt_etaQuotient_prod' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.differentiableAt_etaQuotient_prod

-- STATEMENT PINS (LL-1) for F3.1-B8.  A clean footprint proves only that SOMETHING was proved.
-- These write the propositions out longhand with `r` typed as the bare `ℕ → ℤ` (not the `EtaExp`
-- abbreviation), `upperHalfPlaneSet` fully qualified, and no extra hypothesis: if the statement
-- ever weakens to nonnegative exponents, to a `pow` instead of a `zpow`, to `DifferentiableWithinAt`,
-- or acquires a side condition on `r`, it stops elaborating HERE.
section B8Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- the node EXACTLY as scoped: `(N : ℕ) (r : ℕ → ℤ)`, product written longhand, the
-- hypothesis in set-membership shape, and `DifferentiableAt ℂ` (not `WithinAt`, not `On`).
example : ∀ (N : ℕ) (r : ℕ → ℤ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    DifferentiableAt ℂ (fun w => ∏ δ ∈ N.divisors, (ModularForm.eta ((δ : ℂ) * w)) ^ (r δ)) z :=
  fun N r _ hz => SocrateAI.ModularForms.differentiableAt_etaQuotient_prod N r hz

-- PIN 2 -- the same statement through the definition, which is `rfl`-equal to PIN 1.  Having
-- BOTH is the LL-1 check: it fails if `etaQuotient` is ever redefined to something else.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    DifferentiableAt ℂ (SocrateAI.ModularForms.etaQuotient N r) z :=
  fun _ r _ hz => SocrateAI.ModularForms.differentiableAt_etaQuotient r hz

-- PIN 3 -- the two forms are literally the same proposition.  `rfl` here is the guard that PIN 1
-- is not a strictly weaker statement dressed up to look like the node.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (z : ℂ),
    DifferentiableAt ℂ (SocrateAI.ModularForms.etaQuotient N r) z
      ↔ DifferentiableAt ℂ (fun w => ∏ δ ∈ N.divisors, (ModularForm.eta ((δ : ℂ) * w)) ^ (r δ)) z :=
  fun _ _ _ => Iff.rfl

-- PIN 4 -- THE NEGATIVE-EXPONENT INSTANCE, which is the whole reason B8 depends on B7: at
-- `r ≡ -1` every factor is an INVERSE `η(δw)⁻¹`, and `DifferentiableAt.zpow`'s right disjunct
-- `0 ≤ m` is FALSE there.  A proof that secretly assumed `0 ≤ r δ` dies here.
example : ∀ (N : ℕ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    DifferentiableAt ℂ
      (fun w => ∏ δ ∈ N.divisors, (ModularForm.eta ((δ : ℂ) * w)) ^ (-1 : ℤ)) z :=
  fun N _ hz => SocrateAI.ModularForms.differentiableAt_etaQuotient_prod N _ hz

-- PIN 5 -- the factor lemma, longhand: the chain rule through `w ↦ δw` really is what is proved,
-- with the hypothesis `0 < δ` (NOT `δ ∈ N.divisors`, which would hide the positivity).
example : ∀ (δ : ℕ), 0 < δ → ∀ (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    DifferentiableAt ℂ (fun w : ℂ => ModularForm.eta ((δ : ℂ) * w)) z :=
  fun _ hδ _ hz => SocrateAI.ModularForms.differentiableAt_eta_natCast_mul hδ hz

end B8Pins

-- ---------------------------------------------------------------------------------------------
-- F3.2-A2 -- `etaQuotient`: THE ETA QUOTIENT AS A DEFINITION, TOGETHER WITH NON-VANISHING AND
-- HOLOMORPHY ON THE OPEN UPPER HALF-PLANE.  Sorry-free.
--
-- WHERE THE PROOFS ARE, said first and loudly, because this node's content is NOT new code and
-- claiming otherwise would be the dishonest report.  F3.2-A2 scoped exactly three deliverables:
-- the definition `etaQuotient`, the lemma `etaQuotient_ne_zero`, and the lemma
-- `differentiableAt_etaQuotient`.  All three are landed, sorry-free, in the `F3.1-B` ladder that
-- was built on top of this node's statement layer:
--   * the definition, and its `ℍ`-domain companion `etaQuotientH`, in `F3.1-B5`;
--   * `etaQuotient_ne_zero` / `etaQuotientH_ne_zero` in `F3.1-B7`;
--   * `differentiableAt_etaQuotient` / `differentiableAt_etaQuotient_prod` in `F3.1-B8`.
-- Every one of those already carries a `#guard_msgs in #print axioms` guard above.  Nothing is
-- re-proved here and no second copy of any declaration is created.  What this section adds is
-- the one thing the `B`-ladder guards do NOT check: that the landed declarations discharge the
-- node AT THE SIGNATURE THE NODE WAS SCOPED IN.
--
-- THE DEVIATION, stated rather than glossed.  F3.2-A2 was scoped with the level a POSITIVE
-- natural,  `def etaQuotient (N : ℕ+) (r : ℕ → ℤ) (z : ℂ) := ∏ δ ∈ (N:ℕ).divisors, η(δz)^(r δ)`.
-- What is landed takes `N : ℕ`.  That is a GENERALISATION, not a weakening, and the pins below
-- are the proof of it: each scoped `ℕ+`-statement is discharged by the landed `ℕ`-form applied
-- at `(N : ℕ)`, with no side condition and no repair term.  The extra levels are honest because
-- `N = 0` is degenerate rather than wrong: `Nat.divisors 0 = ∅`, so `etaQuotient 0 r z` is the
-- empty product `1` -- nonzero and constant, so BOTH landed lemmas are true there, merely
-- vacuous.  PIN 4 records that value rather than leaving it to be guessed.  Nothing downstream
-- leans on `N = 0`: every F3.2 modularity node carries `0 < N` as an explicit hypothesis.
--
-- WHAT WAS ACTUALLY PROVED, in English (LL-1).  For every level and every INTEGER exponent
-- vector -- positive, negative or mixed -- the finite product `∏_{δ ∣ N} η(δz)^{r_δ}` is a
-- well-defined complex number that is nonzero at every point of the OPEN upper half-plane, and
-- is complex-differentiable there.  The analytic content is entirely Mathlib's
-- (`ModularForm.eta_ne_zero`, `ModularForm.differentiableAt_eta_of_mem_upperHalfPlaneSet`); the
-- work is the finite-product and `zpow` bookkeeping and the `0 < δ` side condition.
--
-- SCOPE -- read before citing.  A definition, non-vanishing, and differentiability at points of
-- the OPEN upper half-plane.  This is NOT holomorphy at or near a cusp (`upperHalfPlaneSet` is
-- open and the cusps are not in it), NOT meromorphy on `X₀(N)`, and NOT any statement about
-- `Γ₀(N)`, the slash action, or the eta multiplier system.  The tripwire above still asserts
-- that `multiplier_trivial_of_congr` (F3.2-OBSTRUCTED) is UNPROVED, and it is: the Dedekind-sum
-- obstruction is untouched by this node.

section F32A2Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- THE DEFINITION at the node's scoped signature `(N : ℕ+) (r : ℕ → ℤ) (z : ℂ)`, with
-- the index set `(N : ℕ).divisors` and the body written longhand.  `rfl` is the guard: it fails
-- if the index set (`divisors` vs `properDivisors`), the `δ·` scaling inside `η`, or the `zpow`
-- ever drifts from what F3.2-A2 asked for.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (z : ℂ),
    SocrateAI.ModularForms.etaQuotient (N : ℕ) r z
      = ∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * z) ^ (r δ) :=
  fun _ _ _ => rfl

-- PIN 2 -- `etaQuotient_ne_zero` at the scoped signature.  NO hypothesis on `r`: negative
-- exponents included, which is the whole reason the node needed non-vanishing at all (`zpow`
-- identities are false at a vanishing base).
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    SocrateAI.ModularForms.etaQuotient (N : ℕ) r z ≠ 0 :=
  fun _ r _ hz => SocrateAI.ModularForms.etaQuotient_ne_zero r hz

-- PIN 3 -- `differentiableAt_etaQuotient` at the scoped signature.  `DifferentiableAt ℂ`, not
-- `DifferentiableWithinAt` and not `DifferentiableOn`.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    DifferentiableAt ℂ (SocrateAI.ModularForms.etaQuotient (N : ℕ) r) z :=
  fun _ r _ hz => SocrateAI.ModularForms.differentiableAt_etaQuotient r hz

-- PIN 4 -- THE DEGENERATE LEVEL, which is exactly what the `ℕ+ ⇝ ℕ` generalisation adds.  At
-- `N = 0` the divisor set is empty and the quotient is the empty product `1`.  Writing the value
-- down is the honest statement of what those extra levels contain: nothing.
example : ∀ (r : ℕ → ℤ) (z : ℂ), SocrateAI.ModularForms.etaQuotient 0 r z = 1 := by
  intro r z
  simp [SocrateAI.ModularForms.etaQuotient]

-- PIN 5 -- THE NEGATIVE-EXPONENT INSTANCE at the scoped `ℕ+` signature, tying PIN 2 and PIN 3
-- together: at `r ≡ -1` every factor is an INVERSE `η(δz)⁻¹`, where `DifferentiableAt.zpow`'s
-- easy disjunct `0 ≤ m` is unavailable and non-vanishing is doing real work.  A version of this
-- node that secretly assumed `0 ≤ r δ` -- the version that would NOT support Ligozat's
-- criterion, whose exponent vectors are genuinely mixed in sign -- dies here.
example : ∀ (N : ℕ+) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    SocrateAI.ModularForms.etaQuotient (N : ℕ) (fun _ => (-1 : ℤ)) z ≠ 0
      ∧ DifferentiableAt ℂ (SocrateAI.ModularForms.etaQuotient (N : ℕ) (fun _ => (-1 : ℤ))) z :=
  fun _ _ hz => ⟨SocrateAI.ModularForms.etaQuotient_ne_zero _ hz,
    SocrateAI.ModularForms.differentiableAt_etaQuotient _ hz⟩

end F32A2Pins


-- ---------------------------------------------------------------------------------------------
-- F3.2-A3 -- `divisor_smul_comm`: THE COMMUTATION IDENTITY `δ · (γ z) = γ_δ · (δ z)`.  Sorry-free.
--
-- WHAT WAS ACTUALLY PROVED, in English (LL-1).  Let `δ ∣ N`, `δ > 0`, and let
-- `γ = !![a,b;c,d] ∈ Γ₀(N)`, so that `N ∣ c` and hence `δ ∣ c`.  Put
-- `γ_δ := !![a, b·δ; c/δ, d]`.  Then (i) `det γ_δ = a·d − (b·δ)·(c/δ) = a·d − b·c = 1`, so
-- `γ_δ ∈ SL(2,ℤ)`; (ii) for EVERY `z ∈ ℍ`, scaling by `δ` intertwines the two Möbius actions,
-- `δ · (γ z) = γ_δ · (δ z)`; and (iii) the automorphy denominators agree ON THE NOSE,
-- `denom γ_δ (δ z) = (c/δ)·(δ z) + d = c z + d = denom γ z`.  That last equality is the whole
-- point of the node: it is what lets F3.2-A4 collect the `Δ`-modularity factors across the
-- divisors `δ ∣ N` into a SINGLE power of `denom γ z`.
--
-- NO ANALYSIS IS USED, and in particular `denom_ne_zero` is NOT used.  The two Möbius quotients
-- are rewritten to have a syntactically equal denominator before anything is divided, so the
-- proof never needs `c z + d ≠ 0`.  The only arithmetic input is `Int.mul_ediv_cancel'`,
-- `δ · (c/δ) = c`, valid because `δ ∣ c`.
--
-- SCOPE -- read before citing.  This is matrix arithmetic on `SL(2,ℤ)` and the `ℍ`-action.  It
-- says NOTHING about `η`, about the eta quotient, about `Δ`, or about the multiplier system.  It
-- is a lemma FOR F3.2-A4, not a step of Ligozat's criterion; the Dedekind-sum obstruction
-- (`F3.2-OBSTRUCTED`) is completely untouched, and the tripwire above still certifies that
-- `multiplier_trivial_of_congr` depends on `sorryAx`.
--
-- WHERE `Γ₀(N)` ENTERS, and it is only one line: `dvd_lower_left_of_mem_Gamma0`.  Everything
-- else in the block is stated over the bare hypothesis `(δ : ℤ) ∣ γ 1 0`, which is strictly
-- weaker and is the form F3.2-A4 will consume.

/-- info: 'SocrateAI.ModularForms.divisorConjMat' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisorConjMat

/-- info: 'SocrateAI.ModularForms.divisorConjMat_det' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisorConjMat_det

/-- info: 'SocrateAI.ModularForms.divisorConj' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisorConj

/-- info: 'SocrateAI.ModularForms.divisorConj_zero_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisorConj_zero_zero

/-- info: 'SocrateAI.ModularForms.divisorConj_zero_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisorConj_zero_one

/-- info: 'SocrateAI.ModularForms.divisorConj_one_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisorConj_one_zero

/-- info: 'SocrateAI.ModularForms.divisorConj_one_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisorConj_one_one

/-- info: 'SocrateAI.ModularForms.dvd_lower_left_of_mem_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.dvd_lower_left_of_mem_Gamma0

/-- info: 'SocrateAI.ModularForms.denom_divisorConj' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.denom_divisorConj

/-- info: 'SocrateAI.ModularForms.divisor_smul_comm_explicit' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisor_smul_comm_explicit

/-- info: 'SocrateAI.ModularForms.divisor_smul_comm' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.divisor_smul_comm

section F32A3Pins
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix
open scoped MatrixGroups

-- PIN 1 -- the node was scoped with `N : ℕ+`, and the landed form takes `N : ℕ` with an explicit
-- `0 < δ`.  That is not a hidden extra hypothesis: at a POSITIVE level, `δ ∣ N` already forces
-- `0 < δ`.  This pin is the proof, and PIN 3 consumes it.
example : ∀ (N : ℕ+) (_δ : ℕ), _δ ∣ (N : ℕ) → 0 < _δ :=
  fun N _ hδ => Nat.pos_of_dvd_of_pos hδ N.pos

-- PIN 2 -- the scaled point of the scoped statement, `⟨δ • z, _⟩ : ℍ`, really is multiplication
-- by `δ` in `ℂ`.  If `natScale` ever drifts (to `δ⁻¹`, say, or to an additive translation), this
-- is what fails, and PIN 3's `ℂ`-level reading of the node becomes false.
example : ∀ (δ : ℕ) (hδ0 : 0 < δ) (z : ℍ),
    ((SocrateAI.ModularForms.natScale δ hδ0 • z : ℍ) : ℂ) = (δ : ℂ) * (z : ℂ) := by
  intro δ hδ0 z
  simp [SocrateAI.ModularForms.natScale, Complex.real_smul]

-- PIN 3 -- THE SCOPED SIGNATURE, verbatim: level a POSITIVE natural, `γ` an ELEMENT of `Γ₀(N)`
-- rather than a matrix plus a membership hypothesis, and the first conclusion stated in `ℂ` as
-- `δ · (γ z) = γ' · (δ z)` rather than as an equation in `ℍ`.  Nothing is weakened: the landed
-- `ℍ`-form implies this, via PIN 1 for the positivity and PIN 2 for the coercion.
example : ∀ (N : ℕ+) (δ : ℕ) (hδ : δ ∣ (N : ℕ)) (γ : Gamma0 (N : ℕ)),
    ∃ γ' : SL(2, ℤ),
      (∀ z : ℍ, (δ : ℂ) * (((γ : SL(2, ℤ)) • z : ℍ) : ℂ)
          = ((γ' • (SocrateAI.ModularForms.natScale δ
              (Nat.pos_of_dvd_of_pos hδ N.pos) • z : ℍ) : ℍ) : ℂ)) ∧
      (∀ z : ℍ, denom γ' (SocrateAI.ModularForms.natScale δ
          (Nat.pos_of_dvd_of_pos hδ N.pos) • z : ℍ) = denom (γ : SL(2, ℤ)) z) := by
  intro N δ hδ γ
  obtain ⟨γ', h1, h2⟩ :=
    SocrateAI.ModularForms.divisor_smul_comm hδ (Nat.pos_of_dvd_of_pos hδ N.pos) γ.2
  refine ⟨γ', fun z => ?_, h2⟩
  rw [← h1 z]
  simp [SocrateAI.ModularForms.natScale, Complex.real_smul]

-- PIN 4 -- THE ANTI-JUNK-WITNESS GUARD, and the reason the explicit-witness lemmas exist at all.
-- `divisor_smul_comm` is an EXISTENTIAL, and an existential is only as informative as its
-- witness.  This pin re-proves the node with the four entries of `γ'` pinned to Ligozat's
-- `!![a, b·δ; c/δ, d]`.  A proof that satisfied the two equations with some other matrix -- or
-- that quietly used `γ` itself -- dies here.
example : ∀ (N δ : ℕ) (_hδ : δ ∣ N) (hδ0 : 0 < δ) (γ : SL(2, ℤ)), γ ∈ Gamma0 N →
    ∃ γ' : SL(2, ℤ),
      (γ' 0 0 = γ 0 0 ∧ γ' 0 1 = γ 0 1 * (δ : ℤ) ∧
        γ' 1 0 = γ 1 0 / (δ : ℤ) ∧ γ' 1 1 = γ 1 1) ∧
      (∀ z : ℍ, (SocrateAI.ModularForms.natScale δ hδ0 • (γ • z) : ℍ)
          = γ' • (SocrateAI.ModularForms.natScale δ hδ0 • z : ℍ)) ∧
      (∀ z : ℍ, denom γ' (SocrateAI.ModularForms.natScale δ hδ0 • z : ℍ) = denom γ z) := by
  intro N δ hδ hδ0 γ hγ
  have h : (δ : ℤ) ∣ γ 1 0 := SocrateAI.ModularForms.dvd_lower_left_of_mem_Gamma0 hδ hγ
  exact ⟨SocrateAI.ModularForms.divisorConj h, ⟨rfl, rfl, rfl, rfl⟩,
    fun z => SocrateAI.ModularForms.divisor_smul_comm_explicit hδ0 h z,
    fun z => SocrateAI.ModularForms.denom_divisorConj hδ0 h z⟩

-- PIN 5 -- SANITY AT `δ = 1`: the construction is the identity, `γ_1 = γ`.  A sign error or a
-- transposition in `divisorConjMat` shows up here immediately.
example : ∀ (γ : SL(2, ℤ)) (h : ((1 : ℕ) : ℤ) ∣ γ 1 0),
    SocrateAI.ModularForms.divisorConj h = γ := by
  intro γ h
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [SocrateAI.ModularForms.divisorConj, SocrateAI.ModularForms.divisorConjMat]

-- PIN 6 -- A CONCRETE INSTANCE, computed rather than asserted.  `N = 4`, `δ = 2`,
-- `γ = !![1,0;4,1] ∈ Γ₀(4)`;  the conjugate is `γ_2 = !![1,0;2,1]`, which is in `Γ₀(2)` and not
-- in `Γ₀(4)` -- the level really does drop by `δ`, exactly as the classical statement says.
example : (SocrateAI.ModularForms.divisorConjMat 2 ⟨!![1, 0; 4, 1], by decide⟩
      : Matrix (Fin 2) (Fin 2) ℤ) = !![1, 0; 2, 1] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [SocrateAI.ModularForms.divisorConjMat]

end F32A3Pins

-- ---------------------------------------------------------------------------------------------
-- F3.2-A4 -- `etaQuotient_pow24_slash`: `f²⁴` IS `Γ₀(N)`-SLASH-INVARIANT OF WEIGHT `12·Σr_δ`,
-- UNCONDITIONALLY.  Sorry-free.
--
-- WHAT WAS ACTUALLY PROVED, in English (LL-1).  Let `N ≥ 1`, let `r : ℕ → ℤ` be an ARBITRARY
-- integer exponent vector (mixed signs allowed), and let `f(τ) = ∏_{δ ∣ N} η(δτ)^{r_δ}`.  Then
-- for EVERY `γ = !![a,b;c,d] ∈ Γ₀(N)` and every `τ ∈ ℍ`,
--
--     f(γτ)²⁴ = (cτ + d)^{12·Σ_δ r_δ} · f(τ)²⁴,
--
-- equivalently `f²⁴ ∣[12·Σ r_δ] γ = f²⁴`.  NO congruence condition on `r` is assumed: neither
-- `24 ∣ Σ δ r_δ` nor `24 ∣ Σ (N/δ) r_δ` appears anywhere in the statement or the proof.  This
-- is the step that DODGES the eta multiplier system, and with it the Dedekind sums Mathlib does
-- not have: passing to the 24th power replaces `η` by `Δ = η²⁴`, whose modularity is Mathlib's
-- and is for the FULL modular group.
--
-- WHERE THE CONTENT COMES FROM, so credit sits where it belongs.  The only analytic input is
-- Mathlib's: `slash_action_generators_SL2Z` applied to `discriminant_S_invariant` and
-- `discriminant_T_invariant`, i.e. `Δ ∣[12] γ = Δ` for every `γ ∈ SL(2,ℤ)`.  Everything else is
-- F3.2-A3 (`divisor_smul_comm_explicit`, `denom_divisorConj`) plus `zpow` bookkeeping.  The
-- crucial structural fact is the SECOND half of F3.2-A3: `denom γ_δ (δτ) = denom γ τ`, the SAME
-- automorphy factor for every `δ ∣ N`, which is what lets `prod_zpow_const` collapse the
-- `δ`-indexed factors into one power `(denom γ τ)^{12·Σ r_δ}`.  Had the denominators differed
-- with `δ`, no single weight would exist and the node would be false as stated.
--
-- TWO HYPOTHESES ARE UNUSED, and that is reported, not hidden.  `etaQuotient_pow_24` carries
-- `z ∈ ℍₒ` and `etaQuotient_pow24_slash` carries `0 < N`; neither is consumed.  The first is
-- unused because `zpow_mul` is unconditional in `ℂ` (a `CommGroupWithZero`), the second because
-- at `N = 0` the divisor set is empty, `f ≡ 1` and the weight is `0`, so the statement is true
-- but vacuous.  Both are kept because they are verbatim the scoped signatures.
--
-- SCOPE -- READ BEFORE CITING.  This is `f²⁴`, NOT `f`.  It says NOTHING about the eta
-- multiplier of `f` itself, nothing about Ligozat's two congruences, and nothing about the
-- cusps: it is an identity on the OPEN upper half-plane.  Extracting `f` from `f²⁴` is F3.2-A5,
-- which is now PROVED (see the `F32A5Pins` section below) -- but only as EXISTENCE of the
-- multiplier, never its value; the Dedekind-sum obstruction `F3.2-OBSTRUCTED` is completely
-- untouched, and the tripwire above still certifies that `multiplier_trivial_of_congr` depends
-- on `sorryAx`.

/-- info: 'SocrateAI.ModularForms.zpow_pow24_comm' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.zpow_pow24_comm

/-- info: 'SocrateAI.ModularForms.prod_zpow_const' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.prod_zpow_const

/-- info: 'SocrateAI.ModularForms.pow_twelve_zpow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.pow_twelve_zpow

/-- info: 'SocrateAI.ModularForms.etaQuotient_pow_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_pow_24

/-- info: 'SocrateAI.ModularForms.coe_natScale_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.coe_natScale_smul

/-- info: 'SocrateAI.ModularForms.eta_pow24_natScale_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_pow24_natScale_smul

/-- info: 'SocrateAI.ModularForms.etaQuotientH_pow_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_pow_24

/-- info: 'SocrateAI.ModularForms.etaQuotientH_pow24_transform' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_pow24_transform

/-- info: 'SocrateAI.ModularForms.etaQuotient_pow24_slash' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_pow24_slash

section F32A4Pins
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix Complex
open scoped MatrixGroups Real

-- PIN 1 -- THE SCOPED SIGNATURE, longhand.  Level a POSITIVE natural, `γ` an ELEMENT of `Γ₀(N)`
-- rather than a matrix plus a membership hypothesis, the exponent vector the bare `ℕ → ℤ`
-- rather than the `EtaExp` abbreviation, and the eta quotient written out as the product over
-- `Nat.divisors` with `ModularForm.eta` fully qualified -- nothing hides behind our definitions.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (γ : Gamma0 (N : ℕ)),
    (fun τ : ℍ =>
        (∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ)) ^ (24 : ℕ))
        ∣[(12 * ∑ δ ∈ (N : ℕ).divisors, r δ : ℤ)] (((γ : SL(2, ℤ))) : GL (Fin 2) ℝ)
      = fun τ : ℍ =>
        (∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ)) ^ (24 : ℕ) := by
  intro N r γ
  exact SocrateAI.ModularForms.etaQuotient_pow24_slash N.pos r γ.2

-- PIN 2 -- THE POINTWISE READING, with the automorphy factor written as `c·τ + d` rather than
-- as `denom`.  This is the form a referee checks against the classical statement, and it is
-- where a sign or a transposition in the lower row of `γ` would show up.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (γ : Gamma0 (N : ℕ)) (τ : ℍ),
    (∏ δ ∈ (N : ℕ).divisors,
        ModularForm.eta ((δ : ℂ) * (((γ : SL(2, ℤ)) • τ : ℍ) : ℂ)) ^ (r δ)) ^ (24 : ℕ)
      = (((γ : SL(2, ℤ)) 1 0 : ℂ) * (τ : ℂ) + ((γ : SL(2, ℤ)) 1 1 : ℂ))
          ^ (12 * ∑ δ ∈ (N : ℕ).divisors, r δ)
        * (∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ)) ^ (24 : ℕ) := by
  intro N r γ τ
  have h := SocrateAI.ModularForms.etaQuotientH_pow24_transform r γ.2 τ
  rw [ModularGroup.denom_apply] at h
  exact h

-- PIN 3 -- `f²⁴` REALLY IS A `Δ`-QUOTIENT, stated with MATHLIB's `ModularForm.discriminant` at
-- the dilated points: `f(τ)²⁴ = ∏_{δ ∣ N} Δ(δτ)^{r_δ}`.  This is the sentence that makes the
-- whole node possible, and it is pinned against Mathlib's object, not against `η²⁴` spelled by
-- us.  (`Finset.attach` is only there to carry the `0 < δ` needed to form the point `δτ : ℍ`.)
example : ∀ (N : ℕ) (r : ℕ → ℤ) (τ : ℍ),
    (SocrateAI.ModularForms.etaQuotientH N r τ) ^ (24 : ℕ)
      = ∏ δ ∈ N.divisors.attach,
          (ModularForm.discriminant (SocrateAI.ModularForms.natScale (δ : ℕ)
            (Nat.pos_of_mem_divisors δ.2) • τ : ℍ)) ^ (r (δ : ℕ)) := by
  intro N r τ
  rw [SocrateAI.ModularForms.etaQuotientH_pow_24,
    ← Finset.prod_attach N.divisors
      (fun δ => (ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (24 : ℕ)) ^ (r δ))]
  refine Finset.prod_congr rfl fun δ _ => ?_
  rw [ModularForm.discriminant, SocrateAI.ModularForms.coe_natScale_smul]

-- PIN 4 -- THE MATHLIB CROSS-CHECK, run in the strong direction (LL-1).  At `N = 1` and `r ≡ 1`
-- the eta quotient is `η` itself, `f²⁴ = Δ`, the weight is `12·1 = 12`, and `Γ₀(1) = SL(2,ℤ)`;
-- so this node REPROVES Mathlib's own `Δ ∣[12] γ = Δ` for every `γ ∈ SL(2,ℤ)`.  If the weight
-- normalisation, the `24`, or the divisor indexing were off, this would fail.
example : ∀ γ : SL(2, ℤ),
    ModularForm.discriminant ∣[(12 : ℤ)] (γ : GL (Fin 2) ℝ) = ModularForm.discriminant := by
  intro γ
  have hγ : γ ∈ Gamma0 1 := by
    rw [Gamma0_mem]
    exact Subsingleton.elim _ _
  have hfun : (SocrateAI.ModularForms.etaQuotientH 1 (fun _ => (1 : ℤ))) ^ (24 : ℕ)
      = ModularForm.discriminant := by
    funext τ
    simp [SocrateAI.ModularForms.etaQuotientH, SocrateAI.ModularForms.etaQuotient,
      ModularForm.discriminant, Nat.divisors_one]
  have hw : (12 * ∑ _δ ∈ (1 : ℕ).divisors, (1 : ℤ)) = 12 := by simp
  rw [← hfun, ← hw]
  exact SocrateAI.ModularForms.etaQuotient_pow24_slash Nat.one_pos _ hγ

-- PIN 5 -- the same statement with the slash written at `(γ : SL(2,ℤ))` rather than at the
-- `GL (Fin 2) ℝ` coercion the landed form uses.  `ModularForm.SL_slash` says the two agree; this
-- pin is what would catch a drift if that ever stopped being true.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (γ : Gamma0 (N : ℕ)),
    (fun τ : ℍ =>
        (∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ)) ^ (24 : ℕ))
        ∣[(12 * ∑ δ ∈ (N : ℕ).divisors, r δ : ℤ)] ((γ : SL(2, ℤ)) : SL(2, ℤ))
      = fun τ : ℍ =>
        (∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ)) ^ (24 : ℕ) := by
  intro N r γ
  rw [ModularForm.SL_slash]
  exact SocrateAI.ModularForms.etaQuotient_pow24_slash N.pos r γ.2

end F32A4Pins


-- ---------------------------------------------------------------------------------------------
-- F3.2-A5 -- `etaQuotient_multiplier`: THE ETA QUOTIENT TRANSFORMS UNDER `Γ₀(N)` WITH A
-- CHARACTER OF ORDER DIVIDING 24, UNCONDITIONALLY.  Sorry-free.
--
-- WHAT WAS ACTUALLY PROVED, in English (LL-1).  Let `N ≥ 1`, let `r : ℕ → ℤ` be an ARBITRARY
-- integer exponent vector, let `k : ℤ` satisfy `Σ_{δ ∣ N} r_δ = 2k`, and let
-- `f(τ) = ∏_{δ ∣ N} η(δτ)^{r_δ}`.  Then there EXISTS a group homomorphism
-- `w : Γ₀(N) →* ℂˣ` such that `w(γ)²⁴ = 1` for every `γ`, and
--
--     f(γτ) = w(γ) · (cτ + d)^k · f(τ)     for every γ = !![a,b;c,d] ∈ Γ₀(N) and every τ ∈ ℍ.
--
-- NO congruence condition on `r` appears: neither `24 ∣ Σ δ r_δ` nor `24 ∣ Σ (N/δ) r_δ` is
-- assumed.  The only hypothesis on the data is `Σ r_δ = 2k` with `k` an INTEGER, and that is
-- load-bearing twice over: it makes the weight of `f²⁴` equal to `24k` (so the `denom` powers
-- cancel exactly), and it makes `(cτ+d)^k` an unambiguous, branch-free cocycle.
--
-- WHERE THE CONTENT COMES FROM.  Three landed nodes and one Mathlib instance:
--   * F3.2-A4 `etaQuotientH_pow24_transform` -- `f(γτ)²⁴ = (cτ+d)^{12·Σr_δ} f(τ)²⁴`, itself
--     resting on Mathlib's full-level modularity of `Δ`.  This makes the ratio a 24th root of 1.
--   * F3.1-B7 `etaQuotientH_ne_zero` -- `f` is nowhere zero, so the ratio is defined.
--   * F3.1-B8 `differentiableAt_etaQuotient` -- `f` is holomorphic, hence continuous.
--   * Mathlib's `ContractibleSpace ℍ` (`UpperHalfPlane/Topology.lean`) -- `ℍ` is connected.
-- A continuous map from a connected space into the 24 roots of unity (a FINITE, hence discrete,
-- subset of `ℂ`) is constant: that is `eq_of_continuous_pow24_eq_one`, and it is the entire
-- topological content.  The homomorphism property is the automorphy cocycle `denom_SL_mul`
-- (Mathlib's `denom_cocycle` transported along `SpecialLinearGroup.mapGL ℝ`).
--
-- THE WITNESS IS NOT OPAQUE.  No choice is invoked: `w = etaMultiplierHom r hk` with
-- `w(γ) = f(γ·i) / ((denom γ i)^k · f(i))`, evaluated at the base point `i : ℍ`.  Constancy is
-- what makes this base point irrelevant, and `etaQuotientH_transform` is the resulting
-- pointwise law that F3.2-A6 and F3.2-A8 will specialise to `T` and to `V`.
--
-- ONE HYPOTHESIS IS UNUSED, and that is reported, not hidden.  `_hN : 0 < N` is not consumed:
-- at `N = 0` the divisor set is empty, `f ≡ 1`, `hk` forces `k = 0`, and the statement holds
-- with `w = 1`.  It is kept because it is verbatim the scoped signature.
--
-- SCOPE -- READ BEFORE CITING.  This asserts the EXISTENCE of the multiplier and its two
-- structural properties.  It does NOT compute `w(γ)` for any `γ` other than `1` (and, in the
-- guard below, for the level-1 discriminant vector where `f = Δ`).  It is NOT Ligozat's
-- criterion, it says nothing about the two congruences, and it says nothing at any cusp.  The
-- Dedekind-sum obstruction is precisely the question of the VALUE of `w(γ)` for a general `γ`,
-- and the tripwire above still certifies that `multiplier_trivial_of_congr` depends on
-- `sorryAx`.

/-- info: 'SocrateAI.ModularForms.finite_setOf_pow24_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.finite_setOf_pow24_eq_one

/-- info: 'SocrateAI.ModularForms.eq_of_continuous_pow24_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eq_of_continuous_pow24_eq_one

/-- info: 'SocrateAI.ModularForms.continuous_etaQuotientH' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.continuous_etaQuotientH

/-- info: 'SocrateAI.ModularForms.continuous_SL_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.continuous_SL_smul

/-- info: 'SocrateAI.ModularForms.continuous_denom_SL' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.continuous_denom_SL

/-- info: 'SocrateAI.ModularForms.denom_SL_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.denom_SL_mul

/-- info: 'SocrateAI.ModularForms.etaMultiplierAux_pow24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierAux_pow24

/-- info: 'SocrateAI.ModularForms.etaMultiplierAux_const' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierAux_const

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_ne_zero

/-- info: 'SocrateAI.ModularForms.etaQuotientH_transform' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_transform

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_one

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_mul

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom

/-- info: 'SocrateAI.ModularForms.etaQuotientH_level_one_24_transform' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_level_one_24_transform

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_level_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_level_one_24

/-- info: 'SocrateAI.ModularForms.etaQuotient_multiplier' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_multiplier

section F32A5Pins
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix Complex
open scoped MatrixGroups Real

-- PIN 1 -- THE SCOPED SIGNATURE, longhand.  Level a POSITIVE natural, the exponent vector the
-- bare `ℕ → ℤ` rather than the `EtaExp` abbreviation, the eta quotient written out as the
-- product over `Nat.divisors` with `ModularForm.eta` fully qualified, and the automorphy factor
-- written as `c·τ + d` rather than as `denom`.  Nothing hides behind a SocrateAI definition:
-- this is the sentence a referee checks against Ligozat's statement.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (k : ℤ), (∑ δ ∈ (N : ℕ).divisors, r δ) = 2 * k →
    ∃ w : Gamma0 (N : ℕ) →* ℂˣ,
      (∀ γ : Gamma0 (N : ℕ), (w γ) ^ (24 : ℕ) = 1) ∧
      ∀ (γ : Gamma0 (N : ℕ)) (τ : ℍ),
        (∏ δ ∈ (N : ℕ).divisors,
            ModularForm.eta ((δ : ℂ) * (((γ : SL(2, ℤ)) • τ : ℍ) : ℂ)) ^ (r δ))
          = (w γ : ℂ)
            * (((γ : SL(2, ℤ)) 1 0 : ℂ) * (τ : ℂ) + ((γ : SL(2, ℤ)) 1 1 : ℂ)) ^ k
            * ∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ) := by
  intro N r k hk
  obtain ⟨w, hw24, hwt⟩ := SocrateAI.ModularForms.etaQuotient_multiplier N.pos r hk
  refine ⟨w, hw24, fun γ τ => ?_⟩
  have h := hwt γ τ
  rw [ModularGroup.denom_apply] at h
  exact h

-- PIN 2 -- THE WITNESS IS NAMED, not chosen.  The `∃` of PIN 1 is inhabited by an explicit
-- homomorphism whose value at `γ` is the ratio at the base point `i`.  A proof that had smuggled
-- in `Classical.choice` to produce `w` would still satisfy PIN 1; it would not satisfy this.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (k : ℤ) (hk : (∑ δ ∈ N.divisors, r δ) = 2 * k)
    (γ : Gamma0 N),
    ((SocrateAI.ModularForms.etaMultiplierHom r hk γ : ℂˣ) : ℂ)
      = SocrateAI.ModularForms.etaQuotientH N r ((γ : SL(2, ℤ)) • UpperHalfPlane.I)
        / ((UpperHalfPlane.denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) ((UpperHalfPlane.I : ℍ) : ℂ)) ^ k
          * SocrateAI.ModularForms.etaQuotientH N r UpperHalfPlane.I) :=
  fun _ _ _ _ _ => rfl

-- PIN 3 -- THE LL-1 EXTERNAL CROSS-CHECK, and the reason this node is not merely internally
-- consistent.  At `N = 1`, `r ≡ 24`, `k = 12` the eta quotient IS Mathlib's `Δ`, which is
-- `SL(2,ℤ)`-modular of weight 12 with TRIVIAL multiplier.  So the multiplier this node produces
-- must be `1` on all of `Γ₀(1) = SL(2,ℤ)`.  A weight convention off by a factor 2, a stray
-- `denom` power absorbed into `w`, or a `24` that migrated between the exponent and the scaling
-- all still elaborate above and all fail HERE, against an object we did not define.
example : ∀ γ : SL(2, ℤ),
    SocrateAI.ModularForms.etaMultiplierVal 1 (fun _ => (24 : ℤ)) 12 γ = 1 :=
  SocrateAI.ModularForms.etaMultiplierVal_level_one_24

-- PIN 4 -- THE SAME CROSS-CHECK RUN THROUGH THE TRANSFORMATION LAW, so that it constrains the
-- law and not just the number: for `f = Δ` the law degenerates to Mathlib's own
-- `Δ(γτ) = (cτ+d)¹² Δ(τ)`, with no multiplier left over.
example : ∀ (γ : SL(2, ℤ)) (τ : ℍ),
    ModularForm.discriminant ((γ : SL(2, ℤ)) • τ)
      = (((γ : SL(2, ℤ)) 1 0 : ℂ) * (τ : ℂ) + ((γ : SL(2, ℤ)) 1 1 : ℂ)) ^ (12 : ℤ)
        * ModularForm.discriminant τ := by
  intro γ τ
  have h := SocrateAI.ModularForms.etaQuotientH_transform (fun _ => (24 : ℤ))
    SocrateAI.ModularForms.sum_divisors_one_24 (SocrateAI.ModularForms.mem_Gamma0_one γ) τ
  rw [SocrateAI.ModularForms.etaMultiplierVal_level_one_24 γ, one_mul,
    SocrateAI.ModularForms.etaQuotientH_level_one_24,
    SocrateAI.ModularForms.etaQuotientH_level_one_24, ModularGroup.denom_apply] at h
  exact h

-- PIN 5 -- THE UNCONDITIONALITY, stated as a sentence rather than as an absent hypothesis: the
-- multiplier exists for an exponent vector chosen to satisfy NEITHER of Ligozat's congruences.
-- Take `N = 2`, `r₁ = 2`, `r₂ = 0`: then `Σ r_δ = 2 = 2·1` (so `k = 1`), while
-- `Σ δ r_δ = 2` and `Σ (N/δ) r_δ = 4`, neither divisible by 24.
example : ∃ w : Gamma0 2 →* ℂˣ,
      (∀ γ : Gamma0 2, (w γ) ^ (24 : ℕ) = 1) ∧
      ∀ (γ : Gamma0 2) (τ : ℍ),
        SocrateAI.ModularForms.etaQuotientH 2 (fun δ => if δ = 1 then 2 else 0)
            ((γ : SL(2, ℤ)) • τ)
          = (w γ : ℂ)
            * (UpperHalfPlane.denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (τ : ℂ)) ^ (1 : ℤ)
            * SocrateAI.ModularForms.etaQuotientH 2 (fun δ => if δ = 1 then 2 else 0) τ := by
  refine SocrateAI.ModularForms.etaQuotient_multiplier (by norm_num) _ ?_
  decide

end F32A5Pins


-- ---------------------------------------------------------------------------------------------
-- F3.2-A6 -- `multiplier_T_eq_one`: LIGOZAT'S CONGRUENCE (i) IS EXACTLY TRIVIALITY OF THE
-- MULTIPLIER ON `T`.  Sorry-free.
--
-- WHAT WAS ACTUALLY PROVED, in English (LL-1).  Let `N : ℕ`, let `r : ℕ → ℤ` be an arbitrary
-- integer exponent vector and let `f(z) = ∏_{δ ∣ N} η(δz)^{r_δ}`.  Then
--
--     f(z + 1) = e^{πi (Σ_{δ ∣ N} δ·r_δ) / 12} · f(z)      for every z,
--
-- and consequently, writing `S = Σ_{δ ∣ N} δ·r_δ`,
--
--     24 ∣ S   ⟺   f(Tz) = f(z) for all z ∈ ℍ   ⟺   w(T) = 1,
--
-- where `w : Γ₀(N) →* ℂˣ` is the character produced by F3.2-A5.  The middle and right forms
-- coincide because `denom T z = 1` (`denom_T`), so the weight `k` drops out of the `T`-statement
-- entirely -- which is why `multiplier_T_eq_one` needs NO `hk` and no `k` at all, while
-- `etaMultiplierVal_T_eq_one` (the `w(T) = 1` form) does.
--
-- THE `⟸` DIRECTION IS PROVED TOO, and that is the point of the word "exactly".
-- `ligozatCongr1_iff_T_invariant` is an IFF: if `f(Tz) = f(z)` at even the single point `z = i`
-- then `e^{πiS/12} = 1`, so `πiS/12 = n·2πi` (`Complex.exp_eq_one_iff`) and cancelling the
-- nonzero `πi` gives `S = 24n`.  Without this direction, "condition (i) is exactly w(T) = 1"
-- would be a one-way implication dressed as an equivalence.
--
-- WHERE THE CONTENT COMES FROM.  Entirely F3.1-B3 (`eta_add_int`: `η(z+m) = e^{2πim/24} η(z)`
-- for INTEGER `m`, proved from the `q`-product) applied factorwise at the point `δz` and the
-- integer `δ`, plus `zpow`/`exp` algebra: `mul_zpow`, `Complex.exp_int_mul` backwards,
-- `Finset.prod_mul_distrib`, `Complex.exp_sum`.  NO DEDEKIND SUMS, and no multiplier system:
-- `T` is a single matrix and `η` under `⟨T⟩` is elementary.  The `Γ₀(N)`-membership of `T` is
-- `ModularGroup.coe_T` (lower-left entry `0`), and the `ℍ`-action is Mathlib's
-- `modular_T_smul`.
--
-- ONE HYPOTHESIS IS UNUSED, reported not hidden.  `etaQuotient_T_transform` carries
-- `_hz : z ∈ ℍₒ` and does not consume it: `eta_add_int` holds on all of `ℂ`.  It is kept
-- because it is verbatim the scoped signature; PIN 2 pins the statement WITH the hypothesis.
--
-- SCOPE -- READ BEFORE CITING.  This is the multiplier at the SINGLE generator `T`, plus the
-- exact arithmetic condition for it to be trivial.  It is NOT Ligozat's criterion: nothing here
-- evaluates `w` at any `γ` outside `⟨T⟩`, nothing here is about the Fricke conjugate `V`
-- (that is F3.2-A8, proved separately below) or about any cusp, and the reduction of `Γ₀(N)`
-- to `T`, `V` and `-I` remains the named obstruction.  The tripwire above still certifies
-- `multiplier_trivial_of_congr` as depending on `sorryAx`, and (as of F3.2-A8) that is the
-- ONLY remaining `sorry` in the F3.2 block.

/-- info: 'SocrateAI.ModularForms.T_mem_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.T_mem_Gamma0

/-- info: 'SocrateAI.ModularForms.etaQuotient_T_transform' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_T_transform

/-- info: 'SocrateAI.ModularForms.coe_T_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.coe_T_smul

/-- info: 'SocrateAI.ModularForms.etaQuotientH_T_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_T_smul

/-- info: 'SocrateAI.ModularForms.multiplier_T_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_T_eq_one

/-- info: 'SocrateAI.ModularForms.denom_T' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.denom_T

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_T_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_T_eq_one

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_T_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom_T_eq_one

/-- info: 'SocrateAI.ModularForms.ligozatCongr1_iff_T_invariant' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatCongr1_iff_T_invariant

/-- info: 'SocrateAI.ModularForms.etaQuotient_T_transform_level_one_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_T_transform_level_one_pin

/-- info: 'SocrateAI.ModularForms.etaQuotient_T_transform_level_two_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_T_transform_level_two_pin

/-- info: 'SocrateAI.ModularForms.ligozatCongr1_level_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatCongr1_level_one_24

/-- info: 'SocrateAI.ModularForms.discriminant_T_via_multiplier' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.discriminant_T_via_multiplier

/-- info: 'SocrateAI.ModularForms.eta_not_T_invariant' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_not_T_invariant

-- STATEMENT PINS (LL-1).  The guards above certify the PROOFS; these certify the STATEMENTS.
section F32A6Pins
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix Complex
open scoped MatrixGroups Real

-- PIN 1 -- THE SCOPED SIGNATURE, longhand and in the node's own words: level a POSITIVE natural,
-- the hypothesis written as the CONGRUENCE `Σ δ r_δ ≡ 0 (mod 24)` in `ZMod 24` (not as a
-- divisibility), and the conclusion `w ⟨T, T_mem_Gamma0 N⟩ = 1` for the BUNDLED character
-- `w : Γ₀(N) →* ℂˣ` produced by F3.2-A5.  This is the sentence the node was scoped in; a proof
-- that only established `f(z+1) = f(z)` without connecting it to `w` would not satisfy it.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (k : ℤ) (hk : (∑ δ ∈ (N : ℕ).divisors, r δ) = 2 * k),
    (((∑ δ ∈ (N : ℕ).divisors, (δ : ℤ) * r δ : ℤ) : ZMod 24) = 0) →
    SocrateAI.ModularForms.etaMultiplierHom r hk
        ⟨ModularGroup.T, SocrateAI.ModularForms.T_mem_Gamma0 (N : ℕ)⟩ = 1 := by
  intro N r k hk h
  refine SocrateAI.ModularForms.etaMultiplierHom_T_eq_one r hk ?_
  have := (ZMod.intCast_zmod_eq_zero_iff_dvd
    (∑ δ ∈ (N : ℕ).divisors, (δ : ℤ) * r δ) 24).mp h
  exact_mod_cast this

-- PIN 2 -- THE TRANSFORMATION LAW, longhand: no SocrateAI definition on either side, the eta
-- quotient written out as the product over `Nat.divisors` with `ModularForm.eta` fully
-- qualified, and the constant written with `Real.pi` and `Complex.I` spelled out.  This is where
-- a constant that drifted from `πi/12` to `2πi/24`-of-the-wrong-thing, or a `Σ δ r_δ` that
-- became `Σ r_δ`, would fail.  The unused `z ∈ ℍₒ` hypothesis is pinned here too.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (z + 1)) ^ (r δ))
      = Complex.exp ((Real.pi : ℂ) * Complex.I
            * ((∑ δ ∈ N.divisors, (δ : ℤ) * r δ : ℤ) : ℂ) / 12)
        * ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * z) ^ (r δ) :=
  fun _ r _ hz => SocrateAI.ModularForms.etaQuotient_T_transform r hz

-- PIN 3 -- THE `T`-INVARIANCE, longhand and as an IFF, so the word "exactly" in the node
-- description is the theorem and not a gloss.  Note the hypothesis side is the DIVISIBILITY
-- `24 ∣ Σ δ r_δ` and the conclusion side quantifies over all `z : ℍ`.
example : ∀ (N : ℕ) (r : ℕ → ℤ),
    ((24 : ℤ) ∣ ∑ δ ∈ N.divisors, (δ : ℤ) * r δ)
      ↔ ∀ z : ℍ, (∏ δ ∈ N.divisors,
            ModularForm.eta ((δ : ℂ) * ((ModularGroup.T • z : ℍ) : ℂ)) ^ (r δ))
          = ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ) :=
  fun N r => SocrateAI.ModularForms.ligozatCongr1_iff_T_invariant (N := N) r

-- PIN 4 -- `denom T z = 1`, written out as `c·z + d` with the entries of `T` rather than through
-- the `denom` abbreviation.  This is the identity that makes "f is 1-periodic" and "w(T) = 1"
-- the same statement; if it failed, PIN 1 and PIN 3 would be about different things.
example : ∀ z : ℍ,
    ((ModularGroup.T : SL(2, ℤ)) 1 0 : ℂ) * (z : ℂ)
        + ((ModularGroup.T : SL(2, ℤ)) 1 1 : ℂ) = 1 :=
  SocrateAI.ModularForms.denom_T

-- PIN 5 -- NON-VACUITY, as a sentence: `η` itself is not `1`-periodic.  At `N = 1`, `r ≡ 1` the
-- congruence is `24 ∣ 1`, which is false, so by PIN 3 the invariance must fail.  A version of
-- this node whose conclusion held for every `r` would die here.
example : ¬ (∀ z : ℍ, ModularForm.eta ((1 : ℂ) * ((ModularGroup.T • z : ℍ) : ℂ)) ^ (1 : ℤ)
    = ModularForm.eta ((1 : ℂ) * (z : ℂ)) ^ (1 : ℤ)) := by
  intro h
  refine SocrateAI.ModularForms.eta_not_T_invariant fun z => ?_
  have hz := h z
  simpa [SocrateAI.ModularForms.etaQuotientH, SocrateAI.ModularForms.etaQuotient,
    show (1 : ℕ).divisors = {1} from by decide] using hz

end F32A6Pins


-- ---------------------------------------------------------------------------------------------
-- F3.2-A7 -- `etaQuotient_fricke`: THE FRICKE INVOLUTION SENDS AN ETA QUOTIENT TO ITS DUAL.
-- Sorry-free.
--
-- WHAT WAS ACTUALLY PROVED, in English (LL-1).  Let `N : ℕ` with `0 < N`, let `r : ℕ → ℤ` be an
-- ARBITRARY integer exponent vector (mixed signs allowed) with `Σ_{δ ∣ N} r_δ = 2k` for an
-- INTEGER `k`, and let `f(z) = ∏_{δ ∣ N} η(δz)^{r_δ}`.  Then for every `z` in the OPEN upper
-- half-plane
--
--     f(-1/(Nz)) = i^{-k} · N^k · s^{-1/2} · z^k · f*(z),
--
-- where `s = ∏_{δ ∣ N} δ^{r_δ} > 0` is a positive REAL, `s^{-1/2}` is `(Real.sqrt s)⁻¹`, and
-- `f*(z) = ∏_{δ ∣ N} η(δz)^{r_{N/δ}}` is the DUAL eta quotient -- the exponent vector reversed
-- along the divisor involution `δ ↦ N/δ`.  NO congruence condition on `r` is assumed: neither
-- `24 ∣ Σ δ r_δ` nor `24 ∣ Σ (N/δ) r_δ` appears in the statement or the proof.
--
-- WHERE THE CONTENT COMES FROM.  The single analytic input is MATHLIB's
-- `ModularForm.eta_comp_eq_csqrt_I_inv` (`η(-1/w) = (√I)⁻¹ √w η(w)` on `ℍₒ`); it is used, not
-- reproved.  Everything else is bookkeeping, and the bookkeeping is the node:
--   * `δ · (-1/(Nz)) = -1/((N/δ)z)`, which is the divisor identity `δ·(N/δ) = N`;
--   * `csqrt_ofReal_mul`: `√(m·z) = √m·√z` for a POSITIVE REAL `m`.  This is FALSE for a general
--     complex scalar -- it is exactly where the branch cut would be crossed -- and it holds here
--     because `Complex.log_ofReal_mul` splits the logarithm with no `2πi` correction;
--   * `prod_sqrt_zpow`: `∏ (√a_δ)^{r_δ} = √(∏ a_δ^{r_δ})` for POSITIVE reals, which keeps the
--     entire square-root question inside `ℝ`, where no cut exists;
--   * `csqrt_zpow_two_mul` / `csqrt_inv_zpow_two_mul`: `(√x)^{2k} = x^k` for INTEGER `k`.  This
--     is where the integrality of the weight is load-bearing; at half-integral weight a residual
--     square root survives and the statement below is not even well posed;
--   * `Nat.prod_div_divisors` (the multiplicative divisor involution) for the dual quotient.
-- NO DEDEKIND SUMS, and no eta multiplier system: `W_N` composed with the `η` `S`-transform is
-- as elementary as `T` was in F3.2-A6.
--
-- THREE EXTERNAL GUARDS, not three restatements.  `eta_S_via_fricke` runs the node at `N = 1`,
-- `r ≡ 24`, `k = 12`, where `s = 1`, `N^k = 1`, `i^{-12} = 1` and the identity collapses to
-- `η(-1/z)^24 = z^12 η(z)^24` -- MATHLIB's `discriminant_S_invariant`.  PIN 4 below then RE-DERIVES
-- that same statement from Mathlib's theorem, so two independent derivations of one identity have
-- to agree.  SECOND-ROUTE AGREEMENT ONLY, though: at `N = 1`, `k = 12` it pins NO component of
-- the constant.  `fricke_level_two_pin` is the hand-checked `η(z)η(2z)` case at
-- `N = 2`, where the exponent vector is its own dual, so it pins the CONSTANT alone.
-- `fricke_dual_pin` is the converse check: at `N = 2`, `r = (2,0)` the dual `(0,2)` is a
-- DIFFERENT exponent vector, so a version of this node that forgot to reverse the exponents
-- asserts something false there.
--
-- NON-VACUITY CHECKED, not assumed (scratch/A7perturb.lean).  Five perturbations of the real
-- statement, each fed the real proof script, all fail to elaborate: `i^{+k}` for `i^{-k}`,
-- `N^{2k}` for `N^k`, `√s` for `(√s)⁻¹`, `z^{2k}` for `z^k`, and `f` for the dual `f*`.
--
-- SCOPE -- READ BEFORE CITING.  This is one identity on the OPEN upper half-plane relating `f`
-- at `-1/(Nz)` to `f*` at `z`.  It is NOT Ligozat's criterion, it says NOTHING about `Γ₀(N)`,
-- nothing about the multiplier `w` of F3.2-A5, and nothing at any cusp.  F3.2-A8
-- (`multiplier_V_eq_one`, guarded below) is the node that turns it into a statement about `w`.
-- The Dedekind-sum obstruction F3.2-OBSTRUCTED is UNTOUCHED: the inverted tripwire certifying
-- that `multiplier_trivial_of_congr` depends on `sorryAx` is unchanged and still passing, and
-- as of F3.2-A8 that is the ONLY remaining `sorry` in the F3.2 block of
-- `EtaQuotientModularity.lean`.

/-- info: 'SocrateAI.ModularForms.csqrt_sq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_sq

/-- info: 'SocrateAI.ModularForms.csqrt_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_ne_zero

/-- info: 'SocrateAI.ModularForms.csqrt_ofReal_of_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_ofReal_of_nonneg

/-- info: 'SocrateAI.ModularForms.csqrt_ofReal_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_ofReal_mul

/-- info: 'SocrateAI.ModularForms.csqrt_zpow_two_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_zpow_two_mul

/-- info: 'SocrateAI.ModularForms.csqrt_inv_zpow_two_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_inv_zpow_two_mul

/-- info: 'SocrateAI.ModularForms.zpow_sq_comm' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.zpow_sq_comm

/-- info: 'SocrateAI.ModularForms.prod_sqrt_zpow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.prod_sqrt_zpow

/-- info: 'SocrateAI.ModularForms.prod_sqrt_div_divisors' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.prod_sqrt_div_divisors

/-- info: 'SocrateAI.ModularForms.prod_eta_div_divisors' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.prod_eta_div_divisors

/-- info: 'SocrateAI.ModularForms.eta_fricke_factor' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_fricke_factor

/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_fricke

/-- info: 'SocrateAI.ModularForms.eta_S_via_fricke' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_S_via_fricke

/-- info: 'SocrateAI.ModularForms.fricke_level_two_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.fricke_level_two_pin

/-- info: 'SocrateAI.ModularForms.fricke_dual_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.fricke_dual_pin

-- STATEMENT PINS (LL-1).  The guards above certify the PROOFS; these certify the STATEMENTS.
section F32A7Pins
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix Complex
open scoped MatrixGroups Real

-- PIN 1 -- THE SCOPED SIGNATURE, longhand and in the node's own words: level a POSITIVE natural
-- (`ℕ+`), the point a bundled `z : ℍ`, the exponent vector the bare `ℕ → ℤ` rather than the
-- `EtaExp` abbreviation, and BOTH eta quotients written out as products over `Nat.divisors` with
-- `ModularForm.eta` fully qualified -- so nothing hides behind a SocrateAI definition, and in
-- particular the reversal `r_δ ↦ r_{N/δ}` on the right-hand side is visible as text.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (k : ℤ), (∑ δ ∈ (N : ℕ).divisors, r δ) = 2 * k → ∀ z : ℍ,
    (∏ δ ∈ (N : ℕ).divisors,
        ModularForm.eta ((δ : ℂ) * (-(1 / (((N : ℕ) : ℂ) * (z : ℂ))))) ^ (r δ))
      = Complex.I ^ (-k) * (((N : ℕ) : ℂ)) ^ k
        * ((Real.sqrt (∏ δ ∈ (N : ℕ).divisors, (δ : ℝ) ^ (r δ)) : ℝ) : ℂ)⁻¹
        * (z : ℂ) ^ k
        * ∏ δ ∈ (N : ℕ).divisors,
            ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r ((N : ℕ) / δ)) :=
  fun N r _ hk z => SocrateAI.ModularForms.etaQuotient_fricke N.pos r hk z.2

-- PIN 2 -- THE BRANCH-CLEAN SCALING LAW, with `Complex.sqrt` unfolded to the `cpow` it is
-- defined as, so that the pin is about MATHLIB's principal branch and not about a SocrateAI
-- notion of square root: for a POSITIVE REAL `m` and any `z ≠ 0`,
--     (m·z)^{1/2} = (√m : ℝ) · z^{1/2}.
-- Dropping `0 < m` makes this false, and it is the only place the branch cut could have been
-- crossed.
example : ∀ (m : ℝ), 0 < m → ∀ z : ℂ, z ≠ 0 →
    (((m : ℂ) * z) ^ (2⁻¹ : ℂ)) = ((Real.sqrt m : ℝ) : ℂ) * (z ^ (2⁻¹ : ℂ)) :=
  fun _ hm _ hz => SocrateAI.ModularForms.csqrt_ofReal_mul hm hz

-- PIN 3 -- THE REAL SQUARE-ROOT PRODUCT IDENTITY, longhand.  This is the lemma that keeps the
-- branch question inside `ℝ`; the positivity hypothesis on every factor is pinned with it,
-- because without it both sides are junk.
example : ∀ (t : Finset ℕ) (a : ℕ → ℝ), (∀ δ ∈ t, 0 < a δ) → ∀ r : ℕ → ℤ,
    (∏ δ ∈ t, (Real.sqrt (a δ)) ^ (r δ)) = Real.sqrt (∏ δ ∈ t, (a δ) ^ (r δ)) :=
  fun _ _ ha r => SocrateAI.ModularForms.prod_sqrt_zpow ha r

-- PIN 4 -- THE MATHLIB CROSS-CHECK, RUN IN THE STRONG DIRECTION.  At `N = 1`, `r ≡ 24`, `k = 12`
-- the eta quotient IS `η`, so this node asserts `η(-1/z)^24 = z^12 η(z)^24`, and that is exactly
-- MATHLIB's `discriminant_S_invariant` -- `Δ` slashed by weight `12` at `S` is `Δ` -- which is
-- REPROVED here from `etaQuotient_fricke` and nothing else.  SECOND-ROUTE AGREEMENT ONLY: at
-- `N = 1`, `k = 12` it pins NO component of the constant (`selfDual_pin_level_one_no_evidence_*`).
example : (ModularForm.discriminant ∣[(12 : ℤ)] ModularGroup.S) = ModularForm.discriminant := by
  funext z
  have hzne : (z : ℂ) ≠ 0 := UpperHalfPlane.ne_zero z
  have hdS : denom (ModularGroup.S : GL (Fin 2) ℝ) (z : ℂ) = (z : ℂ) := by
    rw [ModularGroup.denom_apply]
    simp [ModularGroup.coe_S]
  have h := SocrateAI.ModularForms.eta_S_via_fricke (z := (z : ℂ)) z.2
  rw [ModularForm.SL_slash_apply, UpperHalfPlane.modular_S_smul]
  simp only [ModularForm.discriminant]
  rw [hdS, show (-(z : ℂ))⁻¹ = -(1 / (z : ℂ)) by rw [one_div, inv_neg], h,
    show (-12 : ℤ) = -((12 : ℕ) : ℤ) by norm_num, _root_.zpow_neg, zpow_natCast]
  field_simp

-- PIN 5 -- THE HAND-CHECKED `η(z)η(Nz)` CASE at `N = 2`, `r ≡ 1`, `k = 1`, `s = 2`, written with
-- `Complex.I` and `Real.sqrt` spelled out.  Here the exponent vector is its own dual, so this pin
-- is about the CONSTANT `i^{-1}·2·(√2)⁻¹·z` alone.
example : ∀ z : ℂ, z ∈ UpperHalfPlane.upperHalfPlaneSet →
    ModularForm.eta (-(1 / ((2 : ℂ) * z))) * ModularForm.eta ((2 : ℂ) * (-(1 / ((2 : ℂ) * z))))
      = Complex.I⁻¹ * (2 : ℂ) * ((Real.sqrt 2 : ℝ) : ℂ)⁻¹ * z
        * (ModularForm.eta z * ModularForm.eta ((2 : ℂ) * z)) :=
  fun _ hz => SocrateAI.ModularForms.fricke_level_two_pin hz

-- PIN 6 -- NON-VACUITY OF THE DUAL, as a sentence.  At `N = 2` with `r = (2,0)` the eta quotient
-- is `η(z)^2` and its dual is `η(2z)^2` -- a DIFFERENT function.  The identity says
-- `η(-1/(2z))^2 = -2i·z·η(2z)^2`; a version of this node that forgot to reverse the exponents
-- would say `... = -2i·z·η(z)^2`, which is false.
example : ∀ z : ℂ, z ∈ UpperHalfPlane.upperHalfPlaneSet →
    ModularForm.eta (-(1 / ((2 : ℂ) * z))) ^ (2 : ℤ)
      = -(2 : ℂ) * Complex.I * z * ModularForm.eta ((2 : ℂ) * z) ^ (2 : ℤ) :=
  fun _ hz => SocrateAI.ModularForms.fricke_dual_pin hz

end F32A7Pins

-- ---------------------------------------------------------------------------------------------
-- F3.2-A8 -- `multiplier_V_eq_one`: LIGOZAT'S CONGRUENCE (ii) IS EXACTLY TRIVIALITY OF THE
-- MULTIPLIER ON `V = W_N T W_N^{-1} = !![1,0;-N,1]`.  Sorry-free.
--
-- WHAT WAS ACTUALLY PROVED, in English (LL-1).  Fix `N > 0`, an exponent vector `r : N -> Z` and
-- an INTEGER `k` with `sum_{d | N} r_d = 2k`.  Then, with `f(z) = prod_{d | N} eta(dz)^{r_d}` and
-- `V = !![1,0;-N,1]`, for EVERY `z` in the upper half-plane and with NO congruence hypothesis:
--
--     f(V.z) = e^{i pi (sum_{d | N} (N/d) r_d) / 12} * (1 - N z)^k * f(z)      [etaQuotientH_V_smul]
--
-- and `1 - N z` is exactly `denom V z` (`denom_matV`).  Consequently `24 | sum_d (N/d) r_d` --
-- Ligozat's congruence (ii) -- gives `f(V.z) = (denom V z)^k f(z)` (`multiplier_V_eq_one`), i.e.
-- `w(V) = 1` for the character `w` of F3.2-A5 (`etaMultiplierVal_V_eq_one`,
-- `etaMultiplierHom_V_eq_one`); and the converse holds too, so congruence (ii) is EQUIVALENT to
-- the `V`-law (`ligozatCongr2_iff_V_transform`).
--
-- HOW, and why there are no Dedekind sums.  `V = W_N T W_N^{-1}` with `W_N : z |-> -1/(Nz)`, so
-- the node is F3.2-A6 (the `T`-law) conjugated by F3.2-A7 (the Fricke law), used twice in
-- opposite directions.  Pushing `W_N` through `etaQuotient_fricke` replaces `f` by its DUAL
-- quotient; congruence (ii) for `r` IS congruence (i) for the dual vector `d |-> r_{N/d}`
-- (`sum_divisors_dual` / `ligozatCongr1_dual`, the divisor involution `Nat.sum_div_divisors`);
-- the dual of the dual is `r` again (`Nat.div_div_self`); and the two Fricke constants are
-- inverse on the dual pair because `sqrt(s) * sqrt(s*) = N^k` (`sqrt_prod_dual`, proved entirely
-- inside `R`, where no branch cut exists).  What survives is `i^{-2k} = (-1)^k` and
-- `(-1)^k (Nz-1)^k = (1-Nz)^k`.  No eta multiplier system is invoked and no Dedekind sum occurs.
--
-- NON-VACUITY CHECKED, not assumed (scratch/A8perturb.lean).  Four perturbations of the real
-- statement, each fed the real proof script, all fail to elaborate: congruence (i) in place of
-- (ii); `denom^{-k}` in place of `denom^k`; `T` in place of `V`; and `sum_d d r_d` in place of
-- `sum_d (N/d) r_d` in the unconditional constant.
--
-- SCOPE -- READ BEFORE CITING.  This is the multiplier at the SINGLE element `V`, plus the exact
-- arithmetic condition for it to be trivial.  It is NOT Ligozat's criterion.  Together with
-- F3.2-A6 it evaluates `w` on `T` and on `V` only; nothing here evaluates `w` at any other
-- `gamma in Gamma0 N`, nothing here is about any cusp, and the reduction of `Gamma0 N` to
-- `<T, V, -I>` -- which is FALSE for general `N` -- remains the named obstruction.  The tripwire
-- above still certifies `multiplier_trivial_of_congr` as depending on `sorryAx`; as of F3.2-A8
-- that is the ONLY remaining `sorry` in the F3.2 block of `EtaQuotientModularity.lean`.

/-- info: 'SocrateAI.ModularForms.matV_mem_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.matV_mem_Gamma0

/-- info: 'SocrateAI.ModularForms.denom_matV' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.denom_matV

/-- info: 'SocrateAI.ModularForms.coe_matV_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.coe_matV_smul

/-- info: 'SocrateAI.ModularForms.neg_inv_mem_upperHalfPlaneSet' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.neg_inv_mem_upperHalfPlaneSet

/-- info: 'SocrateAI.ModularForms.prod_zpow_div_divisors' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.prod_zpow_div_divisors

/-- info: 'SocrateAI.ModularForms.sum_divisors_dual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.sum_divisors_dual

/-- info: 'SocrateAI.ModularForms.ligozatCongr1_dual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatCongr1_dual

/-- info: 'SocrateAI.ModularForms.sqrt_prod_dual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.sqrt_prod_dual

/-- info: 'SocrateAI.ModularForms.mul_shuffle_aux' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.mul_shuffle_aux

/-- info: 'SocrateAI.ModularForms.ligozatCongr2_level_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatCongr2_level_one_24

/-- info: 'SocrateAI.ModularForms.etaQuotientH_V_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_V_smul

/-- info: 'SocrateAI.ModularForms.multiplier_V_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_V_eq_one

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_V_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_V_eq_one

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_V_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom_V_eq_one

/-- info: 'SocrateAI.ModularForms.ligozatCongr2_iff_V_transform' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatCongr2_iff_V_transform

/-- info: 'SocrateAI.ModularForms.multiplier_V_level_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_V_level_one_24

/-- info: 'SocrateAI.ModularForms.eta_two_sq_not_V_invariant' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_two_sq_not_V_invariant

-- STATEMENT PINS (LL-1).  The guards above certify the PROOFS; these certify the STATEMENTS.
section F32A8Pins
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix Complex
open scoped MatrixGroups Real

-- PIN 1 -- `V` IS THE MATRIX THE NODE CLAIMS, AND IT LIES IN `Gamma0 N`.  Written as a raw
-- `2 x 2` integer matrix, so no SocrateAI definition can be hiding a different element.
example : ∀ N : ℕ, ((SocrateAI.ModularForms.matV N : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ)
    = !![1, 0; -(N : ℤ), 1] :=
  fun N => SocrateAI.ModularForms.matV_coe N

example : ∀ N : ℕ, SocrateAI.ModularForms.matV N ∈ Gamma0 N :=
  SocrateAI.ModularForms.matV_mem_Gamma0

-- PIN 2 -- THE UNCONDITIONAL `V`-LAW, longhand and in the node's own words: level a POSITIVE
-- natural (`N+`), the point a bundled `z : H`, the exponent vector the bare `N -> Z` rather than
-- the `EtaExp` abbreviation, the eta quotient written out as a product over `Nat.divisors` with
-- `ModularForm.eta` fully qualified, the Moebius image written out as `z / (1 - N z)` rather
-- than as a group action, and the automorphy factor written out as `(1 - N z)^k`.  Nothing here
-- hides behind `etaQuotientH`, `matV` or `denom`.  NOTE the exponential: NO congruence
-- hypothesis is assumed, and congruence (ii) is visible as exactly the condition killing it.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (k : ℤ), (∑ δ ∈ (N : ℕ).divisors, r δ) = 2 * k → ∀ z : ℍ,
    (∏ δ ∈ (N : ℕ).divisors,
        ModularForm.eta ((δ : ℂ) * ((z : ℂ) / (1 - ((N : ℕ) : ℂ) * (z : ℂ)))) ^ (r δ))
      = Complex.exp ((Real.pi : ℂ) * Complex.I
            * ((∑ δ ∈ (N : ℕ).divisors, (((N : ℕ) / δ : ℕ) : ℤ) * r δ : ℤ) : ℂ) / 12)
        * (1 - ((N : ℕ) : ℂ) * (z : ℂ)) ^ k
        * ∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ) := by
  intro N r k hk z
  have h := SocrateAI.ModularForms.etaQuotientH_V_smul (N := (N : ℕ)) N.pos r hk z
  rw [SocrateAI.ModularForms.denom_matV] at h
  simpa only [SocrateAI.ModularForms.etaQuotientH, SocrateAI.ModularForms.etaQuotient,
    SocrateAI.ModularForms.coe_matV_smul] using h

-- PIN 3 -- CONGRUENCE (ii) IS EXACTLY THE `V`-LAW, as an IFF and with both sides spelled out.
-- Left: `24 | sum_{d | N} (N/d) r_d`, the divisibility in `Z`.  Right: the transformation law
-- for every `z`.  A one-directional transcription would not pin the word "exactly".
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (k : ℤ), (∑ δ ∈ (N : ℕ).divisors, r δ) = 2 * k →
    (((24 : ℤ) ∣ ∑ δ ∈ (N : ℕ).divisors, (((N : ℕ) / δ : ℕ) : ℤ) * r δ) ↔ ∀ z : ℍ,
      (∏ δ ∈ (N : ℕ).divisors,
          ModularForm.eta ((δ : ℂ) * ((z : ℂ) / (1 - ((N : ℕ) : ℂ) * (z : ℂ)))) ^ (r δ))
        = (1 - ((N : ℕ) : ℂ) * (z : ℂ)) ^ k
          * ∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ)) := by
  intro N r k hk
  have h := SocrateAI.ModularForms.ligozatCongr2_iff_V_transform (N := (N : ℕ)) N.pos r hk
  simp only [SocrateAI.ModularForms.LigozatCongr2] at h
  refine h.trans (forall_congr' fun z => ?_)
  rw [SocrateAI.ModularForms.denom_matV]
  simp only [SocrateAI.ModularForms.etaQuotientH, SocrateAI.ModularForms.etaQuotient,
    SocrateAI.ModularForms.coe_matV_smul]

-- PIN 4 -- NON-VACUITY, as a sentence.  `f(z) = eta(2z)^2` at `N = 2`, `k = 1` has
-- `sum_d (N/d) r_d = 2`, which is not divisible by 24, and it does NOT satisfy the `V`-law.
example : ¬ (∀ z : ℍ, SocrateAI.ModularForms.etaQuotientH 2
      (fun δ => if δ = 2 then (2 : ℤ) else 0) (SocrateAI.ModularForms.matV 2 • z)
    = (denom (SocrateAI.ModularForms.matV 2) z) ^ (1 : ℤ)
      * SocrateAI.ModularForms.etaQuotientH 2 (fun δ => if δ = 2 then (2 : ℤ) else 0) z) :=
  SocrateAI.ModularForms.eta_two_sq_not_V_invariant

end F32A8Pins




-- ---------------------------------------------------------------------------------------------
-- F3.1-B9 -- `etaQuotient_add` / `etaQuotientHom`: THE ETA QUOTIENT IS A MONOID HOMOMORPHISM IN
-- THE EXPONENT VECTOR.  Sorry-free.
--
-- READ THIS FIRST -- THE NODE WAS PARTLY A DUPLICATE, AND SAYING SO IS PART OF THE RESULT.
-- B9 was scoped as `etaQuotient N (r + s) τ = etaQuotient N r τ * etaQuotient N s τ` with
-- `τ : ℍ`, which in this library's naming is `etaQuotientH`.  THAT STATEMENT WAS ALREADY PROVED
-- AND ALREADY GUARDED as `etaQuotientH_add`, landed in the F3.1-B5 block and guarded ~400 lines
-- above with its own statement pin (B5 PIN 4).  It was NOT re-proved and NO second copy of it
-- was created.  PIN 1 below re-pins it here so the duplication is visible in one place rather
-- than discovered later.
--
-- WHAT B9 ACTUALLY ADDS, all of it genuinely absent before this commit:
--   (a) `etaQuotient_add` -- the same identity on the `ℂ`-DOMAIN with the hypothesis in
--       set-membership form `z ∈ upperHalfPlaneSet`.  Not cosmetic: `differentiableAt_etaQuotient`
--       and every F3.2 statement are on `ℂ` with that hypothesis shape, so the `ℍ` form cannot be
--       applied there without re-bundling the point.  Same `ℍ`-vs-`ℂ` split as B5's
--       `natCast_mul_mem_upperHalfPlaneSet` vs B7's `..._of_mem`.
--       Its companions `etaQuotient_neg` / `_zsmul` / `_zero_exp` carry NO hypothesis, because
--       `zpow_neg`, `zpow_mul` and `zpow_zero` hold at every base including the junk value.  That
--       asymmetry localises where non-vanishing is actually needed: `zpow_add₀` alone.
--   (b) `etaQuotientUnit` / `etaQuotientHom` -- the homomorphism as an OBJECT.  This is where
--       F3.1-B7 is consumed essentially: without `etaQuotientH_ne_zero` there is no map into
--       `ℂˣ` at all, only into the monoid `ℂ`, where `map_neg` does not exist.  The bundled
--       `(ℕ → ℤ) →+ Additive (ℍ → ℂˣ)` then yields `etaQuotientUnit_neg` and
--       `etaQuotientUnit_zsmul` from Mathlib's `map_neg` / `map_zsmul` with no separate proof --
--       PIN 5 is the longhand instance of that.
--   (c) `etaQuotientH_sum` -- the finite-combination form `f_{Σ r_i} = ∏ f_{r_i}` (two-line
--       induction), which is the shape the Ligozat calculus consumes.
--   (d) `etaQuotient_add_compositional` -- an LL-1 CROSS-CHECK, proving nothing new: one
--       proposition asserting that the SAME `r + s` multiplies the function (B9/B5), adds the
--       weight (F3.1-A1) and adds the cusp order (F3.1-A6).  That triple is the sentence "the
--       Ligozat calculus is compositional", which was otherwise only prose.
--
-- WHAT IT IS NOT.  Algebra of `zpow` at a nonvanishing base on the OPEN upper half-plane.  No
-- `Γ₀(N)`, no slash action, no multiplier system, nothing at a cusp: `etaQuotientCuspOrder` in
-- (d) is the ARITHMETIC definition of F3.1-A, and the theorem that it IS the vanishing order of
-- `f` remains open F3.2 work.  The Dedekind-sum obstruction `F3.2-OBSTRUCTED` is untouched.

/-- info: 'SocrateAI.ModularForms.etaQuotient_add' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_add

/-- info: 'SocrateAI.ModularForms.etaQuotient_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_neg

/-- info: 'SocrateAI.ModularForms.etaQuotient_zsmul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_zsmul

/-- info: 'SocrateAI.ModularForms.etaQuotient_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_zero_exp

/-- info: 'SocrateAI.ModularForms.etaQuotientUnit' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientUnit

/-- info: 'SocrateAI.ModularForms.etaQuotientUnit_coe' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientUnit_coe

/-- info: 'SocrateAI.ModularForms.etaQuotientHom' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientHom

/-- info: 'SocrateAI.ModularForms.etaQuotientHom_apply' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientHom_apply

/-- info: 'SocrateAI.ModularForms.etaQuotientUnit_add' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientUnit_add

/-- info: 'SocrateAI.ModularForms.etaQuotientUnit_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientUnit_neg

/-- info: 'SocrateAI.ModularForms.etaQuotientUnit_zsmul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientUnit_zsmul

/-- info: 'SocrateAI.ModularForms.etaQuotientH_sum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_sum

/-- info: 'SocrateAI.ModularForms.etaQuotient_add_compositional' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_add_compositional

-- STATEMENT PINS (LL-1) for F3.1-B9.  A clean footprint proves only that SOMETHING was proved.
-- These write the propositions out longhand with the exponent vector typed as the bare `ℕ → ℤ`
-- (not the `EtaExp` abbreviation), `upperHalfPlaneSet` fully qualified, the product spelled out
-- rather than hidden behind the definition, and a NEGATIVE-EXPONENT instance.
section B9Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- THE NODE EXACTLY AS SCOPED (`τ : ℍ`).  This is F3.1-B5's `etaQuotientH_add`, already
-- guarded above; it is re-pinned here so that the duplication B9 inherited is visible.
example : ∀ (N : ℕ) (r s : ℕ → ℤ) (τ : ℍ),
    SocrateAI.ModularForms.etaQuotientH N (r + s) τ
      = SocrateAI.ModularForms.etaQuotientH N r τ * SocrateAI.ModularForms.etaQuotientH N s τ :=
  fun N r s τ => SocrateAI.ModularForms.etaQuotientH_add N r s τ

-- PIN 2 -- WHAT IS NEW: the `ℂ`-domain form with the hypothesis in set-membership shape, the
-- product written out longhand.  Fails to elaborate if the index set, the `δ·` scaling inside
-- `η` or the `zpow` ever drift.
example : ∀ (N : ℕ) (r s : ℕ → ℤ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * z) ^ ((r + s) δ))
      = (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * z) ^ (r δ))
        * (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * z) ^ (s δ)) :=
  fun _ r s _ hz => SocrateAI.ModularForms.etaQuotient_add r s hz

-- PIN 3 -- THE NEGATIVE-EXPONENT INSTANCE.  `zpow_add₀` is FALSE at a vanishing base, so a proof
-- that secretly assumed `0 ≤ r δ` dies here: at `r ≡ -1`, `s ≡ 1` every factor on the right is a
-- genuine inverse and the left-hand side is the constant `1`.
example : ∀ (N : ℕ) (z : ℂ), z ∈ UpperHalfPlane.upperHalfPlaneSet →
    SocrateAI.ModularForms.etaQuotient N ((fun _ => (-1 : ℤ)) + (fun _ => (1 : ℤ))) z
      = SocrateAI.ModularForms.etaQuotient N (fun _ => (-1 : ℤ)) z
        * SocrateAI.ModularForms.etaQuotient N (fun _ => (1 : ℤ)) z :=
  fun _ _ hz => SocrateAI.ModularForms.etaQuotient_add _ _ hz

-- PIN 4 -- THE BUNDLED OBJECT, type written out: an ADDITIVE hom from exponent vectors to the
-- pointwise group of NOWHERE-VANISHING functions `ℍ → ℂˣ`, and its value is the eta quotient
-- longhand.  If `etaQuotientHom` is ever retargeted at `ℂ` (a monoid, not a group) or at values
-- rather than functions, this stops elaborating.
-- (`noncomputable` because the pin is DATA -- the hom itself -- and `η` is noncomputable; the
-- point of the pin is the ascribed TYPE, which is checked either way.)
noncomputable example : ∀ _ : ℕ, (ℕ → ℤ) →+ Additive (ℍ → ℂˣ) :=
  SocrateAI.ModularForms.etaQuotientHom

example : ∀ (N : ℕ) (r : ℕ → ℤ) (τ : ℍ),
    ((Additive.toMul (SocrateAI.ModularForms.etaQuotientHom N r) τ : ℂˣ) : ℂ)
      = ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ) :=
  fun _ _ _ => rfl

-- PIN 5 -- THE GROUP STRUCTURE IS REAL, not decorative: negating the exponent vector INVERTS the
-- unit.  This is `map_neg` on the bundled hom, and it is the statement that has no counterpart
-- at the level of `ℂ`-values -- which is exactly the content F3.1-B7 buys.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (τ : ℍ),
    (Additive.toMul (SocrateAI.ModularForms.etaQuotientHom N (-r)) τ : ℂˣ)
      = (Additive.toMul (SocrateAI.ModularForms.etaQuotientHom N r) τ : ℂˣ)⁻¹ :=
  fun N r τ => SocrateAI.ModularForms.etaQuotientUnit_neg N r τ

-- PIN 6 -- THE COMPOSITIONALITY TRIPLE, longhand.  The SAME `r + s` multiplies the function,
-- adds the `ℚ`-valued weight (F3.1-A1) and adds the `ℚ`-valued cusp order (F3.1-A6).  This is
-- the LL-1 check that B9 really is the object-level counterpart of the arithmetic layer.
example : ∀ (N : ℕ) (r s : ℕ → ℤ) (d : ℕ) (τ : ℍ),
    SocrateAI.ModularForms.etaQuotientH N (r + s) τ
        = SocrateAI.ModularForms.etaQuotientH N r τ * SocrateAI.ModularForms.etaQuotientH N s τ
      ∧ SocrateAI.ModularForms.etaQuotientWeight N (r + s)
          = SocrateAI.ModularForms.etaQuotientWeight N r
            + SocrateAI.ModularForms.etaQuotientWeight N s
      ∧ SocrateAI.ModularForms.etaQuotientCuspOrder N (r + s) d
          = SocrateAI.ModularForms.etaQuotientCuspOrder N r d
            + SocrateAI.ModularForms.etaQuotientCuspOrder N s d :=
  fun N r s d τ => SocrateAI.ModularForms.etaQuotient_add_compositional N r s d τ

-- PIN 7 -- the finite-combination form over an ARBITRARY index `Finset`, which is what a Ligozat
-- computation actually applies.
example : ∀ {ι : Type} (N : ℕ) (s : Finset ι) (r : ι → (ℕ → ℤ)) (τ : ℍ),
    SocrateAI.ModularForms.etaQuotientH N (∑ i ∈ s, r i) τ
      = ∏ i ∈ s, SocrateAI.ModularForms.etaQuotientH N (r i) τ :=
  fun N s r τ => SocrateAI.ModularForms.etaQuotientH_sum N s r τ

end B9Pins


-- ---------------------------------------------------------------------------------------------
-- F3.1-B10 — THE SECOND LL-1 EXTERNAL GUARD.  The level-1 eta quotient with `r₁ = 24` is
-- Mathlib's `ModularForm.discriminant`, and the same exponent vector sends the weight layer to
-- `12` and the cusp-order layer to `1`.  These are the only statements in the development whose
-- right-hand sides were not written by us: `Δ`, and the two numbers classically attached to it.
-- ---------------------------------------------------------------------------------------------

/-- info: 'SocrateAI.ModularForms.dedekindPsi_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.dedekindPsi_one

/-- info: 'SocrateAI.ModularForms.etaQuotientWeight_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientWeight_one_24

/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientCuspOrder_one_24

/-- info: 'SocrateAI.ModularForms.sum_etaQuotientCuspOrder_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.sum_etaQuotientCuspOrder_one_24

/-- info: 'SocrateAI.ModularForms.etaQuotient_one_eq_discriminant' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_one_eq_discriminant

/-- info: 'SocrateAI.ModularForms.etaQuotient_one_24_pins' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_one_24_pins

-- STATEMENT PINS (LL-1) for F3.1-B10.  A clean axiom footprint proves only that SOMETHING was
-- proved.  These write the three propositions out longhand: the exponent vector as the bare
-- `ℕ → ℤ` rather than the `EtaExp` abbreviation, the product over `Nat.divisors` spelled out
-- instead of hidden behind `etaQuotient`, `ModularForm.discriminant` fully qualified, and the
-- two numeric right-hand sides as literals in `ℚ`.
section B10Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- THE NODE EXACTLY AS SCOPED.  `η(τ)²⁴ = Δ(τ)` with the eta quotient written out: the
-- index set is `(1 : ℕ).divisors` (NOT `properDivisors`, which is empty at `N = 1` and would
-- make the left-hand side the constant `1`), the scaling `(δ : ℂ) * τ` is present, and the
-- exponent is a `zpow` by the integer `24`, whereas `Δ` is a `pow` by the natural `24`.
example : ∀ τ : ℍ,
    (∏ δ ∈ (1 : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ ((fun _ => (24 : ℤ)) δ))
      = ModularForm.discriminant τ :=
  fun τ => SocrateAI.ModularForms.etaQuotient_one_eq_discriminant τ

-- PIN 2 -- THE WEIGHT LAYER, longhand: `(1/2) Σ_{δ ∣ 1} 24 = 12`, the weight of `Δ`.
example : ((∑ _δ ∈ (1 : ℕ).divisors, (24 : ℚ)) / 2) = 12 :=
  SocrateAI.ModularForms.etaQuotientWeight_one_24

-- PIN 3 -- THE CUSP-ORDER LAYER, longhand: the transcribed formula at `N = d = 1` is `1`, the
-- order to which `Δ` vanishes at `∞`.  Written with the `gcd`s and the `N / d` division intact,
-- so a version that dropped the `gcd(d, N/d)` factor is not silently accepted.
example : ((1 : ℕ) : ℚ) / 24 * ∑ δ ∈ (1 : ℕ).divisors,
      ((Nat.gcd 1 δ : ℚ) ^ 2 * ((24 : ℤ) : ℚ)) / ((Nat.gcd 1 (1 / 1) : ℚ) * (1 : ℚ) * (δ : ℚ))
    = 1 :=
  SocrateAI.ModularForms.etaQuotientCuspOrder_one_24

-- PIN 4 -- THE THREE LAYERS AT ONCE, which is what makes this a guard rather than three
-- coincidences: the SAME exponent vector `r ≡ 24` at level `1` gives `Δ`, gives weight `12` and
-- gives cusp order `1`.
example : ∀ τ : ℍ,
    SocrateAI.ModularForms.etaQuotient 1 (fun _ => (24 : ℤ)) (τ : ℂ)
        = ModularForm.discriminant τ
      ∧ SocrateAI.ModularForms.etaQuotientWeight 1 (fun _ => (24 : ℤ)) = 12
      ∧ SocrateAI.ModularForms.etaQuotientCuspOrder 1 (fun _ => (24 : ℤ)) 1 = 1 :=
  SocrateAI.ModularForms.etaQuotient_one_24_pins

-- PIN 5 -- THE VALENCE CROSS-CHECK at `N = 1`: the weighted sum of cusp orders is `1`, the
-- classical divisor degree of `Δ` on `SL(2,ℤ)`.  Left side from `etaQuotientCuspOrder`, and the
-- number `1` from the literature, so this is F3.1-A10 pinned against `Δ` rather than against a
-- test vector.
example : (∑ d ∈ (1 : ℕ).divisors,
      (Nat.totient (Nat.gcd d (1 / d)) : ℚ)
        * SocrateAI.ModularForms.etaQuotientCuspOrder 1 (fun _ => (24 : ℤ)) d) = 1 :=
  SocrateAI.ModularForms.sum_etaQuotientCuspOrder_one_24

end B10Pins


-- ---------------------------------------------------------------------------------------------
-- F3.1-B11 — THE LEADING `q`-POWER.  `∏_δ η(δτ)^{r_δ}` splits as `exp(2πiτ·(Σ_δ δ r_δ)/24)` times
-- the tail `∏_δ (∏' n, (1 - eta_q n (δτ)))^{r_δ}`, the tail never vanishes on `ℍ`, and the
-- exponent is exactly the ARITHMETIC cusp order at `∞` of F3.1-A2/A3.  Pure `exp` bookkeeping:
-- `mul_zpow`, `Finset.prod_mul_distrib`, `Complex.exp_int_mul`, `Complex.exp_sum`.  NO limit is
-- taken anywhere, so this is an identity of exponents plus pointwise non-vanishing, NOT the
-- analytic claim that `ord_∞` is the vanishing order at the cusp.
-- ---------------------------------------------------------------------------------------------

/-- info: 'SocrateAI.ModularForms.etaQuotient_eq_qpow_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_eq_qpow_mul

/-- info: 'SocrateAI.ModularForms.etaQuotientH_eq_qpow_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_eq_qpow_mul

/-- info: 'SocrateAI.ModularForms.etaQuotient_qProduct_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_qProduct_ne_zero

/-- info: 'SocrateAI.ModularForms.etaQuotient_qpow_exponent_eq_cuspOrder_infty' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_qpow_exponent_eq_cuspOrder_infty

/-- info: 'SocrateAI.ModularForms.etaQuotient_eq_qpow_cuspOrder_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_eq_qpow_cuspOrder_mul

-- STATEMENT PINS (LL-1) for F3.1-B11.  A clean axiom footprint proves only that SOMETHING was
-- proved.  These write the propositions out longhand: the exponent vector as the bare `ℕ → ℤ`
-- rather than the `EtaExp` abbreviation, `etaQuotient` unfolded into the product over
-- `Nat.divisors`, `ModularForm.eta` and `ModularForm.eta_q` fully qualified, and the divisor
-- scaling `(δ : ℂ) * τ` present on both sides of the split.
section B11Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- THE NODE EXACTLY AS SCOPED.  The left-hand side is the product `∏_{δ ∣ N} η(δτ)^{r_δ}`
-- written out (no `etaQuotient` abbreviation), the exponent of the leading `exp` carries the
-- factor `δ` inside the sum (a version that dropped it, i.e. `Σ r_δ` instead of `Σ δ r_δ`, is
-- rejected here), the division by `24` is present, and the tail is Mathlib's `eta_q` product at
-- the SCALED point `δτ`, raised to the integer `r δ` as a `zpow`.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (τ : ℍ),
    (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ))
      = Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (τ : ℂ)
            * (∑ δ ∈ N.divisors, (δ : ℂ) * (r δ : ℂ)) / 24)
        * ∏ δ ∈ N.divisors,
            (∏' n : ℕ, (1 - ModularForm.eta_q n ((δ : ℂ) * (τ : ℂ)))) ^ (r δ) :=
  fun N r τ => SocrateAI.ModularForms.etaQuotient_eq_qpow_mul N r τ

-- PIN 2 -- THE TAIL IS NON-ZERO at every point of `ℍ`, for an arbitrary integer exponent vector
-- (negative exponents included, which is why the power is a `zpow`).  Pointwise; no limit.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (τ : ℍ),
    (∏ δ ∈ N.divisors,
      (∏' n : ℕ, (1 - ModularForm.eta_q n ((δ : ℂ) * (τ : ℂ)))) ^ (r δ)) ≠ 0 :=
  fun N r τ => SocrateAI.ModularForms.etaQuotient_qProduct_ne_zero N r τ

-- PIN 3 -- THE BRIDGE, arithmetic ↔ analytic.  The exponent B11 produces from Mathlib's
-- `q`-product for `η` is the SAME rational number as the cusp-order formula transcribed from
-- Ligozat, evaluated at the cusp `∞` (denominator `d = N`).  The cusp order is spelled out to
-- its definition-level form on the right so that the pin fails if `etaQuotientCuspOrder` is ever
-- restated with a different normalisation.
example : ∀ (N : ℕ), N ≠ 0 → ∀ (r : ℕ → ℤ),
    (∑ δ ∈ N.divisors, (δ : ℂ) * (r δ : ℂ)) / 24
      = ((SocrateAI.ModularForms.etaQuotientCuspOrder N r N : ℚ) : ℂ) :=
  fun N hN r => SocrateAI.ModularForms.etaQuotient_qpow_exponent_eq_cuspOrder_infty N hN r

-- PIN 4 -- THE PACKAGED FORM, which is the sentence the node exists to license:
-- `f(τ) = q^{ord_∞(N,r)} · (a factor that is non-zero at every point of ℍ)`.  Both halves are
-- asserted together so that the split and the non-vanishing cannot drift apart.
example : ∀ (N : ℕ), N ≠ 0 → ∀ (r : ℕ → ℤ) (τ : ℍ),
    (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ))
        = Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (τ : ℂ)
              * ((SocrateAI.ModularForms.etaQuotientCuspOrder N r N : ℚ) : ℂ))
          * ∏ δ ∈ N.divisors,
              (∏' n : ℕ, (1 - ModularForm.eta_q n ((δ : ℂ) * (τ : ℂ)))) ^ (r δ)
      ∧ (∏ δ ∈ N.divisors,
          (∏' n : ℕ, (1 - ModularForm.eta_q n ((δ : ℂ) * (τ : ℂ)))) ^ (r δ)) ≠ 0 :=
  fun N hN r τ => ⟨SocrateAI.ModularForms.etaQuotient_eq_qpow_cuspOrder_mul N hN r τ,
    SocrateAI.ModularForms.etaQuotient_qProduct_ne_zero N r τ⟩

-- PIN 5 -- THE `Δ` CROSS-CHECK at `N = 1`, `r ≡ 24`.  Mathlib's `discriminant` splits as
-- `q · ∏' (1 - q^{n+1})^{24}`, i.e. the leading exponent is `1` — the classical `ord_∞(Δ) = 1`,
-- a number from the literature, not from our definition.  This is B11 instantiated against the
-- one eta quotient Mathlib names independently.
example : ∀ τ : ℍ, ModularForm.discriminant τ
    = Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (τ : ℂ) * ((1 : ℚ) : ℂ))
      * ∏ δ ∈ (1 : ℕ).divisors,
          (∏' n : ℕ, (1 - ModularForm.eta_q n ((δ : ℂ) * (τ : ℂ)))) ^ ((fun _ => (24 : ℤ)) δ) := by
  intro τ
  rw [← SocrateAI.ModularForms.etaQuotient_one_eq_discriminant τ,
    ← SocrateAI.ModularForms.etaQuotientCuspOrder_one_24]
  exact SocrateAI.ModularForms.etaQuotient_eq_qpow_cuspOrder_mul 1 one_ne_zero _ τ

end B11Pins


-- ---------------------------------------------------------------------------------------------
-- F3.1-B12 — THE TAIL TENDS TO `1`, so `ord_∞` is an ANALYTIC order and not just an exponent.
-- `∏_δ (∏' n, (1 - eta_q n (δτ)))^{r_δ} → 1` along `atImInfty`, for arbitrary `N` and arbitrary
-- integer `r` (no hypothesis on either).  Generalises Mathlib's
-- `ModularForm.tendsto_atImInfty_tprod_one_sub_eta_q_pow`, which is hard-wired to exponent `24`
-- and to no dilation, in BOTH directions at once: dilation `δτ` and `ℤ`-exponent of either sign.
-- With F3.1-B11 this gives `f(τ)/q^{ord_∞} → 1`, which is the caveat on B11 discharged.
-- ---------------------------------------------------------------------------------------------

/-- info: 'SocrateAI.ModularForms.qParam_one_natCast_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.qParam_one_natCast_mul

/-- info: 'SocrateAI.ModularForms.tendsto_tprod_one_sub_eta_q_natCast_mul' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.tendsto_tprod_one_sub_eta_q_natCast_mul

/-- info: 'SocrateAI.ModularForms.tendsto_etaQuotient_tprod_factor' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.tendsto_etaQuotient_tprod_factor

/-- info: 'SocrateAI.ModularForms.tendsto_etaQuotientH_div_qpow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.tendsto_etaQuotientH_div_qpow

-- STATEMENT PINS (LL-1) for F3.1-B12.  The limit is the whole content of the node, so the pins
-- are written with `Filter.Tendsto`, `UpperHalfPlane.atImInfty` and `nhds 1` spelled out, the
-- exponent vector as the bare `ℕ → ℤ`, and the dilation `(δ : ℂ) * τ` present inside `eta_q`.
section B12Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- THE NODE EXACTLY AS SCOPED, verbatim.  Arbitrary level, arbitrary integer exponent
-- vector, no hypothesis.  The dilation `(δ : ℂ) * τ` is inside `eta_q`; a version without it
-- would be a different (weaker) theorem.
example : ∀ (N : ℕ) (r : ℕ → ℤ),
    Filter.Tendsto
      (fun τ : ℍ => ∏ δ ∈ N.divisors,
        (∏' n : ℕ, (1 - ModularForm.eta_q n ((δ : ℂ) * (τ : ℂ)))) ^ (r δ))
      UpperHalfPlane.atImInfty (nhds 1) :=
  fun N r => SocrateAI.ModularForms.tendsto_etaQuotient_tprod_factor N r

-- PIN 2 -- THE ANALYTIC ORDER STATEMENT, with `etaQuotient` unfolded to the bare product of
-- `ModularForm.eta` values, so nothing hides behind our own abbreviation: the eta quotient
-- divided by `q^{ord_∞}` tends to `1`.  This is the sentence "`ord_∞(N, r)` is the vanishing
-- order of `∏_{δ ∣ N} η(δτ)^{r_δ}` at the cusp `∞`".
example : ∀ (N : ℕ), N ≠ 0 → ∀ (r : ℕ → ℤ),
    Filter.Tendsto
      (fun τ : ℍ => (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ))
        / Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (τ : ℂ)
            * ((SocrateAI.ModularForms.etaQuotientCuspOrder N r N : ℚ) : ℂ)))
      UpperHalfPlane.atImInfty (nhds 1) :=
  fun N hN r => SocrateAI.ModularForms.tendsto_etaQuotientH_div_qpow N hN r

-- PIN 3 -- THE MATHLIB CROSS-CHECK, and it runs in the strong direction: Mathlib's own
-- `tendsto_atImInfty_tprod_one_sub_eta_q_pow` (exponent `24`, no dilation) is REPROVED here from
-- our generalisation, using only `Multipliable.tprod_pow` to move the `24` across the `∏'`.  If
-- our limit were wrong, or normalised differently, this would not close.
example : Filter.Tendsto (fun τ : ℍ => ∏' n : ℕ, (1 - ModularForm.eta_q n (τ : ℂ)) ^ (24 : ℕ))
    UpperHalfPlane.atImInfty (nhds 1) := by
  have h := (SocrateAI.ModularForms.tendsto_tprod_one_sub_eta_q_natCast_mul
    (δ := 1) one_ne_zero).pow 24
  simp only [Nat.cast_one, one_mul, one_pow] at h
  exact h.congr fun τ =>
    ((ModularForm.multipliableLocallyUniformlyOn_eta.multipliable τ.2).tprod_pow 24).symm

-- PIN 4 -- THE `Δ` CROSS-CHECK against the literature.  At `N = 1`, `r ≡ 24` the packaged
-- corollary says `Δ(τ) / exp(2πiτ · 1) → 1`, i.e. `ord_∞(Δ) = 1` — the classical value, taken
-- from the literature and not from our definition.  Mathlib knows `Δ` is ZERO at `i∞`
-- (`discriminant_isZeroAtImInfty`); this says the rate is exactly `q^1`.
example : Filter.Tendsto
    (fun τ : ℍ => ModularForm.discriminant τ
      / Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (τ : ℂ) * ((1 : ℚ) : ℂ)))
    UpperHalfPlane.atImInfty (nhds 1) := by
  have h := SocrateAI.ModularForms.tendsto_etaQuotientH_div_qpow 1 one_ne_zero (fun _ => (24 : ℤ))
  rw [SocrateAI.ModularForms.etaQuotientCuspOrder_one_24] at h
  exact h.congr fun τ => by rw [SocrateAI.ModularForms.etaQuotientH_level_one_24]

end B12Pins


/-! ## F3.1-B13 — the analytic order of an eta quotient at the cusp `∞`

Ten guards, then the statement pins.  `meromorphicOrderAt` is Mathlib's own order of vanishing
(`Mathlib/Analysis/Meromorphic/Order.lean`), `UpperHalfPlane.cuspFunction 1` is Mathlib's own
width-`1` cusp function (`Mathlib/NumberTheory/ModularForms/QExpansion.lean`), and width `1` is
Mathlib's `strictWidthInfty_Gamma0`.  Nothing here is a SocrateAI notion of "order at a cusp";
that is the whole point of the node, and it is why the F3.1-OBSTRUCTED record in
`EtaQuotientCuspOrder.lean` had to retract half of the obstruction it was given. -/

/-- info: 'SocrateAI.ModularForms.etaQuotientTail' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientTail

/-- info: 'SocrateAI.ModularForms.etaQuotientTail_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientTail_zero

/-- info: 'SocrateAI.ModularForms.analyticAt_tprod_one_sub_pow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.analyticAt_tprod_one_sub_pow

/-- info: 'SocrateAI.ModularForms.analyticAt_etaQuotientTail' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.analyticAt_etaQuotientTail

/-- info: 'SocrateAI.ModularForms.etaQuotientH_eq_zpow_qParam_mul_tail' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_eq_zpow_qParam_mul_tail

/-- info: 'SocrateAI.ModularForms.cuspFunction_etaQuotientH' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.cuspFunction_etaQuotientH

/-- info: 'SocrateAI.ModularForms.meromorphicOrderAt_cuspFunction_etaQuotientH' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.meromorphicOrderAt_cuspFunction_etaQuotientH

/-- info: 'SocrateAI.ModularForms.meromorphicOrderAt_cuspFunction_eq_cuspOrder_infty' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.meromorphicOrderAt_cuspFunction_eq_cuspOrder_infty

/-- info: 'SocrateAI.ModularForms.exists_meromorphicOrderAt_cuspFunction_etaQuotientH' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exists_meromorphicOrderAt_cuspFunction_etaQuotientH

/-- info: 'SocrateAI.ModularForms.meromorphicOrderAt_cuspFunction_discriminant' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.meromorphicOrderAt_cuspFunction_discriminant

section B13Pins
open ModularForm UpperHalfPlane

-- PIN 1 -- THE NODE, with `etaQuotientH` unfolded to the bare product of `ModularForm.eta`
-- values and with Mathlib's `meromorphicOrderAt` and `cuspFunction` spelled out, so that nothing
-- hides behind a SocrateAI abbreviation.  Arbitrary level, arbitrary integer exponent vector,
-- arbitrary integer `m` with `24 m = Σ_δ δ r_δ`; no positivity and no holomorphy hypothesis.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (m : ℤ),
    (24 : ℤ) * m = ∑ δ ∈ N.divisors, (δ : ℤ) * r δ →
    meromorphicOrderAt (UpperHalfPlane.cuspFunction 1
        (fun τ : ℍ => ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ))) 0
      = (m : WithTop ℤ) :=
  fun N r m hm => SocrateAI.ModularForms.meromorphicOrderAt_cuspFunction_etaQuotientH N r m hm

-- PIN 2 -- THE SAME UNDER LIGOZAT'S FIRST CONGRUENCE, with `LigozatCongr1` unfolded to the bare
-- divisibility `24 ∣ Σ_δ δ r_δ`: the congruence produces an integer `m` which is BOTH the value
-- of the transcribed arithmetic expression `etaQuotientCuspOrder N r N` AND the analytic order.
example : ∀ (N : ℕ), N ≠ 0 → ∀ (r : ℕ → ℤ), (24 : ℤ) ∣ ∑ δ ∈ N.divisors, (δ : ℤ) * r δ →
    ∃ m : ℤ, SocrateAI.ModularForms.etaQuotientCuspOrder N r N = (m : ℚ) ∧
      meromorphicOrderAt (UpperHalfPlane.cuspFunction 1
          (fun τ : ℍ => ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (τ : ℂ)) ^ (r δ))) 0
        = (m : WithTop ℤ) :=
  fun N hN r h =>
    SocrateAI.ModularForms.exists_meromorphicOrderAt_cuspFunction_etaQuotientH N hN r h

-- PIN 3 -- THE LITERATURE CROSS-CHECK.  `ord_∞(Δ) = 1`, with `Δ` Mathlib's own
-- `ModularForm.discriminant` and the order Mathlib's own `meromorphicOrderAt`.  The value `1` is
-- the classical one; Mathlib states it independently as `discriminant_qExpansion_order` in
-- `LevelOne/DimensionFormula.lean`, a module outside this workspace's built cone.  A cusp-order
-- normalisation off by any factor fails here.
example : meromorphicOrderAt
    (UpperHalfPlane.cuspFunction 1 (ModularForm.discriminant : ℍ → ℂ)) 0 = (1 : ℤ) :=
  SocrateAI.ModularForms.meromorphicOrderAt_cuspFunction_discriminant

end B13Pins

-- F3.2-A9 -- THE MULTIPLIER AT AN ELLIPTIC FIXED POINT.  Where F3.2-A6 and F3.2-A8 evaluate the
-- character `w` of F3.2-A5 on `T` and on `V` at the cost of real analysis (the `q`-product and
-- Mathlib's `eta_comp_eq_csqrt_I_inv` respectively), this node evaluates `w` on every element
-- with a FIXED POINT in `H` at zero analytic cost: substitute the fixed point into A5's law and
-- cancel `f(tau_0)`, which is legal because eta quotients are nowhere zero on `H` (F3.1-B7).
--
-- READ THE SCOPE (LL-1).  The fixed point is a HYPOTHESIS.  This node does NOT prove that
-- torsion elements of `Gamma0 N` have fixed points in `H` -- the classical `|tr| < 2` argument
-- is not formalised here and is not used anywhere below.  What is proved is the conditional:
-- given a fixed point, the multiplier is FORCED to be the inverse automorphy factor there.
-- Nor does this close F3.2-OBSTRUCTED: elliptic elements do not generate `Gamma0 N` either, and
-- the `sorryAx` tripwire on `multiplier_trivial_of_congr` above is untouched.

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_of_fixed' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_of_fixed

/-- info: 'SocrateAI.ModularForms.etaQuotientH_elliptic_transform' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_elliptic_transform

/-- info: 'SocrateAI.ModularForms.multiplier_elliptic' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_elliptic

/-- info: 'SocrateAI.ModularForms.neg_one_mem_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.neg_one_mem_Gamma0

/-- info: 'SocrateAI.ModularForms.denom_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.denom_neg_one

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_neg_one

/-- info: 'SocrateAI.ModularForms.S_smul_I' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.S_smul_I

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eta_sq_S' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eta_sq_S

/-- info: 'SocrateAI.ModularForms.etaQuotientH_eta_sq_S_transform' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_eta_sq_S_transform

/-- info: 'SocrateAI.ModularForms.matE2_mem_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.matE2_mem_Gamma0

/-- info: 'SocrateAI.ModularForms.matE2_smul_tauE2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.matE2_smul_tauE2

/-- info: 'SocrateAI.ModularForms.denom_matE2_tauE2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.denom_matE2_tauE2

/-- info: 'SocrateAI.ModularForms.four_dvd_of_ligozat_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.four_dvd_of_ligozat_two

/-- info: 'SocrateAI.ModularForms.matV_two_mul_matE2_mul_T' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.matV_two_mul_matE2_mul_T

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_matE2_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_matE2_eq_one

-- STATEMENT PINS (LL-1).  The guards above certify the PROOFS; these certify the STATEMENTS.
section F32A9Pins
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix Complex
open scoped MatrixGroups Real

-- PIN 1 -- THE NODE, longhand.  The exponent vector the bare `N -> Z` rather than the `EtaExp`
-- abbreviation, the eta quotient written out as the product over `Nat.divisors` with
-- `ModularForm.eta` fully qualified, and BOTH automorphy factors written as `c*z + d` rather
-- than as `denom`.  The exponent on the fixed-point factor is `-k` and on the moving factor is
-- `+k`; if those two swapped, or if the fixed point and the moving point were exchanged, this
-- would not elaborate.  Note the fixed point is a HYPOTHESIS `gamma . tau_0 = tau_0`.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (k : ℤ), (∑ δ ∈ N.divisors, r δ) = 2 * k →
    ∀ γ : SL(2, ℤ), γ ∈ Gamma0 N → ∀ τ₀ : ℍ, γ • τ₀ = τ₀ → ∀ z : ℍ,
      (∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * ((γ • z : ℍ) : ℂ)) ^ (r δ))
        = ((γ 1 0 : ℂ) * (τ₀ : ℂ) + (γ 1 1 : ℂ)) ^ (-k)
          * ((γ 1 0 : ℂ) * (z : ℂ) + (γ 1 1 : ℂ)) ^ k
          * ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ) := by
  intro N r k hk γ hγ τ₀ hfix z
  have h := SocrateAI.ModularForms.etaQuotientH_elliptic_transform r hk hγ hfix z
  rw [ModularGroup.denom_apply, ModularGroup.denom_apply] at h
  exact h

-- PIN 2 -- THE SCOPED SIGNATURE, in the `Cx`-valued character of F3.2-A5 rather than in the
-- bare value `etaMultiplierVal`: `w e = (denom e tau_0)^(-k)` for `e` in the SUBGROUP `Gamma0 N`.
example : ∀ (N : ℕ+) (r : ℕ → ℤ) (k : ℤ) (hk : (∑ δ ∈ (N : ℕ).divisors, r δ) = 2 * k)
    (e : Gamma0 (N : ℕ)) (τ₀ : ℍ), (e : SL(2, ℤ)) • τ₀ = τ₀ →
    ((SocrateAI.ModularForms.etaMultiplierHom r hk e : ℂˣ) : ℂ)
      = (((e : SL(2, ℤ)) 1 0 : ℂ) * (τ₀ : ℂ) + ((e : SL(2, ℤ)) 1 1 : ℂ)) ^ (-k) := by
  intro N r k hk e τ₀ hfix
  have h := SocrateAI.ModularForms.multiplier_elliptic N.pos r hk e τ₀ hfix
  rw [ModularGroup.denom_apply] at h
  exact h

-- PIN 3 -- `-I` IS THE DEGENERATE CASE, and the one classical normalisation of the eta
-- multiplier that A9 hands over for free: `-I` fixes every point of `H`, so A9 applies with an
-- arbitrary `tau_0` and forces `w(-I) = (-1)^k`.  This is the value in the literature; a sign
-- error in A9 would make it `(-1)^{-k}`, which is the SAME number, so PIN 3 is a sanity check
-- and NOT the sign pin -- PIN 4 is.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (k : ℤ), (∑ δ ∈ N.divisors, r δ) = 2 * k →
    SocrateAI.ModularForms.etaMultiplierVal N r k (-1 : SL(2, ℤ)) = (-1 : ℂ) ^ k :=
  fun _N r _k hk => SocrateAI.ModularForms.etaMultiplierVal_neg_one r hk

-- PIN 4 -- THE SIGN PIN, and the reason this node is not merely internally consistent.  Every
-- weight-12 example (`Delta`) is blind to the sign of the exponent, because there the automorphy
-- factors are roots of unity raised to `+-12`.  So the pin runs at weight `k = 1`: `N = 1`,
-- `r = 2`, i.e. `f = eta^2`, where `S` fixes `i`, `denom S i = i`, and A9 gives `w(S) = i^{-1}`.
-- The two sides of the sign differ: `i^{-1} = -i` and `i^{+1} = +i`.
example : SocrateAI.ModularForms.etaMultiplierVal 1 (fun _ => (2 : ℤ)) 1 ModularGroup.S
    = -Complex.I :=
  SocrateAI.ModularForms.etaMultiplierVal_eta_sq_S

-- ...and the SAME number derived independently through F3.2-A7 (`etaQuotient_fricke`), whose
-- only analytic input is MATHLIB's `eta_comp_eq_csqrt_I_inv`.  The two derivations share nothing
-- but the definition of the multiplier.  If A9 carried `^{+k}`, the first would give `+i`, the
-- second `-i`, and they could not both compile.
example : ∀ z : ℍ,
    (ModularForm.eta ((1 : ℂ) * ((ModularGroup.S • z : ℍ) : ℂ)) ^ (2 : ℤ))
      = (-Complex.I) * (z : ℂ) * (ModularForm.eta ((1 : ℂ) * (z : ℂ)) ^ (2 : ℤ)) := by
  intro z
  have h := SocrateAI.ModularForms.etaQuotientH_eta_sq_S_transform z
  rw [SocrateAI.ModularForms.etaQuotientH_apply,
    SocrateAI.ModularForms.etaQuotientH_apply] at h
  simpa [Nat.divisors_one] using h

-- PIN 5 -- THE ELLIPTIC POINT OF `Gamma0 2`, two independent derivations of `w(E)`.  `E` is
-- written as a raw 2x2 integer matrix and `tau_0` as a raw complex number, so no SocrateAI
-- definition can be hiding a different element or a different point.
example : ((SocrateAI.ModularForms.matE2 : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ)
    = !![1, -1; 2, -1] :=
  SocrateAI.ModularForms.matE2_coe

example : ((SocrateAI.ModularForms.tauE2 : ℍ) : ℂ) = (1 + Complex.I) / 2 :=
  SocrateAI.ModularForms.coe_tauE2

example : SocrateAI.ModularForms.matE2 ∈ Gamma0 2 :=
  SocrateAI.ModularForms.matE2_mem_Gamma0

example : SocrateAI.ModularForms.matE2 • SocrateAI.ModularForms.tauE2
    = SocrateAI.ModularForms.tauE2 :=
  SocrateAI.ModularForms.matE2_smul_tauE2

-- ROUTE A: through the fixed point `(1+i)/2`, where `denom E tau_0 = i`, plus the ARITHMETIC
-- consequence of Ligozat's two congruences at `N = 2` -- adding them gives
-- `sum_delta (delta + 2/delta) r_delta = 3 sum r_delta = 6k`, so `24 | 6k` and `4 | k`, whence
-- `i^{-k} = 1`.  Both congruences are written as raw divisibilities.
example : ∀ (r : ℕ → ℤ) (k : ℤ), (∑ δ ∈ (2 : ℕ).divisors, r δ) = 2 * k →
    (24 : ℤ) ∣ (∑ δ ∈ (2 : ℕ).divisors, (δ : ℤ) * r δ) →
    (24 : ℤ) ∣ (∑ δ ∈ (2 : ℕ).divisors, ((2 / δ : ℕ) : ℤ) * r δ) →
    SocrateAI.ModularForms.etaMultiplierVal 2 r k SocrateAI.ModularForms.matE2 = 1 :=
  fun _r _k hk h1 h2 => SocrateAI.ModularForms.etaMultiplierVal_matE2_eq_one hk h1 h2

-- ROUTE B: the same value, derived instead from F3.2-A6 (`w(T) = 1`, congruence (i)) and
-- F3.2-A8 (`w(V) = 1`, congruence (ii)) through the group identity `V * E * T = 1`, checked
-- entrywise.  This is a genuine cross-check and not a tautology -- route A runs through the
-- fixed point and the arithmetic of the congruences, route B through the multiplicative
-- structure of the character.  It is also the honest reason `Gamma0 2` is not new territory:
-- `E` lies in the subgroup generated by `T` and `V`, which is exactly why it can be checked.
example : SocrateAI.ModularForms.matV 2 * SocrateAI.ModularForms.matE2 * ModularGroup.T = 1 :=
  SocrateAI.ModularForms.matV_two_mul_matE2_mul_T

example : ∀ (r : ℕ → ℤ) (k : ℤ), (∑ δ ∈ (2 : ℕ).divisors, r δ) = 2 * k →
    SocrateAI.ModularForms.LigozatCongr1 2 r → SocrateAI.ModularForms.LigozatCongr2 2 r →
    SocrateAI.ModularForms.etaMultiplierVal 2 r k SocrateAI.ModularForms.matE2 = 1 := by
  intro r k hk h1 h2
  have hT : SocrateAI.ModularForms.etaMultiplierVal 2 r k ModularGroup.T = 1 :=
    SocrateAI.ModularForms.etaMultiplierVal_T_eq_one r hk h1
  have hV : SocrateAI.ModularForms.etaMultiplierVal 2 r k (SocrateAI.ModularForms.matV 2) = 1 :=
    SocrateAI.ModularForms.etaMultiplierVal_V_eq_one (by norm_num) r hk h2
  have hmul₁ := SocrateAI.ModularForms.etaMultiplierVal_mul r hk
    (mul_mem (SocrateAI.ModularForms.matV_mem_Gamma0 2)
      SocrateAI.ModularForms.matE2_mem_Gamma0)
    (SocrateAI.ModularForms.T_mem_Gamma0 2)
  have hmul₂ := SocrateAI.ModularForms.etaMultiplierVal_mul r hk
    (SocrateAI.ModularForms.matV_mem_Gamma0 2) SocrateAI.ModularForms.matE2_mem_Gamma0
  rw [SocrateAI.ModularForms.matV_two_mul_matE2_mul_T,
    SocrateAI.ModularForms.etaMultiplierVal_one, hmul₂, hV, hT] at hmul₁
  simpa using hmul₁.symm

-- PIN 6 -- NON-VACUITY OF THE FIXED-POINT HYPOTHESIS, in the negative direction: `T` has NO
-- fixed point in `H` (`T . z = z + 1`), so A9 says nothing about `T` and cannot be mistaken for
-- a proof of F3.2-A6.  This is the honest boundary of the node.
example : ∀ z : ℍ, ModularGroup.T • z ≠ z := by
  intro z h
  rw [UpperHalfPlane.modular_T_smul] at h
  have := congrArg (fun w : ℍ => (w : ℂ)) h
  simp only [UpperHalfPlane.coe_vadd, Complex.ofReal_one] at this
  have h1 : (1 : ℂ) = 0 := by linear_combination this
  norm_num at h1

end F32A9Pins

-- ===================================================================================
-- F3.2-B1 -- generators of `Gamma0 N` for `N <= 4`.
-- ===================================================================================

/-- info: 'SocrateAI.ModularForms.exists_balanced_add' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exists_balanced_add

/-- info: 'SocrateAI.ModularForms.sl_det_entries' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.sl_det_entries

/-- info: 'SocrateAI.ModularForms.matV_eq_conj' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.matV_eq_conj

/-- info: 'SocrateAI.ModularForms.matV_zpow_coe' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.matV_zpow_coe

/-- info: 'SocrateAI.ModularForms.T_zpow_mul_zero_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.T_zpow_mul_zero_zero

/-- info: 'SocrateAI.ModularForms.matV_zpow_mul_one_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.matV_zpow_mul_one_zero

/-- info: 'SocrateAI.ModularForms.S_mul_one_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.S_mul_one_zero

/-- info: 'SocrateAI.ModularForms.closure_gamma0Gens_le' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.closure_gamma0Gens_le

/-- info: 'SocrateAI.ModularForms.T_mul_matV_one_mul_T' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.T_mul_matV_one_mul_T

/-- info: 'SocrateAI.ModularForms.S_mem_closure_gens_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.S_mem_closure_gens_one

/-- info: 'SocrateAI.ModularForms.gamma0_descent' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gamma0_descent

/-- info: 'SocrateAI.ModularForms.mem_closure_gamma0Gens_aux' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.mem_closure_gamma0Gens_aux

/-- info: 'SocrateAI.ModularForms.Gamma0_generated_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.Gamma0_generated_of_le_four

/-- info: 'SocrateAI.ModularForms.Gamma0_generated_of_le_four_pnat' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.Gamma0_generated_of_le_four_pnat

/-- info: 'SocrateAI.ModularForms.gamma0Gens_one_top' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gamma0Gens_one_top

/-- info: 'SocrateAI.ModularForms.S_not_mem_closure_gens_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.S_not_mem_closure_gens_two

/-- info: 'SocrateAI.ModularForms.closure_gamma0Gens_two_ne_top' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.closure_gamma0Gens_two_ne_top

/-- info: 'SocrateAI.ModularForms.descent_bound_fails_at_five' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.descent_bound_fails_at_five

/-- info: 'SocrateAI.ModularForms.testGamma0Four_mem_closure' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.testGamma0Four_mem_closure

-- STATEMENT PINS (LL-1) for F3.2-B1.  The guards above certify the PROOF; these certify the
-- STATEMENT.  PIN 1-3: the three generators are the matrices the node names, entry by entry.
-- PIN 4: the target is `Gamma0 N` written as the RAW divisibility condition `N | c`, not as the
-- `Gamma0` abbreviation, and the equality of subgroups is unfolded to membership.
section F32B1Pin
open CongruenceSubgroup Matrix
open scoped MatrixGroups

-- PIN 1 -- the first generator is `-I`.
example : ((-1 : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ) = !![-1, 0; 0, -1] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp

-- PIN 2 -- the second generator is `T = !![1,1;0,1]` (NOT its transpose).
example : ((ModularGroup.T : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ) = !![1, 1; 0, 1] := rfl

-- PIN 3 -- the third generator is `V = !![1,0;-N,1]`; the sign on `N` is part of the claim.
example (N : ℕ) :
    ((SocrateAI.ModularForms.matV N : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ)
      = !![1, 0; -(N : ℤ), 1] := rfl

-- PIN 4 -- THE NODE, longhand: for `1 <= N <= 4` an element of `SL(2,Z)` is a word in
-- `-I`, `T`, `V` if and only if `N` divides its lower-left entry.
example : ∀ N : ℕ, 0 < N → N ≤ 4 → ∀ g : SL(2, ℤ),
    g ∈ Subgroup.closure
        {(-1 : SL(2, ℤ)), ModularGroup.T, SocrateAI.ModularForms.matV N}
      ↔ (N : ℤ) ∣ g 1 0 := by
  intro N hN hN4 g
  haveI : NeZero N := ⟨hN.ne'⟩
  rw [SocrateAI.ModularForms.Gamma0_generated_of_le_four hN hN4, Gamma0_mem,
    ZMod.intCast_zmod_eq_zero_iff_dvd]

end F32B1Pin


-- ---------------------------------------------------------------------------------------------
-- F3.2-B2 -- FULL LIGOZAT FOR `N <= 4`.  Every declaration of the node, guarded.
--
-- WHAT THE NODE PROVES, IN ENGLISH (LL-1).  Let `f(z) = prod_{delta | N} eta(delta z)^{r_delta}`
-- with `sum_delta r_delta = 2k`, `k` an INTEGER.  F3.2-A5 produced a character
-- `w : Gamma0 N ->* Cx` with `f(gamma z) = w(gamma) (cz+d)^k f(z)` -- for every `N`, with no
-- congruence conditions, and WITHOUT evaluating `w`.  This node evaluates it for `N <= 4`:
-- Ligozat (i) gives `w T = 1` (A6), Ligozat (ii) gives `w V = 1` (A8), `w (-I) = (-1)^k` is
-- unconditional (A9), and `<-I, T, V> = Gamma0 N` for `N <= 4` (B1).  A homomorphism is
-- determined by its values on a generating set, so `w` is THE UNIQUE homomorphism with those
-- three values -- `ligozat_of_le_four`.  For EVEN `k` that character is trivial, and with
-- Ligozat (iii) supplied in Mathlib's own `IsBoundedAtImInfty` form the eta quotient becomes a
-- term of Mathlib's `ModularForm (Gamma0 N) k` -- `etaQuotientModularForm`.
--
-- WHAT IT DOES NOT PROVE.  Nothing at `N >= 5`.  `descent_bound_fails_at_five` records where
-- B1's descent breaks, and for general `N` the reduction to three generators is FALSE.  The
-- Dedekind-sum obstruction is not overcome; it is AVOIDED, for four levels, by replacing
-- evaluation with generation.
--
-- THE STATEMENT CORRECTION THIS NODE CARRIES.  `f(gamma z) = (cz+d)^k f(z)` on all of
-- `Gamma0 N` requires `Even k`: `-I` acts trivially on `H` while `denom (-I) z = -1`.
-- `not_multiplier_trivial_odd` is the counterexample (`N = 3`, `r_1 = -3`, `r_3 = 9`, `k = 3`;
-- both Ligozat congruences hold, `N <= 4` so generation is a theorem, and the conclusion
-- fails).  Classically this is the nebentypus: `eta(z)^-3 eta(3z)^9` is weight 3 on `Gamma0(3)`
-- WITH the quadratic character.

/-- info: 'SocrateAI.ModularForms.gamma0GensSub' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gamma0GensSub

/-- info: 'SocrateAI.ModularForms.image_gamma0GensSub' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.image_gamma0GensSub

/-- info: 'SocrateAI.ModularForms.gamma0Gens_eq_perm' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gamma0Gens_eq_perm

/-- info: 'SocrateAI.ModularForms.closure_gamma0Gens_eq_of_hgen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.closure_gamma0Gens_eq_of_hgen

/-- info: 'SocrateAI.ModularForms.closure_gamma0GensSub_eq_top_of_gen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.closure_gamma0GensSub_eq_top_of_gen

/-- info: 'SocrateAI.ModularForms.closure_gamma0GensSub_eq_top' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.closure_gamma0GensSub_eq_top

/-- info: 'SocrateAI.ModularForms.hom_ext_of_gen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.hom_ext_of_gen

/-- info: 'SocrateAI.ModularForms.hom_ext_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.hom_ext_of_le_four

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom_neg_one

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_of_gen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom_eq_of_gen

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom_eq_of_le_four

/-- info: 'SocrateAI.ModularForms.ligozat_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_of_le_four

/-- info: 'SocrateAI.ModularForms.ligozat_of_le_four_pnat' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_of_le_four_pnat

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_one_of_gen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom_eq_one_of_gen

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_one_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom_eq_one_of_le_four

/-- info: 'SocrateAI.ModularForms.etaQuotientH_transform_of_gen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_transform_of_gen

/-- info: 'SocrateAI.ModularForms.etaQuotientH_transform_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_transform_of_le_four

/-- info: 'SocrateAI.ModularForms.etaQuotientH_slash_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_slash_of_le_four

/-- info: 'SocrateAI.ModularForms.mdiff_etaQuotientH' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.mdiff_etaQuotientH

/-- info: 'SocrateAI.ModularForms.Gamma0_map_le_SL' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.Gamma0_map_le_SL

/-- info: 'SocrateAI.ModularForms.isBoundedAt_of_bdd_SL2Z' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.isBoundedAt_of_bdd_SL2Z

/-- info: 'SocrateAI.ModularForms.etaQuotientModularForm' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientModularForm

/-- info: 'SocrateAI.ModularForms.etaQuotientModularForm_apply' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientModularForm_apply

/-- info: 'SocrateAI.ModularForms.ligozat_level_one_24_guard' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_level_one_24_guard

/-- info: 'SocrateAI.ModularForms.ligozatOddExp_sum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatOddExp_sum

/-- info: 'SocrateAI.ModularForms.ligozatOddExp_congr1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatOddExp_congr1

/-- info: 'SocrateAI.ModularForms.ligozatOddExp_congr2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatOddExp_congr2

/-- info: 'SocrateAI.ModularForms.ligozatOdd_hgen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatOdd_hgen

/--
info: 'SocrateAI.ModularForms.etaMultiplierVal_ligozatOddExp_neg_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
-/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_ligozatOddExp_neg_one

/-- info: 'SocrateAI.ModularForms.not_multiplier_trivial_odd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.not_multiplier_trivial_odd

/-- info: 'SocrateAI.ModularForms.ligozatOddExp' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatOddExp

-- STATEMENT PINS (LL-1) for F3.2-B2.  The guards above certify the PROOFS; these certify the
-- STATEMENTS.
section F32B2Pin
open CongruenceSubgroup Matrix SocrateAI.ModularForms
open scoped MatrixGroups ModularForm

-- PIN 1 -- the odd-weight counterexample really is an exponent vector satisfying BOTH of
-- Ligozat's congruences with an ODD `k`.  Written longhand, not through the predicates.
example : (∑ δ ∈ (3 : ℕ).divisors, ligozatOddExp δ) = 2 * 3 := ligozatOddExp_sum
example : (24 : ℤ) ∣ ∑ δ ∈ (3 : ℕ).divisors, (δ : ℤ) * ligozatOddExp δ := ligozatOddExp_congr1
example : (24 : ℤ) ∣ ∑ δ ∈ (3 : ℕ).divisors, ((3 / δ : ℕ) : ℤ) * ligozatOddExp δ :=
  ligozatOddExp_congr2
example : ¬ Even (3 : ℤ) := by decide

-- PIN 2 -- the packaged object really is Mathlib's `ModularForm`, at the image of `Gamma0 N`
-- in `GL(2,R)`, and its underlying function really is the eta quotient.
example {N : ℕ} (hN : 0 < N) (hN4 : N ≤ 4) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    (hke : Even k)
    (hbd : ∀ γ : SL(2, ℤ),
      UpperHalfPlane.IsBoundedAtImInfty ((etaQuotientH N r) ∣[k] γ)) (z : UpperHalfPlane) :
    etaQuotientModularForm hN hN4 r hk h1 h2 hke hbd z
      = ∏ δ ∈ N.divisors, ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ) := rfl

end F32B2Pin

/-! #### F3.2-B3 — the multiplier IS Ligozat's Kronecker character (`N ≤ 4`)

All declarations of the `F3.2-B3` block, with their axiom footprints.  Every one is
`[propext, Classical.choice, Quot.sound]` — no `sorryAx`. -/

/-- info: 'SocrateAI.ModularForms.isSquare_neg_three_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.isSquare_neg_three_iff

/-- info: 'SocrateAI.ModularForms.kroneckerPrime' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerPrime

/-- info: 'SocrateAI.ModularForms.kroneckerSym' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym

/-- info: 'SocrateAI.ModularForms.kroneckerPrime_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerPrime_mul

/-- info: 'SocrateAI.ModularForms.kroneckerPrime_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerPrime_ne_zero

/-- info: 'SocrateAI.ModularForms.kroneckerSym_one_left' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_one_left

/-- info: 'SocrateAI.ModularForms.kroneckerSym_mul_left' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_mul_left

/-- info: 'SocrateAI.ModularForms.kroneckerSym_sq_of_gcd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_sq_of_gcd

/-- info: 'SocrateAI.ModularForms.kroneckerSym_eq_mulChar' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_eq_mulChar

/-- info: 'SocrateAI.ModularForms.legendreSym_neg_three' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.legendreSym_neg_three

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_one

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_three' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_three

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_four

/-- info: 'SocrateAI.ModularForms.charGamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.charGamma0

/-- info: 'SocrateAI.ModularForms.charGamma0_apply' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.charGamma0_apply

/-- info: 'SocrateAI.ModularForms.multiplier_eq_intChar_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_eq_intChar_of_le_four

/-- info: 'SocrateAI.ModularForms.ligozatKroneckerNum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatKroneckerNum

/-- info: 'SocrateAI.ModularForms.gamma0_not_dvd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gamma0_not_dvd

/-- info: 'SocrateAI.ModularForms.gamma0_gcd_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gamma0_gcd_eq_one

/-- info: 'SocrateAI.ModularForms.gcd_pow_of_not_dvd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gcd_pow_of_not_dvd

/-- info: 'SocrateAI.ModularForms.isUnit_gamma0_entry' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.isUnit_gamma0_entry

/-- info: 'SocrateAI.ModularForms.multiplier_eq_kronecker_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_eq_kronecker_one

/-- info: 'SocrateAI.ModularForms.multiplier_eq_kronecker_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_eq_kronecker_two

/-- info: 'SocrateAI.ModularForms.multiplier_eq_kronecker_three' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_eq_kronecker_three

/-- info: 'SocrateAI.ModularForms.multiplier_eq_kronecker_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_eq_kronecker_four

/-- info: 'SocrateAI.ModularForms.multiplier_eq_kronecker_of_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_eq_kronecker_of_le_four

/-- info: 'SocrateAI.ModularForms.kroneckerSym_trichotomy' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_trichotomy

/-- info: 'SocrateAI.ModularForms.kroneckerSym_ne_zero_of_gcd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_ne_zero_of_gcd

/-- info: 'SocrateAI.ModularForms.kroneckerSym_pow_left' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_pow_left

/-- info: 'SocrateAI.ModularForms.kroneckerSym_prod_left' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_prod_left

/-- info: 'SocrateAI.ModularForms.zpow_eq_pow_natAbs' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.zpow_eq_pow_natAbs

/-- info: 'SocrateAI.ModularForms.kroneckerSym_ligozat_eq_prod' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_ligozat_eq_prod

/--
info: 'SocrateAI.ModularForms.multiplier_eq_ligozat_character_of_le_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
-/
#guard_msgs in #print axioms SocrateAI.ModularForms.multiplier_eq_ligozat_character_of_le_four

/-- info: 'SocrateAI.ModularForms.ligozatFourFive' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatFourFive

/-- info: 'SocrateAI.ModularForms.ligozatFourFive_sum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatFourFive_sum

/-- info: 'SocrateAI.ModularForms.ligozatFourFive_congr1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatFourFive_congr1

/-- info: 'SocrateAI.ModularForms.ligozatFourFive_congr2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatFourFive_congr2

/-- info: 'SocrateAI.ModularForms.ligozatFourFive_num' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatFourFive_num

/-- info: 'SocrateAI.ModularForms.ligozat_level_four_weight_five' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_level_four_weight_five

/-- info: 'SocrateAI.ModularForms.ligozatOddExp_num' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatOddExp_num

/-- info: 'SocrateAI.ModularForms.ligozat_level_three_weight_three' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_level_three_weight_three

/--
info: 'SocrateAI.ModularForms.ligozat_kronecker_transform_of_le_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
-/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_kronecker_transform_of_le_four

-- STATEMENT PINS (LL-1) for F3.2-B3.  The guards above certify the PROOFS; these certify that
-- the object called `kroneckerSym` really is the Kronecker symbol of the literature, and that
-- the characters produced for the two worked examples are the ones the literature attaches to
-- them.
section F32B3Pin
open CongruenceSubgroup Matrix SocrateAI.ModularForms
open scoped MatrixGroups

-- PIN 1 -- at `p = 2` the local symbol is Kronecker's `χ₈`, NOT the Legendre symbol mod 2 that
-- `jacobiSym` would use there.  (`jacobiSym (-3) 2 = 1`; the Kronecker value is `-1`, PIN 3.)
example (a : ℤ) : kroneckerPrime a 2 = ZMod.χ₈ (a : ZMod 8) := rfl

-- PIN 2 -- at an odd prime it IS Mathlib's Legendre symbol, definitionally.
section
private instance factFive : Fact (Nat.Prime 5) := ⟨by decide⟩
example (a : ℤ) : kroneckerPrime a 5 = legendreSym 5 a := rfl
end

-- PIN 3 -- the classical table of `(-3/·)`, including the two denominators that a Jacobi symbol
-- cannot see: `d = -1` (the sign convention) and `d = 2` (the `χ₈` convention).  `(-3/d)` is the
-- quadratic character mod `3`: `+1` at `d ≡ 1`, `-1` at `d ≡ 2 (mod 3)`.
example : kroneckerSym (-3) (-1) = -1 := by rw [kroneckerSym_neg_three (by decide)]; decide
example : kroneckerSym (-3) 2 = -1 := by rw [kroneckerSym_neg_three (by decide)]; decide
example : kroneckerSym (-3) 5 = -1 := by rw [kroneckerSym_neg_three (by decide)]; decide
example : kroneckerSym (-3) 7 = 1 := by rw [kroneckerSym_neg_three (by decide)]; decide

-- PIN 4 -- the classical table of `(-4/·) = χ₄`, the character of the level-4 weight-5 example.
example : kroneckerSym (-4) (-1) = -1 := by rw [kroneckerSym_neg_four (by decide)]; decide
example : kroneckerSym (-4) 3 = -1 := by rw [kroneckerSym_neg_four (by decide)]; decide
example : kroneckerSym (-4) 5 = 1 := by rw [kroneckerSym_neg_four (by decide)]; decide

-- PIN 5 -- the two validation exponent vectors really satisfy Ligozat's hypotheses, longhand.
example : (∑ δ ∈ (4 : ℕ).divisors, ligozatFourFive δ) = 2 * 5 := ligozatFourFive_sum
example : (24 : ℤ) ∣ ∑ δ ∈ (4 : ℕ).divisors, (δ : ℤ) * ligozatFourFive δ := ligozatFourFive_congr1
example : (24 : ℤ) ∣ ∑ δ ∈ (4 : ℕ).divisors, ((4 / δ : ℕ) : ℤ) * ligozatFourFive δ :=
  ligozatFourFive_congr2
example : ligozatFourFive 1 = 4 ∧ ligozatFourFive 2 = 2 ∧ ligozatFourFive 4 = 4 := by decide
example : ¬ Even (5 : ℤ) := by decide

-- PIN 6 -- the numerators of the two examples, longhand: `(-1)^5·1^4·2^2·4^4 = -1024` and
-- `(-1)^3·1^{|-3|}·3^9 = -19683`.  The second one has a NEGATIVE exponent.
example : ligozatKroneckerNum 4 ligozatFourFive 5 = -1024 := ligozatFourFive_num
example : ligozatKroneckerNum 3 ligozatOddExp 3 = -19683 := ligozatOddExp_num
example : (-1024 : ℤ) = (-4) * 16 ^ 2 := by norm_num
example : (-19683 : ℤ) = (-3) * 81 ^ 2 := by norm_num

end F32B3Pin

-- ###########################################################################################
-- F3.2-C1 -- THE MODULUS OF THE ETA TRANSFORMATION ON ALL OF SL(2,Z).
--
-- WHAT IS CERTIFIED, in English, so the Lean cannot be misread (LL-1):
--   for EVERY gamma in SL(2,Z) and EVERY z in the upper half-plane,
--       |eta(gamma . z)| = sqrt(|c z + d|) * |eta(z)|.
-- This is the eta transformation law with the multiplier removed by taking absolute values.
-- The multiplier itself -- the 24th root of unity whose classical closed form needs DEDEKIND
-- SUMS, which Mathlib does not have -- has modulus 1, so it is invisible to the norm; and the
-- two branches of the square root (c z + d)^{1/2} differ by a sign, which the norm also kills.
--
-- WHAT IS **NOT** CERTIFIED.  This says nothing about eta(gamma . z) as a complex number.  The
-- phase is exactly the discarded information, and recovering it for a general gamma in
-- Gamma0(N) remains F3.2-OBSTRUCTED.  Read the statement as a fact about a nonnegative real.
--
-- WHERE THE CONTENT COMES FROM.  Not from an induction over the generators S and T: raising to
-- the 24th power removes the multiplier BEFORE any norm is taken, since eta^24 = Delta is
-- Mathlib's `ModularForm.discriminant`, modular of weight 12 for the FULL modular group
-- (`CuspForm.discriminant`).  `eta_pow24_natScale_smul` (F3.2-A4) at delta = 1 is verbatim
-- eta(gamma z)^24 = (cz+d)^12 eta(z)^24; norms, `Real.sq_sqrt` and `pow_left_inj₀` finish.

/-- info: 'SocrateAI.ModularForms.abs_eta_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.abs_eta_smul

/-- info: 'SocrateAI.ModularForms.norm_etaMultiplierVal' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.norm_etaMultiplierVal

/-- info: 'SocrateAI.ModularForms.norm_etaQuotientH_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.norm_etaQuotientH_smul

/-- info: 'SocrateAI.ModularForms.norm_eta_add_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.norm_eta_add_one

/-- info: 'SocrateAI.ModularForms.norm_eta_T_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.norm_eta_T_smul

/-- info: 'SocrateAI.ModularForms.abs_eta_smul_T_guard' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.abs_eta_smul_T_guard

-- STATEMENT PINS (LL-1) for F3.2-C1.
section F32C1Pin
open CongruenceSubgroup Matrix SocrateAI.ModularForms UpperHalfPlane
open scoped MatrixGroups

-- PIN 1 -- `denom` is the automorphy denominator `c z + d` and nothing else, longhand.
example (γ : SL(2, ℤ)) (z : ℍ) :
    denom (γ : GL (Fin 2) ℝ) (z : ℂ)
      = ((γ : GL (Fin 2) ℝ) 1 0 : ℂ) * (z : ℂ) + ((γ : GL (Fin 2) ℝ) 1 1 : ℂ) := rfl

-- PIN 2 -- the EXPONENT of the automorphy factor is one HALF, pinned by squaring.  A drift to
-- `‖denom‖^1` or `‖denom‖^{1/4}` in `abs_eta_smul` breaks this line.
example (γ : SL(2, ℤ)) (z : ℍ) :
    ‖ModularForm.eta ((γ • z : ℍ) : ℂ)‖ ^ 2
      = ‖denom (γ : GL (Fin 2) ℝ) (z : ℂ)‖ * ‖ModularForm.eta (z : ℂ)‖ ^ 2 := by
  rw [abs_eta_smul, mul_pow, Real.sq_sqrt (norm_nonneg _)]

-- PIN 3 -- the S-instance in classical coordinates: `|η(-1/z)| = √|z| · |η(z)|`.  This is the
-- modulus of Mathlib's `eta_comp_eq_csqrt_I_inv`, recovered without touching `Complex.sqrt`.
example (z : ℍ) :
    ‖ModularForm.eta (-(1 / (z : ℂ)))‖
      = Real.sqrt ‖(z : ℂ)‖ * ‖ModularForm.eta (z : ℂ)‖ := by
  have hdS : denom (ModularGroup.S : GL (Fin 2) ℝ) (z : ℂ) = (z : ℂ) := by
    rw [ModularGroup.denom_apply]; simp [ModularGroup.coe_S]
  have hcoe : ((ModularGroup.S • z : ℍ) : ℂ) = -(1 / (z : ℂ)) := by
    rw [UpperHalfPlane.modular_S_smul, UpperHalfPlane.coe_mk, one_div, inv_neg]
  have h := abs_eta_smul ModularGroup.S z
  rwa [hcoe, hdS] at h

-- PIN 4 -- the T-instance is the LL-1 cross-check itself: the Δ-route value equals the
-- q-product-route value.  Nothing in `abs_eta_smul`'s proof passes through `eta_add_one`.
example (z : ℍ) :
    ‖ModularForm.eta ((ModularGroup.T • z : ℍ) : ℂ)‖ = ‖ModularForm.eta ((z : ℂ) + 1)‖ :=
  abs_eta_smul_T_guard z

-- PIN 5 -- the eta-quotient corollary really carries the FULL integer weight `k`, not `k/2`:
-- at `N = 1`, `r ≡ 24`, `k = 12` it must read `‖denom‖^12`.
example (γ : SL(2, ℤ)) (z : ℍ) :
    ‖etaQuotientH 1 (fun _ => (24 : ℤ)) (γ • z)‖
      = ‖denom (γ : GL (Fin 2) ℝ) (z : ℂ)‖ ^ (12 : ℤ)
        * ‖etaQuotientH 1 (fun _ => (24 : ℤ)) z‖ :=
  norm_etaQuotientH_smul _ sum_divisors_one_24 (mem_Gamma0_one γ) z

end F32C1Pin


-- ===================================================================================
-- F3.2-C2 -- LIGOZAT'S CUSP-ORDER FORMULA AS A Θ-ASYMPTOTIC, AT EVERY CUSP.
--
-- HEADLINE: `etaQuotient_cusp_order`.  For every level `N`, every integer exponent vector `r`
-- with even weight-sum `Σ r_δ = 2k`, and EVERY `γ ∈ SL(2,ℤ)`,
--
--     ‖(f ∣[k] γ)(z)‖  =Θ[atImInfty]  exp(-2π · ordRaw(N,r,c) · Im z),   c = γ 1 0,
--     ordRaw(N,r,c) = (1/24) Σ_{δ ∣ N} gcd(c,δ)² r_δ / δ.
--
-- READ PIN 3 BELOW BEFORE CITING.  The exponent is Ligozat's cusp order DIVIDED BY the cusp
-- width `h = N / gcd(d², N)`; the node was scoped without that division, and the scoped form is
-- false.  `etaQuotientCuspOrder_eq_width_mul_raw` is the bridge, and PIN 3 exhibits a level-2
-- example where the two numbers genuinely differ.
-- ===================================================================================

/-- info: 'SocrateAI.ModularForms.etaQuotientRawOrder' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientRawOrder

/-- info: 'SocrateAI.ModularForms.gcd_sq_eq_mul' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gcd_sq_eq_mul

/-- info: 'SocrateAI.ModularForms.etaQuotientCuspOrder_eq_width_mul_raw' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientCuspOrder_eq_width_mul_raw

/-- info: 'SocrateAI.ModularForms.etaQuotientRawOrder_nonneg_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientRawOrder_nonneg_iff

/-- info: 'SocrateAI.ModularForms.etaQuotientRawOrder_infty' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientRawOrder_infty

/-- info: 'SocrateAI.ModularForms.etaQuotientRawOrder_one_24' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientRawOrder_one_24

/-- info: 'SocrateAI.ModularForms.rawOrder_level_two_twelve_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.rawOrder_level_two_twelve_pin

-- The Hermite / Smith normal form of `δ·γ` (the arithmetic engine of the node).
/-- info: 'SocrateAI.ModularForms.Smith.bezout_raw' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.Smith.bezout_raw

/-- info: 'SocrateAI.ModularForms.Smith.denom_gam_hpt' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.Smith.denom_gam_hpt

/-- info: 'SocrateAI.ModularForms.Smith.coe_gam_smul_hpt' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.Smith.coe_gam_smul_hpt

/-- info: 'SocrateAI.ModularForms.Smith.A_div_D_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.Smith.A_div_D_eq

/-- info: 'SocrateAI.ModularForms.Smith.norm_eta_natMul_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.Smith.norm_eta_natMul_smul

-- The analytic layer.
/-- info: 'SocrateAI.ModularForms.norm_eta_eq_exp_mul_tail' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.norm_eta_eq_exp_mul_tail

/-- info: 'SocrateAI.ModularForms.tendsto_hpt_atImInfty' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.tendsto_hpt_atImInfty

/-- info: 'SocrateAI.ModularForms.tendsto_cuspTail' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.tendsto_cuspTail

/-- info: 'SocrateAI.ModularForms.isTheta_mul_of_tendsto' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.isTheta_mul_of_tendsto

/-- info: 'SocrateAI.ModularForms.norm_etaQuotientH_smul_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.norm_etaQuotientH_smul_eq

-- THE HEADLINE.
/-- info: 'SocrateAI.ModularForms.etaQuotient_cusp_order' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_cusp_order

/-- info: 'SocrateAI.ModularForms.etaQuotient_cusp_order_ligozat' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_cusp_order_ligozat

-- The LL-1 guards.
/-- info: 'SocrateAI.ModularForms.norm_etaQuotientH_isTheta_infty' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.norm_etaQuotientH_isTheta_infty

/-- info: 'SocrateAI.ModularForms.cusp_order_infty_guard' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.cusp_order_infty_guard

/-- info: 'SocrateAI.ModularForms.norm_discriminant_isTheta' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.norm_discriminant_isTheta

/-- info: 'SocrateAI.ModularForms.exp_isBigO_discriminant_of_cusp_order' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exp_isBigO_discriminant_of_cusp_order

-- STATEMENT PINS (LL-1) for F3.2-C2.
section F32C2Pin
open CongruenceSubgroup Matrix SocrateAI.ModularForms UpperHalfPlane Asymptotics Filter
open scoped MatrixGroups Real ModularForm

-- PIN 1 -- the un-normalised order is LITERALLY `(1/24) Σ_{δ ∣ N} gcd(c,δ)² r_δ / δ`.  A drift
-- to `gcd(c,δ)` (no square), to a `gcd(c, N/δ)`, or to a `/12` breaks this `rfl`.
example (N : ℕ) (r : EtaExp) (c : ℤ) :
    etaQuotientRawOrder N r c
      = (∑ δ ∈ N.divisors, ((Int.gcd c (δ : ℤ) : ℚ) ^ 2 * (r δ : ℚ)) / (δ : ℚ)) / 24 := rfl

-- PIN 2 -- the slash convention the headline is stated against: `(f ∣[k] γ) z = f(γz)·denom^{-k}`.
example (N : ℕ) (r : EtaExp) (k : ℤ) (γ : SL(2, ℤ)) (z : ℍ) :
    (etaQuotientH N r ∣[k] (γ : GL (Fin 2) ℝ)) z
      = etaQuotientH N r (γ • z) * denom (γ : GL (Fin 2) ℝ) (z : ℂ) ^ (-k) := by
  rw [← ModularForm.SL_slash, ModularForm.SL_slash_apply]

-- PIN 3 -- THE HONESTY PIN.  Ligozat's cusp order and the exponent actually proved are NOT the
-- same number: at `N = 2`, `f = (η(z)η(2z))^12`, cusp `0` (`c = 1`), Ligozat's order is `3/2`
-- while the decay exponent in `Im z` is `3/4`, the ratio being the width `2`.  If someone ever
-- "simplifies" `etaQuotient_cusp_order` by replacing `etaQuotientRawOrder` with
-- `etaQuotientCuspOrder`, this line says loudly that the two differ.
example :
    etaQuotientRawOrder 2 (fun δ => if δ = 1 then 12 else if δ = 2 then 12 else 0) 1 = 3 / 4
      ∧ etaQuotientCuspOrder 2 (fun δ => if δ = 1 then 12 else if δ = 2 then 12 else 0) 1 = 3 / 2
      ∧ etaQuotientRawOrder 2 (fun δ => if δ = 1 then 12 else if δ = 2 then 12 else 0) 1
          ≠ etaQuotientCuspOrder 2 (fun δ => if δ = 1 then 12 else if δ = 2 then 12 else 0) 1 := by
  obtain ⟨h1, -, h3, -⟩ := rawOrder_level_two_twelve_pin
  exact ⟨h1, h3, by rw [h1, h3]; norm_num⟩

-- PIN 4 -- the width bridge, in the general form, with the width spelled `N / gcd(d², N)`.
example {N d : ℕ} (hd : d ∣ N) (r : EtaExp) :
    etaQuotientCuspOrder N r d
      = ((N : ℚ) / (Nat.gcd (d ^ 2) N : ℚ)) * etaQuotientRawOrder N r (d : ℤ) :=
  etaQuotientCuspOrder_eq_width_mul_raw hd r

-- PIN 5 -- the headline in longhand, so the filter, the `Θ` and the shape of the right-hand side
-- cannot drift: no approach region, `Real.exp`, factor `-2π`, argument `z.im`.
example (N : ℕ) (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (γ : SL(2, ℤ)) :
    (fun z : ℍ => ‖(etaQuotientH N r ∣[k] (γ : GL (Fin 2) ℝ)) z‖)
      =Θ[UpperHalfPlane.atImInfty]
      fun z : ℍ => Real.exp (-2 * Real.pi * ((etaQuotientRawOrder N r (γ 1 0) : ℚ) : ℝ) * z.im) :=
  etaQuotient_cusp_order N r hk γ

-- PIN 6 -- the EXTERNAL pin, restated: Mathlib's own `exp_isBigO_discriminant` is recovered from
-- the headline at `N = 1`, `r ≡ 24`, `k = 12`.  Both sides of this equation are propositions
-- about the same functions; the left is Mathlib's, the right is ours.
example :
    (fun z : ℍ => Real.exp (-2 * Real.pi * z.im)) =O[UpperHalfPlane.atImInfty]
      ModularForm.discriminant :=
  exp_isBigO_discriminant_of_cusp_order

example :
    (fun z : ℍ => Real.exp (-2 * Real.pi * z.im)) =O[UpperHalfPlane.atImInfty]
      ModularForm.discriminant :=
  ModularForm.exp_isBigO_discriminant

end F32C2Pin

/-! ## `F3.2-C3` — Ligozat at the genus-zero primes `p = 5, 7, 13`

Generation of `Γ₀(p)` by `{-I, T, V}` together with explicit ELLIPTIC elements (coset
enumeration against the `p+1` classes of `ℙ¹(𝔽_p)`), and the eta multiplier evaluated on every
one of those generators — the elliptic ones through `F3.2-A9`'s fixed-point trick.
-/

section F32C3

/-- info: 'SocrateAI.ModularForms.subgroup_eq_of_transversal' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms subgroup_eq_of_transversal
/-- info: 'SocrateAI.ModularForms.matH' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms matH
/-- info: 'SocrateAI.ModularForms.matH_mem_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms matH_mem_Gamma0
/-- info: 'SocrateAI.ModularForms.cosetReps' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms cosetReps
/-- info: 'SocrateAI.ModularForms.Gamma0_eq_of_schreier' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms Gamma0_eq_of_schreier
/-- info: 'SocrateAI.ModularForms.gamma0GensP5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms gamma0GensP5
/-- info: 'SocrateAI.ModularForms.closure_gamma0GensP5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms closure_gamma0GensP5
/-- info: 'SocrateAI.ModularForms.closure_gamma0GensP7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms closure_gamma0GensP7
/-- info: 'SocrateAI.ModularForms.closure_gamma0GensP13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms closure_gamma0GensP13
/-- info: 'SocrateAI.ModularForms.Gamma0_prime_generated' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms Gamma0_prime_generated
/-- info: 'SocrateAI.ModularForms.tauEll' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms tauEll
/-- info: 'SocrateAI.ModularForms.denom_matH_tauEll' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms denom_matH_tauEll
/-- info: 'SocrateAI.ModularForms.matH_smul_tauEll' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms matH_smul_tauEll
/-- info: 'SocrateAI.ModularForms.omega3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms omega3
/-- info: 'SocrateAI.ModularForms.omega3_poly' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms omega3_poly
/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_matH_diag' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierVal_matH_diag
/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_matH_succ' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierVal_matH_succ
/-- info: 'SocrateAI.ModularForms.closure_preimage_eq_top' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms closure_preimage_eq_top
/-- info: 'SocrateAI.ModularForms.hom_ext_of_closure' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms hom_ext_of_closure
/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_of_p5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierHom_eq_of_p5
/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_of_p7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierHom_eq_of_p7
/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_of_p13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierHom_eq_of_p13
/-- info: 'SocrateAI.ModularForms.ligozat_of_prime5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozat_of_prime5
/-- info: 'SocrateAI.ModularForms.ligozat_of_prime7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozat_of_prime7
/-- info: 'SocrateAI.ModularForms.ligozat_of_prime13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozat_of_prime13
/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_one_p5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierHom_eq_one_p5
/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_one_p7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierHom_eq_one_p7
/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eq_one_p13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierHom_eq_one_p13
/-- info: 'SocrateAI.ModularForms.etaQuotientH_transform_p5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientH_transform_p5
/-- info: 'SocrateAI.ModularForms.etaQuotientH_transform_p7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientH_transform_p7
/-- info: 'SocrateAI.ModularForms.etaQuotientH_transform_p13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotientH_transform_p13
/-- info: 'SocrateAI.ModularForms.closure_gamma0Gens_two_schreier' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms closure_gamma0Gens_two_schreier
/-- info: 'SocrateAI.ModularForms.closure_gamma0Gens_three_schreier' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms closure_gamma0Gens_three_schreier
/-- info: 'SocrateAI.ModularForms.gamma0Gens_three_two_routes' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms gamma0Gens_three_two_routes
/-- info: 'SocrateAI.ModularForms.S_not_mem_closure_gensP5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms S_not_mem_closure_gensP5
/-- info: 'SocrateAI.ModularForms.closure_gamma0GensP5_ne_top' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms closure_gamma0GensP5_ne_top
/-- info: 'SocrateAI.ModularForms.testGamma0Five_mem_closure' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms testGamma0Five_mem_closure
/-- info: 'SocrateAI.ModularForms.elliptic_traces' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms elliptic_traces
/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_satisfies_p5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierHom_satisfies_p5
/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_satisfies_p13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaMultiplierHom_satisfies_p13
/-- info: 'SocrateAI.ModularForms.not_multiplier_trivial_p5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms not_multiplier_trivial_p5
/-- info: 'SocrateAI.ModularForms.ligozat_of_prime' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ligozat_of_prime

end F32C3

section F32C3Pin

open SocrateAI.ModularForms Matrix CongruenceSubgroup UpperHalfPlane
open scoped MatrixGroups Real

-- PIN 1 -- the Schreier generator, entrywise, so it cannot drift.
example (j j' : ℤ) :
    ((matH j j' : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ) = !![-j', -1; j * j' + 1, j] := rfl

-- PIN 2 -- the transversal, longhand: `{1} ∪ {S T^j : 0 ≤ j < p}`, `p+1` elements.
example (p : ℕ) :
    cosetReps p
      = insert 1 ((fun j : ℕ => ModularGroup.S * ModularGroup.T ^ (j : ℤ)) '' {j : ℕ | j < p}) :=
  rfl

-- PIN 3 -- the node's right-hand side re-pinned as the RAW divisibility condition on the
-- lower-left entry, not as the `Gamma0` abbreviation.
example (g : SL(2, ℤ)) :
    g ∈ Subgroup.closure gamma0GensP5 ↔ (5 : ℤ) ∣ g 1 0 := by
  rw [closure_gamma0GensP5, Gamma0_mem]
  exact_mod_cast ZMod.intCast_zmod_eq_zero_iff_dvd (g 1 0) 5

-- PIN 4 -- the generating set in the node's own `{-1, T, V} ∪ elliptic` shape.
example :
    gamma0GensP5
      = ({(-1 : SL(2, ℤ)), ModularGroup.T, matV 5} : Set SL(2, ℤ)) ∪ {matH 2 2, matH 3 3} :=
  gamma0GensP5_eq_union

-- PIN 5 -- the elliptic data at `p = 5` in classical coordinates: the fixed point of
-- `!![-2,-1;5,2]` is `(-2+i)/5` and the automorphy factor there is `i` (NOT `-i`; the sign is
-- what fixes `w(e) = i^{-k}` rather than `(-i)^{-k}`).
example : ((tauEll 2 2 (by norm_num) Complex.I I_im_pos : ℍ) : ℂ) = (Complex.I - 2) / 5 := by
  rw [coe_tauEll]; norm_num

example :
    denom ((matH 2 2 : SL(2, ℤ)) : GL (Fin 2) ℝ)
      ((tauEll 2 2 (by norm_num) Complex.I I_im_pos : ℍ) : ℂ) = Complex.I :=
  denom_matH_tauEll 2 2 (by norm_num) Complex.I I_im_pos

-- PIN 6 -- `ω` longhand, and the fact that it is a primitive cube root of unity.
example : omega3 = (-1 + (Real.sqrt 3 : ℝ) * Complex.I) / 2 := rfl
example : omega3 ^ 2 + omega3 + 1 = 0 := omega3_poly

-- PIN 7 -- the headline at `p = 5` in longhand: the transformation law on ALL of `Γ₀(5)`, with
-- the character's five generator values spelled out.
example (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ (5 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 5 r) (h2 : LigozatCongr2 5 r) (w : Gamma0 5 →* ℂˣ)
    (hwT : w ⟨ModularGroup.T, T_mem_Gamma0 5⟩ = 1)
    (hwV : w ⟨matV 5, matV_mem_Gamma0 5⟩ = 1)
    (hwm : w ⟨-1, neg_one_mem_Gamma0 5⟩ = (-1 : ℂˣ) ^ k)
    (hwE1 : ((w ⟨matH 2 2, matH22_mem5⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k))
    (hwE2 : ((w ⟨matH 3 3, matH33_mem5⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k))
    (γ : Gamma0 5) (z : ℍ) :
    etaQuotientH 5 r ((γ : SL(2, ℤ)) • z)
      = (w γ : ℂ) * (denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)) ^ k
        * etaQuotientH 5 r z :=
  ligozat_of_prime5 r hk h1 h2 w hwT hwV hwm hwE1 hwE2 γ z

-- PIN 8 -- THE HONESTY PIN.  At `p = 5` the hypothesis of the trivial-multiplier corollary is
-- `4 ∣ k`, and it is NOT `Even k`: `r = (5, -1)` satisfies Ligozat (i) and (ii) with `k = 2`
-- even, and the trivial-multiplier law FAILS at the elliptic generator.
example : LigozatCongr1 5 ligozatFiveExp ∧ LigozatCongr2 5 ligozatFiveExp
    ∧ (∑ δ ∈ (5 : ℕ).divisors, ligozatFiveExp δ = 2 * 2) ∧ Even (2 : ℤ) :=
  ⟨ligozatFiveExp_congr1, ligozatFiveExp_congr2, ligozatFiveExp_sum, ⟨1, by norm_num⟩⟩

example :
    ¬ ∀ z : ℍ, etaQuotientH 5 ligozatFiveExp (matH 2 2 • z)
        = (denom ((matH 2 2 : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)) ^ (2 : ℤ)
          * etaQuotientH 5 ligozatFiveExp z :=
  not_multiplier_trivial_p5

-- PIN 9 -- the divisibility thresholds, level by level, so they cannot be transposed.
example (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ (5 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 5 r) (h2 : LigozatCongr2 5 r) (hdvd : (4 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 5) (z : ℍ) :
    etaQuotientH 5 r (γ • z)
      = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH 5 r z :=
  etaQuotientH_transform_p5 r hk h1 h2 hdvd hγ z

example (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ (7 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 7 r) (h2 : LigozatCongr2 7 r) (hdvd : (6 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 7) (z : ℍ) :
    etaQuotientH 7 r (γ • z)
      = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH 7 r z :=
  etaQuotientH_transform_p7 r hk h1 h2 hdvd hγ z

example (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ (13 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 13 r) (h2 : LigozatCongr2 13 r) (hdvd : (12 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 13) (z : ℍ) :
    etaQuotientH 13 r (γ • z)
      = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH 13 r z :=
  etaQuotientH_transform_p13 r hk h1 h2 hdvd hγ z

-- PIN 10 -- the node's own single `ligozat_of_prime`, quantified over the Finset {5,7,13}.
example {p : ℕ} (hp : p ∈ ({5, 7, 13} : Finset ℕ)) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ p.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 p r) (h2 : LigozatCongr2 p r) (hdvd : (12 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 p) (z : ℍ) :
    etaQuotientH p r (γ • z)
      = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH p r z :=
  ligozat_of_prime hp r hk h1 h2 hdvd hγ z

end F32C3Pin


/-! ## Run 4 (DRK-*) — Dedekind sums, Apostol's `Φ`, Rademacher's `Ψ`, the `η` multiplier

STATUS OF RUN 4, stated before any guard so it cannot be read off the guards alone: run 4
delivered a **statement layer** plus **one port**.  Proved and sorry-free: the definitions
`dedekindSaw`, `dedekindSum`, `rademacherPhi`, `rademacherPsi`, the nineteen `DRK-01` supporting
lemmas (a PORT of FLT's `Def_NumberTheory_DedekindSum.lean`, see `ATTRIBUTION.md`), and the
`DRK-00` sign-discipline gate.  UNPROVED, and pinned as unproved by inverted tripwires below:
`DRK-02` (reciprocity), all three `DRK-03` lemmas, `DRK-04` (the descent step), `DRK-05`,
`DRK-06` (the closed form of the multiplier), `DRK-07`, and `ETA-01`.

UPDATED 2026-09-07/08 as those nodes closed one by one: `DRK-02`, all three `DRK-03` lemmas
plus `rademacherPhi_of_pos_toNat`, `DRK-04`, **`DRK-05` (both halves)** and now
**`DRK-06` (both phrasings, 2026-09-08)** are proved and sorry-free, each with a positive guard
below.  STILL UNPROVED, and still pinned as unproved by inverted tripwires: `DRK-07`, `ETA-01`.

WHAT DRK-06 IS AND IS NOT.  It is the closed form of the `η` multiplier —
`η(γz) = e^{πiΦ(γ)/12}·√(-i(cz+d))·η(z)` — for `γ ∈ SL(2,ℤ)` with **`c > 0`**, with `Φ` Apostol's
`rademacherPhi` and NOT `rademacherPsi` (LL-22).  Its STATEMENT is FLT's; its PROOF is ours
(Euclidean descent on `c`; `ATTRIBUTION.md` records the split per declaration).  It is proved on
FLT's own scope, so it is not a weakening of the reference — but `c = 0` and `c < 0` are simply
NOT covered, and `DRK-05` turned out not to be needed for it at all.

The `F3.2-OBSTRUCTED` obstruction is **NOT** removed by DRK-06 alone, and run 4 did **not** meet
its stated success criterion.  `ligozat_general` (ETA-01) is still `sorry`: getting there from
DRK-06 still needs the `c ≤ 0` cases, the conjugated matrices `γ_δ` for each `δ ∣ N`, and the
product `∏_δ ε(γ_δ)^{r_δ} = 1` under Ligozat's congruences (which is `DRK-07` plus counting).
Anyone citing run 4 as having removed the obstruction is citing it wrongly. -/

section Run4DedekindRademacher

open SocrateAI.NumberTheory SocrateAI.ModularForms
open scoped MatrixGroups

-- ---------------------------------------------------------------------------------------
-- PROVED, sorry-free.  DRK-01 (the port) and DRK-00 (the gate).
-- ---------------------------------------------------------------------------------------

/-- info: 'SocrateAI.NumberTheory.dedekindSaw' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw

/-- info: 'SocrateAI.NumberTheory.dedekindSum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_neg

/-- info: 'SocrateAI.NumberTheory.abs_dedekindSaw_lt_half' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.abs_dedekindSaw_lt_half

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_natCast_div' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_natCast_div

/-- info: 'SocrateAI.NumberTheory.dedekindSum_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_neg

/-- info: 'SocrateAI.NumberTheory.dedekindSum_add_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_add_mul

/-- info: 'SocrateAI.NumberTheory.dedekindSum_eq_sum_Ico' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_eq_sum_Ico

-- DRK-01, THE REMAINING THIRTEEN.  Together with the eight guards above, all 21 declarations
-- ported from FLT's `Def_NumberTheory_DedekindSum.lean` are now under an axiom guard, so the
-- whole port -- not a sample of it -- is a build dependency of the audit.  Re-verified
-- 2026-09-07 against a fresh fetch of the upstream file: 21 identical, 0 differing, 0 missing.

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_of_fract_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_of_fract_eq_zero

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_of_fract_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_of_fract_ne_zero

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_intCast' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_intCast

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_natCast' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_natCast

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_zero

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_one

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_add_intCast' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_add_intCast

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_intCast_add' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_intCast_add

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_add_natCast' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_add_natCast

/-- info: 'SocrateAI.NumberTheory.dedekindSaw_half' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSaw_half

/-- info: 'SocrateAI.NumberTheory.dedekindSum_zero_right' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_zero_right

/-- info: 'SocrateAI.NumberTheory.dedekindSum_one_right' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_one_right

/-- info: 'SocrateAI.NumberTheory.dedekindSum_zero_left' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_zero_left

/-- info: 'SocrateAI.NumberTheory.rademacherPhi' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi

/-- info: 'SocrateAI.NumberTheory.rademacherPsi' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPsi

-- DRK-00.  `decide +kernel` adds NO axiom: these two are the gate's axiom audit.  (Had the pins
-- been done with `native_decide`, `Lean.ofReduceBool` would appear here and this guard would
-- fail -- which is exactly why the guard is worth having.)
/-- info: 'SocrateAI.NumberTheory.dedekindSum_five_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_five_pin

-- The other five NAMED pins, one per regime (negative `h`; composite `k`; degenerate `k`; a
-- reciprocity instance; the non-coprime NEGATIVE CONTROL).  Six named, guarded pins in total,
-- which is what the run brief's "6+ decide pins as guarded lemmas" asks for -- the nineteen
-- `example`s in the gate already fail the build if wrong, but an `example` has no name and so
-- cannot be given a `#print axioms` guard.

/-- info: 'SocrateAI.NumberTheory.dedekindSum_neg_three_seven_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_neg_three_seven_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_four_twelve_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_four_twelve_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_one_one_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_one_one_pin

-- (Lean wraps this one: the declaration name is long enough that the axiom list is
-- pretty-printed over three lines.  Same footprint as every other pin.)
/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_five_twelve_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_five_twelve_pin

-- (Lean wraps this one: the declaration name is long enough that the axiom list is
-- pretty-printed over three lines.  Same footprint as every other pin.)
/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_fails_four_twelve' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_fails_four_twelve

-- ---------------------------------------------------------------------------------------
-- DRK-02, PROVED 2026-09-07.  THIS GUARD IS THE ONE THAT MATTERS: it is what makes the DAG
-- node's `status: proved` a build dependency rather than a claim in a JSON file.  If anyone
-- reintroduces a `sorry` anywhere beneath Dedekind reciprocity -- in the permutation lemma, in
-- either fibre lemma, in the double count, in the Gauss sums -- `sorryAx` appears here and the
-- build fails.  `decide +kernel` and `linear_combination` add no axiom of their own; had any pin
-- been done with `native_decide`, `Lean.ofReduceBool` would appear and this would fail too.
-- ---------------------------------------------------------------------------------------

/-- info: 'SocrateAI.NumberTheory.dedekindSum_add_dedekindSum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_add_dedekindSum

-- DRK-02's own gate: the seven reciprocity pins, four intermediate floor/mod-sum pins, two extra
-- non-coprime NEGATIVE CONTROLS, and the four individual Dedekind-sum values that stop a
-- compensating pair of errors from satisfying a reciprocity pin.  Every one is `decide +kernel`
-- on the DEFINITION -- none is proved by `dedekindSum_add_dedekindSum` -- so together they are an
-- independent kernel check of the general theorem at seventeen points, not a restatement of it.

-- (Lean wraps the longer names: the axiom list is pretty-printed over three lines.  Same
-- footprint in every case.)
/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_seven_eleven_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_seven_eleven_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_nine_twentyfive_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_nine_twentyfive_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_two_fifteen_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_two_fifteen_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_four_nine_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_four_nine_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_eleven_thirteen_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_eleven_thirteen_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_three_eight_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_three_eight_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_one_one_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_one_one_pin

/-- info: 'SocrateAI.NumberTheory.floorSum_id_seven_eleven_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.floorSum_id_seven_eleven_pin

/-- info: 'SocrateAI.NumberTheory.floorSum_count_seven_eleven_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.floorSum_count_seven_eleven_pin

/-- info: 'SocrateAI.NumberTheory.floorSum_count_eleven_seven_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.floorSum_count_eleven_seven_pin

/-- info: 'SocrateAI.NumberTheory.modSum_seven_eleven_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.modSum_seven_eleven_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_fails_six_nine' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_fails_six_nine

/-- info: 'SocrateAI.NumberTheory.dedekindSum_reciprocity_fails_ten_fifteen' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_reciprocity_fails_ten_fifteen

/-- info: 'SocrateAI.NumberTheory.dedekindSum_seven_eleven_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_seven_eleven_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_eleven_seven_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_eleven_seven_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_nine_twentyfive_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_nine_twentyfive_pin

/-- info: 'SocrateAI.NumberTheory.dedekindSum_twentyfive_nine_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_twentyfive_nine_pin

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_S_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_S_pin

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_ne_rademacherPsi' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_ne_rademacherPsi

-- ---------------------------------------------------------------------------------------
-- DRK-03 (2026-09-07).  ELEVEN NAMED, AXIOM-GUARDED SIGN-DISCIPLINE PINS, each an instance of
-- one of the three DRK-03 lemmas, all computed by `decide +kernel` from the DEFINITIONS ALONE
-- and placed in `RademacherPhi.lean` ABOVE the three proofs, so no pin can be discharged by the
-- theorem it is pinning.  Every value was recomputed independently in Python
-- (`fractions.Fraction`) before the Lean was written.  `decide +kernel` adds NO axiom; had
-- `native_decide` been used, `Lean.ofReduceBool` would appear below and these guards would fail.
-- ---------------------------------------------------------------------------------------

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_of_pos_pin_c5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_of_pos_pin_c5

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_of_pos_pin_c12' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_of_pos_pin_c12

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_of_pos_pin_c1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_of_pos_pin_c1

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_of_pos_fails_c_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_of_pos_fails_c_neg

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_neg_pin_c_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_neg_pin_c_pos

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_neg_pin_c_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_neg_pin_c_neg

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_neg_pin_c_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_neg_pin_c_zero

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_pin_c_zero_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_pin_c_zero_value

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_T_zpow_pin_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_T_zpow_pin_zero

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_T_zpow_pin_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_T_zpow_pin_four

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_T_zpow_pin_neg_five' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_T_zpow_pin_neg_five

-- ---------------------------------------------------------------------------------------
-- DRK-03 PROVED (2026-09-07).  Positive guards for the three lemmas and their one helper.
-- Their INVERTED tripwires (which asserted `sorryAx` was still present) are consequently GONE
-- from the tripwire block below; this is the receipt for that deletion, on the model of the
-- DRK-02 receipt, so that a vanished inverted tripwire can never be mistaken for someone
-- quietly deleting an inconvenient check.  No `sorryAx`, no `Lean.ofReduceBool`.
-- ---------------------------------------------------------------------------------------

/-- info: 'SocrateAI.NumberTheory.SL2_neg_apply' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.SL2_neg_apply

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_of_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_of_pos

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_neg

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_T_zpow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_T_zpow

-- ---------------------------------------------------------------------------------------
-- DRK-04 PROVED (2026-09-07).  Positive guard for `rademacher_phi_step`, plus the twelve named
-- instance pins and the three negative controls that were landed and kernel-checked BEFORE the
-- proof was written.  The INVERTED tripwire for `rademacher_phi_step` (which asserted `sorryAx`
-- was still in its footprint) is consequently GONE from the tripwire block below; this is the
-- receipt for that deletion, on the model of the DRK-02 and DRK-03 receipts, so that a vanished
-- inverted tripwire can never be mistaken for someone quietly deleting an inconvenient check.
-- No `sorryAx`, no `Lean.ofReduceBool` anywhere below.
--
-- The private helper `phi_step_algebra` carries no separate guard: private declarations get
-- mangled names that `#print axioms` cannot address from here.  It is covered transitively --
-- if it acquired an axiom, `rademacher_phi_step`'s own footprint below would show it.
-- ---------------------------------------------------------------------------------------

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_r2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_r2

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_r7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_r7

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c3_r2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c3_r2

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c4_r5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c4_r5

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c1_r1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c1_r1

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c7_r1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c7_r1

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_q0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_q0

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_qneg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_qneg

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c7_aneg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c7_aneg

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c12_r7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c12_r7

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_dbig' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c5_dbig

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_pin_c13_r5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_pin_c13_r5

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_fails_det_ne_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_fails_det_ne_one

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_fails_det_ne_one_2' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_fails_det_ne_one_2

/-- info: 'SocrateAI.NumberTheory.rademacher_phi_step_fails_hrd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacher_phi_step_fails_hrd

-- ---------------------------------------------------------------------------------------
-- LL-22 STATEMENT PINS.  These fail the build if `Φ`, `Ψ` or `s(h,k)` is ever redefined as
-- another of the three.  `rfl`/`decide +kernel` is the guard, not the source text.
-- ---------------------------------------------------------------------------------------

-- PIN 1 -- the definition of `s(h,k)` longhand, at the ported signature.
example : ∀ (h : ℤ) (k : ℕ), SocrateAI.NumberTheory.dedekindSum h k
    = ∑ r ∈ Finset.range k, SocrateAI.NumberTheory.dedekindSaw ((r : ℚ) / k)
        * SocrateAI.NumberTheory.dedekindSaw ((h : ℚ) * r / k) :=
  fun _ _ => rfl

-- PIN 2 -- the sawtooth longhand: `0` ON the integers, `fract - 1/2` off them.  A version that
-- dropped the `if` (i.e. `((x)) = fract x - 1/2` everywhere) would break this and would make
-- `dedekindSum_neg` false.
example : ∀ x : ℚ, SocrateAI.NumberTheory.dedekindSaw x
    = if Int.fract x = 0 then 0 else Int.fract x - 1 / 2 :=
  fun _ => rfl

-- PIN 3 -- `Ψ = Φ - 3·sign(c(a+d))` longhand, so the OFFSET between the two cannot drift.
example : ∀ γ : SL(2, ℤ), SocrateAI.NumberTheory.rademacherPsi γ
    = SocrateAI.NumberTheory.rademacherPhi γ
        - 3 * ((Int.sign (γ 1 0 * (γ 0 0 + γ 1 1)) : ℤ) : ℚ) :=
  fun _ => rfl

-- PIN 4 -- the three functions are pairwise DIFFERENT as numbers, on matrices where it shows.
example : SocrateAI.NumberTheory.rademacherPhi ModularGroup.T = 1 := by decide +kernel
example : SocrateAI.NumberTheory.dedekindSum 1 5 = 1 / 5 := by decide +kernel
example : SocrateAI.NumberTheory.dedekindSum 1 5 ≠ 2 / 5 := by decide +kernel

-- ---------------------------------------------------------------------------------------
-- INVERTED TRIPWIRES.  Each of these asserts that a run-4 node is STILL UNPROVED.  When one is
-- proved, its footprint loses `sorryAx` and the guard below FAILS -- which is the signal to
-- edit this file and flip the DAG node.  This is the mechanism that stops run 4 from being
-- cited as more finished than it is.
-- ---------------------------------------------------------------------------------------

-- DRK-02 HAS BEEN PROVED (2026-09-07) and its inverted tripwire is therefore GONE, replaced by
-- the ordinary positive guard in the DRK-00/DRK-01 block above.  This comment is the receipt for
-- the deletion: an inverted tripwire that vanishes without a positive guard taking its place
-- would be indistinguishable from someone quietly deleting an inconvenient check.  The positive
-- guard is `#print axioms SocrateAI.NumberTheory.dedekindSum_add_dedekindSum` giving
-- [propext, Classical.choice, Quot.sound] -- no `sorryAx`, no `Lean.ofReduceBool`.
-- The remaining inverted tripwires below are still OPEN nodes and must stay.

-- DRK-03 HAS BEEN PROVED (2026-09-07).  Its three inverted tripwires -- which asserted that
-- `rademacherPhi_of_pos`, `rademacherPhi_neg` and `rademacherPhi_T_zpow` still carried `sorryAx`
-- -- are therefore GONE, replaced by the three ordinary positive guards in the DRK-03 block
-- above, alongside eleven named pin guards.  This comment is the receipt for the deletion.
-- The remaining inverted tripwires below are still OPEN nodes and must stay.

-- DRK-04 HAS BEEN PROVED (2026-09-07).  Its inverted tripwire -- which asserted that
-- `rademacher_phi_step` still carried `sorryAx` -- is therefore GONE, replaced by the ordinary
-- positive guard in the DRK-04 block above, alongside fifteen named pin/negative-control guards.
-- This comment is the receipt for the deletion.  NOTE WHAT THIS DOES **NOT** CLOSE: DRK-06
-- (`eta_specialLinearGroup_smul_flt`, `eta_smul_eq_exp_rademacherPhi`), DRK-05
-- (`logDeriv_eta_smul_eq_logDeriv_csqrt`, `exists_eta_smul_const`), DRK-07
-- (`etaMultiplierPhi_pow24`, `etaMultiplierPhi_mul_cocycle`) and ETA-01 (`ligozat_general`) are
-- all STILL OPEN and their inverted tripwires below are untouched.  DRK-04 is the arithmetic
-- engine of DRK-06, not DRK-06.  (DRK-05 has since been proved -- see the block below -- but
-- that is the ANALYTIC half only and still does not close DRK-06.)

-- DRK-05 HAS BEEN PROVED (2026-09-08), BOTH HALVES.  The two inverted tripwires that stood here
-- -- asserting that `logDeriv_eta_smul_eq_logDeriv_csqrt` and `exists_eta_smul_const` still
-- carried `sorryAx` -- are therefore GONE, replaced by the two ordinary positive guards below
-- plus TWENTY-FIVE named pin / negative-control guards.  This comment is the receipt for the
-- deletion.
--
-- READ THIS BEFORE QUOTING IT (LL-1).  DRK-05 is the ANALYTIC HALF ONLY.  It says the ratio
-- eta(gamma z) / (sqrt(-i(cz+d)) eta z) is a CONSTANT; it says NOTHING about the value of that
-- constant.  It is STRICTLY WEAKER than FLT's `eta_specialLinearGroup_smul`: the reference gives
-- the multiplier as exp(pi i/12 ((a+d)/c - 12 s(d,c))), and DRK-05(b) replaces that value by an
-- unnamed existential.  The reference implies DRK-05(b) in one line; the converse is all of
-- DRK-06.  WHAT DRK-05 DOES *NOT* DO: it does not close FLT item (3); it does not remove
-- F3.2-OBSTRUCTED; it does not unblock ETA-01; and it does not touch the c = 0 or c < 0 branches
-- (both statements carry `0 < gamma 1 0`, exactly as the reference does).
--
-- PROVENANCE: INDEPENDENT.  No FLT text was used, and FLT has no counterpart to DRK-05(a) at all.
-- The proof is the E2-period route: `logDeriv_eta_eq_E2` on both z and gamma z,
-- `EisensteinSeries.E2_slash_action gamma` for the weight-2 defect, and `Complex.deriv_sqrt` for
-- the square-root side; the two sides meet at + c/(2(cz+d)), the sign coming from i^2 = -1
-- acting on the SUBTRACTED defect.  Relative to Mathlib it is a strict generalisation of
-- `ModularForm.logDeriv_eta_comp_eq_logDeriv_csqrt_eta` (which is the gamma = S case only).
--
-- The remaining inverted tripwires below (DRK-06, DRK-07, ETA-01) are still OPEN and must stay.


/-- info: 'SocrateAI.ModularForms.logDeriv_eta_smul_eq_logDeriv_csqrt' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.logDeriv_eta_smul_eq_logDeriv_csqrt


/-- info: 'SocrateAI.ModularForms.exists_eta_smul_const' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exists_eta_smul_const


-- The sign gate for DRK-05, guarded.  Family A pins Re(-i(cz+d)) = c*Im z -- the ONLY place
-- `0 < gamma 1 0` enters the proof, since it is what puts -i(cz+d) in `Complex.slitPlane`.
-- Family B pins the E2 defect constant against SEVEN independently computed rational values
-- (mpmath at 50 dps, then exact `fractions.Fraction`; the two agree to the last digit).
-- Two negative controls show both signs are load-bearing: c < 0 fails, and +i fails.
-- LL-22: no Dedekind sum, no Phi and no Psi occurs anywhere in DRK-05, so the Phi/Psi confusion
-- cannot enter this node; it enters at DRK-06, where the RademacherPhi.lean tripwires live.

/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_c3d2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_c3d2


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_c1d1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_c1d1


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_c4d3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_c4d3


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_c12d5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_c12d5


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_c5dm2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_c5dm2


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_c16d7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_c16d7


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_c2dm1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_c2dm1


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_c1d0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_c1d0


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_pos_c3d2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_pos_c3d2


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_pos_c1d1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_pos_c1d1


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_pos_c4d3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_pos_c4d3


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_pos_c12d5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_pos_c12d5


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_pos_c5dm2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_pos_c5dm2


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_pos_c16d7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_pos_c16d7


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_pos_c2dm1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_pos_c2dm1


/-- info: 'SocrateAI.ModularForms.drk05_pin_slit_pos_c1d0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_slit_pos_c1d0


/-- info: 'SocrateAI.ModularForms.drk05_neg_control_slit_cneg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_neg_control_slit_cneg


/-- info: 'SocrateAI.ModularForms.drk05_neg_control_plus_I' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_neg_control_plus_I


/-- info: 'SocrateAI.ModularForms.drk05_pin_defect_c3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_defect_c3


/-- info: 'SocrateAI.ModularForms.drk05_pin_defect_c1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_defect_c1


/-- info: 'SocrateAI.ModularForms.drk05_pin_defect_c12' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_defect_c12


/-- info: 'SocrateAI.ModularForms.drk05_pin_defect_c5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_defect_c5


/-- info: 'SocrateAI.ModularForms.drk05_pin_defect_c4' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_defect_c4


/-- info: 'SocrateAI.ModularForms.drk05_pin_defect_c16' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_defect_c16


/-- info: 'SocrateAI.ModularForms.drk05_pin_defect_c2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk05_pin_defect_c2


-- ---------------------------------------------------------------------------------------------
-- DRK-06 PROVED (2026-09-08).  The inverted tripwires for `eta_specialLinearGroup_smul_flt` and
-- `eta_smul_eq_exp_rademacherPhi` (which asserted `sorryAx` while the node was open) are DELETED
-- and replaced by the positive guards below.  This comment is the receipt for that deletion.
--
-- WHAT DRK-06 IS: the closed form of the eta multiplier for gamma in SL(2,Z) with c > 0,
--   eta(gamma z) = exp(pi i Phi(gamma) / 12) * sqrt(-i (c z + d)) * eta(z),
-- with Phi = rademacherPhi = APOSTOL'S Phi, NOT the Rademacher symbol Psi (LL-22).
-- Statement from anthropics/fermats-last-theorem (Apache-2.0), PROOF INDEPENDENT: strong
-- induction on c by Euclidean descent, base c = 1 via gamma = T^a S T^d, step via
-- gamma = gamma' S T^q with gamma' 1 0 = r < c, DRK-04 (`rademacher_phi_step`) supplying
-- Phi(gamma) = Phi(gamma') + q - 3 and `csqrt_mul_of_re_mul_pos` supplying the matching branch
-- factor sqrt(-i) = exp(-pi i/4) = exp(pi i (-3)/12).  DRK-05 is NOT used.
--
-- WHAT DRK-06 DOES *NOT* DO: it says nothing about c = 0 or c < 0 (that is FLT's own scope too),
-- it does not prove DRK-07, and it does not close ETA-01 / F3.2-OBSTRUCTED.  The inverted
-- tripwires for DRK-07 and ETA-01 below are still OPEN and must stay.
--
-- The sixteen pins and three negative controls are guarded too: they are the sign gate, and a
-- guard on the theorem without a guard on its gate is worth less than either.
-- ---------------------------------------------------------------------------------------------

/-- info: 'SocrateAI.ModularForms.eta_smul_eq_exp_rademacherPhi' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_smul_eq_exp_rademacherPhi

/-- info: 'SocrateAI.ModularForms.eta_specialLinearGroup_smul_flt' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_specialLinearGroup_smul_flt

/-- info: 'SocrateAI.ModularForms.eta_smul_strong_induction' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_smul_strong_induction

/-- info: 'SocrateAI.ModularForms.eta_smul_of_c_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_smul_of_c_eq_one

/-- info: 'SocrateAI.ModularForms.eta_smul_descent_step' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_smul_descent_step

/-- info: 'SocrateAI.ModularForms.rademacherPhi_descent' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.rademacherPhi_descent

/-- info: 'SocrateAI.ModularForms.sl2_descent_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.sl2_descent_eq

/-- info: 'SocrateAI.ModularForms.sl2_det' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.sl2_det

/-- info: 'SocrateAI.ModularForms.slOf_apply' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.slOf_apply

/-- info: 'SocrateAI.ModularForms.csqrt_mul_self' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_mul_self

/-- info: 'SocrateAI.ModularForms.csqrt_re_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_re_nonneg

/-- info: 'SocrateAI.ModularForms.csqrt_re_mul_re_sub' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_re_mul_re_sub

/-- info: 'SocrateAI.ModularForms.csqrt_two_re_mul_im' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_two_re_mul_im

/-- info: 'SocrateAI.ModularForms.abs_im_csqrt_lt_re' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.abs_im_csqrt_lt_re

/-- info: 'SocrateAI.ModularForms.csqrt_re_pos_im_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_re_pos_im_pos

/-- info: 'SocrateAI.ModularForms.csqrt_mul_of_re_mul_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_mul_of_re_mul_pos

/-- info: 'SocrateAI.ModularForms.csqrt_mul_of_re_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_mul_of_re_pos

/-- info: 'SocrateAI.ModularForms.csqrt_neg_I_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_neg_I_mul

/-- info: 'SocrateAI.ModularForms.csqrt_neg_I_eq_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_neg_I_eq_exp

/-- info: 'SocrateAI.ModularForms.csqrt_I_inv' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.csqrt_I_inv

/-- info: 'SocrateAI.ModularForms.coe_T_zpow_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.coe_T_zpow_smul

/-- info: 'SocrateAI.ModularForms.coe_S_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.coe_S_smul

/-- info: 'SocrateAI.ModularForms.im_pos_coe' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.im_pos_coe

/-- info: 'SocrateAI.ModularForms.eta_neg_inv' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_neg_inv

/-- info: 'SocrateAI.ModularForms.re_neg_I_mul_lin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.re_neg_I_mul_lin

/-- info: 'SocrateAI.ModularForms.coe_T_zpow_entry' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.coe_T_zpow_entry

/-- info: 'SocrateAI.ModularForms.drk06_pin_descent_c5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_descent_c5

/-- info: 'SocrateAI.ModularForms.drk06_pin_descent_c7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_descent_c7

/-- info: 'SocrateAI.ModularForms.drk06_pin_descent_c2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_descent_c2

/-- info: 'SocrateAI.ModularForms.drk06_pin_descent_c4' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_descent_c4

/-- info: 'SocrateAI.ModularForms.drk06_pin_descent_c5b' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_descent_c5b

/-- info: 'SocrateAI.ModularForms.drk06_pin_descent_c3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_descent_c3

/-- info: 'SocrateAI.ModularForms.drk06_pin_descent_c12' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_descent_c12

/-- info: 'SocrateAI.ModularForms.drk06_pin_descent_c13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_descent_c13

/-- info: 'SocrateAI.ModularForms.drk06_neg_control_minus_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_neg_control_minus_two

/-- info: 'SocrateAI.ModularForms.drk06_neg_control_no_shift' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_neg_control_no_shift

/-- info: 'SocrateAI.ModularForms.drk06_pin_base_S' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_base_S

/-- info: 'SocrateAI.ModularForms.drk06_pin_base_T' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_base_T

/-- info: 'SocrateAI.ModularForms.drk06_pin_base_23' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_base_23

/-- info: 'SocrateAI.ModularForms.drk06_pin_base_m14' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_base_m14

/-- info: 'SocrateAI.ModularForms.drk06_pin_base_5m2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_base_5m2

/-- info: 'SocrateAI.ModularForms.drk06_pin_base_m4m7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_base_m4m7

/-- info: 'SocrateAI.ModularForms.drk06_pin_branch_im_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_branch_im_neg

/-- info: 'SocrateAI.ModularForms.drk06_pin_branch_im_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_pin_branch_im_pos

/-- info: 'SocrateAI.ModularForms.drk06_neg_control_branch_sign' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk06_neg_control_branch_sign

/-- info: 'SocrateAI.NumberTheory.rademacherPhi_of_pos_toNat' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.rademacherPhi_of_pos_toNat


/-- info: 'SocrateAI.ModularForms.etaMultiplierPhi_pow24' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierPhi_pow24

/-- info: 'SocrateAI.ModularForms.etaMultiplierPhi_mul_cocycle' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierPhi_mul_cocycle

-- `ligozat_trivial_multiplier_of_twelve_dvd`'s guard moved with it to
-- `Lean/SocrateAI/Quarantine/LigozatTrivialMultiplierRefuted.lean` (not part of this default
-- build target; see that file and ATTRIBUTION.md \S3).

-- The multiplier DEFINITION is sorry-free even though every theorem about it is not.
/-- info: 'SocrateAI.ModularForms.etaMultiplierPhi' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierPhi

/-- info: 'SocrateAI.ModularForms.mobiusC' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.mobiusC


/-! ## DRK-08 — `w(-γ) = (-1)^k·w(γ)` and the `c`-sign reduction  (LL-2 / LL-7)

Both resolving declarations are `SocrateAI.ModularForms.etaMultiplierVal_neg` and
`SocrateAI.ModularForms.exists_pos_lower_left_or_T_zpow`, in
`Lean/SocrateAI/ModularForms/EtaMultiplierNeg.lean`.  PROVENANCE: INDEPENDENT — no FLT counterpart
exists (comparator verdict NO_REFERENCE), and no `ATTRIBUTION.md` port entry is owed.

The three anti-junk-witness controls are guarded here as theorems in their own right:
`drk08_neg_control_cneg4_not_T_zpow` (at `c = -4` the `T^n` disjunct is FALSE, so part 2 must have
produced `γ' = -γ` with `c' = 4 > 0`), `drk08_neg_control_T5_not_pos_lower_left` (at `c = 0` the
`0 < c'` disjunct is FALSE), and `drk08_neg_control_neg_S_ne_S` (at ODD `k = 1`, `f = η²`,
`w(-S) = i ≠ -i = w(S)`, so part 1's `(-1)^k` is load-bearing and not a decoration).

SCOPE (LL-1): DRK-08 is at the eta-QUOTIENT multiplier level.  It does NOT extend DRK-06 to
`c ≤ 0` — the single-`η` closed form is false there by a factor of `i`.  See the file header. -/

/-- info: 'SocrateAI.ModularForms.drk08Mat' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08Mat

/-- info: 'SocrateAI.ModularForms.drk08Mat_coe' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08Mat_coe

/-- info: 'SocrateAI.ModularForms.SL2_neg_entry' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.SL2_neg_entry

/-- info: 'SocrateAI.ModularForms.drk08MatCneg4' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08MatCneg4

/-- info: 'SocrateAI.ModularForms.drk08MatC5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08MatC5

/-- info: 'SocrateAI.ModularForms.drk08MatT5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08MatT5

/-- info: 'SocrateAI.ModularForms.drk08MatNegT3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08MatNegT3

/-- info: 'SocrateAI.ModularForms.drk08_pin_cneg4_entry' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_cneg4_entry

/-- info: 'SocrateAI.ModularForms.drk08_pin_cneg4_neg_entry' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_cneg4_neg_entry

/-- info: 'SocrateAI.ModularForms.drk08_pin_cneg4_mem' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_cneg4_mem

/-- info: 'SocrateAI.ModularForms.drk08_pin_c5_entry' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_c5_entry

/-- info: 'SocrateAI.ModularForms.drk08_pin_T5_entries' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_T5_entries

/-- info: 'SocrateAI.ModularForms.drk08_pin_T5_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_T5_eq

/-- info: 'SocrateAI.ModularForms.drk08_pin_negT3_entries' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_negT3_entries

/-- info: 'SocrateAI.ModularForms.drk08_pin_negT3_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_negT3_eq

/-- info: 'SocrateAI.ModularForms.drk08_neg_control_negT3_wrong_sign' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_neg_control_negT3_wrong_sign

/-- info: 'SocrateAI.ModularForms.drk08_pin_neg_one_zpow_odd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_neg_one_zpow_odd

/-- info: 'SocrateAI.ModularForms.drk08_neg_control_even_k_blind' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_neg_control_even_k_blind

/-- info: 'SocrateAI.ModularForms.drk08_pin_neg_one_zpow_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_neg_one_zpow_neg

/-- info: 'SocrateAI.ModularForms.drk08_pin_eta_sq_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_pin_eta_sq_weight

/-- info: 'SocrateAI.ModularForms.T_zpow_lower_left' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.T_zpow_lower_left

/-- info: 'SocrateAI.ModularForms.neg_T_zpow_lower_left' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.neg_T_zpow_lower_left

/-- info: 'SocrateAI.ModularForms.exists_pos_lower_left_or_T_zpow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exists_pos_lower_left_or_T_zpow

/-- info: 'SocrateAI.ModularForms.drk08_neg_control_cneg4_not_T_zpow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_neg_control_cneg4_not_T_zpow

/-- info: 'SocrateAI.ModularForms.drk08_neg_control_T5_not_pos_lower_left' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_neg_control_T5_not_pos_lower_left

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_neg

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_neg_eta_sq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_neg_eta_sq

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eta_sq_neg_S' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eta_sq_neg_S

/-- info: 'SocrateAI.ModularForms.drk08_neg_control_neg_S_ne_S' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk08_neg_control_neg_S_ne_S


/-! ## DRK-09 — the eta-quotient multiplier as one Dedekind-sum exponential  (LL-2 / LL-7)

The resolving declaration for the DAG node is
`SocrateAI.ModularForms.etaMultiplierVal_eq_exp_etaPhiSum`, in
`Lean/SocrateAI/ModularForms/EtaPhiSum.lean`.  All three statements the node was scoped in are
landed and `sorry`-free: the definition `etaPhiSum`, the split form `etaPhiSum_eq`, and the
closed form `etaMultiplierVal_eq_exp_etaPhiSum`.

PROVENANCE: **INDEPENDENT re-derivation**, from DRK-06 + run 3's `divisorConj` (F3.2-A3) +
`csqrt_zpow_two_mul` (F3.2-A7).  No FLT text, tactic or proof strategy is used and no FLT
solution file was read, so **no `ATTRIBUTION.md` port entry is owed for the proofs**.  But the
node's own metadata claim "No FLT counterpart" is **FALSE** and is retracted in
`ATTRIBUTION.md` §DRK-09: `P2M/Sol/S_ModularCurve_sharpUnitInvariant.lean`'s
`DedekindEtaLaw.phi` is our summand at prime level with two divisors, and
`ModularForm.etaProductEleven_transform` is an `N = 11` instance.  DRK-09 is a genuine
generalisation (arbitrary `N`, arbitrary `r`, arbitrary integer weight `k`) and the
`(√x)^{2k} = (-i)^k(cz+d)^k` collection has no upstream counterpart, since FLT works at weight 0.

WHAT DRK-09 DOES *NOT* DO (LL-1).  It does **not** delete `F3.2-OBSTRUCTED`; the node's own
docstring said "deletes" and that word is wrong.  It REPLACES the `hgen` generation hypothesis of
`multiplier_trivial_of_congr` with an explicit Dedekind-sum evaluation.  Still open:
(a) `c ≤ 0` — and `etaMultiplierVal_c_zero_formula_fails`, guarded below, PROVES the formula is
false at `c = 0` (`N = 1`, `r ≡ 2`, `k = 1`, `γ = T`: truth `e^{πi/6}`, formula `-i`), so this is
a real gap and not bookkeeping; (b) the arithmetic `24 ∣ etaPhiSum N r γ` from Ligozat's two
congruences, which is a separate and harder node.  `ETA-01` therefore remains OPEN.

THE ANTI-JUNK GATE.  Fifteen `decide +kernel` pins of `etaPhiSum` at explicit `(N, r, γ)`
(`N ∈ {2,4,5,6,7,9,11,12,13}`, values `0, ±24, 11, 28, -18, 12, 18, 5, -3, 6, -8`, including odd
values and values not divisible by 24), each computed independently in Python first and eleven of
them checked against a 4000-term `η`-product evaluation of the multiplier (worst relative error
3.3e-14).  Four kernel negative controls separate `etaPhiSum` from the three one-character
mutants the numerical sweep rejects: `+12·s` instead of `−12·s`, `(a+d)/c` instead of
`(a+d)·δ/c`, and `s(d,c)` instead of `s(d,c/δ)`.

BONUS, and an independent consistency check on the whole formula: comparing DRK-09 at
`(N,r,k) = (1, 24, 12)` with run 3's `etaMultiplierVal_level_one_24` (the multiplier of `Δ` is 1,
proved with no Dedekind sums at all) forces `e^{2πiΦ(γ)} = 1`, i.e. **`Φ(γ) ∈ ℤ`**
(`rademacherPhi_eq_intCast`).  That was the explicitly-named missing ingredient of `DRK-07.a`,
and `etaMultiplierPhi_pow24_of_intCast` discharges DRK-07.a's statement under a new name.  The
`sorry` at `EtaMultiplier.lean:1234` is deliberately NOT touched by this run, so the inverted
tripwire above still fires: it is now **stale**, not wrong. -/

/-- info: 'SocrateAI.ModularForms.etaPhiSum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaPhiSum

/-- info: 'SocrateAI.ModularForms.drk09MatC4' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC4

/-- info: 'SocrateAI.ModularForms.drk09MatC8' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC8

/-- info: 'SocrateAI.ModularForms.drk09MatC2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC2

/-- info: 'SocrateAI.ModularForms.drk09MatC6' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC6

/-- info: 'SocrateAI.ModularForms.drk09MatC6b' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC6b

/-- info: 'SocrateAI.ModularForms.drk09MatC12' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC12

/-- info: 'SocrateAI.ModularForms.drk09MatC5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC5

/-- info: 'SocrateAI.ModularForms.drk09MatC13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC13

/-- info: 'SocrateAI.ModularForms.drk09MatC7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC7

/-- info: 'SocrateAI.ModularForms.drk09MatC11' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC11

/-- info: 'SocrateAI.ModularForms.drk09MatC9' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09MatC9

/-- info: 'SocrateAI.ModularForms.drk09R4' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R4

/-- info: 'SocrateAI.ModularForms.drk09R2' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R2

/-- info: 'SocrateAI.ModularForms.drk09R6' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R6

/-- info: 'SocrateAI.ModularForms.drk09R12' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R12

/-- info: 'SocrateAI.ModularForms.drk09R5' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R5

/-- info: 'SocrateAI.ModularForms.drk09R13' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R13

/-- info: 'SocrateAI.ModularForms.drk09R7' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R7

/-- info: 'SocrateAI.ModularForms.drk09R11' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R11

/-- info: 'SocrateAI.ModularForms.drk09R9' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R9

/-- info: 'SocrateAI.ModularForms.drk09R6a' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R6a

/-- info: 'SocrateAI.ModularForms.drk09R12b' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R12b

/-- info: 'SocrateAI.ModularForms.drk09R5b' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R5b

/-- info: 'SocrateAI.ModularForms.drk09R9b' does not depend on any axioms -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09R9b

/-- info: 'SocrateAI.ModularForms.drk09_pin_N4_c4' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N4_c4

/-- info: 'SocrateAI.ModularForms.drk09_pin_N4_c8' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N4_c8

/-- info: 'SocrateAI.ModularForms.drk09_pin_N2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N2

/-- info: 'SocrateAI.ModularForms.drk09_pin_N6_c6' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N6_c6

/-- info: 'SocrateAI.ModularForms.drk09_pin_N6_c6b' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N6_c6b

/-- info: 'SocrateAI.ModularForms.drk09_pin_N12' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N12

/-- info: 'SocrateAI.ModularForms.drk09_pin_N5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N5

/-- info: 'SocrateAI.ModularForms.drk09_pin_N13' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N13

/-- info: 'SocrateAI.ModularForms.drk09_pin_N7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N7

/-- info: 'SocrateAI.ModularForms.drk09_pin_N11' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N11

/-- info: 'SocrateAI.ModularForms.drk09_pin_N9' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N9

/-- info: 'SocrateAI.ModularForms.drk09_pin_N6_single' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N6_single

/-- info: 'SocrateAI.ModularForms.drk09_pin_N12_sparse' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N12_sparse

/-- info: 'SocrateAI.ModularForms.drk09_pin_N5_sparse' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N5_sparse

/-- info: 'SocrateAI.ModularForms.drk09_pin_N9_sparse' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_pin_N9_sparse

/-- info: 'SocrateAI.ModularForms.etaPhiSumSignFlip' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaPhiSumSignFlip

/-- info: 'SocrateAI.ModularForms.etaPhiSumNoDelta' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaPhiSumNoDelta

/-- info: 'SocrateAI.ModularForms.etaPhiSumWrongModulus' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaPhiSumWrongModulus

/-- info: 'SocrateAI.ModularForms.drk09_neg_control_sign_flip' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_neg_control_sign_flip

/-- info: 'SocrateAI.ModularForms.drk09_neg_control_no_delta' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_neg_control_no_delta

/-- info: 'SocrateAI.ModularForms.drk09_neg_control_wrong_modulus' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_neg_control_wrong_modulus

/-- info: 'SocrateAI.ModularForms.drk09_neg_control_mutants_at_N7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk09_neg_control_mutants_at_N7

/-- info: 'SocrateAI.ModularForms.etaPhiSum_eq_unconditional' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaPhiSum_eq_unconditional

/-- info: 'SocrateAI.ModularForms.etaPhiSum_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaPhiSum_eq

/-- info: 'SocrateAI.ModularForms.rademacherPhi_divisorConj' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.rademacherPhi_divisorConj

/-- info: 'SocrateAI.ModularForms.eta_natScale_smul_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta_natScale_smul_eq

/-- info: 'SocrateAI.ModularForms.etaQuotientH_smul_eq_exp_etaPhiSum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_smul_eq_exp_etaPhiSum

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eq_exp_etaPhiSum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eq_exp_etaPhiSum

/-- info: 'SocrateAI.ModularForms.etaPhiSum_of_lower_left_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaPhiSum_of_lower_left_zero

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_c_zero_formula_fails' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_c_zero_formula_fails

/-- info: 'SocrateAI.ModularForms.rademacherPhi_eq_intCast_of_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.rademacherPhi_eq_intCast_of_pos

/-- info: 'SocrateAI.ModularForms.rademacherPhi_eq_intCast' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.rademacherPhi_eq_intCast

/-- info: 'SocrateAI.ModularForms.etaMultiplierPhi_pow24_of_intCast' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierPhi_pow24_of_intCast



/-! ## DRK-10 — the Dedekind sum mod 8 and the Kronecker/Jacobi bridge

28 guards.  Every one of them is `[propext, Classical.choice, Quot.sound]` — no `sorryAx`, no
new axiom.  The block covers, in order: the twelve `decide +kernel` instance pins of the
`DRK-10` statement, its four negative controls (two for `Odd k`, two for `Nat.Coprime h k`),
the two headline theorems and the integrality lemma they run on, the consistency tripwire that
re-derives the `(7,11)` witness `t = -4` **from the general theorem**, and half 2's four
agreement pins and two `2`-disagreement controls. -/

section Drk10

/-- info: 'SocrateAI.NumberTheory.drk10_pin_one_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_one_one

/-- info: 'SocrateAI.NumberTheory.drk10_pin_zero_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_zero_one

/-- info: 'SocrateAI.NumberTheory.drk10_pin_one_five' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_one_five

/-- info: 'SocrateAI.NumberTheory.drk10_pin_two_five' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_two_five

/-- info: 'SocrateAI.NumberTheory.drk10_pin_three_seven' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_three_seven

/-- info: 'SocrateAI.NumberTheory.drk10_pin_five_seven' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_five_seven

/-- info: 'SocrateAI.NumberTheory.drk10_pin_seven_eleven' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_seven_eleven

/-- info: 'SocrateAI.NumberTheory.drk10_pin_nine_twentyfive' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_nine_twentyfive

/-- info: 'SocrateAI.NumberTheory.drk10_pin_eleven_thirteen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_eleven_thirteen

/-- info: 'SocrateAI.NumberTheory.drk10_pin_two_fifteen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_two_fifteen

/-- info: 'SocrateAI.NumberTheory.drk10_pin_four_nine' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_four_nine

/-- info: 'SocrateAI.NumberTheory.drk10_pin_thirteen_five' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_pin_thirteen_five

/-- info: 'SocrateAI.NumberTheory.drk10_fails_k_even_one_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_fails_k_even_one_two

/-- info: 'SocrateAI.NumberTheory.drk10_fails_k_even_five_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_fails_k_even_five_six

/-- info: 'SocrateAI.NumberTheory.drk10_fails_gcd_three_nine' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_fails_gcd_three_nine

/-- info: 'SocrateAI.NumberTheory.drk10_fails_gcd_five_fifteen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_fails_gcd_five_fifteen

/-- info: 'SocrateAI.NumberTheory.dedekindSum_jacobiSym_mod_eight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.dedekindSum_jacobiSym_mod_eight

/-- info: 'SocrateAI.ModularForms.kronecker_ne_jacobi_at_two_neg_three' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kronecker_ne_jacobi_at_two_neg_three

/-- info: 'SocrateAI.ModularForms.kronecker_ne_jacobi_at_two_five' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kronecker_ne_jacobi_at_two_five

/-- info: 'SocrateAI.ModularForms.kronecker_eq_jacobi_pin_three_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kronecker_eq_jacobi_pin_three_one

/-- info: 'SocrateAI.ModularForms.kronecker_eq_jacobi_pin_five_three' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kronecker_eq_jacobi_pin_five_three

/-- info: 'SocrateAI.ModularForms.kronecker_eq_jacobi_pin_two_five' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kronecker_eq_jacobi_pin_two_five

/-- info: 'SocrateAI.ModularForms.kroneckerSym_eq_jacobiSym_of_odd'' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_eq_jacobiSym_of_odd'

/-- info: 'SocrateAI.ModularForms.kroneckerSym_eq_jacobiSym_of_odd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_eq_jacobiSym_of_odd

/-- info: 'SocrateAI.ModularForms.pos_of_odd_nat' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.pos_of_odd_nat

/-- info: 'SocrateAI.NumberTheory.exists_intCast_eq_twelve_mul_dedekindSum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.exists_intCast_eq_twelve_mul_dedekindSum

/-- info: 'SocrateAI.NumberTheory.drk10_general_matches_pin_seven_eleven' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.NumberTheory.drk10_general_matches_pin_seven_eleven

/-- info: 'SocrateAI.ModularForms.kronecker_eq_jacobi_pin_neg_one_seven' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kronecker_eq_jacobi_pin_neg_one_seven

end Drk10


section Drk11

-- DRK-11 (run 4) -- the closed-form eta multiplier vs Ligozat's Kronecker character.
--
-- WHAT THESE GUARDS CERTIFY, and equally what they do NOT.
--
-- PROVED, footprint [propext, Classical.choice, Quot.sound] in every case below:
--   * the exponential layer, which REDUCES the node to a congruence mod 24 (`drk11_iff_congr`);
--   * the node's exact conclusion for `0 < N <= 4` on all of `Gamma0 N` with `c > 0`
--     (`exp_etaPhiSum_eq_kroneckerSym_of_le_four`), obtained by composing DRK-09 with run 3's
--     F3.2-B3 -- no new mathematics, but the node's proposition on a nonempty domain;
--   * eleven `decide +kernel` pins of the node's conclusion at explicit `(N, r, k, gamma)`,
--     covering k even/odd/zero/NEGATIVE, c odd and even, d = 0 / positive odd / positive even /
--     negative odd / negative even, negative exponents, and both symbol values;
--   * four negative controls: Ligozat's two congruences are load-bearing (levels 8 and 12),
--     `hc : 0 < c` is load-bearing (`gamma = T`, where the formula gives `i` and the truth is
--     `1`), and the `(-1)^k` factor of `ligozatKroneckerNum` is load-bearing;
--   * two consistency tripwires running the general (N <= 4) theorem at the gate's own
--     instances and reproducing the values computed OUTSIDE Lean.
--
-- NOT PROVED, and the INVERTED tripwire at the end of this section certifies it: the node for
-- general `N` (`exp_etaPhiSum_eq_kroneckerSym`) still depends on `sorryAx`.  `F3.2-OBSTRUCTED`
-- stands; `ETA-01` is NOT resolved.  The two missing inputs are named in the `-- OPEN:` comment
-- of the theorem: an EVEN-modulus companion to DRK-10, and the divisor-by-divisor quadratic
-- reciprocity assembly.

/-- info: 'SocrateAI.ModularForms.neg_I_eq_exp_pi_div_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.neg_I_eq_exp_pi_div_twelve

/-- info: 'SocrateAI.ModularForms.neg_I_zpow_eq_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.neg_I_zpow_eq_exp

/-- info: 'SocrateAI.ModularForms.drk11_lhs_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_lhs_eq

/-- info: 'SocrateAI.ModularForms.exp_pi_div_twelve_eq_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exp_pi_div_twelve_eq_one_iff

/-- info: 'SocrateAI.ModularForms.exp_pi_div_twelve_eq_neg_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exp_pi_div_twelve_eq_neg_one_iff

/-- info: 'SocrateAI.ModularForms.drk11_eq_one_of' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_eq_one_of

/-- info: 'SocrateAI.ModularForms.drk11_eq_neg_one_of' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_eq_neg_one_of

/-- info: 'SocrateAI.ModularForms.drk11_ne_one_of' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_ne_one_of

/-- info: 'SocrateAI.ModularForms.drk11_iff_congr' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_iff_congr

/-- info: 'SocrateAI.ModularForms.kroneckerSym_one_right' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_one_right

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_one_right_of_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_one_right_of_neg

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_one_right_of_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_one_right_of_pos

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_three_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_three_two

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_three_neg_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_three_neg_two

/-- info: 'SocrateAI.ModularForms.drk11_pin_N1_S' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N1_S

/-- info: 'SocrateAI.ModularForms.drk11_pin_N11_even_d' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N11_even_d

/-- info: 'SocrateAI.ModularForms.drk11_pin_N3_odd_k' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N3_odd_k

/-- info: 'SocrateAI.ModularForms.drk11_pin_N3_even_d' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N3_even_d

/-- info: 'SocrateAI.ModularForms.drk11_pin_N3_neg_even_d' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N3_neg_even_d

/-- info: 'SocrateAI.ModularForms.drk11_pin_N3_neg_odd_d' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N3_neg_odd_d

/-- info: 'SocrateAI.ModularForms.drk11_pin_N3_neg_k' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N3_neg_k

/-- info: 'SocrateAI.ModularForms.drk11_pin_N7_odd_c' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N7_odd_c

/-- info: 'SocrateAI.ModularForms.drk11_pin_N2_even_c' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N2_even_c

/-- info: 'SocrateAI.ModularForms.drk11_pin_N4_neg_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N4_neg_exp

/-- info: 'SocrateAI.ModularForms.drk11_pin_N5_k_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_pin_N5_k_zero

/-- info: 'SocrateAI.ModularForms.drk11_neg_control_congr_needed' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_neg_control_congr_needed

/-- info: 'SocrateAI.ModularForms.drk11_neg_control_congr_needed_twelve' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_neg_control_congr_needed_twelve

/-- info: 'SocrateAI.ModularForms.drk11_neg_control_c_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_neg_control_c_zero

/-- info: 'SocrateAI.ModularForms.drk11_neg_control_drop_sign' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_neg_control_drop_sign

/-- info: 'SocrateAI.ModularForms.exp_etaPhiSum_eq_kroneckerSym_of_le_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exp_etaPhiSum_eq_kroneckerSym_of_le_four

/-- info: 'SocrateAI.ModularForms.drk11_general_matches_pin_N3_odd_k' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_general_matches_pin_N3_odd_k

/-- info: 'SocrateAI.ModularForms.drk11_general_matches_pin_N3_even_d' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk11_general_matches_pin_N3_even_d

-- INVERTED TRIPWIRE.  This guard PASSES only while DRK-11 for general `N` is UNPROVED.  When
-- someone discharges the `sorry`, THIS CHECK FAILS and must be edited to the standard footprint
-- in the same commit -- which is the point: the claim "DRK-11 is open" cannot go stale.
/-- info: 'SocrateAI.ModularForms.exp_etaPhiSum_eq_kroneckerSym' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exp_etaPhiSum_eq_kroneckerSym

end Drk11

end Run4DedekindRademacher

/-! ## ETA-01 — Ligozat at general `N` in Kronecker-character form
(`Lean/SocrateAI/ModularForms/EtaLigozatGeneral.lean`)

FORTY-THREE guards with the standard footprint and FOUR inverted tripwires.

WHAT IS PROVED (standard footprint): the Kronecker sign law, the `c < 0` and `c = 0` strata of
ETA-01 at EVERY `N`, the reduction `etaMultiplierVal_eq_kroneckerSym_of_pos` that turns the
`c > 0` slice into all of `Γ₀(N)`, ETA-01 in full for `0 < N ≤ 4` including the packaged
`ModularForm (Γ₀ N) k` term `etaQuotientModularFormOfLeFour`, and the `N = 17` refutation of
`ligozat_trivial_multiplier_of_twelve_dvd`.

WHAT IS OPEN (inverted tripwires): `etaMultiplierVal_eq_kroneckerSym`, `ligozat_general`,
`ligozat_kronecker_transform` and `etaQuotientModularFormGeneral` still depend on `sorryAx`, and
they depend on it through EXACTLY ONE declaration — `DRK-11`'s `exp_etaPhiSum_eq_kroneckerSym`,
whose own inverted tripwire sits in section `Drk11` above.  Discharging DRK-11 breaks all five
guards at once, which is the point: "ETA-01 is open, and DRK-11 is the only reason" cannot go
stale. -/

section Eta01

/-! ### The sign-discipline gate -/

/-- info: 'SocrateAI.ModularForms.eta01_pin_num_N17' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_num_N17

/-- info: 'SocrateAI.ModularForms.eta01_pin_num_N17_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_num_N17_pos

/-- info: 'SocrateAI.ModularForms.eta01_pin_num_N3_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_num_N3_neg

/-- info: 'SocrateAI.ModularForms.eta01_pin_num_N3_neg_k' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_num_N3_neg_k

/-- info: 'SocrateAI.ModularForms.eta01_pin_sym_N17_pos_d' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_sym_N17_pos_d

/-- info: 'SocrateAI.ModularForms.eta01_pin_sym_N17_neg_d' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_sym_N17_neg_d

/-- info: 'SocrateAI.ModularForms.eta01_pin_sym_N3_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_sym_N3_one

/-- info: 'SocrateAI.ModularForms.eta01_pin_sym_N3_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_sym_N3_neg_one

/-- info: 'SocrateAI.ModularForms.eta01_pin_sym_N3_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_sym_N3_two

/-- info: 'SocrateAI.ModularForms.eta01_pin_sym_N3_neg_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_sym_N3_neg_two

/-- info: 'SocrateAI.ModularForms.eta01_pin_N17_entries' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_N17_entries

/-- info: 'SocrateAI.ModularForms.eta01_pin_N17_mem' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_N17_mem

/-- info: 'SocrateAI.ModularForms.eta01_pin_N3negA_entries' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_N3negA_entries

/-- info: 'SocrateAI.ModularForms.eta01_pin_N3negB_entries' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_N3negB_entries

/-- info: 'SocrateAI.ModularForms.eta01_pin_R17_sum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_R17_sum

/-- info: 'SocrateAI.ModularForms.eta01_pin_R17_congr1_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_R17_congr1_value

/-- info: 'SocrateAI.ModularForms.eta01_pin_R17_congr2_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_R17_congr2_value

/-- info: 'SocrateAI.ModularForms.eta01_R17_congr1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_R17_congr1

/-- info: 'SocrateAI.ModularForms.eta01_R17_congr2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_R17_congr2

/-- info: 'SocrateAI.ModularForms.eta01_pin_twelve_dvd' depends on axioms: [propext] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_pin_twelve_dvd

/-- info: 'SocrateAI.ModularForms.eta01_neg_control_sign_law_needs_numerator_sign' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_neg_control_sign_law_needs_numerator_sign

/-- info: 'SocrateAI.ModularForms.eta01_neg_control_sign_law_not_always_flip' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_neg_control_sign_law_not_always_flip

/-! ### The Kronecker sign law and the numerator's sign -/

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_right_of_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_right_of_nonneg

/-- info: 'SocrateAI.ModularForms.kroneckerSym_neg_right_of_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_neg_right_of_neg

/-- info: 'SocrateAI.ModularForms.ligozat_prod_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_prod_pos

/-- info: 'SocrateAI.ModularForms.ligozatKroneckerNum_pos_of_even' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatKroneckerNum_pos_of_even

/-- info: 'SocrateAI.ModularForms.ligozatKroneckerNum_neg_of_odd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozatKroneckerNum_neg_of_odd

/-- info: 'SocrateAI.ModularForms.kroneckerSym_ligozat_neg_right' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_ligozat_neg_right

/-! ### The `c = 0` stratum -/

/-- info: 'SocrateAI.ModularForms.T_zpow_lower_right' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.T_zpow_lower_right

/-- info: 'SocrateAI.ModularForms.neg_T_zpow_lower_right' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.neg_T_zpow_lower_right

/-- info: 'SocrateAI.ModularForms.T_zpow_mem_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.T_zpow_mem_Gamma0

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_T_zpow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_T_zpow

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_T_zpow' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_T_zpow

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_neg_T_zpow' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_neg_T_zpow

/-! ### THE REDUCTION — the file's main proved theorem -/

/-- info: 'SocrateAI.ModularForms.even_of_lower_right_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.even_of_lower_right_zero

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_of_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_of_pos

/-! ### ETA-01 for `0 < N ≤ 4`, PROVED, including a genuine `ModularForm` term -/

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_of_le_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_of_le_four

/-- info: 'SocrateAI.ModularForms.eta01_reduction_matches_le_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_reduction_matches_le_four

/-- info: 'SocrateAI.ModularForms.etaQuotientH_slash_of_kronecker' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_slash_of_kronecker

/-- info: 'SocrateAI.ModularForms.etaQuotientModularFormOfLeFour' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientModularFormOfLeFour

/-! ### The `N = 17` refutation of the `12 ∣ k` form -/

/-- info: 'SocrateAI.ModularForms.eta01_seventeen_kronecker_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_seventeen_kronecker_value

/-- info: 'SocrateAI.ModularForms.eta01_seventeen_hchi_fails' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_seventeen_hchi_fails

/-- info: 'SocrateAI.ModularForms.eta01_seventeen_refutes_trivial_multiplier' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.eta01_seventeen_refutes_trivial_multiplier

/-! ### INVERTED TRIPWIRES — ETA-01 general `N` is STILL OPEN

Each of the four PASSES only while `DRK-11` is undischarged.  Proving `DRK-11` breaks all four
in the same commit, which is exactly the intent: nobody can claim ETA-01 without editing here. -/

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym

/-- info: 'SocrateAI.ModularForms.ligozat_general' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_general

/-- info: 'SocrateAI.ModularForms.ligozat_kronecker_transform' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ligozat_kronecker_transform

/-- info: 'SocrateAI.ModularForms.etaQuotientModularFormGeneral' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientModularFormGeneral

end Eta01


/-! ## DRK-12 — Ligozat at level 11 (`EtaLigozatLevelEleven.lean`)

`η(z)²·η(11z)²` on `Γ₀(11)`, weight 2.  Level 11 is beyond run 3's `F3.2-C3` reach because
`Γ̄₀(11)` has no elliptic elements.  Fifty-three guards are POSITIVE (`sorry`-free) and ONE is an
INVERTED tripwire certifying that the route through `ligozat_general` is still open. -/

section Drk12


/-! ### DRK-12 — the sign-discipline gate

Twenty pins.  Every `etaPhiSum` value was computed independently in Python (`fractions.Fraction`,
`Int.fract`/`dedekindSaw`/`dedekindSum`/`etaPhiSum` re-implemented from the Lean SOURCE) before it
was written, and the re-implementation first reproduced `drk11_phi_N11`, `drk11_phi_N3a/b/c/d` and
`drk11_phi_N7` exactly.  A 2376-matrix sweep of `Γ₀(11)` with `c > 0` found zero mismatches. -/

/-- info: 'SocrateAI.ModularForms.drk12_pin_R11_sum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_pin_R11_sum

/-- info: 'SocrateAI.ModularForms.drk12_pin_R11_congr1_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_pin_R11_congr1_value

/-- info: 'SocrateAI.ModularForms.drk12_pin_R11_congr2_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_pin_R11_congr2_value

/-- info: 'SocrateAI.ModularForms.drk12_R11_congr1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_R11_congr1

/-- info: 'SocrateAI.ModularForms.drk12_R11_congr2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_R11_congr2

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_1_10' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_1_10

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_2_5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_2_5

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_3_7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_3_7

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_4_8' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_4_8

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_5_2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_5_2

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_6_9' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_6_9

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_7_3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_7_3

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_8_4' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_8_4

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_9_6' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_9_6

/-- info: 'SocrateAI.ModularForms.drk12_phi_h_10_1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_phi_h_10_1

/-- info: 'SocrateAI.ModularForms.drk12_pin_num_eleven' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_pin_num_eleven

/-- info: 'SocrateAI.ModularForms.drk12_pin_sym_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_pin_sym_four

/-- info: 'SocrateAI.ModularForms.drk12_pin_sym_three' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_pin_sym_three

/-- info: 'SocrateAI.ModularForms.drk12_neg_control_sym_eleven' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_neg_control_sym_eleven

/-- info: 'SocrateAI.ModularForms.drk12_neg_control_phi_distinct' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_neg_control_phi_distinct

/-! ### DRK-12 — generation of `Γ₀(11)`

`Γ̄₀(11)` is free of rank 3 with NO elliptic elements, so run 3's `F3.2-C3` route cannot supply a
single generator value here.  `S_not_mem_closure_gensP11` certifies the closure is PROPER. -/

/-- info: 'SocrateAI.ModularForms.gamma0GensP11' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gamma0GensP11

/-- info: 'SocrateAI.ModularForms.drk12_mem_h_2_5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_mem_h_2_5

/-- info: 'SocrateAI.ModularForms.drk12_mem_h_3_7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_mem_h_3_7

/-- info: 'SocrateAI.ModularForms.drk12_mem_h_4_8' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_mem_h_4_8

/-- info: 'SocrateAI.ModularForms.drk12_mem_h_6_9' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_mem_h_6_9

/-- info: 'SocrateAI.ModularForms.gamma0GensP11_subset' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.gamma0GensP11_subset

/-- info: 'SocrateAI.ModularForms.closure_gamma0GensP11' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.closure_gamma0GensP11

/-- info: 'SocrateAI.ModularForms.S_not_mem_closure_gensP11' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.S_not_mem_closure_gensP11

/-! ### DRK-12 — the multiplier of `η²·η(11·)²` is trivial on `Γ₀(11)` -/

/-- info: 'SocrateAI.ModularForms.drk12_mult_h_2_5' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_mult_h_2_5

/-- info: 'SocrateAI.ModularForms.drk12_mult_h_3_7' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_mult_h_3_7

/-- info: 'SocrateAI.ModularForms.drk12_mult_h_4_8' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_mult_h_4_8

/-- info: 'SocrateAI.ModularForms.drk12_mult_h_6_9' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_mult_h_6_9

/-- info: 'SocrateAI.ModularForms.etaMultiplierHom_eleven_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierHom_eleven_eq_one

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eleven_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eleven_eq_one

/-! ### DRK-12 — Ligozat's character at level 11, and `DRK-11` at `N = 11`

`exp_etaPhiSum_eq_kroneckerSym_eleven` is `DRK-11`'s exact conclusion at a level OUTSIDE
`DRK-11A`'s `0 < N ≤ 4`.  It does not close `DRK-11`. -/

/-- info: 'SocrateAI.ModularForms.drk12_eleven_not_dvd' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_eleven_not_dvd

/-- info: 'SocrateAI.ModularForms.kroneckerSym_eleven_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.kroneckerSym_eleven_eq_one

/-- info: 'SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_eleven' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaMultiplierVal_eq_kroneckerSym_eleven

/-- info: 'SocrateAI.ModularForms.exp_etaPhiSum_eq_kroneckerSym_eleven' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.exp_etaPhiSum_eq_kroneckerSym_eleven

/-! ### DRK-12 — THE HEADLINE

`ModularForm.etaProductEleven_transform` is FLT's theorem of the same name, statement for
statement, proved here `sorry`-free by an INDEPENDENT route (ATTRIBUTION.md §DRK-12).  FLT's
`CuspForm.exists_gamma0_eleven_apply_eq_eta_sq_mul_eta_sq` is NOT reproduced — cusp vanishing is
`F3.1-OBSTRUCTED`. -/

/-- info: 'SocrateAI.ModularForms.etaQuotientH_eleven_eq' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_eleven_eq

/-- info: 'SocrateAI.ModularForms.ModularForm.etaProductEleven_transform' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.ModularForm.etaProductEleven_transform

/-- info: 'SocrateAI.ModularForms.etaQuotientH_transform_p11' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_transform_p11

/-- info: 'SocrateAI.ModularForms.etaQuotientH_eleven_slash' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotientH_eleven_slash

/-! ### DRK-12 — comparators

`drk12_matches_pin_N11_even_d` makes the generation route reproduce a value fixed OUTSIDE Lean at
a matrix that appears nowhere in its proof.  `drk12_le_four_routeA` / `routeB` are two proofs of
one numeric statement at `N = 4` by routes sharing no step.  No `Eq` between proof terms is
written: that comparator is `rfl` under proof irrelevance and carries no information. -/

/-- info: 'SocrateAI.ModularForms.drk12_matN11_mem' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_matN11_mem

/-- info: 'SocrateAI.ModularForms.drk12_matN11_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_matN11_pos

/-- info: 'SocrateAI.ModularForms.drk12_matches_pin_N11_even_d' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_matches_pin_N11_even_d

/-- info: 'SocrateAI.ModularForms.drk12_pin_N11_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_pin_N11_value

/-- info: 'SocrateAI.ModularForms.drk12_R4_sum' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_R4_sum

/-- info: 'SocrateAI.ModularForms.drk12_R4_congr1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_R4_congr1

/-- info: 'SocrateAI.ModularForms.drk12_R4_congr2' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_R4_congr2

/-- info: 'SocrateAI.ModularForms.drk12_matN4_mem' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_matN4_mem

/-- info: 'SocrateAI.ModularForms.drk12_matN4_pos' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_matN4_pos

/-- info: 'SocrateAI.ModularForms.drk12_le_four_routeB' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_le_four_routeB

/-- info: 'SocrateAI.ModularForms.drk12_le_four_routeA' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.drk12_le_four_routeA

/-! ### DRK-12 — INVERTED TRIPWIRE: the `ligozat_general` route is STILL OPEN

The SAME statement as `ModularForm.etaProductEleven_transform`, derived from `ligozat_general`
instead of from the generation argument.  It PASSES only while `DRK-11` is undischarged.  The
contrast between this footprint and the one above is the whole point: level 11 is closed, ETA-01
is not. -/

/-- info: 'SocrateAI.ModularForms.etaProductEleven_via_ligozat_general' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaProductEleven_via_ligozat_general

end Drk12


/-! ### TDUAL-M0 — the T-duality bridge's sign-discipline gate (run 5)

The four decide-pins of `SocrateAI/StringTheory/TDualityBridge.lean`.  Their values were computed
FIRST from the physics formula `τ ↦ -1/(N·τ)` in exact Gaussian-rational arithmetic and only then
written as Lean statements; the proofs go through `UpperHalfPlane.coe_smul_of_det_pos` fed by FRK-01
(`frickeW_mem_GLPos`), so a drift in `frickeMatrix`, in `frickeW`, or in Mathlib's `num`/`denom`
convention shows up here rather than silently inside `TDUAL-M1`'s general formula. -/

namespace Tdual0Pins

open SocrateAI.StringTheory

/-- info: 'SocrateAI.StringTheory.frickeW_pin_N1_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_pin_N1_i

/-- info: 'SocrateAI.StringTheory.frickeW_pin_N2_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_pin_N2_i

/-- info: 'SocrateAI.StringTheory.frickeW_pin_N4_halfI' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_pin_N4_halfI

/-- info: 'SocrateAI.StringTheory.frickeW_pin_N1_onePlusI' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_pin_N1_onePlusI

/-! #### TDUAL-M1 — the general Fricke formula (run 5, PROVED)

`W_N • τ = -1/(N·τ)` pointwise in `ℂ`, for every `N > 0` and every `τ ∈ ℍ`.  This is the general
statement the four pins above gate; the pins were discharged first, and all four are re-derivable
*from* this lemma (checked, not assumed).  It also composes with the already-proved
`frickeW_sq_smul` through `mul_smul`, so it reduces to `frickeW`'s existing proven behaviour rather
than sitting beside it.

That the proof is not vacuous is certified by `verification/TDualM1NegControl.lean`, which restates
this theorem with four wrong right-hand sides under the identical tactic block and must fail with
exactly four `unsolved goals`. -/

/-- info: 'SocrateAI.StringTheory.frickeW_smul_coe' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_smul_coe

/-! #### TDUAL-M2 — the `GL(2,ℝ)` / `SL(2,ℤ)` instance-agreement hinge (run 5, PROVED)

`mapGL_smul_eq_sl_smul` is closed by `rfl`: Mathlib *defines* `UpperHalfPlane.SLAction` as
`MulAction.compHom ℍ (SpecialLinearGroup.mapGL ℝ)` (MoebiusAction.lean:283-284).  It is therefore
recorded here for exactly what it is — **definitional unfolding with no mathematical content**,
mentioning neither `frickeW` nor `Γ₀(N)`, reducing to Mathlib's definition rather than to anything
of ours.  Its only job is the anti-pun check: FRK-07 is stated on
`(Gamma0 N).map (Matrix.SpecialLinearGroup.mapGL ℝ)` inside `GL(2,ℝ)`, and without this lemma "the
group `W_N` normalizes" and "the group that acts on `ℍ` by GPR's fractional-linear formula" would be
two different Lean objects.  `exists_sl_smul_eq_of_mem_map_Gamma0` is that consequence, made
explicit.  It must not be presented as evidence that the bridge has substance.

Because the proof is `rfl`, no wrong-right-hand-side control on the general statement could certify
anything — the tactic does nothing.  The discrimination evidence is the five pins below, which
evaluate the `GL(2,ℝ)` path and the `SL(2,ℤ)` path **separately** against values computed first in
exact Gaussian-rational arithmetic from `(aτ+b)/(cτ+d)`, with two of the five matrices asserted in
the pin to lie in `Γ₀(2)` so that the gate is exercised inside the bridge's own subgroup:
`γ = 1` at `i` gives `i`; `!![1,1;0,1]` at `i` gives `1+i`; `!![0,-1;1,0]` at `1+i` gives
`(-1+i)/2`; `!![1,0;2,1] ∈ Γ₀(2)` at `i` gives `(2+i)/5`; `!![3,1;2,1] ∈ Γ₀(2)` at `i` gives
`(7+i)/5`.  `verification/TDualM2PinNegControl.lean` restates all five with variant right-hand sides
(transpose, `b`-flip, conjugation) under the identical tactic blocks and must fail with exactly ten
`unsolved goals` errors; it was confirmed to fail before the general lemma was proved. -/

/-- info: 'SocrateAI.StringTheory.mapGL_sl_pin_id_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms mapGL_sl_pin_id_i

/-- info: 'SocrateAI.StringTheory.mapGL_sl_pin_T_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms mapGL_sl_pin_T_i

/-- info: 'SocrateAI.StringTheory.mapGL_sl_pin_S_onePlusI' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms mapGL_sl_pin_S_onePlusI

/-- info: 'SocrateAI.StringTheory.mapGL_sl_pin_G0two_lower_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms mapGL_sl_pin_G0two_lower_i

/-- info: 'SocrateAI.StringTheory.mapGL_sl_pin_G0two_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms mapGL_sl_pin_G0two_i

/-- info: 'SocrateAI.StringTheory.mapGL_smul_eq_sl_smul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms mapGL_smul_eq_sl_smul

/-- info: 'SocrateAI.StringTheory.exists_sl_smul_eq_of_mem_map_Gamma0' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms exists_sl_smul_eq_of_mem_map_Gamma0

/-! #### TDUAL-M3 — the fractional-linear formula (run 5, PROVED)

`sl_smul_coe_eq_flt` says Mathlib's `SL(2,ℤ)`-action on `ℍ` is `(aτ+b)/(cτ+d)` with the entries read
off `γ.1` in the positions `0 0, 0 1, 1 0, 1 1`.  What can silently go wrong in such a statement is
the *entry-position assignment*, not the arithmetic: a transpose, an `a`/`d` swap or a sign on `b`
or `c` is still well-typed, still an equality in `ℂ`, and still true on symmetric matrices.  So the
gate below is five pins on matrices chosen to break those symmetries, each asserting the Mathlib
action value and the `TDUAL-M3` right-hand side *separately* against one value computed first in
exact Gaussian-rational arithmetic:

| pin | `γ` | `τ` | value |
| --- | --- | --- | --- |
| `sl_flt_pin_2111_i`    | `!![2,1;1,1]`  | `i`  | `(3+i)/2`    |
| `sl_flt_pin_Tsq_i`     | `!![1,2;0,1]`  | `i`  | `2+i`        |
| `sl_flt_pin_L3_i`      | `!![1,0;3,1]`  | `i`  | `(3+i)/10`   |
| `sl_flt_pin_G5_i`      | `!![7,2;10,3]` | `i`  | `(76+i)/109` |
| `sl_flt_pin_negB_twoI` | `!![1,-1;1,0]` | `2i` | `(2+i)/2`    |

Each pin is blind to exactly one variant and the blindness is recorded in `TDualityBridge.lean`
rather than glossed: `2111` cannot see a transpose (`b = c`), `Tsq` cannot see a `c`-flip or an
`a`/`d` swap, `L3` cannot see a `b`-flip or an `a`/`d` swap.  `G5` — the only pin with four nonzero
pairwise-distinct entries, and a member of `Γ₀(5)` — catches all five variants, including the
inverted action convention that the `TDUAL-M0` gate provably cannot see.
`verification/TDualM3PinNegControl.lean` restates all five with the variant right-hand sides under
identical tactic blocks and must fail with exactly ten `error:` lines; it was confirmed to fail
**before** `sl_smul_coe_eq_flt` was proved. -/

/-- info: 'SocrateAI.StringTheory.sl_flt_pin_2111_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sl_flt_pin_2111_i

/-- info: 'SocrateAI.StringTheory.sl_flt_pin_Tsq_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sl_flt_pin_Tsq_i

/-- info: 'SocrateAI.StringTheory.sl_flt_pin_L3_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sl_flt_pin_L3_i

/-- info: 'SocrateAI.StringTheory.sl_flt_pin_G5_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sl_flt_pin_G5_i

/-- info: 'SocrateAI.StringTheory.sl_flt_pin_negB_twoI' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sl_flt_pin_negB_twoI

/-- info: 'SocrateAI.StringTheory.sl_smul_coe_eq_flt' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sl_smul_coe_eq_flt

/-! #### TDUAL-M4 — the duality squares to the identity on the moduli (run 10, PROVED)

`frickeW_smul_involutive : frickeW hN • frickeW hN • τ = τ`.  Recorded for exactly what it is:
**the already-proved ℍ-level lemma `frickeW_sq_smul` (`FrickeComposite.lean`) re-associated by
Mathlib's `mul_smul`**, which is a `MulAction` field.  There is no new mathematics in this node.
The matrix→ℍ upgrade — the step that consumes `W_N² = -N·I` (FRK-02) together with
`det (W_N²) = N² > 0` and `denom (W_N²) = -N` — happened in `FrickeComposite.lean`; FRK-02 enters
here only transitively.  This is the same situation as `TDUAL-M2`'s `rfl`, and is not to be
presented as a new involution theorem.

Consequently a wrong-right-hand-side control on the general statement certifies nothing: the proof
is `exact` of an existing lemma, so the tactic does no work.  The discrimination evidence is the
five two-step pins below, each stated as a *pair* — the intermediate `W_N • τ` and the round trip
`W_N • W_N • τ` — at points chosen so that `W_N • τ ≠ τ`, which is what `TDUAL-M0`'s self-dual
point `W₁ • i = i` and fixed point `W₄ • (i/2) = i/2` cannot test.  Values computed first in exact
Gaussian-rational arithmetic: `N=2` at `i` gives `i/2` then `i`; `N=3` at `2i` gives `i/6` then
`2i`; `N=1` at `1+i` gives `(-1+i)/2` then `1+i`; `N=2` at `1+i` gives `(-1+i)/4` then `1+i`;
`N=4` at `i` gives `i/4` then `i`.  The pins run through `frickeW_smul_coe` (TDUAL-M1) applied once
and twice — a route independent of `frickeW_sq_smul`'s product-matrix computation, so the two
agree by computation rather than by construction.
`verification/TDualM4PinNegControl.lean` restates all ten components with wrong values (dropped
factor of `N` or flipped `b`-entry on the intermediates, the *idempotent* variant
`W_N • W_N • τ = W_N • τ` on the round trips) under identical tactic blocks and must fail with
exactly ten `error:` lines; it was confirmed failing **before** `frickeW_smul_involutive` was
discharged. -/

/-- info: 'SocrateAI.StringTheory.frickeW_invol_pin_N2_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_invol_pin_N2_i

/-- info: 'SocrateAI.StringTheory.frickeW_invol_pin_N3_twoI' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_invol_pin_N3_twoI

/-- info: 'SocrateAI.StringTheory.frickeW_invol_pin_N1_onePlusI' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_invol_pin_N1_onePlusI

/-- info: 'SocrateAI.StringTheory.frickeW_invol_pin_N2_onePlusI' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_invol_pin_N2_onePlusI

/-- info: 'SocrateAI.StringTheory.frickeW_invol_pin_N4_i' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_invol_pin_N4_i

/-- info: 'SocrateAI.StringTheory.frickeW_smul_involutive' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeW_smul_involutive

/-! #### INVERTED TRIPWIRE: TDUAL-01 is STILL OPEN

This guard PASSES only while the bridge is undischarged.  The contrast with the five clean
footprints above is the point: the gate is closed and the general formula is proved, but the bridge
is not.  `TDUAL-01` must not be closed before the `SL(2,ℤ)_τ` vs `SL(2,ℤ)_ρ` attribution question
recorded in `TDualityBridge.lean`'s Status section is settled from GPR §2.4, and before the absence
of any verified literature anchor for a T-duality element acting as the level-`N` Fricke map at
`N > 1` is either supplied or stated plainly as a mathematical generalisation with no claimed
physical counterpart. -/

/-- info: 'SocrateAI.StringTheory.tduality_tau_fricke_bridge' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms tduality_tau_fricke_bridge

end Tdual0Pins


/-! ### `SDF-DEF-01` — the Fricke-self-dual (Fricke-symmetric) condition on an exponent vector

`IsFrickeSelfDual N r : Prop := ∀ δ ∈ N.divisors, r δ = r (N / δ)`
(`SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`).  This is the condition under which the
DUAL exponent vector `δ ↦ r (N / δ)` on the right-hand side of the already-proved
`etaQuotient_fricke` (`EtaQuotientModularity.lean`, tag `F3.2-A7`) agrees with `r` on `N.divisors`.

NAMING, and the reason it is worth a line here: this condition is **never** called `balanced` in
this library.  That word is already taken, in `EtaQuotientModularity.lean`, by the unrelated
`Int.bmod` lemma `exists_balanced_add` (`F3.2-B1`) — and it is *also* the term Persson–Volpato use
for this same condition, so it collides twice.  `self-dual` / `Fricke-symmetric` throughout.

The six condition pins below were computed OUTSIDE Lean first (exact integer arithmetic:
`divisors 1 = [1]`, `divisors 2 = [1,2]`, `divisors 6 = [1,2,3,6]`, with each vector printed
alongside its dual) and only then asserted.  `selfDual_cond_pin_level_six` is the load-bearing one
— the only pin with `N > 1` AND a non-constant exponent vector (`rPinSix_nonconstant` is the
machine-checked witness of the non-constancy), hence the only one a wrong `δ ↔ N/δ` pairing could
fail.  `selfDual_cond_pin_level_one` and `selfDual_cond_pin_zero_exp` are degenerate by
construction (at `N = 1` every `r` is self-dual; `r ≡ 0` is self-dual at every `N`) and are guarded
as floors, not as evidence about the involution.

All are discharged by `decide` (or `rfl` under the binder), so no `Lean.ofReduceBool` may appear
below; `native_decide` is deliberately not used, matching `DedekindSum.lean`'s convention.

TWO FOOTPRINTS THAT ARE NOT WHAT THEY LOOK LIKE, recorded because this gate caught both when they
were first written the other way round.  `rPinSix_nonconstant` depends on NO axioms: it is an
inequality of two integers and never touches `Finset`.  `selfDual_cond_pin_zero_exp` DOES carry
`[propext, Classical.choice, Quot.sound]` even though its proof is `fun _ _ => rfl` — the axioms
come from `Nat.divisors` in its STATEMENT, not from its proof.  `#print axioms` reports the
footprint of the whole declaration, statement included; reading a clean footprint as evidence about
a proof alone is the misreading these two lines exist to block.

SCOPE: nothing in this section, or in `EtaQuotientFrickeSelfDual.lean`, formalises any physics.
Persson–Volpato (arXiv:1504.07260) is cited in that file's module docstring as the ORIGIN of the
question only, at the literature (L) tier; their CHL / axio-dilaton S-duality claim is NOT a Lean
statement anywhere in this library and must never be reported as one. -/

namespace SdfDef01

open SocrateAI.ModularForms

/-- info: 'SocrateAI.ModularForms.IsFrickeSelfDual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms IsFrickeSelfDual

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_one

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_six

/-- info: 'SocrateAI.ModularForms.rPinSix_nonconstant' does not depend on any axioms -/
#guard_msgs in #print axioms rPinSix_nonconstant

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_zero_exp

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_two_weight_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_two_weight_one

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_one_weight_two' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_one_weight_two

/-! #### The negative control — `IsFrickeSelfDual` is a genuine restriction

`r = (2, 0)` at `N = 2`: the vector reads `[2, 0]` on `[1, 2]` while its dual reads `[0, 2]`.  This
is the SAME exponent vector as `fricke_dual_pin` (`EtaQuotientModularity.lean`, sorry-free), where
`f(z) = η(z)²` and its Fricke dual `f*(z) = η(2z)²` are shown to be genuinely different functions.
Without this guard, every `SDF-*` statement could be vacuous on a mis-stated predicate — one
quantified over `δ ∈ ∅`, or one that had collapsed to `r δ = r δ`. -/

/-- info: 'SocrateAI.ModularForms.not_selfDual_pin_asymmetric' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms not_selfDual_pin_asymmetric

/-! #### The MIS-PAIRING control — the divisor involution is the right one

`r = (1, 11, 1, 11)` on `(1, 2, 3, 6)` carries the SAME weight normalisation as
`selfDual_cond_pin_level_six`'s vector (`∑ r δ = 24`) and IS invariant under the WRONG involution
`1 ↔ 3`, `2 ↔ 6` — but not under `δ ↦ 6/δ`, under which it reads `[1, 11, 1, 11]` against a dual
`[11, 1, 11, 1]`.  A definition that had transposed the divisor pairing would satisfy every
positive pin above and would prove this statement's NEGATION, so this guard and
`selfDual_cond_pin_level_six` bracket the pairing from both sides. -/

/-- info: 'SocrateAI.ModularForms.not_selfDual_pin_mispaired' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms not_selfDual_pin_mispaired

/-! #### RECEIPT: the two INVERTED TRIPWIRES that used to live here are GONE

This slot held, in turn, an inverted tripwire asserting that `etaQuotient_fricke_selfDual_raw`
depends on `sorryAx` and one asserting the same of `etaQuotient_fricke_selfDual`.  Each PASSED only
while its node was open, so "the statement landed, the proof did not" was machine-checked rather
than asserted.  BOTH HAVE NOW BEEN INVERTED BACK, each in the same commit that discharged its node:
`SDF-04` one run earlier, `SDF-05` this run.  Their real guards live in sections `Sdf04` and `Sdf05`
below, alongside those nodes' pins.

This paragraph is the receipt, kept so the removals are visible rather than silent — a green build
with a stale tripwire, or with a tripwire quietly deleted instead of inverted, is the LL-2 failure
mode this file exists to prevent.  No `SDF-*` node carries an inverted tripwire any more: `SDF-07`
onward are open and simply have no guards, which is the correct state for an open node.  `SDF-06`
never held one: its statement was pinned and its proof landed in the same run, so there was no
interval during which "the statement is here, the proof is not" needed asserting. -/

end SdfDef01

/-! ## `SDF-DEF-02` — the closed-form Fricke eigenvalue `λ = i^{-k} · N^{k/2}`

`frickeEigenvalue N k := i^{-k} · √(N^k)` is the constant that `etaQuotient_fricke`'s
`N^k · s^{-1/2}` collapses to once the exponent vector is Fricke-self-dual, `s = ∏_{δ ∣ N} δ^{r δ}`
having been forced to `N^k` by `prod_zpow_selfDual` (`SDF-02`).  The exponent vector has
disappeared: the eigenvalue depends only on the LEVEL and the WEIGHT.

WHAT THE GUARDS BUY.  A definition cannot be false, so the axiom footprint of `frickeEigenvalue`
itself certifies only that it elaborates.  The content is in the VALUE pins: six concrete
`(N, k)` instances whose numbers were computed by hand before being written as Lean statements,
and three negative controls.  Until this section existed, the only Lean statements asserting any
value of `frickeEigenvalue` were the five `SDF-05` pins (`selfDual_pin_level_one` and friends),
every one of which is still `sorry` — so the closed form had NO machine-checked evidence behind
it at all, only the hand arithmetic in its docstring.  These guards are that evidence.

WHY THE PINS ARE STATED ON THE EIGENVALUE ALONE.  No eta quotient, no exponent vector and no
`IsFrickeSelfDual` hypothesis appears in any of them.  That keeps `SDF-DEF-02` independent of the
still-open `SDF-05`: a pin that carried the eigenform relation as a conjunct would be `sorry` for
reasons having nothing to do with the eigenvalue, which is exactly the situation this section
replaces.  The cost is that these pins say nothing about whether the closed form IS the Fricke
eigenvalue — that is `SDF-03` (`fricke_const_selfDual`, closed, guarded below) plus `SDF-05`
(still open), and must not be read off this section.

THE REGIMES COVERED, and why each is needed:
* `N = 1`, `k = 12` → `1`.  The instance underlying the sorry-free `eta_S_via_fricke`
  (`EtaQuotientModularity.lean:2246`), where `η(-1/z)²⁴ = z¹² η(z)²⁴` carries no constant.  The
  closed form must reproduce the constant this library already proves, and `1` is it.
* `N = 6`, `k = 12` → `46656 = 6⁶`.  THE LOAD-BEARING PIN: a genuine `N > 1` level, and the same
  instance at which `prod_zpow_pin_level_six_value` (sorry-free) pins the product to
  `2176782336 = 6¹²` and `fricke_const_pin_level_six` (sorry-free) pins the constant to `46656`.
  `SDF-DEF-02` and `SDF-03` are independent nodes that land on the same number here.
* `k = 0` → `1`.  Degenerate by construction — both factors die at once.  A floor, not evidence.
* `N = 2`, `k = 1` → `-(i·√2)`.  ODD weight: the only value that leaves `ℝ`.  Catches `i^{k}`
  written for `i^{-k}` (which would give `+i·√2`) and a dropped root of unity (`√2`).
* `N = 1`, `k = 2` → `-1`.  The SIGN pin.  It was the only machine-checked witness in this library
  that the eigenvalue is ever `-1` until `SDF-13` closed, adding `(1, -2)`
  (`frickeEigenvalue_pin_level_one_weight_neg_two`); `SDF-09` and `SDF-13`, which characterise that
  case, are now both CLOSED, and this line called them open until then.
* `N = 6`, `k = -12` → `1/46656`.  NEGATIVE weight, proper-fraction radicand.  A closed form that
  had assumed `k ≥ 0` — a `k.toNat`, or `pow_pos` for `zpow_pos` — is FALSE here.

THE NEGATIVE CONTROLS, which the positive pins cannot supply on their own.
`frickeEigenvalue_pin_not_natPow`: at `N = 6`, `k = 12` the eigenvalue is `46656 = 6⁶`, NOT
`2176782336 = 6¹²` — so a definition reading the exponent as `k` rather than `k/2`, i.e. one that
dropped the square root, is refuted.  `frickeEigenvalue_pin_not_one`: at `N = 1`, `k = 2` the
modulus is `1`, so a definition that dropped `i^{-k}` entirely would give `1`; the true value is
`-1`.  Note PIN A cannot play this role — its value IS `1`, which a dropped factor also produces.
`frickeEigenvalue_pin_nonconstant`: `46656 ≠ 1` at equal weight and different level, so the
eigenvalue genuinely varies with `N` and has not collapsed to something trivial.

BRANCH DISCIPLINE.  The square root is `Real.sqrt` of the positive real `N^k`, so no complex
square root and no branch choice enters the eigenvalue — in contrast to `etaQuotient_fricke`'s own
proof, which uses `Complex.sqrt` internally.  Had `SDF-DEF-02` been written with `Complex.sqrt`
the value at every pin here would have been branch-dependent; it is not.

JUNK AT `N = 0`, recorded so it is never mistaken for a claim: `(0 : ℝ)^k` is `0` for `k ≠ 0` in
Mathlib's `zpow`, so `frickeEigenvalue 0 k = 0` for every `k ≠ 0`.  Harmless — every downstream
statement carries `hN : 0 < N` — but the definition must not be read as meaningful at `N = 0`.

SCOPE: nothing here formalises any physics.  `frickeEigenvalue` is a complex number attached to a
level and a weight.  Persson–Volpato's CHL / axio-dilaton S-duality claim (arXiv:1504.07260) is
cited in the module docstring at the literature (L) tier only, is NOT a Lean statement anywhere in
this library, and must never be reported as one. -/

namespace SdfDef02

open SocrateAI.ModularForms

/-! #### The definition itself — it elaborates -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue

/-! #### The `i`-power lemmas the pins rest on, at INTEGER exponents -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_two

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_one

/-! #### The six value pins -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_six

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_zero_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_zero_weight

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_two_weight_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_two_weight_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_neg_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_six_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_six_neg

/-! #### The negative controls — what the closed form is NOT -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_not_natPow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_not_natPow

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_not_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_not_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_nonconstant' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_nonconstant

end SdfDef02

/-! ## `SDF-01` — the `ℂ`-domain exponent-vector congruence for `etaQuotient`

`SDF-01` is the ADAPTER the rest of the `SDF-*` block needs and did not have: `etaQuotient_fricke`
(`EtaQuotientModularity.lean:2212`, sorry-free) is stated on `ℂ`, while the only congruence lemma
that existed, `etaQuotientH_congr`, is stated on the bundled `τ : ℍ`.  Whole-library grep this
session confirms no `ℂ`-domain version existed anywhere in `Lean/`.

WHAT THE PINS BUY.  `SDF-01` itself is a `Finset.prod_congr`, so it cannot really be "wrong" in
its proof — it can only be wrong in its STATEMENT, and specifically in whether its hypothesis is
the one its consumer can actually discharge.  The pins below therefore fix the hypothesis at the
exact instantiation `SDF-04` uses (`r := fun d => r (N / d)`, `s := r`), across the three regimes
this run's discipline names, plus two negative controls and one orientation bridge.

NAMING: the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced" — that
word is already taken in `EtaQuotientModularity.lean` by the unrelated `Int.bmod` lemma
`exists_balanced_add` (`F3.2-B1`).

PHYSICS SCOPE: nothing guarded here formalises any physics.  Every declaration below is a
statement about `∏_{δ ∣ N} η(δz)^{r δ}` and about `Nat.divisors`, and nothing else.

All pins are discharged by `decide` (never `native_decide`), so no `Lean.ofReduceBool` enters the
footprint; the two structural ones close by `rfl` under the binder and by `.symm`. -/

namespace Sdf01

open SocrateAI.ModularForms

/-! #### The three regimes: level one (`k = 12`), a genuine `N > 1` non-constant vector, `r ≡ 0` -/

/-- info: 'SocrateAI.ModularForms.dualExp_congr_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dualExp_congr_pin_level_one

/-- info: 'SocrateAI.ModularForms.dualExp_congr_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dualExp_congr_pin_level_six

/-- info: 'SocrateAI.ModularForms.dualExp_congr_pin_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dualExp_congr_pin_zero_exp

/-- info: 'SocrateAI.ModularForms.dualExp_congr_pin_level_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dualExp_congr_pin_level_two

/-! #### Negative controls — the hypothesis of `SDF-01` is a genuine restriction

Without these, `SDF-01` could be read as applying to the dual vector of an ARBITRARY `r`, which
would make `SDF-04`'s appeal to self-duality vacuous.  `not_dualExp_congr_pin_asymmetric` uses the
SAME exponent vector `r = (2, 0)` at `N = 2` as `fricke_dual_pin` (sorry-free), where `η(z)²` and
its Fricke dual `η(2z)²` are shown to be genuinely different functions — so at that vector the
CONCLUSION of `SDF-01` fails too, not merely its hypothesis.  `not_dualExp_congr_pin_mispaired`
carries the same weight normalisation as the load-bearing pin and is invariant under the WRONG
involution `1 ↔ 3`, `2 ↔ 6`, so a transposed divisor pairing would prove its negation while
satisfying every positive pin above. -/

/-- info: 'SocrateAI.ModularForms.not_dualExp_congr_pin_asymmetric' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms not_dualExp_congr_pin_asymmetric

/-- info: 'SocrateAI.ModularForms.not_dualExp_congr_pin_mispaired' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms not_dualExp_congr_pin_mispaired

/-! #### The orientation bridge and the application check

`IsFrickeSelfDual` reads `r δ = r (N / δ)`; `SDF-01` instantiated as `SDF-04` needs it requires
`r (N / δ) = r δ`.  The two differ by a `.symm`, and that flip is the one place a downstream proof
could silently need something that does not exist.  `dualExp_congr_pin_level_six_of_selfDual`
discharges the load-bearing pin's obligation FROM the sorry-free `selfDual_cond_pin_level_six`
through exactly that bridge, and `etaQuotient_congr_divisors_pin_level_six` then runs the whole
path to the collapsed quotient — so the step `SDF-04` is claimed to be one `rw` away from is
machine-checked here rather than assumed. -/

/-- info: 'SocrateAI.ModularForms.dualExp_congr_pin_level_six_of_selfDual' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms dualExp_congr_pin_level_six_of_selfDual

/-! #### `SDF-01` itself, and the application check that it fires -/

/-- info: 'SocrateAI.ModularForms.etaQuotient_congr_divisors' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotient_congr_divisors

/-- info: 'SocrateAI.ModularForms.etaQuotient_congr_divisors_pin_level_six' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms etaQuotient_congr_divisors_pin_level_six

end Sdf01

/-! ## `SDF-02` — the Fricke constant collapses: `∏_{δ ∣ N} δ^{r δ} = N^k` on self-dual `r`

`prod_zpow_selfDual` (`EtaQuotientFrickeSelfDual.lean`) is the one genuinely arithmetic step of the
`SDF-*` block, and it lives entirely inside `ℝ` — no complex square root and no branch choice is
anywhere near it.  Route: `sqrt_prod_dual` (`EtaQuotientModularity.lean:2409`, sorry-free, tag
`F3.2-A7`) gives `√s* = N^k · (√s)⁻¹` with `s = ∏_δ δ^{r δ}` and `s* = ∏_δ δ^{r (N/δ)}`;
self-duality collapses `s*` onto `s` factor by factor on the SAME index set (`Finset.prod_congr`,
no divisor reindexing); `s > 0` (`Finset.prod_pos` with `zpow_pos`) then turns `√s · √s = N^k` into
`s = N^k` via `Real.mul_self_sqrt`.

WHY THE HYPOTHESIS IS LOAD-BEARING, machine-checked below: `prod_zpow_pin_asymmetric_ne` exhibits
`r = (2, 0)` at `N = 2` which satisfies the WEIGHT hypothesis exactly (`rPinAsym_weight`:
`∑ r δ = 2 = 2·1`) and yet has `∏ δ^{r δ} = 1 ≠ 2 = N^k`.  So the `hr`-free version of `SDF-02` is
FALSE, and this is a counterexample to it — the self-duality hypothesis cannot be dropped or
weakened to the weight condition alone.  `prod_zpow_pin_mispaired_ne` brackets the divisor
involution from the other side: that vector carries the same weight normalisation as the
load-bearing pin and is invariant under the WRONG pairing `1 ↔ 3`, `2 ↔ 6`.

The pins here are stated on the PRODUCT ALONE, with no `frickeEigenvalue` conjunct — deliberately,
since the eigenvalue belongs to `SDF-DEF-02`, a different and still-open node.  That is why they
close while the `selfDual_pin_*` conjunctions in the same file do not.

NAMING: the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced" — that
word is already taken in `EtaQuotientModularity.lean` by the unrelated `Int.bmod` lemma
`exists_balanced_add` (`F3.2-B1`).

PHYSICS SCOPE: nothing guarded here formalises any physics.  Every declaration below is a statement
about a product of real powers of divisors, and nothing else.

The concrete pins are discharged by `decide` (for `Nat.divisors`) and `norm_num` (for the real
arithmetic), never `native_decide`, so no `Lean.ofReduceBool` enters the footprint. -/

namespace Sdf02

open SocrateAI.ModularForms

/-! #### The three regimes: level one (`k = 12`), a genuine `N > 1` non-constant vector, `r ≡ 0` -/

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_one

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_six_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_six_value

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_six

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_zero_exp

/-! #### Two regimes the three above cannot reach

`prod_zpow_pin_level_two` is the smallest non-degenerate instance and matches the `(√2)⁻¹` already
pinned upstream by the sorry-free `fricke_level_two_pin`.  `prod_zpow_pin_level_four_neg` is the
only pin with NEGATIVE exponents — `1⁻² · 2⁶ · 4⁻² = 64/16 = 4 = 4¹` — hence the only one that
exercises the `zpow_pos` positivity step; without it, a version of `SDF-02` restricted to
non-negative exponent vectors would satisfy every other pin here.  Level four also contributes the
only `N > 1` divisor that is its own dual (`4 / 2 = 2`). -/

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_two

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_four_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_four_neg

/-- info: 'SocrateAI.ModularForms.rPinLevelFourNeg_selfDual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourNeg_selfDual

/-- info: 'SocrateAI.ModularForms.rPinLevelFourNeg_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourNeg_weight

/-! #### Negative controls — `IsFrickeSelfDual` cannot be dropped from `SDF-02` -/

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_asymmetric_ne' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_asymmetric_ne

/-- info: 'SocrateAI.ModularForms.rPinAsym_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinAsym_weight

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_mispaired_ne' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_mispaired_ne

/-! #### `SDF-02` itself, and the application check that it reproduces the load-bearing pin

`prod_zpow_selfDual_pin_level_six` re-derives `2176782336` by RUNNING the general lemma at
`(N, r, k) = (6, rPinSix, 12)`, where `prod_zpow_pin_level_six_value` asserts the same number by
direct computation.  A general statement that had drifted — a wrong exponent, `N^{k/2}` for `N^k`,
the dual product for the original — would produce a different number here while staying provable in
its own terms. -/

/-- info: 'SocrateAI.ModularForms.prod_zpow_selfDual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_selfDual

/-- info: 'SocrateAI.ModularForms.prod_zpow_selfDual_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_selfDual_pin_level_six

end Sdf02

/-! ## `SDF-03` — the constant of `etaQuotient_fricke` in closed form

`SDF-03` collapses the constant `N^k · s^{-1/2}` of `etaQuotient_fricke` (`s = ∏_{δ ∣ N} δ^{r δ}`)
to the single real square root `√(N^k) = N^{k/2}` on a Fricke-self-dual exponent vector.  Resolved
by `SocrateAI.ModularForms.fricke_const_selfDual`
(`SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`).

WHAT THE GUARDS BUY.  The proof is short — `SDF-02` (`prod_zpow_selfDual`) does the arithmetic, and
what remains is `a · (√a)⁻¹ = √a` at the positive real `a = N^k`, proved in `ℝ` and only then cast
into `ℂ`.  So the risk is entirely in the STATEMENT, not the proof, and the pins below are what
constrain it: each fixes a concrete `(N, r, k)` and matches BOTH sides separately against a numeral
computed outside Lean first (exact rational arithmetic).

`fricke_const_pin_level_six` is the load-bearing one — the only pin with `N > 1` and a non-constant
exponent vector, where `√(N^k) = 46656` and `N^k = 2176782336` are different numbers.
`fricke_const_pin_level_six_neg` is the only pin with `k < 0`, where `N^k` and `√(N^k)` are proper
fractions; a statement that had silently assumed `k ≥ 0` (`k.toNat`, or `pow_pos` for `zpow_pos`)
would satisfy every other pin and fail there.  `fricke_const_pin_level_one` and
`fricke_const_pin_zero_exp` are DEGENERATE BY CONSTRUCTION (both sides are `1`) and are guarded as
floors, not as evidence about exponents.

NEGATIVE CONTROLS.  `fricke_const_pin_not_natPow` shows the square root cannot be dropped
(`√(6¹²) ≠ 6¹²`) and `fricke_const_pin_not_mul` shows the inversion cannot be dropped
(`6¹² · √s ≠ √(6¹²)`); both fail exactly at the load-bearing instance and are invisible at the
degenerate ones, which is why the degenerate pins are not sufficient on their own.

APPLICATION CHECKS.  `fricke_const_selfDual_pin_level_six` and
`fricke_const_selfDual_pin_level_six_neg` re-derive `46656` and `1/46656` by RUNNING the general
lemma at those instances, i.e. through the general proof rather than around it, so a general
statement that had drifted would return a different number while staying provable in its own terms.

NAMING: the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced" — that
word is already taken in `EtaQuotientModularity.lean` by the unrelated `Int.bmod` lemma
`exists_balanced_add` (`F3.2-B1`).

PHYSICS SCOPE: nothing guarded here formalises any physics.  Every declaration below is an identity
between real and complex numbers attached to an eta-quotient exponent vector.  No S-duality, no
axio-dilaton, no CHL content is asserted anywhere in this section or in the file it guards. -/

namespace Sdf03

/-! #### The square-root values the pins are stated against -/

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_six

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_four

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_six_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_six_neg

/-! #### The `SDF-03` pins -/

/-- info: 'SocrateAI.ModularForms.fricke_const_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_pin_level_one

/-- info: 'SocrateAI.ModularForms.fricke_const_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_pin_level_six

/-- info: 'SocrateAI.ModularForms.fricke_const_pin_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_pin_zero_exp

/-- info: 'SocrateAI.ModularForms.fricke_const_pin_level_four_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_pin_level_four_neg

/-! #### The negative-weight pin, and that its vector really satisfies the hypotheses -/

/-- info: 'SocrateAI.ModularForms.rPinLevelSixNeg_selfDual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelSixNeg_selfDual

/-- info: 'SocrateAI.ModularForms.rPinLevelSixNeg_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelSixNeg_weight

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_six_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_six_neg

/-- info: 'SocrateAI.ModularForms.fricke_const_pin_level_six_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_pin_level_six_neg

/-! #### Negative controls — the square root and the inversion are both load-bearing -/

/-- info: 'SocrateAI.ModularForms.fricke_const_pin_not_natPow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_pin_not_natPow

/-- info: 'SocrateAI.ModularForms.fricke_const_pin_not_mul' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_pin_not_mul

/-! #### `SDF-03` itself, and the application checks that it reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.fricke_const_selfDual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_selfDual

/-- info: 'SocrateAI.ModularForms.fricke_const_selfDual_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_selfDual_pin_level_six

/-- info: 'SocrateAI.ModularForms.fricke_const_selfDual_pin_level_six_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms fricke_const_selfDual_pin_level_six_neg

end Sdf03


/-! ## `SDF-04` — the eigenform relation, raw shape

`SDF-04` specialises `etaQuotient_fricke` (`EtaQuotientModularity.lean:2212`, sorry-free) to a
Fricke-self-dual exponent vector.  On such an `r` the DUAL quotient
`etaQuotient N (fun δ => r (N / δ)) z` sitting on the right of that theorem collapses to the
original `etaQuotient N r z`, so the transformation law becomes a genuine eigenform relation:
the Fricke transform of the quotient is a scalar times `z^k` times the quotient ITSELF.  Resolved
by `SocrateAI.ModularForms.etaQuotient_fricke_selfDual_raw`
(`SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`).

WHAT IS AND IS NOT CLAIMED HERE.  The constant is left EXACTLY as `etaQuotient_fricke` writes it,
`i^{-k} · N^k · s^{-1/2}` with `s = ∏_{δ ∣ N} δ^{r δ}` and with `r`, not the dual vector, inside.
Nothing about the constant is asserted by this node; collapsing it to `√(N^k) = N^{k/2}` is `SDF-03`
and `SDF-05`, which are separate nodes with separate guards.  Keeping the two apart is deliberate —
"collapse the quotient" (trivial, uses only `SDF-01`) must never be conflated with "collapse the
constant" (needs the arithmetic of `SDF-02`).

RELATIVE TO THE REFERENCE, `SDF-04` is strictly a SPECIALISATION: it ADDS the hypothesis
`IsFrickeSelfDual N r` to `etaQuotient_fricke` and changes nothing else except the final factor.
It is never a strengthening of the reference, and it is not the reference with a decorative
hypothesis bolted on either — `not_selfDual_pin_asymmetric` (guarded in section `SdfDef01`)
`decide`-proves that `r = (2, 0)` at `N = 2` FAILS the hypothesis, and `fricke_dual_pin`
(`EtaQuotientModularity.lean`, sorry-free) proves that the Fricke transform there lands on `η(2z)²`,
the quotient of the DUAL vector `(0, 2)`, not on `η(z)²`.  Stated precisely so it is not oversold:
what is machine-proved is that the two exponent vectors differ and that the transform lands on the
dual one; that `η(z)²` and `η(2z)²` are different FUNCTIONS is true and recorded in that pin's
docstring but is not itself a theorem here, so "the conclusion is false at that `r`" is a
hand-checked claim, not a Lean one.

WHAT THE GUARDS BUY.  The proof is two rewrites, so the risk is in the statement and in whether the
first rewrite really leaves nothing but the collapse.  The four instance pins below are what
constrain that: unlike every earlier pin set in this file they are stated as instances of `SDF-04`'s
OWN EQUATION at concrete `(N, r, k)`, discharged along the same two-rewrite route, and NONE of them
invokes `etaQuotient_fricke_selfDual_raw` — they are declared ABOVE it in the same module, so Lean's
scoping makes referring to it impossible and the compiler, not this comment, enforces that.  They
are therefore evidence about the route rather than consequences of it.  Each closes with the two
rewrites alone, which machine-checks that there is no residual goal and no side condition.

`selfDual_raw_pin_level_six` is the load-bearing one: the only instance with `N > 1` AND a
non-constant exponent vector, hence the only one where the dual quotient is a genuinely reordered
product rather than a syntactic no-op.  `selfDual_raw_pin_level_four_neg` is the only one with
NEGATIVE exponents, and the only level here with a divisor that is its own dual (`4 / 2 = 2`), a
fixed point of `δ ↦ N/δ`.  `selfDual_raw_pin_level_one` and `selfDual_raw_pin_zero_exp` are
DEGENERATE BY CONSTRUCTION and are guarded as floors, not as evidence about the involution.

THE EXTERNAL CROSS-CHECK.  `selfDual_raw_pin_level_one_is_eta_S` carries the level-one instance all
the way down to `η(-1/z)²⁴ = z¹² η(z)²⁴` — which is `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`, sorry-free, itself checked there against MATHLIB's
`discriminant_S_invariant`).  It DERIVES that conclusion from the pin and names neither existing
derivation of it.  Both are in scope there, so absence from the source text is not enough on its
own; what closes the gap is that every tactic in that proof except `norm_num` takes an EXPLICIT
lemma list and neither target carries `@[simp]` (checked this run against this library and against
the pinned Mathlib), so `norm_num`'s default set cannot reach them either.  It is therefore an
agreement between two independent routes.  It is a FLOOR, not a discriminating test: at `N = 1`,
`k = 12` it pins NO component of `λ` — `selfDual_pin_level_one_no_evidence_*` proves all four.

NAMING: the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced" — that
word is already taken in `EtaQuotientModularity.lean` by the unrelated `Int.bmod` lemma
`exists_balanced_add` (`F3.2-B1`).

All weight witnesses are discharged by `decide` (never `native_decide`), so no `Lean.ofReduceBool`
enters the footprint.

PHYSICS SCOPE.  Nothing guarded here formalises any physics.  `SDF-04` is an identity between two
explicit products of values of Mathlib's `ModularForm.eta`; it says nothing about `Γ₀(N)`-modularity,
nothing about holomorphy at the cusps, and nothing about S-duality, the axio-dilaton or CHL models.
Persson–Volpato (arXiv:1504.07260) is cited in the guarded file's docstring as the ORIGIN of the
question only, at the literature (L) tier; their physics claim is NOT a Lean statement anywhere in
this library and must never be reported as one. -/

namespace Sdf04

open SocrateAI.ModularForms

/-! #### The weight witnesses the pins are stated against -/

/-- info: 'SocrateAI.ModularForms.rPinOne_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinOne_weight

/-- info: 'SocrateAI.ModularForms.rPinSix_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinSix_weight

/-- info: 'SocrateAI.ModularForms.zeroExp_weight_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms zeroExp_weight_level_six

/-! #### The `SDF-04` instance pins — `SDF-04`'s own equation at concrete `(N, r, k)` -/

/-- info: 'SocrateAI.ModularForms.selfDual_raw_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_raw_pin_level_one

/-- info: 'SocrateAI.ModularForms.selfDual_raw_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_raw_pin_level_six

/-- info: 'SocrateAI.ModularForms.selfDual_raw_pin_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_raw_pin_zero_exp

/-- info: 'SocrateAI.ModularForms.selfDual_raw_pin_level_four_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_raw_pin_level_four_neg

/-! #### The external cross-check against `eta_S_via_fricke` / `discriminant_S_invariant` -/

/-- info: 'SocrateAI.ModularForms.selfDual_raw_pin_level_one_is_eta_S' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_raw_pin_level_one_is_eta_S

/-! #### `SDF-04` itself -/

/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual_raw' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotient_fricke_selfDual_raw

end Sdf04

/-! ## `SDF-05` — the eigenform relation with the eigenvalue in CLOSED FORM

`SDF-05` is the headline of `EtaQuotientFrickeSelfDual.lean`.  It takes `SDF-04`'s eigenform
relation — whose constant is still `etaQuotient_fricke`'s raw `i^{-k} · N^k · s^{-1/2}`, with the
exponent vector present through `s = ∏_{δ ∣ N} δ^{r δ}` — and collapses that constant to
`frickeEigenvalue N k = i^{-k} · √(N^k) = i^{-k} · N^{k/2}`, which mentions only the LEVEL and the
WEIGHT.  Resolved by `SocrateAI.ModularForms.etaQuotient_fricke_selfDual`
(`SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`).

THE INVERTED TRIPWIRE IN SECTION `SdfDef01` HAS BEEN INVERTED BACK — the guard that asserted
`etaQuotient_fricke_selfDual` depends on `sorryAx` is GONE, replaced by the ordinary positive guard
at the end of this section, in the same commit that discharged the node.  This paragraph is the
receipt for that inversion, kept so the change is visible rather than silent (LL-2).

WHAT IS AND IS NOT CLAIMED.  `SDF-05` is an identity between two explicit finite products of values
of Mathlib's `ModularForm.eta`.  It says NOTHING about `Γ₀(N)`-modularity, NOTHING about holomorphy
or order at the cusps, and NOTHING about physics.  In particular it does not say that a self-dual
eta quotient IS a modular form, only how the Fricke involution acts on the function it defines.

RELATIVE TO `SDF-04` it is strictly STRONGER, and neither strengthening is asserted for free: the
constant becomes `r`-free (that is `SDF-03`, itself resting on `SDF-02`, the one genuinely
arithmetical step in the file, both closed and guarded above).  Relative to `etaQuotient_fricke`
(`EtaQuotientModularity.lean:2212`, sorry-free, tag `F3.2-A7`) it is a SPECIALISATION plus a
simplification: it ADDS the hypothesis `IsFrickeSelfDual N r` and drops nothing.

WHAT THE GUARDS BUY.  The proof is three rewrites and a `ring`, so all the risk is in the statement.
The instance pins below are what constrain it: they are stated as instances of `SDF-05`'s OWN
EQUATION at concrete `(N, r, k)`, and NONE of them invokes `etaQuotient_fricke_selfDual` — they are
declared ABOVE it in the same module, so Lean's scoping makes referring to it impossible and the
compiler, not this comment, enforces that.  Five of them fix the equation with `frickeEigenvalue N k`
in the constant slot; four more re-state it with the eigenvalue replaced by the NUMERAL computed by
hand outside Lean, reached through `SDF-DEF-02`'s `frickeEigenvalue_pin_*` lemmas — which are proved
from `Real.sqrt_sq` and never touch `s`.  So each numeral is reached twice, by routes that share no
lemma, and they agree.

`selfDual_eigen_pin_level_six` / `..._value` is the load-bearing pair: the only instance with `N > 1`
AND a non-constant exponent vector, hence the only one where the collapse moves a real number
(`2176782336 · 46656⁻¹ = 46656`).  `selfDual_eigen_pin_level_four_neg` is the only ODD weight (so
`i^{-k} = -i` is not real) and the only one with NEGATIVE exponents and a self-dual divisor
(`4 / 2 = 2`).  `selfDual_eigen_pin_level_six_neg` is the only NEGATIVE weight, where `N^k` and
`√(N^k)` are proper fractions rather than integers — the case a `k.toNat` or a `pow_pos`-in-place-of
-`zpow_pos` slip would fail.  `selfDual_eigen_pin_level_one` and `selfDual_eigen_pin_zero_exp` are
DEGENERATE BY CONSTRUCTION and are guarded as floors, not as evidence about the involution.

NON-VACUITY, guarded elsewhere in this file and not restated: `not_selfDual_pin_asymmetric` and
`not_selfDual_pin_mispaired` (section `SdfDef01`) `decide`-prove that the hypothesis is a genuine
restriction and that the divisor involution is the right one; `prod_zpow_pin_asymmetric_ne` (section
`Sdf02`) is an `hk`-satisfying counterexample to dropping `hr`; `frickeEigenvalue_pin_not_natPow`
and `frickeEigenvalue_pin_nonconstant` (section `SdfDef02`) separate `√(N^k)` from `N^k` and show the
eigenvalue is not constant in `N`.  And `selfDual_cond_pin_level_six` exhibits a self-dual vector at
`N = 6` with `rPinSix 1 ≠ rPinSix 2`, so the theorem is not the `N = 1` case in disguise.

THE FIVE CONJUNCTION PINS.  `selfDual_pin_level_one` and its four siblings bundle, at one instance
each, the self-duality condition, the weight, the product `∏ δ^{r δ}` as a literal AND as `N^k`, and
the eigenvalue.  They were `SDF-05`'s bookkeeping and are now closed by assembly from facts already
proved separately; they are guarded here rather than in `SdfDef01` or `Sdf02` because that is the
node they belong to.  `selfDual_pin_level_two_weight_one` and `selfDual_pin_eigenvalue_neg_one`
cover the two eigenvalue regimes no other pin reaches: `k` odd (imaginary `λ`) and `k ≡ 2 (mod 4)`
(`λ = -1`).

`SDF-06` closed one run later and is guarded in section `Sdf06` below, `SDF-07` … `SDF-10` closed in
the runs after that and are guarded in sections `Sdf07` … `Sdf10`, `SDF-11` and `SDF-12` closed after
those in sections `Sdf11` and `Sdf12`, and `SDF-13` — the last one — is guarded in section `Sdf13`;
this paragraph named each of them as open until then, and said of `SDF-13` that it "remains OPEN and
carries no guard" until the run that closed it.  NO `SDF-*` node is open now.

All `decide`s in the guarded declarations are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint below.

PHYSICS SCOPE.  Nothing guarded here formalises any physics.  Persson–Volpato (arXiv:1504.07260)
is cited in the guarded file's docstring as the ORIGIN of the question only, at the literature (L)
tier of this programme's ladder; their CHL / axio-dilaton S-duality claim is NOT a Lean statement
anywhere in this library and must never be reported as one.  Their term for the `r δ = r (N/δ)`
condition is "balanced"; this library calls it SELF-DUAL, both to avoid their physics framing and
because `balanced` is already taken in `EtaQuotientModularity.lean` by the unrelated `Int.bmod`
lemma `exists_balanced_add` (`F3.2-B1`). -/

namespace Sdf05

open SocrateAI.ModularForms

/-! #### The eigenvalue value the odd-weight pin is stated against -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_four

/-! #### The `SDF-05` instance pins — `SDF-05`'s own equation at concrete `(N, r, k)` -/

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_one

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_six

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_zero_exp

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_neg

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_six_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_six_neg

/-! #### The same five instances with the eigenvalue evaluated to its hand-computed NUMERAL -/

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_one_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_one_value

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_six_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_six_value

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_zero_exp_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_zero_exp_value

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_neg_value' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_neg_value

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_six_neg_value' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_six_neg_value

/-! #### The five conjunction pins — `SDF-05`'s bookkeeping, now closed -/

/-- info: 'SocrateAI.ModularForms.selfDual_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_level_one

/-- info: 'SocrateAI.ModularForms.selfDual_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_level_six

/-- info: 'SocrateAI.ModularForms.selfDual_pin_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_zero_exp

/-- info: 'SocrateAI.ModularForms.selfDual_pin_level_two_weight_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_level_two_weight_one

/-- info: 'SocrateAI.ModularForms.selfDual_pin_eigenvalue_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_eigenvalue_neg_one

/-! #### `SDF-05` itself -/

/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms etaQuotient_fricke_selfDual

end Sdf05

-- STATEMENT PIN (LL-1).  The guard above certifies the PROOF; the pin below certifies the
-- STATEMENT.
--
-- It is a NAMED theorem rather than an anonymous `example`, for the same reason as the F3.1-B0
-- gate witness at line 284: so that the `SDF-GUARD` DAG node has a `lean_name` that resolves
-- (`dag/check_dag.py` rule 3) and carries an axiom guard of its own (rule 7).  It proves nothing
-- new — its whole content is that `SDF-05`, restated with every abbreviation of ours removed,
-- is the same proposition.
--
-- `SDF-05` longhand, in the node's own words, with NOTHING hiding behind a SocrateAI definition:
-- the level is a POSITIVE natural (`ℕ+`), the point is a bundled `z : ℍ`, the exponent vector is
-- the bare `ℕ → ℤ` rather than the `EtaExp` abbreviation, `IsFrickeSelfDual` is UNFOLDED to the
-- bounded quantifier `∀ δ ∈ N.divisors, r δ = r (N / δ)`, `frickeEigenvalue` is UNFOLDED to
-- `i^{-k} · √(N^k)`, and BOTH eta quotients are written out as products over `Nat.divisors` with
-- `ModularForm.eta` fully qualified.  Unfolding the EIGENVALUE is the point of this pin: the
-- eigenvalue is the entire content of `SDF-05`, so it is precisely the term that must not be
-- quoted back through a definition of ours.  Compare the A7 pin at line 1657, which writes out
-- that node's raw constant `i^{-k} · N^k · (√s)⁻¹` for the same reason.
--
-- What a reader can then check by eye, with no definition to chase: the RIGHT-hand eta product
-- runs over `r δ`, the SAME vector as the left — not the dual `r (N/δ)` that F3.2-A7's law
-- carries (pinned at line 1657).  That collapse is what turns a transformation law into an
-- eigenform relation, and here it is visible as text.
--
-- NON-VACUITY CHECKED, not assumed (`scratch_sdfguard/neg/S05_*.lean`).  Five perturbations of
-- the statement below, each fed this same proof term, all fail to elaborate: `i^{+k}` for
-- `i^{-k}`, `√(N^{2k})` for `√(N^k)`, `(√(N^k))⁻¹` for `√(N^k)`, `z^{2k}` for `z^k`, and the dual
-- `r (N/δ)` for `r δ` in the right-hand product.
--
-- SCOPE -- READ BEFORE CITING.  One identity between two explicit finite products of values of
-- Mathlib's `ModularForm.eta` on the open upper half-plane.  It says nothing about
-- `Γ₀(N)`-modularity, nothing at any cusp, and nothing about physics.
section Sdf05StatementPin
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix Complex
open scoped MatrixGroups Real

/-- **`SDF-GUARD` — the `SDF-05` STATEMENT pin, longhand.**  `etaQuotient_fricke_selfDual` with
`EtaExp`, `IsFrickeSelfDual`, `frickeEigenvalue` and `etaQuotient` all unfolded, so the eigenform
relation and its eigenvalue `i^{-k} · √(N^k)` are readable without chasing a SocrateAI
definition.  Proves nothing new; see the comment above. -/
theorem SocrateAI.ModularForms.etaQuotient_fricke_selfDual_statement_pin :
    ∀ (N : ℕ+) (r : ℕ → ℤ) (k : ℤ),
    (∀ δ ∈ (N : ℕ).divisors, r δ = r ((N : ℕ) / δ)) →
    (∑ δ ∈ (N : ℕ).divisors, r δ) = 2 * k → ∀ z : ℍ,
    (∏ δ ∈ (N : ℕ).divisors,
        ModularForm.eta ((δ : ℂ) * (-(1 / (((N : ℕ) : ℂ) * (z : ℂ))))) ^ (r δ))
      = Complex.I ^ (-k) * ((Real.sqrt ((((N : ℕ) : ℝ)) ^ k) : ℝ) : ℂ)
        * (z : ℂ) ^ k
        * ∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ) :=
  fun N _ _ hr hk z => SocrateAI.ModularForms.etaQuotient_fricke_selfDual N.pos hr hk z.2

/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual_statement_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms SocrateAI.ModularForms.etaQuotient_fricke_selfDual_statement_pin

end Sdf05StatementPin

/-! ## `SDF-06` — the NORMALISED form: the eigenvalue is a root of unity

`SDF-06` divides `SDF-05` through by the normaliser `√(N^k)` and by `z^k`, leaving

`(√(N^k))⁻¹ · z^{-k} · f(-1/(Nz)) = i^{-k} · f(z)`

so the whole eigenvalue is `i^{-k}`, a fourth ROOT OF UNITY, with no residual power of the level.
Resolved by `SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized`
(`SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`).

WHAT THIS NODE ADDS, AND WHAT IT MUST NOT BE READ AS ADDING.  The division is bookkeeping.  The
`N`-dependence does not cancel because of anything visible in `SDF-06`; it cancels because
`∏_{δ ∣ N} δ^{r δ} = N^k` on a self-dual vector — `prod_zpow_selfDual` (`SDF-02`, guarded above,
the only genuinely arithmetical step in that file: it routes through `sqrt_prod_dual` (`F3.2-A7`)
and then uses positivity of the product to pick the root `+N^k` rather than `-N^k`) — packaged into
`ℂ` by `fricke_const_selfDual` (`SDF-03`, guarded above) and absorbed into `frickeEigenvalue` by
`SDF-05`.  Anyone reading "the `N`-dependence cancels completely" as this node's achievement is
reading it wrongly, and the module docstring says so too.

THE TWO CANCELLATIONS EACH NEED A HYPOTHESIS, and that is where the risk in an otherwise mechanical
proof sits: `(√(N^k))⁻¹ · √(N^k) = 1` needs `√(N^k) ≠ 0`, from `0 < N` via `zpow_pos` — `zpow_pos`,
NOT `pow_pos`, because `k < 0` is in scope and is pinned at `k = -12`; and `z^{-k} · z^k = 1` needs
`z ≠ 0`, extracted from membership in the OPEN upper half-plane.  `ring` performs NEITHER — verified
this run by running `ring` alone on the post-`SDF-05` goal, where it fails and reports the
uncancelled residue `√(N^k) · (√(N^k))⁻¹ · z^{-k} · i^{-k} · z^k · f = i^{-k} · f`.  That failure is
correct: both cancellations are false at `N = 0` and at `z = 0`.  `ring` only re-associates.

WHAT THE GUARDS BUY.  As with `SDF-04` and `SDF-05`, the proof is short and all the risk is in the
statement, so the instance pins are the evidence.  They are stated as instances of `SDF-06`'s OWN
equation at concrete `(N, r, k)` and NONE of them invokes
`etaQuotient_fricke_selfDual_normalized` — they are declared ABOVE it in the same module, so Lean's
scoping makes referring to it impossible and the compiler, not this comment, enforces that.  Each
carries a NUMERAL normaliser, so the cancellation a pin performs is `46656⁻¹ · 46656 = 1` rather than
`inv_mul_cancel₀` at a symbolic root.

`selfDual_norm_pin_level_six` / `..._value` is the load-bearing pair: `N > 1`, a non-constant
exponent vector, and a normaliser (`46656⁻¹`) that genuinely divides.  `selfDual_norm_pin_level_six_neg`
is THE SIGN PIN of this node: at `k = -12` the statement carries `z^{-k} = z^{+12}` and the
normaliser `(√(6⁻¹²))⁻¹ = 46656 > 1`, so a transcription with `z^k` for `z^{-k}`, or with the
normaliser uninverted, is FALSE there while surviving the `k = 0` pin;
`selfDual_norm_pin_level_one` moves the same exponent in the opposite direction, and the two together
fix its sign.  `selfDual_norm_pin_level_four_neg` / `..._value` is the only ODD weight, hence the
only instance whose normalised eigenvalue (`-i`) is neither `1` nor `-1` — without it every guarded
instance would have `4 ∣ k` and eigenvalue `1`, which is also what a statement that had LOST the
`i^{-k}` factor would produce.  `selfDual_norm_pin_level_one` and `selfDual_norm_pin_zero_exp` are
DEGENERATE BY CONSTRUCTION (`√(1^k) = 1`; `k = 0` kills all three factors at once) and are guarded as
floors, not as evidence about the involution or the normalisation.

EXTERNAL CROSS-CHECK, not an input.  `selfDual_norm_pin_level_one_is_eta_S` carries the level-one
instance down to `z⁻¹² · η(-1/z)²⁴ = η(z)²⁴`, which is `eta_S_via_fricke`
(`EtaQuotientModularity.lean:2246`, sorry-free) divided by `z¹²` and is proved independently in
MATHLIB as `discriminant_S_invariant`.  It is DERIVED, not cited: the proof starts from
`selfDual_eigen_pin_level_one_value` and names neither target, every tactic in it takes an explicit
lemma list, and neither target carries `@[simp]` (re-verified this run over this library and over the
pinned Mathlib), so `norm_num`'s default set cannot reach them either.

NEGATIVE CONTROL, and its honest limit.  `selfDual_norm_pin_asymmetric_ne` shows the two normalisers
diverge at the non-self-dual `rPinAsym = (2, 0)`, which satisfies the weight hypothesis exactly:
`SDF-06`'s `√(2¹) = √2` against the raw law's `√(1² · 2⁰) = 1`.  So `hr` is load-bearing here and not
decoration.  What is machine-proved is the discrepancy between the two NORMALISERS; that the full
conclusion also fails at that `r` (`fricke_dual_pin` gives `η(-1/(2z))² = -2i z η(2z)²`, so the
`hr`-free reading would assert `-i√2 · η(2z)² = -i · η(z)²`) needs `η(z)² ≠ η(2z)²` as functions,
which is true, is recorded in `fricke_dual_pin`'s docstring, and is NOT a theorem in this library —
so that half is asserted at the hand-check level, exactly as in section `Sdf04`.

APPLICATION CHECKS.  `etaQuotient_fricke_selfDual_normalized_pin_level_six` and
`..._pin_level_six_neg` state the same two equations as the `_value` pins but RUN THE GENERAL LEMMA
at those instances, so each equation is reached twice by routes that share no lemma — once through
`SDF-05`'s numeral pins, once through `SDF-06` — and they agree.  The negative-weight one is what
shows the general proof does not silently assume `k ≥ 0`.

`SDF-07` … `SDF-15` are ALL CLOSED and guarded in sections `Sdf07`, `Sdf08`, `Sdf09`, `Sdf10`,
`Sdf11`, `Sdf12`, `Sdf13`, `Sdf14` and `Sdf15` below.  No `SDF-*` node is open, and
`EtaQuotientFrickeSelfDual.lean` is `sorry`-free in full.  (This paragraph named `SDF-10`, then
`SDF-11`, then `SDF-12`, then `SDF-13`, then `SDF-14`, then `SDF-15` as open until the runs that
closed them; the sentences were rewritten together each time, not one of them.)  No `SDF-*` node
carries an inverted tripwire; `SDF-06` never had one, because its statement landed and its proof
followed in the same run, and neither did `SDF-07` … `SDF-15`.

All `decide`s in the guarded declarations are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint below.

PHYSICS SCOPE.  Nothing guarded here formalises any physics.  `SDF-06` is an identity between two
explicit finite products of values of Mathlib's `ModularForm.eta`; it says NOTHING about
`Γ₀(N)`-modularity, NOTHING about holomorphy or order at the cusps, and NOTHING about physics.  The
claim that this normalisation is the classical one (Martin, *Multiplicative eta-quotients*, Trans.
AMS 348 (1996)) is a CITATION claim about Martin's convention, at the literature (L) tier of this
programme's ladder, and is checked by nothing here.  Persson–Volpato (arXiv:1504.07260) is cited in
the guarded file's docstring as the ORIGIN of the question only, also at the L tier; their CHL /
axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must never be
reported as one.  Their term for the `r δ = r (N/δ)` condition is "balanced"; this library calls it
SELF-DUAL. -/

namespace Sdf06

open SocrateAI.ModularForms

/-! #### The two radicand values the normalisers are stated against -/

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_one

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_zero_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_zero_weight

/-! #### The `SDF-06` instance pins — `SDF-06`'s own equation at concrete `(N, r, k)` -/

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_level_one

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_level_six

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_zero_exp' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_zero_exp

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_level_four_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_level_four_neg

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_level_six_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_level_six_neg

/-! #### The same instances with normaliser and eigenvalue evaluated to their hand-computed NUMERALS -/

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_level_six_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_level_six_value

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_level_four_neg_value' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_level_four_neg_value

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_level_six_neg_value' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_level_six_neg_value

/-! #### The external cross-check against Mathlib's `discriminant_S_invariant` -/

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_level_one_is_eta_S' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_level_one_is_eta_S

/-! #### The negative control — `hr` is load-bearing in the normaliser -/

/-- info: 'SocrateAI.ModularForms.selfDual_norm_pin_asymmetric_ne' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_norm_pin_asymmetric_ne

/-! #### `SDF-06` itself -/

/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms etaQuotient_fricke_selfDual_normalized

/-! #### The two application checks — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized_pin_level_six' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms etaQuotient_fricke_selfDual_normalized_pin_level_six

/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized_pin_level_six_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms etaQuotient_fricke_selfDual_normalized_pin_level_six_neg

end Sdf06

-- STATEMENT PIN (LL-1).  The guard above certifies the PROOF; the pin below certifies the
-- STATEMENT.  Named rather than anonymous for the same `dag/check_dag.py` reason as the `SDF-05`
-- statement pin; it proves nothing new.
--
-- `SDF-06` longhand, on the same terms as that pin: level a POSITIVE natural (`ℕ+`), point a
-- bundled `z : ℍ`, exponent vector the bare `ℕ → ℤ`, `IsFrickeSelfDual` UNFOLDED to
-- `∀ δ ∈ N.divisors, r δ = r (N / δ)`, and both eta quotients written out over `Nat.divisors`
-- with `ModularForm.eta` fully qualified.  No `frickeEigenvalue` clause is needed here and none
-- is used: `etaQuotient_fricke_selfDual_normalized` already states its constants as `(√(N^k))⁻¹`,
-- `z^{-k}` and `i^{-k}`, with no eigenvalue definition to unfold.
--
-- What a reader can check by eye: after dividing by the normaliser `√(N^k)` and by `z^k`, the
-- constant left standing is `i^{-k}`, a fourth root of unity, with the `N`-dependence gone.  It
-- is gone because `SDF-02` cancelled it, NOT because of anything visible in this line — see the
-- section docstring above before reporting that cancellation as this node's achievement.
--
-- NON-VACUITY CHECKED, not assumed (`scratch_sdfguard/neg/S06_*.lean`).  Five perturbations of
-- the statement below, each fed this same proof term, all fail to elaborate: `i^{+k}` for
-- `i^{-k}`, `√(N^{2k})` for `√(N^k)`, `√(N^k)` for `(√(N^k))⁻¹`, `z^{k}` for `z^{-k}`, and the
-- dual `r (N/δ)` for `r δ` in the right-hand product.
--
-- SCOPE -- READ BEFORE CITING.  One identity between two explicit finite products of values of
-- Mathlib's `ModularForm.eta` on the open upper half-plane.  It says nothing about
-- `Γ₀(N)`-modularity, nothing at any cusp, and nothing about physics.  It is deliberately NOT
-- written through Mathlib's `∣[k]` slash: the `GL(2,ℝ)` slash carries a `det^(k-1)` factor, and
-- the Fricke matrix has determinant `N`, so restating it that way would change the constant.
section Sdf06StatementPin
open ModularForm UpperHalfPlane CongruenceSubgroup Matrix Complex
open scoped MatrixGroups Real

/-- **`SDF-GUARD` — the `SDF-06` STATEMENT pin, longhand.**
`etaQuotient_fricke_selfDual_normalized` with `EtaExp`, `IsFrickeSelfDual` and `etaQuotient` all
unfolded, so the normalised relation and its root-of-unity constant `i^{-k}` are readable without
chasing a SocrateAI definition.  Proves nothing new; see the comment above. -/
theorem SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized_statement_pin :
    ∀ (N : ℕ+) (r : ℕ → ℤ) (k : ℤ),
    (∀ δ ∈ (N : ℕ).divisors, r δ = r ((N : ℕ) / δ)) →
    (∑ δ ∈ (N : ℕ).divisors, r δ) = 2 * k → ∀ z : ℍ,
    ((Real.sqrt ((((N : ℕ) : ℝ)) ^ k) : ℝ) : ℂ)⁻¹ * (z : ℂ) ^ (-k)
        * (∏ δ ∈ (N : ℕ).divisors,
            ModularForm.eta ((δ : ℂ) * (-(1 / (((N : ℕ) : ℂ) * (z : ℂ))))) ^ (r δ))
      = Complex.I ^ (-k)
        * ∏ δ ∈ (N : ℕ).divisors, ModularForm.eta ((δ : ℂ) * (z : ℂ)) ^ (r δ) :=
  fun N _ _ hr hk z =>
    SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized N.pos hr hk z.2

/-- info: 'SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized_statement_pin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms SocrateAI.ModularForms.etaQuotient_fricke_selfDual_normalized_statement_pin

end Sdf06StatementPin

/-! ### `SDF-07` — integer powers of `i` are `4`-periodic

`I_zpow_emod` (`SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`).  `i^k = i^(k % 4)` for
`k : ℤ`, with `%` the `Int.emod` of a positive divisor, so the reduced exponent lies in `[0, 4)`
(`I_zpow_emod_exponent_mem`, guarded below).

WHAT THIS NODE IS.  A fact about `ℂ` alone: `i` has multiplicative order `4`.  It is NOT a
specialisation of `etaQuotient_fricke` in either direction, and it is not derived from the Fricke
transformation law — it mentions no eta quotient, no level, no weight and no `z`.  It is auxiliary:
`i^{-k}` is one factor of `frickeEigenvalue N k`, so this is what will let `SDF-08` and `SDF-09`
settle when that factor is `±1` by a finite case analysis instead of a fresh computation.

NOT ALREADY IN MATHLIB — re-verified this session by whole-library grep, no `| head` truncation.
`Complex.I_pow_eq_pow_mod` (`Data/Complex/Basic.lean:633`) is the `ℕ`-exponent version only.  The
generic `zpow_eq_zpow_emod` (`Algebra/Group/Basic.lean:849`) would have subsumed this, but it sits
inside `section Group` (`variable [Group G]`, opened at `Algebra/Group/Basic.lean:594` and not closed
before line 849) and `ℂ` is not a group under multiplication; a whole-Mathlib grep for a
`GroupWithZero`/`DivisionRing` zpow-emod variant returns nothing.  Hence the proof pays the `I ≠ 0`
side condition of `zpow_add₀`.

PINS.  Six instance pins, all stated and proved ABOVE the general lemma, each computing its two
sides by routes that do not meet: the left-hand side through the already sorry-free `I_zpow_*` value
lemmas of section `SdfDef02Pins` (or, at `k = -15`, through `zpow_neg` and a `ℕ`-power computation),
the right-hand side by `decide`-reducing `k % 4` to a numeral and evaluating that small power.  All
81 exponents in `[-40, 40]` were checked outside Lean first, in exact Gaussian-rational arithmetic
(repeated multiplication for `k ≥ 0`, explicit conjugate/norm inversion for `k < 0`); zero
mismatches.  `k = 12` is the exponent of `frickeEigenvalue 1 12`, the `N = 1`, `r = (24)` instance
underlying the sorry-free `eta_S_via_fricke`; `k = -12` is the exponent that actually appears in the
load-bearing `N = 6` self-dual instance; `k = -2` is the SIGN exponent behind
`frickeEigenvalue 1 2 = -1`, whose eta-quotient witness is `selfDual_pin_eigenvalue_neg_one`.

`I_zpow_emod_pin_zero` is DEGENERATE and is guarded as such, not as evidence: after its `decide` the
two sides are the same term, so it constrains nothing.  It is present because the degenerate case is
part of the required pin set.

NEGATIVE CONTROLS.  `I_zpow_emod_pin_not_mod_two` shows the modulus `4` is load-bearing — at `k = 3`
a mod-`2` statement would assert `-i = i`, refuted through `Complex.I_im`.
`I_zpow_emod_pin_nontrivial_reduction` shows the reduction is not the identity map
(`(-15) % 4 = 1 ≠ -15`), so the node is not a disguised tautology — and its guard below records that
it depends on NO axioms at all, not even the usual three: it is a closed `decide` on `ℤ`, so the
kernel evaluates it outright.  Together with
`I_zpow_emod_pin_neg_one` these also pin `%` as `Int.emod` and not `Int.tmod`: under `tmod` the
reduced exponent at `k = -1` would be `-1` and that pin would collapse into `i^{-1} = i^{-1}`.

APPLICATION CHECK.  `I_zpow_emod_pin_application` re-states five of the six pinned equations but
REACHES them by running `I_zpow_emod` at those exponents, so each is proved twice by routes sharing
no lemma, and they agree.  The `k = -15` conjunct is the informative one — its value is neither `1`
nor `-1`, so it is invisible to the `±1` bookkeeping of `SDF-08`/`SDF-09`.

All `decide`s in the declarations guarded below are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint.

NAMING.  `SDF-08`'s forward direction already exists in this library as `I_zpow_neg_eq_one`
(`EtaQuotientPrimeLevel.lean:630`, sorry-free, same namespace `SocrateAI.ModularForms`).  This file
imports both that module and `EtaQuotientFrickeSelfDual`, so when `SDF-08` closes it must keep its
`_iff` suffix or it will collide here.  `I_zpow_emod` itself is a fresh name library-wide
(grep-verified this session).

PHYSICS SCOPE.  Nothing here formalises any physics.  This node is an identity between two powers of
`Complex.I`.  It says NOTHING about `Γ₀(N)`, nothing about eta quotients, and nothing about physics.
Persson–Volpato (arXiv:1504.07260) is cited in the guarded file's docstring as the ORIGIN of the
question only, at the literature (L) tier; their CHL / axio-dilaton S-duality claim is NOT a Lean
statement anywhere in this library and must never be reported as one. -/

namespace Sdf07

open SocrateAI.ModularForms

/-! #### The exponent-range companion — what makes `SDF-08`/`SDF-09`'s case analysis exhaustive -/

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_exponent_mem' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_exponent_mem

/-! #### The six instance pins — `SDF-07`'s own equation at concrete exponents -/

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_pin_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_neg_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_pin_neg_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_pin_zero

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_pin_neg_one

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_neg_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_pin_neg_two

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_neg_fifteen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_pin_neg_fifteen

/-! #### The negative controls — the modulus, and the non-triviality of the reduction -/

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_not_mod_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_pin_not_mod_two

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_nontrivial_reduction' does not depend on any axioms -/
#guard_msgs in #print axioms I_zpow_emod_pin_nontrivial_reduction

/-! #### `SDF-07` itself -/

/-- info: 'SocrateAI.ModularForms.I_zpow_emod' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.I_zpow_emod_pin_application' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_emod_pin_application

end Sdf07

/-! ### `SDF-08` — `i^{-k} = 1 ↔ 4 ∣ k`  (`EtaQuotientFrickeSelfDual.lean`)

CLOSED this run.  `I_zpow_neg_eq_one_iff (k : ℤ) : (I : ℂ) ^ (-k) = 1 ↔ (4 : ℤ) ∣ k` — the criterion
for the NORMALISED Fricke eigenvalue of `SDF-06` (`etaQuotient_fricke_selfDual_normalized`, whose
constant is exactly `i^{-k}`) to be `+1`.

WHAT THIS NODE IS, AND WHAT IT IS NOT — stated here so the guard is not read as more than it is.  It
is an equivalence between a `ℂ`-valued `zpow` equation and an integer divisibility.  It mentions no
level `N`, no exponent vector `r`, no point `z` and no eta quotient, and it is NOT a specialisation
of `etaQuotient_fricke`: that specialisation is `SDF-04` (`etaQuotient_fricke_selfDual_raw`).
`SDF-08` is downstream of the Fricke work only through the CONSTANT — `i^{-k}` is one factor of
`frickeEigenvalue N k` — exactly as the `SDF-07` block above says.

PROOF ROUTE.  `SDF-07` (`I_zpow_emod`) reduces the exponent to `(-k) % 4 ∈ {0, 1, 2, 3}`
(`I_zpow_emod_exponent_mem`, then `omega`); the three non-zero residues are refuted by evaluating
`i^1`, `i^2` (`Complex.I_sq`) and `i^3` (`pow_succ` ON TOP OF `Complex.I_sq` — `I_sq` alone does not
reach `i^3`) and comparing one coordinate against `1` (`Complex.I_im`, `Complex.one_re`,
`Complex.one_im`); `(-k) % 4 = 0 ↔ 4 ∣ k` is inside `omega`'s numeral `emod`/`dvd` fragment, so
`Int.emod_emod_of_dvd` is not used.  BOTH directions run through `SDF-07`: the converse is NOT a
reuse of the sorry-free `I_zpow_neg_eq_one` (`EtaQuotientPrimeLevel.lean:630`), which is out of
scope in `EtaQuotientFrickeSelfDual.lean` — that module and `EtaQuotientPrimeLevel` are siblings,
both importing `EtaQuotientModularity` and neither importing the other.  THIS file imports both,
which is why the `_iff` suffix is mandatory: the un-suffixed name is already taken here.

SIX WEIGHT PINS, all stated ABOVE the general lemma so Lean scoping forbids them from using it, and
each settling its two sides by routes that do not meet — the `ℂ` side through the sorry-free
`I_zpow_*` value lemmas of section `SdfDef02Pins` (or, at `k = 15`, through
`I_zpow_emod_pin_neg_fifteen`), the `ℤ` side by `decide`.  The pinned weights are the weights of
eta-quotient instances already in that file: `k = 12` (`selfDual_eigen_pin_level_one`, the
`eta_S_via_fricke` instance, and `selfDual_eigen_pin_level_six`), `k = -12`
(`selfDual_eigen_pin_level_six_neg`), `k = 0` (`selfDual_eigen_pin_zero_exp`), `k = 2`
(`selfDual_pin_eigenvalue_neg_one`), `k = 1` (`selfDual_eigen_pin_level_four_neg`), and `k = 15`
(no eta-quotient instance — it is there because its value is neither `1` nor `-1`).

WHICH PINS CARRY WEIGHT.  `..._pin_two` is the load-bearing one: at `k = 2` BOTH sides are false
(`i^{-2} = -1 ≠ 1`, `4 ∤ 2`), and `k = 2` is the weight of `selfDual_pin_eigenvalue_neg_one` (`η⁴` at
level one, eigenvalue `-1`), so a statement on the wrong residue class — `2 ∣ k`, or the divisor
dropped to `2` — would break there and would hand `SDF-09` the wrong sign.  `..._pin_one` and
`..._pin_fifteen` refute through `Complex.I_im` at NON-REAL values, so they cannot be artefacts of
`±1` bookkeeping.  `..._pin_zero` is DEGENERATE and is guarded as such, not as evidence: after
`neg_zero` its left conjunct is `zpow_zero`.

Before any of this was stated in Lean, `i^{-k} = 1 ↔ 4 ∣ k` was checked outside Lean in exact
Gaussian-integer arithmetic at all 121 weights `k ∈ [-60, 60]` (positive powers by repeated
multiplication, negative ones by conjugation, since `|i^m| = 1`); zero mismatches.

APPLICATION CHECK.  `I_zpow_neg_eq_one_iff_pin_application` re-derives all six pinned weights by
RUNNING the general lemma there, so each is settled twice by routes sharing no lemma, and they agree.

All `decide`s in the declarations guarded below are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node is an equivalence between a power of
`Complex.I` and a divisibility in `ℤ`.  Persson–Volpato (arXiv:1504.07260) is cited in the guarded
file's docstring as the ORIGIN of the question only, at the literature (L) tier; their CHL /
axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must never be
reported as one. -/

namespace Sdf08

open SocrateAI.ModularForms

/-! #### The six weight pins — `SDF-08`'s own biconditional at concrete weights -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_one_iff_pin_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_one_iff_pin_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_one_iff_pin_neg_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_one_iff_pin_neg_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_one_iff_pin_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_one_iff_pin_zero

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_one_iff_pin_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_one_iff_pin_two

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_one_iff_pin_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_one_iff_pin_one

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_one_iff_pin_fifteen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_one_iff_pin_fifteen

/-! #### `SDF-08` itself -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_one_iff

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_one_iff_pin_application' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_one_iff_pin_application

end Sdf08

/-! ### `SDF-09` — `i^{-k} = -1 ↔ k % 4 = 2`  (`EtaQuotientFrickeSelfDual.lean`)

CLOSED this run.  `I_zpow_neg_eq_neg_one_iff (k : ℤ) : (I : ℂ) ^ (-k) = -1 ↔ k % 4 = 2` — the
criterion for the NORMALISED Fricke eigenvalue of `SDF-06`
(`etaQuotient_fricke_selfDual_normalized`, whose constant is exactly `i^{-k}`) to be `-1`, i.e. for a
Fricke-self-dual eta quotient of weight `k` to be a `(-1)`-eigenform of the normalised involution.

WHY IT IS A NODE OF ITS OWN, and not a conjunct of `SDF-08`.  The SIGN of the eigenvalue is exactly
the quantity a sign error corrupts, so it gets its own node and its own guard: a sign regression then
shows up in the DAG rather than inside somebody else's conjunction.  The independently computed
instance it answers to is `selfDual_pin_eigenvalue_neg_one` (`η⁴` at level one, weight two,
eigenvalue `-1`, computed by hand from `η(-1/z)⁴ = (-i z)² η(z)⁴ = -z² η(z)⁴`) together with
`frickeEigenvalue_pin_neg_one` — both already sorry-free and guarded in earlier sections.

WHAT THIS NODE IS, AND WHAT IT IS NOT.  It is an equivalence between a `ℂ`-valued `zpow` equation and
an integer congruence.  It mentions no level `N`, no exponent vector `r`, no point `z` and no eta
quotient, and it is NOT a specialisation of `etaQuotient_fricke` — no substitution into that theorem
produces it, since `i^{-k}` occurs there only as an opaque subterm of the scalar and that theorem
makes no claim about when the subterm is `-1`.  That specialisation is `SDF-04`.  `SDF-09` is
downstream of the Fricke work only through the CONSTANT: `i^{-k}` is one factor of
`frickeEigenvalue N k`.  (The statement comparator for this node was pointed at `etaQuotient_fricke`
and correctly returned NO_REFERENCE for exactly this reason; the real dependency is `SDF-07`.)

PROOF ROUTE.  `SDF-07` (`I_zpow_emod`) reduces the exponent to `(-k) % 4 ∈ {0, 1, 2, 3}`
(`Int.emod_nonneg`, `Int.emod_lt_of_pos`, then `omega`).  Three residues are refuted by evaluating the
power and comparing ONE coordinate against `-1`: `i^0 = 1` through `Complex.one_re`/`Complex.neg_re`,
`i^1 = i` and `i^3 = -i` through `Complex.I_im` (`i^3` needs `pow_succ` ON TOP OF `Complex.I_sq` —
`I_sq` alone does not reach it).  The surviving residue `(-k) % 4 = 2` gives the value `-1` by
`Complex.I_sq`, and `(-k) % 4 = 2 ↔ k % 4 = 2` is `omega`'s numeral-`emod` fragment, isolated as the
separately guarded `I_zpow_neg_eq_neg_one_iff_emod_neg` so it can be inspected on its own.
`Complex.ext_iff` (which this node's `built_from` named) is NOT used, and neither is
`Int.emod_emod_of_dvd`.

SIX WEIGHT PINS, all stated ABOVE the general lemma so Lean scoping forbids them from using it, each
settling its two sides by routes that do not meet — the `ℂ` side through the sorry-free `I_zpow_*`
value lemmas of section `SdfDef02Pins` (or, at `k = 15`, through `I_zpow_emod_pin_neg_fifteen`), the
`ℤ` side by `decide`.  `k = 12` (`selfDual_eigen_pin_level_one`, the `eta_S_via_fricke` instance, and
the `N = 6` instance `selfDual_eigen_pin_level_six`), `k = -12` (`selfDual_eigen_pin_level_six_neg`),
`k = 0` (`selfDual_eigen_pin_zero_exp`), `k = 2` (`selfDual_pin_eigenvalue_neg_one`), `k = -2`, and
`k = 15` (no eta-quotient instance — it is there because its value is neither `1` nor `-1`).

WHICH PINS CARRY WEIGHT.  `..._pin_two` is the load-bearing one and the ONLY pin here at which both
sides are TRUE: `i^{-2} = -1` and `2 % 4 = 2`, at the weight of `selfDual_pin_eigenvalue_neg_one`, so
a statement on the wrong residue class — `4 ∣ k`, i.e. `SDF-08`'s class — would contradict
`I_zpow_neg_two` there.  `..._pin_neg_two` is the `emod` pin: both sides true at a NEGATIVE weight,
reached through `Complex.I_sq` rather than `I_zpow_neg_two`, so PIN D and PIN E agree without sharing
a route.  `..._pin_fifteen` refutes through `Complex.I_im` at the non-real value `i`, so it cannot be
an artefact of `±1` bookkeeping.  `..._pin_zero` is DEGENERATE and is guarded as such, not as
evidence: after `neg_zero` its left conjunct is `zpow_zero`.

TWO NEGATIVE CONTROLS.  `..._pin_k_not_neg_k` shows that `k % 4` and `(-k) % 4` are DIFFERENT
functions (`1 % 4 = 1` but `(-1) % 4 = 3`; `15 % 4 = 3` but `(-15) % 4 = 1`), so stating the
right-hand side on the weight `k` rather than on the exponent `-k` is a real choice and not a
notational one — what makes both forms true is only their agreement on the single residue class `2`.
`..._pin_emod_not_tmod` shows the `emod`/`tmod` distinction is load-bearing: `(-2) % 4 = 2` while
`Int.tmod (-2) 4 = -2`, so under a truncating remainder PIN E would be FALSE and the node would fail
at every negative weight in the class where the eigenvalue actually is `-1`.

Before any of this was stated in Lean, `i^{-k} = -1 ↔ k % 4 = 2` was checked outside Lean in exact
Gaussian-integer arithmetic at all 401 weights `k ∈ [-200, 200]` (positive powers by repeated
multiplication, negative ones by conjugation since `|i^m| = 1`, `%` as `Int.emod`); zero mismatches.

APPLICATION CHECK.  `I_zpow_neg_eq_neg_one_iff_pin_application` re-derives all six pinned weights by
RUNNING the general lemma there, so each is settled twice by routes sharing no lemma, and they agree.

All `decide`s in the declarations guarded below are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node is an equivalence between a power of
`Complex.I` and a congruence in `ℤ`.  Persson–Volpato (arXiv:1504.07260) is cited in the guarded
file's docstring as the ORIGIN of the question only, at the literature (L) tier; their CHL /
axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must never be
reported as one. -/

namespace Sdf09

open SocrateAI.ModularForms

/-! #### The six weight pins — `SDF-09`'s own biconditional at concrete weights -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_neg_twelve' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_neg_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_zero

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_two

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_neg_two' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_neg_two

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_fifteen' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_fifteen

/-! #### The two negative controls — the `k`/`-k` and `emod`/`tmod` hazards -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_k_not_neg_k' does not depend on any axioms -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_k_not_neg_k

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod' does not depend on any axioms -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod

/-! #### The `k`/`-k` bridge used by the general proof -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_emod_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_emod_neg

/-! #### `SDF-09` itself -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_eq_neg_one_iff_pin_application' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_eq_neg_one_iff_pin_application

end Sdf09

/-! ### `SDF-10` — `(N : ℝ)^k = 1 ↔ (N = 1 ∨ k = 0)`  (`EtaQuotientFrickeSelfDual.lean`)

CLOSED this run.  `natCast_zpow_eq_one_iff {N : ℕ} (hN : 0 < N) (k : ℤ) : (N : ℝ) ^ k = 1 ↔
(N = 1 ∨ k = 0)` — the MODULUS half of the `±1` classification.  `SDF-08` and `SDF-09` settled the
root of unity `i^{-k}` in `frickeEigenvalue N k`; this settles the other factor, the positive real
`√(N^k)`, by settling `N^k`.  It is what rules out any `N > 1` with `k ≠ 0` in `SDF-12`/`SDF-13`.

WHAT THIS NODE IS, AND WHAT IT IS NOT.  It is an equivalence between a `zpow` equation in `ℝ` and a
disjunction of two decidable conditions on `(N, k)`.  It mentions no exponent vector `r`, no point
`z`, no eta quotient and no `Complex.I`, and it is NOT a specialisation of `etaQuotient_fricke` — no
substitution into that theorem produces it, since `N^k` occurs there only inside the opaque scalar
and that theorem makes no claim about when the scalar's modulus is `1`.  That specialisation is
`SDF-04`.  (The statement comparator for this node was pointed at `etaQuotient_fricke` and correctly
returned NO_REFERENCE for exactly that reason; the real reference is Mathlib's
`zpow_eq_one_iff_right₀`, `Algebra/Order/GroupWithZero/Basic.lean:1357`, whose `a ≠ 1` hypothesis
this node trades for the extra disjunct `N = 1`.)

PROOF ROUTE.  Split on `N = 1`: there `Nat.cast_one` and `one_zpow` make the left side `1 = 1` at
EVERY integer exponent, and the left disjunct supplies the right side.  Otherwise `(N : ℝ) ≠ 1` by
injectivity of the cast, and `zpow_eq_one_iff_right₀ (Nat.cast_nonneg N)` reduces the goal to
`k = 0 ↔ (N = 1 ∨ k = 0)`, closed by `Or.resolve_left`.

SIX INSTANCE PINS plus a two-route value check, all stated ABOVE the general lemma so Lean scoping
forbids them from using it, and all tied to eta-quotient instances this file already has:
`(N, k) = (1, 12)` (the `eta_S_via_fricke` instance, `selfDual_eigen_pin_level_one`), `(6, 12)` (the
genuine `N > 1` self-dual instance `rPinSix`, `selfDual_eigen_pin_level_six`), `(6, 0)` (the
degenerate `r ≡ 0` case, `selfDual_eigen_pin_zero_exp`), `(4, 1)` (odd weight,
`selfDual_eigen_pin_level_four_neg`), `(6, -12)` (negative weight,
`selfDual_eigen_pin_level_six_neg`), and `(1, -12)`.

WHICH PINS CARRY WEIGHT.  `..._pin_level_six` is the load-bearing one and the reason the node exists:
BOTH sides FALSE at a real `N > 1` Fricke-self-dual eta quotient, which is what makes `SDF-12` and
`SDF-13` sharp rather than vacuous.  `..._pin_level_six_neg` is the one that sees the SIGN of `k`:
there the power is the proper fraction `1/2176782336`, not an integer, so a statement or proof that
read `zpow` as `Monoid.npow` would break there — on live content, since this file has a self-dual
instance at that level and weight.  `..._pin_level_one` and `..._pin_zero_weight` are the two pins
that force the right-hand side to carry a level clause and a weight clause respectively.
`..._pin_zero_weight` is DEGENERATE and is guarded as such, not as evidence: its left conjunct is
`zpow_zero`.

PIN B's VALUE, CHECKED TWICE.  `natCast_zpow_pin_level_six_value` computes `6^12 = 2176782336` by
`norm_num`.  `natCast_zpow_pin_level_six_routes_agree` reaches the same number a second way, by
squaring the already sorry-free `sqrt_natPow_level_six` (`√(6^12) = 46656`, section `Sdf03Pins`, the
lemma `fricke_const_pin_level_six` and `frickeEigenvalue_pin_level_six` are built on) through
`Real.sq_sqrt`, then records `46656² = 2176782336`.  So the modulus this node rules out and the
modulus `SDF-03` computed are the same number, and a disagreement fails the build here rather than
surfacing downstream.

TWO NEGATIVE CONTROLS, ONE PER DISJUNCT, showing NEITHER is droppable.
`..._pin_not_weight_only` exhibits `1^12 = 1` with `12 ≠ 0`, refuting the strengthened form
`(N : ℝ)^k = 1 ↔ k = 0` — which is Mathlib's `zpow_eq_one_iff_right₀` read WITHOUT its `a ≠ 1`
hypothesis — and refuting it at the `eta_S_via_fricke` instance.  `..._pin_not_level_only` exhibits
`6^0 = 1` with `6 ≠ 1`, refuting `(N : ℝ)^k = 1 ↔ N = 1`.  Together they also refute the conjunctive
form `N = 1 ∧ k = 0`.  The disjunction is therefore exactly right, not merely sufficient.

`hN` IS REDUNDANT, AND THAT IS PINNED RATHER THAN GLOSSED.
`..._pin_hypothesis_redundant` proves the SAME biconditional at `N = 0`, at a positive, a negative
and a zero weight, via `zero_zpow_eq_one₀`.  `hN` is kept anyway and is deliberately UNUSED in the
proof, only so this lemma's shape matches `SDF-12` and `SDF-13`, which need it.  A future reader must
not infer from its presence that the statement fails at `N = 0`.

Before any of this was stated in Lean, `N^k = 1 ↔ (N = 1 ∨ k = 0)` was checked outside Lean in exact
rational arithmetic (no floating point) at all 20301 instances `N ∈ [0, 100]`, `k ∈ [-100, 100]`,
with the `N = 0` row evaluated under Lean's convention `(0 : ℝ)⁻¹ = 0`; zero mismatches.

APPLICATION CHECK.  `natCast_zpow_eq_one_iff_pin_application` re-derives all six pinned `(N, k)` by
RUNNING the general lemma there, so each is settled twice by routes sharing no lemma, and they agree.

All `decide`s in the declarations guarded below are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node is an equivalence between a power of
a cast natural in `ℝ` and a disjunction of two arithmetic conditions.  Persson–Volpato
(arXiv:1504.07260) is cited in the guarded file's docstring as the ORIGIN of the question only, at
the literature (L) tier; their CHL / axio-dilaton S-duality claim is NOT a Lean statement anywhere in
this library and must never be reported as one. -/

namespace Sdf10

open SocrateAI.ModularForms

/-! #### The six instance pins — `SDF-10`'s two sides at concrete `(N, k)` -/

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_level_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_level_one

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_level_six' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_level_six

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_zero_weight' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_zero_weight

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_level_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_level_four

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_level_six_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_level_six_neg

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_level_one_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_level_one_neg

/-! #### The pinned values, and PIN B's second route through `SDF-03`'s `√(6^12) = 46656` -/

/-- info: 'SocrateAI.ModularForms.natCast_zpow_pin_level_six_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_pin_level_six_value

/-- info: 'SocrateAI.ModularForms.natCast_zpow_pin_level_six_routes_agree' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_pin_level_six_routes_agree

/-- info: 'SocrateAI.ModularForms.natCast_zpow_pin_level_four_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_pin_level_four_value

/-- info: 'SocrateAI.ModularForms.natCast_zpow_pin_level_six_neg_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_pin_level_six_neg_value

/-! #### The two negative controls — neither disjunct of the right-hand side is droppable -/

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_not_weight_only' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_not_weight_only

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_not_level_only' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_not_level_only

/-! #### The hypothesis-redundancy pin — the biconditional also holds at `N = 0` -/

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_hypothesis_redundant' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_hypothesis_redundant

/-! #### `SDF-10` itself -/

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.natCast_zpow_eq_one_iff_pin_application' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms natCast_zpow_eq_one_iff_pin_application

end Sdf10

/-! ### `SDF-11` — `‖frickeEigenvalue N k‖ = √((N : ℝ)^k)`

`SDF-11` (`frickeEigenvalue_norm`, `EtaQuotientFrickeSelfDual.lean`) is CLOSED, and every
declaration that closes it is guarded here.  The statement is

`‖frickeEigenvalue N k‖ = Real.sqrt ((N : ℝ)^k)`  for `0 < N`,

the MODULUS of the unnormalised Fricke eigenvalue in closed form.  `frickeEigenvalue N k` is
`i^{-k} · √(N^k)` (`SDF-DEF-02`), a fourth root of unity times a NON-NEGATIVE real, so the norm
discards the `i`-factor and returns the real one.  This is the node that makes the `±1`
classification of `SDF-12`/`SDF-13` split cleanly into an ARGUMENT condition (`SDF-08`/`SDF-09`) and
a MODULUS condition (`SDF-10`).

SIX INSTANCE PINS, each computing BOTH sides by routes sharing no lemma — the left through
`SDF-DEF-02`'s `frickeEigenvalue_pin_*` value lemmas, the right through `SDF-03`'s `sqrt_natPow_*`
radicand lemmas — and all stated ABOVE the general lemma, so Lean scoping forbids them from using
it: `(1, 12)` the `eta_S_via_fricke` instance; `(6, 12)` the genuine `N > 1` self-dual instance
`rPinSix` (LOAD-BEARING); `(6, 0)` the degenerate `r ≡ 0` case; `(2, 1)` odd weight with both sides
IRRATIONAL; `(1, 2)` the `η⁴` instance where the eigenvalue is `-1`; `(6, -12)` NEGATIVE weight,
where the modulus is the proper fraction `1/46656`.

THREE NEGATIVE CONTROLS.  `..._pin_not_natPow` refutes the dropped-square-root reading
`‖frickeEigenvalue N k‖ = (N : ℝ)^k` at `(6, 12)`, where the modulus is `46656` and
`6^12 = 2176782336` — and it takes that second number from `SDF-10`'s already sorry-free
`natCast_zpow_pin_level_six_value`, so the two nodes agree on it or the build fails.
`..._pin_not_eigenvalue` records that at `(1, 2)` the modulus `1` differs from the eigenvalue `-1`,
so this node must NOT be read as a closed form for `frickeEigenvalue` itself — it gives the SIZE
only, and `SDF-08`/`SDF-09` remain what settle the argument.  `..._pin_nonconstant` records
`‖frickeEigenvalue 6 12‖ ≠ ‖frickeEigenvalue 1 12‖` at the SAME weight, so the right-hand side
genuinely depends on the level and the unnormalised eigenvalue is not a root of unity in general.

`hN` IS REDUNDANT, AND THAT IS PINNED RATHER THAN GLOSSED.
`..._pin_hypothesis_redundant` proves the SAME equation at `N = 0`, at a negative, a zero and a
positive weight.  `hN` is kept anyway and is deliberately UNUSED in the proof — with
`set_option linter.unusedVariables false in` on that declaration alone, for that documented reason —
only so this lemma's shape matches `SDF-10`, `SDF-12` and `SDF-13`.

APPLICATION CHECK.  `frickeEigenvalue_norm_pin_application` re-derives all six pinned `(N, k)` by
RUNNING the general lemma there, so each is settled twice by routes sharing no lemma, and they
agree.

All `decide`s in the declarations guarded below are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint.

RENUMBERING RECEIPT.  `frickeEigenvalue_eq_one_iff` and `frickeEigenvalue_eq_neg_one_iff` were
labelled `SDF-11`/`SDF-12` by an earlier run working from a TRUNCATED specification, which recorded
in their docstrings that the labels were a guess.  The real `SDF-11` is `frickeEigenvalue_norm`,
guarded here; those two were renumbered to `SDF-12`/`SDF-13` in the same commit.  `SDF-12`
(`frickeEigenvalue_eq_one_iff`) has SINCE been confirmed by the orchestrating session — character for
character, `hN` included — and is now proved and guarded in section `Sdf12` below.  `SDF-13`
(`frickeEigenvalue_eq_neg_one_iff`) has SINCE been confirmed the same way and is proved and guarded
in section `Sdf13` below; this sentence called it "still an UNCONFIRMED reconstruction and still
OPEN with no guard" until that run.  No reconstructed statement remains.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node is the modulus of a complex number.
Persson–Volpato (arXiv:1504.07260) is cited in the guarded file's docstring as the ORIGIN of the
question only, at the literature (L) tier; their CHL / axio-dilaton S-duality claim is NOT a Lean
statement anywhere in this library and must never be reported as one. -/

namespace Sdf11

open SocrateAI.ModularForms

/-! #### The six instance pins — both sides of `SDF-11` at concrete `(N, k)` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_level_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_level_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_level_six' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_level_six

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_zero_weight' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_zero_weight

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_level_two_weight_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_level_two_weight_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_neg_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_neg_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_level_six_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_level_six_neg

/-! #### The three negative controls — dropped root, sign, and level-dependence -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_not_natPow' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_not_natPow

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_not_eigenvalue' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_not_eigenvalue

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_nonconstant' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_nonconstant

/-! #### The hypothesis-redundancy pin — the equation also holds at `N = 0` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_hypothesis_redundant' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_hypothesis_redundant

/-! #### `SDF-11` itself -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm_pin_application' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_norm_pin_application

end Sdf11

/-! ### `SDF-12` — `frickeEigenvalue N k = 1 ↔ (4 ∣ k ∧ (N = 1 ∨ k = 0))`

`SDF-12` (`frickeEigenvalue_eq_one_iff`, `EtaQuotientFrickeSelfDual.lean`) is CLOSED, and every
declaration that closes it is guarded here.  The statement is

`frickeEigenvalue N k = 1 ↔ ((4 : ℤ) ∣ k ∧ (N = 1 ∨ k = 0))`  for `0 < N`,

i.e. the unnormalised Fricke eigenvalue `λ = i^{-k} · √(N^k)` (`SDF-DEF-02`) is `1` exactly when BOTH
of its factors are: the fourth root of unity by `SDF-08`, the modulus by `SDF-11` + `Real.sqrt_eq_one`
+ `SDF-10`.  This is the first node in the `SDF-*` block that pins the EIGENVALUE ITSELF to a
constant rather than its modulus or one of its factors.

WHAT THIS NODE IS NOT.  It is a fact about a SCALAR — no exponent vector `r`, no point `z`, no eta
quotient, no `IsFrickeSelfDual` hypothesis — and it is NOT a specialisation of `etaQuotient_fricke`.
That specialisation is `SDF-04`/`SDF-05`.  The statement comparator for this node was pointed at
`etaQuotient_fricke` and correctly returned NO_REFERENCE for exactly that reason, as it did for
`SDF-10` and `SDF-11`.

SIX INSTANCE PINS, all stated ABOVE the general lemma so Lean scoping forbids them from using it, and
all reaching the left-hand side through `SDF-DEF-02`'s `frickeEigenvalue_pin_*` value lemmas rather
than through the biconditional: `(1, 12)` the `eta_S_via_fricke` instance, both sides TRUE with the
level clause firing at a NON-zero weight; `(6, 12)` the genuine `N > 1` self-dual instance `rPinSix`
(LOAD-BEARING — both sides FALSE while `4 ∣ 12` HOLDS, so it is the pin that forces the second
conjunct to exist); `(6, 0)` the degenerate `r ≡ 0` case, both sides TRUE at a level that is not `1`;
`(2, 1)` odd weight, `λ = -(i√2)`, refuted through its modulus; `(1, 2)` the `η⁴` instance where
`λ = -1` — modulus `1`, so the SIGN CONTROL, the pin that forces the FIRST conjunct to exist;
`(6, -12)` NEGATIVE weight, `λ = 1/46656`, where a proof assuming `0 ≤ k` breaks.

TWO NEGATIVE CONTROLS, one per conjunct.  `..._pin_not_level_only` exhibits `(1, 2)` with the level
clause TRUE and `λ = -1 ≠ 1`, refuting the weakened `λ = 1 ↔ (N = 1 ∨ k = 0)` — i.e. `SDF-10` alone
does not settle this node.  `..._pin_not_dvd_only` exhibits `(6, 12)` with `4 ∣ 12` and
`λ = 46656 ≠ 1`, refuting the weakened `λ = 1 ↔ 4 ∣ k` — i.e. `SDF-08` alone does not either.  So the
conjunction is exactly right, not merely sufficient.

`hN` IS REDUNDANT, AND THAT IS PINNED RATHER THAN GLOSSED.  `..._pin_hypothesis_redundant` proves the
SAME biconditional at `N = 0` at three weights, including `k = -4` where `4 ∣ k` HOLDS and the
biconditional survives only because the second conjunct fails.  Unlike in `SDF-10` and `SDF-11`, `hN`
IS syntactically used in `SDF-12`'s proof — it is passed to those two lemmas, which ignore it in turn
— so no `linter.unusedVariables` suppression is needed here.  It is kept for shape-uniformity with
`SDF-10`, `SDF-11` and `SDF-13`.

WHICH SQUARE-ROOT LEMMA.  The proof uses Mathlib's UNCONDITIONAL `Real.sqrt_eq_one`
(`Analysis/Real/Sqrt.lean:172`, `√x = 1 ↔ x = 1`), NOT `Real.sq_sqrt`, which would require
`0 ≤ (N : ℝ)^k` as a side goal and a `zpow_pos` detour.  No positivity fact about `N` is used
anywhere in the proof; that is why `hN` can be redundant.

OUT-OF-LEAN CHECK, recorded as evidence about the STATEMENT.  Before it was proved, the biconditional
was checked in exact rational arithmetic (`fractions.Fraction`, no floating point) at all `12221`
instances `N ∈ [0, 100]`, `k ∈ [-60, 60]`, with the `N = 0` row under Lean's conventions
`(0 : ℝ)^k = 0` for `k ≠ 0` and `√0 = 0`.  Zero mismatches.

APPLICATION CHECK.  `frickeEigenvalue_eq_one_iff_pin_application` re-derives all six pinned `(N, k)`
by RUNNING the general lemma there, so each is settled twice by routes sharing no lemma below
`SDF-DEF-02`, and they agree.

RECONSTRUCTION RECEIPT.  This declaration's statement was originally reconstructed by a run working
from a TRUNCATED specification (see the RENUMBERING RECEIPT in section `Sdf11`'s docstring above).
The orchestrating session has since supplied `SDF-12` in full and the supplied text agrees with the
declaration CHARACTER FOR CHARACTER, `hN` included, so the reconstruction is CONFIRMED and this node
may be reported as a specified node.  Its sibling `SDF-13` (`frickeEigenvalue_eq_neg_one_iff`) has
SINCE been confirmed the same way and is proved and guarded in section `Sdf13` below; this sentence
said it "has NOT been confirmed, remains a reconstruction, remains OPEN and carries no guard" until
that run.

All `decide`s in the declarations guarded below are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node says when a complex number attached
to a level and a weight equals `1`.  Persson–Volpato (arXiv:1504.07260) is cited in the guarded
file's docstring as the ORIGIN of the question only, at the literature (L) tier; their CHL /
axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must never be
reported as one. -/

namespace Sdf12

open SocrateAI.ModularForms

/-! #### The six instance pins — both sides of `SDF-12` at concrete `(N, k)` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_level_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_level_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_level_six' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_level_six

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_zero_weight' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_zero_weight

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_level_two_weight_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_level_two_weight_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_neg_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_neg_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_level_six_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_level_six_neg

/-! #### The two negative controls — one per conjunct of the right-hand side -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_not_level_only' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_not_level_only

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_not_dvd_only' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_not_dvd_only

/-! #### The hypothesis-redundancy pin — the biconditional also holds at `N = 0` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_hypothesis_redundant' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_hypothesis_redundant

/-! #### `SDF-12` itself -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_one_iff_pin_application' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_one_iff_pin_application

end Sdf12

/-! ### `SDF-13` — `frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1)`

`frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1)` for `0 < N`.  The sibling of `SDF-12` at the OTHER
value: the unnormalised eigenvalue `λ = i^{-k} · √(N^k)` is `-1` exactly when the ROOT OF UNITY is
`-1` (`SDF-09`) and the MODULUS is `1` (`SDF-11` + `Real.sqrt_eq_one` + `SDF-10`).

WHY THE RIGHT-HAND SIDE IS NOT `SDF-12`'s WITH `1` REPLACED BY `-1`.  `SDF-12` reads
`(4 ∣ k ∧ (N = 1 ∨ k = 0))`; this node reads `(k % 4 = 2 ∧ N = 1)`, with the `k = 0` disjunct GONE —
because `k % 4 = 2` already forces `k ≠ 0`, so `SDF-10`'s second disjunct cannot fire and the level
condition SHARPENS to `N = 1`.  That is machine-checked, not asserted:
`frickeEigenvalue_eq_neg_one_iff_pin_asymmetry` proves the `SDF-12`-shaped right-hand side equivalent
to the one used here for EVERY `N` and `k`, and exhibits `(6, 0)` where `SDF-12`'s right-hand side is
TRUE and this node's is FALSE — so the two nodes are genuinely different statements.  That pin is
also the only declaration guarded in this section whose footprint is `[propext, Quot.sound]` with NO
`Classical.choice`: it is pure `omega` and constructor logic, and the guard below records that
smaller footprint rather than pasting the section's usual triple.

THREE VALUE PINS THIS NODE ADDS, because `SDF-DEF-02`'s six do not cover the instances it needs.
`I_zpow_two` (`i^{2} = -1`, the integer-exponent form, needed for `i^{-k}` at `k = -2`),
`frickeEigenvalue_pin_level_six_weight_two` (`λ = -6` at `(6, 2)`) and
`frickeEigenvalue_pin_level_one_weight_neg_two` (`λ = -1` at `(1, -2)`).

EIGHT INSTANCE PINS, all stated ABOVE the general lemma so Lean scoping forbids them from using it.
`(1, 12)` the `eta_S_via_fricke` instance, BOTH sides FALSE with the LEVEL clause TRUE — `λ = 1` and
`12 % 4 = 0`, which is what forces the residue conjunct to exist; `(6, 12)` the genuine `N > 1`
self-dual instance `rPinSix = (1, 11, 11, 1)`, both sides FALSE; `(6, 0)` the DEGENERATE `r ≡ 0`
case, both sides FALSE — and note it is FALSE here where the `SDF-12` pin at the same `(N, k)` is
TRUE, which is the dropped `k = 0` disjunct made visible at an instance; `(2, 1)` ODD weight,
`λ = -(i√2)`, refuted through its modulus `√2`, left symbolic; `(1, 2)` the LOAD-BEARING pin and one
of only two where BOTH sides are TRUE — `λ = -1`, `2 % 4 = 2`, `N = 1`; `(6, -12)` NEGATIVE weight,
`λ = 1/46656`, where a proof assuming `0 ≤ k` breaks; `(6, 2)` THE LEVEL CONTROL and the pin `SDF-12`
has no analogue of — the residue clause HOLDS, so the root of unity IS `-1`, and yet `λ = -6` because
the modulus `√(6²) = 6` is not `1`, the only pin at which the two conjuncts disagree; and `(1, -2)`
BOTH sides TRUE at a NEGATIVE weight, the `emod` pin.

THREE NEGATIVE CONTROLS.  `..._pin_not_level_only` exhibits `(1, 12)` with `N = 1` TRUE and
`λ = 1 ≠ -1`, refuting the weakened `λ = -1 ↔ N = 1` — i.e. `SDF-10` alone does not settle this node.
`..._pin_not_emod_only` exhibits `(6, 2)` with `2 % 4 = 2` and `λ = -6 ≠ -1`, refuting the weakened
`λ = -1 ↔ k % 4 = 2` — i.e. `SDF-09` alone does not either.  So the conjunction is exactly right,
not merely sufficient.  `..._pin_emod_not_tmod` records `(-2) % 4 = 2` beside `Int.tmod (-2) 4 = -2`
TOGETHER WITH the eigenvalue `-1` at `(1, -2)`, so "Lean's `%` is `Int.emod`" is a checked fact of
THIS node — on the eigenvalue, not only on the root of unity as in `SDF-09` — rather than an
assumption inherited from upstream.  Under a truncating remainder `SDF-13` would be FALSE at every
weight in `{…, -10, -6, -2}`.

`hN` IS REDUNDANT, AND THAT IS PINNED RATHER THAN GLOSSED.  `..._pin_hypothesis_redundant` proves the
SAME biconditional at `N = 0` at three weights, including `k = 2` where the RESIDUE clause HOLDS and
the biconditional survives only because `λ = 0` and the LEVEL conjunct fails.  As in `SDF-12`, `hN`
IS syntactically used in the proof — it is passed to `SDF-10` and `SDF-11`, which ignore it in turn —
so no `linter.unusedVariables` suppression is needed.  It is kept for shape-uniformity with `SDF-10`,
`SDF-11` and `SDF-12`.

WHICH SQUARE-ROOT LEMMA.  As in `SDF-12`, the proof uses Mathlib's UNCONDITIONAL `Real.sqrt_eq_one`
(`Analysis/Real/Sqrt.lean:172`, `√x = 1 ↔ x = 1`), NOT `Real.sq_sqrt` — which the DAG node's
`built_from` names, and which would require `0 ≤ (N : ℝ)^k` as a side goal and a `zpow_pos` detour
for no gain.  A build hint, not a statement difference.  No positivity fact about `N` is used
anywhere in the proof; that is why `hN` can be redundant.

OUT-OF-LEAN CHECK, recorded as evidence about the STATEMENT.  Before it was proved, the biconditional
was checked in exact arithmetic (`fractions.Fraction` for `N^k`, Gaussian units for `i^{-k}`; no
floating point) at all `40501` instances `N ∈ [0, 100]`, `k ∈ [-200, 200]`, with the `N = 0` row
under Lean's conventions `(0 : ℝ)^k = 0` for `k ≠ 0` and `√0 = 0`.  Zero mismatches, and every
instance at which the eigenvalue IS `-1` had `N = 1`.

APPLICATION CHECK.  `frickeEigenvalue_eq_neg_one_iff_pin_application` re-derives all eight pinned
`(N, k)` by RUNNING the general lemma there, so each is settled twice by routes sharing no lemma
below `SDF-DEF-02`, and they agree.

RECONSTRUCTION RECEIPT — THE LAST ONE IN THIS FILE IS NOW DISCHARGED.  This declaration's statement
was originally reconstructed by a run working from a TRUNCATED specification (see the RENUMBERING
RECEIPT in section `Sdf11`'s docstring above).  The orchestrating session has since supplied `SDF-13`
in full and the supplied text agrees with the declaration CHARACTER FOR CHARACTER, `hN` included, so
the reconstruction is CONFIRMED and this node may be reported as a specified node.  With `SDF-12`
confirmed one commit earlier, NO declaration in `EtaQuotientFrickeSelfDual.lean` carries an
unconfirmed statement any more, and that file is now `sorry`-free in full.

All `decide`s in the declarations guarded below are `decide`, never `native_decide`, so no
`Lean.ofReduceBool` enters any footprint.

NORMALISATION CAVEAT, because this node is the one most likely to be misreported.  `frickeEigenvalue`
is the UNNORMALISED constant of `f(-1/(Nz)) = λ · z^k · f(z)` and carries the factor `N^{k/2}`.  Read
without that qualification, "eigenvalue `-1` forces `N = 1`" would appear to contradict the classical
fact (Martin, *Multiplicative eta-quotients*, 1996) that multiplicative eta quotients of level
`N > 1` have Fricke eigenvalue `±1`.  It does not: the classical eigenvalue is the NORMALISED one,
here `i^{-k}` (`SDF-06`), whose `N`-dependence has already cancelled by `SDF-02`.
`frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two` is the guarded pin where the two disagree:
at `(6, 2)` the normalised eigenvalue is `-1` and the unnormalised one is `-6`.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node says when a complex number attached
to a level and a weight equals `-1`.  Persson–Volpato (arXiv:1504.07260) is cited in the guarded
file's docstring as the ORIGIN of the question only, at the literature (L) tier; their CHL /
axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must never be
reported as one. -/

namespace Sdf13

open SocrateAI.ModularForms

/-! #### The three VALUE pins this node adds — `i^{2}`, and the eigenvalue at `(6, 2)` and `(1, -2)` -/

/-- info: 'SocrateAI.ModularForms.I_zpow_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_two

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_six_weight_two' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_six_weight_two

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_one_weight_neg_two' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_one_weight_neg_two

/-! #### The eight instance pins — both sides of `SDF-13` at concrete `(N, k)` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_level_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_level_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_level_six' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_level_six

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_zero_weight' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_zero_weight

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_level_two_weight_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_level_two_weight_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_neg_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_neg_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_level_six_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_level_six_neg

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_neg_one_neg_weight' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_neg_one_neg_weight

/-! #### The three negative controls — one per conjunct, plus the remainder convention -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_not_level_only' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_not_level_only

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_not_emod_only' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_not_emod_only

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_emod_not_tmod' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_emod_not_tmod

/-! #### The asymmetry pin — why this right-hand side is not `SDF-12`'s with `1` replaced by `-1` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_asymmetry' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_asymmetry

/-! #### The hypothesis-redundancy pin — the biconditional also holds at `N = 0` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_hypothesis_redundant' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_hypothesis_redundant

/-! #### `SDF-13` itself -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff_pin_application' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff_pin_application

end Sdf13

/-! ### `SDF-14` — `(λ = 1 ∨ λ = -1) ↔ (4 ∣ ∑ r δ ∧ (N = 1 ∨ ∑ r δ = 0))`

`SDF-14` (`frickeEigenvalue_pm_one_iff`, `EtaQuotientFrickeSelfDual.lean`) is CLOSED, and every
declaration it adds is guarded below.

WHAT THIS NODE IS, AND WHAT IT IS NOT.  `SDF-14` is the DISJUNCTION of `SDF-12` and `SDF-13`,
re-parametrised by the WEIGHT SUM `∑ δ ∈ N.divisors, r δ` instead of the weight `k`, using the
hypothesis `hk : ∑ δ ∈ N.divisors, r δ = 2 * k`.  It is NOT new mathematical content and NOT a
statement about eta quotients: no `etaQuotient`, no point `z`, no dual exponent vector and no
`IsFrickeSelfDual` hypothesis occurs in it, and `r` enters ONLY through `hk`.  In particular THIS
GUARD MUST NOT BE READ, OR REPORTED, AS GUARDING A SPECIALISATION OF `etaQuotient_fricke`.  That
specialisation is `SDF-04` (`etaQuotient_fricke_selfDual_raw`, guarded in section `Sdf04`).  The
statement comparator for this node was pointed at `etaQuotient_fricke` and correctly returned
NO_REFERENCE for exactly that reason — the same disposition already recorded for `SDF-09`
(section `Sdf09`), `SDF-10` (section `Sdf10`) and the `SDF-12`/`SDF-13` pair.  The node's real
references are `SDF-12` and `SDF-13`, both proved sorry-free and guarded in sections `Sdf12` and
`Sdf13`.

WHY IT IS WORTH STATING.  The weight SUM is what a concrete exponent vector presents to `decide`;
the weight `k` exists only as the witness of `hk`.  So this is the form of the `±1` criterion that
applies to a concrete eta quotient without first solving for `k`.

THE STEP THAT IS NOT MECHANICAL, and the pin that guards it.  `4 ∣ ∑ r δ` is `4 ∣ 2k`, which does
NOT give `4 ∣ k` (`k = 2`: `4 ∣ 4` but `4 ∤ 2`).  The backward direction case-splits
`k % 4 ∈ {0, 2}` and routes residue `0` to `SDF-12` and residue `2` to `SDF-13`.
`frickeEigenvalue_pm_one_iff_pin_neg_one_branch` is that instance machine-checked: at
`(1, rPinFour, 2)` the divisibility of the SUM holds, the divisibility of the WEIGHT fails, and the
eigenvalue is `-1`.

PIN COVERAGE.  `..._pin_level_six` is the LOAD-BEARING pin: a genuine `N > 1` Fricke-self-dual
exponent vector with the SAME weight sum `24` as the level-one pin and the OPPOSITE verdict, which
is what forces the `(N = 1 ∨ ∑ r δ = 0)` conjunct to exist.  `..._pin_zero_exp` is DEGENERATE
(`r ≡ 0`) and is recorded as such, but it is the ONLY pin at which the right-hand side holds with
`N > 1`, so it is what makes the `∑ r δ = 0` disjunct non-vacuous.  `..._pin_level_two_weight_one`
is the only pin failing on the DIVISIBILITY conjunct.  `..._pin_level_six_neg` and
`..._pin_emod_not_tmod` are the negative-weight instances; the latter also pins
`(-2) % 4 = 2` against `Int.tmod (-2) 4 = -2`, so the `Int.emod` convention that `SDF-13` needs is a
checked fact at this node too, on a concrete exponent vector.

NORMALISATION CAVEAT, mandatory in any prose report of this node.  `frickeEigenvalue` is the
UNNORMALISED constant of `f(-1/(Nz)) = λ · z^k · f(z)` and carries `N^{k/2}`.  "`λ = ±1` forces
`N = 1` or `∑ r δ = 0`" is a statement about THAT convention and does NOT contradict the classical
fact (Martin, *Multiplicative eta-quotients*, 1996) that multiplicative eta quotients of level
`N > 1` have Fricke eigenvalue `±1`; the classical eigenvalue is the NORMALISED one, here `i^{-k}`
(`SDF-06`), whose `N`-dependence has already cancelled by `SDF-02`.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node relates a complex number attached to
a level and a weight to a divisor-sum condition over `ℤ`.  Persson–Volpato (arXiv:1504.07260) is
cited in the guarded file's header as the ORIGIN of the question only, at the literature (L) tier;
their CHL / axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must
never be reported as one. -/

namespace Sdf14

open SocrateAI.ModularForms

/-! #### The exponent vector this node adds, and its weight witness -/

/-- info: 'SocrateAI.ModularForms.rPinNegFour_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinNegFour_weight

/-! #### The seven instance pins — both sides of `SDF-14` at concrete `(N, r, k)` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff_pin_level_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff_pin_level_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff_pin_level_six' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff_pin_level_six

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff_pin_zero_exp' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff_pin_zero_exp

/-! #### The trap pin — `4 ∣ ∑ r δ` does NOT give `4 ∣ k`, and here `λ = -1`, not `1` -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff_pin_neg_one_branch' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff_pin_neg_one_branch

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff_pin_level_two_weight_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff_pin_level_two_weight_one

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff_pin_level_six_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff_pin_level_six_neg

/-! #### The remainder convention at this node's level, on a concrete exponent vector -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff_pin_emod_not_tmod' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff_pin_emod_not_tmod

/-! #### `SDF-14` itself -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pm_one_iff_pin_application' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pm_one_iff_pin_application

end Sdf14

/-! ### `SDF-15` — the NORMALISED `±1` criterion: `(i^{-k} = 1 ∨ i^{-k} = -1) ↔ Even k`

WHAT IS GUARDED.  `I_zpow_neg_pm_one_iff (k : ℤ) : ((I : ℂ) ^ (-k) = 1 ∨ (I : ℂ) ^ (-k) = -1) ↔
Even k`, together with six weight pins, two negative controls, the negation-invariance lemma
`I_zpow_neg_pm_one_iff_even_neg` and the application check.

WHAT IT IS NOT, AND MUST NOT BE REPORTED AS.  Like `SDF-07`, `SDF-08` and `SDF-09`, this is a fact
about `ℂ` and `ℤ` ALONE: no level `N`, no exponent vector `r : EtaExp`, no `N.divisors`, no point
`z`, no `ℍₒ`, no `etaQuotient`, no `IsFrickeSelfDual` hypothesis and no `hk : ∑ r δ = 2 * k` occurs
in it.  THIS GUARD MUST NOT BE READ, OR REPORTED, AS GUARDING A SPECIALISATION OF
`etaQuotient_fricke`.  That specialisation is `SDF-04` (`etaQuotient_fricke_selfDual_raw`, guarded in
section `Sdf04`).  The statement comparator for this node was pointed at `etaQuotient_fricke` and
correctly returned NO_REFERENCE for exactly that reason — the same disposition already recorded for
`SDF-09`, `SDF-10`, `SDF-12`/`SDF-13` and `SDF-14`.  The node's real references are `SDF-08`
(`I_zpow_neg_eq_one_iff`, section `Sdf08`) and `SDF-09` (`I_zpow_neg_eq_neg_one_iff`, section
`Sdf09`), both proved sorry-free, together with `SDF-06` for the identification of `i^{-k}` as the
normalised eigenvalue.

DEPENDENCY RECEIPT.  The DAG entry lists `depends_on: [SDF-08, SDF-09]`.  An earlier draft of the
node listed `[SDF-07]`; that understated it, since routing through `SDF-07` directly would re-run the
four-case residue analysis `SDF-08` and `SDF-09` already carry, including the `Int.emod` /
`Int.tmod` hazard pinned by `I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod`.  The proof reuses the two
closed criteria and closes the remaining gap, `(4 ∣ k ∨ k % 4 = 2) ↔ k % 2 = 0`, with `omega`.

PIN COVERAGE.  `..._pin_two` is the LOAD-BEARING pin: `k = 2` is the ONLY pinned weight at which the
left-hand side holds through its SECOND disjunct (`i^{-2} = -1`, and `i^{-2} ≠ 1` is recorded
separately), and it is the weight of `selfDual_pin_eigenvalue_neg_one` (`η⁴` at level one, eigenvalue
`-1`).  A version of this node with `i^{-k} = 1` alone on the left — i.e. `SDF-08`'s left-hand side —
is refuted there.  `..._pin_twelve` is the `Δ = η²⁴` / level-six weight, `..._pin_neg_twelve` the
negative-weight instance (a proof assuming `0 ≤ k` breaks there), `..._pin_zero` the DEGENERATE
`r ≡ 0` case, recorded as such.  `..._pin_fifteen` and `..._pin_one` cover the two ODD residue
classes, with values `i` and `-i`; each records the value and refutes BOTH `1` and `-1`, one
comparison through `Complex.I_im` and one through `Complex.I_re`, so neither refutation can be an
artefact of `±1` bookkeeping.  `..._pin_neither_disjunct_alone` shows neither `SDF-08`'s nor
`SDF-09`'s criterion is equivalent to `Even k` on the `ℂ` side, and
`..._pin_even_strictly_between` shows the same on the `ℤ` side by `decide`.

NORMALISATION CAVEAT, mandatory in any prose report of this node, and sharper here than anywhere
else in this file.  `i^{-k}` is the NORMALISED eigenvalue — `SDF-06` has already divided out
`√(N^k)` and `z^k`.  The sentence "the Fricke eigenvalue is `±1` iff the weight is even" is TRUE of
`i^{-k}` and FALSE of `frickeEigenvalue`, the UNNORMALISED constant, for which `±1` is `SDF-14`'s far
tighter condition requiring `N = 1` or `∑ r δ = 0`;
`frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two` is the instance where the two conventions
differ (normalised `-1`, unnormalised `-6`).  This node may be quoted in preference to `SDF-14` only
with the normalisation named in the same sentence, and only after composing with `SDF-06`.
Separately, the re-parametrisation `Even k ↔ 4 ∣ ∑_{δ ∣ N} r δ` is NOT guarded here and is not a
consequence of this node: it needs `hk : ∑ δ ∈ N.divisors, r δ = 2 * k`, which `SDF-15` does not
carry.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node relates an integer power of the
complex unit `i` to the parity of an integer.  Persson–Volpato (arXiv:1504.07260) is cited in the
guarded file's header as the ORIGIN of the self-duality question only, at the literature (L) tier;
their CHL / axio-dilaton S-duality claim is NOT a Lean statement anywhere in this library and must
never be reported as one. -/

namespace Sdf15

open SocrateAI.ModularForms

/-! #### The six weight pins — both sides of `SDF-15` at concrete weights -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_neg_twelve' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_neg_twelve

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_zero

/-! #### The load-bearing pin — the left-hand side holds through its SECOND disjunct only -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_two

/-! #### The two ODD residue classes, where no `±1` coincidence can fake the value -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_fifteen' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_fifteen

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_one' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_one

/-! #### The negative controls — neither component criterion is equivalent to `Even k` -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_neither_disjunct_alone' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_neither_disjunct_alone

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_even_strictly_between' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_even_strictly_between

/-! #### Parity is negation-invariant — the `k`/`-k` hazard of `SDF-09` does not arise here -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_even_neg' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_even_neg

/-! #### `SDF-15` itself -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff

/-! #### The application check — the general lemma reproduces the pins -/

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_pm_one_iff_pin_application' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_pm_one_iff_pin_application

end Sdf15

/-! ## `SDF-16` — `IsFrickeSelfDual` is DECIDABLE  (ERGONOMICS ONLY)

`decidableIsFrickeSelfDual` is the `Decidable` instance for `IsFrickeSelfDual N r`, obtained by
`inferInstanceAs` at the bounded quantifier `∀ δ ∈ N.divisors, r δ = r (N / δ)` the `def` unfolds to,
where Mathlib's `Finset.decidableBAll` already applies.

READ THIS BEFORE QUOTING THE NODE.  It is ERGONOMICS and nothing more: with it in scope, `by decide`
closes a self-duality goal without the leading `unfold IsFrickeSelfDual`.  Two overclaims were
caught by this run's statement comparator and are guarded against here by being written down.
(i) This node is NOT what lets the `selfDual_cond_pin_*` pins of section `SdfDef01` discharge their
goals — every one of them predates it, uses `unfold IsFrickeSelfDual; decide`, needs no instance,
and was `sorry`-free before it existed.  (ii) This node is NOT what makes the self-duality
hypothesis non-vacuous — that is `not_selfDual_pin_asymmetric` and `not_selfDual_pin_mispaired`,
both guarded in section `SdfDef01`, both independent of this instance.  Nothing in the library above
the node's own section depends on it.

IT IS STILL A GENUINE DELTA.  Verified this run: with the instance removed,
`IsFrickeSelfDual 6 rPinSix := by decide`, `¬ IsFrickeSelfDual 2 rPinAsym := by decide` and
`decide (IsFrickeSelfDual 6 rPinSix) = true := rfl` fail with exactly three
`failed to synthesize Decidable (IsFrickeSelfDual …)` errors and no other cause.

WHAT THESE GUARDS ACTUALLY GUARD.  A `Decidable` instance is proof-carrying, so it CANNOT disagree
with the proposition it decides — this node cannot be wrong about which exponent vectors are
self-dual.  The failure mode it CAN have is being INERT: an instance that elaborates but does not
reduce in the kernel (`Classical.dec` typechecks against the same statement and computes nothing),
or one routed through `native_decide` (which would put `Lean.ofReduceBool` in the footprint).
`decidableIsFrickeSelfDual_pin_bool_values` is the pin that refutes both — it asserts the `Bool`
value of `decide (IsFrickeSelfDual N r)` at four TRUE and two FALSE concrete instances **by `rfl`**,
forcing kernel evaluation of `Nat.divisors N` and of the exponent vector at every divisor.  The
footprints below are therefore load-bearing in one specific way: any `Lean.ofReduceBool` appearing
in them means a `decide` somewhere below became a `native_decide`.

THE PINNED ROWS, computed outside Lean first (exact integer arithmetic, this session) and only then
asserted: `N=1 r=(24)` self-dual (DEGENERATE — at `N = 1` every `r` is); `N=6 r=(1,11,11,1)`
self-dual (THE LOAD-BEARING ROW — the only positive one with `N > 1` and a non-constant vector);
`N=6 r≡0` self-dual (DEGENERATE, a floor); `N=4 r=(-2,6,-2)` self-dual (the only row with NEGATIVE
entries and the only `N > 1` level with a self-paired divisor, `4/2 = 2`); `N=6 r=(1,11,1,11)` NOT
self-dual (the mis-pairing control, same weight sum `24`, invariant under the WRONG involution
`1 ↔ 3`, `2 ↔ 6`); `N=2 r=(2,0)` NOT self-dual (the `fricke_dual_pin` vector).

`decidableIsFrickeSelfDual_pin_level_zero_vacuous` is a TRAP, not evidence: `Nat.divisors 0 = ∅`, so
`IsFrickeSelfDual 0 r` is VACUOUSLY TRUE for every `r`, including `rPinAsym`, which is not self-dual
at `N = 2`.  Both halves are asserted at the same vector so the contrast is machine-checked.  This
is why every `SDF-*` lemma carries `hN : 0 < N`, and it is a hazard specific to the decidable
reading: `by decide` will close `IsFrickeSelfDual 0 r` for any concrete `r`, so a future pin that
dropped its positivity hypothesis would pass.  Its second conjunct is `not_selfDual_pin_asymmetric`
REUSED, not re-decided.

PHYSICS SCOPE.  Nothing here formalises any physics.  This node says a decidable arithmetic
condition on a function `ℕ → ℤ` over a finite set of divisors is decidable.  Persson–Volpato
(arXiv:1504.07260) is cited in the guarded file's header as the ORIGIN of the self-duality question
only, at the literature (L) tier; their CHL / axio-dilaton S-duality claim is NOT a Lean statement
anywhere in this library and must never be reported as one. -/

namespace Sdf16

open SocrateAI.ModularForms

/-! #### `SDF-16` itself — the instance -/

/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual

/-! #### The four positive rows, each closed by BARE `decide` (no `unfold`) -/

/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual_pin_level_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual_pin_level_one

/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual_pin_level_six' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual_pin_level_six

/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual_pin_zero_exp' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual_pin_zero_exp

/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual_pin_level_four_neg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual_pin_level_four_neg

/-! #### The negative-side row — the instance produces `isFalse`, not merely `isTrue` -/

/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual_pin_mispaired' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual_pin_mispaired

/-! #### THE PIN THAT CAN FAIL — the `Bool` values by `rfl`, i.e. by kernel reduction -/

/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual_pin_bool_values' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual_pin_bool_values

/-! #### The `N = 0` TRAP — vacuously true there, false at `N = 2` on the SAME vector -/

/-- info: 'SocrateAI.ModularForms.decidableIsFrickeSelfDual_pin_level_zero_vacuous' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms decidableIsFrickeSelfDual_pin_level_zero_vacuous

end Sdf16

/-! ## `SDF-PIN-01` — the level-one pin's REACH, guarded

`selfDual_raw_pin_level_one_is_eta_S` (guarded in section `Sdf04` above) is the level-one instance
of `SDF-04` carried down to `η(-1/z)²⁴ = z¹² η(z)²⁴`, i.e. to `eta_S_via_fricke` /
MATHLIB's `discriminant_S_invariant`, by a route that names neither.  The independence is now
CHECKED rather than argued from the tactic scripts: walking the kernel proof term of
`selfDual_raw_pin_level_one_is_eta_S` transitively (this run) reaches `etaQuotient_fricke`,
`etaQuotient_congr_divisors`, `selfDual_cond_pin_level_one`, `rPinOne_weight` and
`IsFrickeSelfDual`, and reaches NEITHER `eta_S_via_fricke` NOR `discriminant_S_invariant`.

WHAT IS GUARDED HERE IS THE OPPOSITE OF EVIDENCE.  Earlier prose in this file (and in
`eta_S_via_fricke`'s own docstring) claimed that a wrong `i^{-k}`, a wrong power of `N` or an
inverted `√s` would fail at that instance.  THAT CLAIM WAS FALSE and has been corrected in all
three places: at `N = 1`, `k = 12` we have `i^{-12} = i^{+12}`, `1^k = 1` for every `k`, `s = 1`
so `(√s)⁻¹ = √s`, and `δ ↦ 1/δ` is the identity on `Nat.divisors 1`.  The four
`selfDual_pin_level_one_no_evidence_*` theorems prove exactly those four degeneracies, so the
limitation is machine-checked rather than remembered, and the level-one pin is filed as a FLOOR
(two definitions reproducing an already-established value by a second route), not as a test that
discriminates any component of `λ = i^{-k} · N^k · s^{-1/2}`.

The two `..._evidence_*` theorems check that the discrimination is somewhere: three of the four
degeneracies fail at `N = 6` (`selfDual_pin_level_six_evidence_contrast`), and the fourth fails
only at ODD weight (`selfDual_pin_weight_one_evidence_I_sign`) — raising the level does NOT fix
it, since `i^{-k} = i^{k}` for every even `k`.  The perturbation evidence about the GENERAL
statement (`scratch/A7perturb.lean`, five failing perturbations of `etaQuotient_fricke`) is
unaffected by this correction: it concerns free `N` and `k`, not the `N = 1` instance. -/

section SdfPin01

/-- info: 'SocrateAI.ModularForms.selfDual_pin_level_one_no_evidence_I_sign' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_level_one_no_evidence_I_sign

/-- info: 'SocrateAI.ModularForms.selfDual_pin_level_one_no_evidence_level_pow' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_level_one_no_evidence_level_pow

/-- info: 'SocrateAI.ModularForms.selfDual_pin_level_one_no_evidence_radicand' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_level_one_no_evidence_radicand

/-- info: 'SocrateAI.ModularForms.selfDual_pin_level_one_no_evidence_involution' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_level_one_no_evidence_involution

/-! #### The contrast checks — the discrimination is elsewhere, and it is really there -/

/-- info: 'SocrateAI.ModularForms.selfDual_pin_level_six_evidence_contrast' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_level_six_evidence_contrast

/-- info: 'SocrateAI.ModularForms.selfDual_pin_weight_one_evidence_I_sign' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_pin_weight_one_evidence_I_sign

end SdfPin01

/-! ## `SDF-PIN-02` — the level-two pin in expanded `η` form, and its reach, guarded

`SDF-PIN-02` is `selfDual_eigen_pin_level_two_eta`
(`EtaQuotientFrickeSelfDual.lean`, inside `section Sdf05Pins`):

```
η(-1/(2z)) · η(2 · (-1/(2z)))  =  -i·√2 · z · (η(z) · η(2z))
```

the `(N, r, k) = (2, rPinTwo, 1)` instance of `SDF-05`, i.e. `f = η(z)·η(2z)`, with every definition
this library introduces unfolded away.  It is the ONLY pin in that module stated without
`etaQuotient`, `EtaExp` or `frickeEigenvalue`, so it is the only one that exercises the
`etaQuotient` UNFOLDING (`divisors 2 = {1, 2}`, `Finset.prod_pair`, `zpow_one`, the casts).

WHAT IT IS NOT.  It is not the `(2, 1)` constant collapse — `frickeEigenvalue_pin_level_two_weight_one`
(`SDF-DEF-02`, guarded in section `SdfDef02`) already closed that — and it is not "the only odd
weight", since `selfDual_eigen_pin_level_four_neg` (`k = 1`) precedes it.  And it is NOT evidence
about the divisor PAIRING: `rPinTwo` is constant on `Nat.divisors 2`, which
`selfDual_eigen_pin_level_two_no_evidence_pairing` proves, so a transposed pairing would still close
it.  The pairing evidence lives at level six (`rPinSix_nonconstant`, `not_selfDual_pin_mispaired`,
`prod_zpow_pin_mispaired_ne`), exactly as section `SdfPin01` records for the level-one pin.

WHAT IS GENUINELY NEW, and guarded here.  (i) The `SDF-03` constant collapse at an IRRATIONAL
radicand: `fricke_const_pin_level_two` is the first member of that pin family whose two routes meet
at `√2` rather than at an integer or its reciprocal, and `two_mul_inv_sqrt_two` is the one step
`ring` and `norm_num` cannot do (`√2` is an atom to both).  (ii) A SECOND, INDEPENDENT DERIVATION of
the node's equation: `selfDual_eigen_pin_level_two_eta_via_upstream` reaches it from
`fricke_level_two_pin` (`EtaQuotientModularity.lean:2285`, hand-derived one run earlier from the
`S`-transform at `z` and `2z`) through `selfDual_eigen_pin_level_two_routes_agree`
(`i⁻¹ · 2 · (√2)⁻¹ = -i·√2`).  So "the two spellings agree" is a BUILD OBLIGATION, not a docstring
claim: if `SDF-03`'s collapse and that hand computation ever disagreed at this instance, one of the
two derivations would stop compiling.

INDEPENDENCE OF THE TWO ROUTES, checked on the compiled KERNEL TERM this run
(`scratch_sdfpin02/DepWalk.lean`), not argued from the tactic scripts — `fricke_level_two_pin` is in
scope in the self-dual module, so source-text absence would not be enough:

* `selfDual_eigen_pin_level_two_eta` reaches `etaQuotient_fricke`, `etaQuotient_fricke_selfDual_raw`,
  `fricke_const_selfDual`, `prod_zpow_selfDual`, `frickeEigenvalue`, `IsFrickeSelfDual`, and reaches
  NEITHER `fricke_level_two_pin` NOR `etaQuotient_fricke_selfDual`;
* `selfDual_eigen_pin_level_two_eta_via_upstream` reaches `fricke_level_two_pin`,
  `two_mul_inv_sqrt_two` and `Complex.inv_I`, and reaches NONE of
  `selfDual_eigen_pin_level_two_eta`, `selfDual_eigen_pin_level_two`,
  `etaQuotient_fricke_selfDual`, `etaQuotient_fricke_selfDual_raw`, `fricke_const_selfDual`,
  `prod_zpow_selfDual`, `frickeEigenvalue` or `IsFrickeSelfDual`.

Corroborating receipt for the same claim: `fricke_level_two_pin` carries no `@[simp]` (whole-file
scan of `EtaQuotientModularity.lean` for `@[simp]` and `attribute [simp]` this run returns fifteen
hits, none of them this theorem), and every tactic in the node's proof takes an explicit lemma list.

NUMERICS, computed outside Lean this run at 40 dps from `η`'s product formula (800 factors) and only
then asserted: relative error `≤ 5.9e-41` at `z ∈ {i, 2i, 1+i, 0.3+0.7i, -0.4+1.3i, 0.13+0.41i}`;
the CONJUGATE constant `+i√2` fails at relative error `2.0` at every one of them.  Its Lean
counterpart is `selfDual_eigen_pin_level_two_not_conjugate`.

Two of the eighteen footprints below are `does not depend on any axioms` (`rPinTwo_values_pin` and
`selfDual_eigen_pin_level_two_no_evidence_pairing`, both closed by `decide` on a decidable
proposition about `rPinTwo` alone); the other sixteen are `[propext, Classical.choice, Quot.sound]`.
No `sorryAx` anywhere.  Must-fail control: `verification/SdfPin02NegControl.lean`. -/

section SdfPin02

/-- info: 'SocrateAI.ModularForms.rPinTwo_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinTwo_weight

/-- info: 'SocrateAI.ModularForms.rPinTwo_divisors_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinTwo_divisors_pin

/-- info: 'SocrateAI.ModularForms.rPinTwo_values_pin' does not depend on any axioms -/
#guard_msgs in #print axioms rPinTwo_values_pin

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_two

/-- info: 'SocrateAI.ModularForms.two_mul_inv_sqrt_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms two_mul_inv_sqrt_two

/-- info: 'SocrateAI.ModularForms.fricke_const_pin_level_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms fricke_const_pin_level_two

/-- info: 'SocrateAI.ModularForms.sqrt_two_nondegenerate' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_two_nondegenerate

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_two_weight_one_spelling' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_two_weight_one_spelling

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_value' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_value

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_eta' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_eta

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_routes_agree' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_routes_agree

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_eta_via_upstream' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_eta_via_upstream

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_not_conjugate' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_not_conjugate

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_evidence_level_pow' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_evidence_level_pow

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_evidence_radicand' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_evidence_radicand

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_evidence_involution' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_evidence_involution

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_two_no_evidence_pairing' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_two_no_evidence_pairing

end SdfPin02

/-! ## `SDF-PIN-03` — the level-four, weight-four eigenform identity, written out in `η`

`selfDual_eigen_pin_level_four_weight_four_eta`
(`EtaQuotientFrickeSelfDual.lean`, section `SdfPin03`):

```
η(-1/(4z))² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))²  =  16 · z⁴ · (η(z)² · η(2z)⁴ · η(4z)²)
```

the `(N, r, k) = (4, rPinLevelFourWeightFour, 4)` instance of `SDF-05`, `s = 1²·2⁴·4² = 256 = 4⁴`,
`λ = i^{-4} · √(4⁴) = 1 · 16 = 16`.  The second statement in the library (after `SDF-PIN-02`) with
`etaQuotient`, `EtaExp`, `frickeEigenvalue` and `IsFrickeSelfDual` all unfolded away, and the first
at `N > 2`, at EVEN weight, and on a NON-CONSTANT exponent vector.

WHAT THE GUARDS BELOW ARE FOR, beyond the usual `sorryAx` watch.  This node's eigenvalue is reached
twice — `prod_zpow_pin_level_four_weight_four` computes `s = 256` DIRECTLY from
`Nat.divisors 4 = {1,2,4}` while `prod_zpow_selfDual_pin_level_four_weight_four` reaches the same
number through `SDF-02`'s general collapse `s = N^k` — and the two must agree.  Likewise
`selfDual_cond_pin_level_four_weight_four` (bare `decide`, through `SDF-16`'s instance) and
`..._unfolded` (`unfold IsFrickeSelfDual; decide`, needing no instance) discharge one hypothesis by
two routes.  And `selfDual_eigen_pin_level_one_eta_calibration` re-derives, along this file's
`SDF-05`/`SDF-04`/`SDF-03`/`SDF-02` route, the statement `eta_S_via_fricke` proves upstream WITHOUT
self-duality; `..._agrees` pairs the two proofs of that one proposition so the agreement is a build
obligation.

READ THE LIMITATION BEFORE CITING THIS NODE.  At `(N, k) = (4, 4)` the LEVEL and the WEIGHT are the
SAME NUMBER, so a constant that had swapped them reads `16` either way and is INVISIBLE here —
`selfDual_eigen_pin_level_four_weight_four_no_evidence_level_weight` states that in Lean.  The
degeneracy is broken by the two companion η-unfolded pins, both guarded below:
`selfDual_eigen_pin_level_nine_weight_four_eta` (`N = 9`, `k = 4`, `λ = 81`, while `√(k^N) = 512`)
moves the level at fixed weight, and `selfDual_eigen_pin_level_four_weight_two_eta` (`N = 4`,
`k = 2`, `λ = -4`, NEGATIVE, so `i^{-k}` is visible) moves the weight at fixed level.  Neither
alone suffices.  The degenerate `r ≡ 0` case at the node's own level is
`selfDual_eigen_pin_level_four_zero_exp`.

NUMERICS, computed outside Lean this run at 60 dps from `η`'s product formula (1200 factors) and
only then asserted: relative error `≤ 3.5e-60` for the node at
`z ∈ {i, 0.3+0.7i, -0.11+0.45i, 0.25+0.9i, -0.4+1.3i, 0.05+0.31i}`, and `≤ 1.5e-59` for each of the
four calibration/companion pins at `z = 0.3+0.7i`.  Negative controls for the node at `z = 0.3+0.7i`:
`λ = 256` fails at relative error `9.4e-1`, `λ = 4` at `3.0`, `λ = 8` at `1.0`, `λ = 32` at `5.0e-1`,
`λ = -16` at `2.0`, `λ = 16i` at `1.4`, `z²` in place of `z⁴` at `1.5`, `z⁶` at `2.5`.

Two of the thirty-six footprints below are `does not depend on any axioms`
(`rPinLevelFourWeightFour_values_pin` and
`selfDual_eigen_pin_level_four_weight_four_evidence_pairing`, both closed by `decide` on a decidable
proposition about the exponent vector alone); the other thirty-four are
`[propext, Classical.choice, Quot.sound]`.  No `sorryAx` anywhere.  Must-fail control:
`verification/SdfPin03NegControl.lean`.

NAMING: `sqrt_natPow_level_four_weight_four` is `√(4⁴) = 16` and is a DIFFERENT lemma from
`sqrt_natPow_level_four`, which is `√(4¹) = 2` — the library's other level-four instance has weight
one.  And the condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced". -/

section SdfPin03

/-- info: 'SocrateAI.ModularForms.divisors_four_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms divisors_four_pin

/-- info: 'SocrateAI.ModularForms.divisors_nine_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms divisors_nine_pin

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_four_weight_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_four_weight_four

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_four_weight_four_unfolded' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_four_weight_four_unfolded

/-- info: 'SocrateAI.ModularForms.not_selfDual_pin_level_four_mispaired' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms not_selfDual_pin_level_four_mispaired

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_nine_weight_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_nine_weight_four

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_four_weight_two' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_four_weight_two

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_four_zero_exp' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_four_zero_exp

/-- info: 'SocrateAI.ModularForms.rPinLevelFourWeightFour_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourWeightFour_weight

/-- info: 'SocrateAI.ModularForms.rPinLevelNineWeightFour_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelNineWeightFour_weight

/-- info: 'SocrateAI.ModularForms.rPinLevelFourWeightTwo_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourWeightTwo_weight

/-- info: 'SocrateAI.ModularForms.rPinLevelFourZero_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourZero_weight

/-- info: 'SocrateAI.ModularForms.rPinLevelFourMispaired_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourMispaired_weight

/-- info: 'SocrateAI.ModularForms.rPinLevelFourWeightFour_values_pin' does not depend on any axioms -/
#guard_msgs in #print axioms rPinLevelFourWeightFour_values_pin

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_four_weight_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_four_weight_four

/-- info: 'SocrateAI.ModularForms.prod_zpow_selfDual_pin_level_four_weight_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_selfDual_pin_level_four_weight_four

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_nine_weight_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_nine_weight_four

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_four_weight_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_four_weight_two

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_four_weight_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_four_weight_four

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_nine_weight_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_nine_weight_four

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_four_weight_two' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_four_weight_two

/-- info: 'SocrateAI.ModularForms.I_zpow_neg_four' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms I_zpow_neg_four

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_four_weight_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_four_weight_four

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_nine_weight_four' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_nine_weight_four

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_four_weight_two' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_four_weight_two

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_one_eta_calibration' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_one_eta_calibration

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_one_eta_calibration_agrees' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_one_eta_calibration_agrees

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_zero_exp' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_zero_exp

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_nine_weight_four_eta' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_nine_weight_four_eta

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_two_eta' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_two_eta

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_four_eta' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_four_eta

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_four_evidence_pairing' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_four_evidence_pairing

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_four_evidence_involution_fixed' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_four_evidence_involution_fixed

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_four_evidence_radicand' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_four_evidence_radicand

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_four_evidence_level_and_weight' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_four_evidence_level_and_weight

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_four_no_evidence_level_weight' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_four_no_evidence_level_weight

end SdfPin03

/-! ## `SDF-PIN-04` — the level-four, WEIGHT-ZERO eigenform identity, written out in `η`

`selfDual_eigen_pin_level_four_weight_zero_eta`
(`EtaQuotientFrickeSelfDual.lean`, section `SdfPin04`):

```
η(-1/(4z))⁻² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))⁻²  =  η(z)⁻² · η(2z)⁴ · η(4z)⁻²
```

the `(N, r, k) = (4, rPinLevelFourWeightZero, 0)` instance of `SDF-05`, `s = 1⁻²·2⁴·4⁻² = 1 = 4⁰`,
`λ = i^{-0} · √(4⁰) = 1`.  The fourth statement in the library with `etaQuotient`, `EtaExp`,
`frickeEigenvalue` and `IsFrickeSelfDual` all unfolded away; the FIRST with NEGATIVE exponents; and
the first whose radicand is `1` by CANCELLATION (`2⁴ · 4⁻²`) rather than because every factor is
separately `1`.  At `λ = 1` and `k = 0` the equation says the eta quotient `η(2z)⁴/(η(z)²η(4z)²)` is
INVARIANT under `z ↦ -1/(4z)`.

WHAT THE GUARDS BELOW ARE FOR, beyond the usual `sorryAx` watch.  This node is proved TWICE, and the
two proofs are kernel-verified independent (`scratch_sdfpin04/DepWalk.lean`, this run):
`selfDual_eigen_pin_level_four_weight_zero_eta` goes through `SDF-05` and hence `SDF-04`, `SDF-03`,
`SDF-02`, `SDF-DEF-01`, `SDF-DEF-02`, `SDF-16`; `..._eta_via_fricke` reaches the SAME equation from
`etaQuotient_fricke` (`F3.2-A7`) alone and touches NONE of those — its dual-vector collapse is the
hand-written `etaQuotient_dual_pin_level_four_weight_zero` over the bare `decide` fact
`rPinLevelFourWeightZero_dual_eq_pin`, and its constant is killed by
`prod_zpow_pin_level_four_weight_zero` and `Real.sqrt_one`.  `..._routes_agree` pairs them, so this
module's packaged constant agreeing with the upstream raw constant is a `lake build` obligation.
Likewise `prod_zpow_pin_level_four_weight_zero` (`s = 1` computed directly through negative `zpow`s)
and `prod_zpow_selfDual_pin_level_four_weight_zero` (`s = 4⁰` through `SDF-02`) are a two-route
product check, and `selfDual_cond_pin_level_four_weight_zero` (bare `decide`, through `SDF-16`) and
`..._unfolded` (`unfold IsFrickeSelfDual; decide`, no instance) discharge one hypothesis twice.
`selfDual_eigen_pin_level_four_weight_zero_regime_battery` makes the three named regimes — the
`N = 1` calibration against `eta_S_via_fricke`, the `r ≡ 0` case at this level, and the `N = 9`,
`k = 4` non-constant instance — a build obligation of this section as well.

READ THE LIMITATION BEFORE CITING THIS NODE — it is severe.  At `k = 0` EVERY component of
`λ = i^{-k} · N^k · s^{-1/2}` collapses to `1` for a reason that survives any misspelling of it:
`i^{-0} = i^{+0}`, `4⁰ = 9⁰`, `s = 1` so `(√s)⁻¹ = √s`, and `z⁰ = 1`.
`selfDual_eigen_pin_level_four_weight_zero_no_evidence_constant` states all four in Lean.  **This
node pins NO component of the Fricke constant** and must NOT be counted among this arc's
constant-pinning instances; those are `selfDual_eigen_pin_level_six` (`λ = 46656`),
`selfDual_eigen_pin_level_four_neg` (`λ = -2i`), `selfDual_eigen_pin_level_two_eta` (`λ = -i√2`) and
`selfDual_eigen_pin_level_four_weight_two_eta` (`λ = -4`), all guarded elsewhere in this file.  What
it DOES pin: the dual-vector substitution on a NON-constant vector
(`..._evidence_pairing`, `r 1 = -2 ≠ 4 = r 2`, with the same-weight negative control
`not_selfDual_pin_level_four_weight_zero_mispaired`), negative-exponent `zpow` bookkeeping in an
`η`-level identity (`..._evidence_negative_exponents`), and a radicand that genuinely cancels
(`..._evidence_radicand_cancels`).

NUMERICS, computed outside Lean this run at 60 dps from `η`'s product formula (1500 factors) and
only then asserted: relative error `≤ 2.9e-60` for the node at
`z ∈ {0.3+0.7i, -0.11+0.45i, 0.9+1.3i, i, 0.05+0.31i, -0.4+1.3i}`.  Negative controls at
`z = 0.3+0.7i`: `λ = -1` fails at relative error `2.0`, `λ = i` at `1.41`, `λ = 16` at `0.94`,
`λ = 1/16` at `15.0`, an inserted `z¹` at `1.30`, an inserted `z⁻¹` at `0.99`, and the mis-paired
vector `(0, 4, -4)` — same weight sum — at `0.73` (and it fails the equation outright at three
points, relative error `0.58`–`1.06`).  The quotient itself is NOT identically `1`
(`f(i) = 1.6944`, `f(0.3+0.7i) = 1.4192 - 0.1907i`), so the identity is not vacuous;
`rPinLevelFourWeightZero_ne_zero_pin` is its Lean-side receipt.

Three of the twenty-one footprints below are `does not depend on any axioms`
(`rPinLevelFourWeightZero_values_pin`, `..._evidence_pairing`, `..._evidence_negative_exponents`,
all closed by `decide` on a decidable proposition about the exponent vector alone), one is
`[propext]` (`rPinLevelFourWeightZero_ne_zero_pin`), and the other seventeen are
`[propext, Classical.choice, Quot.sound]`.  No `sorryAx` anywhere.  Must-fail control:
`verification/SdfPin04NegControl.lean`.

NAMING: `_weight_zero` is NOT `_zero_exp`.  `selfDual_eigen_pin_level_four_zero_exp` is the `r ≡ 0`
pin at this same level (zero EXPONENTS); this node has zero WEIGHT with non-zero exponents, and
`rPinLevelFourWeightZero_ne_zero_pin` is the receipt that the two vectors differ.  The node was
PROPOSED as `selfDual_pin_weight_zero`, a name that would have joined the `selfDual_pin_*`
CONJUNCTION family; the supplied statement was transcribed verbatim under that name and closed by
the shipped theorem as a bare term application (`scratch_sdfpin04/VerbatimCheck.lean`).  And the
condition `r δ = r (N / δ)` is SELF-DUAL (Fricke-symmetric), never "balanced". -/

section SdfPin04

/-- info: 'SocrateAI.ModularForms.rPinLevelFourWeightZero_values_pin' does not depend on any axioms -/
#guard_msgs in #print axioms rPinLevelFourWeightZero_values_pin

/-- info: 'SocrateAI.ModularForms.rPinLevelFourWeightZero_weight' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourWeightZero_weight

/-- info: 'SocrateAI.ModularForms.rPinLevelFourWeightZero_dual_eq_pin' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourWeightZero_dual_eq_pin

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_four_weight_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_four_weight_zero

/-- info: 'SocrateAI.ModularForms.selfDual_cond_pin_level_four_weight_zero_unfolded' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_cond_pin_level_four_weight_zero_unfolded

/-- info: 'SocrateAI.ModularForms.rPinLevelFourWeightZeroMispaired_weight' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms rPinLevelFourWeightZeroMispaired_weight

/-- info: 'SocrateAI.ModularForms.not_selfDual_pin_level_four_weight_zero_mispaired' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms not_selfDual_pin_level_four_weight_zero_mispaired

/-- info: 'SocrateAI.ModularForms.rPinLevelFourWeightZero_ne_zero_pin' depends on axioms: [propext] -/
#guard_msgs in #print axioms rPinLevelFourWeightZero_ne_zero_pin

/-- info: 'SocrateAI.ModularForms.prod_zpow_pin_level_four_weight_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_pin_level_four_weight_zero

/-- info: 'SocrateAI.ModularForms.prod_zpow_selfDual_pin_level_four_weight_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms prod_zpow_selfDual_pin_level_four_weight_zero

/-- info: 'SocrateAI.ModularForms.sqrt_natPow_level_four_weight_zero' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms sqrt_natPow_level_four_weight_zero

/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_pin_level_four_weight_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms frickeEigenvalue_pin_level_four_weight_zero

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_regime_battery' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_regime_battery

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_eta' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_eta

/-- info: 'SocrateAI.ModularForms.etaQuotient_dual_pin_level_four_weight_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms etaQuotient_dual_pin_level_four_weight_zero

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_eta_via_fricke' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_eta_via_fricke

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_routes_agree' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_routes_agree

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_evidence_pairing' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_evidence_pairing

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_evidence_negative_exponents' does not depend on any axioms -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_evidence_negative_exponents

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_evidence_radicand_cancels' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_evidence_radicand_cancels

/-- info: 'SocrateAI.ModularForms.selfDual_eigen_pin_level_four_weight_zero_no_evidence_constant' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in #print axioms selfDual_eigen_pin_level_four_weight_zero_no_evidence_constant

end SdfPin04
