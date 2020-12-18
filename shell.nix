with import <nixpkgs> {};
mkShell {
  buildInputs = [
    antora-wrapper
    nodePackages.http-server
  ];
}
