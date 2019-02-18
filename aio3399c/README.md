These sources can be used to pre-build an SD Image for the AIO-3399C:

```nix build config.system.build.sdImage -I  nixos-config=config.nix --option system aarch64-linux```
