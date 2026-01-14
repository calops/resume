# Resume

My resume built with [Typst](https://typst.app/).

## Building

This project uses [Nix](https://nixos.org/) with flakes for reproducible builds.

### PDF (Default)

To build the PDF version of the resume:

```bash
nix build
```

The output will be available at `result/resume.pdf`.

### Web (HTML)

To build the HTML version:

```bash
nix build .#web
```

The output will be available at `result/index.html`.

## Development

To start a development shell with all dependencies (compiler, fonts, LSP, formatter):

```bash
nix develop
```

This shell provides:
- `typst` - The Typst compiler
- `tinymist` - Language server for editor integration
- `typstyle` - Formatter for Typst files
- `nixfmt-rfc-style` - Formatter for Nix files
- `aporetic-sans` - The font family used in the resume
- `nerd-fonts` - Icon font

Inside the shell, you can manually compile or watch files:

```bash
# Compile to PDF
typst compile --root . src/pdf.typ resume.pdf

# Watch for changes
typst watch --root . src/pdf.typ resume.pdf
```