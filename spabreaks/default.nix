{ pkgs, pkgs-stable, ... }:

let
  rubyVersionFile = builtins.readFile ./.ruby-version;
  rubyVersion = builtins.replaceStrings [ "\n" " " ] [ "" "" ] rubyVersionFile;

  ruby = pkgs."ruby-${rubyVersion}";

  rubyEnv = pkgs.bundlerEnv {
    name = "spabreaks-ruby-lsp";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
pkgs.mkShell
{
  name = "spabreaks-ruby-lsp";
  buildInputs = [
    ruby
    rubyEnv
  ] ++ (with pkgs; [
    bundix
    elmPackages.elm
    elmPackages.elm-analyse
    elmPackages.elm-format
    elmPackages.elm-language-server
    elmPackages.elm-test
    nodejs_22
    sops
    tailwindcss-language-server
    tailwindcss_4
    typescript
    yarn
  ]) ++ (with pkgs-stable; [
    go-task
  ]);

  shellHook = ''
    echo "Ruby development environment ready!"
    echo "Ruby version: $(ruby --version)"
  '';
}
