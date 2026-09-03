/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import Lean
import Socrate.Meta.Attributes

namespace Socrate.Meta

open Lean Meta Elab Command

/-- Command `#inspect_claim <decl>`: inspects a theorem or definition in the scientific formalization,
    reporting its statement, epistemological tags, and verification status. -/
syntax (name := inspectClaim) "#inspect_claim " ident : command

@[command_elab inspectClaim]
def elabInspectClaim : CommandElab := fun stx => do
  match stx with
  | `(#inspect_claim $id:ident) => do
    let resolvedNames ← liftCoreM <| Lean.resolveGlobalConst id
    match resolvedNames.head? with
    | some declName =>
      let env ← getEnv
      match env.find? declName with
      | some cinfo =>
        let isClaim := isPaperClaim env declName
        let isAssumption := isEmpiricalAssumption env declName
        let claimBadge := if isClaim then "[CLAIM]" else ""
        let assumpBadge := if isAssumption then "[ASSUMPTION]" else ""
        let msg : MessageData :=
          m!"═══════════════════════════════════════════════════════\n" ++
          m!"🔬 Scientific Declaration: {declName} {claimBadge} {assumpBadge}\n" ++
          m!"Type: {cinfo.type}\n" ++
          m!"Is Paper Claim: {isClaim}\n" ++
          m!"Is Empirical Assumption: {isAssumption}\n" ++
          m!"═══════════════════════════════════════════════════════"
        logInfo msg
      | none =>
        throwError "Unknown declaration '{declName}'"
    | none =>
      throwError "Identifier '{id.getId}' cannot be resolved in current scope"
  | _ => throwUnsupportedSyntax

end Socrate.Meta
