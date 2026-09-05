/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.AlienMath.ExactRationalWitness
import SocrateAI.AlienMath.KalChargingMatrix
import SocrateAI.AlienMath.KalHolographicBorderRank

namespace Tests.TestAlienMath

open SocrateAI.AlienMath.ExactRationalWitness
open SocrateAI.AlienMath.KalChargingMatrix
open SocrateAI.AlienMath.KalHolographicBorderRank

-- Test ExactRationalWitness
def testDecomp : QuadraticSOSDecomposition := {
  linearShift := 3,
  remainderDiscrim := 5,
  hDiscrimNonNeg := by decide
}

theorem test_sos_nonneg : 0 ≤ evalSOS testDecomp :=
  certified_quadratic_nonneg testDecomp

-- Test KalChargingMatrix
def matrixA : KalMatrix2D := { q1 := 2, q2 := 3, delta := 1 }
def matrixB : KalMatrix2D := { q1 := 1, q2 := 4, delta := -1 }

theorem test_total_charge_additive :
    totalCharge (add matrixA matrixB) = totalCharge matrixA + totalCharge matrixB :=
  total_charge_additive matrixA matrixB

theorem test_charging_potential_nonneg :
    0 ≤ chargingPotential matrixA :=
  charging_potential_nonnegative matrixA (by decide) (by decide)

-- Test KalHolographicBorderRank
theorem test_zero_area_unentangled : 2 ^ 0 = 1 :=
  zero_area_unentangled

end Tests.TestAlienMath
