{ config, pkgs, lib, ... }:
let
  #kernel = pkgs.callPackage ./kernel.nix { };
  #kernel = pkgs.callPackage ./kernel-rockchip.nix { };

  extlinux-conf-builder =
    import <nixpkgs/nixos/modules/system/boot/loader/generic-extlinux-compatible/extlinux-conf-builder.nix> {
      pkgs = pkgs.buildPackages;
    };
in
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    # <stockholm/makefu/2configs/minimal.nix>
  ];
  # only enable for ttyS2
  boot.kernelParams = lib.mkForce ["console=ttyS2,1500000n8" "earlycon=uart8250,mmio32,0xff1a0000" "earlyprintk"];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackagesFor kernel;
  boot.supportedFilesystems = lib.mkForce [ "vfat" ];

  # krebs.hidden-ssh.enable = true;
  environment.systemPackages = with pkgs; [
  ];
  environment.extraInit = ''
    EDITOR=vim
  '';
  # iso-specific
  services.openssh = {
    enable = true;
    hostKeys = [
      { bits = 8192; type = "ed25519"; path = "/etc/ssh/ssh_host_ed25519_key"; }
    ];
  };
  # enable ssh in the iso boot process
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
  sdImage.populateBootCommands = lib.mkForce ''
    ${extlinux-conf-builder} -t 3 -c ${config.system.build.toplevel} -d ./boot
  '';
}
