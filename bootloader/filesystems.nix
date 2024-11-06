{ pkgs, config, lib, inputs, ... }:

{
  boot.supportedFilesystems = {
    btrfs = true;
    zfs = lib.mkForce true;
    ntfs = lib.mkForce true;
  };
  # fileSystems."/path/to/mount/to" =
  # { device = "/path/to/the/device";
  #   fsType = "ntfs-3g"; 
  #   options = [ "rw" "uid=theUidOfYourUser"];
  # };
}
