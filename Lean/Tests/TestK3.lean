/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.K3.K3Surfaces
import SocrateAI.K3.CooperSym2
import SocrateAI.K3.FDM_Candidates

namespace Tests.TestK3

open SocrateAI.K3.K3Surfaces
open SocrateAI.K3.CooperSym2
open SocrateAI.K3.FDM_Candidates

-- Test K3Surfaces
theorem test_k3_b2 : b2FromHodge k3HodgeDiamond = 22 :=
  k3_b2_is_22

theorem test_k3_lattice_rank : k3LatticeRank {} = 22 :=
  k3_lattice_rank_valid

theorem test_k3_signature : (k3SignaturePos : Int) - (k3SignatureNeg : Int) = -16 :=
  k3_signature_is_minus_16

-- Test CooperSym2
theorem test_sym2_dim : sym2Dim 2 = 3 :=
  sym2_L2_dim_is_3

theorem test_veronese_quadric : veroneseQuadricDefect (2 * 5) (5 * 5) = 0 :=
  cooper_pair_veronese_quadric 5

-- Test FDM Candidates
theorem test_fdm_ultralight :
    let inst : InstantonSuppression := { instantonAction := 70 }
    inst.effectiveExponent ≤ -22 :=
  ultralight_condition 70 (by decide)

end Tests.TestK3
