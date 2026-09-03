/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.Duality.DualScale
import SocrateAI.Duality.T_Duality
import SocrateAI.Duality.EffectiveScale

namespace Tests.TestDuality

open SocrateAI.Duality.DualScale
open SocrateAI.Duality.T_Duality
open SocrateAI.Duality.EffectiveScale

-- Test DualScale
theorem test_self_dual : isDualPair 10 10 10 :=
  self_dual_at_crossover 10

theorem test_dual_symmetry : isDualPair 10 10 10 :=
  dual_pair_symmetric 10 10 10 (self_dual_at_crossover 10)

-- Test T_Duality
theorem test_t_duality_involution :
    tDualState (tDualState { n := 3, w := 5 }) = { n := 3, w := 5 } :=
  t_duality_involution { n := 3, w := 5 }

theorem test_self_dual_mass_symmetry :
    selfDualMassFactor 2 3 = selfDualMassFactor 3 2 :=
  self_dual_mass_symmetry 2 3

-- Test EffectiveScale
def testHierarchy : ScaleHierarchy := {
  mEW := 100
  mKK := 1000
  mString := 10000
  mPlanck := 100000
  h1 := by decide
  h2 := by decide
  h3 := by decide
}

theorem test_ew_le_planck : testHierarchy.mEW ≤ testHierarchy.mPlanck :=
  ew_bounded_by_planck testHierarchy

end Tests.TestDuality
