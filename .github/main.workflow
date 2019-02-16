workflow "New workflow" {
  on = "push"
  resolves = [
    "docker://nixos/nix",
  ]
}

action "docker://nixos/nix" {
  uses = "docker://nixos/nix"
  runs = "nix-build"
  args = "-A pkgsCross.aarch64-multiplatform.ROC-RK3399-PC.firmware"
  env = {
    NIXPKGS_ALLOW_UNFREE = "1"
    NIX_PATH = "nixpkgs=channel:nixos-13.10"
  }
}
