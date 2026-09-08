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

-- Extremal Level-12 Eta-Quotient (sub-article)
import SocrateAI.Moonshine.ExtremalEtaQuotient

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

-- Eta quotients & Ligozat's criterion (F3.1 arithmetic layer, F3.2 analytic layer)
import SocrateAI.ModularForms.EtaQuotient
import SocrateAI.ModularForms.EtaQuotientModularity
import SocrateAI.ModularForms.EtaQuotientPrimeLevel
-- F3.1-B13 (order at the cusp `∞` in Mathlib's `meromorphicOrderAt` language) and the
-- F3.1-OBSTRUCTED record (why the other cusps are out of reach).
import SocrateAI.ModularForms.EtaQuotientCuspOrder

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
