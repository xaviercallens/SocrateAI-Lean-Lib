/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/

import SocrateAI.Quantum.GolayM24

namespace Tests.TestQuantumM24

open SocrateAI.Quantum.GolayM24

theorem test_golay_parameters :
    golayN = 24 ∧ golayK = 12 ∧ golayD = 8 :=
  golay_parameters

theorem test_golay_capacity : golayErrorCapacity = 3 :=
  golay_corrects_3_errors

theorem test_golay_redundancy : golayRedundancy = 12 :=
  golay_redundancy_is_12

theorem test_extended_golay_not_perfect : extendedGolayIsPerfect = false :=
  extended_golay_not_perfect

theorem test_perfect_golay_hamming :
    1 + 23 + 23*22/2 + 23*22*21/6 = 2^11 :=
  perfect_golay_hamming_bound

theorem test_css_parameters :
    cssN = 24 ∧ cssK = 0 ∧ cssD = 8 :=
  css_parameters

theorem test_entropy_half_block : topologicalEntropy 12 = 12 :=
  half_block_entropy

theorem test_mathieu_order : mathieuM24Order = 244823040 :=
  mathieuM24Order_value

theorem test_mathieu_order_factored :
    2^10 * 3^3 * 5 * 7 * 11 * 23 = mathieuM24Order :=
  mathieuM24Order_factored

theorem test_generation_discrepancy :
    predictedGenerationCount - observedGenerationCount = 1 :=
  generation_discrepancy

end Tests.TestQuantumM24
