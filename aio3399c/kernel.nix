{ fetchFromGitHub, buildLinux, ... } @ args:
buildLinux (args // rec {
  kernelPatches = [];
  version = "4.19.0-rc8";
  modDirVersion = "4.19.0-rc8";
  defconfig = "firefly_linux_defconfig";
  autoModules = false;

  src = fetchFromGitHub {
    owner = "FireflyTeam";
    repo = "kernel";
    rev = "8c0f8c1b1f8d12c6ef633761c0ae9e51a9619240"; #mainline 4.19
    sha256 = "1md7qm99d641p9rw65dngh9z8ljx72gap5k7ibmf516ndzzdfdfg";
  };
} // (args.argsOverride or {}))
