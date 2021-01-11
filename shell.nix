with import <nixpkgs> {};

mkShell {
  buildInputs = [
    antora-wrapper
    nodejs
    jq
  ];
  shellHook = ''
    export LIVERELOAD=true
  '';
}
