import SocrateAI.ModularForms.EtaQuotientCuspOrder
open SocrateAI.ModularForms ModularForm UpperHalfPlane
-- NEGATIVE CONTROL 2: dropping the factor 24 from the hypothesis must break the theorem.
example : ∀ (N : ℕ) (r : ℕ → ℤ) (m : ℤ), m = ∑ δ ∈ N.divisors, (δ : ℤ) * r δ →
    meromorphicOrderAt (UpperHalfPlane.cuspFunction 1 (etaQuotientH N r)) 0 = (m : WithTop ℤ) :=
  fun N r m hm => meromorphicOrderAt_cuspFunction_etaQuotientH N r m hm
