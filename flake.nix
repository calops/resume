{
  description = "A resume built with Typst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    aporetic.url = "github:calops/iosevka-aporetic";
    aporetic.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, flake-utils, aporetic, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.typst
            pkgs.tinymist
            pkgs.typstyle
            aporetic.packages.${system}.aporetic-sans-prebuilt
            pkgs.nerd-fonts.symbols-only
          ];

          shellHook = ''
            echo "Typst development environment loaded"
            echo "Run 'typst compile resume.typ' to build the resume"
            echo "Run 'typst watch resume.typ' to watch for changes"
          '';
        };

        packages.default = pkgs.stdenv.mkDerivation {
          name = "resume";
          src = ./.;
          buildInputs = [ pkgs.typst ];
          buildPhase = ''
            typst compile resume.typ resume.pdf
          '';
          installPhase = ''
            mkdir -p $out
            cp resume.pdf $out/
          '';
        };
      });
}
