/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import Lean

namespace Socrate.Meta

open Lean Meta

/-- Attribute marking a definition or theorem as a core claim of a formalized scientific paper. -/
initialize paperClaimAttr : TagAttribute ←
  registerTagAttribute `paper_claim
    "Marks a definition or theorem as a formalized claim of a scientific paper."

/-- Attribute marking a scientific claim as having an explicit falsification criterion. -/
initialize falsifiableAttr : TagAttribute ←
  registerTagAttribute `falsifiable
    "Attaches Popperian falsification criteria to a formal scientific statement."

/-- Attribute marking an empirical assumption, domain idealization, or simplifying hypothesis. -/
initialize empiricalAssumptionAttr : TagAttribute ←
  registerTagAttribute `empirical_assumption
    "Identifies an empirical idealization or domain-specific assumption in a theoretical model."

/-- Helper to check if a declaration is tagged as a scientific paper claim. -/
def isPaperClaim (env : Environment) (declName : Name) : Bool :=
  paperClaimAttr.hasTag env declName

/-- Helper to check if a declaration is tagged as an empirical assumption. -/
def isEmpiricalAssumption (env : Environment) (declName : Name) : Bool :=
  empiricalAssumptionAttr.hasTag env declName

end Socrate.Meta
