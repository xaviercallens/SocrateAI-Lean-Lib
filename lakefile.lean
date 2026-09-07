import Lake
open Lake DSL

package "SocrateAI" where
  version := v!"1.0.0"
  keywords := #["number-theory", "modular-forms", "formalization", "mathlib"]

-- Mathlib is pinned to the exact revision every theorem in this library was checked against.
-- v4.32.2 == 905b95818eb32af7874a58b427f50c1711a5e96c (2026-07-28); lean-toolchain matches.
require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.32.2"

@[default_target]
lean_lib «SocrateAI» where
  srcDir := "Lean"

@[default_target]
lean_lib «Tests» where
  srcDir := "Lean"
