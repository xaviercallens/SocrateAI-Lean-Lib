/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/

-- Core Foundations
import SocrateAI.Core.Algebra
import SocrateAI.Core.Topology
import SocrateAI.Core.Analysis
import SocrateAI.Core.Logic
import SocrateAI.Core.References

-- Duality & Scale
import SocrateAI.Duality.DualScale
import SocrateAI.Duality.T_Duality
import SocrateAI.Duality.EffectiveScale

-- K3 Surface Geometry
import SocrateAI.K3.K3Surfaces
import SocrateAI.K3.CooperSym2
import SocrateAI.K3.FDM_Candidates

-- Ramanujan Symmetric Sieve & Modular Forms
import SocrateAI.Ramanujan.RAMA
import SocrateAI.Ramanujan.CallensAlixKernel
import SocrateAI.Ramanujan.ShadowBridge

-- Navier-Stokes Regularity & Turbulence
import SocrateAI.NavierStokes.HypothesisU
import SocrateAI.NavierStokes.Enstrophy
import SocrateAI.NavierStokes.FrustrationIndex

-- String Theory & Compactifications
import SocrateAI.StringTheory.FTheory
import SocrateAI.StringTheory.Swampland
import SocrateAI.StringTheory.K3xT2
import SocrateAI.StringTheory.StringInequalities
import SocrateAI.StringTheory.KunnethProduct
import SocrateAI.StringTheory.VacuumSelection

-- Pregeometry & Hypergraphs
import SocrateAI.Pregeometry.HypergraphK4

-- Quantum Information & Holographic Error Correction
import SocrateAI.Quantum.GolayCode
import SocrateAI.Quantum.GolayM24

-- Moonshine, RAMA η-Quotient & Vacuum Energy (Papers I–III)
import SocrateAI.Moonshine.RAMA_EtaQuotient
import SocrateAI.Moonshine.MathieuBispectrum
import SocrateAI.Moonshine.VacuumEnergy
import SocrateAI.Moonshine.M24Representations

-- Inflationary Observables (Paper I §6)
import SocrateAI.Inflation.InflationaryObservables

-- Cosmological Phenomenology & Bayesian Evidence (Paper II §7)
import SocrateAI.Cosmology.BayesianEvidence
import SocrateAI.Cosmology.MoonshineVacuum
import SocrateAI.Cosmology.Inflation
import SocrateAI.Cosmology.DarkEnergy

-- Particle Physics Applications (Paper III)
import SocrateAI.ParticlePhysics.IndexTheorem
import SocrateAI.ParticlePhysics.PMNS

-- Chameleon Gravity & Modified Gravity (DAC sub-article)
import SocrateAI.ChameleonGravity.DACModel

-- Extremal Level-12 Eta-Quotient (sub-article) -- QUARANTINED 2026-09-10: its exponent vector is
-- indexed over d=1..12 rather than the divisors of 12, so "level 12" is false and every derived
-- quantity (weight, zero-point energy, central charge) inherits the wrong indexing. No theorem in
-- it is false (all numeral arithmetic), only its docstrings' claim about what the arithmetic is
-- evidence for. See Lean/SocrateAI/Quarantine/ExtremalLevel12Refuted.lean and
-- docs/Lean4_FrickeEigenspace.tex for the audit. PHY-01 (dag/theorems.jsonl) is re-scoped
-- accordingly and no longer depends on this content.

-- Modular Forms & Poincaré Upper Half-Plane (sub-article)
import SocrateAI.ModularForms.PoincareUpperHalfPlane

-- Core Tier Calculus (SocrateAI-Mathesis foundation)
import SocrateAI.Core.TierCalculus

-- AlienMath Non-Anthropocentric Foundations
import SocrateAI.AlienMath.KalChargingMatrix
import SocrateAI.AlienMath.KalHolographicBorderRank
import SocrateAI.AlienMath.ExactRationalWitness

-- Generated Blueprint & Ingestion Skeletons
import SocrateAI.Generated.BlueprintSkeleton

-- Scratch Database for Sub-Articles
import SocrateAI.LeanScratchDB
import SocrateAI.ModularForms.FrickeInvolution
import SocrateAI.FinalCheck
import SocrateAI.ModularForms.FrickeSlash
import SocrateAI.ModularForms.FrickeModular
import SocrateAI.ModularForms.FrickeComposite

-- Run 5 (TDUAL-*): T-duality on the T^2 complex-structure modulus, attempted reduction to the
-- Fricke involution. TDUAL-M0..M4 are PROVED, sorry-free, and reusable (frickeW_smul_coe links
-- the GL(2,R)-action language of the Fricke*.lean files to the -1/(N*z) normal form). TDUAL-01,
-- the bridge itself, is CONTESTED, not merely open: an independent review found it equivalent to
-- M1 AND M2 AND M3 with no added content, and found no primary-literature support for the level-N
-- physics attribution at any N > 1 (see the DAG node and Lean4_Fricke_Involution.tex). Its sorry
-- stays open under an inverted FinalCheck tripwire; do not close it as a proof of this statement.
import SocrateAI.StringTheory.TDualityBridge

-- Eta quotients & Ligozat's criterion (F3.1 arithmetic layer, F3.2 analytic layer)
import SocrateAI.ModularForms.EtaQuotient
import SocrateAI.ModularForms.EtaQuotientModularity
import SocrateAI.ModularForms.EtaQuotientPrimeLevel
-- F3.1-B13 (order at the cusp `∞` in Mathlib's `meromorphicOrderAt` language) and the
-- F3.1-OBSTRUCTED record (why the other cusps are out of reach).
import SocrateAI.ModularForms.EtaQuotientCuspOrder

-- Run 6 (SDF-*): the Fricke-SELF-DUAL specialisation of `etaQuotient_fricke` — when
-- `r δ = r (N/δ)` the Fricke transform returns the SAME eta quotient, so the transformation law
-- becomes an eigenform relation with eigenvalue `i^{-k}·N^{k/2}`.  STATEMENT LAYER ONLY: every
-- declaration is `sorry`.  Named "self-dual", never "balanced" (that word is taken by the
-- unrelated `exists_balanced_add`); see the file header.
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

-- Run 4 (DRK-*): Dedekind sums, Apostol's Φ / Rademacher's Ψ, and the η multiplier system.
-- DedekindSum + RademacherPhi carry the DRK-00 sign-discipline gate and are import-light on
-- purpose (no η, no ℍ); EtaMultiplier is where the analysis enters and is entirely `sorry`.
import SocrateAI.NumberTheory.DedekindSum
import SocrateAI.NumberTheory.RademacherPhi
import SocrateAI.NumberTheory.DedekindSumJacobi
import SocrateAI.ModularForms.EtaMultiplier
-- DRK-08 (etaMultiplierVal_neg, exists_pos_lower_left_or_T_zpow).  Imports ONLY
-- EtaQuotientModularity: it uses no Dedekind sum, no Phi, no analysis.  See the file header.
import SocrateAI.ModularForms.EtaMultiplierNeg
import SocrateAI.ModularForms.EtaPhiSum
import SocrateAI.ModularForms.KroneckerJacobi
-- DRK-11 (run 4): the closed-form eta multiplier vs Ligozat's Kronecker character.  Proved:
-- the exponential layer (the node reduces to a congruence mod 24), the node's conclusion for
-- 0 < N <= 4, eleven kernel pins and four negative controls.  UNPROVED: general N (one sorry).
import SocrateAI.ModularForms.EtaLigozatKronecker
import SocrateAI.ModularForms.EtaLigozatGeneral

-- Run 7 (FRK-11 closed as a STATEMENT, FRK-12..FRK-27, SDF-17..SDF-20): the Fricke EIGENSPACE
-- DECOMPOSITION on Mathlib's bundled `ModularForm (Gamma0GL N) (2*m)`, built on the already
-- sorry-free `frickeW_sq_slash` (FRK-10) and `frickeModularOperator` (FRK-09).  STATEMENT LAYER:
-- FRK-12..FRK-16 and all eleven decide-pins are proved; everything else is `sorry` with an
-- `-- OPEN:` comment.  The eta-quotient lift ships in TWO honest forms and NEITHER assumes
-- modularity: SDF-18 takes `f : ModularForm ...` plus `hf : ∀ τ, f τ = etaQuotientH N r τ` as
-- explicit HYPOTHESES at general N, and SDF-19 is restricted to `0 < N ≤ 4` where the library's
-- own `etaQuotientModularForm` supplies the transformation law -- and even there Ligozat's
-- condition (iii) (`hbd`) stays a hypothesis.  Odd weight is VACUOUS (FRK-24) and said so.
import SocrateAI.ModularForms.FrickeEigenspace
