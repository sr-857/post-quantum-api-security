# Frequently Asked Questions

## Why PQC?

Shor's algorithm gives a sufficiently large, fault-tolerant quantum
computer a polynomial-time method for solving integer factorization and
the discrete logarithm problem — the two hard problems underlying RSA and
elliptic-curve cryptography respectively. If such a computer is built,
every system relying solely on these classical primitives becomes
insecure against a quantum-capable adversary. Post-quantum cryptography
(PQC) replaces these primitives with ones believed to resist both
classical and quantum cryptanalysis (currently, primarily lattice-based
and hash-based constructions).

The more time-sensitive reason is the **harvest-now, decrypt-later**
(HNDL) threat: an adversary doesn't need a quantum computer today to
benefit from one in the future. They can record encrypted traffic now and
decrypt it retroactively once a quantum computer exists. This means
migration urgency depends on how long your data needs to remain
confidential, not on how far away a quantum computer is — see Mosca's
risk framework, summarized in `docs/bibliography.md`.

## Why Hybrid TLS?

Two independent risks motivate combining a classical and a post-quantum
algorithm rather than switching outright:

1. **Newly standardized post-quantum algorithms could have undiscovered
   weaknesses.** ML-KEM and ML-DSA are recent standards (finalized 2024)
   relative to decades of cryptanalysis on RSA and elliptic curves. A
   hybrid construction remains secure if the classical component is
   still sound, even if a flaw is later found in the post-quantum
   component.
2. **Classical algorithms remain vulnerable to a future quantum
   computer.** A hybrid construction remains secure if the post-quantum
   component is sound, even after a CRQC arrives and breaks the classical
   component.

A correctly designed hybrid combiner is secure if *either* component
remains unbroken, which is a strictly stronger guarantee during this
transition period than committing fully to either approach alone. This is
also the approach recommended by NSA CNSA 2.0 guidance and the
IETF TLS working group's hybrid key-exchange draft.

## Why ML-KEM?

ML-KEM (FIPS 203) was selected as NIST's primary standardized key
encapsulation mechanism following a multi-year public evaluation process
involving extensive cryptanalysis from the academic community. Its
security relies on the Module Learning With Errors (MLWE) problem, which
has a substantial body of supporting hardness analysis. Practically,
ML-KEM also offers a favorable balance of key size, ciphertext size, and
computational performance relative to other PQC KEM candidates evaluated
during NIST's standardization rounds, which matters for TLS handshake
overhead (see Table I in the paper).

## Why Cryptographic Agility?

Standardization is not the end of the story. Cryptographic algorithms get
deprecated — sometimes due to newly discovered weaknesses, sometimes due
to evolving compliance requirements. SHA-1 and MD5's deprecation
timelines are the most familiar classical-era examples. There is no
strong reason to assume ML-KEM, ML-DSA, or SLH-DSA will be permanent
fixtures on an infinite time horizon, even though they are currently the
best-vetted standardized options available.

Designing for cryptographic agility — protocol-level algorithm
identifiers, configuration-driven selection, no hard-coded size
assumptions — means that *if* a future transition is needed, it does not
require repeating the full architectural migration described in this
paper. It is cheaper to build this in now than to retrofit it later under
time pressure.

## Future Directions

This paper is explicitly scoped as an architectural and migration
analysis, not an empirical performance study. The research roadmap in
`CHANGELOG.md` outlines planned future work:

- **Empirical benchmarking** of hybrid TLS handshake latency under
  representative API workloads, to move from the qualitative discussion
  in Section V/VIII of the paper to measured figures.
- **Prototype implementation** of the gateway-layer migration patterns
  described in Section IV, likely built on OpenSSL + the Open Quantum
  Safe (`liboqs`) provider.
- **Composite certificate interoperability testing**, once IETF LAMPS
  standardization and library support mature further.
- **Conference and journal submission** of an extended version
  incorporating the above empirical results.

If you're interested in contributing to any of this future work, see
[`CONTRIBUTING.md`](../CONTRIBUTING.md) and the placeholder scope in
[`implementation/README.md`](../implementation/README.md).

## Is this paper a complete security audit framework?

No. As stated in the threat model (`docs/threat-model.md`), this work
does not address implementation-level side channels, denial-of-service,
application-layer vulnerabilities unrelated to cryptographic algorithm
choice, or physical/insider threats to certificate authorities. It is
scoped specifically to the architectural question of migrating API
cryptography to post-quantum primitives.

## Does this repository contain working code?

Not yet. The current release is a research paper and its accompanying
documentation. The `implementation/` directory reserves scope for future
prototype and benchmark code, tracked via the roadmap in
`CHANGELOG.md`. If you were looking for a ready-to-use PQC TLS library,
consider the [Open Quantum Safe project](https://openquantumsafe.org)
(`liboqs`) referenced throughout this paper.
