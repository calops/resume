{
  stdenv,
  typst,
  aporetic-sans,
  nerd-fonts,
  isWeb ? false,
}:

stdenv.mkDerivation {
  name = if isWeb then "resume-web" else "resume";
  src = ./.;

  buildInputs = [
    typst
    aporetic-sans
    nerd-fonts.symbols-only
  ];

  buildPhase = ''
    export TYPST_FONT_PATHS=${aporetic-sans}/share/fonts/truetype:${nerd-fonts.symbols-only}/share/fonts/truetype
    ${
      if isWeb then
        "typst compile --root . --features html src/web.typ index.html"
      else
        "typst compile --root . src/pdf.typ resume.pdf"
    }
  
'';

  installPhase = ''
    mkdir -p $out
    ${if isWeb then "cp index.html $out/" else "cp resume.pdf $out/"}
  '';
}
