# Implementation (Placeholder Scope)

This directory reserves scope for future reproducible implementation work
referenced in the paper's Discussion and Conclusion sections, and tracked
in the repository's [research roadmap](../CHANGELOG.md).

**Current status: no implementation code has been published yet.** This
README documents the intended scope so that contributors and readers know
what to expect, and so that future work can be tracked against concrete
placeholders rather than an undefined backlog.

## Planned Contents

### `examples/`

Minimal, single-purpose code examples demonstrating individual concepts
from the paper in isolation:

- A minimal ML-KEM key encapsulation example (likely via `liboqs` bindings)
- A minimal hybrid TLS client/server handshake example
- A JWT signing/validation example using ML-DSA

### `prototype/`

A more complete, multi-component prototype demonstrating the five-layer
architecture described in `docs/architecture.md`:

- **Hybrid TLS prototype** — OpenSSL + Open Quantum Safe (`liboqs`)
  provider configuration demonstrating hybrid key exchange end-to-end.
- **ML-KEM implementation notes** — configuration and integration
  guidance specific to the prototype (not a from-scratch cryptographic
  implementation; this paper does not propose new primitives).
- **Certificate experiments** — composite or parallel-chain certificate
  issuance and validation, once IETF LAMPS draft support stabilizes in
  available libraries.
- **API gateway prototype** — a minimal gateway configuration
  demonstrating the dual-algorithm validation patterns described in
  `docs/migration-guide.md`.

### `benchmarks/`

Reproducible benchmark methodology and (once collected) results for:

- **Hybrid TLS handshake latency** across ML-KEM-512/768/1024 versus
  classical-only baselines
- **JWT benchmark** — signature size and validation latency: ECDSA vs.
  ML-DSA vs. SLH-DSA
- **Packet size analysis** — cumulative overhead of hybrid handshake +
  composite certificate + post-quantum-signed token in a single request
  flow
- **Performance evaluation** — end-to-end API request latency under
  representative workloads, with and without post-quantum migration

## Why This Is Empty Right Now

The accompanying paper (`paper/paper.tex`) is explicitly scoped as an
architectural and migration-strategy analysis, not an empirical
performance study (see the paper's Discussion section). Populating this
directory with the benchmark and prototype work described above is the
primary goal of the "Version 2.0" milestone in
[`CHANGELOG.md`](../CHANGELOG.md).

## Contributing

If you'd like to contribute toward any of the planned contents above,
please open an issue first using the **Feature Request** template (see
`.github/ISSUE_TEMPLATE/`) referencing the specific roadmap item, so effort
isn't duplicated. See [`CONTRIBUTING.md`](../CONTRIBUTING.md) for coding
style and review process.
