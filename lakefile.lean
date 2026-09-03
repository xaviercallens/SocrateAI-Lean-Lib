import Lake
open Lake DSL

package "SocrateAI" where
  version := v!"0.1.0"
  keywords := #["science", "formalization", "research", "theory", "paper"]
  description := "Lean 4 foundation library and tooling for formal scientific papers, theories, and empirical research"

lean_lib «Socrate» where
  -- Core library targets and settings

@[default_target]
lean_exe "socrate" where
  root := `Socrate.Main

/-
-- Optional Mathlib Integration:
-- To enable Mathlib for advanced real analysis, measure theory, or topology:
-- 1. Uncomment the following require:
-- require "leanprover-community" / "mathlib" @ git "v4.33.1"
-- 2. Run: lake update && lake exe cache get && lake build
-/
