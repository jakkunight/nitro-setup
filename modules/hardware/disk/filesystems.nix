{
  flake.modules.nixos."hardware/disk/filesystems" = {
    modulesPath,
    lib,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot.supportedFilesystems = lib.mkForce [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];
    services.gvfs.enable = true;
  };
}
