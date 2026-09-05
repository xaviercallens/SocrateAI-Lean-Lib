/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team

## Scientific References

- [Vafa2005] Vafa, C. *The String Landscape and the Swampland*.
  arXiv: hep-th/0509212 — Not all QFTs can be UV-completed in string theory.

- [OoguriVafa2007] Ooguri, H.; Vafa, C.
  *On the Geometry of the String Landscape and the Swampland*.
  arXiv: hep-th/0605264. DOI: 10.1016/j.nuclphys.2007.04.022
  — Distance Conjecture: infinite tower becomes light at large field distance.

- [Obied2018] Obied, G.; Ooguri, H.; Spodyneiko, L.; Vafa, C.
  *de Sitter Space and the Swampland*. arXiv: 1806.08362
  — Refined de Sitter conjecture: |∇V| ≥ c·V or min(∇²V) ≤ -c'·V.

- [Arkani-Hamed2007] Arkani-Hamed, N.; Motl, L.; Nicolis, A.; Vafa, C.
  *The String Landscape, Black Holes and Gravity as the Weakest Force*.
  arXiv: hep-th/0601001. DOI: 10.1088/1126-6708/2007/06/060
  — Weak Gravity Conjecture: q ≥ m in Planck units.
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
