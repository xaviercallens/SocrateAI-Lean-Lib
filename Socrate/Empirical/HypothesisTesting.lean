/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/

namespace Socrate.Empirical

/-- Formal statistical hypothesis test specification. -/
structure HypothesisTest where
  testName : String
  nullHypothesisDesc : String
  alternativeHypothesisDesc : String
  significanceLevelAlpha : Float := 0.05
  statisticalPowerBeta : Float := 0.80
  effectSizeMetric : String := "Cohen's d"
  minDetectableEffect : Float := 0.5
  sampleSize : Nat

/-- Empirical test outcome for a formalized paper's experiment. -/
structure TestOutcome where
  test : HypothesisTest
  observedStatistic : Float
  pValue : Float
  effectSizeObserved : Float
  rejectedNull : Bool := pValue < test.significanceLevelAlpha

/-- Replicability and open-science audit metadata for empirical papers. -/
structure ReplicabilityManifest where
  preregistered : Bool := false
  preregistrationDoi : Option String := none
  openDataUri : Option String := none
  openCodeUri : Option String := none
  replicationsAttempted : Nat := 0
  replicationsSuccessful : Nat := 0

end Socrate.Empirical
