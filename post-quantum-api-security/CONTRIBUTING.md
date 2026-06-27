# Contributing

Thank you for your interest in contributing to this research repository.
This project hosts an academic paper, its supporting documentation, and a
roadmap toward future reproducible implementation work. Contributions are
welcome in the form of corrections, clarifications, documentation
improvements, diagram refinements, and — once the `implementation/`
scope is populated — prototype or benchmark code.

## Ways to Contribute

- **Errata and corrections** — factual, mathematical, or citation
  corrections to the paper or documentation.
- **Documentation improvements** — clarifying the architecture, threat
  model, or migration guide.
- **Diagrams** — improvements or additional diagrams consistent with the
  existing visual style (see `diagrams/`).
- **Implementation** — once placeholder directories under
  `implementation/` are scoped with issues, prototype contributions
  aligned with the paper's described architecture.

## Before You Start

For non-trivial changes, please open an issue first to discuss the
proposed change. This avoids duplicated effort and ensures alignment with
the paper's scope and claims.

## Coding Style

- **LaTeX**: Follow the existing structure in `paper/paper.tex`. Use
  semantic sectioning (`\section`, `\subsection`) rather than manual
  formatting. Keep citations in `references.bib` alphabetized by key.
- **Markdown**: Use ATX-style headers (`#`, `##`), reference-style links
  where a URL is reused, and keep line length reasonable for diff
  readability (soft wrap around 80–100 characters).
- **Diagrams**: SVG source should use the existing color tokens (see any
  file in `diagrams/*.svg` for the palette) and avoid embedding raster
  images where vector shapes suffice.
- **Scripts**: POSIX-compatible shell where possible; document any
  non-POSIX dependency at the top of the script.

## Documentation Style

- Use precise, hedged academic language. Avoid absolute claims
  ("eliminates," "guarantees") where the underlying literature only
  supports a probabilistic or conditional claim.
- Cite sources for factual claims about standards, algorithms, or
  performance figures. Prefer primary sources (NIST FIPS documents, IETF
  RFCs/drafts) over secondary summaries.
- Keep terminology consistent with `paper/supplementary/notation-and-abbreviations.md`.

## Commit Message Conventions

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <short summary>

[optional body]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
Examples:

```
docs(threat-model): clarify HNDL adversary data-retention assumption
fix(paper): correct ML-DSA-44 signature size in Table I
feat(diagrams): add certificate composite-key structure diagram
```

## Branch Naming

```
<type>/<short-description>
```

Examples: `docs/migration-guide-jwt-section`, `fix/bibtex-doi-typo`,
`feat/benchmark-harness-scaffold`.

## Review Process

1. Open a pull request against `main` with a clear description of the
   change and its motivation.
2. For changes to the paper's claims or citations, include the
   supporting source (DOI, RFC number, or URL) in the PR description.
3. At least one maintainer review is required before merge.
4. CI (see `.github/workflows/`) must pass, including LaTeX build
   verification where the paper source is modified.

## Questions

Open a [GitHub Discussion](https://github.com/sr-857/post-quantum-api-security/discussions)
or contact subhajitroy857@gmail.com.
