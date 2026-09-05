/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team & Mathesis Framework

TIER A — Formal Tier Calculus and Epistemic Ledger Soundness.
Imported from SocrateAI-Mathesis / TierCalculus.lean.

This module formalizes the 5-tier epistemic lattice:
  Tier.X (Exploratory, rank 0)
  Tier.C (Conjecture, rank 1)
  Tier.L (Literature, rank 2)
  Tier.B (Exact finite arithmetic, rank 3)
  Tier.A (Kernel-verified theorem, rank 4)

It proves that in any sound ledger, transitive dependencies cannot outrank
their supporting foundations (e.g. a Tier A theorem cannot secretly rely
on a Tier L or Tier C assumption without explicit parameterization).
-/

namespace SocrateAI.Core.TierCalculus

/-! ## 1. The Epistemic Tier Lattice -/

/-- Citation strength and verification tier. -/
inductive Tier where
  | X  -- Exploratory: floats, sampling, unverified heuristic
  | C  -- Conjecture, analogy, unverified reduction
  | L  -- Peer-reviewed literature, cited to a quoted theorem
  | B  -- Finite statement decided in exact arithmetic with negative control
  | A  -- Kernel-verified: compiles, no sorry, declared axiom footprint
deriving DecidableEq, Repr

namespace Tier

/-- Numeric rank from X (0) to A (4). -/
def rank : Tier → Nat
  | X => 0
  | C => 1
  | L => 2
  | B => 3
  | A => 4

/-- Citation-strength partial order. -/
protected def le (s t : Tier) : Prop := s.rank ≤ t.rank

instance : LE Tier := ⟨Tier.le⟩

instance (s t : Tier) : Decidable (s ≤ t) :=
  inferInstanceAs (Decidable (s.rank ≤ t.rank))

protected theorem le_refl (s : Tier) : s ≤ s := Nat.le_refl _

protected theorem le_trans {s t u : Tier} (h₁ : s ≤ t) (h₂ : t ≤ u) : s ≤ u :=
  Nat.le_trans h₁ h₂

/-- Tier A is the top of the lattice. -/
theorem le_A (s : Tier) : s ≤ Tier.A := by
  cases s <;> decide

/-- Tier X is the bottom of the lattice. -/
theorem X_le (s : Tier) : Tier.X ≤ s := by
  cases s <;> decide

/-- Rank 4 identifies Tier A uniquely. -/
theorem eq_A_of_A_le {s : Tier} (h : Tier.A ≤ s) : s = Tier.A := by
  cases s <;> first | rfl | exact absurd h (by decide)

/-- Antisymmetry of tier ordering. -/
protected theorem le_antisymm {s t : Tier} (h₁ : s ≤ t) (h₂ : t ≤ s) : s = t := by
  cases s <;> cases t <;> first | rfl | exact absurd h₁ (by decide) | exact absurd h₂ (by decide)

end Tier

/-! ## 2. Ledgers and Transitive Dependencies -/

/-- A single ledger row: tier classification and direct support dependencies. -/
structure Claim (ι : Type) where
  tier : Tier
  supports : List ι
deriving Repr

/-- A ledger maps claim identifiers to claims. -/
def Ledger (ι : Type) := ι → Claim ι

/-- Soundness condition: no claim is filed above any claim it directly cites. -/
def Sound {ι : Type} (L : Ledger ι) : Prop :=
  ∀ a b, b ∈ (L a).supports → (L a).tier ≤ (L b).tier

/-- Transitive dependency relation. -/
inductive Depends {ι : Type} (L : Ledger ι) : ι → ι → Prop where
  | direct {a b} : b ∈ (L a).supports → Depends L a b
  | step {a b c} : b ∈ (L a).supports → Depends L b c → Depends L a c

namespace Depends

/-- Transitivity of dependency chains. -/
theorem trans {ι : Type} {L : Ledger ι} {a b c : ι}
    (hab : Depends L a b) (hbc : Depends L b c) : Depends L a c := by
  induction hab with
  | direct h => exact Depends.step h hbc
  | step h _ ih => exact Depends.step h (ih hbc)

end Depends

/-! ## 3. Core Theorems -/

/-- Transitive tier monotonicity: In a sound ledger, a claim never outranks
    anything in its transitive support set. -/
theorem tier_le_of_depends {ι : Type} {L : Ledger ι} (hL : Sound L) :
    ∀ {a b : ι}, Depends L a b → (L a).tier ≤ (L b).tier := by
  intro a b h
  induction h with
  | direct hmem => exact hL _ _ hmem
  | step hmem _ ih => exact Tier.le_trans (hL _ _ hmem) ih

/-- Theorem: A kernel claim (Tier A) can only depend transitively on other Tier A claims. -/
theorem no_kernel_claim_rests_on_weaker {ι : Type} {L : Ledger ι} (hL : Sound L)
    {a b : ι} (ha : (L a).tier = Tier.A) (hab : Depends L a b) :
    (L b).tier = Tier.A :=
  Tier.eq_A_of_A_le (ha ▸ tier_le_of_depends hL hab)

/-- Contrapositive: If any dependency is below Tier A, the citing claim cannot be Tier A. -/
theorem not_A_of_weak_support {ι : Type} {L : Ledger ι} (hL : Sound L)
    {a b : ι} (hab : Depends L a b) (hb : (L b).tier ≠ Tier.A) :
    (L a).tier ≠ Tier.A :=
  fun ha => hb (no_kernel_claim_rests_on_weaker hL ha hab)

end SocrateAI.Core.TierCalculus
