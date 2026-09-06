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
