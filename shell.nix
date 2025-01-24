{ pkgs ? import <nixpkgs> { }, }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    nixfmt-rfc-style
    zigpkgs.master
    qemu
    llvmPackages_19.bintools
  ];

  shellHook = '''';
}
