# Creates user Jakku:
{
  config,
  lib,
  ...
}: let
  user = "jakku";
in {
  users.users.${user} = {
    isNormalUser = true;
    initialPassword = "${user}";
    extraGroups = [
      # Enable ‘sudo’ for the user
      "wheel"
      # Enable networking for the user
      "networkmanager"
      # Enable virtualization for the user
      "libvirtd"
    ];
    # Use the default shell (ZSH):
    useDefaultShell = true;

    # Add the user to the Nix store trusted users:
    nix.settings.trusted-users = [
      "${user}"
      "root"
      "@wheel"
    ];
  };
}
