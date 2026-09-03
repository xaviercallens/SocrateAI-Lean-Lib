# SocrateAI-Lean-Lib 🔬📐

> **A Formal Lean 4 Foundation & Tooling Ecosystem for Scientific Papers, Theories, and Empirical Research.**

[![Lean 4](https://img.shields.io/badge/Lean-4.33.1-blue.svg)](https://lean-lang.org/)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()

---

## 🌟 Vision: Making Lean 4 the Foundation of Science

Modern scientific literature faces reproducibility challenges: implicit assumptions, unstated regimes of validity, unit/dimensional mistakes, and gaps between theoretical models and empirical evidence.

**SocrateAI-Lean-Lib** (`Socrate`) establishes a rigorous, machine-checked bridge between scientific inquiry and Lean 4's interactive theorem proving environment. It equips researchers, theorists, and AI agents with:

1. **Epistemological Ontologies**: First-class representations of scientific papers, claims, empirical findings, theoretical postulates, approximations, and Popperian falsification criteria.
2. **Type-Safe Dimensional Analysis**: Compile-time verification of SI physical dimensions ($L, M, T, I, \Theta, N, J$) and units, eliminating unphysical equations before proof attempts.
3. **Theoretical Modeling Framework**: Discrete and continuous dynamical systems, state trajectories, equilibria, and invariant conservation laws.
4. **Empirical & Statistical Framework**: Measurements with quantified uncertainty ($\pm \sigma$), automated Gaussian error propagation, and statistical hypothesis testing structures.
5. **Metaprogramming & Scientific DSL**: Custom attributes (`@[paper_claim]`, `@[falsifiable]`, `@[empirical_assumption]`) and interactive commands (`#inspect_claim`).
6. **CLI Tooling (`lake exe socrate`)**: Command-line workflows to scaffold new paper formalizations, audit claims, and inspect literature repositories.

---

## 🏛️ Project Architecture

```
SocrateAI-Lean-Lib/
├── lakefile.lean                  # Lake package, Socrate library, and socrate executable
├── lean-toolchain                 # Pinned to leanprover/lean4:v4.33.1
├── Socrate.lean                   # Root library interface
├── Socrate/
│   ├── Main.lean                  # CLI utility implementation
│   ├── Core/
│   │   ├── Ontology.lean          # Scientific domains, claim types, evidence levels, falsification
│   │   └── Paper.lean             # Paper metadata, claim registry, and provenance manifests
│   ├── Dimensions/
│   │   ├── Base.lean              # 7 SI base dimensions vector arithmetic & Quantity types
│   │   └── Units.lean             # SI units, physical constants, dimensional consistency theorems
│   ├── Theory/
│   │   ├── DynamicalSystem.lean   # Trajectories, equilibria, and invariant conservation theorems
│   │   └── Approximation.lean     # Perturbation theory, asymptotic bounds, and linearization
│   ├── Empirical/
│   │   ├── Measurement.lean       # Uncertain measurements (v ± σ) & Gaussian error propagation
│   │   └── HypothesisTesting.lean # H₀, H₁, significance level α, power, and replicability
│   ├── Meta/
│   │   ├── Attributes.lean        # Attributes: @[paper_claim], @[falsifiable], @[empirical_assumption]
│   │   └── Commands.lean          # Command: #inspect_claim
│   └── Examples/
│       ├── ClassicalMechanics.lean # Newton (1687): Second Law, Hooke's Law & Energy dimensional proofs
│       ├── InformationTheory.lean  # Shannon (1948): Entropy, Mutual Info, and independence theorem
│       ├── EpidemiologySIR.lean    # Kermack & McKendrick (1927): SIR Model & Population conservation
│       └── MLTheoryPAC.lean        # Valiant (1984): PAC Generalization & Sample Complexity bounds
└── README.md
```

---

## 🚀 Quickstart

### Prerequisites
- [Elan](https://github.com/leanprover/elan) (Lean version manager)
- Lean 4 toolchain `leanprover/lean4:v4.33.1` (automatically resolved via `lean-toolchain`)

### 1. Build the Entire Library and Tooling

```bash
lake build
```

This compiles the `Socrate` core library and produces the native executable binary in `.lake/build/bin/socrate`.

### 2. Run the Socrate CLI Utility

```bash
# View system information and supported scientific domains
lake exe socrate info

# List formalized scientific papers in the project
lake exe socrate list-papers

# Inspect a specific formalized scientific paper
lake exe socrate show-paper newton1687
lake exe socrate show-paper kermack1927
lake exe socrate show-paper shannon1948
lake exe socrate show-paper valiant1984

# Scaffold a new scientific paper formalization template
lake exe socrate scaffold MyNewPaper
```

---

## 🧪 Core Concepts & Examples

### 1. Compile-Time Type-Safe Dimensional Analysis

In `Socrate.Dimensions`, physical quantities carry their SI dimensions in their Lean types. Equations that do not balance dimensionally fail to compile:

```lean
import Socrate.Dimensions.Units

open Socrate.Dimensions
open Socrate.Dimensions.SI

-- Force is defined with Mass and Acceleration:
def force (m : Mass Float) (a : Acceleration Float) : Force Float :=
  ⟨m.val * a.val⟩

-- Theorem: Multiplying Mass by Acceleration strictly equals Force dimensionally
theorem newton_valid : dimMul dimMass dimAcceleration = dimForce := by
  rfl

-- Theorem: Spring constant [M·T⁻²] multiplied by displacement [L] yields Force [M·L·T⁻²]
theorem hooke_valid : dimMul dimSpringConstant dimLength = dimForce := by
  rfl
```

### 2. Verified Conservation Laws in Dynamical Systems

In `Socrate.Theory`, physical and biological invariants are verified across state trajectories using Lean's induction tactics:

```lean
import Socrate.Theory.DynamicalSystem

open Socrate.Theory

-- For any discrete dynamical system with a conserved observable Q:
-- Q(s_{t+1}) = Q(s_t) implies Q(s_t) = Q(s_0) for all t ∈ ℕ:
#check DiscreteDynamicalSystem.conserved_along_trajectory
```

In `Socrate.Examples.EpidemiologySIR`, Kermack & McKendrick's compartmental SIR model is proven to conserve total population:
```lean
theorem sir_step_conserves_population (trans : SIRTransition) (s : SIRState) :
    totalPopulation (sirStep trans s) = totalPopulation s := by
  dsimp [totalPopulation, sirStep]
  omega
```

### 3. Empirical Evidence with Error Propagation

In `Socrate.Empirical`, experimental measurements track uncertainty and support automated Gaussian error propagation:

```lean
import Socrate.Empirical.Measurement

open Socrate.Empirical
open Socrate.Dimensions

-- Measure two independent lengths:
def l1 : Measurement dimLength := { value := 10.0, uncertainty := 0.2 }
def l2 : Measurement dimLength := { value := 5.0,  uncertainty := 0.1 }

-- Combined measurement with propagated uncertainty: σ = √(0.2² + 0.1²) ≈ 0.2236
def totalLength := l1.add l2

-- Check consistency with theoretical prediction within 2σ bounds:
#eval totalLength.isConsistentWithTheory 15.1 (k := 2.0)
```

### 4. Scientific Metaprogramming & Inspection

Annotate declarations with their epistemological status:

```lean
import Socrate.Meta.Attributes
import Socrate.Meta.Commands

namespace MyPaper

open Socrate.Meta

@[empirical_assumption]
def flatSpacetimeAssumption : Prop := True

@[paper_claim]
theorem energy_conservation : True := by trivial

#inspect_claim energy_conservation

end MyPaper
```

Output:
```
═══════════════════════════════════════════════════════
🔬 Scientific Declaration: MyPaper.energy_conservation [CLAIM] 
Type: True
Is Paper Claim: true
Is Empirical Assumption: false
═══════════════════════════════════════════════════════
```

---

## 📚 Exemplar Formalized Scientific Literature

| ID | Title | Authors | Year | Domain | Key Formalized Result |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `newton1687` | *Philosophiae Naturalis Principia Mathematica* | I. Newton | 1687 | Physics | Newton's 2nd Law, Hooke's Law & Kinetic/Potential Energy Dimensional Invariants |
| `shannon1948` | *A Mathematical Theory of Communication* | C. Shannon | 1948 | Computer Science | Discrete Shannon Entropy, Mutual Information, Independence Vanishing Theorem |
| `kermack1927` | *A Contribution to the Mathematical Theory of Epidemics* | W. Kermack, A. McKendrick | 1927 | Medicine & Biology | SIR Model, Population Invariant Conservation ($S+I+R=N$), $R_0$ Threshold |
| `valiant1984` | *A Theory of the Learnable* | L. Valiant | 1984 | AI & ML Theory | PAC Learning Model, Sample Complexity Distributivity Bound |

---

## 🔌 Optional Mathlib Integration

The core library is designed to be lightweight and compile in **< 5 seconds** with zero external dependencies.

To enable **Mathlib** for advanced measure theory, manifold topology, or functional analysis:
1. Open `lakefile.lean`
2. Uncomment:
   ```lean
   require "leanprover-community" / "mathlib" @ git "v4.33.1"
   ```
3. Run:
   ```bash
   lake update && lake exe cache get && lake build
   ```

---

## 📄 License

Licensed under the Apache License, Version 2.0.
