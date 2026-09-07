/-
# `F3.2-C3` — Ligozat at the genus-zero primes `p = 5, 7, 13`

`F3.2-B1` proved `Γ₀(N) = ⟨-I, T, V⟩` for `N ≤ 4` by a Euclidean descent, and recorded the
counterexample `descent_bound_fails_at_five` showing the descent stops working at `N = 5`.
It stops for a reason that is not an artefact: classically [L, Rademacher] `Γ̄₀(5)` is the free
product `ℤ/2 * ℤ/2 * ℤ`, so `{-I, T, V}` cannot generate `Γ₀(5)` and two elliptic generators are
needed.  That NECESSITY is a literature fact and is NOT formalised here; what IS formalised is
that this proof needs them — deleting the two elliptic generators from `gamma0GensP5` and
re-running the block verbatim leaves exactly two unprovable goals, `j = 2` and `j = 3`, and no
others.

This file supplies them, for the three primes `p = 5, 7, 13` at which `X₀(p)` has genus zero and
`Γ̄₀(p)` is a free product of cyclic groups with exactly two cusps.

## What is proved, in English (LL-1)

1. `Gamma0_eq_of_schreier` — a COSET/TRANSVERSAL CRITERION, valid for every prime `p`: a
   subgroup `H ≤ Γ₀(p)` containing `-I`, `T`, `V` equals `Γ₀(p)` as soon as it contains, for
   every `j ∈ [1, p-1]`, one Schreier generator `h_{j,j'} = !![-j', -1; jj'+1, j]` with
   `j' ∈ [0, p)` and `p ∣ jj' + 1` (i.e. `j' ≡ -j⁻¹ mod p`).  This is coset enumeration against
   the transversal `{1} ∪ {S T^j : 0 ≤ j < p}` for `Γ₀(p) \ SL(2,ℤ)`, whose `p+1` classes are
   `ℙ¹(𝔽_p)`; primality is used exactly once, to know that `j` is invertible mod `p`.
   The group-theoretic engine is `subgroup_eq_of_transversal`, an elementary statement proved
   here from `Subgroup.closure`: Mathlib's `Subgroup.closure_mul_image_eq_top` (Schreier's
   lemma) is NOT used, because it is stated through `IsComplement` and the transversal function,
   which would then have to be computed.

2. `closure_gamma0GensP5`, `closure_gamma0GensP7`, `closure_gamma0GensP13`, packaged as
   `Gamma0_prime_generated` — the criterion discharged at `p = 5, 7, 13`.  The Schreier
   generators that are not elliptic are short explicit words: `h_{1,p-1} = T⁻¹V⁻¹`,
   `h_{p-1,1} = (-I)·V·T`, `h_{j',j} = (-I)·h_{j,j'}⁻¹`, and at `p = 13` two products of two
   elliptics.  Every such identity is a single `decide` on `2 × 2` integer matrices.

3. `tauEll` / `matH_smul_tauEll` / `denom_matH_tauEll` — the elliptic fixed point, uniformly:
   if `ζ` is a root of the characteristic polynomial `X² - (j - j')X + 1` of `h_{j,j'}` lying in
   the open upper half-plane and `jj' + 1 > 0`, then `τ₀ = (ζ - j)/(jj'+1)` is fixed by
   `h_{j,j'}` and `denom h_{j,j'} τ₀ = ζ`.  Only two roots occur: `ζ = i` (trace `0`) and
   `ζ = ω = (-1 + √3 i)/2` (trace `-1`).

4. `etaMultiplierVal_matH_diag` / `etaMultiplierVal_matH_succ` — `F3.2-A9` applied to those
   fixed points: `w(h_{j,j}) = i^{-k}` and `w(h_{j,j+1}) = ω^{-k}`.

5. `etaMultiplierHom_eq_of_p5/7/13` and `ligozat_of_prime5/7/13` — the eta multiplier is THE
   unique character of `Γ₀(p)` with the values `1` at `T` (Ligozat (i)), `1` at `V`
   (Ligozat (ii)), `(-1)^k` at `-I`, and `i^{-k}` / `ω^{-k}` at the elliptic generators; and the
   eta quotient transforms with it across all of `Γ₀(p)`.

6. `etaQuotientH_transform_p5/7/13` — the transformation law with TRIVIAL multiplier, under
   `4 ∣ k` (`p = 5`), `6 ∣ k` (`p = 7`), `12 ∣ k` (`p = 13`).

7. `ligozat_of_prime` — the node's single uniform corollary, quantified over
   `p ∈ ({5,7,13} : Finset ℕ)`, with the common hypothesis `12 ∣ k`.

## What is NOT proved — read before citing

* The multiplier is NOT identified with Ligozat's Kronecker character `χ(d)`.  That is the
  `F3.2-B3` analogue at these levels and it is not attempted here; what is delivered is the
  character's value on a generating set, hence (by uniqueness) on the whole group, but not a
  closed formula in `d = γ₁₁`.
* Ligozat's condition (iii) — holomorphy at the cusps — is untouched at these levels; see
  `F3.1-OBSTRUCTED` and `F3.2-C2`.
* The divisibility hypotheses of item 6 are NOT consequences of Ligozat's congruences.
  `not_multiplier_trivial_p5` is the proof: at `p = 5`, `r = (r₁, r₅) = (5, -1)`, `k = 2`, both
  congruences hold and `k` is even, yet `w(h_{2,2}) = i^{-2} = -1 ≠ 1`.  This is the level-5
  analogue of `F3.2-B2`'s `not_multiplier_trivial_odd`, and it is why the statement carries
  `4 ∣ k` rather than `Even k`.
* `F3.2-OBSTRUCTED` (the Dedekind-sum obstruction to the general multiplier) is AVOIDED, not
  overcome: for three more levels, evaluation of the multiplier is replaced by generation of the
  group plus `A9`'s fixed-point trick.  Nothing here says anything about a general `N`.

## Guards

* `gamma0Gens_three_two_routes` — the Schreier route reproves `F3.2-B1` at `N = 3`
  (`closure_gamma0Gens_three_schreier`), a derivation sharing no step with B1's Euclidean
  descent.  `closure_gamma0Gens_two_schreier` does the same at `N = 2`.
* `S_not_mem_closure_gensP5` / `closure_gamma0GensP5_ne_top` — the closure is PROPER, so the
  theorem has not degenerated into `closure = ⊤`.
* `testGamma0Five_mem_closure` — a concrete non-generator of `Γ₀(5)` is a word in the generators.
* `elliptic_traces` — every extra generator really is elliptic (`|trace| < 2`).
* `etaMultiplierHom_satisfies_p5` / `_p13` — non-vacuity: the generator-value hypotheses of the
  headline are simultaneously satisfiable.
* `not_multiplier_trivial_p5` — the honest negative described above.
-/

import SocrateAI.ModularForms.EtaQuotientModularity

namespace SocrateAI.ModularForms

/-- **The transversal criterion.** -/
theorem subgroup_eq_of_transversal {G : Type*} [Group G] {X : Set G}
    (hX : Subgroup.closure X = ⊤) {H K : Subgroup G} (hHK : H ≤ K) {R : Set G}
    (hR1 : (1 : G) ∈ R) (hRK : ∀ r ∈ R, r ∈ K → r = 1)
    (hfwd : ∀ r ∈ R, ∀ x ∈ X, ∃ r' ∈ R, r * x * r'⁻¹ ∈ H)
    (hbwd : ∀ r ∈ R, ∀ x ∈ X, ∃ r' ∈ R, r * x⁻¹ * r'⁻¹ ∈ H) :
    H = K := by
  set P : G → Prop := fun g => ∃ r ∈ R, g * r⁻¹ ∈ H with hP
  have hP1 : P 1 := ⟨1, hR1, by simpa using H.one_mem⟩
  have hstep : ∀ u : G, P u → ∀ x ∈ X, P (u * x) := by
    rintro u ⟨r, hr, hu⟩ x hx
    obtain ⟨r', hr', h'⟩ := hfwd r hr x hx
    refine ⟨r', hr', ?_⟩
    have he : u * x * r'⁻¹ = (u * r⁻¹) * (r * x * r'⁻¹) := by group
    rw [he]; exact H.mul_mem hu h'
  have hstep' : ∀ u : G, P u → ∀ x ∈ X, P (u * x⁻¹) := by
    rintro u ⟨r, hr, hu⟩ x hx
    obtain ⟨r', hr', h'⟩ := hbwd r hr x hx
    refine ⟨r', hr', ?_⟩
    have he : u * x⁻¹ * r'⁻¹ = (u * r⁻¹) * (r * x⁻¹ * r'⁻¹) := by group
    rw [he]; exact H.mul_mem hu h'
  have key : ∀ g : G, P g := by
    let Q : Subgroup G :=
      { carrier := {g : G | (∀ u, P u → P (u * g)) ∧ (∀ u, P u → P (u * g⁻¹))}
        one_mem' := ⟨fun u hu => by simpa using hu, fun u hu => by simpa using hu⟩
        mul_mem' := by
          rintro a b ⟨ha1, ha2⟩ ⟨hb1, hb2⟩
          refine ⟨fun u hu => ?_, fun u hu => ?_⟩
          · rw [← mul_assoc]; exact hb1 _ (ha1 u hu)
          · rw [mul_inv_rev, ← mul_assoc]; exact ha2 _ (hb2 u hu)
        inv_mem' := by
          rintro a ⟨h1, h2⟩
          refine ⟨h2, fun u hu => ?_⟩
          rw [inv_inv]; exact h1 u hu }
    have hXQ : X ⊆ (Q : Set G) := fun x hx =>
      ⟨fun u hu => hstep u hu x hx, fun u hu => hstep' u hu x hx⟩
    have hQ : Q = ⊤ := top_le_iff.mp (hX ▸ (Subgroup.closure_le Q).mpr hXQ)
    intro g
    have hg : g ∈ Q := hQ ▸ Subgroup.mem_top g
    simpa using hg.1 1 hP1
  refine le_antisymm hHK fun k hk => ?_
  obtain ⟨r, hr, hkr⟩ := key k
  have hrK : r ∈ K := by
    have h := K.mul_mem (K.inv_mem (hHK hkr)) hk
    simpa using h
  rw [hRK r hr hrK] at hkr
  simpa using hkr


open Matrix CongruenceSubgroup ModularForm Complex
open UpperHalfPlane hiding I
open scoped MatrixGroups Real

/-! ### The Schreier generator `h_{j,j'}` and the coset transversal -/

/-- `h_{j,j'} = !![-j', -1; j j' + 1, j]`, of determinant `1`. -/
def matH (j j' : ℤ) : SL(2, ℤ) :=
  ⟨!![-j', -1; j * j' + 1, j], by simp [Matrix.det_fin_two_of]; ring⟩

@[simp] theorem matH_coe (j j' : ℤ) :
    ((matH j j' : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ) = !![-j', -1; j * j' + 1, j] := rfl

theorem matH_mem_Gamma0 {p : ℕ} {j j' : ℤ} (h : ((j * j' + 1 : ℤ) : ZMod p) = 0) :
    matH j j' ∈ Gamma0 p := by
  rw [Gamma0_mem]
  simpa [matH] using h

/-- `S T^j` has lower-left entry `1`, so it never lies in `Γ₀(p)` for `p ≥ 2`. -/
theorem S_T_zpow_one_zero (j : ℤ) :
    (ModularGroup.S * ModularGroup.T ^ j : SL(2, ℤ)) 1 0 = 1 := by
  rw [show ((ModularGroup.S * ModularGroup.T ^ j : SL(2, ℤ)) 1 0)
      = (((ModularGroup.S : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ)
        * ((ModularGroup.T ^ j : SL(2, ℤ)) : Matrix (Fin 2) (Fin 2) ℤ)) 1 0 from rfl,
    ModularGroup.coe_S, ModularGroup.coe_T_zpow]
  simp [Matrix.mul_apply, Fin.sum_univ_two]

theorem S_T_zpow_S (j : ℤ) :
    ((ModularGroup.S * ModularGroup.T ^ j * ModularGroup.S : SL(2, ℤ))
      : Matrix (Fin 2) (Fin 2) ℤ) = !![-1, 0; j, -1] := by
  simp only [Matrix.SpecialLinearGroup.coe_mul, ModularGroup.coe_S, ModularGroup.coe_T_zpow]
  norm_num [Matrix.mul_fin_two]

theorem STS_mul_eq (j j' : ℤ) :
    ModularGroup.S * ModularGroup.T ^ j * ModularGroup.S
      = matH j j' * (ModularGroup.S * ModularGroup.T ^ j') := by
  apply Subtype.ext
  rw [S_T_zpow_S, Matrix.SpecialLinearGroup.coe_mul, matH_coe,
    Matrix.SpecialLinearGroup.coe_mul, ModularGroup.coe_S, ModularGroup.coe_T_zpow]
  norm_num [Matrix.mul_fin_two]

/-- The Schreier generator, in the exact shape the transversal criterion produces it. -/
theorem STS_inv_eq (j j' : ℤ) :
    ModularGroup.S * ModularGroup.T ^ j * ModularGroup.S
        * (ModularGroup.S * ModularGroup.T ^ j')⁻¹ = matH j j' :=
  mul_inv_eq_of_eq_mul (STS_mul_eq j j')

theorem ST_mul_ST_inv (m n : ℤ) :
    ModularGroup.S * ModularGroup.T ^ m * (ModularGroup.S * ModularGroup.T ^ n)⁻¹
      = ModularGroup.S * ModularGroup.T ^ (m - n) * ModularGroup.S⁻¹ := by
  group

theorem ST_conj_zero :
    ModularGroup.S * ModularGroup.T ^ (0 : ℤ) * ModularGroup.S⁻¹ = 1 := by
  simp

theorem ST_conj_natCast (p : ℕ) :
    ModularGroup.S * ModularGroup.T ^ ((p : ℕ) : ℤ) * ModularGroup.S⁻¹ = matV p :=
  (matV_eq_conj p).symm

theorem ST_conj_neg_natCast (p : ℕ) :
    ModularGroup.S * ModularGroup.T ^ (-((p : ℕ) : ℤ)) * ModularGroup.S⁻¹ = (matV p)⁻¹ := by
  rw [matV_eq_conj]; group

theorem S_mul_S : ModularGroup.S * ModularGroup.S = (-1 : SL(2, ℤ)) := by decide

theorem S_inv_eq_neg_one_mul : ModularGroup.S⁻¹ = (-1 : SL(2, ℤ)) * ModularGroup.S := by decide

theorem neg_one_comm (a : SL(2, ℤ)) :
    a * (-1 : SL(2, ℤ)) = (-1 : SL(2, ℤ)) * a := by
  apply Subtype.ext
  simp [Matrix.SpecialLinearGroup.coe_mul]

theorem mul_S_inv_mul (a b : SL(2, ℤ)) :
    a * ModularGroup.S⁻¹ * b = (-1 : SL(2, ℤ)) * (a * ModularGroup.S * b) := by
  rw [S_inv_eq_neg_one_mul, ← mul_assoc a (-1 : SL(2, ℤ)) ModularGroup.S, neg_one_comm a]
  simp [mul_assoc]

/-- The transversal `{1} ∪ {S T^j : 0 ≤ j < p}` for `Γ₀(p) \ SL(2,ℤ)`, `p` prime. -/
def cosetReps (p : ℕ) : Set SL(2, ℤ) :=
  insert 1 ((fun j : ℕ => ModularGroup.S * ModularGroup.T ^ (j : ℤ)) '' {j : ℕ | j < p})

theorem one_mem_cosetReps (p : ℕ) : (1 : SL(2, ℤ)) ∈ cosetReps p := Set.mem_insert _ _

theorem ST_mem_cosetReps {p j : ℕ} (hj : j < p) :
    ModularGroup.S * ModularGroup.T ^ ((j : ℕ) : ℤ) ∈ cosetReps p :=
  Set.mem_insert_of_mem _ ⟨j, hj, rfl⟩

/-- **The generation criterion at prime level.** -/
theorem Gamma0_eq_of_schreier {p : ℕ} (hp : 2 ≤ p) {H : Subgroup SL(2, ℤ)}
    (hle : H ≤ Gamma0 p) (hneg : (-1 : SL(2, ℤ)) ∈ H)
    (hT : ModularGroup.T ∈ H) (hV : matV p ∈ H)
    (hH : ∀ j : ℕ, 1 ≤ j → j < p → ∃ j' : ℕ, j' < p ∧ matH (j : ℤ) (j' : ℤ) ∈ H) :
    H = Gamma0 p := by
  haveI : Fact (1 < p) := ⟨hp⟩
  refine subgroup_eq_of_transversal SpecialLinearGroup.SL2Z_generators hle
    (one_mem_cosetReps p) ?_ ?_ ?_
  · -- `R ∩ Γ₀(p) = {1}`
    intro r hr hrG
    simp only [cosetReps, Set.mem_insert_iff, Set.mem_image, Set.mem_setOf_eq] at hr
    rcases hr with rfl | ⟨j, _, rfl⟩
    · rfl
    · exfalso
      rw [Gamma0_mem, S_T_zpow_one_zero] at hrG
      simpa using hrG
  · -- forward step
    intro r hr x hx
    simp only [cosetReps, Set.mem_insert_iff, Set.mem_image, Set.mem_setOf_eq] at hr
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
    rcases hr with rfl | ⟨j, hj, rfl⟩
    · rcases hx with rfl | rfl
      · exact ⟨ModularGroup.S * ModularGroup.T ^ ((0 : ℕ) : ℤ),
          ST_mem_cosetReps (by omega), by simpa using H.one_mem⟩
      · exact ⟨1, one_mem_cosetReps p, by simpa using hT⟩
    · rcases hx with rfl | rfl
      · -- x = S
        rcases Nat.eq_zero_or_pos j with rfl | hj1
        · refine ⟨1, one_mem_cosetReps p, ?_⟩
          simpa [S_mul_S] using hneg
        · obtain ⟨j', hj', hmem⟩ := hH j hj1 hj
          exact ⟨ModularGroup.S * ModularGroup.T ^ ((j' : ℕ) : ℤ), ST_mem_cosetReps hj',
            by rw [STS_inv_eq]; exact hmem⟩
      · -- x = T
        have hstep : ModularGroup.S * ModularGroup.T ^ ((j : ℕ) : ℤ) * ModularGroup.T
            = ModularGroup.S * ModularGroup.T ^ (((j : ℕ) : ℤ) + 1) := by
          rw [mul_assoc, ← _root_.zpow_add_one]
        rcases Nat.lt_or_ge (j + 1) p with hlt | hge
        · refine ⟨ModularGroup.S * ModularGroup.T ^ (((j + 1 : ℕ)) : ℤ),
            ST_mem_cosetReps hlt, ?_⟩
          rw [hstep, ST_mul_ST_inv]
          push_cast
          simpa using H.one_mem
        · have hjp : (j : ℤ) + 1 = (p : ℤ) := by
            have : j + 1 = p := by omega
            exact_mod_cast congrArg (fun n : ℕ => (n : ℤ)) this
          refine ⟨ModularGroup.S * ModularGroup.T ^ ((0 : ℕ) : ℤ),
            ST_mem_cosetReps (by omega), ?_⟩
          rw [hstep, ST_mul_ST_inv]
          push_cast
          rw [show ((j : ℤ) + 1 - 0) = (p : ℤ) by push_cast at hjp ⊢; omega]
          rw [ST_conj_natCast]
          exact hV
  · -- backward step
    intro r hr x hx
    simp only [cosetReps, Set.mem_insert_iff, Set.mem_image, Set.mem_setOf_eq] at hr
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
    rcases hr with rfl | ⟨j, hj, rfl⟩
    · rcases hx with rfl | rfl
      · refine ⟨ModularGroup.S * ModularGroup.T ^ ((0 : ℕ) : ℤ),
          ST_mem_cosetReps (by omega), ?_⟩
        rw [mul_S_inv_mul]
        simpa [S_mul_S] using hneg
      · exact ⟨1, one_mem_cosetReps p, by simpa using H.inv_mem hT⟩
    · rcases hx with rfl | rfl
      · -- x = S⁻¹
        rcases Nat.eq_zero_or_pos j with rfl | hj1
        · refine ⟨1, one_mem_cosetReps p, ?_⟩
          rw [mul_S_inv_mul]
          have : ModularGroup.S * ModularGroup.T ^ ((0 : ℕ) : ℤ) * ModularGroup.S * (1 : SL(2, ℤ))⁻¹
              = (-1 : SL(2, ℤ)) := by simpa [S_mul_S] using rfl
          rw [this]
          simpa using H.mul_mem hneg hneg
        · obtain ⟨j', hj', hmem⟩ := hH j hj1 hj
          refine ⟨ModularGroup.S * ModularGroup.T ^ ((j' : ℕ) : ℤ), ST_mem_cosetReps hj', ?_⟩
          rw [mul_S_inv_mul, STS_inv_eq]
          exact H.mul_mem hneg hmem
      · -- x = T⁻¹
        have hstep : ModularGroup.S * ModularGroup.T ^ ((j : ℕ) : ℤ) * ModularGroup.T⁻¹
            = ModularGroup.S * ModularGroup.T ^ (((j : ℕ) : ℤ) - 1) := by
          rw [mul_assoc, ← _root_.zpow_sub_one]
        rcases Nat.eq_zero_or_pos j with rfl | hj1
        · refine ⟨ModularGroup.S * ModularGroup.T ^ (((p - 1 : ℕ)) : ℤ),
            ST_mem_cosetReps (by omega), ?_⟩
          rw [hstep, ST_mul_ST_inv]
          have hc : ((0 : ℕ) : ℤ) - 1 - ((p - 1 : ℕ) : ℤ) = -((p : ℕ) : ℤ) := by
            have : ((p - 1 : ℕ) : ℤ) = (p : ℤ) - 1 := by omega
            rw [this]; push_cast; ring
          rw [hc, ST_conj_neg_natCast]
          exact H.inv_mem hV
        · refine ⟨ModularGroup.S * ModularGroup.T ^ (((j - 1 : ℕ)) : ℤ),
            ST_mem_cosetReps (by omega), ?_⟩
          rw [hstep, ST_mul_ST_inv]
          have hc : ((j : ℕ) : ℤ) - 1 - ((j - 1 : ℕ) : ℤ) = 0 := by omega
          rw [hc, ST_conj_zero]
          exact H.one_mem


/-- The generating set of `Γ₀(5)`: `-I`, `T`, `V = !![1,0;-5,1]`, and the elliptic
Schreier generators. -/
def gamma0GensP5 : Set SL(2, ℤ) :=
  {(-1 : SL(2, ℤ)), ModularGroup.T, matV 5, matH 2 2, matH 3 3}

set_option maxRecDepth 40000 in
/-- **F3.2-C3 at `p = 5`.**  `Γ₀(5)` is generated by `-I`, `T`, `V` and the listed
elliptic elements. -/
theorem closure_gamma0GensP5 : Subgroup.closure gamma0GensP5 = Gamma0 5 := by
  have hneg : (-1 : SL(2, ℤ)) ∈ Subgroup.closure gamma0GensP5 :=
    Subgroup.subset_closure (by simp [gamma0GensP5])
  have hT : ModularGroup.T ∈ Subgroup.closure gamma0GensP5 :=
    Subgroup.subset_closure (by simp [gamma0GensP5])
  have hV : matV 5 ∈ Subgroup.closure gamma0GensP5 :=
    Subgroup.subset_closure (by simp [gamma0GensP5])
  have hE1 : matH 2 2 ∈ Subgroup.closure gamma0GensP5 :=
    Subgroup.subset_closure (by simp [gamma0GensP5])
  have hE2 : matH 3 3 ∈ Subgroup.closure gamma0GensP5 :=
    Subgroup.subset_closure (by simp [gamma0GensP5])
  refine Gamma0_eq_of_schreier (by norm_num) ?_ hneg hT hV ?_
  · rw [Subgroup.closure_le]
    intro g hg
    simp only [gamma0GensP5, Set.mem_insert_iff, Set.mem_singleton_iff] at hg
    rcases hg with rfl|rfl|rfl|rfl|rfl
    · exact neg_one_mem_Gamma0 5
    · exact T_mem_Gamma0 5
    · exact matV_mem_Gamma0 5
    · exact matH_mem_Gamma0 (by decide)
    · exact matH_mem_Gamma0 (by decide)
  · intro j hj1 hj
    interval_cases j
    · refine ⟨4, by norm_num, ?_⟩
      have hw : matH ((1 : ℕ) : ℤ) ((4 : ℕ) : ℤ) = ModularGroup.T⁻¹ * (matV 5)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ (Subgroup.inv_mem _ hT) (Subgroup.inv_mem _ hV)
    · refine ⟨2, by norm_num, ?_⟩
      have hw : matH ((2 : ℕ) : ℤ) ((2 : ℕ) : ℤ) = matH 2 2 := by decide
      rw [hw]
      exact hE1
    · refine ⟨3, by norm_num, ?_⟩
      have hw : matH ((3 : ℕ) : ℤ) ((3 : ℕ) : ℤ) = matH 3 3 := by decide
      rw [hw]
      exact hE2
    · refine ⟨1, by norm_num, ?_⟩
      have hw : matH ((4 : ℕ) : ℤ) ((1 : ℕ) : ℤ)
          = (-1 : SL(2, ℤ)) * (matV 5 * ModularGroup.T) := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.mul_mem _ hV hT)

/-- The generating set of `Γ₀(7)`: `-I`, `T`, `V = !![1,0;-7,1]`, and the elliptic
Schreier generators. -/
def gamma0GensP7 : Set SL(2, ℤ) :=
  {(-1 : SL(2, ℤ)), ModularGroup.T, matV 7, matH 2 3, matH 4 5}

set_option maxRecDepth 40000 in
/-- **F3.2-C3 at `p = 7`.**  `Γ₀(7)` is generated by `-I`, `T`, `V` and the listed
elliptic elements. -/
theorem closure_gamma0GensP7 : Subgroup.closure gamma0GensP7 = Gamma0 7 := by
  have hneg : (-1 : SL(2, ℤ)) ∈ Subgroup.closure gamma0GensP7 :=
    Subgroup.subset_closure (by simp [gamma0GensP7])
  have hT : ModularGroup.T ∈ Subgroup.closure gamma0GensP7 :=
    Subgroup.subset_closure (by simp [gamma0GensP7])
  have hV : matV 7 ∈ Subgroup.closure gamma0GensP7 :=
    Subgroup.subset_closure (by simp [gamma0GensP7])
  have hE1 : matH 2 3 ∈ Subgroup.closure gamma0GensP7 :=
    Subgroup.subset_closure (by simp [gamma0GensP7])
  have hE2 : matH 4 5 ∈ Subgroup.closure gamma0GensP7 :=
    Subgroup.subset_closure (by simp [gamma0GensP7])
  refine Gamma0_eq_of_schreier (by norm_num) ?_ hneg hT hV ?_
  · rw [Subgroup.closure_le]
    intro g hg
    simp only [gamma0GensP7, Set.mem_insert_iff, Set.mem_singleton_iff] at hg
    rcases hg with rfl|rfl|rfl|rfl|rfl
    · exact neg_one_mem_Gamma0 7
    · exact T_mem_Gamma0 7
    · exact matV_mem_Gamma0 7
    · exact matH_mem_Gamma0 (by decide)
    · exact matH_mem_Gamma0 (by decide)
  · intro j hj1 hj
    interval_cases j
    · refine ⟨6, by norm_num, ?_⟩
      have hw : matH ((1 : ℕ) : ℤ) ((6 : ℕ) : ℤ) = ModularGroup.T⁻¹ * (matV 7)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ (Subgroup.inv_mem _ hT) (Subgroup.inv_mem _ hV)
    · refine ⟨3, by norm_num, ?_⟩
      have hw : matH ((2 : ℕ) : ℤ) ((3 : ℕ) : ℤ) = matH 2 3 := by decide
      rw [hw]
      exact hE1
    · refine ⟨2, by norm_num, ?_⟩
      have hw : matH ((3 : ℕ) : ℤ) ((2 : ℕ) : ℤ) = (-1 : SL(2, ℤ)) * (matH 2 3)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ hE1)
    · refine ⟨5, by norm_num, ?_⟩
      have hw : matH ((4 : ℕ) : ℤ) ((5 : ℕ) : ℤ) = matH 4 5 := by decide
      rw [hw]
      exact hE2
    · refine ⟨4, by norm_num, ?_⟩
      have hw : matH ((5 : ℕ) : ℤ) ((4 : ℕ) : ℤ) = (-1 : SL(2, ℤ)) * (matH 4 5)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ hE2)
    · refine ⟨1, by norm_num, ?_⟩
      have hw : matH ((6 : ℕ) : ℤ) ((1 : ℕ) : ℤ)
          = (-1 : SL(2, ℤ)) * (matV 7 * ModularGroup.T) := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.mul_mem _ hV hT)

/-- The generating set of `Γ₀(13)`: `-I`, `T`, `V = !![1,0;-13,1]`, and the elliptic
Schreier generators. -/
def gamma0GensP13 : Set SL(2, ℤ) :=
  {(-1 : SL(2, ℤ)), ModularGroup.T, matV 13, matH 3 4, matH 5 5, matH 8 8, matH 9 10}

set_option maxRecDepth 40000 in
/-- **F3.2-C3 at `p = 13`.**  `Γ₀(13)` is generated by `-I`, `T`, `V` and the listed
elliptic elements. -/
theorem closure_gamma0GensP13 : Subgroup.closure gamma0GensP13 = Gamma0 13 := by
  have hneg : (-1 : SL(2, ℤ)) ∈ Subgroup.closure gamma0GensP13 :=
    Subgroup.subset_closure (by simp [gamma0GensP13])
  have hT : ModularGroup.T ∈ Subgroup.closure gamma0GensP13 :=
    Subgroup.subset_closure (by simp [gamma0GensP13])
  have hV : matV 13 ∈ Subgroup.closure gamma0GensP13 :=
    Subgroup.subset_closure (by simp [gamma0GensP13])
  have hE1 : matH 3 4 ∈ Subgroup.closure gamma0GensP13 :=
    Subgroup.subset_closure (by simp [gamma0GensP13])
  have hE2 : matH 5 5 ∈ Subgroup.closure gamma0GensP13 :=
    Subgroup.subset_closure (by simp [gamma0GensP13])
  have hE3 : matH 8 8 ∈ Subgroup.closure gamma0GensP13 :=
    Subgroup.subset_closure (by simp [gamma0GensP13])
  have hE4 : matH 9 10 ∈ Subgroup.closure gamma0GensP13 :=
    Subgroup.subset_closure (by simp [gamma0GensP13])
  refine Gamma0_eq_of_schreier (by norm_num) ?_ hneg hT hV ?_
  · rw [Subgroup.closure_le]
    intro g hg
    simp only [gamma0GensP13, Set.mem_insert_iff, Set.mem_singleton_iff] at hg
    rcases hg with rfl|rfl|rfl|rfl|rfl|rfl|rfl
    · exact neg_one_mem_Gamma0 13
    · exact T_mem_Gamma0 13
    · exact matV_mem_Gamma0 13
    · exact matH_mem_Gamma0 (by decide)
    · exact matH_mem_Gamma0 (by decide)
    · exact matH_mem_Gamma0 (by decide)
    · exact matH_mem_Gamma0 (by decide)
  · intro j hj1 hj
    interval_cases j
    · refine ⟨12, by norm_num, ?_⟩
      have hw : matH ((1 : ℕ) : ℤ) ((12 : ℕ) : ℤ) = ModularGroup.T⁻¹ * (matV 13)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ (Subgroup.inv_mem _ hT) (Subgroup.inv_mem _ hV)
    · refine ⟨6, by norm_num, ?_⟩
      have hw : matH ((2 : ℕ) : ℤ) ((6 : ℕ) : ℤ) = matH 3 4 * matH 5 5 := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hE1 hE2
    · refine ⟨4, by norm_num, ?_⟩
      have hw : matH ((3 : ℕ) : ℤ) ((4 : ℕ) : ℤ) = matH 3 4 := by decide
      rw [hw]
      exact hE1
    · refine ⟨3, by norm_num, ?_⟩
      have hw : matH ((4 : ℕ) : ℤ) ((3 : ℕ) : ℤ) = (-1 : SL(2, ℤ)) * (matH 3 4)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ hE1)
    · refine ⟨5, by norm_num, ?_⟩
      have hw : matH ((5 : ℕ) : ℤ) ((5 : ℕ) : ℤ) = matH 5 5 := by decide
      rw [hw]
      exact hE2
    · refine ⟨2, by norm_num, ?_⟩
      have hw : matH ((6 : ℕ) : ℤ) ((2 : ℕ) : ℤ)
          = (-1 : SL(2, ℤ)) * (matH 3 4 * matH 5 5)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ (Subgroup.mul_mem _ hE1 hE2))
    · refine ⟨11, by norm_num, ?_⟩
      have hw : matH ((7 : ℕ) : ℤ) ((11 : ℕ) : ℤ) = matH 8 8 * matH 9 10 := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hE3 hE4
    · refine ⟨8, by norm_num, ?_⟩
      have hw : matH ((8 : ℕ) : ℤ) ((8 : ℕ) : ℤ) = matH 8 8 := by decide
      rw [hw]
      exact hE3
    · refine ⟨10, by norm_num, ?_⟩
      have hw : matH ((9 : ℕ) : ℤ) ((10 : ℕ) : ℤ) = matH 9 10 := by decide
      rw [hw]
      exact hE4
    · refine ⟨9, by norm_num, ?_⟩
      have hw : matH ((10 : ℕ) : ℤ) ((9 : ℕ) : ℤ) = (-1 : SL(2, ℤ)) * (matH 9 10)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ hE4)
    · refine ⟨7, by norm_num, ?_⟩
      have hw : matH ((11 : ℕ) : ℤ) ((7 : ℕ) : ℤ)
          = (-1 : SL(2, ℤ)) * (matH 8 8 * matH 9 10)⁻¹ := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.inv_mem _ (Subgroup.mul_mem _ hE3 hE4))
    · refine ⟨1, by norm_num, ?_⟩
      have hw : matH ((12 : ℕ) : ℤ) ((1 : ℕ) : ℤ)
          = (-1 : SL(2, ℤ)) * (matV 13 * ModularGroup.T) := by decide
      rw [hw]
      exact Subgroup.mul_mem _ hneg (Subgroup.mul_mem _ hV hT)


/-! ### The elliptic generators: fixed point, automorphy factor, multiplier value -/

/-- `matH j j'` acts on `ℍ` by the Möbius map `z ↦ (-j'z - 1)/((jj'+1)z + j)`. -/
theorem coe_matH_smul (j j' : ℤ) (z : ℍ) :
    ((matH j j' • z : ℍ) : ℂ)
      = (-(j' : ℂ) * (z : ℂ) - 1) / (((j : ℂ) * (j' : ℂ) + 1) * (z : ℂ) + (j : ℂ)) := by
  rw [UpperHalfPlane.coe_specialLinearGroup_apply]
  simp [matH]
  ring

/-- `denom (matH j j') z = (jj'+1) z + j`. -/
theorem denom_matH (j j' : ℤ) (z : ℍ) :
    denom ((matH j j' : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)
      = ((j : ℂ) * (j' : ℂ) + 1) * (z : ℂ) + (j : ℂ) := by
  rw [ModularGroup.denom_apply]
  simp [matH]

/-- The elliptic fixed point of `matH j j'`, written through the value `ζ` of the automorphy
factor at it: `τ₀ = (ζ - j)/(jj'+1)`.  Requires `jj' + 1 > 0` (true for both families used
below: `j' = j` gives `j²+1`, `j' = j+1` gives `j²+j+1`) and `Im ζ > 0`. -/
noncomputable def tauEll (j j' : ℤ) (hc : 0 < j * j' + 1) (ζ : ℂ) (hζ : 0 < ζ.im) : ℍ :=
  ⟨(ζ - (j : ℂ)) / (((j * j' + 1 : ℤ) : ℝ) : ℂ), by
    have hpos : (0 : ℝ) < ((j * j' + 1 : ℤ) : ℝ) := by exact_mod_cast hc
    simp only [Complex.div_ofReal_im, Complex.sub_im, Complex.intCast_im, sub_zero]
    exact div_pos hζ hpos⟩

theorem coe_tauEll (j j' : ℤ) (hc : 0 < j * j' + 1) (ζ : ℂ) (hζ : 0 < ζ.im) :
    ((tauEll j j' hc ζ hζ : ℍ) : ℂ) = (ζ - (j : ℂ)) / ((j : ℂ) * (j' : ℂ) + 1) := by
  show (ζ - (j : ℂ)) / (((j * j' + 1 : ℤ) : ℝ) : ℂ) = _
  push_cast
  ring

theorem c_ne_zero {j j' : ℤ} (hc : 0 < j * j' + 1) :
    ((j : ℂ) * (j' : ℂ) + 1) ≠ 0 := by
  have : ((j * j' + 1 : ℤ) : ℂ) ≠ 0 := Int.cast_ne_zero.mpr (by omega)
  push_cast at this
  exact this

/-- The automorphy factor of `matH j j'` at its fixed point is `ζ`. -/
theorem denom_matH_tauEll (j j' : ℤ) (hc : 0 < j * j' + 1) (ζ : ℂ) (hζ : 0 < ζ.im) :
    denom ((matH j j' : SL(2, ℤ)) : GL (Fin 2) ℝ) ((tauEll j j' hc ζ hζ : ℍ) : ℂ) = ζ := by
  have hcz : ((j : ℂ) * (j' : ℂ) + 1) ≠ 0 := c_ne_zero hc
  rw [denom_matH, coe_tauEll, mul_div_cancel₀ _ hcz]
  ring

/-- **The fixed point.**  If `ζ` is a root of the characteristic polynomial `X² - tX + 1` of
`matH j j'` (`t = j - j'` is its trace) lying in the open upper half-plane, then
`τ₀ = (ζ - j)/(jj'+1)` is fixed by `matH j j'`. -/
theorem matH_smul_tauEll (j j' : ℤ) (hc : 0 < j * j' + 1) (ζ : ℂ) (hζ : 0 < ζ.im)
    (hpoly : ζ ^ 2 - ((j : ℂ) - (j' : ℂ)) * ζ + 1 = 0) :
    matH j j' • tauEll j j' hc ζ hζ = tauEll j j' hc ζ hζ := by
  apply UpperHalfPlane.ext
  have hcz : ((j : ℂ) * (j' : ℂ) + 1) ≠ 0 := c_ne_zero hc
  have hζ0 : ζ ≠ 0 := by
    intro h; rw [h] at hζ; simp at hζ
  have hden : ((j : ℂ) * (j' : ℂ) + 1) * ((tauEll j j' hc ζ hζ : ℍ) : ℂ) + (j : ℂ) = ζ := by
    rw [coe_tauEll, mul_div_cancel₀ _ hcz]; ring
  rw [coe_matH_smul, hden, div_eq_iff hζ0, coe_tauEll]
  have hcz' : ((j' : ℂ) * (j : ℂ) + 1) ≠ 0 := by rw [mul_comm]; exact hcz
  field_simp
  linear_combination (-1 : ℂ) * hpoly


/-- `ω = (-1 + √3 i)/2`, the primitive cube root of unity: the automorphy factor of an
order-three elliptic element at its fixed point. -/
noncomputable def omega3 : ℂ := (-1 + (Real.sqrt 3 : ℝ) * Complex.I) / 2

theorem omega3_im : omega3.im = Real.sqrt 3 / 2 := by
  simp [omega3, Complex.add_im, Complex.div_im, Complex.normSq_apply]

theorem omega3_im_pos : 0 < omega3.im := by
  rw [omega3_im]
  have : (0 : ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  linarith

theorem omega3_poly : omega3 ^ 2 + omega3 + 1 = 0 := by
  have hs : ((Real.sqrt 3 : ℝ) : ℂ) ^ 2 = 3 := by
    norm_cast
    rw [Real.sq_sqrt] ; norm_num
  unfold omega3
  field_simp
  linear_combination Complex.I ^ 2 * hs + 3 * Complex.I_sq

theorem I_im_pos : (0 : ℝ) < Complex.I.im := by simp

/-- **The multiplier at a trace-zero elliptic generator.**  `w(matH j j) = i^{-k}`. -/
theorem etaMultiplierVal_matH_diag {p : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ p.divisors, r δ = 2 * k) {j : ℤ} (hmem : matH j j ∈ Gamma0 p) :
    etaMultiplierVal p r k (matH j j) = Complex.I ^ (-k) := by
  have hc : 0 < j * j + 1 := by nlinarith [mul_self_nonneg j]
  have hpoly : Complex.I ^ 2 - ((j : ℂ) - (j : ℂ)) * Complex.I + 1 = 0 := by
    simp [Complex.I_sq]
  rw [etaMultiplierVal_of_fixed r hk hmem
      (matH_smul_tauEll j j hc Complex.I I_im_pos hpoly),
    denom_matH_tauEll]

/-- **The multiplier at a trace `-1` elliptic generator.**  `w(matH j (j+1)) = ω^{-k}`. -/
theorem etaMultiplierVal_matH_succ {p : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ p.divisors, r δ = 2 * k) {j : ℤ} (hmem : matH j (j + 1) ∈ Gamma0 p) :
    etaMultiplierVal p r k (matH j (j + 1)) = omega3 ^ (-k) := by
  have hc : 0 < j * (j + 1) + 1 := by nlinarith [sq_nonneg (2 * j + 1)]
  have hpoly : omega3 ^ 2 - ((j : ℂ) - ((j + 1 : ℤ) : ℂ)) * omega3 + 1 = 0 := by
    push_cast
    linear_combination omega3_poly
  rw [etaMultiplierVal_of_fixed r hk hmem
      (matH_smul_tauEll j (j + 1) hc omega3 omega3_im_pos hpoly),
    denom_matH_tauEll]

theorem I_zpow_neg_eq_one {k : ℤ} (h : (4 : ℤ) ∣ k) : Complex.I ^ (-k) = 1 := by
  obtain ⟨m, rfl⟩ := h
  have hI4 : (Complex.I) ^ (4 : ℤ) = 1 := by
    rw [show (4 : ℤ) = ((4 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_pow_four]
  rw [show (-(4 * m) : ℤ) = 4 * (-m) by ring, _root_.zpow_mul, hI4, _root_.one_zpow]

theorem omega3_zpow_neg_eq_one {k : ℤ} (h : (3 : ℤ) ∣ k) : omega3 ^ (-k) = 1 := by
  obtain ⟨m, rfl⟩ := h
  have hw3 : omega3 ^ (3 : ℤ) = 1 := by
    rw [show (3 : ℤ) = ((3 : ℕ) : ℤ) by norm_num, zpow_natCast]
    linear_combination (omega3 - 1) * omega3_poly
  rw [show (-(3 * m) : ℤ) = 3 * (-m) by ring, _root_.zpow_mul, hw3, _root_.one_zpow]


/-! ### Uniqueness of a character by its values on a generating set -/

/-- Generation transported into the subtype `Γ₀(N)`. -/
theorem closure_preimage_eq_top {N : ℕ} {S : Set SL(2, ℤ)}
    (hS : S ⊆ (Gamma0 N : Set SL(2, ℤ))) (hgen : Subgroup.closure S = Gamma0 N) :
    Subgroup.closure ((Gamma0 N).subtype ⁻¹' S) = ⊤ := by
  have himg : (Gamma0 N).subtype '' ((Gamma0 N).subtype ⁻¹' S) = S := by
    rw [Set.image_preimage_eq_inter_range]
    have hr : Set.range ((Gamma0 N).subtype) = (Gamma0 N : Set SL(2, ℤ)) := by
      rw [← MonoidHom.coe_range, Subgroup.range_subtype]
    rw [hr, Set.inter_eq_left.mpr hS]
  rw [← Subgroup.map_subtype_inj (H := Gamma0 N), MonoidHom.map_closure, himg, hgen,
    ← MonoidHom.range_eq_map, Subgroup.range_subtype]

/-- A homomorphism out of `Γ₀(N)` is determined by its values on any generating set. -/
theorem hom_ext_of_closure {N : ℕ} {S : Set SL(2, ℤ)}
    (hS : S ⊆ (Gamma0 N : Set SL(2, ℤ))) (hgen : Subgroup.closure S = Gamma0 N)
    {M : Type*} [Monoid M] {w w' : Gamma0 N →* M}
    (h : Set.EqOn w w' ((Gamma0 N).subtype ⁻¹' S)) : w = w' :=
  MonoidHom.eq_of_eqOn_dense (closure_preimage_eq_top hS hgen) h

theorem coe_etaMultiplierHom {N : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k) (e : Gamma0 N) :
    ((etaMultiplierHom r hk e : ℂˣ) : ℂ) = etaMultiplierVal N r k (e : SL(2, ℤ)) := by
  simp [etaMultiplierHom]

/-- The trace-zero multiplier value, in the shape the instantiations need it. -/
theorem etaMultiplierVal_matH_trace_zero {p : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ p.divisors, r δ = 2 * k) {j j' : ℤ} (hj : j' = j)
    (hmem : matH j j' ∈ Gamma0 p) :
    etaMultiplierVal p r k (matH j j') = Complex.I ^ (-k) := by
  subst hj; exact etaMultiplierVal_matH_diag r hk hmem

/-- The trace `-1` multiplier value, in the shape the instantiations need it. -/
theorem etaMultiplierVal_matH_trace_neg_one {p : ℕ} (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ p.divisors, r δ = 2 * k) {j j' : ℤ} (hj : j' = j + 1)
    (hmem : matH j j' ∈ Gamma0 p) :
    etaMultiplierVal p r k (matH j j') = omega3 ^ (-k) := by
  subst hj; exact etaMultiplierVal_matH_succ r hk hmem

theorem matH22_mem5 : matH 2 2 ∈ Gamma0 5 := matH_mem_Gamma0 (by decide)

theorem matH33_mem5 : matH 3 3 ∈ Gamma0 5 := matH_mem_Gamma0 (by decide)


theorem gamma0GensP5_subset : gamma0GensP5 ⊆ (Gamma0 5 : Set SL(2, ℤ)) := by
  intro g hg
  simp only [gamma0GensP5, Set.mem_insert_iff, Set.mem_singleton_iff] at hg
  rcases hg with rfl|rfl|rfl|rfl|rfl
  · exact neg_one_mem_Gamma0 5
  · exact T_mem_Gamma0 5
  · exact matV_mem_Gamma0 5
  · exact matH22_mem5
  · exact matH33_mem5


/-- **F3.2-C3 at `p = 5`: the eta multiplier is the UNIQUE character with the listed
generator values.** -/
theorem etaMultiplierHom_eq_of_p5 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (5 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 5 r) (h2 : LigozatCongr2 5 r)
    (w : Gamma0 5 →* ℂˣ)
    (hwT : w ⟨ModularGroup.T, T_mem_Gamma0 5⟩ = 1)
    (hwV : w ⟨matV 5, matV_mem_Gamma0 5⟩ = 1)
    (hwm : w ⟨-1, neg_one_mem_Gamma0 5⟩ = (-1 : ℂˣ) ^ k)
    (hwE1 : ((w ⟨matH 2 2, matH22_mem5⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k))
    (hwE2 : ((w ⟨matH 3 3, matH33_mem5⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k)) :
    w = etaMultiplierHom r hk := by
  refine hom_ext_of_closure gamma0GensP5_subset closure_gamma0GensP5 ?_
  intro x hx
  simp only [Set.mem_preimage, gamma0GensP5, Set.mem_insert_iff, Set.mem_singleton_iff] at hx
  rcases hx with h|h|h|h|h
  · rw [show x = (⟨-1, neg_one_mem_Gamma0 5⟩ : Gamma0 5) from Subtype.ext h, hwm,
      etaMultiplierHom_neg_one]
  · rw [show x = (⟨ModularGroup.T, T_mem_Gamma0 5⟩ : Gamma0 5) from Subtype.ext h, hwT,
      etaMultiplierHom_T_eq_one r hk h1]
  · rw [show x = (⟨matV 5, matV_mem_Gamma0 5⟩ : Gamma0 5) from Subtype.ext h, hwV,
      etaMultiplierHom_V_eq_one (by norm_num) r hk h2]
  · rw [show x = (⟨matH 2 2, matH22_mem5⟩ : Gamma0 5) from Subtype.ext h]
    apply Units.ext
    rw [hwE1, coe_etaMultiplierHom]
    exact (etaMultiplierVal_matH_trace_zero r hk rfl matH22_mem5).symm
  · rw [show x = (⟨matH 3 3, matH33_mem5⟩ : Gamma0 5) from Subtype.ext h]
    apply Units.ext
    rw [hwE2, coe_etaMultiplierHom]
    exact (etaMultiplierVal_matH_trace_zero r hk rfl matH33_mem5).symm

/-- **F3.2-C3, THE HEADLINE at `p = 5`.**  Full Ligozat at level 5: any character with the
listed generator values transports the eta quotient across ALL of `Γ₀(5)`. -/
theorem ligozat_of_prime5 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (5 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 5 r) (h2 : LigozatCongr2 5 r)
    (w : Gamma0 5 →* ℂˣ)
    (hwT : w ⟨ModularGroup.T, T_mem_Gamma0 5⟩ = 1)
    (hwV : w ⟨matV 5, matV_mem_Gamma0 5⟩ = 1)
    (hwm : w ⟨-1, neg_one_mem_Gamma0 5⟩ = (-1 : ℂˣ) ^ k)
    (hwE1 : ((w ⟨matH 2 2, matH22_mem5⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k))
    (hwE2 : ((w ⟨matH 3 3, matH33_mem5⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k)) :
    ∀ (γ : Gamma0 5) (z : ℍ),
      etaQuotientH 5 r ((γ : SL(2, ℤ)) • z)
        = (w γ : ℂ) * (denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)) ^ k
          * etaQuotientH 5 r z := by
  intro γ z
  rw [etaMultiplierHom_eq_of_p5 r hk h1 h2 w hwT hwV hwm hwE1 hwE2]
  exact etaQuotientH_transform r hk γ.2 z


/-- For `4 ∣ k` every generator value is `1`, so the multiplier is trivial at level 5. -/
theorem etaMultiplierHom_eq_one_p5 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (5 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 5 r) (h2 : LigozatCongr2 5 r) (hdvd : (4 : ℤ) ∣ k) :
    etaMultiplierHom r hk = 1 := by
  have hke : Even k := by
    obtain ⟨m, rfl⟩ := hdvd; exact ⟨2 * m, by ring⟩
  refine (etaMultiplierHom_eq_of_p5 r hk h1 h2 1 rfl rfl ?_ ?_ ?_).symm
  · rw [hke.neg_one_zpow]; rfl
  · simp [I_zpow_neg_eq_one (show (4 : ℤ) ∣ k from dvd_trans (⟨1, by ring⟩ : (4 : ℤ) ∣ 4) hdvd)]
  · simp [I_zpow_neg_eq_one (show (4 : ℤ) ∣ k from dvd_trans (⟨1, by ring⟩ : (4 : ℤ) ∣ 4) hdvd)]

/-- The pointwise transformation law with TRIVIAL multiplier at level 5, for `4 ∣ k`. -/
theorem etaQuotientH_transform_p5 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (5 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 5 r) (h2 : LigozatCongr2 5 r) (hdvd : (4 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 5) (z : ℍ) :
    etaQuotientH 5 r (γ • z)
      = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH 5 r z := by
  have h := etaQuotientH_transform r hk hγ z
  have hw : etaMultiplierVal 5 r k γ = 1 := by
    have hone := etaMultiplierHom_eq_one_p5 r hk h1 h2 hdvd
    simpa [etaMultiplierHom] using congrArg (fun f => ((f ⟨γ, hγ⟩ : ℂˣ) : ℂ)) hone
  rw [h, hw, one_mul]

theorem matH23_mem7 : matH 2 3 ∈ Gamma0 7 := matH_mem_Gamma0 (by decide)

theorem matH45_mem7 : matH 4 5 ∈ Gamma0 7 := matH_mem_Gamma0 (by decide)


theorem gamma0GensP7_subset : gamma0GensP7 ⊆ (Gamma0 7 : Set SL(2, ℤ)) := by
  intro g hg
  simp only [gamma0GensP7, Set.mem_insert_iff, Set.mem_singleton_iff] at hg
  rcases hg with rfl|rfl|rfl|rfl|rfl
  · exact neg_one_mem_Gamma0 7
  · exact T_mem_Gamma0 7
  · exact matV_mem_Gamma0 7
  · exact matH23_mem7
  · exact matH45_mem7


/-- **F3.2-C3 at `p = 7`: the eta multiplier is the UNIQUE character with the listed
generator values.** -/
theorem etaMultiplierHom_eq_of_p7 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (7 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 7 r) (h2 : LigozatCongr2 7 r)
    (w : Gamma0 7 →* ℂˣ)
    (hwT : w ⟨ModularGroup.T, T_mem_Gamma0 7⟩ = 1)
    (hwV : w ⟨matV 7, matV_mem_Gamma0 7⟩ = 1)
    (hwm : w ⟨-1, neg_one_mem_Gamma0 7⟩ = (-1 : ℂˣ) ^ k)
    (hwE1 : ((w ⟨matH 2 3, matH23_mem7⟩ : ℂˣ) : ℂ) = omega3 ^ (-k))
    (hwE2 : ((w ⟨matH 4 5, matH45_mem7⟩ : ℂˣ) : ℂ) = omega3 ^ (-k)) :
    w = etaMultiplierHom r hk := by
  refine hom_ext_of_closure gamma0GensP7_subset closure_gamma0GensP7 ?_
  intro x hx
  simp only [Set.mem_preimage, gamma0GensP7, Set.mem_insert_iff, Set.mem_singleton_iff] at hx
  rcases hx with h|h|h|h|h
  · rw [show x = (⟨-1, neg_one_mem_Gamma0 7⟩ : Gamma0 7) from Subtype.ext h, hwm,
      etaMultiplierHom_neg_one]
  · rw [show x = (⟨ModularGroup.T, T_mem_Gamma0 7⟩ : Gamma0 7) from Subtype.ext h, hwT,
      etaMultiplierHom_T_eq_one r hk h1]
  · rw [show x = (⟨matV 7, matV_mem_Gamma0 7⟩ : Gamma0 7) from Subtype.ext h, hwV,
      etaMultiplierHom_V_eq_one (by norm_num) r hk h2]
  · rw [show x = (⟨matH 2 3, matH23_mem7⟩ : Gamma0 7) from Subtype.ext h]
    apply Units.ext
    rw [hwE1, coe_etaMultiplierHom]
    exact (etaMultiplierVal_matH_trace_neg_one r hk (by norm_num) matH23_mem7).symm
  · rw [show x = (⟨matH 4 5, matH45_mem7⟩ : Gamma0 7) from Subtype.ext h]
    apply Units.ext
    rw [hwE2, coe_etaMultiplierHom]
    exact (etaMultiplierVal_matH_trace_neg_one r hk (by norm_num) matH45_mem7).symm

/-- **F3.2-C3, THE HEADLINE at `p = 7`.**  Full Ligozat at level 7: any character with the
listed generator values transports the eta quotient across ALL of `Γ₀(7)`. -/
theorem ligozat_of_prime7 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (7 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 7 r) (h2 : LigozatCongr2 7 r)
    (w : Gamma0 7 →* ℂˣ)
    (hwT : w ⟨ModularGroup.T, T_mem_Gamma0 7⟩ = 1)
    (hwV : w ⟨matV 7, matV_mem_Gamma0 7⟩ = 1)
    (hwm : w ⟨-1, neg_one_mem_Gamma0 7⟩ = (-1 : ℂˣ) ^ k)
    (hwE1 : ((w ⟨matH 2 3, matH23_mem7⟩ : ℂˣ) : ℂ) = omega3 ^ (-k))
    (hwE2 : ((w ⟨matH 4 5, matH45_mem7⟩ : ℂˣ) : ℂ) = omega3 ^ (-k)) :
    ∀ (γ : Gamma0 7) (z : ℍ),
      etaQuotientH 7 r ((γ : SL(2, ℤ)) • z)
        = (w γ : ℂ) * (denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)) ^ k
          * etaQuotientH 7 r z := by
  intro γ z
  rw [etaMultiplierHom_eq_of_p7 r hk h1 h2 w hwT hwV hwm hwE1 hwE2]
  exact etaQuotientH_transform r hk γ.2 z


/-- For `6 ∣ k` every generator value is `1`, so the multiplier is trivial at level 7. -/
theorem etaMultiplierHom_eq_one_p7 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (7 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 7 r) (h2 : LigozatCongr2 7 r) (hdvd : (6 : ℤ) ∣ k) :
    etaMultiplierHom r hk = 1 := by
  have hke : Even k := by
    obtain ⟨m, rfl⟩ := hdvd; exact ⟨3 * m, by ring⟩
  refine (etaMultiplierHom_eq_of_p7 r hk h1 h2 1 rfl rfl ?_ ?_ ?_).symm
  · rw [hke.neg_one_zpow]; rfl
  · simp only [MonoidHom.one_apply, Units.val_one]
    exact (omega3_zpow_neg_eq_one (dvd_trans (⟨2, by ring⟩ : (3 : ℤ) ∣ 6) hdvd)).symm
  · simp only [MonoidHom.one_apply, Units.val_one]
    exact (omega3_zpow_neg_eq_one (dvd_trans (⟨2, by ring⟩ : (3 : ℤ) ∣ 6) hdvd)).symm

/-- The pointwise transformation law with TRIVIAL multiplier at level 7, for `6 ∣ k`. -/
theorem etaQuotientH_transform_p7 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (7 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 7 r) (h2 : LigozatCongr2 7 r) (hdvd : (6 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 7) (z : ℍ) :
    etaQuotientH 7 r (γ • z)
      = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH 7 r z := by
  have h := etaQuotientH_transform r hk hγ z
  have hw : etaMultiplierVal 7 r k γ = 1 := by
    have hone := etaMultiplierHom_eq_one_p7 r hk h1 h2 hdvd
    simpa [etaMultiplierHom] using congrArg (fun f => ((f ⟨γ, hγ⟩ : ℂˣ) : ℂ)) hone
  rw [h, hw, one_mul]

theorem matH34_mem13 : matH 3 4 ∈ Gamma0 13 := matH_mem_Gamma0 (by decide)

theorem matH55_mem13 : matH 5 5 ∈ Gamma0 13 := matH_mem_Gamma0 (by decide)

theorem matH88_mem13 : matH 8 8 ∈ Gamma0 13 := matH_mem_Gamma0 (by decide)

theorem matH910_mem13 : matH 9 10 ∈ Gamma0 13 := matH_mem_Gamma0 (by decide)


theorem gamma0GensP13_subset : gamma0GensP13 ⊆ (Gamma0 13 : Set SL(2, ℤ)) := by
  intro g hg
  simp only [gamma0GensP13, Set.mem_insert_iff, Set.mem_singleton_iff] at hg
  rcases hg with rfl|rfl|rfl|rfl|rfl|rfl|rfl
  · exact neg_one_mem_Gamma0 13
  · exact T_mem_Gamma0 13
  · exact matV_mem_Gamma0 13
  · exact matH34_mem13
  · exact matH55_mem13
  · exact matH88_mem13
  · exact matH910_mem13


/-- **F3.2-C3 at `p = 13`: the eta multiplier is the UNIQUE character with the listed
generator values.** -/
theorem etaMultiplierHom_eq_of_p13 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (13 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 13 r) (h2 : LigozatCongr2 13 r)
    (w : Gamma0 13 →* ℂˣ)
    (hwT : w ⟨ModularGroup.T, T_mem_Gamma0 13⟩ = 1)
    (hwV : w ⟨matV 13, matV_mem_Gamma0 13⟩ = 1)
    (hwm : w ⟨-1, neg_one_mem_Gamma0 13⟩ = (-1 : ℂˣ) ^ k)
    (hwE1 : ((w ⟨matH 3 4, matH34_mem13⟩ : ℂˣ) : ℂ) = omega3 ^ (-k))
    (hwE2 : ((w ⟨matH 5 5, matH55_mem13⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k))
    (hwE3 : ((w ⟨matH 8 8, matH88_mem13⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k))
    (hwE4 : ((w ⟨matH 9 10, matH910_mem13⟩ : ℂˣ) : ℂ) = omega3 ^ (-k)) :
    w = etaMultiplierHom r hk := by
  refine hom_ext_of_closure gamma0GensP13_subset closure_gamma0GensP13 ?_
  intro x hx
  simp only [Set.mem_preimage, gamma0GensP13, Set.mem_insert_iff, Set.mem_singleton_iff] at hx
  rcases hx with h|h|h|h|h|h|h
  · rw [show x = (⟨-1, neg_one_mem_Gamma0 13⟩ : Gamma0 13) from Subtype.ext h, hwm,
      etaMultiplierHom_neg_one]
  · rw [show x = (⟨ModularGroup.T, T_mem_Gamma0 13⟩ : Gamma0 13) from Subtype.ext h, hwT,
      etaMultiplierHom_T_eq_one r hk h1]
  · rw [show x = (⟨matV 13, matV_mem_Gamma0 13⟩ : Gamma0 13) from Subtype.ext h, hwV,
      etaMultiplierHom_V_eq_one (by norm_num) r hk h2]
  · rw [show x = (⟨matH 3 4, matH34_mem13⟩ : Gamma0 13) from Subtype.ext h]
    apply Units.ext
    rw [hwE1, coe_etaMultiplierHom]
    exact (etaMultiplierVal_matH_trace_neg_one r hk (by norm_num) matH34_mem13).symm
  · rw [show x = (⟨matH 5 5, matH55_mem13⟩ : Gamma0 13) from Subtype.ext h]
    apply Units.ext
    rw [hwE2, coe_etaMultiplierHom]
    exact (etaMultiplierVal_matH_trace_zero r hk rfl matH55_mem13).symm
  · rw [show x = (⟨matH 8 8, matH88_mem13⟩ : Gamma0 13) from Subtype.ext h]
    apply Units.ext
    rw [hwE3, coe_etaMultiplierHom]
    exact (etaMultiplierVal_matH_trace_zero r hk rfl matH88_mem13).symm
  · rw [show x = (⟨matH 9 10, matH910_mem13⟩ : Gamma0 13) from Subtype.ext h]
    apply Units.ext
    rw [hwE4, coe_etaMultiplierHom]
    exact (etaMultiplierVal_matH_trace_neg_one r hk (by norm_num) matH910_mem13).symm

/-- **F3.2-C3, THE HEADLINE at `p = 13`.**  Full Ligozat at level 13: any character with the
listed generator values transports the eta quotient across ALL of `Γ₀(13)`. -/
theorem ligozat_of_prime13 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (13 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 13 r) (h2 : LigozatCongr2 13 r)
    (w : Gamma0 13 →* ℂˣ)
    (hwT : w ⟨ModularGroup.T, T_mem_Gamma0 13⟩ = 1)
    (hwV : w ⟨matV 13, matV_mem_Gamma0 13⟩ = 1)
    (hwm : w ⟨-1, neg_one_mem_Gamma0 13⟩ = (-1 : ℂˣ) ^ k)
    (hwE1 : ((w ⟨matH 3 4, matH34_mem13⟩ : ℂˣ) : ℂ) = omega3 ^ (-k))
    (hwE2 : ((w ⟨matH 5 5, matH55_mem13⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k))
    (hwE3 : ((w ⟨matH 8 8, matH88_mem13⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k))
    (hwE4 : ((w ⟨matH 9 10, matH910_mem13⟩ : ℂˣ) : ℂ) = omega3 ^ (-k)) :
    ∀ (γ : Gamma0 13) (z : ℍ),
      etaQuotientH 13 r ((γ : SL(2, ℤ)) • z)
        = (w γ : ℂ) * (denom ((γ : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)) ^ k
          * etaQuotientH 13 r z := by
  intro γ z
  rw [etaMultiplierHom_eq_of_p13 r hk h1 h2 w hwT hwV hwm hwE1 hwE2 hwE3 hwE4]
  exact etaQuotientH_transform r hk γ.2 z


/-- For `12 ∣ k` every generator value is `1`, so the multiplier is trivial at level 13. -/
theorem etaMultiplierHom_eq_one_p13 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (13 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 13 r) (h2 : LigozatCongr2 13 r) (hdvd : (12 : ℤ) ∣ k) :
    etaMultiplierHom r hk = 1 := by
  have hke : Even k := by
    obtain ⟨m, rfl⟩ := hdvd; exact ⟨6 * m, by ring⟩
  refine (etaMultiplierHom_eq_of_p13 r hk h1 h2 1 rfl rfl ?_ ?_ ?_ ?_ ?_).symm
  · rw [hke.neg_one_zpow]; rfl
  · simp only [MonoidHom.one_apply, Units.val_one]
    exact (omega3_zpow_neg_eq_one (dvd_trans (⟨4, by ring⟩ : (3 : ℤ) ∣ 12) hdvd)).symm
  · simp [I_zpow_neg_eq_one (show (4 : ℤ) ∣ k from dvd_trans (⟨3, by ring⟩ : (4 : ℤ) ∣ 12) hdvd)]
  · simp [I_zpow_neg_eq_one (show (4 : ℤ) ∣ k from dvd_trans (⟨3, by ring⟩ : (4 : ℤ) ∣ 12) hdvd)]
  · simp only [MonoidHom.one_apply, Units.val_one]
    exact (omega3_zpow_neg_eq_one (dvd_trans (⟨4, by ring⟩ : (3 : ℤ) ∣ 12) hdvd)).symm

/-- The pointwise transformation law with TRIVIAL multiplier at level 13, for `12 ∣ k`. -/
theorem etaQuotientH_transform_p13 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (13 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 13 r) (h2 : LigozatCongr2 13 r) (hdvd : (12 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 13) (z : ℍ) :
    etaQuotientH 13 r (γ • z)
      = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH 13 r z := by
  have h := etaQuotientH_transform r hk hγ z
  have hw : etaMultiplierVal 13 r k γ = 1 := by
    have hone := etaMultiplierHom_eq_one_p13 r hk h1 h2 hdvd
    simpa [etaMultiplierHom] using congrArg (fun f => ((f ⟨γ, hγ⟩ : ℂˣ) : ℂ)) hone
  rw [h, hw, one_mul]


/-! ### The node's own combined statement -/

/-- The generating set attached to a genus-zero prime `p ∈ {5,7,13}`. -/
noncomputable def gamma0GensPrime (p : ℕ) : Set SL(2, ℤ) :=
  if p = 5 then gamma0GensP5 else if p = 7 then gamma0GensP7 else gamma0GensP13

/-- **F3.2-C3, the generation headline.**  For each of the three genus-zero primes with exactly
two cusps and no `Γ₀(N)`-generation by `{-I, T, V}` alone, `Γ₀(p)` is generated by `-I`, `T`, `V`
and an explicit finite set of ELLIPTIC elements. -/
theorem Gamma0_prime_generated {p : ℕ} (hp : p ∈ ({5, 7, 13} : Finset ℕ)) :
    Subgroup.closure (gamma0GensPrime p) = Gamma0 p := by
  fin_cases hp
  · rw [show gamma0GensPrime 5 = gamma0GensP5 by norm_num [gamma0GensPrime]]
    exact closure_gamma0GensP5
  · rw [show gamma0GensPrime 7 = gamma0GensP7 by norm_num [gamma0GensPrime]]
    exact closure_gamma0GensP7
  · rw [show gamma0GensPrime 13 = gamma0GensP13 by norm_num [gamma0GensPrime]]
    exact closure_gamma0GensP13

/-- The generating set in the node's `{-1, T, V} ∪ elliptic` shape. -/
theorem gamma0GensP5_eq_union :
    gamma0GensP5
      = ({(-1 : SL(2, ℤ)), ModularGroup.T, matV 5} : Set SL(2, ℤ)) ∪ {matH 2 2, matH 3 3} := by
  ext g; simp only [gamma0GensP5, Set.mem_insert_iff, Set.mem_singleton_iff, Set.mem_union]
  tauto

theorem gamma0GensP7_eq_union :
    gamma0GensP7
      = ({(-1 : SL(2, ℤ)), ModularGroup.T, matV 7} : Set SL(2, ℤ)) ∪ {matH 2 3, matH 4 5} := by
  ext g; simp only [gamma0GensP7, Set.mem_insert_iff, Set.mem_singleton_iff, Set.mem_union]
  tauto

theorem gamma0GensP13_eq_union :
    gamma0GensP13
      = ({(-1 : SL(2, ℤ)), ModularGroup.T, matV 13} : Set SL(2, ℤ))
        ∪ {matH 3 4, matH 5 5, matH 8 8, matH 9 10} := by
  ext g; simp only [gamma0GensP13, Set.mem_insert_iff, Set.mem_singleton_iff, Set.mem_union]
  tauto

/-! ### LL-1 guards -/

/-- The trace of `matH j j'` is `j - j'`. -/
theorem trace_matH (j j' : ℤ) :
    (matH j j' : Matrix (Fin 2) (Fin 2) ℤ) 0 0 + (matH j j' : Matrix (Fin 2) (Fin 2) ℤ) 1 1
      = j - j' := by
  simp [matH]
  ring

/-- **GUARD 1a.**  The Schreier/coset route reproves `F3.2-B1` at `N = 2` — a route that shares
no step with B1's Euclidean descent. -/
theorem closure_gamma0Gens_two_schreier : Subgroup.closure (gamma0Gens 2) = Gamma0 2 := by
  have hneg := neg_one_mem_closure_gens 2
  have hT := T_mem_closure_gens 2
  have hV := matV_mem_closure_gens 2
  refine Gamma0_eq_of_schreier (by norm_num) (closure_gamma0Gens_le 2) hneg hT hV ?_
  intro j hj1 hj
  interval_cases j
  · refine ⟨1, by norm_num, ?_⟩
    rw [show matH ((1 : ℕ) : ℤ) ((1 : ℕ) : ℤ) = ModularGroup.T⁻¹ * (matV 2)⁻¹ by decide]
    exact Subgroup.mul_mem _ (Subgroup.inv_mem _ hT) (Subgroup.inv_mem _ hV)

/-- **GUARD 1b.**  The same at `N = 3`. -/
theorem closure_gamma0Gens_three_schreier : Subgroup.closure (gamma0Gens 3) = Gamma0 3 := by
  have hneg := neg_one_mem_closure_gens 3
  have hT := T_mem_closure_gens 3
  have hV := matV_mem_closure_gens 3
  refine Gamma0_eq_of_schreier (by norm_num) (closure_gamma0Gens_le 3) hneg hT hV ?_
  intro j hj1 hj
  interval_cases j
  · refine ⟨2, by norm_num, ?_⟩
    rw [show matH ((1 : ℕ) : ℤ) ((2 : ℕ) : ℤ) = ModularGroup.T⁻¹ * (matV 3)⁻¹ by decide]
    exact Subgroup.mul_mem _ (Subgroup.inv_mem _ hT) (Subgroup.inv_mem _ hV)
  · refine ⟨1, by norm_num, ?_⟩
    rw [show matH ((2 : ℕ) : ℤ) ((1 : ℕ) : ℤ)
        = (-1 : SL(2, ℤ)) * (matV 3 * ModularGroup.T) by decide]
    exact Subgroup.mul_mem _ hneg (Subgroup.mul_mem _ hV hT)

/-- **GUARD 1, the assertion.**  Two routes that share no step deliver the same proposition. -/
theorem gamma0Gens_three_two_routes :
    (Subgroup.closure (gamma0Gens 3) = Gamma0 3) ∧ (Subgroup.closure (gamma0Gens 3) = Gamma0 3) :=
  ⟨closure_gamma0Gens_three_schreier, closure_gamma0Gens_eq (by norm_num) (by norm_num)⟩

/-- **GUARD 2.**  The closure at `p = 5` is a PROPER subgroup of `SL(2,ℤ)`: `S` is not in it.
The theorem has not silently degenerated into `closure = ⊤`. -/
theorem S_not_mem_closure_gensP5 : ModularGroup.S ∉ Subgroup.closure gamma0GensP5 := by
  intro h
  rw [closure_gamma0GensP5, Gamma0_mem] at h
  rw [show ((ModularGroup.S : SL(2, ℤ)) 1 0) = 1 by decide] at h
  exact absurd h (by decide)

theorem closure_gamma0GensP5_ne_top : Subgroup.closure gamma0GensP5 ≠ ⊤ := by
  intro h
  exact S_not_mem_closure_gensP5 (h ▸ Subgroup.mem_top _)

/-- A concrete element of `Γ₀(5)` — not a generator — is a word in the generators. -/
def testGamma0Five : SL(2, ℤ) := ⟨!![6, 1; 5, 1], by decide⟩

theorem testGamma0Five_mem_closure : testGamma0Five ∈ Subgroup.closure gamma0GensP5 := by
  rw [closure_gamma0GensP5, Gamma0_mem]
  decide

/-! #### GUARD 3, the honest negative: `4 ∣ k` is NOT implied by Ligozat's congruences -/

/-- `r₁ = 5`, `r₅ = -1` at level `5`: `η(z)⁵ η(5z)⁻¹`, weight `k = 2`. -/
def ligozatFiveExp : EtaExp := fun δ => if δ = 1 then 5 else if δ = 5 then -1 else 0

theorem ligozatFiveExp_sum : ∑ δ ∈ (5 : ℕ).divisors, ligozatFiveExp δ = 2 * 2 := by decide

theorem ligozatFiveExp_congr1 : LigozatCongr1 5 ligozatFiveExp := by
  have h : ∑ δ ∈ (5 : ℕ).divisors, (δ : ℤ) * ligozatFiveExp δ = 0 := by decide
  exact ⟨0, by rw [h]; ring⟩

theorem ligozatFiveExp_congr2 : LigozatCongr2 5 ligozatFiveExp := by
  have h : ∑ δ ∈ (5 : ℕ).divisors, ((5 / δ : ℕ) : ℤ) * ligozatFiveExp δ = 24 := by decide
  exact ⟨1, by rw [h]; ring⟩

/-- The multiplier of this example at the elliptic generator is `-1`, not `1`. -/
theorem etaMultiplierVal_ligozatFive_matH22 :
    etaMultiplierVal 5 ligozatFiveExp 2 (matH 2 2) = -1 := by
  rw [etaMultiplierVal_matH_diag ligozatFiveExp ligozatFiveExp_sum matH22_mem5]
  rw [show (-(2 : ℤ)) = -(2 : ℤ) from rfl, _root_.zpow_neg,
    show (Complex.I ^ (2 : ℤ)) = -1 by
      rw [show (2 : ℤ) = ((2 : ℕ) : ℤ) by norm_num, zpow_natCast, Complex.I_sq]]
  norm_num

/-- **GUARD 3.**  Level `5`, `r = (5, -1)`, `k = 2`: Ligozat's congruences (i) and (ii) both
hold, `k` is EVEN, generation is a theorem — and the transformation law with TRIVIAL multiplier
is FALSE at the elliptic generator.  So the divisibility hypothesis `4 ∣ k` of
`etaQuotientH_transform_p5` is load-bearing, not defensive: `Even k` is not enough at level 5,
unlike at levels `N ≤ 4`. -/
theorem not_multiplier_trivial_p5 :
    ¬ ∀ z : ℍ, etaQuotientH 5 ligozatFiveExp (matH 2 2 • z)
        = (denom ((matH 2 2 : SL(2, ℤ)) : GL (Fin 2) ℝ) (z : ℂ)) ^ (2 : ℤ)
          * etaQuotientH 5 ligozatFiveExp z := by
  intro h
  have ht := etaQuotientH_transform ligozatFiveExp ligozatFiveExp_sum matH22_mem5
    UpperHalfPlane.I
  rw [h UpperHalfPlane.I, etaMultiplierVal_ligozatFive_matH22] at ht
  have hD : (denom ((matH 2 2 : SL(2, ℤ)) : GL (Fin 2) ℝ) ((UpperHalfPlane.I : ℍ) : ℂ)) ≠ 0 :=
    UpperHalfPlane.denom_ne_zero _ _
  have hf := etaQuotientH_ne_zero 5 ligozatFiveExp UpperHalfPlane.I
  exact mul_ne_zero (zpow_ne_zero _ hD) hf (by linear_combination ht / 2)


/-- **GUARD 4.**  Every generator listed beyond `{-I, T, V}` is genuinely ELLIPTIC: its trace is
`0` (order two in `PSL₂(ℤ)`) or `-1` (order three).  A hyperbolic or parabolic entry here would
have no fixed point in `ℍ` and `F3.2-A9` would not apply to it. -/
theorem elliptic_traces :
    (matH 2 2 : Matrix (Fin 2) (Fin 2) ℤ).trace = 0 ∧
    (matH 3 3 : Matrix (Fin 2) (Fin 2) ℤ).trace = 0 ∧
    (matH 2 3 : Matrix (Fin 2) (Fin 2) ℤ).trace = -1 ∧
    (matH 4 5 : Matrix (Fin 2) (Fin 2) ℤ).trace = -1 ∧
    (matH 3 4 : Matrix (Fin 2) (Fin 2) ℤ).trace = -1 ∧
    (matH 5 5 : Matrix (Fin 2) (Fin 2) ℤ).trace = 0 ∧
    (matH 8 8 : Matrix (Fin 2) (Fin 2) ℤ).trace = 0 ∧
    (matH 9 10 : Matrix (Fin 2) (Fin 2) ℤ).trace = -1 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> decide

/-- **GUARD 5, non-vacuity at `p = 5`.**  The five generator-value hypotheses of
`ligozat_of_prime5` are simultaneously satisfiable: `etaMultiplierHom` itself satisfies them,
under Ligozat's two congruences.  Without this the headline could be vacuously true. -/
theorem etaMultiplierHom_satisfies_p5 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (5 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 5 r) (h2 : LigozatCongr2 5 r) :
    etaMultiplierHom r hk ⟨ModularGroup.T, T_mem_Gamma0 5⟩ = 1 ∧
      etaMultiplierHom r hk ⟨matV 5, matV_mem_Gamma0 5⟩ = 1 ∧
      etaMultiplierHom r hk ⟨-1, neg_one_mem_Gamma0 5⟩ = (-1 : ℂˣ) ^ k ∧
      ((etaMultiplierHom r hk ⟨matH 2 2, matH22_mem5⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k) ∧
      ((etaMultiplierHom r hk ⟨matH 3 3, matH33_mem5⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k) :=
  ⟨etaMultiplierHom_T_eq_one r hk h1, etaMultiplierHom_V_eq_one (by norm_num) r hk h2,
    etaMultiplierHom_neg_one r hk,
    by rw [coe_etaMultiplierHom]; exact etaMultiplierVal_matH_trace_zero r hk rfl matH22_mem5,
    by rw [coe_etaMultiplierHom]; exact etaMultiplierVal_matH_trace_zero r hk rfl matH33_mem5⟩

/-- **GUARD 5, non-vacuity at `p = 13`** — the level carrying BOTH an order-two and an
order-three elliptic generator. -/
theorem etaMultiplierHom_satisfies_p13 (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ (13 : ℕ).divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 13 r) (h2 : LigozatCongr2 13 r) :
    etaMultiplierHom r hk ⟨ModularGroup.T, T_mem_Gamma0 13⟩ = 1 ∧
      etaMultiplierHom r hk ⟨matV 13, matV_mem_Gamma0 13⟩ = 1 ∧
      etaMultiplierHom r hk ⟨-1, neg_one_mem_Gamma0 13⟩ = (-1 : ℂˣ) ^ k ∧
      ((etaMultiplierHom r hk ⟨matH 3 4, matH34_mem13⟩ : ℂˣ) : ℂ) = omega3 ^ (-k) ∧
      ((etaMultiplierHom r hk ⟨matH 5 5, matH55_mem13⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k) ∧
      ((etaMultiplierHom r hk ⟨matH 8 8, matH88_mem13⟩ : ℂˣ) : ℂ) = Complex.I ^ (-k) ∧
      ((etaMultiplierHom r hk ⟨matH 9 10, matH910_mem13⟩ : ℂˣ) : ℂ) = omega3 ^ (-k) :=
  ⟨etaMultiplierHom_T_eq_one r hk h1, etaMultiplierHom_V_eq_one (by norm_num) r hk h2,
    etaMultiplierHom_neg_one r hk,
    by rw [coe_etaMultiplierHom]
       exact etaMultiplierVal_matH_trace_neg_one r hk (by norm_num) matH34_mem13,
    by rw [coe_etaMultiplierHom]; exact etaMultiplierVal_matH_trace_zero r hk rfl matH55_mem13,
    by rw [coe_etaMultiplierHom]; exact etaMultiplierVal_matH_trace_zero r hk rfl matH88_mem13,
    by rw [coe_etaMultiplierHom]
       exact etaMultiplierVal_matH_trace_neg_one r hk (by norm_num) matH910_mem13⟩


/-- **F3.2-C3, the node's single `ligozat_of_prime`.**  A uniform corollary over the three
genus-zero primes: `12 ∣ k` is divisible by each of `4` (`p = 5`), `6` (`p = 7`) and `12`
(`p = 13`), so under Ligozat's two congruences the eta quotient transforms with TRIVIAL
multiplier on all of `Γ₀(p)`.  The per-prime statements `etaQuotientH_transform_p5/7/13` carry
the sharp divisibility threshold for their own level; this one trades sharpness for uniformity.

The character-valued statements, whose generator lists have different lengths at the three
primes, are `ligozat_of_prime5`, `ligozat_of_prime7` and `ligozat_of_prime13`. -/
theorem ligozat_of_prime {p : ℕ} (hp : p ∈ ({5, 7, 13} : Finset ℕ)) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ p.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 p r) (h2 : LigozatCongr2 p r) (hdvd : (12 : ℤ) ∣ k)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 p) (z : ℍ) :
    etaQuotientH p r (γ • z)
      = (denom (γ : GL (Fin 2) ℝ) (z : ℂ)) ^ k * etaQuotientH p r z := by
  fin_cases hp
  · exact etaQuotientH_transform_p5 r hk h1 h2
      (dvd_trans (⟨3, by ring⟩ : (4 : ℤ) ∣ 12) hdvd) hγ z
  · exact etaQuotientH_transform_p7 r hk h1 h2
      (dvd_trans (⟨2, by ring⟩ : (6 : ℤ) ∣ 12) hdvd) hγ z
  · exact etaQuotientH_transform_p13 r hk h1 h2 hdvd hγ z

end SocrateAI.ModularForms
