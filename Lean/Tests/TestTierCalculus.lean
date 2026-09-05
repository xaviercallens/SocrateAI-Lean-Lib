/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.Core.TierCalculus

namespace Tests.TestTierCalculus

open SocrateAI.Core.TierCalculus

theorem test_A_max : ∀ (t : Tier), t ≤ Tier.A :=
  Tier.le_A

theorem test_X_min : ∀ (t : Tier), Tier.X ≤ t :=
  Tier.X_le

theorem test_rank_ordering : Tier.B ≤ Tier.A := by decide

theorem test_conjecture_below_kernel : Tier.C ≤ Tier.A := by decide

end Tests.TestTierCalculus
