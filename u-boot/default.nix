# NOTE: This is **only** the open source bits from a u-boot build.
#       DO NOT create idbloader or anything requiring the rockchip loaders here.
{ lib, buildUBoot, fetchFromGitHub, fetchpatch
, defconfig ? "roc-rk3399-pc_defconfig"
  # Passing a BL31 binary will built u-boot.itb with the downstream script.
, BL31 ? null
}:

buildUBoot rec {
  version = "2017.09";

  src = fetchFromGitHub {
    owner = "FireflyTeam";
    repo = "u-boot";
    rev = "1ce6742a2e94f14352b58132f45689e9205de712";
    sha256 = "1qpa14ynxl3lkxnjp6qgfxs4f5ssqcb351hxqbks5h99lyc92lmj";
  };

  extraPatches = [
    (fetchpatch {
      url = "https://github.com/FireflyTeam/u-boot/pull/1.patch";
      sha256 = "1y6xhq3jvlga1a82sr1xm5i1ni7kwwx1nq0aclv5s0ms1nl38lhk";
    })
    ./0001-rk3399-roc-pc-Inits-target.patch
    ./0002-rk3399-roc-pc-Specifies-upstream-DTB-file-name.patch
  ];

  inherit defconfig;
  extraMakeFlags = [
    "all"
  ]
  ++ lib.optional (BL31 != null) ["u-boot.itb"]
  ;

  filesToInstall = [
    "u-boot.bin"
    ".config"
    "tools/mkimage"
  ]
  ++ lib.optional (BL31 != null) ["u-boot.itb"]
  ;

  preConfigure = ''
    patchShebangs arch/arm/mach-rockchip
  ''
     + lib.optionalString (BL31 != null) "cp ${BL31} ./bl31.elf"
  ;

  extraMeta = with lib; {
    maintainers = [ maintainers.samueldr ];
    platforms = ["aarch64-linux"];
  };
}
