# Figures

This directory is reserved for figures embedded directly in
`paper/paper.tex` via `\includegraphics`.

The current paper revision (v1.0) references the repository's
`diagrams/` directory in prose (e.g., "illustrated in the API
architecture diagram accompanying this repository,
`diagrams/api-architecture.svg`") rather than embedding figures inline,
since the diagrams are maintained as standalone SVG/PNG assets shared
between the paper, the README, and `docs/`.

Future paper revisions that require LaTeX-native embedded figures
(e.g., empirical benchmark plots generated directly from
`implementation/benchmarks/` data) will be added here as PDF or PNG
files, with the corresponding `\includegraphics` calls added to
`paper.tex`.
