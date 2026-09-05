# 🌐 External Lean 4 Repositories, Checkers & Tool Ecosystem

This catalog maps external GitHub Lean 4 repositories, official checkers, and AI proving bridges
leveraged by **SocrateAI-Lean-Lib**.

---

## 🏛️ Repository & Checker Index

| Project | Category | Repository | Role in SocrateAI |
|---|---|---|---|
| **`mathlib4`** | `pure_math` | [https://github.com/leanprover-community/mathlib4](https://github.com/leanprover-community/mathlib4) | Canonical Lean 4 mathematical library (algebra, analysis, topology, geometry). |
| **`physlib`** | `physics_ontology` | [https://github.com/leanprover-community/physlib](https://github.com/leanprover-community/physlib) | Official community formalization of theoretical physics in Lean 4. |
| **`TNLean`** | `quantum_information` | [https://github.com/leanprover-community/TNLean](https://github.com/leanprover-community/TNLean) | Tensor Networks, Matrix Product States (MPS), and entanglement bounds. |
| **`Arithmon`** | `k3_string_geometry` | [https://github.com/dwrensha/arithmon](https://github.com/dwrensha/arithmon) | Arithmetic geometry, K3 surface lattices, and Picard-Fuchs differential systems. |
| **`lean4checker`** | `verification_checker` | [https://github.com/leanprover/lean4checker](https://github.com/leanprover/lean4checker) | Official Lean 4 community kernel checker for compiled .olean binaries. |
| **`lean-repl`** | `ai_agent_bridge` | [https://github.com/leanprover-community/repl](https://github.com/leanprover-community/repl) | REPL server for communication between AI agents (LEAP, DeepSeek-Prover, Leanstral) and Lean 4. |
| **`leanblueprint`** | `blueprint_generator` | [https://github.com/PatrickMassot/leanblueprint](https://github.com/PatrickMassot/leanblueprint) | Web blueprint generation tool used by Terence Tao (PFR, LTE, Sphere Eversion). |

---

## 🔍 Deep Dive: Checkers & Neuro-Symbolic Agent Bridges

### 1. `lean4checker` (Official Kernel Verifier)
- **Source**: `https://github.com/leanprover/lean4checker`
- **Purpose**: Reads all emitted `.olean` files and processes their environment using a fresh, minimal Lean 4 kernel.
- **Why we use it**: Guarantees that no tactic, meta-program, or macro corrupted the proof environment.
- **Runner in SocrateAI**: `./scripts/check_olean_kernel.sh`

### 2. `lean-repl` (AI Agent Prover Interface)
- **Source**: `https://github.com/leanprover-community/repl`
- **Purpose**: Lightweight JSON-RPC interface for Lean 4. Used by autonomous provers (LEAP, DeepSeek-Prover, Leanstral).
- **Protocol**: Receives Lean commands via stdin (JSON format) and returns AST, tactic states, and errors without restarting the compiler.

### 3. `leanblueprint` (Tao Blueprint Web Visualizer)
- **Source**: `https://github.com/PatrickMassot/leanblueprint`
- **Purpose**: Generates interactive HTML blueprints with clickable lemma graphs and completion status.
- **SocrateAI Implementation**: `scripts/quickwin_blueprint.py` generates native Mermaid DAGs (`docs/BLUEPRINT_DAG.md`) while adhering to Massot's blueprint format.

---

## 📚 Mathematical & Physical Knowledge Ontologies

### 1. `physlib` (Theoretical Physics)
- Bridges classical Lagrangian mechanics and quantum operators.
- Recommended approach: Borrow type definitions and conventions into `SocrateAI.Core` without pulling full dependency trees.

### 2. `TNLean` (Tensor Networks & Error Correction)
- Formal tensor networks and Ryu-Takayanagi boundary-bulk bounds.
- Connects directly to `SocrateAI.Quantum.GolayCode` and `SocrateAI.Quantum.GolayM24`.

### 3. `Arithmon` (K3 & Calabi-Yau Arithmetic Geometry)
- K3 lattice structure and Picard-Fuchs systems.
- Informs `SocrateAI.K3` and `SocrateAI.StringTheory.K3xT2`.

---

## 🛡️ Architectural Standard: Why We Avoid Direct Monolithic Mathlib Imports
1. **Compilation Speed**: Mathlib requires downloading ~3GB of cache and minutes of compile time. SocrateAI builds in **under 30 seconds**.
2. **Self-Contained Scientific Proofs**: Our core library relies solely on pure Lean 4 core, ensuring extreme portability and zero upstream breakage.
3. **Modular Extraction**: Any theorem from Mathlib needed for scientific formalization is extracted as a clean, minimal lemma in `SocrateAI.Core`.
