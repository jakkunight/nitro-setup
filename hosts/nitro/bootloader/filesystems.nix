{ pkgs, config, lib, inputs, ... }:

{
  boot.supportedFilesystems = [
    "ntfs"
  ];
  # fileSystems."/path/to/mount/to" =
  # { device = "/path/to/the/device";
  #   fsType = "ntfs-3g"; 
  #   options = [ "rw" "uid=theUidOfYourUser"];
  # };
}
