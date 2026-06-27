# Changelog

All notable changes to this repository are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
for repository releases (the paper itself is versioned independently;
see "Paper Versions" below).

## [Unreleased]

### Planned

- Prototype implementation scaffolding under `implementation/prototype/`
- Benchmark harness for hybrid TLS handshake latency
- Packet-size analysis tooling for ML-KEM/ML-DSA-augmented handshakes

## [1.0.0] - 2026-01-01

### Added

- Initial publication of the research paper (LaTeX source + compiled PDF)
- Five-layer reference architecture documentation (`docs/architecture.md`)
- Threat model documentation (`docs/threat-model.md`)
- Migration guide covering TLS, certificates, JWT, OAuth 2.0, and API
  gateway migration (`docs/migration-guide.md`)
- Annotated bibliography (`docs/bibliography.md`)
- FAQ (`docs/faq.md`)
- Five diagrams in SVG and PNG format: hybrid TLS handshake, API
  architecture, cryptographic dependency graph, migration roadmap, and
  threat model
- Repository governance files: `LICENSE` (MIT), `CITATION.cff`,
  `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `SECURITY.md`
- GitHub issue and pull request templates
- Placeholder scope for future implementation work
  (`implementation/{examples,prototype,benchmarks}`)

---

## Research Roadmap

This roadmap tracks planned milestones beyond the current documentation
release. Dates are targets, not commitments, and will be revised as work
progresses.

### Version 1.1 — Documentation Refinement

- Incorporate community feedback on the threat model and migration guide
- Expand `docs/bibliography.md` with additional composite-certificate
  standardization references as IETF LAMPS drafts mature
- Add a comparison table of liboqs-supported algorithm parameter sets

### Version 2.0 — Prototype Implementation

- Hybrid TLS prototype using OpenSSL + Open Quantum Safe (`liboqs`)
  provider, under `implementation/prototype/`
- Minimal ML-KEM-backed key exchange example, under
  `implementation/examples/`
- API gateway prototype demonstrating dual-algorithm certificate
  validation

### Benchmark Study

- Hybrid TLS handshake latency measurement across ML-KEM-512/768/1024
- JWT signature size and validation latency comparison: ECDSA vs.
  ML-DSA vs. SLH-DSA
- Packet size and round-trip overhead analysis for hybrid vs.
  classical-only handshakes

### Experimental Evaluation

- Reproducible benchmark methodology published under
  `implementation/benchmarks/`
- Raw data and analysis notebooks accompanying the benchmark study,
  cross-referenced from `paper/supplementary/`

### Conference Submission

- Submission of an extended version of this paper, incorporating
  empirical benchmark results, to a relevant applied cryptography or
  systems security venue

### Journal Submission

- Further extended version with complete experimental evaluation,
  targeting a journal venue appropriate for applied post-quantum
  cryptography and distributed systems security research

---

## Paper Versions

The research paper itself follows its own version history, distinct from
repository releases:

| Paper Version | Date | Summary |
|---|---|---|
| v1.0 | 2026-01-01 | Initial architectural analysis and migration framework (5 pages, IEEE conference format) |

Future paper revisions incorporating empirical results will be tracked
here and published as new Zenodo versions under the same concept DOI.
