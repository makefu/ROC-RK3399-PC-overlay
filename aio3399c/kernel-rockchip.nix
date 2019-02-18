{ fetchFromGitHub, buildLinux, ... } @ args:
buildLinux (args // rec {
  kernelPatches = [];
  version = "4.4.167";
  modDirVersion = "4.4.167";
  defconfig = "rockchip_linux_defconfig";

  extraConfig = ''
    GATOR n
  '';
  autoModules = false; # do not automatically try to load other modules

  src = fetchFromGitHub {
    owner = "rockchip-linux";
    repo = "kernel";
    rev = "27f039b43ada8d0301867505ce9a91d8b5c604bc"; # release-4.4
    sha256 = "1d1nj77l5wlnk15r4l14cylmhvhd81dn8mm1aq4565q5za628lyb";
  };
} // (args.argsOverride or {}))
