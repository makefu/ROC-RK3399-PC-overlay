workflow "New workflow" {
  on = "push"
  resolves = ["samueldr/action-nix-build@509cecf58864761b41748dff0a60cf7157c6657f"]
}

action "samueldr/action-nix-build@509cecf58864761b41748dff0a60cf7157c6657f" {
  uses = "samueldr/action-nix-build@master"
  args = "-A pkgsCross.aarch64-multiplatform.ROC-RK3399-PC.firmware"
  env = {
    NIXPKGS_ALLOW_UNFREE = "1"
  }
}
