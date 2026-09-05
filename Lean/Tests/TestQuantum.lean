/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/

import SocrateAI.Quantum.GolayCode

namespace Tests.TestQuantum

open SocrateAI.Quantum.GolayCode

theorem test_golay_capacity : golay_error_capacity = 3 :=
  golay_corrects_three_errors

theorem test_complex_modes : complex_fermion_modes = 12 :=
  complex_modes_eq_twelve

theorem test_fock_dim : fock_space_dimension = 4096 :=
  fock_space_dim_eq_4096

theorem test_parity_sector_dim : parity_sector_dimension = 2048 :=
  parity_sector_dim_eq_2048

theorem test_parity_sum : parity_sector_dimension + parity_sector_dimension = 4096 :=
  parity_sum_eq_total_fock_dim

theorem test_golay_k3_match : golay_length = k3_euler_characteristic :=
  golay_matches_k3_euler

end Tests.TestQuantum
