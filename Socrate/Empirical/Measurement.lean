/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import Socrate.Dimensions.Base

namespace Socrate.Empirical

open Socrate.Dimensions

/-- An empirical scientific measurement of a physical quantity with quantified uncertainty.
    Includes central value, standard uncertainty $\sigma$, and optional sample size. -/
structure Measurement (d : Dimensions) where
  value : Float
  uncertainty : Float
  sampleSize : Option Nat := none
  confidenceLevel : Float := 0.95
  instrument : String := "Laboratory Instrument"
  deriving Repr

namespace Measurement

/-- Lower bound of the confidence interval. -/
def lowerBound {d : Dimensions} (m : Measurement d) : Float :=
  m.value - m.uncertainty

/-- Upper bound of the confidence interval. -/
def upperBound {d : Dimensions} (m : Measurement d) : Float :=
  m.value + m.uncertainty

/-- Check if a theoretical scalar prediction is consistent with the empirical measurement
    within $k$ standard deviations (default $k = 2$, corresponding to ~95.4% normal interval). -/
def isConsistentWithTheory {d : Dimensions} (m : Measurement d) (pred : Float) (k : Float := 2.0) : Bool :=
  let delta := pred - m.value
  let absDelta := if delta < 0.0 then -delta else delta
  absDelta <= k * m.uncertainty

/-- Addition of two independent empirical measurements with Gaussian uncertainty propagation:
    $\sigma_{sum} = \sqrt{\sigma_1^2 + \sigma_2^2}$. -/
def add {d : Dimensions} (m1 m2 : Measurement d) : Measurement d :=
  let v := m1.value + m2.value
  let u := Float.sqrt (m1.uncertainty * m1.uncertainty + m2.uncertainty * m2.uncertainty)
  { value := v
  , uncertainty := u
  , sampleSize := match m1.sampleSize, m2.sampleSize with
      | some n1, some n2 => some (n1 + n2)
      | _, _ => none
  , instrument := s!"Combined ({m1.instrument} + {m2.instrument})" }

/-- Subtraction of two independent empirical measurements with uncertainty propagation. -/
def sub {d : Dimensions} (m1 m2 : Measurement d) : Measurement d :=
  let v := m1.value - m2.value
  let u := Float.sqrt (m1.uncertainty * m1.uncertainty + m2.uncertainty * m2.uncertainty)
  { value := v
  , uncertainty := u
  , instrument := s!"Combined ({m1.instrument} - {m2.instrument})" }

/-- Scaling a measurement by an exact dimensionless scalar:
    $\sigma_{scaled} = |c| \sigma$. -/
def scale {d : Dimensions} (c : Float) (m : Measurement d) : Measurement d :=
  let absC := if c < 0.0 then -c else c
  { value := c * m.value
  , uncertainty := absC * m.uncertainty
  , sampleSize := m.sampleSize
  , instrument := m.instrument }

/-- Product of two independent measurements with standard first-order error propagation:
    $\sigma_{prod} = \sqrt{(v_2 \sigma_1)^2 + (v_1 \sigma_2)^2}$. -/
def mul {d1 d2 : Dimensions} (m1 : Measurement d1) (m2 : Measurement d2) : Measurement (dimMul d1 d2) :=
  let v := m1.value * m2.value
  let term1 := m2.value * m1.uncertainty
  let term2 := m1.value * m2.uncertainty
  let u := Float.sqrt (term1 * term1 + term2 * term2)
  { value := v
  , uncertainty := u
  , instrument := s!"Product ({m1.instrument} * {m2.instrument})" }

instance {d : Dimensions} : ToString (Measurement d) where
  toString m := s!"{m.value} ± {m.uncertainty} [{d}]"

end Measurement

end Socrate.Empirical
