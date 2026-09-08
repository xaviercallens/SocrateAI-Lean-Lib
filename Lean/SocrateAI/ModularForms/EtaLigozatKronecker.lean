/-
Copyright (c) 2026 SocrateAI Contributors. Released under MIT license.
-/
import SocrateAI.ModularForms.EtaPhiSum
import SocrateAI.ModularForms.KroneckerJacobi
import SocrateAI.ModularForms.EtaQuotientPrimeLevel

/-!
# DRK-11 — the closed-form eta multiplier IS Ligozat's Kronecker character

The node's statement, for `γ ∈ Γ₀(N)` with `c = γ₁₀ > 0`, `Σ_{δ ∣ N} r_δ = 2k`, and Ligozat's
two congruences:

  `(-i)^k · exp(πi/12 · Φ_N(r,γ)) = ( (-1)^k ∏_{δ ∣ N} δ^{r_δ} / γ₁₁ )`,

with `Φ_N(r,γ) = etaPhiSum N r γ` (DRK-09) and `( · / · )` run 3's Kronecker symbol.

## STATUS, stated first because it is the honest headline (LL-1/LL-2)

* **PROVED here, unconditionally**: the whole complex-exponential layer — `drk11_lhs_eq`,
  `exp_pi_div_twelve_eq_one_iff`, `exp_pi_div_twelve_eq_neg_one_iff` — which *reduces the node
  to a congruence mod 24* (`drk11_iff_congr`).  This is a genuine structural reduction, not
  bookkeeping: after it, DRK-11 says exactly

    `Φ_N(r,γ) − 6k ≡ 0 (mod 24)` when the symbol is `+1`, and `≡ 12 (mod 24)` when it is `−1`.

* **PROVED here**: the node's conclusion **for `0 < N ≤ 4`**, on all of `Γ₀(N)` with `c > 0`
  (`exp_etaPhiSum_eq_kroneckerSym_of_le_four`).  It is `DRK-09` composed with run 3's
  `multiplier_eq_kronecker_of_le_four` (F3.2-B3), so it costs nothing new mathematically — but
  it *is* the node's statement, verbatim, on a nonempty domain, and every pin below is an
  instance of it or of a level (`5, 7, 8, 11, 12`) where it does not apply.

* **NOT PROVED**: the node for general `N`.  It is left as a single `sorry` with an `-- OPEN:`
  comment naming the missing input.  See "WHAT IS MISSING" below.  DRK-11 is **not** discharged
  and `ETA-01` is **not** closed by this file.

## WHAT IS MISSING (the `-- OPEN:` in one paragraph)

After `drk11_iff_congr` the remaining content is arithmetic: `Φ_N(r,γ) − 6k mod 24`.  Writing
`c_δ = c/δ`, `Φ = Σ_δ r_δ ((a+d)δ/c − 12 s(d,c_δ))`, the classical route replaces every
`12 s(d,c_δ)` by its Petersson closed form, which is `DRK-10`
(`dedekindSum_jacobiSym_mod_eight`, `12 k s(h,k) = k + 1 − 2(h|k) + 8t`) — **but DRK-10 is
odd-modulus only**.  When `c` is even (and `N` even, `δ` even, or simply `2 ∣ c/δ`) there is no
statement in this library, and none upstream, that evaluates `s(d, c_δ)` mod the relevant power
of `2`.  A second missing input is the reciprocity flip: DRK-10 produces the symbol `(d | c_δ)`
with `d` on top, while Ligozat's character has `δ` on top and `γ₁₁` below, so
`jacobiSym.quadratic_reciprocity` has to be applied `δ`-by-`δ` and the resulting `(−1)^{...}`
signs collected against `hk`, `h1`, `h2`.  Neither is attempted here.  `F3.2-OBSTRUCTED` stands.

## HONESTY — the `c > 0` restriction is NOT cosmetic (LL-1)

Ligozat's theorem is over **all** of `Γ₀(N)`; this node is the `c > 0` slice.  With `hc` dropped
the statement is **false**: `etaPhiSum_of_lower_left_zero` (DRK-09) makes `Φ = 0` at `c = 0`, so
the left side degenerates to `(−i)^k`.  `drk11_neg_control_c_zero` below is a kernel-checked
witness at `N = 3`, `r = (−3, 9)`, `k = 3`, `γ = T`: hypotheses `hk`, `h1`, `h2` and `γ ∈ Γ₀(3)`
all hold, and the two sides are `i` and `1`.  So even a fully proved DRK-11 would still need the
`c < 0` reduction (DRK-08) and the `c = 0` case (`γ = ±T^n`) before `ETA-01`.

## PROVENANCE — INDEPENDENT, with one overlap named rather than hidden (LL-25)

Nothing here is ported.  `anthropics/fermats-last-theorem` contains no `ligozat`, no Kronecker
*symbol* (its 33 `kronecker` hits are Kronecker's congruence for modular polynomials and
`Matrix.kroneckerMap`), and no eta quotient with a character; `Mathlib` at our pinned revision
has no `ligozat`, `kroneckerSym`, `etaQuotient` or `dedekindSum`.  **But "no counterpart in any
form" would be too strong by exactly one instance**, and it is named here rather than omitted:
`ModularForm.etaProductEleven_transform` in FLT is the `N = 11`, `r = (2,2)`, `k = 2` case of
this theorem (numerator `121`, trivial character), proved there on all of `Γ₀(11)` with no
`c > 0` restriction.  `drk11_pin_N11_even_d` below is that very instance, and it is proved here
from our own `etaPhiSum` kernel evaluation, not from FLT.  See `ATTRIBUTION.md §DRK-11`.

## LL-22

Every Dedekind-sum symbol reached from this file through `etaPhiSum` is Apostol's `s(h,k)`
(`dedekindSum`).  `rademacherPhi` is Apostol's `Φ`.  Rademacher's `Ψ` (`rademacherPsi`) appears
nowhere in this file.
-/

namespace SocrateAI.ModularForms

open Matrix CongruenceSubgroup ModularForm
open scoped MatrixGroups Real
open SocrateAI.NumberTheory
open NumberTheorySymbols

/-! ## DRK-11, part 0 — the complex-exponential layer

Proved, unconditional, and independent of everything eta-theoretic.  It is what turns the node
into a statement about `Φ − 6k mod 24`. -/

section ExpLayer

/-- `−i = exp(πi/12 · (−6))`.  This is where the `(−i)^k` prefactor of DRK-09 gets absorbed
into the exponent. -/
theorem neg_I_eq_exp_pi_div_twelve :
    (-Complex.I) = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((-6 : ℚ) : ℂ)) := by
  rw [show (Real.pi : ℂ) * Complex.I / 12 * ((-6 : ℚ) : ℂ)
      = -(Real.pi : ℂ) / 2 * Complex.I by push_cast; ring]
  exact Complex.exp_neg_pi_div_two_mul_I.symm

/-- `(−i)^k = exp(πi/12 · (−6k))` for every INTEGER `k` (negative `k` included). -/
theorem neg_I_zpow_eq_exp (k : ℤ) :
    (-Complex.I) ^ k = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((-6 * k : ℚ) : ℂ)) := by
  rw [neg_I_eq_exp_pi_div_twelve, ← Complex.exp_int_mul]
  congr 1
  push_cast
  ring

/-- **The DRK-11 left-hand side is a SINGLE exponential**: `(−i)^k · exp(πi q/12) =
exp(πi (q − 6k)/12)`.  Every pin and every negative control below goes through this. -/
theorem drk11_lhs_eq (k : ℤ) (q : ℚ) :
    (-Complex.I) ^ k * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * (q : ℂ))
      = Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((q - 6 * k : ℚ) : ℂ)) := by
  rw [neg_I_zpow_eq_exp, ← Complex.exp_add]
  congr 1
  push_cast
  ring

/-- `exp(πi q/12) = 1 ↔ 24 ∣ q`, for RATIONAL `q`. -/
theorem exp_pi_div_twelve_eq_one_iff (q : ℚ) :
    Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * (q : ℂ)) = 1 ↔ ∃ n : ℤ, q = 24 * n := by
  rw [Complex.exp_eq_one_iff]
  constructor
  · rintro ⟨n, hn⟩
    refine ⟨n, ?_⟩
    have hpiI : (Real.pi : ℂ) * Complex.I ≠ 0 :=
      mul_ne_zero (by exact_mod_cast Real.pi_ne_zero) Complex.I_ne_zero
    have key : ((Real.pi : ℂ) * Complex.I) * ((q : ℂ) - 24 * (n : ℂ)) = 0 := by
      linear_combination 12 * hn
    have h0 : (q : ℂ) - 24 * (n : ℂ) = 0 := (mul_eq_zero.mp key).resolve_left hpiI
    have hq : ((q : ℚ) : ℂ) = (((24 * n : ℤ) : ℚ) : ℂ) := by push_cast; linear_combination h0
    exact_mod_cast hq
  · rintro ⟨n, rfl⟩
    exact ⟨n, by push_cast; ring⟩

/-- `exp(πi q/12) = −1 ↔ q ≡ 12 (mod 24)`, for RATIONAL `q`. -/
theorem exp_pi_div_twelve_eq_neg_one_iff (q : ℚ) :
    Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * (q : ℂ)) = -1 ↔ ∃ n : ℤ, q = 24 * n + 12 := by
  have h : Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((q + 12 : ℚ) : ℂ))
      = -Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * (q : ℂ)) := by
    rw [show (Real.pi : ℂ) * Complex.I / 12 * ((q + 12 : ℚ) : ℂ)
        = (Real.pi : ℂ) * Complex.I / 12 * (q : ℂ) + (Real.pi : ℂ) * Complex.I by
      push_cast; ring]
    exact Complex.exp_add_pi_mul_I _
  constructor
  · intro hq
    have h1 : Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((q + 12 : ℚ) : ℂ)) = 1 := by
      rw [h, hq]; ring
    obtain ⟨n, hn⟩ := (exp_pi_div_twelve_eq_one_iff _).mp h1
    exact ⟨n - 1, by push_cast; linarith⟩
  · rintro ⟨n, hn⟩
    have h1 : Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((q + 12 : ℚ) : ℂ)) = 1 :=
      (exp_pi_div_twelve_eq_one_iff _).mpr ⟨n + 1, by push_cast; linarith⟩
    rw [h] at h1
    exact neg_eq_iff_eq_neg.mp h1

/-- `(−i)^k · exp(πi q/12) = 1` from an explicit witness `q − 6k = 24n`. -/
theorem drk11_eq_one_of {k : ℤ} {q : ℚ} (n : ℤ) (h : q - 6 * k = 24 * n) :
    (-Complex.I) ^ k * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * (q : ℂ)) = 1 := by
  rw [drk11_lhs_eq]
  exact (exp_pi_div_twelve_eq_one_iff _).mpr ⟨n, h⟩

/-- `(−i)^k · exp(πi q/12) = −1` from an explicit witness `q − 6k = 24n + 12`. -/
theorem drk11_eq_neg_one_of {k : ℤ} {q : ℚ} (n : ℤ) (h : q - 6 * k = 24 * n + 12) :
    (-Complex.I) ^ k * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * (q : ℂ)) = -1 := by
  rw [drk11_lhs_eq]
  exact (exp_pi_div_twelve_eq_neg_one_iff _).mpr ⟨n, h⟩

/-- The negation, for the negative controls: no witness ⇒ the value is not `1`. -/
theorem drk11_ne_one_of {k : ℤ} {q : ℚ} (h : ∀ n : ℤ, q - 6 * k ≠ 24 * n) :
    (-Complex.I) ^ k * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * (q : ℂ)) ≠ 1 := by
  rw [drk11_lhs_eq]
  intro hc
  obtain ⟨n, hn⟩ := (exp_pi_div_twelve_eq_one_iff _).mp hc
  exact h n hn

/-- **DRK-11 IS A CONGRUENCE MOD 24.**  With the symbol's value supplied as `ε = ±1`, the node's
complex identity is *equivalent* to an arithmetic statement about `Φ − 6k`.  This is the real
structural content proved in this file. -/
theorem drk11_iff_congr {k : ℤ} {q : ℚ} {ε : ℤ} (hε : ε = 1 ∨ ε = -1) :
    ((-Complex.I) ^ k * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * (q : ℂ)) = ((ε : ℤ) : ℂ))
      ↔ (∃ n : ℤ, q - 6 * k = 24 * n + (if ε = 1 then 0 else 12)) := by
  rcases hε with rfl | rfl
  · rw [drk11_lhs_eq]
    simpa using exp_pi_div_twelve_eq_one_iff (q - 6 * k)
  · rw [drk11_lhs_eq]
    have : ((-1 : ℤ) : ℂ) = -1 := by push_cast; ring
    rw [this, if_neg (by norm_num : ¬((-1 : ℤ) = 1))]
    exact exp_pi_div_twelve_eq_neg_one_iff (q - 6 * k)

end ExpLayer

/-! ## DRK-11, part 1 — Kronecker-symbol evaluation helpers

Three small unfolding lemmas that run 3 did not need.  They are what makes the pins below
kernel-checkable at `d = 0`, `d = ±1` and `d` even. -/

section KroneckerEval

private lemma pfl_two' : Nat.primeFactorsList 2 = [2] :=
  Nat.primeFactorsList_prime (by norm_num)

/-- `(a / 1) = 1`: the empty product. -/
theorem kroneckerSym_one_right (a : ℤ) : kroneckerSym a 1 = 1 := by
  rw [kroneckerSym, if_neg (by norm_num : (1 : ℤ) ≠ 0),
    if_neg (fun h : a < 0 ∧ (1 : ℤ) < 0 => absurd h.2 (by norm_num)), one_mul,
    show ((1 : ℤ)).natAbs = 1 from rfl, Nat.primeFactorsList_one]
  rfl

/-- `(a / −1) = −1` for `a < 0` — the sign branch of the Kronecker symbol, which is exactly what
makes Ligozat's character consistent under `γ ↦ −γ`. -/
theorem kroneckerSym_neg_one_right_of_neg {a : ℤ} (ha : a < 0) : kroneckerSym a (-1) = -1 := by
  rw [kroneckerSym, if_neg (by norm_num : (-1 : ℤ) ≠ 0),
    if_pos ⟨ha, by norm_num⟩, show ((-1 : ℤ)).natAbs = 1 from rfl, Nat.primeFactorsList_one]
  rfl

/-- `(a / −1) = 1` for `a > 0`. -/
theorem kroneckerSym_neg_one_right_of_pos {a : ℤ} (ha : 0 < a) : kroneckerSym a (-1) = 1 := by
  rw [kroneckerSym, if_neg (by norm_num : (-1 : ℤ) ≠ 0),
    if_neg (fun h : a < 0 ∧ (-1 : ℤ) < 0 => absurd h.1 (by omega)),
    show ((-1 : ℤ)).natAbs = 1 from rfl, Nat.primeFactorsList_one]
  rfl

/-- `(−3 / 2) = −1`.  The `χ₈` branch — `jacobiSym` gets this WRONG (`J(−3|2) = 1`), which is
run 3's documented reason for building `kroneckerSym` at all. -/
theorem kroneckerSym_neg_three_two : kroneckerSym (-3) (2 : ℤ) = -1 := by
  rw [kroneckerSym, if_neg (by norm_num : (2 : ℤ) ≠ 0),
    if_neg (fun h : (-3 : ℤ) < 0 ∧ (2 : ℤ) < 0 => absurd h.2 (by norm_num)), one_mul,
    show ((2 : ℤ)).natAbs = 2 from rfl, pfl_two']
  simp only [List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one]
  rw [kroneckerPrime, if_pos rfl]
  decide

/-- `(−3 / −2) = 1`: the sign factor `(−1)` times `χ₈(−3) = −1`. -/
theorem kroneckerSym_neg_three_neg_two : kroneckerSym (-3) (-2 : ℤ) = 1 := by
  rw [kroneckerSym, if_neg (by norm_num : (-2 : ℤ) ≠ 0),
    if_pos ⟨by norm_num, by norm_num⟩,
    show ((-2 : ℤ)).natAbs = 2 from rfl, pfl_two']
  simp only [List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, mul_one]
  rw [kroneckerPrime, if_pos rfl]
  decide

end KroneckerEval

/-! ## DRK-11, part 2 — THE SIGN-DISCIPLINE GATE

Eleven pins of the **node's exact conclusion** at explicit `(N, r, k, γ)`, and four negative
controls.  Nothing below the gate may be used above it, and no general lemma about the node has
been stated yet, so no pin can be discharged by the theory it guards.

Every `Φ` value was computed independently in Python (`fractions.Fraction`, `Int.fract`,
`dedekindSaw`, `dedekindSum`, `etaPhiSum` re-implemented from the Lean SOURCE, and first checked
against all of `DedekindSum.lean`'s and `EtaPhiSum.lean`'s existing `decide +kernel` pins, which
it reproduces exactly) BEFORE any Lean was written, together with a floating-point evaluation of
`(−i)^k e^{πiΦ/12}` and of the Kronecker symbol.  The same sweep verified the node's statement at
several hundred matrices of `Γ₀(N)` with `c > 0` for `N ∈ {1,2,3,4,5,6,7,11}` with zero
mismatches.

COVERAGE, deliberately: `k` even (`12, 2, 8`), `k` odd (`3`), `k = 0`, `k` NEGATIVE (`−3`);
`c` odd (`1,3,5,7,11`) and `c` even (`2,4`); `d = 0`, `d > 0` odd, `d > 0` even, `d < 0` odd,
`d < 0` even; negative exponents `r_δ`; and both symbol values `+1` and `−1`. -/

section SignDisciplineGate

/-- `N = 1`, `f = η²⁴ = Δ`, `k = 12`. -/
def drk11R1 : EtaExp := fun _ => 24

/-- `N = 11`, `r = (2,2)`, `k = 2` — FLT's `etaProductEleven`. -/
def drk11R11 : EtaExp := fun d => if d = 1 then 2 else if d = 11 then 2 else 0

/-- `N = 3`, `r = (−3, 9)`, `k = 3`: ODD weight, NEGATIVE exponent, numerator `−19683 < 0`. -/
def drk11R3 : EtaExp := fun d => if d = 1 then -3 else if d = 3 then 9 else 0

/-- `N = 3`, `r = (3, −9)`, `k = −3`: NEGATIVE weight. -/
def drk11R3' : EtaExp := fun d => if d = 1 then 3 else if d = 3 then -9 else 0

/-- `N = 7`, `r = (3,3)`, `k = 3`. -/
def drk11R7 : EtaExp := fun d => if d = 1 then 3 else if d = 7 then 3 else 0

/-- `N = 2`, `r = (8,8)`, `k = 8`. -/
def drk11R2 : EtaExp := fun d => if d = 1 then 8 else if d = 2 then 8 else 0

/-- `N = 4`, `r = (−8, 32, −8)`, `k = 8`: two negative exponents, numerator `2⁴⁸`. -/
def drk11R4 : EtaExp :=
  fun d => if d = 1 then -8 else if d = 2 then 32 else if d = 4 then -8 else 0

/-- `N = 5`, `r = (6, −6)`, `k = 0`: WEIGHT ZERO. -/
def drk11R5 : EtaExp := fun d => if d = 1 then 6 else if d = 5 then -6 else 0

/-- NEGATIVE CONTROL vector: `N = 8`, `r = (4,4,4,−4)`.  `Σ δ r_δ = −4` and `Σ (8/δ) r_δ = 52`,
so BOTH Ligozat congruences fail. -/
def drk11R8bad : EtaExp :=
  fun d => if d = 1 then 4 else if d = 2 then 4 else if d = 4 then 4 else if d = 8 then -4 else 0

/-- NEGATIVE CONTROL vector: `N = 12`, `r ≡ 2`.  `Σ δ r_δ = Σ (12/δ) r_δ = 56`, so both
congruences fail. -/
def drk11R12bad : EtaExp := fun _ => 2

def drk11MatS : SL(2, ℤ) := slOf 0 (-1) 1 0 (by decide)
def drk11MatN11 : SL(2, ℤ) := slOf 3 1 11 4 (by decide)
def drk11MatN3a : SL(2, ℤ) := slOf 1 0 3 1 (by decide)
def drk11MatN3b : SL(2, ℤ) := slOf 2 1 3 2 (by decide)
def drk11MatN3c : SL(2, ℤ) := slOf 1 (-1) 3 (-2) (by decide)
def drk11MatN3d : SL(2, ℤ) := slOf (-1) 0 3 (-1) (by decide)
def drk11MatN7 : SL(2, ℤ) := slOf 3 2 7 5 (by decide)
def drk11MatN2 : SL(2, ℤ) := slOf 1 0 2 1 (by decide)
def drk11MatN4 : SL(2, ℤ) := slOf 1 0 4 1 (by decide)
def drk11MatN5 : SL(2, ℤ) := slOf 2 1 5 3 (by decide)
def drk11MatN8 : SL(2, ℤ) := slOf 1 0 8 1 (by decide)
def drk11MatN12 : SL(2, ℤ) := slOf 1 0 12 1 (by decide)
def drk11MatT : SL(2, ℤ) := slOf 1 1 0 1 (by decide)

/-! ### Kernel evaluations of `etaPhiSum` and `ligozatKroneckerNum` -/

theorem drk11_phi_S : etaPhiSum 1 drk11R1 drk11MatS = 0 := by decide +kernel
theorem drk11_phi_N11 : etaPhiSum 11 drk11R11 drk11MatN11 = 12 := by decide +kernel
theorem drk11_phi_N3a : etaPhiSum 3 drk11R3 drk11MatN3a = 18 := by decide +kernel
theorem drk11_phi_N3b : etaPhiSum 3 drk11R3 drk11MatN3b = 30 := by decide +kernel
theorem drk11_phi_N3c : etaPhiSum 3 drk11R3 drk11MatN3c = -6 := by decide +kernel
theorem drk11_phi_N3d : etaPhiSum 3 drk11R3 drk11MatN3d = -18 := by decide +kernel
theorem drk11_phi_N3d' : etaPhiSum 3 drk11R3' drk11MatN3d = 18 := by decide +kernel
theorem drk11_phi_N7 : etaPhiSum 7 drk11R7 drk11MatN7 = 30 := by decide +kernel
theorem drk11_phi_N2 : etaPhiSum 2 drk11R2 drk11MatN2 = 24 := by decide +kernel
theorem drk11_phi_N4 : etaPhiSum 4 drk11R4 drk11MatN4 = 24 := by decide +kernel
theorem drk11_phi_N5 : etaPhiSum 5 drk11R5 drk11MatN5 = -24 := by decide +kernel
theorem drk11_phi_N8bad : etaPhiSum 8 drk11R8bad drk11MatN8 = -28 := by decide +kernel
theorem drk11_phi_N12bad : etaPhiSum 12 drk11R12bad drk11MatN12 = -20 := by decide +kernel
theorem drk11_phi_T : etaPhiSum 3 drk11R3 drk11MatT = 0 := by decide +kernel

theorem drk11_num_S : ligozatKroneckerNum 1 drk11R1 12 = 1 := by decide
theorem drk11_num_N11 : ligozatKroneckerNum 11 drk11R11 2 = 121 := by decide
theorem drk11_num_N3 : ligozatKroneckerNum 3 drk11R3 3 = -19683 := by decide
theorem drk11_num_N3' : ligozatKroneckerNum 3 drk11R3' (-3) = -19683 := by decide
theorem drk11_num_N7 : ligozatKroneckerNum 7 drk11R7 3 = -343 := by decide
theorem drk11_num_N2 : ligozatKroneckerNum 2 drk11R2 8 = 256 := by decide
theorem drk11_num_N4 : ligozatKroneckerNum 4 drk11R4 8 = 281474976710656 := by decide
theorem drk11_num_N5 : ligozatKroneckerNum 5 drk11R5 0 = 15625 := by decide
theorem drk11_num_N8bad : ligozatKroneckerNum 8 drk11R8bad 4 = 16777216 := by decide
theorem drk11_num_N12bad : ligozatKroneckerNum 12 drk11R12bad 6 = 2985984 := by decide

/-! ### The lower-right entries -/

theorem drk11_d_S : drk11MatS 1 1 = 0 := by decide
theorem drk11_d_N11 : drk11MatN11 1 1 = 4 := by decide
theorem drk11_d_N3a : drk11MatN3a 1 1 = 1 := by decide
theorem drk11_d_N3b : drk11MatN3b 1 1 = 2 := by decide
theorem drk11_d_N3c : drk11MatN3c 1 1 = -2 := by decide
theorem drk11_d_N3d : drk11MatN3d 1 1 = -1 := by decide
theorem drk11_d_N7 : drk11MatN7 1 1 = 5 := by decide
theorem drk11_d_N2 : drk11MatN2 1 1 = 1 := by decide
theorem drk11_d_N4 : drk11MatN4 1 1 = 1 := by decide
theorem drk11_d_N5 : drk11MatN5 1 1 = 3 := by decide
theorem drk11_d_N8 : drk11MatN8 1 1 = 1 := by decide
theorem drk11_d_N12 : drk11MatN12 1 1 = 1 := by decide
theorem drk11_d_T : drk11MatT 1 1 = 1 := by decide

/-! ### The symbol values -/

theorem drk11_sym_S : kroneckerSym 1 (0 : ℤ) = 1 := kroneckerSym_one_left 0

theorem drk11_sym_N11 : kroneckerSym 121 (4 : ℤ) = 1 := by
  rw [show (121 : ℤ) = 11 ^ 2 by norm_num]
  exact kroneckerSym_sq_of_gcd (by decide)

theorem drk11_sym_N3a : kroneckerSym (-19683) (1 : ℤ) = 1 := kroneckerSym_one_right _

theorem drk11_sym_N3b : kroneckerSym (-19683) (2 : ℤ) = -1 := by
  rw [show (-19683 : ℤ) = (-3) * ((3 : ℤ) ^ 4) ^ 2 by norm_num,
    kroneckerSym_mul_left (by norm_num) (by norm_num),
    kroneckerSym_sq_of_gcd (by decide), kroneckerSym_neg_three_two, mul_one]

theorem drk11_sym_N3c : kroneckerSym (-19683) (-2 : ℤ) = 1 := by
  rw [show (-19683 : ℤ) = (-3) * ((3 : ℤ) ^ 4) ^ 2 by norm_num,
    kroneckerSym_mul_left (by norm_num) (by norm_num),
    kroneckerSym_sq_of_gcd (by decide), kroneckerSym_neg_three_neg_two, mul_one]

theorem drk11_sym_N3d : kroneckerSym (-19683) (-1 : ℤ) = -1 :=
  kroneckerSym_neg_one_right_of_neg (by norm_num)

theorem drk11_sym_N7 : kroneckerSym (-343) (5 : ℤ) = -1 := by
  rw [show (5 : ℤ) = ((5 : ℕ) : ℤ) from rfl,
    kroneckerSym_eq_jacobiSym_of_odd' (by decide)]
  norm_num

theorem drk11_sym_N2 : kroneckerSym 256 (1 : ℤ) = 1 := kroneckerSym_one_right _
theorem drk11_sym_N4 : kroneckerSym 281474976710656 (1 : ℤ) = 1 := kroneckerSym_one_right _

theorem drk11_sym_N5 : kroneckerSym 15625 (3 : ℤ) = 1 := by
  rw [show (3 : ℤ) = ((3 : ℕ) : ℤ) from rfl,
    kroneckerSym_eq_jacobiSym_of_odd' (by decide)]
  norm_num

theorem drk11_sym_N8bad : kroneckerSym 16777216 (1 : ℤ) = 1 := kroneckerSym_one_right _
theorem drk11_sym_N12bad : kroneckerSym 2985984 (1 : ℤ) = 1 := kroneckerSym_one_right _

/-! ### THE ELEVEN PINS — each is the node's conclusion, verbatim, at explicit data -/

/-- PIN 1/11 — `N = 1`, `Δ = η²⁴`, `k = 12`, `γ = S`, `c = 1`, `d = 0` (the `(a/0)` branch of
the Kronecker symbol).  `Φ = 0`, `Φ − 6k = −72 = 24·(−3)`, symbol `= 1`. -/
theorem drk11_pin_N1_S :
    (-Complex.I) ^ (12 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 1 drk11R1 drk11MatS : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 1 drk11R1 12) (drk11MatS 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_S, drk11_num_S, drk11_d_S, drk11_sym_S,
    drk11_eq_one_of (-3) (by norm_num)]
  norm_num

/-- PIN 2/11 — `N = 11`, `r = (2,2)`, `k = 2`, `c = 11`, `d = 4` EVEN.  `Φ = 12`, `Φ − 6k = 0`,
symbol `= (11²/4) = 1`.

This is the `(N, r, k)` of FLT's `ModularForm.etaProductEleven_transform` (fetched
2026-09-08, HTTP 200, 936 B), which reads
`η(γτ)²·η(11γτ)² = denom(γ,τ)²·(η(τ)²·η(11τ)²)` for `γ ∈ Γ₀(11)` — i.e. the multiplier is
identically `1`, which is what the symbol `(121/d) = (11²/d) = 1` says.  Two honest differences:
FLT proves the full transformation law on ALL of `Γ₀(11)` (no `c > 0`), whereas this is one
`γ` and a statement about `etaPhiSum`; and the proof here is our own kernel evaluation, not
FLT's `p2m_exact_reverting`. -/
theorem drk11_pin_N11_even_d :
    (-Complex.I) ^ (2 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 11 drk11R11 drk11MatN11 : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 11 drk11R11 2) (drk11MatN11 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N11, drk11_num_N11, drk11_d_N11, drk11_sym_N11,
    drk11_eq_one_of 0 (by norm_num)]
  norm_num

/-- PIN 3/11 — `N = 3`, `r = (−3, 9)`, `k = 3` ODD, `d = 1`.  `Φ = 18`, `Φ − 6k = 0`.
Both `(−i)³ = i` and `e^{18πi/12} = −i` are nontrivial and cancel: a pin that a wrong sign
anywhere in `etaPhiSum` or in `(−i)^k` would break. -/
theorem drk11_pin_N3_odd_k :
    (-Complex.I) ^ (3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 3 drk11R3 drk11MatN3a : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 3 drk11R3 3) (drk11MatN3a 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N3a, drk11_num_N3, drk11_d_N3a, drk11_sym_N3a,
    drk11_eq_one_of 0 (by norm_num)]
  norm_num

/-- PIN 4/11 — same form, `d = 2` EVEN, symbol `= −1` (the `χ₈` branch).  `Φ = 30`,
`Φ − 6k = 12`. -/
theorem drk11_pin_N3_even_d :
    (-Complex.I) ^ (3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 3 drk11R3 drk11MatN3b : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 3 drk11R3 3) (drk11MatN3b 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N3b, drk11_num_N3, drk11_d_N3b, drk11_sym_N3b,
    drk11_eq_neg_one_of 0 (by norm_num)]
  norm_num

/-- PIN 5/11 — `d = −2`: NEGATIVE and EVEN, so both the sign factor and `χ₈` are exercised.
`Φ = −6`, `Φ − 6k = −24`, symbol `= 1`. -/
theorem drk11_pin_N3_neg_even_d :
    (-Complex.I) ^ (3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 3 drk11R3 drk11MatN3c : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 3 drk11R3 3) (drk11MatN3c 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N3c, drk11_num_N3, drk11_d_N3c, drk11_sym_N3c,
    drk11_eq_one_of (-1) (by norm_num)]
  norm_num

/-- PIN 6/11 — `d = −1`: the pure sign branch, symbol `= −1`.  `Φ = −18`, `Φ − 6k = −36
= 24·(−2) + 12`. -/
theorem drk11_pin_N3_neg_odd_d :
    (-Complex.I) ^ (3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 3 drk11R3 drk11MatN3d : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 3 drk11R3 3) (drk11MatN3d 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N3d, drk11_num_N3, drk11_d_N3d, drk11_sym_N3d,
    drk11_eq_neg_one_of (-2) (by norm_num)]
  push_cast
  ring

/-- PIN 7/11 — `k = −3`, NEGATIVE weight, `r = (3, −9)`, `d = −1`.  `Φ = 18`,
`Φ − 6k = 36 = 24 + 12`, symbol `= −1`.  `(−i)^{−3} = −i` is a genuine `zpow` at a negative
exponent. -/
theorem drk11_pin_N3_neg_k :
    (-Complex.I) ^ (-3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 3 drk11R3' drk11MatN3d : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 3 drk11R3' (-3)) (drk11MatN3d 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N3d', drk11_num_N3', drk11_d_N3d, drk11_sym_N3d,
    drk11_eq_neg_one_of 1 (by norm_num)]
  push_cast
  ring

/-- PIN 8/11 — `N = 7`, `c = 7` odd, `d = 5` odd, symbol `= J(−343|5) = −1` (the `jacobiSym`
branch, via `kroneckerSym_eq_jacobiSym_of_odd'`).  `Φ = 30`, `Φ − 6k = 12`. -/
theorem drk11_pin_N7_odd_c :
    (-Complex.I) ^ (3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 7 drk11R7 drk11MatN7 : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 7 drk11R7 3) (drk11MatN7 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N7, drk11_num_N7, drk11_d_N7, drk11_sym_N7,
    drk11_eq_neg_one_of 0 (by norm_num)]
  push_cast
  ring

/-- PIN 9/11 — `N = 2`, `c = 2` EVEN, `k = 8`.  `Φ = 24`, `Φ − 6k = −24`. -/
theorem drk11_pin_N2_even_c :
    (-Complex.I) ^ (8 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 2 drk11R2 drk11MatN2 : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 2 drk11R2 8) (drk11MatN2 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N2, drk11_num_N2, drk11_d_N2, drk11_sym_N2,
    drk11_eq_one_of (-1) (by norm_num)]
  norm_num

/-- PIN 10/11 — `N = 4`, `r = (−8, 32, −8)`: TWO negative exponents, numerator `2⁴⁸`, `c = 4`
even.  `Φ = 24`, `Φ − 6k = −24`. -/
theorem drk11_pin_N4_neg_exp :
    (-Complex.I) ^ (8 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 4 drk11R4 drk11MatN4 : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 4 drk11R4 8) (drk11MatN4 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N4, drk11_num_N4, drk11_d_N4, drk11_sym_N4,
    drk11_eq_one_of (-1) (by norm_num)]
  norm_num

/-- PIN 11/11 — `N = 5`, WEIGHT ZERO (`k = 0`, so `(−i)^k = 1` and the whole burden is on `Φ`),
`c = 5`, `d = 3`.  `Φ = −24`, `Φ − 6k = −24`. -/
theorem drk11_pin_N5_k_zero :
    (-Complex.I) ^ (0 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 5 drk11R5 drk11MatN5 : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum 5 drk11R5 0) (drk11MatN5 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N5, drk11_num_N5, drk11_d_N5, drk11_sym_N5,
    drk11_eq_one_of (-1) (by norm_num)]
  norm_num

/-! ### FOUR NEGATIVE CONTROLS -/

/-- **NEGATIVE CONTROL 1/4 — Ligozat's congruences are LOAD-BEARING.**  `N = 8`,
`r = (4,4,4,−4)`, `k = 4`: `Σ r_δ = 8 = 2k` holds, `γ = !![1,0;8,1] ∈ Γ₀(8)` with `c = 8 > 0`,
but `Σ δ r_δ = −4` (congruence (i) FAILS) and `Σ (8/δ) r_δ = 52` (congruence (ii) FAILS).
`Φ = −28`, `Φ − 6k = −52 ≢ 0, 12 (mod 24)`, while the symbol is `1`.  The two sides differ. -/
theorem drk11_neg_control_congr_needed :
    (-Complex.I) ^ (4 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 8 drk11R8bad drk11MatN8 : ℚ) : ℂ))
      ≠ ((kroneckerSym (ligozatKroneckerNum 8 drk11R8bad 4) (drk11MatN8 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N8bad, drk11_num_N8bad, drk11_d_N8, drk11_sym_N8bad]
  have h : ((1 : ℤ) : ℂ) = 1 := by norm_num
  rw [h]
  refine drk11_ne_one_of ?_
  intro n hn
  have : (24 * n : ℤ) = -52 := by exact_mod_cast hn.symm
  omega

/-- **NEGATIVE CONTROL 2/4 — the same, at a level where BOTH congruence sums are `56`.**
`N = 12`, `r ≡ 2`, `k = 6`, `γ = !![1,0;12,1]`.  `Φ = −20`, `Φ − 6k = −56`. -/
theorem drk11_neg_control_congr_needed_twelve :
    (-Complex.I) ^ (6 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 12 drk11R12bad drk11MatN12 : ℚ) : ℂ))
      ≠ ((kroneckerSym (ligozatKroneckerNum 12 drk11R12bad 6) (drk11MatN12 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_N12bad, drk11_num_N12bad, drk11_d_N12, drk11_sym_N12bad]
  have h : ((1 : ℤ) : ℂ) = 1 := by norm_num
  rw [h]
  refine drk11_ne_one_of ?_
  intro n hn
  have : (24 * n : ℤ) = -56 := by exact_mod_cast hn.symm
  omega

/-- **NEGATIVE CONTROL 3/4 — `hc : 0 < c` IS LOAD-BEARING (LL-1).**  Take the level-3 odd-weight
form `r = (−3, 9)`, `k = 3`, which satisfies `hk`, `h1` and `h2`, and `γ = T ∈ Γ₀(3)` — every
hypothesis of the node holds EXCEPT `c > 0` (`c = 0`).  Then `Φ = 0` (this is DRK-09's
`etaPhiSum_of_lower_left_zero` in the concrete), so the left side collapses to `(−i)³ = i`,
while the symbol is `(−19683 / 1) = 1`.

Consequence, stated so it cannot be misread: **proving DRK-11 does not give Ligozat's criterion
on `Γ₀(N)`.**  The `c < 0` reduction (DRK-08) and the `c = 0` case `γ = ±Tⁿ` are still required
for `ETA-01`. -/
theorem drk11_neg_control_c_zero :
    (-Complex.I) ^ (3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 3 drk11R3 drk11MatT : ℚ) : ℂ))
      ≠ ((kroneckerSym (ligozatKroneckerNum 3 drk11R3 3) (drk11MatT 1 1) : ℤ) : ℂ) := by
  rw [drk11_phi_T, drk11_num_N3, drk11_d_T, drk11_sym_N3a]
  have h : ((1 : ℤ) : ℂ) = 1 := by norm_num
  rw [h]
  refine drk11_ne_one_of ?_
  intro n hn
  have : (24 * n : ℤ) = -18 := by exact_mod_cast hn.symm
  omega

/-- **NEGATIVE CONTROL 4/4 — the `(−1)^k` factor of `ligozatKroneckerNum` is LOAD-BEARING.**
At `N = 3`, `r = (−3, 9)`, `k = 3`, `d = −1` the true symbol is `(−19683 / −1) = −1`; the
sign-free mutant numerator `∏ δ^{|r_δ|} = 19683` gives `(19683 / −1) = +1`.  So the `(−1)^k`
is not decoration: it is what makes the character consistent under `γ ↦ −γ`. -/
theorem drk11_neg_control_drop_sign :
    kroneckerSym (∏ δ ∈ (3 : ℕ).divisors, (δ : ℤ) ^ (drk11R3 δ).natAbs) (-1 : ℤ)
      ≠ kroneckerSym (ligozatKroneckerNum 3 drk11R3 3) (-1 : ℤ) := by
  rw [drk11_num_N3, drk11_sym_N3d,
    show (∏ δ ∈ (3 : ℕ).divisors, (δ : ℤ) ^ (drk11R3 δ).natAbs) = 19683 from by decide,
    kroneckerSym_neg_one_right_of_pos (by norm_num)]
  norm_num

end SignDisciplineGate

/-! ## DRK-11, part 3 — what IS proved of the node

`0 < N ≤ 4`, all of `Γ₀(N)` with `c > 0`. -/

/-- **DRK-11 for `0 < N ≤ 4`, PROVED.**  The node's exact conclusion on a nonempty domain.

The proof is a two-line composition and that is the point: DRK-09
(`etaMultiplierVal_eq_exp_etaPhiSum`) says the left side IS the multiplier `w(γ)`, and run 3's
F3.2-B3 (`multiplier_eq_kronecker_of_le_four`) says `w(γ)` IS Ligozat's symbol at levels
`N ≤ 4`.  No new mathematics — but it certifies that the node's statement, signs and all, is the
same proposition run 3 proved, and it is what the eleven pins are instances of at `N ≤ 4`. -/
theorem exp_etaPhiSum_eq_kroneckerSym_of_le_four {N : ℕ} (hN : 0 < N) (hN4 : N ≤ 4)
    (r : EtaExp) {k : ℤ} (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) (hc : 0 < γ 1 0) :
    (-Complex.I) ^ k
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((etaPhiSum N r γ : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum N r k) (γ 1 1) : ℤ) : ℂ) := by
  have hval := etaMultiplierVal_eq_exp_etaPhiSum r hk hγ hc
  have hkr := multiplier_eq_kronecker_of_le_four hN hN4 r hk h1 h2 ⟨γ, hγ⟩
  rw [coe_etaMultiplierHom] at hkr
  rw [← hval]
  exact hkr

/-! ### CONSISTENCY TRIPWIRES (LL-2)

The general theorem, instantiated at two of the gate's own instances, must reproduce the
independently computed values.  If `exp_etaPhiSum_eq_kroneckerSym_of_le_four` ever drifts — a
sign in `(-i)^k`, an off-by-`δ` in `etaPhiSum`, a wrong branch of `kroneckerSym` — these break,
because the pins were computed outside Lean and the general theorem is proved inside it. -/

theorem drk11R3_sum : ∑ δ ∈ (3 : ℕ).divisors, drk11R3 δ = 2 * 3 := by decide

theorem drk11R3_congr1 : LigozatCongr1 3 drk11R3 := by
  have h : ∑ δ ∈ (3 : ℕ).divisors, (δ : ℤ) * drk11R3 δ = 24 := by decide
  exact ⟨1, by rw [h]; ring⟩

theorem drk11R3_congr2 : LigozatCongr2 3 drk11R3 := by
  have h : ∑ δ ∈ (3 : ℕ).divisors, ((3 / δ : ℕ) : ℤ) * drk11R3 δ = 0 := by decide
  exact ⟨0, by rw [h]; ring⟩

theorem drk11MatN3a_mem : drk11MatN3a ∈ Gamma0 3 := by
  rw [Gamma0_mem, show drk11MatN3a 1 0 = 3 from by decide]
  decide

theorem drk11MatN3b_mem : drk11MatN3b ∈ Gamma0 3 := by
  rw [Gamma0_mem, show drk11MatN3b 1 0 = 3 from by decide]
  decide

/-- **TRIPWIRE 1** — the general theorem at `N = 3`, `d = 1`, symbol `+1`, reproduces
`drk11_pin_N3_odd_k`. -/
theorem drk11_general_matches_pin_N3_odd_k :
    (-Complex.I) ^ (3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 3 drk11R3 drk11MatN3a : ℚ) : ℂ)) = 1 := by
  have h := exp_etaPhiSum_eq_kroneckerSym_of_le_four (N := 3) (by norm_num) (by norm_num)
    drk11R3 drk11R3_sum drk11R3_congr1 drk11R3_congr2 drk11MatN3a_mem
    (by rw [show drk11MatN3a 1 0 = 3 from by decide]; norm_num)
  rw [h, drk11_num_N3, drk11_d_N3a, drk11_sym_N3a]
  norm_num

/-- **TRIPWIRE 2** — the general theorem at `N = 3`, `d = 2` EVEN, symbol `−1`, reproduces
`drk11_pin_N3_even_d`.  This is the one that would catch a `χ₈`-branch error. -/
theorem drk11_general_matches_pin_N3_even_d :
    (-Complex.I) ^ (3 : ℤ)
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12
          * ((etaPhiSum 3 drk11R3 drk11MatN3b : ℚ) : ℂ)) = -1 := by
  have h := exp_etaPhiSum_eq_kroneckerSym_of_le_four (N := 3) (by norm_num) (by norm_num)
    drk11R3 drk11R3_sum drk11R3_congr1 drk11R3_congr2 drk11MatN3b_mem
    (by rw [show drk11MatN3b 1 0 = 3 from by decide]; norm_num)
  rw [h, drk11_num_N3, drk11_d_N3b, drk11_sym_N3b]
  norm_num

/-! ## DRK-11, part 4 — the node, general `N`

UNPROVED.  See the `-- OPEN:` comment. -/

set_option linter.unusedVariables false in
/-- **DRK-11 (the node), general `N` — NOT PROVED.**

`(-i)^k · exp(πi/12 · Φ_N(r,γ)) = ((-1)^k ∏_{δ ∣ N} δ^{r_δ} / γ₁₁)` for `γ ∈ Γ₀(N)`, `c > 0`.

By `drk11_iff_congr` this is EQUIVALENT to `Φ_N(r,γ) − 6k ≡ 0 or 12 (mod 24)` according to the
sign of the symbol; the pins above verify it at eleven explicit instances and
`exp_etaPhiSum_eq_kroneckerSym_of_le_four` proves it for `0 < N ≤ 4`.

`hN : 0 < N` is INERT (`Gamma0 0` forces `c = 0`, contradicting `hc`); it is carried because the
node carries it. -/
theorem exp_etaPhiSum_eq_kroneckerSym {N : ℕ} (hN : 0 < N) (r : EtaExp) {k : ℤ}
    (hk : ∑ δ ∈ N.divisors, r δ = 2 * k)
    (h1 : LigozatCongr1 N r) (h2 : LigozatCongr2 N r)
    {γ : SL(2, ℤ)} (hγ : γ ∈ Gamma0 N) (hc : 0 < γ 1 0) :
    (-Complex.I) ^ k
      * Complex.exp ((Real.pi : ℂ) * Complex.I / 12 * ((etaPhiSum N r γ : ℚ) : ℂ))
      = ((kroneckerSym (ligozatKroneckerNum N r k) (γ 1 1) : ℤ) : ℂ) := by
  -- OPEN: general `N`.  `drk11_iff_congr` reduces this to `etaPhiSum N r γ - 6*k ≡ 0 or 12
  -- (mod 24)`.
  -- OPEN: A SINGLE SUFFICIENT INPUT, named precisely (added 2026-09-08 by the ETA-01 run; it is
  -- OPEN: NOT proved anywhere here).  The PETERSSON CLOSED FORM FOR `Φ` MOD 24: for
  -- OPEN: `γ = !![a,b;c,d] ∈ SL(2,ℤ)` with `c > 0`,
  -- OPEN:   c ODD :  Φ(γ) ≡ (a+d)c - b d (c²-1) - 3c + 3 + 12·[(d|c) = -1]   (mod 24),
  -- OPEN:   c EVEN:  Φ(γ) ≡ (a+d)c - b d (c²-1) + 3d - 3cd + 12·[(c|d) = -1] (mod 24).
  -- OPEN: Both branches were checked in python3 (exact `Fraction`; `Φ` and `dedekindSum`
  -- OPEN: re-implemented from the Lean source) at 4857 odd-`c` and 1686 even-`c` matrices with
  -- OPEN: `c = 1..24`, `d = -20..20`: ZERO mismatches.  Given it, what remains here is the
  -- OPEN: divisor-by-divisor collection: summing over `δ ∣ N` with `c_δ = c/δ`, the `+3` of the
  -- OPEN: odd branch cancels EXACTLY against `6k = 3·Σ_δ r_δ`, which is the structural reason
  -- OPEN: `h1` and `h2` are the right hypotheses.  Proving the Petersson form is a Euclidean
  -- OPEN: induction on `c` (base `c = 1`: `s(d,1) = 0`, `Φ = a+d`; step: `DRK-04`
  -- OPEN: `rademacher_phi_step`) with quadratic reciprocity on the symbol side; it is a run of
  -- OPEN: its own, and it is NOT attempted here.
  -- OPEN: In the shape this file's inputs currently have it, the two missing pieces are:
  -- (1) an EVEN-modulus companion to DRK-10 (`dedekindSum_jacobiSym_mod_eight`, which is
  --     `Odd k`-only) evaluating `12·c_δ·s(d, c_δ)` mod 8 when `2 ∣ c_δ = γ₁₀/δ`; without it
  --     every level with `2 ∣ N`, and every odd level at an even `c`, is untouched;
  -- (2) the reciprocity assembly: DRK-10 yields `(d | c_δ)` (numerator `d`), Ligozat's
  --     character is `(δ | γ₁₁)` (numerator `δ`), so `jacobiSym.quadratic_reciprocity` must be
  --     applied divisor-by-divisor and the `(-1)^{((p-1)/2)((q-1)/2)}` signs collected against
  --     `hk`, `h1` (`24 ∣ Σ δ r_δ`) and `h2` (`24 ∣ Σ (N/δ) r_δ`).
  -- `F3.2-OBSTRUCTED` therefore stands, and `ETA-01` is NOT resolved by this file.
  sorry

end SocrateAI.ModularForms
