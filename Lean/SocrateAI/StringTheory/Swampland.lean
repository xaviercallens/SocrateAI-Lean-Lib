/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/

namespace SocrateAI.StringTheory.Swampland

/-- Swampland Distance Conjecture (SDC):
    For a displacement $\Delta\phi$ in moduli space, a tower of states has mass
    $m(\Delta\phi) \le m_0 \cdot \exp(-\alpha \Delta\phi)$ where $\alpha > 0$.
    Expressed in discrete logarithmic units:
    $\log(m_0 / m) \ge \alpha \cdot \Delta\phi$. -/
structure DistanceConjecture where
  alpha : Nat -- α in integer basis units (α ≥ 1)
  moduliDistance : Nat
  logMassSuppression : Nat := alpha * moduliDistance

/-- Theorem: Monotonic mass suppression with moduli excursion:
    Moving farther in moduli space ($\Delta\phi_1 \le \Delta\phi_2$) monotonically decreases
    the mass of the light tower (increases the mass suppression factor).
    Proven via Nat.mul_le_mul_left. -/
theorem distance_conjecture_monotonicity (alpha d1 d2 : Nat)
    (hLe : d1 ≤ d2) :
    let dc1 : DistanceConjecture := { alpha := alpha, moduliDistance := d1 }
    let dc2 : DistanceConjecture := { alpha := alpha, moduliDistance := d2 }
    dc1.logMassSuppression ≤ dc2.logMassSuppression :=
  Nat.mul_le_mul_left alpha hLe

/-- Weak Gravity Conjecture (WGC) state:
    For any consistent $U(1)$ gauge coupling with gauge charge $q$ and mass $m$,
    extremality requires $q \ge m$ in natural Planck units (gravity is the weakest force). -/
structure WGCState where
  charge : Int
  mass : Int
  hMassPos : mass > 0

/-- WGC condition predicate: $|q| \ge m$. -/
def satisfiesWGC (s : WGCState) : Prop :=
  (s.charge * s.charge) ≥ (s.mass * s.mass)

/-- Theorem: A superextremal state with $q = m$ satisfies the Weak Gravity Conjecture. -/
theorem extremality_satisfies_wgc (m : Int) (hm : m > 0) :
    satisfiesWGC ⟨m, m, hm⟩ :=
  Int.le_refl (m * m)

/-- Refined de Sitter Conjecture:
    In any effective field theory consistent with quantum gravity, the scalar potential $V(\phi)$
    must satisfy $|\nabla V| \ge c \cdot V$ or $\nabla^2 V \le -c' \cdot V$. -/
structure DeSitterConjecture where
  potential : Int
  gradPotential : Int
  hPotentialPos : potential > 0
  cParam : Int := 1

/-- Predicate for the gradient condition of the de Sitter conjecture:
    $|\nabla V| \ge c \cdot V$. -/
def satisfiesDeSitterGradient (ds : DeSitterConjecture) : Prop :=
  ds.gradPotential ≥ ds.cParam * ds.potential

end SocrateAI.StringTheory.Swampland
