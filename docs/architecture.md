# Architecture

This document expands on the five-layer reference architecture proposed
in Section IV of the paper (`paper/paper.tex`). It is intended as a
practitioner-facing companion to the academic text — slightly more
implementation-oriented, while remaining consistent with the paper's
claims.

<p align="center">
  <img src="../diagrams/api-architecture.png" alt="Five-layer quantum-resilient API architecture" width="800">
</p>

## Why Five Layers

API security migration is frequently discussed as if it were a single
decision — "switch to post-quantum TLS" — but in practice, transport,
certificate, token, gateway, and application concerns each have distinct
owners, distinct upgrade cadences, and distinct failure modes. Separating
them clarifies which trust boundary a given change actually affects, and
prevents the common mistake of assuming transport-layer hybridization
alone constitutes a complete migration.

## Layer 1 — Transport

**Responsibility:** TLS 1.3 connection establishment between API clients
and servers (or between services, in a service-mesh context).

**Components:** TLS termination point (load balancer, reverse proxy, or
application server), key-exchange negotiation, cipher suite selection.

**Post-quantum concern:** The key-exchange mechanism. Hybrid key exchange
(classical ECDHE + ML-KEM) is the recommended interim approach; see
`docs/migration-guide.md` and the paper's Section V for handshake
mechanics.

**Trust boundary:** The TLS session itself — material exchanged here is
visible only to the two TLS endpoints (absent an active MITM, which is
precisely what the handshake's authentication step is designed to
prevent).

## Layer 2 — Certificate

**Responsibility:** X.509 certificate issuance, chain validation, and
revocation.

**Components:** Certificate authority (internal or external), certificate
chain presented during the TLS handshake, relying-party validation logic
(commonly delegated to a TLS library).

**Post-quantum concern:** The signature algorithm used by the issuing CA.
Two non-exclusive migration paths exist: sequential parallel chains
(classical and post-quantum chains issued and trusted simultaneously), or
composite certificates embedding both a classical and post-quantum
key/signature in a single certificate structure (still under IETF LAMPS
working group standardization at the time of writing).

**Trust boundary:** The handoff between certificate authority and relying
party. A relying party's confidence in the certificate is only as strong
as its confidence in the CA's key-management practices for whichever
algorithm(s) it accepts.

## Layer 3 — Token

**Responsibility:** Application-level authentication and authorization
artifacts — primarily JWTs and OAuth 2.0 access/refresh tokens.

**Components:** Identity provider (token issuer), resource server (token
validator), token signing/verification key material.

**Post-quantum concern:** The signature or MAC scheme protecting the
token. JWTs are algorithm-agnostic by design (the `alg` header identifies
the scheme), which permits incremental migration — an identity provider
can begin issuing ML-DSA-signed tokens while resource servers validate
both classical and post-quantum signatures during a transition window.
The primary practical cost is token size: ML-DSA signatures are
substantially larger than ECDSA signatures, with implications for HTTP
header size limits.

**Trust boundary:** The handoff between identity provider and resource
server — typically mediated by a published JSON Web Key Set (JWKS) or
equivalent key-distribution mechanism.

## Layer 4 — Gateway

**Responsibility:** TLS termination, request routing, and token
validation at the perimeter of an API surface.

**Components:** API gateway or reverse proxy (e.g., a dedicated gateway
product, or a general-purpose reverse proxy configured for this role).

**Post-quantum concern:** The gateway is the convergence point of Layers
1–3's migrations. It must simultaneously support hybrid TLS key-exchange
groups, trust whichever certificate chain format is in use, and validate
tokens signed under either classical or post-quantum algorithms during
the transition. We recommend externalizing this configuration (algorithm
allow-lists, minimum acceptable key-exchange groups) rather than
hard-coding it, so that algorithm rollback remains possible if an issue
is discovered post-deployment.

**Trust boundary:** Between external (potentially hybrid-capable)
clients and internal services that may still operate classical-only
cryptography during migration. The gateway effectively translates
between two trust postures.

## Layer 5 — Application

**Responsibility:** Business logic consuming already-validated requests.

**Components:** Application services downstream of the gateway.

**Post-quantum concern:** Generally minimal, provided Layers 1–4 expose a
stable interface (a validated, decoded request/token) to the application
layer. Applications that directly inspect token signatures or embed
assumptions about key/signature byte lengths are the exception, and
should be flagged during the Phase 0 inventory step described in
`docs/migration-guide.md`.

**Trust boundary:** Internal to the service mesh or monolith; generally
not a cryptographic trust boundary in the same sense as Layers 1–4,
though it may be a *blast-radius* boundary worth considering during
incident response planning.

## Cross-Cutting Concern: Cryptographic Agility

Cryptographic agility is treated as a design requirement across all five
layers rather than a property of any single layer. Practically:

- **Protocol-level identifiers** — TLS cipher suite / key-share group
  identifiers, JWT `alg` headers — already provide the negotiation
  surface needed for agility; the discipline required is in *using* that
  surface rather than hard-coding a single algorithm assumption.
- **Configuration-driven selection** — gateway and identity-provider
  components should read algorithm allow-lists from configuration, not
  code, to support both forward migration and emergency rollback.
- **Avoiding size assumptions** — application code that allocates
  fixed-size buffers for keys, signatures, or tokens based on classical
  algorithm sizes will break (or silently truncate) under post-quantum
  algorithms, which are substantially larger (see Table I in the paper).

## Data Flow Summary

A typical authenticated API request traverses the layers as follows:

1. Client and gateway negotiate a hybrid TLS session (**Layer 1**).
2. Gateway presents its certificate chain, validated by the client
   against a trust store containing classical and/or post-quantum roots
   (**Layer 2**).
3. Client presents a bearer token in the request; gateway validates its
   signature against the identity provider's published key set
   (**Layer 3**).
4. Gateway routes the validated request to the appropriate internal
   service, potentially over a separate (and possibly still
   classical-only, during migration) internal TLS session (**Layer 4**).
5. The internal service processes the request without further
   cryptographic concern (**Layer 5**).

## Security Assumptions

This architecture assumes:

- The underlying post-quantum primitives (ML-KEM, ML-DSA, SLH-DSA) are
  correctly implemented per their NIST FIPS specifications; this document
  does not address implementation-level side-channel concerns, which are
  out of scope for an architectural analysis.
- Hybrid combiners used in TLS key exchange are themselves
  IND-CCA2-secure constructions, per IETF hybrid key-exchange guidance.
- Certificate authorities and identity providers maintain key-management
  practices (HSM-backed signing, key rotation) consistent with existing
  classical-era operational security standards; post-quantum migration
  does not relax these requirements.
