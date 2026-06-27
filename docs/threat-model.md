# Threat Model

This document expands on Section III of the paper. It defines the
adversary capabilities, protected assets, security goals, trust
assumptions, and attack surfaces considered throughout this research.

<p align="center">
  <img src="../diagrams/threat-model.png" alt="Threat model: adversaries, assets, and attack surfaces" width="800">
</p>

## Adversary Capabilities

### Classical Network Adversary

A network-positioned adversary bounded by present-day computational
limits. Capabilities include:

- **Passive eavesdropping** on network traffic between API clients and
  servers.
- **Active man-in-the-middle (MITM) positioning**, attempting to
  intercept or modify traffic in transit.
- **Certificate or token forgery attempts**, bounded by the
  computational hardness of the classical primitives (RSA factoring,
  ECDLP) protecting those artifacts today.

This adversary class is already addressed by mature classical security
practice (TLS 1.3, properly validated certificate chains, signed tokens)
and is not the primary motivation for this paper; it is included for
completeness, since any proposed migration must not *regress* protection
against this adversary while improving protection against the next one.

### Harvest-Now, Decrypt-Later (HNDL) Adversary

A more consequential adversary for this paper's purposes:

- **Passively records** encrypted API traffic and certificate material
  today, without needing to break any cryptography at capture time.
- **Defers decryption** until a cryptographically relevant quantum
  computer (CRQC) becomes available, at which point recorded
  classically-encrypted material becomes retroactively exposed.
- **Bounded by data retention capacity**, not by present-day
  computational limits — this is the defining feature that distinguishes
  HNDL from the classical adversary above.

The HNDL model is why post-quantum transport-layer migration is
time-sensitive in a way that, for example, post-quantum signature
migration for newly-issued short-lived tokens is not: a signature forged
in the future cannot retroactively forge a *past* authorization decision,
but a session recorded today *can* be decrypted in the future if it
relied solely on classical key exchange.

## Protected Assets

| Asset | Description | Primarily Protected By |
|---|---|---|
| Confidentiality of data in transit | API request/response payloads, including any sensitive data carried within | Transport-layer encryption (Layer 1) |
| Integrity/authenticity of requests and responses | Assurance that messages were not modified or forged in transit | TLS record authentication, application-layer signatures where used |
| Long-term validity of certificate chains and trust anchors | Assurance that a certificate chain remains unforgeable over its validity period, including against future adversaries | Certificate signature algorithm (Layer 2) |
| Integrity of bearer tokens | Assurance that JWTs/OAuth tokens were issued by a legitimate identity provider and not forged or tampered with | Token signature/MAC scheme (Layer 3) |

## Security Goals

1. **Forward secrecy against both classical and HNDL adversaries at the
   transport layer.** Achieved via hybrid TLS key exchange (Section V of
   the paper): the session remains secure if either the classical or the
   post-quantum component of the hybrid combiner is unbroken, which
   covers both the case where ML-KEM has an undiscovered weakness and the
   case where a future CRQC breaks the classical component.

2. **Unforgeability of certificates and tokens against quantum-capable
   signature forgery.** Achieved via migration to ML-DSA/SLH-DSA-signed
   certificates and tokens (Section VI of the paper), on a timeline
   distinct from transport-layer migration since the HNDL urgency does
   not apply equally to signature forgery (a forged signature requires
   the adversary to act in real time against a currently-valid
   certificate or token, not retroactively against recorded material).

3. **Backward compatibility with classical-only clients during the
   transition period, without weakening the security posture for
   quantum-resistant clients.** Achieved via algorithm negotiation at the
   protocol level (TLS key-share groups, JWT `alg` headers) combined with
   gateway-layer policy enforcement of minimum acceptable algorithms for
   sensitive endpoints once client-side support is sufficiently mature.

## Trust Assumptions

This threat model assumes:

- The cryptographic primitives standardized by NIST (ML-KEM, ML-DSA,
  SLH-DSA) are correctly specified and free of structural weaknesses at
  the time of writing, consistent with the broader cryptographic
  community's assessment following NIST's multi-round public
  standardization process.
- Implementations of these primitives (e.g., via liboqs or vendor TLS
  libraries) correctly implement the FIPS specifications without
  introducing side-channel or implementation-level vulnerabilities;
  implementation security is explicitly out of scope for this
  architectural analysis.
- Certificate authorities and identity providers are not themselves
  compromised; this threat model addresses cryptographic algorithm
  strength, not key-management compromise, insider threats, or supply
  chain attacks against CA/IdP infrastructure.
- The "harvest now, decrypt later" adversary has the resources to store
  intercepted traffic for an extended period (years), which is a
  reasonable assumption for well-resourced state-level or
  intelligence-affiliated adversaries, though less certain for
  opportunistic attackers.

## Attack Surfaces

| Surface | Adversary | Concern |
|---|---|---|
| TLS handshake | Classical, HNDL | Key-exchange interception; HNDL recording of the handshake for future decryption |
| Certificate chain | Classical, HNDL | Forged or substituted CA signatures; HNDL forgery of certificates once CRQC exists, threatening long-lived trust anchors |
| Bearer tokens (JWT/OAuth) | Classical | Signature forgery against currently-valid tokens; less HNDL-relevant given typical token lifetimes are short relative to CRQC timelines |
| API gateway configuration | Classical | Misconfigured algorithm fallback inadvertently permitting weak classical-only negotiation in production |

## Out of Scope

This threat model — and the paper it accompanies — does **not** address:

- Side-channel attacks against specific cryptographic implementations
- Denial-of-service attacks against API infrastructure
- Application-layer vulnerabilities unrelated to cryptographic algorithm
  choice (e.g., injection attacks, business logic flaws)
- Physical security or insider threat models for certificate authorities
  or identity providers
- Quantum algorithms beyond Shor's algorithm's impact on asymmetric
  cryptography (e.g., this document does not provide an exhaustive
  treatment of Grover's algorithm's impact on symmetric primitives,
  beyond noting that key-length doubling is the standard mitigation)

These are acknowledged as important but separate concerns, consistent
with the paper's stated scope as an architectural and migration analysis
rather than a comprehensive security audit framework.
