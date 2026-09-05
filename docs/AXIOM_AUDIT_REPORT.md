# 🛡️ SocrateAI Lean 4 Kernel Axiom & Quarantine Audit Report

- **Date**: 2026-09-04
- **Total Declarations Audited**: 307
- **Pure Computational (0 Axioms)**: 260 ⚡
- **Standard Lean Logic (`propext`, `Quot.sound`, `choice`)**: 41 📐
- **Quarantined Physics Postulates**: 6 ⚠️
- **Illegal Axiom Leaks (Unquarantined Postulates)**: 0 ✅ (Zero Leaks)

---

## 📋 Audit Classification Overview

| Classification | Count | Meaning |
|---|---|---|
| `COMPUTATIONAL_ZERO_AXIOMS` | 260 | Proven purely by computation (`rfl`, `decide`). 0 axioms in proof term. |
| `STANDARD_LEAN_LOGIC` | 41 | Verified using standard CIC axioms (`propext`, `Quot.sound`, `choice` from `omega`/`simp`). |
| `QUARANTINED_PHYSICS_POSTULATE` | 6 | Theoretical physics conjectures safely quarantined in allowlisted modules. |
| `ILLEGAL_AXIOM_LEAK` | 0 | Physics heuristic masquerading as proven math (must be 0). |

---

## 🔬 Declaration Details

| Module | Declaration | Classification | Axioms Reported | Verdict |
|---|---|---|---|---|
| `SocrateAI.AlienMath.ExactRationalWitness` | `certified_quadratic_nonneg` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.AlienMath.KalChargingMatrix` | `total_charge_additive` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.AlienMath.KalChargingMatrix` | `charging_potential_nonnegative` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.AlienMath.KalHolographicBorderRank` | `border_product_bounded` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.AlienMath.KalHolographicBorderRank` | `zero_area_unentangled` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `regime_I_mass_positive` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `regime_I_fifth_force_vanishes` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `regime_II_mass_negative` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `regime_II_vev_nonzero` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `thin_shell_below_cassini` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `total_model_params` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `sub_critical_with_DM_falsifies` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `sub_critical_without_DM_consistent` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `df2_below_mond` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `df2_upper_below_mond` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.ChameleonGravity.DACModel` | `df2_deeply_in_mond_regime` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.Algebra` | `int_sq_nonneg` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.Algebra` | `lagrange_remainder_nonneg` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.Algebra` | `amgm_defect_nonneg` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.Algebra` | `sum_of_squares_nonneg` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Core.Algebra` | `am_gm_from_defect` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Core.Analysis` | `dissipation_nonpositive` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Core.Analysis` | `dissipation_nonpositive_int` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Core.Logic` | `excluded_middle` | `STANDARD_LEAN_LOGIC` | `propext, Classical.choice, Quot.sound` | ✅ PASS |
| `SocrateAI.Core.Logic` | `double_negation_elimination` | `STANDARD_LEAN_LOGIC` | `propext, Classical.choice, Quot.sound` | ✅ PASS |
| `SocrateAI.Core.Logic` | `modus_tollens` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.Logic` | `true_theory_is_consistent` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `le_refl` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `le_trans` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `le_A` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `X_le` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `eq_A_of_A_le` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `le_antisymm` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `trans` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `tier_le_of_depends` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `no_kernel_claim_rests_on_weaker` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.TierCalculus` | `not_A_of_weak_support` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.Topology` | `euler_char_T2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.Topology` | `euler_char_K3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Core.Topology` | `euler_char_K3xT2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `flat_prior_disfavors_on_expansion` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `physical_prior_favors_on_joint` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `flat_prior_joint_is_weakly_positive` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `flat_prior_exceeds_weak_threshold` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `physical_prior_exceeds_weak_threshold` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `prior_sensitivity_contradicts` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `k3t2_chi2_below_1` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `jwst_improvement_positive` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `jwst_datapoints` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.BayesianEvidence` | `occam_penalty_3_params` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.Inflation` | `spectral_tilt_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.Inflation` | `tensor_to_scalar_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.Inflation` | `bispectrum_ratio_irreducible` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.Inflation` | `bispectrum_ratio_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.Inflation` | `slowroll_epsilon_consistency` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.Inflation` | `lyth_bound_sub_planckian` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.Inflation` | `ns_within_falsification_window` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.MoonshineVacuum` | `discriminant_from_indices` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.MoonshineVacuum` | `delta_is_largest_mathieu_prime` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.MoonshineVacuum` | `intermediate_vacuum_is_23` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.MoonshineVacuum` | `lvs_gap_is_70` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.MoonshineVacuum` | `total_hierarchy_is_123` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Cosmology.MoonshineVacuum` | `moonshine_explains_about_20_percent` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Duality.DualScale` | `dual_pair_symmetric` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.Duality.DualScale` | `self_dual_at_crossover` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Duality.DualScale` | `dual_product_invariant` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Duality.EffectiveScale` | `ew_bounded_by_planck` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.Duality.EffectiveScale` | `planck_string_unit_volume` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.Duality.T_Duality` | `t_duality_involution` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Duality.T_Duality` | `self_dual_mass_symmetry` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Duality.T_Duality` | `t_duality_spectrum_invariance` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `physics_postulate_1` | `QUARANTINED_PHYSICS_POSTULATE` | `SocrateAI.Generated.BlueprintSkeleton.physics_postulate_1` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `physics_postulate_2` | `QUARANTINED_PHYSICS_POSTULATE` | `SocrateAI.Generated.BlueprintSkeleton.physics_postulate_2` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `physics_postulate_3` | `QUARANTINED_PHYSICS_POSTULATE` | `SocrateAI.Generated.BlueprintSkeleton.physics_postulate_3` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `physics_postulate_4` | `QUARANTINED_PHYSICS_POSTULATE` | `SocrateAI.Generated.BlueprintSkeleton.physics_postulate_4` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `physics_postulate_5` | `QUARANTINED_PHYSICS_POSTULATE` | `SocrateAI.Generated.BlueprintSkeleton.physics_postulate_5` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `physics_postulate_6` | `QUARANTINED_PHYSICS_POSTULATE` | `SocrateAI.Generated.BlueprintSkeleton.physics_postulate_6` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3_euler_char_eq_24` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `picard_bound` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3t2_euler_char_eq_zero` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `mathieu_rigidity_ratio` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `golay_corrects_three_errors` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `fock_space_dim_eq_4096` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `m24_order_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `efolds_squared_eq_3025` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `ns_numerator_eq_53` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `prior_sensitivity_opposition` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3t2_chi2_below_unity` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3_euler_char_eq_24_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `picard_bound_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3t2_euler_char_eq_zero_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `mathieu_rigidity_ratio_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `golay_corrects_three_errors_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `fock_space_dim_eq_4096_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `m24_order_factored_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `efolds_squared_eq_3025_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `ns_numerator_eq_53_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `prior_sensitivity_opposition_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3t2_chi2_below_unity_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3_euler_char_eq_24_3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `picard_bound_3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3t2_euler_char_eq_zero_3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `mathieu_rigidity_ratio_3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `golay_corrects_three_errors_3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `fock_space_dim_eq_4096_3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `m24_order_factored_3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k4_handshaking` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k4_adjacency_trace_zero` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k4_spectral_gap_eq_four` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `orf_suppression_exact` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3_euler_char_eq_24_4` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `picard_bound_4` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k3t2_euler_char_eq_zero_4` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `mathieu_rigidity_ratio_4` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `thm_exact_conservation_lean_shellbc__energy` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `thm_volume_preservation_lean_shell__divergen` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k4_handshaking_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k4_adjacency_trace_zero_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `k4_spectral_gap_eq_four_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `orf_suppression_exact_2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `golay_corrects_three_errors_4` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `fock_space_dim_eq_4096_4` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `m24_order_factored_4` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `dac_regime_I_fifth_force_zero` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `dac_parameter_count` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `dac_below_cassini` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `thm_logarithmic_derivative_recurrence` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Generated.BlueprintSkeleton` | `thm_exact_analytic_formula` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `Ne_squared` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `r_denominator_exact` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `r_irreducible` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `r_scaled_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `r_high_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `r_low_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `r_above_liteBIRD_threshold` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `ns_numerator_correct` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `ns_irreducible` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `ns_scaled_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `ns_in_Planck_range` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Inflation.InflationaryObservables` | `r_detectable_by_liteBIRD` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.K3.CooperSym2` | `sym2_L2_dim_is_3` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.K3.CooperSym2` | `cooper_pair_veronese_quadric` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.K3.FDM_Candidates` | `ultralight_condition` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.K3.K3Surfaces` | `k3_b2_is_22` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.K3.K3Surfaces` | `k3_lattice_rank_valid` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.K3.K3Surfaces` | `k3_signature_is_minus_16` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.ModularForms.PoincareUpperHalfPlane` | `int_sq_nonneg` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.ModularForms.PoincareUpperHalfPlane` | `sq_pos_of_ne_zero` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.ModularForms.PoincareUpperHalfPlane` | `denom_norm_sq_pos` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.ModularForms.PoincareUpperHalfPlane` | `im_numerator_pos` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.ModularForms.PoincareUpperHalfPlane` | `mobius_preserves_uhp` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.ModularForms.PoincareUpperHalfPlane` | `sl2z_det_pos` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.ModularForms.PoincareUpperHalfPlane` | `modular_form_closure_witness` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `exponent_sum_eq_minus183` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `twice_k_eq` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `weighted_exponent_sum` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `pole_order_gcd` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `pole_order_num_reduced` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `pole_order_den_reduced` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `principal_terms_eq_71` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `effective_central_charge_eq_1701` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `weight1_eq` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `weight2_eq` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `weight3_eq` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a1_eq_minus24` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a1_factorization` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a2_eq_229` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a3_eq_minus906` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a3_factorization` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a4_factorization` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a5_factorization` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a6_factorization` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a7_factorization` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `a8_factorization` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `twice_nu_eq` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `pole_asymptotic_power_eq_46` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `twice_n_power_eq_186` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `n_power_half_int` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `radicand_numerator_eq_425` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.ExtremalEtaQuotient` | `radicand_denominator_eq_6` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.MathieuBispectrum` | `mathieuA1_decomposition` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.MathieuBispectrum` | `mathieuA2_decomposition` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.MathieuBispectrum` | `mathieuA3_decomposition` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.MathieuBispectrum` | `bispectrum_ratio_exact` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.MathieuBispectrum` | `bispectrum_ratio_irreducible` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.MathieuBispectrum` | `four_A1_is_360` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.MathieuBispectrum` | `mathieu_rigidity_ratio_verified` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.MathieuBispectrum` | `bispectrumRatio_x1000_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaExponents12_sum_is_minus183` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaTwiceWeight` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `sum_d_4_to_12` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaWeightedSum` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `zeroPoint_irreducible` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `zeroPoint_reduced_num` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `zeroPoint_reduced_den` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaEffCentralCharge_is_minus1698` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaEffCentralCharge_formula` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff1_eq_minus24` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff2_eq_229` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff3_eq_minus906` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ligozat_parity_violated` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ligozat_integrality_violated` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff1_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff2_prime_witness` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff3_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff4_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff5_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff6_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff7_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaCoeff8_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.RAMA_EtaQuotient` | `ramaOEIS_length` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.VacuumEnergy` | `discriminant_is_23` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.VacuumEnergy` | `intermediate_rho_correct` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.VacuumEnergy` | `hierarchy_gap_is_70` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.VacuumEnergy` | `corrected_claim_differs_from_old_false_claim` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Moonshine.VacuumEnergy` | `four_open_assumptions` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.NavierStokes.Enstrophy` | `enstrophy_2d_decay` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.NavierStokes.Enstrophy` | `enstrophy_growth_condition` | `STANDARD_LEAN_LOGIC` | `propext, Classical.choice, Quot.sound` | ✅ PASS |
| `SocrateAI.NavierStokes.FrustrationIndex` | `complete_frustration_arrest` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.NavierStokes.FrustrationIndex` | `frustration_reduces_transfer` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.NavierStokes.HypothesisU` | `bkm_integral_finite_int` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.NavierStokes.HypothesisU` | `hypothesis_u_guarantees_regularity` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `k4_handshaking` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `k4_edges_formula` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `k4_adjacency_trace_zero` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `k4_spectral_gap_eq_four` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `laplacian_zero_mode_is_zero` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `laplacian_excited_mode_is_four` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `hadamard_trace_eq_16` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `orf_suppression_exact` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Pregeometry.HypergraphK4` | `spectral_index_decomposition` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayCode` | `golay_corrects_three_errors` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayCode` | `complex_modes_eq_twelve` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayCode` | `fock_space_dim_eq_4096` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayCode` | `parity_sector_dim_eq_2048` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayCode` | `parity_sum_eq_total_fock_dim` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayCode` | `golay_matches_k3_euler` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `golay_parameters` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `golay_corrects_3_errors` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `golay_redundancy_is_12` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `extended_golay_not_perfect` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `perfect_golay_hamming_bound` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `css_parameters` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `entropy_linear_below_plateau` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `entropy_saturates_above_plateau` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `max_entropy_is_12` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `half_block_entropy` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `mathieuM24Order_value` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `mathieuM24Order_factored` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `generation_discrepancy` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Quantum.GolayM24` | `four_triplets_exceed_SM` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Ramanujan.CallensAlixKernel` | `mirror_reflection_involution` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Ramanujan.CallensAlixKernel` | `mirror_reflection_center` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Ramanujan.CallensAlixKernel` | `kernel_nonnegative` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Ramanujan.RAMA` | `ramanujan_tau_6_multiplicative` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Ramanujan.RAMA` | `ramanujan_tau_4_recurrence` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.Ramanujan.ShadowBridge` | `shadow_bridge_exact_cancellation` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.Ramanujan.ShadowBridge` | `shadow_bridge_difference` | `STANDARD_LEAN_LOGIC` | `propext, Quot.sound` | ✅ PASS |
| `SocrateAI.StringTheory.FTheory` | `discriminant_origin_zero` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.FTheory` | `discriminant_example_7brane` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.FTheory` | `e8_fiber_rank_is_8` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.K3xT2` | `dim_real_k3xt2_is_6` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.K3xT2` | `target_spacetime_is_4d` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.K3xT2` | `typeII_k3xt2_susy_N4` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.K3xT2` | `string_duality_susy_match` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.K3xT2` | `euler_char_vanishes` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `b3_K3T2_is_44` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `b3_kunneth_decomposition` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `b2_K3T2_is_23` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `b2_kunneth_decomposition` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `poincare_duality_06` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `poincare_duality_15` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `poincare_duality_24` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `euler_char_6D_vanishes` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `narain_rank_is_24` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `narain_signature_diff` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `vector_multiplets_from_b2` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.KunnethProduct` | `narain_moduli_dim_is_80` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `picard_bound` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `euler_char_eq_24` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `hodge_symmetry_h20_h02` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `spectral_picard_bridge` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `cooper_s10_is_consistent` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `k3_euler_char_eq_24` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `k3t2_euler_char_eq_zero` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `k3_signature_difference` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `k3_parity_modulo_8` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `k3_real_moduli_dim_eq_58` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `mathieu_rigidity_ratio` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `discriminant_is_23` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `kummer_matches_euler` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `tensor_ratio_exact` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `swampland_distance_conjecture_safe` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `passes_deSitter_conjecture` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `kuenneth_b3_derivation` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `picard_rank_kummer_maximal` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.StringInequalities` | `hodge_h11_eq_20` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.Swampland` | `distance_conjecture_monotonicity` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.Swampland` | `extremality_satisfies_wgc` | `STANDARD_LEAN_LOGIC` | `propext` | ✅ PASS |
| `SocrateAI.StringTheory.VacuumSelection` | `swampland_below_lefschetz` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.VacuumSelection` | `excluded_picard_ranks` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.VacuumSelection` | `low_f_order_is_minimal` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.VacuumSelection` | `az1_swampland_safe` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.VacuumSelection` | `s10_swampland_excluded` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.VacuumSelection` | `az1_maximal_picard` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.VacuumSelection` | `az1_minimal_transcendental` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |
| `SocrateAI.StringTheory.VacuumSelection` | `az1_hodge_decomposition` | `COMPUTATIONAL_ZERO_AXIOMS` | `None (0)` | ✅ PASS |

---

## 🎯 Conclusion
The repository adheres strictly to Terence Tao's Axiom Quarantine protocol.
All physical conjectures are segregated into quarantined sections and do not leak into certified mathematical invariants.
