{
  description = "myctrl C++ service for NixOS and Arch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.callPackage ./nix/default.nix {};
        packages.myctrl = self.packages.${system}.default;

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.cmake
            pkgs.gcc
            pkgs.pkg-config
            pkgs.ninja
          ];
        };
      }
    ) // {
      nixosModules.default = ./nix/modules/myctrl.nix;
      nixosModules.myctrl = self.nixosModules.default;
    };
}
