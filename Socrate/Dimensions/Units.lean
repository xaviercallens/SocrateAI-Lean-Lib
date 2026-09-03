/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import Socrate.Dimensions.Base

namespace Socrate.Dimensions

/-- Dimension of Length ($L$). -/
def dimLength : Dimensions := { length := 1 }

/-- Dimension of Mass ($M$). -/
def dimMass : Dimensions := { mass := 1 }

/-- Dimension of Time ($T$). -/
def dimTime : Dimensions := { time := 1 }

/-- Dimension of Electric Current ($I$). -/
def dimCurrent : Dimensions := { current := 1 }

/-- Dimension of Thermodynamic Temperature ($\Theta$). -/
def dimTemperature : Dimensions := { temperature := 1 }

/-- Dimension of Amount of Substance ($N$). -/
def dimAmount : Dimensions := { amount := 1 }

/-- Dimension of Luminous Intensity ($J$). -/
def dimLuminosity : Dimensions := { luminosity := 1 }

/-- Dimension of Velocity ($L \cdot T^{-1}$). -/
def dimVelocity : Dimensions := { length := 1, time := -1 }

/-- Dimension of Acceleration ($L \cdot T^{-2}$). -/
def dimAcceleration : Dimensions := { length := 1, time := -2 }

/-- Dimension of Force ($M \cdot L \cdot T^{-2}$). -/
def dimForce : Dimensions := { mass := 1, length := 1, time := -2 }

/-- Dimension of Energy and Work ($M \cdot L^2 \cdot T^{-2}$). -/
def dimEnergy : Dimensions := { mass := 1, length := 2, time := -2 }

/-- Dimension of Power ($M \cdot L^2 \cdot T^{-3}$). -/
def dimPower : Dimensions := { mass := 1, length := 2, time := -3 }

/-- Dimension of Pressure ($M \cdot L^{-1} \cdot T^{-2}$). -/
def dimPressure : Dimensions := { mass := 1, length := -1, time := -2 }

/-- Dimension of Frequency ($T^{-1}$). -/
def dimFrequency : Dimensions := { time := -1 }

/-- Dimension of Electric Charge ($I \cdot T$). -/
def dimCharge : Dimensions := { current := 1, time := 1 }

/-- Dimension of Voltage / Electric Potential ($M \cdot L^2 \cdot T^{-3} \cdot I^{-1}$). -/
def dimVoltage : Dimensions := { mass := 1, length := 2, time := -3, current := -1 }

/-- Dimension of Gravitational Constant $G$ ($M^{-1} \cdot L^3 \cdot T^{-2}$). -/
def dimGravitationalConstant : Dimensions := { mass := -1, length := 3, time := -2 }

/-- Dimension of Planck's Constant $\hbar$ ($M \cdot L^2 \cdot T^{-1}$). -/
def dimPlanckConstant : Dimensions := { mass := 1, length := 2, time := -1 }

-- Type aliases for ergonomic use in scientific paper formalizations:
abbrev Length (α : Type := Float) := Quantity dimLength α
abbrev Mass (α : Type := Float) := Quantity dimMass α
abbrev Time (α : Type := Float) := Quantity dimTime α
abbrev Velocity (α : Type := Float) := Quantity dimVelocity α
abbrev Acceleration (α : Type := Float) := Quantity dimAcceleration α
abbrev Force (α : Type := Float) := Quantity dimForce α
abbrev Energy (α : Type := Float) := Quantity dimEnergy α
abbrev Power (α : Type := Float) := Quantity dimPower α
abbrev Pressure (α : Type := Float) := Quantity dimPressure α
abbrev Frequency (α : Type := Float) := Quantity dimFrequency α

/-- Theorem: Newton's Second Law dimensional identity $F = m \cdot a$ holds strictly. -/
theorem newton_second_law_dimension : dimMul dimMass dimAcceleration = dimForce := by
  rfl

/-- Theorem: Kinetic energy dimensional identity $E = m \cdot v^2$ holds strictly. -/
theorem kinetic_energy_dimension : dimMul dimMass (dimPow dimVelocity 2) = dimEnergy := by
  rfl

/-- Theorem: Power is work per unit time ($P = E / t$). -/
theorem power_dimension : dimDiv dimEnergy dimTime = dimPower := by
  rfl

/-- Theorem: Pressure is force per unit area ($P = F / A$). -/
theorem pressure_dimension : dimDiv dimForce (dimPow dimLength 2) = dimPressure := by
  rfl

namespace SI

/-- Speed of light in vacuum $c \approx 299792458\ \text{m/s}$. -/
def speedOfLight : Velocity Float := ⟨299792458.0⟩

/-- Standard acceleration due to gravity $g \approx 9.80665\ \text{m/s}^2$. -/
def standardGravity : Acceleration Float := ⟨9.80665⟩

/-- Newtonian gravitational constant $G \approx 6.67430 \times 10^{-11}\ \text{m}^3\cdot\text{kg}^{-1}\cdot\text{s}^{-2}$. -/
def gravitationalConstant : Quantity dimGravitationalConstant Float := ⟨6.67430e-11⟩

/-- Reduced Planck constant $\hbar \approx 1.054571817 \times 10^{-34}\ \text{J}\cdot\text{s}$. -/
def planckConstant : Quantity dimPlanckConstant Float := ⟨1.054571817e-34⟩

/-- Helper to construct a Mass quantity in kilograms. -/
def kg (x : Float) : Mass Float := ⟨x⟩

/-- Helper to construct a Length quantity in meters. -/
def meters (x : Float) : Length Float := ⟨x⟩

/-- Helper to construct a Time quantity in seconds. -/
def seconds (x : Float) : Time Float := ⟨x⟩

/-- Helper to construct a Force quantity in Newtons. -/
def newtons (x : Float) : Force Float := ⟨x⟩

/-- Helper to construct an Energy quantity in Joules. -/
def joules (x : Float) : Energy Float := ⟨x⟩

end SI

end Socrate.Dimensions
