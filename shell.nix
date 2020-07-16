with import <nixpkgs> {};
mkShell {
  buildInputs = [
    pkgs.pypi2nix
    pkgs.antora-wrapper
  ];
}
