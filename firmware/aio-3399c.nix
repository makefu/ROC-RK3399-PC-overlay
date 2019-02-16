{ stdenv

# TODO: i cannot explicitly provide "board" or a similar variable, then rkbin
# will be un-patch-elf-ed when including it
, AIO-3399C }:

let
  inherit (AIO-3399C) u-boot rkbin;
in
stdenv.mkDerivation rec {
  pname = "AIO-3399C-firmware";
  version = "2019-02-14";
  name = "${pname}-${version}";

  unpackPhase = ":";
  flashData = "${rkbin}/share/rkbin/bin/rk33/rk3399_ddr_800MHz_v1.14.bin";
  flashBoot = "${rkbin}/share/rkbin/bin/rk33/rk3399_miniloader_v1.15.bin";

  nativeBuildInputs = [
    rkbin
  ];

  installPhase = ''
    (
    PS4=" $ "
    set -x

    ${u-boot}/mkimage -n rk3399 -T rksd -d ${flashData} idbloader.img
    cat ${flashBoot} >> idbloader.img

    cp idbloader.img combined.img

    ln -s ${rkbin}/share/rkbin rk_tools

    loaderimage --pack \
      --uboot ${u-boot}/u-boot.bin uboot.img \
      --size 1024 2

    trust_merger --size 1024 2 --verbose \
     --replace tools/ "(dummy)" \
      ${rkbin}/share/rkbin/RKTRUST/RK3399TRUST.ini

    # minus 64 since this file is written starting at offset 64.
    dd if=uboot.img of=combined.img seek=$(( 0x4000 - 64 ))
    dd if=trust.img of=combined.img seek=$(( 0x6000 - 64 ))

    mkdir -p $out
    mv uboot.img trust.img idbloader.img combined.img $out/
    )
  '';

  meta = with stdenv.lib; {
    maintainers = [ maintainers.samueldr ];
    platforms = ["aarch64-linux"];
  };
}
