import Lake
open Lake DSL

package "SocrateAI" where
  version := v!"1.0.0"
  keywords := #["science", "k3", "string-theory", "navier-stokes", "duality", "formalization"]

@[default_target]
lean_lib «SocrateAI» where
  srcDir := "Lean"

@[default_target]
lean_lib «Tests» where
  srcDir := "Lean"
