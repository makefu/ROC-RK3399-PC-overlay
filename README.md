WIP overlay for ROC-RK3399-PC
=============================

This overlay intends to provide *all* tools, open and proprietary, for the ROC-RK3399-PC.


Usage
-----

Here's an example invocation for building one of the aarch64 bits:

```
 $ nix-build -A pkgsCross.aarch64-multiplatform.ROC-RK3399-PC.firmware
 $ nix-build -A pkgsCross.aarch64-multiplatform.AIO-3399C.firmware
```

Result
------

* `combined.img` - directly flash onto sd-card to get boot-loader support
* `idbloader.img` - proprietary first bootloader for rockchip, at the front of the emmc
* `u-boot.img` - aligned uboot image for the uboot partition on the emmc
* `trust.img` - arm trusted boot image for rk3399 for the trusted partition
