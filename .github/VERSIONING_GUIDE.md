# Versioning Guide

This repository tracks two independent version sequences: the
**repository release version** and the **paper version**. This guide
clarifies how each is incremented and when to bump which.

## Repository Releases (Semantic Versioning)

The repository as a whole — documentation, diagrams, tooling, and
(eventually) implementation code — follows
[Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`.

| Bump | When |
|---|---|
| **MAJOR** | A breaking restructure of the repository layout, or a paper revision that materially changes the architecture/migration framework's conclusions |
| **MINOR** | New documentation sections, new diagrams, new implementation scope (e.g., the prototype code landing for the first time), non-breaking additions |
| **PATCH** | Typo fixes, citation corrections, broken link fixes, diagram polish, CI/tooling fixes |

Tag releases as `vX.Y.Z` and use the
[release template](RELEASE_TEMPLATE.md) for the accompanying GitHub
release notes. Update `CITATION.cff`'s `version` field to match.

## Paper Versions

The paper itself is versioned independently, tracked in the "Paper
Versions" table at the bottom of [`CHANGELOG.md`](../CHANGELOG.md), and
corresponds to **Zenodo's own versioning** of the archived record under
the shared concept DOI (`10.5281/zenodo.20413115`).

- A new paper version is created whenever the *content* of
  `paper/paper.tex` materially changes — new sections, revised claims,
  added empirical data — not for documentation-only repository updates.
- Each paper version should be archived to Zenodo as a new version under
  the existing concept DOI, which automatically gets its own
  version-specific DOI while preserving citability of the concept as a
  whole.
- Update the abstract and citation examples in `README.md` if a new
  paper version changes the abstract text.

## Relationship Between the Two

A repository release (e.g., `v1.1.0`) might ship purely documentation
improvements with no paper version bump. Conversely, landing paper v2.0
(adding empirical benchmark results) would typically coincide with at
least a repository MINOR or MAJOR bump, since it likely also means new
content in `implementation/` and `docs/`.

| Repository Release | Paper Version | Example Trigger |
|---|---|---|
| v1.0.0 | v1.0 | Initial publication (this release) |
| v1.1.0 | v1.0 (unchanged) | Documentation refinement, no paper content change |
| v2.0.0 | v2.0 | Empirical benchmark results added to paper + `implementation/` populated |

## Pre-Release Versions

If a release contains incomplete or unreviewed prototype code (e.g., an
early cut of `implementation/prototype/`), tag it with a pre-release
suffix: `v2.0.0-rc.1`. Do not archive pre-release versions to Zenodo;
reserve Zenodo archival for finalized releases.
