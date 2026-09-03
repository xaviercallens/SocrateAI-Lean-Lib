/-
Copyright (c) 2026 SocrateAI Contributors. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: SocrateAI Team
-/

namespace SocrateAI.Core.Logic

/-- Law of Excluded Middle (LEM) principle: for any proposition $P$, either $P$ or $\neg P$ holds. -/
theorem excluded_middle (P : Prop) : P ∨ ¬P :=
  Classical.em P

/-- Double Negation Elimination: from $\neg\neg P$, infer $P$. -/
theorem double_negation_elimination (P : Prop) (h : ¬¬P) : P :=
  Classical.byContradiction fun hn => h hn

/-- Scientific Modus Tollens (Popperian Falsification):
    If theory $T$ predicts observable consequence $P$, and observation yields $\neg P$,
    then theory $T$ is falsified ($\neg T$). -/
theorem modus_tollens (Theory Prediction : Prop)
    (hPredict : Theory → Prediction) (hFalse : ¬Prediction) : ¬Theory :=
  fun hT => hFalse (hPredict hT)

/-- Consistency of a scientific theory: a theory cannot prove both $P$ and $\neg P$. -/
def isConsistent (Theory : Prop) : Prop :=
  ∀ (P : Prop), ¬((Theory → P) ∧ (Theory → ¬P))

/-- Theorem: A sound non-vacuous theory ($T$ is true) is logically consistent. -/
theorem true_theory_is_consistent (Theory : Prop) (hT : Theory) : isConsistent Theory := by
  intro P ⟨hP, hNotP⟩
  have p : P := hP hT
  have notP : ¬P := hNotP hT
  exact notP p

end SocrateAI.Core.Logic
