{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [pkgs.xorriso pkgs.qemu];
}

# let
#   qemuGtk = pkgs.qemu.override (oldAttrs: rec {
#     gtkSupport = true;
#   });
# in
#   pkgs.mkShell {
#     buildInputs = [
#       pkgs.xorriso qemuGtk
#     ];
#   }
