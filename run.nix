{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [pkgs.xorriso pkgs.qemu];
}
