{
  description = "A flake with YGT utils";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "nixpkgs";
    fu.url = "github:numtide/flake-utils";
    bob-ruby = {
      url = "github:bobvanderlinden/nixpkgs-ruby";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs-stable
    , fu
    , bob-ruby
    , ...
    }:
      with fu.lib;
      eachDefaultSystem (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ bob-ruby.overlays.default ];
          };

          pkgs-stable = import nixpkgs-stable { inherit system; };
        in
        {
          devShells = rec {
            default = spabreaks;

            spabreaks = import ./spabreaks/default.nix { inherit pkgs pkgs-stable; };
          };
        }
      );
}
