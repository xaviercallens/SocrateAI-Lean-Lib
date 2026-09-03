/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/

namespace Socrate.Dimensions

/-- Representation of physical dimensions across the 7 SI base quantities:
    - Length ($L$)
    - Mass ($M$)
    - Time ($T$)
    - Electric Current ($I$)
    - Thermodynamic Temperature ($\Theta$)
    - Amount of Substance ($N$)
    - Luminous Intensity ($J$) -/
structure Dimensions where
  length : Int := 0
  mass : Int := 0
  time : Int := 0
  current : Int := 0
  temperature : Int := 0
  amount : Int := 0
  luminosity : Int := 0
  deriving Repr, DecidableEq, Inhabited

/-- Dimensionless quantity: all powers are zero. -/
def dimensionless : Dimensions := {}

/-- Dimensional multiplication: powers add. -/
def dimMul (d1 d2 : Dimensions) : Dimensions :=
  { length := d1.length + d2.length
  , mass := d1.mass + d2.mass
  , time := d1.time + d2.time
  , current := d1.current + d2.current
  , temperature := d1.temperature + d2.temperature
  , amount := d1.amount + d2.amount
  , luminosity := d1.luminosity + d2.luminosity }

/-- Dimensional division: powers subtract. -/
def dimDiv (d1 d2 : Dimensions) : Dimensions :=
  { length := d1.length - d2.length
  , mass := d1.mass - d2.mass
  , time := d1.time - d2.time
  , current := d1.current - d2.current
  , temperature := d1.temperature - d2.temperature
  , amount := d1.amount - d2.amount
  , luminosity := d1.luminosity - d2.luminosity }

/-- Dimensional inversion: powers negated. -/
def dimInv (d : Dimensions) : Dimensions :=
  { length := -d.length
  , mass := -d.mass
  , time := -d.time
  , current := -d.current
  , temperature := -d.temperature
  , amount := -d.amount
  , luminosity := -d.luminosity }

/-- Dimensional integer exponentiation. -/
def dimPow (d : Dimensions) (n : Int) : Dimensions :=
  { length := d.length * n
  , mass := d.mass * n
  , time := d.time * n
  , current := d.current * n
  , temperature := d.temperature * n
  , amount := d.amount * n
  , luminosity := d.luminosity * n }

/-- Pretty printer for physical dimensions (e.g. `m·s⁻¹`, `kg·m·s⁻²`). -/
def Dimensions.toSIString (d : Dimensions) : String :=
  if d == dimensionless then "dimensionless"
  else
    let parts : List String := []
    let parts := if d.mass != 0 then s!"kg^{d.mass}" :: parts else parts
    let parts := if d.length != 0 then s!"m^{d.length}" :: parts else parts
    let parts := if d.time != 0 then s!"s^{d.time}" :: parts else parts
    let parts := if d.current != 0 then s!"A^{d.current}" :: parts else parts
    let parts := if d.temperature != 0 then s!"K^{d.temperature}" :: parts else parts
    let parts := if d.amount != 0 then s!"mol^{d.amount}" :: parts else parts
    let parts := if d.luminosity != 0 then s!"cd^{d.luminosity}" :: parts else parts
    String.intercalate "·" parts.reverse

instance : ToString Dimensions where
  toString := Dimensions.toSIString

/-- A physical quantity with exact compile-time dimension `d : Dimensions`.
    Values of different dimensions cannot be added or equated at compile time,
    eliminating dimensional errors in formal scientific models. -/
structure Quantity (d : Dimensions) (α : Type := Float) where
  val : α
  deriving Repr, Inhabited

namespace Quantity

/-- Addition of two quantities with identical physical dimensions. -/
def add {d : Dimensions} {α : Type} [Add α] (q1 q2 : Quantity d α) : Quantity d α :=
  ⟨q1.val + q2.val⟩

/-- Subtraction of two quantities with identical physical dimensions. -/
def sub {d : Dimensions} {α : Type} [Sub α] (q1 q2 : Quantity d α) : Quantity d α :=
  ⟨q1.val - q2.val⟩

/-- Negation of a physical quantity. -/
def neg {d : Dimensions} {α : Type} [Neg α] (q : Quantity d α) : Quantity d α :=
  ⟨-q.val⟩

/-- Multiplication of two quantities: dimensions add according to `dimMul`. -/
def mul {d1 d2 : Dimensions} {α : Type} [Mul α] (q1 : Quantity d1 α) (q2 : Quantity d2 α) :
    Quantity (dimMul d1 d2) α :=
  ⟨q1.val * q2.val⟩

/-- Division of two quantities: dimensions subtract according to `dimDiv`. -/
def div {d1 d2 : Dimensions} {α : Type} [Div α] (q1 : Quantity d1 α) (q2 : Quantity d2 α) :
    Quantity (dimDiv d1 d2) α :=
  ⟨q1.val / q2.val⟩

/-- Scaling a quantity by a dimensionless scalar factor. -/
def smul {d : Dimensions} {α : Type} [Mul α] (c : α) (q : Quantity d α) : Quantity d α :=
  ⟨c * q.val⟩

instance {d : Dimensions} {α : Type} [Add α] : Add (Quantity d α) := ⟨add⟩
instance {d : Dimensions} {α : Type} [Sub α] : Sub (Quantity d α) := ⟨sub⟩
instance {d : Dimensions} {α : Type} [Neg α] : Neg (Quantity d α) := ⟨neg⟩
instance {d : Dimensions} {α : Type} [Mul α] : HMul α (Quantity d α) (Quantity d α) := ⟨smul⟩
instance {d1 d2 : Dimensions} {α : Type} [Mul α] :
    HMul (Quantity d1 α) (Quantity d2 α) (Quantity (dimMul d1 d2) α) := ⟨mul⟩
instance {d1 d2 : Dimensions} {α : Type} [Div α] :
    HDiv (Quantity d1 α) (Quantity d2 α) (Quantity (dimDiv d1 d2) α) := ⟨div⟩

instance {d : Dimensions} {α : Type} [ToString α] : ToString (Quantity d α) where
  toString q := s!"{q.val} [{d}]"

end Quantity

end Socrate.Dimensions
