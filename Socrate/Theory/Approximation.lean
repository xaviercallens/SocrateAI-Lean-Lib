/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/

namespace Socrate.Theory

/-- Quantitative bound on an approximation error:
    The distance between the exact physical quantity and its idealized approximation
    is bounded above by `bound`. -/
structure Approximation (α : Type) (dist : α → α → Float) where
  exact : α
  approx : α
  bound : Float
  hBound : dist exact approx ≤ bound
  regime : String := "General regime"

/-- Order of approximation in perturbation theory (e.g. $O(\epsilon)$, $O(\epsilon^2)$). -/
inductive PerturbationOrder where
  | ZerothOrder
  | FirstOrder
  | SecondOrder
  | HigherOrder (n : Nat)
  deriving Repr, DecidableEq, Inhabited

instance : ToString PerturbationOrder where
  toString
    | .ZerothOrder => "O(1) (Zeroth-order)"
    | .FirstOrder => "O(ε) (First-order / Linearization)"
    | .SecondOrder => "O(ε²) (Second-order / Quadratic)"
    | .HigherOrder n => s!"O(ε^{n}) (Order {n})"

/-- Formal model of an asymptotic or perturbation approximation scheme. -/
structure PerturbationScheme (Param State : Type) where
  order : PerturbationOrder
  expansionParam : String := "ε"
  idealizedLimit : Param → State
  errorRate : String

/-- Linearization of a single-variable scientific model around an equilibrium point $x₀$:
    $f(x) \approx f(x₀) + f'(x₀)(x - x₀)$. -/
def linearApproximation (f_x0 f_prime_x0 x0 x : Float) : Float :=
  f_x0 + f_prime_x0 * (x - x0)

end Socrate.Theory
