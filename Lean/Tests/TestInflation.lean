/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.Inflation.InflationaryObservables

namespace Tests.TestInflation

open SocrateAI.Inflation.InflationaryObservables

theorem test_efolds_squared : efoldsN * efoldsN = 3025 :=
  Ne_squared

theorem test_r_denom : rDenominator = 3025 :=
  r_denominator_exact

theorem test_r_irreducible : Nat.gcd rNumerator rDenominator = 1 :=
  r_irreducible

theorem test_r_scaled : r_scaled_x1e5 = 396 :=
  r_scaled_value

theorem test_ns_numerator : efoldsN - 2 = nsNumerator :=
  ns_numerator_correct

theorem test_ns_scaled : ns_scaled_x10000 = 9636 :=
  ns_scaled_value

theorem test_ns_in_planck_range : ns_scaled_x10000 ≥ 9600 :=
  ns_in_Planck_range

theorem test_r_detectable_by_litebird : r_scaled_x1e5 ≥ 3 * liteBIRD_sigma_r_x1e5 :=
  r_detectable_by_liteBIRD

end Tests.TestInflation
