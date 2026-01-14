{
  description = "A resume built with Typst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    aporetic.url = "github:calops/iosevka-aporetic";
    aporetic.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      aporetic,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        aporetic-sans = aporetic.packages.${system}.aporetic-sans-prebuilt;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.typst
            pkgs.tinymist
            pkgs.typstyle
            pkgs.nixfmt-rfc-style
            aporetic-sans
            pkgs.nerd-fonts.symbols-only
          ];

          shellHook = ''
            echo "Typst development environment loaded"
            echo "Run 'typst compile resume.typ' to build the resume"
            echo "Run 'typst watch resume.typ' to watch for changes"
          '';
        };

        formatter = pkgs.nixfmt-rfc-style;

        packages = rec {
          default = pdf;

          pdf = pkgs.callPackage ./package.nix {
            inherit aporetic-sans;
            isWeb = false;
          };

          web = pkgs.callPackage ./package.nix {
            inherit aporetic-sans;
            isWeb = true;
          };
        };
      }
    );
}
