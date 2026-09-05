/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.Cosmology.BayesianEvidence

namespace Tests.TestCosmology

open SocrateAI.Cosmology.BayesianEvidence

theorem test_flat_prior_disfavors : lnB_flatPrior_expansionOnly_x10 < 0 :=
  flat_prior_disfavors_on_expansion

theorem test_physical_prior_favors : lnB_physicalPrior_joint_x10 > 0 :=
  physical_prior_favors_on_joint

theorem test_prior_sensitivity :
    lnB_flatPrior_expansionOnly_x10 < 0 ∧ lnB_physicalPrior_joint_x10 > 0 :=
  prior_sensitivity_contradicts

theorem test_k3t2_chi2 : chiSq_reduced_x1000 < 1000 :=
  k3t2_chi2_below_1

theorem test_jwst_improvement : deltaChiSq_JWST_x10 > 0 :=
  jwst_improvement_positive

theorem test_jwst_points : nJWST_datapoints = 14 :=
  jwst_datapoints

end Tests.TestCosmology
