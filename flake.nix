{
  description = "Slstatus flake by jonwin";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          hugo
          go
          dart-sass
        ];

        shellHook = ''
          exec zsh
        '';
      };
    });
}
