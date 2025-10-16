#! /bin/bash

# sudo apt-get install -y ocaml opam;
opam init;
opam switch create default ocaml-base-compiler.5.3.0;
opam install -y utop odoc ounit2 qcheck bisect_ppx menhir ocaml-lsp-server ocamlformat;
