# Resume

My resume built with [Typst](https://typst.app/).

## Prerequisites

This project uses [Nix](https://nixos.org/) with flakes for dependency management.

## Development

Enter the development shell:

```bash
nix develop
```

This provides:
- `typst` - The Typst compiler
- `typst-lsp` - Language server for editor integration
- `typstfmt` - Formatter for Typst files
- `aporetic-sans` - Font used for the resume
- `nerd-fonts` - Font used for icons

## Building

Compile the resume to PDF:

```bash
typst compile resume.typ
```

Watch for changes and automatically recompile:

```bash
typst watch resume.typ
```

Or build using Nix:

```bash
nix build
```

The output PDF will be in `result/resume.pdf`.
