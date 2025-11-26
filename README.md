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

## Structure

- `resume.typ` - Main resume source file
- `flake.nix` - Nix flake for development environment and build
