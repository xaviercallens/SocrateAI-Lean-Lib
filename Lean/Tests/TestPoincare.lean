/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/
import SocrateAI.ModularForms.PoincareUpperHalfPlane

namespace Tests.TestPoincare

open SocrateAI.ModularForms.PoincareUpperHalfPlane

def sampleZ : UpperHalfPlanePoint := { x := 0, y := 1, y_pos := by decide }

def sampleS : SL2Z := {
  a := 0, b := -1, c := 1, d := 0,
  det_one := by decide
}

def sampleT : SL2Z := {
  a := 1, b := 1, c := 0, d := 1,
  det_one := by decide
}

theorem test_S_det : 0 < sampleS.toGLPos2.a * sampleS.toGLPos2.d - sampleS.toGLPos2.b * sampleS.toGLPos2.c :=
  sl2z_det_pos sampleS

theorem test_T_det : 0 < sampleT.toGLPos2.a * sampleT.toGLPos2.d - sampleT.toGLPos2.b * sampleT.toGLPos2.c :=
  sl2z_det_pos sampleT

theorem test_S_preserves_uhp :
    0 < imNumerator sampleS.toGLPos2 sampleZ ∧ 0 < denomNormSq sampleS.toGLPos2 sampleZ :=
  mobius_preserves_uhp sampleS.toGLPos2 sampleZ

theorem test_T_preserves_uhp :
    0 < imNumerator sampleT.toGLPos2 sampleZ ∧ 0 < denomNormSq sampleT.toGLPos2 sampleZ :=
  mobius_preserves_uhp sampleT.toGLPos2 sampleZ

end Tests.TestPoincare
