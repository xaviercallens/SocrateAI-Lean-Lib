import SocrateAI.ModularForms.EtaQuotientCuspOrder
open SocrateAI.ModularForms ModularForm UpperHalfPlane
-- NEGATIVE CONTROL 1: the discriminant order is NOT 2.  Must fail to compile.
example : meromorphicOrderAt
    (UpperHalfPlane.cuspFunction 1 (ModularForm.discriminant : ℍ → ℂ)) 0 = (2 : ℤ) :=
  meromorphicOrderAt_cuspFunction_discriminant
