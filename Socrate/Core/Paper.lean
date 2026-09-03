/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import Socrate.Core.Ontology

namespace Socrate.Core

/-- Bibliographic and provenance metadata for a formalized scientific paper. -/
structure PaperMetadata where
  title : String
  authors : List String
  year : Nat
  venue : String
  doi : Option String := none
  abstract : String := ""
  domain : ScientificDomain
  bibtexKey : String := ""
  deriving Repr, Inhabited

/-- Record of an assumption or hypothesis upon which theoretical theorems depend. -/
structure Assumption where
  name : String
  hypothesis : Prop
  justification : String := "Theoretical postulate or empirical idealization"

/-- A verified scientific claim within a formalized scientific publication. -/
structure Claim where
  id : String
  title : String
  claimType : ClaimType
  evidenceLevel : EvidenceLevel
  description : String
  regime : Option String := none
  falsification : Option FalsificationCondition := none

/-- Formal representation of a scientific paper combining metadata and verified claims. -/
structure ScientificPaper where
  metadata : PaperMetadata
  claims : List Claim
  assumptions : List Assumption := []

/-- Generates a formatted scientific report summary of a paper. -/
def ScientificPaper.summary (p : ScientificPaper) : String :=
  let auths := String.intercalate ", " p.metadata.authors
  let doiStr := match p.metadata.doi with
    | some d => s!" (DOI: {d})"
    | none => ""
  s!"════════════════════════════════════════════════════════════════\n" ++
  s!"Paper: {p.metadata.title}\n" ++
  s!"Authors: {auths} ({p.metadata.year})\n" ++
  s!"Venue: {p.metadata.venue}{doiStr}\n" ++
  s!"Domain: {p.metadata.domain}\n" ++
  s!"Claims: {p.claims.length} registered | Assumptions: {p.assumptions.length}\n" ++
  s!"════════════════════════════════════════════════════════════════"

end Socrate.Core
