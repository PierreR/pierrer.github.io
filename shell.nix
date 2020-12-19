with import <nixpkgs> {};

mkShell {
  buildInputs = [
    antora-wrapper
    nodejs
  ];
  shellHook = ''
    export LIVERELOAD=true
  '';
}
