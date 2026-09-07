/- NEGATIVE CONTROL for FinalCheck.lean (Mathesis HARDNESS.md H2: a checker that cannot
   fail is not a checker).  This file claims a deliberately WRONG axiom footprint and must
   FAIL to compile.  It lives in scratch/ (outside the library target) precisely so the
   build stays green while the control stays runnable:
     lake env lean scratch/GuardNegativeControl.lean   # must exit nonzero -/
import SocrateAI.ModularForms.FrickeInvolution
open SocrateAI.ModularForms
/-- info: 'SocrateAI.ModularForms.frickeW_sq_coe' depends on axioms: [] -/
#guard_msgs in #print axioms frickeW_sq_coe
