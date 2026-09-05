---
name: socrateai-lean-formalization
description: |
  Comprehensive guide and standard operating procedure for writing, verifying, and extracting formal Lean 4 proofs for scientific and theoretical physics research in the SocrateAI-Lean-Lib ecosystem. Essential for any task involving String Theory, Pregeometry, K3 Surfaces, or Quantum invariants.
---

# 🧠 SocrateAI-Lean-Lib — Agent Guide for Scientific Lean 4 Formalization

**Purpose**: This skill provides the canonical reference for any Antigravity session that needs to produce, verify, or extend **formally certified Lean 4 proofs** for scientific research papers within the `SocrateAI-Lean-Lib` workspace.

**Before writing any Lean code in this repository, you MUST follow these guidelines.**

---

## 1. Philosophy & Non-Negotiable Rules

This library follows the **Terence Tao Blueprint Philosophy** for AI-assisted formal mathematics:

### Core Principles

| Principle | What It Means For You |
|---|---|
| **No black-box proofs** | Every theorem must be human-readable. If your proof is longer than ~15 lines, break it into smaller lemmas. |
| **Axiom quarantine** | Any physical heuristic that is not mathematically proven (path integral convergence, Calabi-Yau metric existence, Swampland conjectures) must be declared as `axiom` or `variable`, **never** as `theorem`. |
| **Constructive invariants first** | Prioritize numerical identities provable by `rfl`, `decide`, `omega`, or `norm_num`. These are the "quick wins" — they compile instantly and give immediate confidence. |
| **No Mathlib dependency** | This library uses **only** the Lean 4 core prelude. Do not import Mathlib. This is intentional: it ensures the library compiles in seconds, not minutes, and remains self-contained. |
| **Blueprint DAG over monolith** | Structure your work as a dependency graph of small, named lemmas. The `quickwin_blueprint.py` tool generates Mermaid DAGs automatically. |

### The Three Classifications

Every statement in this library falls into exactly one of these categories:

```
┌──────────────────────────────────────────────────────────────────┐
│  PROVEN INVARIANT          │  QUARANTINED AXIOM        │ SORRY  │
│  ✅ Tactics: rfl, decide,  │  ⚠️ Keywords: axiom,     │ 🔴 TODO│
│     omega, norm_num        │     variable              │ sorry  │
│  Example:                  │  Example:                 │        │
│  theorem χ_K3 : 24 = 24   │  axiom flux_cancel : True │        │
│    := by rfl               │                           │        │
└──────────────────────────────────────────────────────────────────┘
```

> **CRITICAL**: **NEVER** use `native_decide`, `sorry`, or `admit` in committed code unless it is explicitly marked as a blueprint skeleton for future work. All `sorry` must live in `Generated/` only.

---

## 2. Repository Map

```
SocrateAI-Lean-Lib/
├── lakefile.lean                 # Lake package config (srcDir := "Lean")
├── lean-toolchain                # Pinned: leanprover/lean4:v4.33.1
├── Lean/
│   ├── SocrateAI.lean            # Root import file — ALL modules listed here
│   ├── SocrateAI/
│   │   ├── Core/                 # Foundational math (algebra, topology, analysis, logic)
│   │   ├── Duality/              # T-duality, dual-scale, effective scales
│   │   ├── K3/                   # K3 surfaces, Hodge diamond, Cooper pairs
│   │   ├── Ramanujan/            # Modular forms, RAMA engine, sieve kernel
│   │   ├── NavierStokes/         # Enstrophy, BKM criterion, frustration index
│   │   ├── StringTheory/         # F-theory, Swampland, K3×T², 19 string inequalities
│   │   ├── Pregeometry/          # K4 hypergraph, spectral analysis, ORF suppression
│   │   ├── Quantum/              # Golay code, Majorana modes, Golay M24
│   │   ├── Moonshine/            # RAMA level-12 η-quotient, Mathieu bispectrum, vacuum energy
│   │   ├── Inflation/            # Inflationary observables, r = 12/Ne^2, LiteBIRD bounds
│   │   ├── Cosmology/            # Bayesian evidence, DESI BAO chi2, JWST high-z
│   │   ├── ChameleonGravity/     # Inverted symmetron DAC model, NGC 1052-DF2, PPN screening
│   │   ├── AlienMath/            # Non-anthropocentric algebra, SOS witnesses
│   │   └── Generated/            # Auto-generated blueprint skeletons (may contain sorry)
│   ├── Tests.lean                # Root import for all test modules
│   └── Tests/                    # Unit tests mirroring all 14 domains
├── scripts/
│   ├── verify.sh                 # 5-step master proof verification & audit suite
│   ├── audit_axioms.py           # Kernel-level '#print axioms' audit & quarantine check
│   ├── check_olean_kernel.sh     # Lean 4 kernel .olean integrity checker (lean4checker)
│   ├── quickwin_blueprint.py     # Multi-article LaTeX → Lean 4 blueprint generator
│   └── external_library_sync.py  # Knowledge bridge for Mathlib, Physlib, TNLean, Arithmon
└── docs/
    ├── BLUEPRINT_DAG.md          # Mermaid dependency graph (auto-generated)
    ├── PROOF_MANIFEST.md         # Audit matrix of all theorems (auto-generated)
    ├── AXIOM_AUDIT_REPORT.md     # Kernel axiom audit report (auto-generated)
    ├── EXTERNAL_LIBRARIES.md     # Catalog of external Lean 4 repos & tools
    └── GUIDE_FOR_AGENTS.md       # Full canonical reference guide
```

### Key Rule: the `SocrateAI.lean` Root Import

Every module must be registered in `Lean/SocrateAI.lean`. If you create a new file `Lean/SocrateAI/MyDomain/MyFile.lean`, you **must** add:

```lean
import SocrateAI.MyDomain.MyFile
```

to `SocrateAI.lean`. Otherwise `lake build SocrateAI` will not include your module.

---

## 3. Quick Start: Build & Verify

```bash
# Full library build (should complete in ~30s)
lake build SocrateAI

# Full test suite
lake build Tests

# One-command verification (both library + tests)
./scripts/verify.sh

# Type-check a single file manually
lake env lean Lean/SocrateAI/Core/Topology.lean
```

> **IMPORTANT**: Always run `lake build SocrateAI` after any change. If it fails, do NOT proceed — fix the error first. The library must remain **zero-error at all times**.

---

## 4. How to Reuse Existing Modules

The library provides battle-tested structures you should **reuse, not redefine**:
- **Topology**: `SocrateAI.Core.Topology` (`Betti4D`, `Betti2D`, `eulerChar4D`)
- **Algebra**: `SocrateAI.Core.Algebra` (Inequalities)
- **String Theory**: `SocrateAI.StringTheory.StringInequalities` (K3 Constants)
- **Pregeometry**: `SocrateAI.Pregeometry.HypergraphK4` (K4 Graph parameters)
- **Quantum**: `SocrateAI.Quantum.GolayCode` (Golay, Majorana modes)

> **TIP**: **Before defining any new constant**, search the existing modules with: `grep -rn "def your_constant_name" Lean/SocrateAI/`. If it already exists, import it. Duplication will cause namespace collisions.

---

## 5. Adding a New Scientific Domain

Follow this exact recipe:
1. **Create the Module Directory**: `mkdir -p Lean/SocrateAI/YourDomain`
2. **Write the Lean File**: `Lean/SocrateAI/YourDomain/YourModule.lean`
3. **Register in Root Import**: Add `import SocrateAI.YourDomain.YourModule` to `Lean/SocrateAI.lean`
4. **Create Unit Tests**: Create `Lean/Tests/TestYourDomain.lean`
5. **Register Test**: Add `import Tests.TestYourDomain` to `Lean/Tests.lean`
6. **Verify**: `lake build SocrateAI && lake build Tests`

---

## 6. The Quick-Win Blueprint Pipeline

The `scripts/quickwin_blueprint.py` tool automates the extraction of certifiable invariants from LaTeX papers.

### Usage

**Ingest All Registered Papers**
```bash
python3 scripts/quickwin_blueprint.py --all --verify
```

**Ingest a Custom Paper**
```bash
python3 scripts/quickwin_blueprint.py \
  -i /path/to/your/paper.tex \
  -o Lean/SocrateAI/Generated/YourPaperSkeleton.lean \
  --verify
```

### Registering a New Paper
Edit `scripts/quickwin_blueprint.py` and add your paper to the `STANDARD_PAPERS` dictionary, then add domain-specific keyword detection.

---

## 7. Writing Lean 4 Proofs: Style & Tactics

### Allowed Tactics (Ordered by Preference)
1. `rfl` (Definitional equality)
2. `decide` (Decidable propositions)
3. `omega` (Linear integer arithmetic)
4. `norm_num` (Numerical normalization)
5. `simp [lemma]` (Simplification)
6. `ring` (Ring identities)

### Naming & Docs
- **Definitions**: `lowercase_snake_case` (e.g. `k3_euler_char`)
- **Theorems**: Action-oriented names (e.g. `euler_char_eq_24`)
- **Structures**: `PascalCase` (e.g. `Betti4D`)
- **Docs**: Every definition and theorem **must** have a `/-- ... -/` doc-comment.

---

## 8. Axiom Quarantine Protocol

When your paper makes a physical claim that cannot be proven from first principles, use `axiom` or `variable`:

```lean
section QuarantinedPhysicsPostulates

/-- **QUARANTINED**: Tadpole cancellation requires total D3-brane charge to vanish. -/
axiom tadpole_cancellation : True

end QuarantinedPhysicsPostulates
```

**DO NOT** prove them with `trivial` or `sorry` masquerading as a proof.

---

## 9. Testing & Verification Checklist

Before ending your turn or committing:
- [ ] `lake build SocrateAI` — zero errors
- [ ] `lake build Tests` — zero errors  
- [ ] New module registered in `Lean/SocrateAI.lean`
- [ ] New test file registered in `Lean/Tests.lean`
- [ ] Every `def` and `theorem` has a doc-comment
- [ ] No `sorry` outside of `Generated/`
- [ ] Physical heuristics use `axiom`/`variable`
