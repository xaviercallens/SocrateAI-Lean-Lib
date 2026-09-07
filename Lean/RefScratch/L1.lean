import Mathlib.NumberTheory.ModularForms.SlashActions
import Mathlib.NumberTheory.ModularForms.CongruenceSubgroups
namespace RefScratchL1
open Matrix CongruenceSubgroup
open scoped MatrixGroups

def frickeMatrix (N : ℕ) : Matrix (Fin 2) (Fin 2) ℝ := !![0, -1; (N : ℝ), 0]

@[simp] theorem frickeMatrix_det (N : ℕ) : (frickeMatrix N).det = (N : ℝ) := by
  simp [frickeMatrix, Matrix.det_fin_two_of]

noncomputable def frickeW {N : ℕ} (hN : 0 < N) : GL (Fin 2) ℝ :=
  Matrix.GeneralLinearGroup.mkOfDetNeZero (frickeMatrix N) (frickeMatrix_det_ne_zero hN)

end RefScratchL1
