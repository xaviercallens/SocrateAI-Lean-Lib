/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.ChameleonGravity.DACModel

namespace Tests.TestChameleonGravity

open SocrateAI.ChameleonGravity.DACModel

def sampleParams : DACParams := { mu2 := 2, lambda := 1, bigM2 := 5 }

theorem test_critical_density : criticalDensity sampleParams = 10 := by rfl

theorem test_regime_I_mass : effectiveMassProxy sampleParams 4 > 0 :=
  regime_I_mass_positive sampleParams 4 (by decide)

theorem test_regime_I_fifth_force : fifthForceRegimeI = 0 :=
  regime_I_fifth_force_vanishes

end Tests.TestChameleonGravity
