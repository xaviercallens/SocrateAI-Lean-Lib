/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.Ramanujan.RAMA
import SocrateAI.Ramanujan.CallensAlixKernel
import SocrateAI.Ramanujan.ShadowBridge

namespace Tests.TestRamanujan

open SocrateAI.Ramanujan.RAMA
open SocrateAI.Ramanujan.CallensAlixKernel
open SocrateAI.Ramanujan.ShadowBridge

-- Test RAMA
theorem test_tau_multiplicative : (-24 : Int) * 252 = -6048 :=
  ramanujan_tau_6_multiplicative

theorem test_tau_recurrence : tauPrimeSquare (-24) 2 = -1472 :=
  ramanujan_tau_4_recurrence

-- Test CallensAlixKernel
theorem test_kernel_involution : mirrorReflection20 (mirrorReflection20 7) = 7 :=
  mirror_reflection_involution 7

theorem test_kernel_center : mirrorReflection20 10 = 10 :=
  mirror_reflection_center

theorem test_kernel_nonneg : 0 ≤ callensAlixKernelCanonical 3 (-4) :=
  kernel_nonnegative 3 (-4)

-- Test ShadowBridge
theorem test_shadow_cancellation : (15 : Int) + (-15) = 0 :=
  shadow_bridge_exact_cancellation 15

end Tests.TestRamanujan
