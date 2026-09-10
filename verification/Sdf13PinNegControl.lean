/- NEGATIVE CONTROL for `SDF-13` (`frickeEigenvalue_eq_neg_one_iff`), its instance pins and its
   `FinalCheck` guard (Mathesis HARDNESS.md H2: a checker that cannot fail is not a checker).

   This file lives OUTSIDE the library target so the build stays green while the control stays
   runnable.  Every declaration below is deliberately WRONG.  Run it with

     lake --packages=local-packages.json env lean verification/Sdf13PinNegControl.lean

   and it MUST exit nonzero.  (`--packages` is a GLOBAL lake flag and must precede the subcommand:
   LL-27, LL-32.  The other two spellings both exit 1 for an ENVIRONMENT reason, which makes a
   negative control look like it passed when it examined nothing — and this run reproduced exactly
   that: `lake env lean` without the flag exits 1 with `object file ... Discriminant.olean ... does
   not exist`, which says nothing about the mathematics.)

   `SDF-13` says `frickeEigenvalue N k = -1 ↔ (k % 4 = 2 ∧ N = 1)`.  The errors that statement can
   hide are: the LEVEL conjunct dropped (reading `SDF-09` as if it settled the eigenvalue rather
   than only its root-of-unity factor); the RESIDUE conjunct dropped (reading `SDF-10` the same
   way); `%` read as a TRUNCATING remainder, which would silently make the node false at every
   negative weight in `k ≡ 2 (mod 4)`; the `SDF-12` right-hand side mistaken for this one; and a
   pinned VALUE that is simply the wrong number.  Each item below takes a statement that is FALSE
   for one of those reasons and hands it EXACTLY the tactic block the corresponding positive
   declaration uses.  If any of them compiled, the positive pins in
   `EtaQuotientFrickeSelfDual.lean` would be evidence about nothing. -/
import SocrateAI.ModularForms.EtaQuotientFrickeSelfDual

open SocrateAI.ModularForms Complex

-- 1. WRONG AXIOM FOOTPRINT.  The real guard in `FinalCheck.lean` §`Sdf13` says
--    `[propext, Classical.choice, Quot.sound]`; this claims the node is axiom-free, so a guard
--    written without teeth would pass here too.
/-- info: 'SocrateAI.ModularForms.frickeEigenvalue_eq_neg_one_iff' does not depend on any axioms -/
#guard_msgs in #print axioms frickeEigenvalue_eq_neg_one_iff

-- 2. THE LEVEL CONJUNCT DROPPED, at the instance that refutes it.  `2 % 4 = 2` holds and the root
--    of unity IS `-1`, but the eigenvalue at `(6, 2)` is `-6`, because the UNNORMALISED constant
--    carries `N^{k/2} = 6`.  Handed `frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two`'s own
--    refutation block, used here to try to prove the opposite.
theorem neg_control_level_conjunct_dropped : frickeEigenvalue 6 2 = -1 := by
  rw [frickeEigenvalue_pin_level_six_weight_two]
  norm_num

-- 3. THE RESIDUE CONJUNCT DROPPED, at the instance that refutes it.  `N = 1` holds, the modulus is
--    `1`, and yet `λ = 1` because `12 % 4 = 0 ≠ 2`.  This is the `eta_S_via_fricke` instance, where
--    the Fricke transformation carries no constant at all.  Handed
--    `frickeEigenvalue_eq_neg_one_iff_pin_level_one`'s own refutation block.
theorem neg_control_residue_conjunct_dropped : frickeEigenvalue 1 12 = -1 := by
  rw [frickeEigenvalue_pin_level_one]
  norm_num

-- 4. `%` READ AS A TRUNCATING REMAINDER.  `Int.tmod (-2) 4 = -2`, so this right-hand side is FALSE
--    at `(1, -2)` — an instance whose eigenvalue genuinely IS `-1`.  Handed
--    `frickeEigenvalue_eq_neg_one_iff_pin_neg_one_neg_weight`'s own term, with `%` replaced by
--    `Int.tmod`.  If this compiled, `SDF-13` would be false at every weight in `{…, -10, -6, -2}`
--    and nothing in the file would notice.
theorem neg_control_tmod_not_emod :
    frickeEigenvalue 1 (-2) = -1 ↔ (Int.tmod (-2 : ℤ) 4 = 2 ∧ (1 : ℕ) = 1) :=
  iff_of_true frickeEigenvalue_pin_level_one_weight_neg_two ⟨by decide, rfl⟩

-- 5. `SDF-12`'s RIGHT-HAND SIDE MISTAKEN FOR THIS ONE.  `(4 ∣ k ∧ (N = 1 ∨ k = 0))` is NOT
--    equivalent to `(k % 4 = 2 ∧ N = 1)`: at `N = 6`, `k = 0` the first is TRUE and the second is
--    FALSE.  Handed `frickeEigenvalue_eq_neg_one_iff_pin_asymmetry`'s own block, which proves the
--    equivalence that IS true — the one with `k % 4 = 2` on both sides.
theorem neg_control_sdf12_rhs_is_same :
    ∀ (N : ℕ) (k : ℤ), ((4 : ℤ) ∣ k ∧ (N = 1 ∨ k = 0)) ↔ (k % 4 = 2 ∧ N = 1) := by
  intro N k
  constructor
  · rintro ⟨h1, h2 | h2⟩
    · exact ⟨h1, h2⟩
    · exact absurd h1 (by omega)
  · rintro ⟨h1, h2⟩
    exact ⟨h1, Or.inl h2⟩

-- 6. THE ROOT OF UNITY DROPPED FROM A VALUE PIN.  Without the `i^{-k}` factor the eigenvalue at
--    `(6, 2)` would be `+6`; the true value is `-6`.  Handed
--    `frickeEigenvalue_pin_level_six_weight_two`'s own tactic block.
theorem neg_control_value_unit_dropped : frickeEigenvalue 6 2 = 6 := by
  rw [frickeEigenvalue, I_zpow_neg_two,
      show (((6 : ℕ) : ℝ) ^ (2 : ℤ)) = (6 : ℝ) ^ 2 by norm_num,
      Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 6)]
  norm_num

-- 7. THE GENERAL LEMMA WITH THE LEVEL CONJUNCT DROPPED, handed `frickeEigenvalue_eq_neg_one_iff`'s
--    OWN proof block.  The forward direction still goes through — that is exactly the point: the
--    residue condition alone IS necessary — and the BACKWARD direction is where it dies, because
--    nothing supplies `(N : ℝ)^k = 1`.  Item 2 is the numerical instance of the same failure.
theorem neg_control_general_no_level {N : ℕ} (hN : 0 < N) (k : ℤ) :
    frickeEigenvalue N k = -1 ↔ k % 4 = 2 := by
  constructor
  · intro h
    have hsqrt : Real.sqrt ((N : ℝ) ^ k) = 1 := by
      rw [← frickeEigenvalue_norm hN k, h, norm_neg, norm_one]
    refine (I_zpow_neg_eq_neg_one_iff k).mp ?_
    rw [frickeEigenvalue, hsqrt, Complex.ofReal_one, mul_one] at h
    exact h
  · intro hemod
    rw [frickeEigenvalue, (I_zpow_neg_eq_neg_one_iff k).mpr hemod,
      (natCast_zpow_eq_one_iff hN k).mpr (Or.inl rfl), Real.sqrt_one, Complex.ofReal_one, mul_one]
