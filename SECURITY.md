# Security Policy

## Scope

This repository hosts a research paper, documentation, and (in future
revisions) prototype implementation code related to post-quantum API
security. This policy covers:

- Vulnerabilities in any code published under `implementation/` once
  populated.
- Build-tooling issues in `scripts/` that could result in unsafe behavior
  (e.g., unsafe file handling, command injection in build scripts).

It does **not** cover vulnerabilities in third-party libraries referenced
by the paper (e.g., liboqs, OpenSSL) — please report those directly to
their respective maintainers.

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.x     | ✅ |
| < 1.0   | ❌ (pre-release, not supported) |

This table will be updated as the `implementation/` scope matures past
placeholder status.

## Reporting a Vulnerability

If you believe you have found a security vulnerability in any code
published in this repository, please report it privately rather than
opening a public issue.

**Email:** subhajitroy857@gmail.com
**Subject line:** `[SECURITY] post-quantum-api-security: <short description>`

Please include:

- A description of the vulnerability and its potential impact
- Steps to reproduce, or a proof-of-concept if available
- The affected file(s) or commit hash
- Your suggested severity assessment, if you have one

## Disclosure Policy

This project follows a **coordinated disclosure** approach:

1. **Acknowledgment** — reports will be acknowledged within 5 business
   days.
2. **Assessment** — the maintainer will assess severity and confirm
   reproducibility within 14 days of acknowledgment.
3. **Remediation** — a fix or mitigation will be developed and tested.
   Timeline depends on severity; critical issues are prioritized.
4. **Disclosure** — once a fix is released, the reporter will be credited
   (unless anonymity is requested) in `CHANGELOG.md`, and a summary will
   be published.

## Responsible Disclosure Timeline

| Phase | Target Timeline |
|---|---|
| Initial acknowledgment | ≤ 5 business days |
| Severity assessment | ≤ 14 days from acknowledgment |
| Fix development (critical) | ≤ 30 days |
| Fix development (non-critical) | ≤ 90 days |
| Public disclosure | After fix release, or 90 days from report if unresolved, whichever is sooner |

We ask that reporters refrain from public disclosure until a fix is
available or the timeline above has elapsed, whichever comes first.

## A Note on Cryptographic Claims

This repository discusses post-quantum cryptographic standards (ML-KEM,
ML-DSA, SLH-DSA) and migration strategies at an architectural level. It
does not implement cryptographic primitives. If you identify a factual
error regarding a cryptographic standard's properties, please open a
regular GitHub issue rather than a security report, unless the error
itself could lead to unsafe deployment guidance — in which case, please
use the private reporting channel above out of caution.
