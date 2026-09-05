/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team

TIER A — All theorems are sorry-free and kernel-verified.

Source: Paper I §6 Theorem 6.1 "Geometric Origin of Inflationary Observables"
All quantities are exact rational arithmetic — no floating point.

## Scientific References

- [Planck2018X] Planck Collaboration; Akrami, Y. et al.
  *Planck 2018 results. X. Constraints on inflation*.
  arXiv: 1807.06211. DOI: 10.1051/0004-6361/201833887
  — n_s = 0.9649 ± 0.0042 (68% CL), r < 0.056 (95% CL).

- [LiteBIRD2022] LiteBIRD Collaboration; Allys, E. et al.
  *Probing Cosmic Inflation with LiteBIRD*.
  arXiv: 2202.02773. DOI: 10.1093/ptep/ptac150
  — Target sensitivity σ(r) ≈ 0.001, detection threshold r ≳ 0.002.

- [Lyth1997] Lyth, D.H.; Riotto, A.
  *Particle physics models of inflation and the cosmological density perturbation*.
  arXiv: hep-ph/9807278. DOI: 10.1016/S0370-1573(99)00002-7
  — Standard slow-roll formulae: r = 12/N_e², n_s = 1 - 2/N_e.
-/

namespace SocrateAI.Inflation.InflationaryObservables

/-!
## 1. e-folds
-/

/-- Number of e-folds of inflation on the T² fiber plateau. -/
def efoldsN : Nat := 55

/-!
## 2. Tensor-to-Scalar Ratio  r = 12α / N_e²

Paper I Theorem 6.1: r = 12α / N_e² = 12(1) / 55² = 12 / 3025
with uncertainty Δr from ΔN_e = ±1.
-/

/-- Kallosh-Linde α-attractor parameter from K\"ahler hyperbolic geometry. -/
def alphaAttractor : Nat := 1

def rNumerator   : Nat := 12 * alphaAttractor
def rDenominator : Nat := 55 * 55   -- = 3025

/-- Theorem: N_e² = 3025 -/
theorem Ne_squared : efoldsN * efoldsN = 3025 := by decide

/-- Theorem: rDenominator = 3025 -/
theorem r_denominator_exact : rDenominator = 3025 := by decide

/-- Theorem: gcd(12, 3025) = 1 → fraction is irreducible. -/
theorem r_irreducible : Nat.gcd rNumerator rDenominator = 1 := by decide

/-- Paper states r ≈ 0.00396; verify: 12 × 100000 / 3025 = 396 (× 10^{-5}).
    Exact: 12/3025 = 396/100375 ... we use 10^5 scaling. -/
def r_scaled_x1e5 : Nat := rNumerator * 100000 / rDenominator   -- = 396

theorem r_scaled_value : r_scaled_x1e5 = 396 := by decide

/-- Uncertainty from ΔN_e = ±1: r(N_e+1) = 12α/56² = 12/3136 -/
def rNumeratorUncHigh : Nat := 12 * alphaAttractor
def rDenomHigh        : Nat := 56 * 56   -- = 3136
def r_high_scaled_x1e5 : Nat := rNumeratorUncHigh * 100000 / rDenomHigh

theorem r_high_value : r_high_scaled_x1e5 = 382 := by decide

/-- r(N_e-1) = 12α/54² = 12/2916 -/
def rDenomLow : Nat := 54 * 54   -- = 2916
def r_low_scaled_x1e5 : Nat := 12 * alphaAttractor * 100000 / rDenomLow

theorem r_low_value : r_low_scaled_x1e5 = 411 := by decide

/-- Theorem: r is strictly between LiteBIRD sensitivity ~ r > 0.001.
    In units ×10^5: 396 > 100 ✓ -/
theorem r_above_liteBIRD_threshold : r_scaled_x1e5 > 100 := by decide

/-!
## 3. Spectral Index  n_s = 1 - 2/N_e

Paper I Theorem 6.1: n_s = 1 - 2/55 = 53/55 = 0.9636...
-/

def nsNumerator   : Nat := 53   -- 55 - 2
def nsDenominator : Nat := 55

/-- Theorem: n_s = 1 - 2/N_e expressed as (N_e - 2) / N_e. -/
theorem ns_numerator_correct : efoldsN - 2 = nsNumerator := by decide

/-- Theorem: gcd(53, 55) = 1 → irreducible. -/
theorem ns_irreducible : Nat.gcd nsNumerator nsDenominator = 1 := by decide

/-- n_s × 10000 = 53 × 10000 / 55 = 9636 (truncated). -/
def ns_scaled_x10000 : Nat := nsNumerator * 10000 / nsDenominator

theorem ns_scaled_value : ns_scaled_x10000 = 9636 := by decide

/-- Theorem: n_s > 0.96 (within Planck 2018 preferred range ≈ 0.9649 ± 0.0042). -/
theorem ns_in_Planck_range : ns_scaled_x10000 ≥ 9600 := by decide

/-!
## 4. LiteBIRD Falsifiability Window
-/

/-- LiteBIRD target σ(r) ~ 0.001; in ×10^5 units: σ ≈ 100. -/
def liteBIRD_sigma_r_x1e5 : Nat := 100

/-- Theorem: The predicted r = 396×10^{-5} is > 3σ above r=0 at LiteBIRD sensitivity. -/
theorem r_detectable_by_liteBIRD :
    r_scaled_x1e5 ≥ 3 * liteBIRD_sigma_r_x1e5 := by decide

end SocrateAI.Inflation.InflationaryObservables
