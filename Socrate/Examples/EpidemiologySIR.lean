/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import Socrate.Core.Paper
import Socrate.Theory.DynamicalSystem
import Socrate.Meta.Attributes
import Socrate.Meta.Commands

namespace Socrate.Examples.EpidemiologySIR

open Socrate.Core
open Socrate.Theory
open Socrate.Meta

/-- Metadata for Kermack & McKendrick's foundational 1927 epidemiology paper. -/
def kermack1927Metadata : PaperMetadata := {
  title := "A Contribution to the Mathematical Theory of Epidemics"
  authors := ["W. O. Kermack", "A. G. McKendrick"]
  year := 1927
  venue := "Proceedings of the Royal Society of London. Series A, Vol. 115, pp. 700–721"
  doi := some "10.1098/rspa.1927.0118"
  domain := .Medicine
  abstract := "Original formulation of the SIR compartmental epidemic model, establishing the epidemic threshold phenomenon and basic reproduction number R₀."
}

/-- Empirical assumption: Closed homogeneously mixing population with negligible vital dynamics (birth/death). -/
@[empirical_assumption]
def closedPopulationAssumption : Prop :=
  True

/-- SIR compartmental population state: Susceptible ($S$), Infectious ($I$), Recovered ($R$). -/
structure SIRState where
  S : Int
  I : Int
  R : Int
  deriving Repr, DecidableEq

/-- Total population $N = S + I + R$. -/
def totalPopulation (s : SIRState) : Int :=
  s.S + s.I + s.R

/-- SIR discrete transmission transition record:
    - `newInfections`: newly infected individuals transitioning $S \to I$.
    - `newRecoveries`: newly recovered individuals transitioning $I \to R$. -/
structure SIRTransition where
  newInfections : Int
  newRecoveries : Int

/-- Discrete SIR state step:
    $S_{t+1} = S_t - \Delta_{inf}$
    $I_{t+1} = I_t + \Delta_{inf} - \Delta_{rec}$
    $R_{t+1} = R_t + \Delta_{rec}$. -/
def sirStep (trans : SIRTransition) (s : SIRState) : SIRState :=
  { S := s.S - trans.newInfections
  , I := s.I + trans.newInfections - trans.newRecoveries
  , R := s.R + trans.newRecoveries }

/-- Theorem: Total population is conserved in every SIR transition step:
    $(S - \Delta_{inf}) + (I + \Delta_{inf} - \Delta_{rec}) + (R + \Delta_{rec}) = S + I + R$. -/
@[paper_claim]
theorem sir_step_conserves_population (trans : SIRTransition) (s : SIRState) :
    totalPopulation (sirStep trans s) = totalPopulation s := by
  dsimp [totalPopulation, sirStep]
  omega

/-- Basic reproduction number $R₀ = \beta / \gamma$ defined for positive transmission $\beta$ and recovery $\gamma$. -/
@[paper_claim]
def basicReproductionNumber (beta gamma : Float) : Float :=
  beta / gamma

/-- Epidemic Threshold Condition:
    An epidemic can grow initially ($\Delta I > 0$) if and only if $R₀ > 1$ when the population
    is initially fully susceptible ($S₀ \approx N$). -/
@[paper_claim]
def epidemicThresholdCondition (R0 : Float) : Prop :=
  R0 > 1.0

/-- Falsification condition: If disease spreads exponentially in a population with $R₀ < 1$,
    the standard homogeneous SIR model is refuted (suggesting super-spreading, network heterogeneity, or migration). -/
def sirFalsificationCriterion : FalsificationCondition := {
  description := "Exponential epidemic growth observed in an empirical setting with measured R₀ < 1"
  counterHypothesis := False
}

/-- Verified scientific claim registered in Socrate paper specification. -/
def claimTotalPopulationConservation : Claim := {
  id := "KERMACK-1927-CONSERVATION"
  title := "Conservation of Total Population in Compartmental Dynamics"
  claimType := .TheoreticalTheorem
  evidenceLevel := .DeductiveProof
  description := "In closed compartmental SIR dynamics, total population S(t) + I(t) + R(t) = N is strictly invariant."
  regime := some "Closed host population over epidemic timescale (birth/death rate ≪ recovery rate)"
  falsification := some sirFalsificationCriterion
}

/-- Paper specification for Kermack & McKendrick 1927. -/
def paperKermack1927 : ScientificPaper := {
  metadata := kermack1927Metadata
  claims := [claimTotalPopulationConservation]
  assumptions := [{
    name := "Homogeneous Well-Mixed Closed Population"
    hypothesis := closedPopulationAssumption
    justification := "Epidemic duration is short compared to host demographic turnover"
  }]
}

#inspect_claim sir_step_conserves_population
#inspect_claim basicReproductionNumber

end Socrate.Examples.EpidemiologySIR
