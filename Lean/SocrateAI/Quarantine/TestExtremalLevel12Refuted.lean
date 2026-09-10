/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.

QUARANTINED alongside `Quarantine/ExtremalLevel12Refuted.lean` — see that file's header for why.
These are re-derivations of the same true numerals, kept for the record. NOT imported from
`Lean/Tests.lean`, so not part of the default `Tests` build target.
-/
import SocrateAI.Quarantine.ExtremalLevel12Refuted

namespace SocrateAI.Quarantine.TestExtremalLevel12Refuted

open SocrateAI.Moonshine.ExtremalEtaQuotient

theorem test_exponent_sum : (24 : Int) + 23 + (-14) + 9 * (-24) = -183 :=
  exponent_sum_eq_minus183

theorem test_pole_order_gcd : Nat.gcd 1700 24 = 4 :=
  pole_order_gcd

theorem test_c_eff : effectiveCentralCharge = 1701 :=
  effective_central_charge_eq_1701

theorem test_a1 : a1 = -24 :=
  a1_eq_minus24

theorem test_a2 : a2 = 229 :=
  a2_eq_229

theorem test_a3 : a3 = -906 :=
  a3_eq_minus906

theorem test_principal_terms : principalTermsCount = 71 :=
  principal_terms_eq_71

theorem test_bessel_order : twice_nu = 185 :=
  twice_nu_eq

end Tests.TestExtremalEta
