workflow "New workflow" {
  on = "push"
  resolves = ["samueldr/action-nix-build@master"]
}

action "samueldr/action-nix-build@master" {
  uses = "samueldr/action-nix-build@master"
  args = "-A pkgsCross.aarch64-multiplatform.ROC-RK3399-PC.firmware"
}
