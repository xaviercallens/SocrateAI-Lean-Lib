/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team

TIER B — Phenomenological limits.

Source: Paper III §2.3 Theorem 2.1 "Numerical PMNS Predictions from Fricke Attractor"
-/

namespace SocrateAI.ParticlePhysics.PMNS

/-- PMNS CP phase δ_CP predicted to be 282.4 degrees -/
def delta_cp_num : Nat := 2824
def delta_cp_den : Nat := 10

/-- Sum of neutrino masses predicted to be 0.059 eV -/
def sum_m_nu_num : Nat := 59
def sum_m_nu_den : Nat := 1000

/-- These are phenomenological bounds explicitly labelled as Tier B. -/
def pmns_phenomenological_bounds : Bool := true

end SocrateAI.ParticlePhysics.PMNS
