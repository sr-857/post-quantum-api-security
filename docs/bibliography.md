# Bibliography

This document summarizes the major standards and references underlying
the paper's analysis. Full BibTeX entries are in
[`paper/references.bib`](../paper/references.bib).

## NIST Post-Quantum Cryptography Standards

### FIPS 203 — Module-Lattice-Based Key-Encapsulation Mechanism Standard

Finalized by NIST in 2024, FIPS 203 standardizes **ML-KEM**, derived from
the CRYSTALS-Kyber submission to NIST's PQC standardization project.
ML-KEM provides key encapsulation based on the Module Learning With
Errors (MLWE) problem, and is the primitive this paper recommends for
hybrid TLS key exchange.

### FIPS 204 — Module-Lattice-Based Digital Signature Standard

Standardizes **ML-DSA**, derived from CRYSTALS-Dilithium, providing
digital signatures based on MLWE combined with the Module Short Integer
Solution (MSIS) problem. Recommended for certificate and JWT signature
migration in this paper's framework.

### FIPS 205 — Stateless Hash-Based Digital Signature Standard

Standardizes **SLH-DSA**, derived from SPHINCS+. Security rests solely on
the collision resistance of the underlying hash function, making it a
conservative fallback should lattice-based assumptions (underlying
ML-KEM/ML-DSA) later prove weaker than currently believed. Trade-off:
substantially larger signatures than ML-DSA.

### NIST PQC Standardization Project

The multi-year, multi-round public competition and review process through
which FIPS 203, 204, and 205 (and ongoing work on additional algorithms,
including FALCON) were selected and standardized.

## Foundational Cryptographic Research

### Shor's Algorithm (1997)

Peter Shor's polynomial-time quantum algorithm for integer factorization
and discrete logarithm computation is the foundational result motivating
this entire research area: it is what makes RSA and elliptic-curve
cryptography insecure against a sufficiently capable quantum computer.

### CRYSTALS-Kyber, CRYSTALS-Dilithium, FALCON, SPHINCS+

The original academic submissions underlying ML-KEM, ML-DSA, and the
ongoing FALCON standardization track, plus SLH-DSA's SPHINCS+ origin.
Referenced both for historical context and because some implementation
libraries still use the original names internally or in documentation.

## IETF Standards

### RFC 8446 — TLS 1.3

The transport-layer protocol this paper's hybrid key-exchange analysis is
built on. TLS 1.3's `key_share` extension mechanism is what enables hybrid
classical/post-quantum key exchange without protocol-level redesign.

### RFC 7519 — JSON Web Token (JWT)

Defines the JWT structure, including the `alg` header that makes
algorithm-agnostic, incremental signature migration possible at the token
layer.

### RFC 6749 — OAuth 2.0 Authorization Framework

The authorization framework whose access/refresh tokens are commonly
implemented as JWTs, inheriting the same migration considerations.

### IETF Hybrid Key Exchange in TLS 1.3 (Internet-Draft)

Ongoing IETF TLS working group draft specifying how classical and
post-quantum key shares are combined within the existing TLS 1.3
handshake structure. Cited throughout the paper's Section V; readers
should consult the current draft revision, as this work was still
evolving at the time of writing.

### Composite Public and Private Keys for X.509 Certificates (IETF LAMPS, Internet-Draft)

The IETF LAMPS working group's draft specification for composite
certificates embedding both classical and post-quantum keys/signatures.
Referenced in the paper's certificate migration discussion (Section VI)
and `docs/migration-guide.md`.

## Government and Industry Guidance

### NSA Commercial National Security Algorithm Suite 2.0 (CNSA 2.0)

U.S. National Security Agency guidance recommending hybrid cryptographic
approaches during the post-quantum transition for national security
systems; cited as supporting evidence for the hybrid-first migration
sequencing recommended in this paper.

### ETSI Quantum-Safe Cryptography Technical Reports

European Telecommunications Standards Institute technical reports on
quantum-safe cryptography, providing additional standards-body context
for the migration urgency discussed in the paper's introduction.

## Open-Source Reference Implementations

### Open Quantum Safe Project (liboqs)

A C library providing reference and optimized implementations of
NIST-standardized and candidate post-quantum algorithms. Referenced as
the most likely foundation for the prototype implementation work
described in this repository's research roadmap (`CHANGELOG.md`).

## Risk Assessment Literature

### Mosca's Quantum Risk Estimate (2018)

Michele Mosca's widely-cited framework for reasoning about quantum risk
timelines (the "Mosca theorem": compare the security shelf-life of data,
the time required to migrate, and the time until a CRQC exists). Cited in
the paper's introduction as context for why migration urgency is a
function of data sensitivity and migration lead time, not solely of CRQC
arrival date.
