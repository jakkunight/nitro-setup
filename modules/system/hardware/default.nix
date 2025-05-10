{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    ./cpu
    ./disk
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
}
