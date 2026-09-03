/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.StringTheory.FTheory
import SocrateAI.StringTheory.Swampland
import SocrateAI.StringTheory.K3xT2

namespace Tests.TestStringTheory

open SocrateAI.StringTheory.FTheory
open SocrateAI.StringTheory.Swampland
open SocrateAI.StringTheory.K3xT2

-- Test FTheory
theorem test_weierstrass_origin : weierstrassDiscriminant 0 0 = 0 :=
  discriminant_origin_zero

theorem test_weierstrass_7brane : weierstrassDiscriminant (-3) 2 = 0 :=
  discriminant_example_7brane

theorem test_e8_rank : fiberGaugeRank .TypeIIStar = 8 :=
  e8_fiber_rank_is_8

-- Test Swampland
theorem test_sdc_monotonicity :
    let dc1 : DistanceConjecture := { alpha := 2, moduliDistance := 3 }
    let dc2 : DistanceConjecture := { alpha := 2, moduliDistance := 5 }
    dc1.logMassSuppression ≤ dc2.logMassSuppression :=
  distance_conjecture_monotonicity 2 3 5 (by decide)

theorem test_wgc_extremality : satisfiesWGC ⟨1, 1, by decide⟩ :=
  extremality_satisfies_wgc 1 (by decide)

-- Test K3xT2
theorem test_k3xt2_dim : dimRealK3xT2 = 6 :=
  dim_real_k3xt2_is_6

theorem test_4d_target : targetSpacetimeDim = 4 :=
  target_spacetime_is_4d

theorem test_susy_N4 : typeII_4D_N = 4 :=
  typeII_k3xt2_susy_N4

theorem test_euler_vanishing :
    SocrateAI.Core.Topology.eulerChar4D SocrateAI.Core.Topology.bettiK3 *
    SocrateAI.Core.Topology.eulerChar2D SocrateAI.Core.Topology.bettiT2 = 0 :=
  euler_char_vanishes

end Tests.TestStringTheory
