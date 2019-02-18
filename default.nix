{
  pkgs ? import <nixpkgs> {
    overlays = [ (import ./overlay.nix) ];
  }
}:

{
  # Pass through the cross-compilation infra
  inherit (pkgs) pkgsCross AIO-3399C ROK-RK3399-PC;
  # And passes the nixpkgs with overly through if required.
  overlay = pkgs;
}
