self: super:

let
  inherit (self) callPackage;
in
{
  ROC-RK3399-PC = {
    rkbin = callPackage ./rkbin {};
    u-boot = callPackage ./u-boot {};
    firmware = callPackage ./firmware { };
  };
  AIO-3399C = {
    rkbin = callPackage ./rkbin {};
    u-boot = callPackage ./u-boot/aio-3399c.nix { defconfig = "firefly-rk3399_defconfig"; };
    firmware = callPackage ./firmware/aio-3399c.nix { };
  };
}
