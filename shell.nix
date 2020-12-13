with import <nixpkgs> {};
mkShell {
  buildInputs = [
    antora-wrapper
    (python3.withPackages (ps: [ps.requests ]))
  ];
}
