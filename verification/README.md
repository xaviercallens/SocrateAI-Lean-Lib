# Negative controls

A guard that cannot fail proves nothing. These files assert **deliberately wrong** axiom footprints
and are expected to be **rejected** by Lean. They live outside the library target so the build stays
green while the controls stay runnable.

```bash
lake --packages=local-packages.json env lean verification/GuardNegativeControl.lean    # MUST exit nonzero
lake --packages=local-packages.json env lean verification/F31OrderNegControl.lean      # MUST exit nonzero
lake --packages=local-packages.json env lean verification/F31OrderNegControl2.lean     # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDual0PinNegControl.lean     # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDualM1NegControl.lean      # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDualM2PinNegControl.lean    # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDualM3PinNegControl.lean    # MUST exit nonzero
lake --packages=local-packages.json env lean verification/TDualM4PinNegControl.lean    # MUST exit nonzero
lake --packages=local-packages.json env lean verification/SdfDef01PinNegControl.lean   # MUST exit nonzero
lake --packages=local-packages.json env lean verification/Sdf05PinNegControl.lean      # MUST exit nonzero
lake --packages=local-packages.json env lean verification/Sdf06PinNegControl.lean      # MUST exit nonzero
lake --packages=local-packages.json env lean verification/SdfPin01NegControl.lean     # MUST exit nonzero
lake --packages=local-packages.json env lean verification/SdfPin02NegControl.lean     # MUST exit nonzero
lake --packages=local-packages.json env lean verification/SdfPin03NegControl.lean     # MUST exit nonzero
lake --packages=local-packages.json env lean verification/SdfPin04NegControl.lean     # MUST exit nonzero
```

`SdfDef01PinNegControl.lean` and `Sdf05PinNegControl.lean` guard the two ends of the
Fricke-self-dual chain in `Lean/SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`.  The first
asserts that the mis-paired exponent vector `(1, 11, 1, 11)` at `N = 6` IS `IsFrickeSelfDual` (it is
self-dual only under the WRONG involution `1 ↔ 3`, `2 ↔ 6`) and that the load-bearing vector is not
— so if `decide` were succeeding vacuously, on an empty binder or on a goal collapsed to
`r δ = r δ`, the positive pins would prove nothing.  The second does the same for the headline
`SDF-05`: it claims the eigenvalue at `(N, r, k) = (6, (1,11,11,1), 12)` is `N^k = 2176782336`
rather than `√(N^k) = 46656` (the square root dropped), claims it is `-46656` (the sign flipped),
and instantiates `SDF-05` at the non-self-dual `r = (2, 0)` at `N = 2`, which satisfies the WEIGHT
hypothesis exactly — so if `IsFrickeSelfDual` were decoration rather than load-bearing, that item
would compile.

`Sdf06PinNegControl.lean` does the same for the NORMALISED form, `SDF-06`, where the errors that can
hide are all in the normaliser and the exponent rather than in the eta quotients.  Its six items are:
a wrong axiom footprint; the exponent's sign flipped (`z^{+k}` for `z^{-k}`, which is why the block
is handed the flipped exponent consistently — the first version of that item left the calc head
correct and died of a whnf heartbeat timeout, a resource failure that would have made the control
pass for the wrong reason); the normaliser not inverted (`46656` for `46656⁻¹`, a factor of `6¹²`);
the square root dropped from the normaliser (`2176782336⁻¹` for `46656⁻¹`); the root of unity
conjugated (`+i` for `-i`, stated at the ODD-weight instance because every `4 ∣ k` instance is blind
to it); and `SDF-06` instantiated at the non-self-dual `r = (2, 0)`, which satisfies the WEIGHT
hypothesis exactly.  Items 2-5 hand a FALSE statement exactly the tactic block the corresponding
positive pin uses.

`TDual0PinNegControl.lean` is a different kind of control: it does not assert a wrong axiom
footprint, it asserts the **wrong numeric value** of each of the four `TDUAL-M0` Fricke decide-pins
— the value the pin would take against a transposed `frickeMatrix`, a flipped `b`-entry, or a
dropped factor of `N` — using the *same* tactic block as the real pin. It exists because a
decide-pin that any nearby variant would also satisfy is not a pin.

`TDualM1NegControl.lean` is the same idea lifted from instances to the **general** formula.  Pins
are instances, and an instance check cannot certify that a general theorem's tactic block is doing
real work rather than closing whatever it is handed.  This file restates `TDUAL-M1`
(`frickeW_smul_coe : ((frickeW hN • τ : ℍ) : ℂ) = -1 / ((N : ℂ) * (τ : ℂ))`) with four *wrong*
right-hand sides — `+1/(Nτ)` (`b`-entry sign flip), `-1/τ` (dropped factor of `N`), `-N/τ`
(transposed matrix), `-1/(N+τ)` (`denom` misread as `c + d·τ`) — under the **identical** tactic
block, and must fail with exactly four `unsolved goals`.  Each failing goal displays the
simp-normalised left-hand side as `-1 / (↑N * ↑τ)`, which is the positive receipt: the simp set
computes the Fricke map independently of what it is being compared against.  If this file ever
compiles, `TDUAL-M1` is vacuous and the node must be reopened.

`TDualM3PinNegControl.lean` guards the one thing that can silently go wrong in `TDUAL-M3`
(`sl_smul_coe_eq_flt : ((γ • τ : ℍ) : ℂ) = (aτ+b)/(cτ+d)` with the entries read off `γ.1` at
`0 0, 0 1, 1 0, 1 1`): the **entry-position assignment**, not the arithmetic.  A transpose, an
`a`/`d` swap, or a sign on `b` or `c` yields a statement that is still well-typed, still an equality
in `ℂ`, and still *true* on symmetric matrices.  So it restates the five `TDUAL-M3` pins with the
value each such error would produce — `(3+i)/5` (`a`/`d` swap), `(2+i)/5` and `3+i` (transpose),
`(64+41i)/109` (`b`-flip), `(-2-i)/2` (`c`-flip), all recomputed in exact Gaussian-rational
arithmetic — under the identical tactic blocks, and must fail with exactly **ten** `error:` lines,
two per pin.  (The two `Γ₀(3)` / `Γ₀(5)` membership conjuncts are left correct and stay proved, so
they contribute no errors.)  Each pin is blind to exactly one variant and that blindness is recorded
at the gate rather than glossed; only the `Γ₀(5)` pin `!![7,2;10,3]` catches all five.

`TDualM4PinNegControl.lean` is the control the `TDUAL-M4` node is *entitled* to, and no more.
`frickeW_smul_involutive` is proved by `rw [← mul_smul]; exact frickeW_sq_smul hN τ` — `exact` of an
already-proved lemma — so a wrong-right-hand-side restatement of the theorem itself would fail only
because `exact` does not unify, certifying nothing about the mathematics.  That is stated rather
than papered over, and no such control is manufactured.  What *is* discriminated is the two-step
gate: the five `frickeW_invol_pin_*` lemmas state, as pairs, the intermediate `W_N • τ` and the
round trip `W_N • W_N • τ` at five points chosen so that `W_N • τ ≠ τ` — which is exactly what
`TDUAL-M0`'s self-dual point `W₁ • i = i` and fixed point `W₄ • (i/2) = i/2` cannot test.  Values
computed first in exact Gaussian-rational arithmetic: `N=2` at `i` → `i/2` → `i`; `N=3` at `2i` →
`i/6` → `2i`; `N=1` at `1+i` → `(-1+i)/2` → `1+i`; `N=2` at `1+i` → `(-1+i)/4` → `1+i`; `N=4` at
`i` → `i/4` → `i`.  This file restates all ten components with wrong values — a dropped factor of
`N` or a flipped `b`-entry on the intermediates, and the **idempotent** variant
`W_N • W_N • τ = W_N • τ` on the round trips — under the identical tactic blocks, and must fail with
exactly ten `error:` lines (nine `unsolved goals`, one `ring_nf made no progress`).  The pins reach
their values through `frickeW_smul_coe` (TDUAL-M1) applied once and twice, a route independent of
`frickeW_sq_smul`'s product-matrix computation, so pins and general proof agree by computation
rather than by construction.  Confirmed failing **before** `frickeW_smul_involutive` was discharged.

If any of these ever *passes*, the 816 `#guard_msgs` guards in `Lean/SocrateAI/FinalCheck.lean` are
vacuous and every axiom-footprint claim in the papers is unsupported. That is the failure this
directory exists to detect.

Verified failing 2026-09-07: `GuardNegativeControl.lean` reports
`expected [], received [propext, Classical.choice, Quot.sound]`.

Verified 2026-09-08 against this run (RUN-6): `lake build SocrateAI --packages=local-packages.json`
completes at 3767 jobs; `verification/*.lean` re-checked failing.

Verified 2026-09-08 against run 7 (TDUAL-M0): `lake build --packages=local-packages.json` completes
at 3788 jobs (`lake build SocrateAI` at 3768); `TDual0PinNegControl.lean` re-checked failing with
exactly four `unsolved goals` errors, and the other three controls re-checked failing.

Verified 2026-09-08 against run 8 (TDUAL-M1): `lake build SocrateAI --packages=local-packages.json`
completes at 3768 jobs, exit 0, with `SocrateAI.FinalCheck` built — so the flipped guard
`'SocrateAI.StringTheory.frickeW_smul_coe' depends on axioms: [propext, Classical.choice, Quot.sound]`
is enforced by the build, and the inverted tripwire on `tduality_tau_fricke_bridge` (which must
still contain `sorryAx`) still passes.  `TDual0PinNegControl.lean` and the new
`TDualM1NegControl.lean` each re-checked failing with exit 1 and exactly four errors.

Verified 2026-09-08 against run 9 (TDUAL-M3): `lake build SocrateAI --packages=local-packages.json`
completes at **3768 jobs, exit 0**, `Build completed successfully (3768 jobs).`, with
`SocrateAI.FinalCheck` built — so the six new guards (five `sl_flt_pin_*` pins and
`sl_smul_coe_eq_flt`, all `[propext, Classical.choice, Quot.sound]`) are enforced by the build, and
the inverted tripwire on `tduality_tau_fricke_bridge` (which must still contain `sorryAx`) still
passes.  The `sorry` count drops from 6 to **5** (2 `EtaMultiplier`, 1 `EtaLigozatKronecker`,
2 `TDualityBridge` for the still-open `TDUAL-M4` and `TDUAL-01`).  All five negative controls
re-checked failing: `GuardNegativeControl` exit 1 / 1 error, `TDual0PinNegControl` exit 1 / 4
errors, `TDualM1NegControl` exit 1 / 4 errors, `TDualM2PinNegControl` exit 1 / 10 errors,
`TDualM3PinNegControl` exit 1 / 10 errors.  The `TDUAL-M3` pins were discharged and
`TDualM3PinNegControl.lean` confirmed failing with exactly ten **before** `sl_smul_coe_eq_flt` was
proved.

Verified 2026-09-08 against run 10 (TDUAL-M4): `lake build SocrateAI --packages=local-packages.json`
completes at **3768 jobs, exit 0**, `Build completed successfully (3768 jobs).`, with
`SocrateAI.FinalCheck` built — so the six new guards (five `frickeW_invol_pin_*` pins and
`frickeW_smul_involutive`, all `[propext, Classical.choice, Quot.sound]`) are enforced by the build,
and the inverted tripwire on `tduality_tau_fricke_bridge` (which must still contain `sorryAx`) still
passes: closing `TDUAL-M4` does not close the bridge.  The `sorry` count in the build target drops
from 5 to **4** (2 `EtaMultiplier`, 1 `EtaLigozatKronecker`, 1 `TDualityBridge` for the still-open
`TDUAL-01`).  All eight negative controls re-checked failing: `GuardNegativeControl` exit 1 / 1
error, `F31OrderNegControl` exit 1 / 1, `F31OrderNegControl2` exit 1 / 1, `TDual0PinNegControl`
exit 1 / 4, `TDualM1NegControl` exit 1 / 4, `TDualM2PinNegControl` exit 1 / 10,
`TDualM3PinNegControl` exit 1 / 10, `TDualM4PinNegControl` exit 1 / 10.

Verified 2026-09-10 against run 12 (`SDF-05`): `lake --packages=local-packages.json build SocrateAI`
completes at **3769 jobs, exit 0**, `Build completed successfully (3769 jobs).`, with
`SocrateAI.FinalCheck` built — so the 67 new guards of section `Sdf05` (five `SDF-05` instance pins,
their five numeral forms, `frickeEigenvalue_pin_level_four`, the five `selfDual_pin_*` conjunctions
and `etaQuotient_fricke_selfDual` itself, all `[propext, Classical.choice, Quot.sound]`) are enforced
by the build, taking the guard count from 842 to **909**.  The INVERTED tripwire asserting that
`etaQuotient_fricke_selfDual` still depends on `sorryAx` was inverted back in the same commit, as
required — no `SDF-*` node carries an inverted tripwire any more.  The `sorry` count in the build
target drops from 17 to **11** (the pre-run figure is 17, not the 19 `BUILDING.md` claimed —
that number had drifted and is corrected there in the same commit) (2 `EtaMultiplier`, 1 `EtaLigozatKronecker`, 1 `TDualityBridge` for
the still-open `TDUAL-01`, and 7 in `EtaQuotientFrickeSelfDual` for the still-open `SDF-06` …
`SDF-12`).  `dag/check_dag.py` reports `PASS — 94 nodes (5 blocked, 11 open, 78 proved), acyclic,
sound.`  Negative controls re-checked failing this run: `GuardNegativeControl` exit 1 / 1 error,
`SdfDef01PinNegControl` exit 1 / 4 errors, and the new `Sdf05PinNegControl` exit 1 / 4 errors — the
last confirmed failing on all four items, including the two that hand a FALSE numeral the real pin's
own tactic block.

Verified 2026-09-10 against run 13 (`SDF-06`): `lake build SocrateAI --packages=local-packages.json`
completes at **3769 jobs, exit 0**, `Build completed successfully (3769 jobs).`, with
`SocrateAI.FinalCheck` built — so the 15 new guards of section `Sdf06` (two radicand lemmas, five
`SDF-06` instance pins, three numeral forms, the `eta_S` cross-check, the normaliser negative
control, `etaQuotient_fricke_selfDual_normalized` itself and its two application checks, all
`[propext, Classical.choice, Quot.sound]` — no `sorryAx` anywhere) are enforced by the build, taking
the guard count from 909 to **924**.  `SDF-06` never carried an inverted tripwire: its statement was
pinned and its proof landed in the same run.  The `sorry` count in the build target drops from 11 to
**10** (2 `EtaMultiplier`, 1 `EtaLigozatKronecker`, 1 `TDualityBridge` for the still-open
`TDUAL-01`, and 6 in `EtaQuotientFrickeSelfDual` for the still-open `SDF-07` … `SDF-12`).
`dag/check_dag.py` reports `PASS — 94 nodes (5 blocked, 10 open, 79 proved), acyclic, sound.`
Negative controls re-checked failing this run: `GuardNegativeControl` exit 1 / 1 error, and the new
`Sdf06PinNegControl` exit 1 / 6 errors — each item confirmed failing for the right reason (a guard
mismatch, a `rewrite failed`, two `invalid 'calc' step`s, an `unsolved goals` displaying the residue
`-I * f = I * f`, and a ``decide` proved that the proposition ... is false` on the self-duality
hypothesis), none by timeout.  A one-off check that the new guard has teeth was also run: restating
`#print axioms etaQuotient_fricke_selfDual_normalized` with the expected footprint `[]` is rejected.

Verified 2026-09-10 against the `SDF-11` run (`frickeEigenvalue_norm`):
`lake build SocrateAI --packages=local-packages.json` completes at **3769 jobs, exit 0**,
`Build completed successfully (3769 jobs).`, with `SocrateAI.FinalCheck` built — so the 12 new
guards of section `Sdf11` (six instance pins, three negative controls, the hypothesis-redundancy
pin, `frickeEigenvalue_norm` itself and its application check, all
`[propext, Classical.choice, Quot.sound]` — no `sorryAx` anywhere) are enforced by the build, taking
the guard count from 969 to **981**.  `SDF-11` never carried an inverted tripwire: its statement was
pinned and its proof landed in the same run, and it added no `sorry`, so the `sorry` count in the
build target is unchanged at **6** (2 `EtaMultiplier`, 1 `EtaLigozatKronecker`, 1 `TDualityBridge`
for the still-open `TDUAL-01`, and 2 in `EtaQuotientFrickeSelfDual` for the still-open, still
RECONSTRUCTED `SDF-12` and `SDF-13`).  `dag/check_dag.py` reports
`PASS — 95 nodes (5 blocked, 6 open, 84 proved), acyclic, sound.`  Negative controls re-checked
failing this run: `GuardNegativeControl` exit 1 / 1 error, and the new `Sdf11PinNegControl` exit 1 /
7 errors across its five items (items 3 and 4 are conjunctions and produce two each) — each item
confirmed failing for the right reason: a guard mismatch, an `unsolved goals ⊢ √(↑N ^ k) = ↑N ^ k`
displaying the DROPPED SQUARE ROOT, an `Application type mismatch` on `sqrt_natPow_level_six`
together with an `⊢ False`, an `⊢ 1 = -1` twice (the sign the norm discards) and an
`⊢ ↑√2 = -(I * ↑√2)` (the `i`-factor the norm discards); none by timeout.

NUMBERING CHANGE MADE IN THIS RUN, and deliberately NOT retro-applied to the dated records above.
`frickeEigenvalue_eq_one_iff` and `frickeEigenvalue_eq_neg_one_iff` were labelled `SDF-11` and
`SDF-12` by an earlier run whose task specification had been TRUNCATED mid-node at the string
`theorem frickeEigenvalue_`; that run reconstructed both statements and recorded in their own
docstrings that the labels were a guess to be confirmed or replaced.  The orchestrating session then
supplied the real `SDF-11` — `frickeEigenvalue_norm`, `‖frickeEigenvalue N k‖ = √((N : ℝ)^k)` — a
DIFFERENT theorem, so both reconstructions were renumbered to `SDF-12` and `SDF-13` in the same
commit that closed the real `SDF-11`, and `dag/theorems.jsonl`, `BUILDING.md`, `FinalCheck.lean` and
`EtaQuotientFrickeSelfDual.lean` were updated to match.  Every run record ABOVE this paragraph
predates that commit and uses the OLD numbering, in which `SDF-11` means `frickeEigenvalue_eq_one_iff`
and `SDF-12` means `frickeEigenvalue_eq_neg_one_iff`; rewriting them would have falsified the record,
so they were left alone and this paragraph is the key.

Verified 2026-09-10 against the `SDF-13` run (`frickeEigenvalue_eq_neg_one_iff`) — the run that
CLOSES the `SDF-*` block: `lake build SocrateAI --packages=local-packages.json` completes at
**3769 jobs, exit 0**, `Build completed successfully (3769 jobs).`, with `SocrateAI.FinalCheck`
built — so the 18 new guards of section `Sdf13` (three value pins `I_zpow_two`,
`frickeEigenvalue_pin_level_six_weight_two` and `frickeEigenvalue_pin_level_one_weight_neg_two`;
eight instance pins; three negative controls; the asymmetry pin; the hypothesis-redundancy pin;
`frickeEigenvalue_eq_neg_one_iff` itself and its application check) are enforced by the build,
taking the guard count from 992 to **1010**.  Seventeen of the eighteen footprints are
`[propext, Classical.choice, Quot.sound]`; the eighteenth,
`frickeEigenvalue_eq_neg_one_iff_pin_asymmetry`, is `[propext, Quot.sound]` with NO
`Classical.choice` — it is pure `omega` and constructor logic — and its guard records that smaller
footprint rather than the section's usual triple.  No `sorryAx` anywhere, and every `decide` is
`decide`, never `native_decide`, so no `Lean.ofReduceBool` enters any footprint.  `SDF-13` never
carried an inverted tripwire: its statement was already in the file as a `sorry` and its proof
landed in this run.  The `sorry` count in the build target drops from 5 to **4** (2
`EtaMultiplier`, 1 `EtaLigozatKronecker`, 1 `TDualityBridge` for the still-open `TDUAL-01`) — and
`EtaQuotientFrickeSelfDual.lean` now contributes NONE: `SDF-13` was that file's last open node, so
the file is `sorry`-free in full, verified by
`grep -nE '(^|[^`A-Za-z-])sorry([^`A-Za-z-]|$)' Lean/SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`
returning nothing.  `dag/check_dag.py` reports
`PASS — 95 nodes (5 blocked, 4 open, 86 proved), acyclic, sound.` and `SDF-13` has left the
frontier.  Negative control re-checked failing this run: the new `Sdf13PinNegControl` exits 1 with
NINE `error:` lines across its seven items (item 5 produces three, being a two-directional
equivalence between mismatched right-hand sides), each failing for the RIGHT reason and none by
timeout: item 1 a `#guard_msgs` mismatch printing the real footprint against the claimed
`does not depend on any axioms`; item 2 `unsolved goals ⊢ False` from `norm_num` on `-6 = -1` — the
LEVEL conjunct dropped at `(6, 2)`, where the root of unity IS `-1`; item 3 the same on `1 = -1` —
the RESIDUE conjunct dropped at the `eta_S_via_fricke` instance `(1, 12)`; item 4
``Tactic `decide` proved that the proposition (-2).tmod 4 = 2 is false`` — the truncating-remainder
reading, refuted at a weight whose eigenvalue genuinely is `-1`; item 5 two
`Application type mismatch` on `4 ∣ k` against `k % 4 = 2` plus an `omega could not prove the goal`
— `SDF-12`'s right-hand side is not this one's; item 6 `unsolved goals ⊢ False` on `-6 = 6` — the
root of unity dropped from a value pin; item 7 `Application type mismatch: rfl ... but is expected
to have type N = 1` — the general lemma with the level conjunct dropped, dying in exactly the
backward direction where nothing supplies `(N : ℝ)^k = 1`.

BUILD-FLAG RECEIPT FOR THIS RUN, recorded because it cost real time and disk.  The FIRST build
attempt of this run omitted `--packages=local-packages.json` and began recompiling Mathlib FROM
SOURCE inside the repo-local `.lake/packages/mathlib` (observed on
`Mathlib/Analysis/Calculus/Deriv/Mul.lean`, `Mathlib/Analysis/Calculus/ContDiff/Operations.lean`
and `Mathlib/FieldTheory/Finite/Basic.lean`), because that checkout's `lake exe cache get` is
INCOMPLETE.  It was killed after roughly twenty minutes and about 1 GB of writes; nothing in the
shared pool at `SocrateAI-Scientific-Measure/lean/.lake/packages/mathlib` was touched, and the
re-run WITH the flag replayed the dependency graph and built the target module in 6.2 s.  Same
hazard as LL-27/LL-32 on the negative-control side, and the same fix: `--packages` is a GLOBAL lake
flag, and on this repo it is not optional for either `lake build` or `lake env lean`.

RECONSTRUCTION CAVEATS: BOTH NOW DISCHARGED.  The `NUMBERING CHANGE` paragraph above records that
`frickeEigenvalue_eq_one_iff` and `frickeEigenvalue_eq_neg_one_iff` were reconstructions produced
from a TRUNCATED specification, renumbered to `SDF-12` and `SDF-13`.  The orchestrating session has
since supplied `SDF-12` and then `SDF-13` in full, and each supplied statement agreed with the
reconstructed declaration CHARACTER FOR CHARACTER, hypothesis `hN` included.  Both caveats are
therefore discharged, in the same commits that discharged the corresponding `sorry`s, and NO
declaration in `EtaQuotientFrickeSelfDual.lean` carries an unconfirmed statement any more.  The
dated records above this paragraph still use the OLD numbering and were deliberately left alone.

STATEMENT-COMPARATOR RECEIPT FOR `SDF-13`: **NO_REFERENCE**, and correctly so — the comparator was
pointed at `etaQuotient_fricke` (`EtaQuotientModularity.lean:2212`), whose statement contains an
`etaQuotient`, an exponent vector `r`, a point `z`, an `IsFrickeSelfDual`-style hypothesis and the
weight normalisation `hk`, none of which occur in `SDF-13`.  Substituting a self-dual `r` into that
theorem produces `SDF-04`/`SDF-05`'s eigenform equation, never a `±1` criterion on a scalar.  The
same call was already recorded for `SDF-10`, `SDF-11` and `SDF-12`; it is a wrong-yardstick verdict,
not a defect in the node.  The node was instead checked against its real references — `SDF-09`,
`SDF-10`, `SDF-11` and Mathlib's `Real.sqrt_eq_one` — and against an out-of-Lean exact-arithmetic
sweep of all 40 501 instances `N ∈ [0, 100]`, `k ∈ [-200, 200]`, zero mismatches.

PROSE CAVEAT THAT MUST TRAVEL WITH `SDF-13` INTO ANY PAPER.  `frickeEigenvalue` is the UNNORMALISED
constant of `f(-1/(Nz)) = λ · z^k · f(z)` and carries `N^{k/2}`.  "Eigenvalue `-1` forces `N = 1`"
is a statement about THAT convention.  It does NOT contradict the classical fact (Martin,
*Multiplicative eta-quotients*, 1996) that multiplicative eta quotients of level `N > 1` have Fricke
eigenvalue `±1`: the classical eigenvalue is the NORMALISED one, here `i^{-k}` (`SDF-06`), whose
`N`-dependence has already cancelled by `SDF-02`.
`frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two` is the machine-checked instance where the
two differ — at `(6, 2)` the normalised eigenvalue is `-1` and the unnormalised one is `-6`.
Reporting `SDF-13` without naming the normalisation would read as a false claim.

PHYSICS SCOPE FOR THIS RUN, restated because the topic invites the error.  Nothing added in this run
formalises any physics.  `SDF-13` says when a complex number attached to a level and a weight equals
`-1`.  No declaration anywhere in this library mentions S-duality, the axio-dilaton or CHL models,
and none was added; Persson–Volpato (arXiv:1504.07260) is cited in `EtaQuotientFrickeSelfDual.lean`'s
docstring as the ORIGIN of the question only, at the literature (L) tier.  Their claim that CHL
models are self-dual under Fricke S-duality exactly when the Frame shape is "balanced" in THEIR sense
(their eq. 1.6, the same combinatorial condition this library calls Fricke-self-dual, and NOT to be
confused with this codebase's unrelated `exists_balanced_add`) rests on charge-lattice
`N`-modularity and BPS/Witten-index computations that nothing here derives.  That claim belongs in
prose, cited, and must never be reported as a Lean statement of this library.

Verified 2026-09-10 against the `SDF-15` run (`I_zpow_neg_pm_one_iff`, the NORMALISED `±1`
criterion `(i^{-k} = 1 ∨ i^{-k} = -1) ↔ Even k`): `lake build SocrateAI
--packages=local-packages.json` completes at **3769 jobs, exit 0**,
`Build completed successfully (3769 jobs).`, with `SocrateAI.FinalCheck` built — so the 11 new
guards of section `Sdf15` (six weight pins `I_zpow_neg_pm_one_iff_pin_twelve` / `..._pin_neg_twelve`
/ `..._pin_zero` / `..._pin_two` / `..._pin_fifteen` / `..._pin_one`; two negative controls
`..._pin_neither_disjunct_alone` and `..._pin_even_strictly_between`; the negation-invariance lemma
`I_zpow_neg_pm_one_iff_even_neg`; the theorem itself and its application check) are enforced by the
build.  The guard count, MEASURED by
`grep -c '#guard_msgs in #print axioms' Lean/SocrateAI/FinalCheck.lean`, is **1031**.  All 11
footprints are `[propext, Classical.choice, Quot.sound]`; no `sorryAx` anywhere, and every `decide`
is `decide`, never `native_decide`, so no `Lean.ofReduceBool` enters any footprint.  The `sorry`
count in the build target is unchanged at **4** (2 `EtaMultiplier`, 1 `EtaLigozatKronecker`, 1
`TDualityBridge` for the still-open `TDUAL-01`) — `SDF-15` needed no `sorry` to remove, since it was
stated and proved in the same run, so it never carried an inverted tripwire either.
`dag/check_dag.py` reports `PASS — 97 nodes (5 blocked, 4 open, 88 proved), acyclic, sound.`

GUARD-COUNT DRIFT CORRECTED HERE, inherited rather than caused by this run.  The paragraph above
records 1010 guards as of the `SDF-13` run.  The `SDF-14` run (`frickeEigenvalue_pm_one_iff`) then
added 10 guards in section `Sdf14` and updated NEITHER this file nor `BUILDING.md`, so both read
"1010" when the `SDF-15` run began, understating the real count by 10.  Both are now set to 1031
from the measurement command, not by arithmetic; that 1010 + 10 + 11 = 1031 is a consistency check
on the correction, not its source.

STATEMENT PROVENANCE AND COMPARATOR DISPOSITION FOR `SDF-15`.  The statement was supplied in full by
the orchestrating session and the declaration matches it: `theorem I_zpow_neg_pm_one_iff (k : ℤ) :
((I : ℂ) ^ (-k) = 1 ∨ (I : ℂ) ^ (-k) = -1) ↔ Even k`.  No reconstruction was involved.  The
statement comparator returned NO_REFERENCE because it was pointed at `etaQuotient_fricke`, which is
the wrong reference for this node — the same disposition already recorded for `SDF-07` … `SDF-14`.
`SDF-15` quantifies over one integer and contains no `N`, no `r : EtaExp`, no `N.divisors`, no `z`,
no `ℍₒ`, no `etaQuotient` and no `IsFrickeSelfDual` hypothesis; the specialisation of
`etaQuotient_fricke` to self-dual exponent vectors is `SDF-04`.  The node's real references are
`SDF-08` and `SDF-09`, both already closed here, and `SDF-06` for the eigenvalue reading.  The DAG
entry's `depends_on` was RE-POINTED from `[SDF-07]` to `[SDF-08, SDF-09]` before proving: routing
through `SDF-07` directly would have duplicated the four-case residue analysis those two already
carry, including the `Int.emod` / `Int.tmod` hazard pinned by
`I_zpow_neg_eq_neg_one_iff_pin_emod_not_tmod`.

OUT-OF-LEAN CHECK RUN BEFORE THE STATEMENT WAS ENTERED.  `i^{-k} ∈ {1, -1} ↔ k` even was evaluated
in exact Gaussian-integer arithmetic (integer pairs, no floating point) at all 601 weights
`k ∈ [-300, 300]`: zero mismatches.  The six pinned weights were computed by the same script and
agree with the values the Lean pins assert — `k = 12, -12, 0` give `1`, `k = 2` gives `-1`,
`k = 15` gives `i` and `k = 1` gives `-i`.

NOVELTY RECEIPTS, re-run this session with no truncation.  `grep -rn I_zpow_neg_pm_one_iff Lean/
verification/ dag/` returned nothing before this run.  Mathlib carries only the NATURAL-exponent
periodicity `Complex.I_pow_eq_pow_mod` (`Mathlib/Data/Complex/Basic.lean:633`); a whole-tree grep for
any `Even`/iff form of `I_pow` or `I_zpow` returns nothing, and `zpow_eq_one_iff_of_ne_zero₀`
(`Mathlib/Algebra/Order/Field/Power.lean:87`), the only `zpow`/`Even` biconditional in Mathlib, is
stated for a `LinearOrderedField` and does not apply to `ℂ`.

PROSE CAVEATS THAT MUST TRAVEL WITH `SDF-15` INTO ANY PAPER — three, all mandatory.  (i) The
identification of `i^{-k}` with "the Fricke eigenvalue of a Fricke-self-dual eta quotient of weight
`k`" is `SDF-06` (`etaQuotient_fricke_selfDual_normalized`), NOT this node; the sentence "the Fricke
eigenvalue is `±1` exactly when the weight is even" is `SDF-15` COMPOSED WITH `SDF-06` and both must
be cited.  (ii) NORMALISATION: `i^{-k}` is the NORMALISED eigenvalue, `SDF-06` having already divided
out `√(N^k)` and `z^k`.  That sentence is TRUE of `i^{-k}` and FALSE of `frickeEigenvalue`, the
UNNORMALISED constant carrying `N^{k/2}`, for which `±1` is `SDF-14`'s far tighter condition
requiring `N = 1` or `∑ r δ = 0`; `frickeEigenvalue_eq_neg_one_iff_pin_level_six_weight_two` is the
machine-checked instance where the two conventions differ (normalised `-1`, unnormalised `-6`).
`SDF-15` may be quoted in preference to `SDF-14` only with the normalisation named in the same
sentence.  (iii) The re-parametrisation `Even k ↔ 4 ∣ ∑_{δ ∣ N} r δ` is NOT this node and does not
follow from it: it needs `hk : ∑ δ ∈ N.divisors, r δ = 2 * k`, which `SDF-15` does not carry, and
would require a separate node or an added hypothesis, exactly as `SDF-14` needed one to restate
`SDF-12`/`SDF-13` on the weight sum.

PHYSICS SCOPE FOR THIS RUN, restated because the topic invites the error.  Nothing added in this run
formalises any physics.  `SDF-15` relates an integer power of the complex unit `i` to the parity of
an integer.  No declaration anywhere in this library mentions S-duality, the axio-dilaton or CHL
models, and none was added; Persson–Volpato (arXiv:1504.07260) is cited in
`EtaQuotientFrickeSelfDual.lean`'s docstring as the ORIGIN of the self-duality question only, at the
literature (L) tier.  Their claim that CHL models are self-dual under Fricke S-duality exactly when
the Frame shape is "balanced" in THEIR sense (their eq. 1.6, the same combinatorial condition this
library calls Fricke-self-dual, and NOT to be confused with this codebase's unrelated
`exists_balanced_add`) rests on charge-lattice `N`-modularity and BPS/Witten-index computations that
nothing here derives.  That claim belongs in prose, cited, and must never be reported as a Lean
statement of this library.

NEGATIVE CONTROL FOR `SDF-15`, re-checked FAILING this run.  `verification/Sdf15PinNegControl.lean`
(outside the build target, so the build stays green while the control stays runnable) exits **1**
with SEVEN `error:` lines across its seven items, each failing for the RIGHT reason and none by
timeout: item 1 a `#guard_msgs` mismatch printing the real footprint
`[propext, Classical.choice, Quot.sound]` against the claimed `does not depend on any axioms`;
items 2, 3 and 4 `omega could not prove the goal` on, respectively, the `-1` disjunct dropped
(`SDF-08`'s left-hand side against this node's right-hand side, false at `k = 2`), the `+1` disjunct
dropped (`SDF-09`'s left-hand side, false at `k = 12`) and the right-hand side narrowed back to
`4 ∣ k` (false at `k = 2`) — the SAME `omega` call that closes the true statement, so that step is
discharging real content; item 5 ``Tactic `decide` proved that the proposition Even 15 is false``,
reached after rewriting by `SDF-15` ITSELF at `k = 15`, i.e. the general lemma refusing to hand out
`i^{-15} ∈ {1, -1}` — the control on the node's EXCLUSION power; item 6 `unsolved goals ⊢ -1 = 1`,
the load-bearing pin `..._pin_two` with the sign flipped and handed its own route through
`I_zpow_neg_two`; item 7 the odd pin's parity side claimed even.  Run it as
`lake --packages=local-packages.json env lean verification/Sdf15PinNegControl.lean` — `--packages`
is a GLOBAL lake flag and must precede the subcommand (LL-27, LL-32); the other spellings exit 1 for
an ENVIRONMENT reason, which makes a negative control look like it passed when it examined nothing.

---

`SDF-PIN-01` — THE LEVEL-ONE PIN, AND A CORRECTION TO WHAT IT WAS CLAIMED TO SHOW.

`SDF-PIN-01` is `selfDual_raw_pin_level_one_is_eta_S`
(`Lean/SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean:1675`, sorry-free, guarded in
`FinalCheck` §`Sdf04`): the `(N, r, k) = (1, r ≡ 24, 12)` instance of `SDF-04`, with its constant
evaluated, i.e. `η(-1/z)²⁴ = z¹² η(z)²⁴` — the `S`-transformation law of the discriminant.

WHAT IT IS.  A FLOOR: second-route agreement.  The same conclusion is already sorry-free upstream
twice, as `eta_S_via_fricke` (`EtaQuotientModularity.lean:2246`) and, in the `example` beside it,
from MATHLIB's `discriminant_S_invariant` (`Mathlib/NumberTheory/ModularForms/Discriminant.lean:143`,
a bare `lemma`, not `@[simp]`).  This node certifies that the self-dual module's two NEW definitions
reproduce that value by a third, independent route.  INDEPENDENCE IS NOW CHECKED, not argued from the
tactic script: walking the KERNEL PROOF TERM of `selfDual_raw_pin_level_one_is_eta_S` transitively
reaches `etaQuotient_fricke`, `etaQuotient_congr_divisors`, `selfDual_cond_pin_level_one`,
`rPinOne_weight` and `IsFrickeSelfDual`, and reaches NEITHER `eta_S_via_fricke` NOR
`discriminant_S_invariant`.  Numerically re-checked at 30 decimal places at `z = 0.3+1.1i`,
`-0.7+0.45i`, `2.3i`, `0.1+0.05i`: relative error `≤ 1.3e-29`.

A CLAIM THAT WAS FALSE, AND IS NOW REFUTED IN LEAN.  Three docstrings in this library — the one on
`eta_S_via_fricke` itself, the `SDF-04` pin prose, and two `FinalCheck` comments — asserted that a
wrong sign on `i^{-k}`, a wrong power of `N`, or `√s` on the wrong side of the fraction would break
the agreement AT THIS INSTANCE.  It would not.  At `N = 1`, `k = 12`: `i^{-12} = 1 = i^{+12}`, so the
sign of the `i`-exponent is invisible; every `zpow` of `(1 : ℂ)` is `1`, so `N^k`, `N^{2k}` and
`N^{-k}` agree; `s = ∏_{δ ∣ 1} δ^{r δ} = 1²⁴ = 1`, so `(√s)⁻¹ = √s`; and `δ ↦ 1/δ` is the IDENTITY on
`Nat.divisors 1`, so a transposed divisor pairing is invisible too.  All four sentences are now
THEOREMS — `selfDual_pin_level_one_no_evidence_I_sign`, `..._level_pow`, `..._radicand`,
`..._involution`, section `SdfPin01Reach` — each sorry-free and guarded in `FinalCheck` §`SdfPin01`,
so the limitation is machine-checked rather than remembered, and the four docstrings have been
corrected in the same commit.  This pin pins NO component of `λ = i^{-k} · N^k · s^{-1/2}`.

The perturbation evidence about the GENERAL statement (`scratch/A7perturb.lean`: five perturbations
of `etaQuotient_fricke`, all failing to elaborate) is UNAFFECTED by this correction — it concerns
free `N` and `k`, not the `N = 1` instance.

WHERE THE DISCRIMINATION ACTUALLY LIVES, also machine-checked.  Three of the four degeneracies fail
at `N = 6` (`selfDual_pin_level_six_evidence_contrast`: `6¹² ≠ 1`, `∏ δ^{rPinSix δ} = 2176782336 ≠ 1`,
and `δ ↦ 6/δ` is not the identity on `{1,2,3,6}`), which is why `selfDual_raw_pin_level_six`,
`prod_zpow_pin_mispaired_ne` and `not_selfDual_pin_mispaired` are this arc's load-bearing pins.  The
fourth fails only at ODD weight (`selfDual_pin_weight_one_evidence_I_sign`: `i^{-1} = -i ≠ i`) —
raising the LEVEL does not fix it, because `i^{-k} = i^{k}` for every even `k`, `k = 12` included.

NAME DRIFT, RESOLVED — read before citing.  The name `selfDual_pin_level_one`
(`EtaQuotientFrickeSelfDual.lean:908`) is a DIFFERENT and stronger proposition: the five-way
conjunction `IsFrickeSelfDual 1 rPinOne ∧ ∑ rPinOne δ = 2·12 ∧ ∏ δ^{rPinOne δ} = 1 ∧
∏ δ^{rPinOne δ} = 1^12 ∧ frickeEigenvalue 1 12 = 1`, which mentions neither `η` nor `z`.  It is
sorry-free and separately guarded (`FinalCheck.lean:6103`) but carries NO DAG node.  `SDF-PIN-01`
resolves to `selfDual_raw_pin_level_one_is_eta_S`; a base-name-matched axiom guard filed against
`selfDual_pin_level_one` would have guarded the wrong proposition while looking correct, which is
precisely what the base-name-match rule exists to catch.

PHYSICS SCOPE.  Nothing added for `SDF-PIN-01` formalises any physics.  Every new declaration is an
identity between complex numbers, a divisor computation, or a `Prop` about `Nat.divisors`.  No
declaration mentions S-duality, the axio-dilaton or CHL models.  Persson–Volpato (arXiv:1504.07260)
remains cited in the module docstring as the ORIGIN of the self-duality question only, at the
literature (L) tier; their "balanced Frame shape" is the same combinatorial condition this library
calls Fricke-self-dual, and is unrelated to this codebase's `exists_balanced_add`.

NEGATIVE CONTROL FOR `SDF-PIN-01`, re-checked FAILING this run.
`verification/SdfPin01NegControl.lean` (outside the build target, so the build stays green while the
control stays runnable) exits **1** with EIGHT `error:` lines across its eight items, each failing
for the RIGHT reason and none by timeout or by an environment error: item 1 a `#guard_msgs` mismatch
printing the real footprint `[propext, Classical.choice, Quot.sound]` against the claimed `does not
depend on any axioms`; items 2–5 are the four degeneracies asserted INVERTED, i.e. the old false
claim, failing at `⊢ 1 ≠ 1`, `⊢ False`, `⊢ False` and ``decide proved that the proposition
¬∀ δ ∈ Nat.divisors 1, 1 / δ = δ is false`` respectively — these are what stop the four
`..._no_evidence_*` theorems from being vacuous; item 6 the level-six contrast inverted (`6¹² = 1`,
`⊢ False`); item 7 the odd-weight contrast inverted, failing at `⊢ -I = I`, which is what makes "the
`i`-sign IS visible at odd weight" a real statement rather than a restatement of item 2; item 8 THE
NAME-DRIFT CONTROL, a `Type mismatch` from trying to close `SDF-PIN-01`'s equation with
`selfDual_pin_level_one`, printing that name's actual five-way conjunction.  The file sets
`autoImplicit false` and `open Complex (I)` on purpose: without them `I` is silently auto-bound as an
implicit variable and items 2 and 7 fail on a rewrite that never examined `Complex.I` — observed
once this run, and the reason the failure REASONS above are quoted rather than just the exit code.
Run it as `lake --packages=local-packages.json env lean verification/SdfPin01NegControl.lean` —
`--packages` is a GLOBAL lake flag and must precede the subcommand (LL-27, LL-32); the other
spellings exit 1 for an ENVIRONMENT reason, which makes a negative control look like it passed when
it examined nothing.

---

NEGATIVE CONTROL FOR `SDF-PIN-03`, run FAILING this run.
`SDF-PIN-03` is `selfDual_eigen_pin_level_four_weight_four_eta`
(`Lean/SocrateAI/ModularForms/EtaQuotientFrickeSelfDual.lean`, section `SdfPin03`):

```
η(-1/(4z))² · η(2·(-1/(4z)))⁴ · η(4·(-1/(4z)))²  =  16 · z⁴ · (η(z)² · η(2z)⁴ · η(4z)²)
```

the `(N, r, k) = (4, rPinLevelFourWeightFour, 4)` instance of `SDF-05`, `s = 1²·2⁴·4² = 256 = 4⁴`,
`λ = i^{-4} · √(4⁴) = 16`.  `verification/SdfPin03NegControl.lean` (outside the build target) exits
**1** with TWELVE `error:` lines across its twelve items, each failing for the RIGHT reason and none
by timeout or by an environment error:

* item 1 a `#guard_msgs` mismatch printing the real footprint `[propext, Classical.choice,
  Quot.sound]` against the claimed `does not depend on any axioms`;
* item 2 the WRONG CONSTANT `256` — the radicand `s = N^k`, i.e. the square root dropped, and the
  single most likely transcription error here since `256` appears in the same instance's product pin
  — as a `Type mismatch` printing the real `16 * z ^ 4 * …`;
* item 3 the wrong `z`-exponent (`z²` for `z⁴`), also a `Type mismatch`;
* item 4 the same claim stated on the constant alone, residual goal `⊢ 16 = 256`;
* item 5 THE FIRST NAME-DRIFT CONTROL: `sqrt_natPow_level_four` is `√(4¹) = 2`, the library's OTHER
  level-four instance (`r = (-2, 6, -2)`, `k = 1`); feeding it where `√(4⁴) = 16` is wanted fails with
  `has type √(↑4 ^ 1) = 2 but is expected to have type √(↑4 ^ 4) = 16`.  This is why every name in
  section `SdfPin03` carries the WEIGHT as well as the level;
* item 6 THE SECOND NAME-DRIFT CONTROL: `selfDual_pin_*` (no `eigen`) is the `SDF-PIN-01` family of
  five-way HYPOTHESIS CONJUNCTIONS mentioning neither `z` nor `η`; closing this node's EQUATION with
  one fails on a `Type mismatch` printing that conjunction.  This is why the DAG node names
  `selfDual_eigen_pin_level_four_weight_four_eta` and not `selfDual_pin_level_four`;
* items 7 and 8 the two `decide` inversions — `IsFrickeSelfDual 4 rPinLevelFourMispaired` (the
  mis-paired vector has the SAME weight sum `8 = 2·4`, so only `hr` rejects it) and
  `rPinLevelFourWeightFour 1 = rPinLevelFourWeightFour 2` (which is what stops the node's PAIRING
  evidence, its main advance over `SDF-PIN-02`, from being empty);
* item 9 THE DEGENERACY CONTROL.  The node itself cannot tell `√(N^k)` from `√(k^N)`, because
  `N = 4 = k` there — that limitation is stated in Lean as
  `selfDual_eigen_pin_level_four_weight_four_no_evidence_level_weight`.  Item 9 claims the LEVEL-NINE
  companion is equally blind and must fail; it does, at `⊢ 81 = √262144`.  If it compiled, the reason
  the companion pins exist would be gone;
* item 10 the SIGN control, `⊢ -4 = 4`: pin D (`N = 4`, `k = 2`) has a NEGATIVE constant, so a
  statement that had dropped `i^{-k}` closes the node and the level-nine pin (both `i^{-4} = 1`) and
  fails here;
* item 11 the calibration with a wrong exponent, a `Type mismatch` against
  `selfDual_eigen_pin_level_one_eta_calibration` — which is what makes the agreement with the
  upstream `eta_S_via_fricke` a real check;
* item 12 the involution asserted to be the identity at `N = 4`, ``decide proved that the proposition
  ∀ δ ∈ Nat.divisors 4, 4 / δ = δ is false``.

The file sets `autoImplicit false` and `open Complex (I)` on purpose, for the same reason
`SdfPin01NegControl.lean` does.  Run it as
`lake --packages=local-packages.json env lean verification/SdfPin03NegControl.lean` — `--packages` is
a GLOBAL lake flag and must precede the subcommand (LL-27, LL-32).

SCOPE, restated because this node sits next to a physics citation: `SDF-PIN-03` is an identity
between products of values of Mathlib's `ModularForm.eta` and nothing else.  No declaration in
section `SdfPin03` mentions S-duality, the axio-dilaton, CHL models or Frame shapes.
Persson–Volpato (arXiv:1504.07260) is cited in the module docstring as the ORIGIN of the
self-duality question only, at the literature (L) tier; their "balanced Frame shape" is the same
combinatorial condition this library calls Fricke-self-dual, and is unrelated to this codebase's
`exists_balanced_add`.

`SdfPin04NegControl.lean` guards `SDF-PIN-04`, the level-four WEIGHT-ZERO pin
(`selfDual_eigen_pin_level_four_weight_zero_eta`, `λ = 1`, `k = 0`). Twelve items, twelve error
lines, exit 1, verified this run. The ones to read first: item 6 is the NAME-DRIFT control
(`selfDual_eigen_pin_level_four_zero_exp` — the `r ≡ 0` pin at the SAME level, SAME weight and SAME
eigenvalue — does NOT close this node's equation); item 9 is the HONESTY control, which inverts the
section's own stated limitation (`i^{-0} = i^{+0}`, i.e. the pin cannot see the sign of the
`i`-exponent) and must fail, so the limitation cannot be a decoration; and item 10 instantiates
`SDF-05` at `rPinLevelFourWeightZeroMispaired = (0, 4, -4)`, which satisfies the WEIGHT hypothesis
`Sum r delta = 0 = 2 * 0` exactly, and fails on `hr` alone — the receipt that `IsFrickeSelfDual` is
load-bearing here even at `k = 0`, where every component of the constant is degenerate.
