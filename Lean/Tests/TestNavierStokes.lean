/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.NavierStokes.HypothesisU
import SocrateAI.NavierStokes.Enstrophy
import SocrateAI.NavierStokes.FrustrationIndex

namespace Tests.TestNavierStokes

open SocrateAI.NavierStokes.HypothesisU
open SocrateAI.NavierStokes.Enstrophy
open SocrateAI.NavierStokes.FrustrationIndex

-- Test HypothesisU
theorem test_bkm_finite : 0 ≤ (10 : Int) * 5 :=
  bkm_integral_finite_int 10 5 (by decide) (by decide)

theorem test_hypothesis_u_regular : isRegularContinuation 40 (10 * 5) :=
  hypothesis_u_guarantees_regularity 10 5 40 (by decide)

-- Test Enstrophy
def test2DBalance : EnstrophyBalance := {
  omega := 10
  vortexStretching := 0
  palinstrophy := 2
  nu := 1
  hOmegaNonNeg := by decide
  hPalinNonNeg := by decide
  hNuNonNeg := by decide
}

theorem test_2d_enstrophy_decay : enstrophyDerivative test2DBalance ≤ 0 :=
  enstrophy_2d_decay test2DBalance rfl

-- Test FrustrationIndex
def testFrustrationFull : TriadicFrustration := {
  frustrationScore := 100
  maxTransfer := 500
  hScoreBound := by decide
  hMaxPos := by decide
}

theorem test_complete_frustration_arrest :
    effectiveTransfer testFrustrationFull = 0 :=
  complete_frustration_arrest testFrustrationFull rfl

end Tests.TestNavierStokes
