# Assets

Visual assets for this repository's README and any future presentation
materials.

## Contents

| File | Purpose |
|---|---|
| `logo.svg` / `logo.png` | Square repository logo (shield + lattice motif, representing security and lattice-based PQC) |
| `banner.svg` / `banner.png` | Wide banner used at the top of `README.md` |
| `screenshots/` | Reserved for future screenshots once `implementation/` produces a runnable prototype (e.g., gateway dashboard, benchmark output visualizations) |

## Design Notes

The visual identity uses a dark slate (`#1f2933`) and teal (`#0d7a7a`)
palette, matching the color tokens used throughout `diagrams/`, so that
the README banner, logo, and inline diagrams read as a single coherent
visual system rather than disconnected assets.

The shield-and-lattice motif is intentional: the shield represents the
security/protection subject matter, and the embedded square lattice grid
references lattice-based cryptography (the mathematical foundation of
ML-KEM and ML-DSA), distinguishing this from a generic padlock icon.

## Regenerating Assets

Both `logo.png` and `banner.png` are rasterized from their `.svg`
counterparts:

```bash
pip install cairosvg --break-system-packages
python3 -c "import cairosvg; cairosvg.svg2png(url='logo.svg', write_to='logo.png', output_width=480, output_height=480)"
python3 -c "import cairosvg; cairosvg.svg2png(url='banner.svg', write_to='banner.png', output_width=2400)"
```

Edit the `.svg` source and regenerate the `.png` rather than editing the
raster directly.
