import Mathlib.NumberTheory.ModularForms.Basic
import Mathlib.NumberTheory.ModularForms.SlashActions
import Mathlib.NumberTheory.ModularForms.CongruenceSubgroups

open Matrix CongruenceSubgroup ConjAct
open scoped MatrixGroups Pointwise

-- P1. Does Mathlib already carry the analytic transport the paper's limitation (b)
--     says is "not yet constructed"?
#check @ModularForm.translate
#check @SlashInvariantForm.translate
#check @CuspForm.translate
#check @ModularForm.coe_translate

-- P2. Mathlib's general conjugation theory for congruence subgroups.
#check @CongruenceSubgroup.conjGL
#check @CongruenceSubgroup.IsCongruenceSubgroup.conjGL
#check @CongruenceSubgroup.exists_Gamma_le_conj
#check @Subgroup.IsArithmetic.conj

-- P3. The N = 1 Fricke matrix is already in Mathlib as ModularGroup.S, with S^2 = -1.
#check @ModularGroup.S
#check @ModularGroup.coe_S
#check @ModularGroup.S_inv
example : (ModularGroup.S : Matrix (Fin 2) (Fin 2) ℤ) = !![0, -1; 1, 0] := by
  exact ModularGroup.coe_S

-- P4. Is there a Fricke/Atkin-Lehner declaration at all?  (name-resolution test, not grep)
-- open Fricke   -- would fail
