/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.Moonshine.RAMA_EtaQuotient
import SocrateAI.Moonshine.MathieuBispectrum
import SocrateAI.Moonshine.VacuumEnergy

namespace Tests.TestMoonshine

open SocrateAI.Moonshine.RAMA_EtaQuotient
open SocrateAI.Moonshine.MathieuBispectrum
open SocrateAI.Moonshine.VacuumEnergy

-- Test RAMA Eta Quotient
theorem test_rama_sum : (24 : Int) + 23 + (-14) + 9 * (-24) = -183 :=
  ramaExponents12_sum_is_minus183

theorem test_rama_weight : ramaWeightNum = -183 :=
  ramaTwiceWeight

theorem test_rama_central_charge : ramaEffCentralCharge = 1701 :=
  ramaEffCentralCharge_is_1701

theorem test_rama_coeff1 : ramaCoeff1 = -(2^3 * 3) :=
  ramaCoeff1_factored

theorem test_rama_coeff5 : ramaCoeff5 = 2 * 3 * 4157 :=
  ramaCoeff5_factored

-- Test Mathieu Bispectrum
theorem test_mathieu_a1_decomp : mathieuA1 = 45 + 45 :=
  mathieuA1_decomposition

theorem test_mathieu_a2_decomp : mathieuA2 = 231 + 231 :=
  mathieuA2_decomposition

theorem test_mathieu_rigidity : mathieuA2 * 60 = 360 * 77 :=
  mathieu_rigidity_ratio_verified

theorem test_bispectrum_irreducible : Nat.gcd bRatioNum bRatioDen = 1 :=
  bispectrum_ratio_irreducible

-- Test Vacuum Energy
theorem test_vacuum_discriminant : vacuumDiscriminant = 23 :=
  discriminant_is_23

theorem test_hierarchy_gap : remainingHierarchyGap = 81 :=
  hierarchy_gap_is_81

theorem test_corrected_differs_from_old : logIntermediateRho ≠ oldFalseLogClaim :=
  corrected_claim_differs_from_old_false_claim

end Tests.TestMoonshine
