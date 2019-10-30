let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  pypi2nix = import sources.pypi2nix {};
in pkgs.mkShell {
  buildInputs = [
    pypi2nix
    pkgs.antora
  ];
}
