/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/

namespace Socrate.Core

/-- Scientific disciplines supported for formalization and cross-disciplinary linkage. -/
inductive ScientificDomain where
  | Physics
  | Chemistry
  | Biology
  | Medicine
  | ComputerScience
  | AITheory
  | Mathematics
  | Economics
  | Interdisciplinary (name : String)
  deriving Repr, DecidableEq, Inhabited

instance : ToString ScientificDomain where
  toString
    | .Physics => "Physics"
    | .Chemistry => "Chemistry"
    | .Biology => "Biology"
    | .Medicine => "Medicine"
    | .ComputerScience => "Computer Science"
    | .AITheory => "AI & Machine Learning Theory"
    | .Mathematics => "Mathematics"
    | .Economics => "Economics & Social Systems"
    | .Interdisciplinary s => s!"Interdisciplinary ({s})"

/-- Epistemological categorization of scientific claims in papers and theories. -/
inductive ClaimType where
  /-- Deductively proven from theoretical axioms or established theorems. -/
  | TheoreticalTheorem
  /-- Empirically supported law grounded in observational or experimental data. -/
  | EmpiricalFinding
  /-- Foundational axiom or postulate taken as fundamental starting point. -/
  | Postulate
  /-- Idealization, perturbation, or simplifying approximation with bounded error. -/
  | Approximation
  /-- Hypothesized result supported by heuristics, simulations, or open conjectures. -/
  | Conjecture
  deriving Repr, DecidableEq, Inhabited

instance : ToString ClaimType where
  toString
    | .TheoreticalTheorem => "Theoretical Theorem"
    | .EmpiricalFinding   => "Empirical Finding"
    | .Postulate          => "Postulate / Axiom"
    | .Approximation      => "Approximation / Idealization"
    | .Conjecture         => "Conjecture / Hypothesis"

/-- Level of supporting evidence for scientific claims. -/
inductive EvidenceLevel where
  /-- Verified deductive proof formalized in Lean 4 without ungrounded sorries. -/
  | DeductiveProof
  /-- Confirmed through multiple independent empirical replications. -/
  | EmpiricalReplication (nReplications : Nat)
  /-- Grounded in a peer-reviewed empirical study. -/
  | SingleStudy (doi : String)
  /-- Verified via reproducible Monte-Carlo or numerical simulation. -/
  | Simulation
  /-- Theoretical proposal or hypothesis awaiting experimental validation. -/
  | Speculative
  deriving Repr, Inhabited

/-- Current verification and peer-consensus status of a scientific claim. -/
inductive ClaimStatus where
  | Active
  | UnderReview
  | Refuted (reason : String)
  | Superseded (byClaimId : String)
  deriving Repr, Inhabited

/-- Formal specification of the physical or mathematical regime where a claim is valid.
    Examples:
    - Non-relativistic: `v / c < 0.01`
    - High temperature: `T > 300 K`
    - Asymptotic: `N >= 1000` -/
structure RegimeOfValidity where
  description : String
  condition : Prop
  isSatisfied : Decidable condition := by infer_instance

/-- Popperian falsification specification: describes an observable condition
    that, if experimentally observed, refutes the scientific claim. -/
structure FalsificationCondition where
  description : String
  counterHypothesis : Prop

end Socrate.Core
