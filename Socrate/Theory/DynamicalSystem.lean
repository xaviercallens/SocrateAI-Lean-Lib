/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/

namespace Socrate.Theory

/-- A discrete-time dynamical system governing the evolution of states over time. -/
structure DiscreteDynamicalSystem (State : Type) (Param : Type) where
  /-- State transition map for a given set of system parameters. -/
  step : Param → State → State

namespace DiscreteDynamicalSystem

variable {State Param : Type}

/-- Compute the state of the system after `n` discrete time steps starting from `s₀`. -/
def trajectory (sys : DiscreteDynamicalSystem State Param) (p : Param) (s₀ : State) : Nat → State
  | 0 => s₀
  | n + 1 => sys.step p (trajectory sys p s₀ n)

/-- An equilibrium point / steady state is a state invariant under the time-evolution map. -/
def isEquilibrium (sys : DiscreteDynamicalSystem State Param) (p : Param) (s_eq : State) : Prop :=
  sys.step p s_eq = s_eq

/-- A conservation law (first integral) is an observable quantity `Q` invariant under time evolution. -/
def isConserved (sys : DiscreteDynamicalSystem State Param) (p : Param) {α : Type} (Q : State → α) : Prop :=
  ∀ (s : State), Q (sys.step p s) = Q s

/-- Fundamental Invariant Theorem:
    If an observable `Q` is conserved at each step, it is invariant along any trajectory for all time $t \in \mathbb{N}$. -/
theorem conserved_along_trajectory
    (sys : DiscreteDynamicalSystem State Param) (p : Param) {α : Type} (Q : State → α)
    (hConserved : sys.isConserved p Q) (s₀ : State) (t : Nat) :
    Q (sys.trajectory p s₀ t) = Q s₀ := by
  induction t with
  | zero =>
    rfl
  | succ n ih =>
    unfold trajectory
    rw [hConserved]
    exact ih

end DiscreteDynamicalSystem

/-- Continuous dynamical system representation with state space and continuous vector field. -/
structure ContinuousDynamicalSystem (State : Type) (Param : Type) where
  /-- Vector field specifying instantaneous rate of change $ds/dt = f(p, s)$. -/
  vectorField : Param → State → State

namespace ContinuousDynamicalSystem

variable {State Param : Type}

/-- An equilibrium point (fixed point) of a continuous system where $ds/dt = 0$. -/
def isEquilibrium [Zero State] (sys : ContinuousDynamicalSystem State Param) (p : Param) (s_eq : State) : Prop :=
  sys.vectorField p s_eq = 0

end ContinuousDynamicalSystem

end Socrate.Theory
