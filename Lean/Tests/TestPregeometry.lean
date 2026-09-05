/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/

import SocrateAI.Pregeometry.HypergraphK4

namespace Tests.TestPregeometry

open SocrateAI.Pregeometry.HypergraphK4

theorem test_k4_handshaking : k4_vertices * k4_degree = 2 * k4_edges :=
  k4_handshaking

theorem test_k4_edges_formula : (k4_vertices * (k4_vertices - 1)) / 2 = k4_edges :=
  k4_edges_formula

theorem test_k4_trace_zero : k4_adjacency_trace = 0 :=
  k4_adjacency_trace_zero

theorem test_k4_spectral_gap : k4_spectral_gap = 4 :=
  k4_spectral_gap_eq_four

theorem test_laplacian_zero_mode : laplacian_zero_mode = 0 :=
  laplacian_zero_mode_is_zero

theorem test_laplacian_excited_mode : laplacian_excited_mode = 4 :=
  laplacian_excited_mode_is_four

theorem test_hadamard_trace : hadamard_trace = 16 :=
  hadamard_trace_eq_16

theorem test_orf_suppression : orf_ratio_factor = 144 :=
  orf_suppression_exact

theorem test_spectral_index : gamma_base_scaled + gamma_k3_correction_scaled = 4847 :=
  spectral_index_decomposition

end Tests.TestPregeometry
