/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.Core.Algebra
import SocrateAI.Core.Topology
import SocrateAI.Core.Analysis
import SocrateAI.Core.Logic

namespace Tests.TestCore

open SocrateAI.Core.Algebra
open SocrateAI.Core.Topology
open SocrateAI.Core.Analysis
open SocrateAI.Core.Logic

-- Test Algebra
theorem test_int_sq_nonneg : 0 ≤ (-5 : Int) * (-5) :=
  int_sq_nonneg (-5)

theorem test_amgm_defect : 0 ≤ amgmDefect 10 7 :=
  amgm_defect_nonneg 10 7

theorem test_sum_of_squares : 0 ≤ (3 : Int) * 3 + (4 : Int) * 4 :=
  sum_of_squares_nonneg 3 4

-- Test Topology
theorem test_euler_T2 : eulerChar2D bettiT2 = 0 :=
  euler_char_T2

theorem test_euler_K3 : eulerChar4D bettiK3 = 24 :=
  euler_char_K3

theorem test_euler_K3xT2 : productEulerChar (eulerChar4D bettiK3) (eulerChar2D bettiT2) = 0 :=
  euler_char_K3xT2

-- Test Analysis
theorem test_viscous_dissipation : energyDissipationRate 1 10 ≤ 0 :=
  dissipation_nonpositive 1 10 (by decide) (by decide)

-- Test Logic
theorem test_modus_tollens (P Q : Prop) (h1 : P → Q) (h2 : ¬Q) : ¬P :=
  modus_tollens P Q h1 h2

theorem test_consistency : isConsistent True :=
  true_theory_is_consistent True trivial

end Tests.TestCore
