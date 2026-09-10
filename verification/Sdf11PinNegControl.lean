/- NEGATIVE CONTROL for `SDF-11` (`frickeEigenvalue_norm`), its instance pins and its `FinalCheck`
   guard (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/Sdf11PinNegControl.lean

   and it MUST exit nonzero.  Verified this run: exit 1 with SEVEN `error:` lines across the five
   items — items 3 and 4 each produce two, because each is a conjunction and both conjuncts are
   false — every one of them failing for the RIGHT reason rather than for a resource or environment
   reason:
     item 1  a `#guard_msgs` mismatch (`does not depend on any axioms` vs the real footprint);
     item 2  `unsolved goals ⊢ √(↑N ^ k) = ↑N ^ k` — the dropped square root, displayed;
     item 3  `Application type mismatch: sqrt_natPow_level_six ... has type √(↑6 ^ 12) = 46656 but
             is expected to have type √(↑6 ^ 12) = 2176782336`, plus `unsolved goals ⊢ False` from
             the `norm_num` on the eigenvalue side;
     item 4  `unsolved goals ⊢ 1 = -1`, twice — the sign the norm discards;
     item 5  `unsolved goals ⊢ ↑√2 = -(I * ↑√2)` — the `i`-factor the norm discards.
   None by timeout.  (`--packages` is a GLOBAL lake flag and must precede the subcommand: LL-27,
   LL-32.  The other two spellings both exit 1 for an ENVIRONMENT reason, which makes a negative
   control look like it passed when it examined nothing.)

   `SDF-11` is a MODULUS computation, so the errors it can hide are: the square root dropped, the
   `i`-factor not discarded (a modulus that still tracks the sign or the argument), and a pinned
   value that is simply the wrong number.  Items 2-5 each take a statement that is FALSE for one of
   those reasons and hand it EXACTLY the tactic block the corresponding positive pin uses.  If any
   of them compiled, the positive pins in `EtaQuotientFrickeSelfDual.lean` would be evidence about
   nothing. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms Complex

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`Sdf11` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the node is axiom-free, so a guard
--    written without teeth would pass here too.
/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_norm' does not depend on any axioms -/
#guard_msgs in #print axioms frickeEigenvalue_norm

-- 2. THE SQUARE ROOT DROPPED from the general statement — `‖λ‖ = (N : ℝ)^k` instead of `√((N:ℝ)^k)`,
--    handed the real node's own `rw` chain.  This is the reading `frickeEigenvalue_norm_pin_not_natPow`
--    refutes numerically; here it is refuted at the level of the general lemma's proof.
theorem neg_control_norm_no_sqrt {N : ℕ} (hN : 0 < N) (k : ℤ) :
    ‖frickeEigenvalue N k‖ = ((N : ℝ) ^ k) := by
  rw [frickeEigenvalue, norm_mul, Complex.norm_zpow, Complex.norm_I, Complex.norm_real,
    Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), _root_.one_zpow, one_mul]

-- 3. THE LOAD-BEARING PIN GIVEN THE UN-ROOTED NUMBER — `6^12 = 2176782336` where the modulus is
--    `√(6^12) = 46656` — handed `frickeEigenvalue_norm_pin_level_six`'s own tactic block.
theorem neg_control_pin_level_six_wrong_value :
    ‖frickeEigenvalue 6 12‖ = 2176782336 ∧
      Real.sqrt (((6 : ℕ) : ℝ) ^ (12 : ℤ)) = 2176782336 := by
  refine ⟨?_, sqrt_natPow_level_six⟩
  rw [frickeEigenvalue_pin_level_six]
  norm_num

-- 4. THE NORM MADE TO TRACK THE SIGN — at `(N, k) = (1, 2)` the eigenvalue is `-1`
--    (`frickeEigenvalue_pin_neg_one`) and its modulus is `1`, not `-1` — handed
--    `frickeEigenvalue_norm_pin_neg_one`'s own tactic block.  If this compiled, PIN E would not be
--    evidence that `‖·‖` discards the sign.
theorem neg_control_pin_neg_one_signed :
    ‖frickeEigenvalue 1 2‖ = -1 ∧ Real.sqrt (((1 : ℕ) : ℝ) ^ (2 : ℤ)) = -1 := by
  refine ⟨?_, ?_⟩
  · rw [frickeEigenvalue_pin_neg_one, norm_neg, norm_one]
  · rw [Nat.cast_one, _root_.one_zpow, Real.sqrt_one]

-- 5. THE `i`-FACTOR NOT DISCARDED at the odd-weight, irrational instance — claiming
--    `‖frickeEigenvalue 2 1‖ = -(I * √2)`, i.e. the eigenvalue itself rather than its size, is not
--    even type-correct as a real equation; stated over `ℂ` it is the false claim that the modulus
--    equals the eigenvalue, handed the real pin's own opening rewrite.
theorem neg_control_pin_level_two_weight_one_not_norm :
    ((‖frickeEigenvalue 2 1‖ : ℝ) : ℂ) = frickeEigenvalue 2 1 := by
  rw [frickeEigenvalue_pin_level_two_weight_one, norm_neg, norm_mul, Complex.norm_I,
    Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), one_mul]
