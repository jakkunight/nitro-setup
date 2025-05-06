# Jakku config:
{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakku = {
    isNormalUser = true;
    initialPassword = "1234";
    # Enable ‘sudo’ for the user.
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];
    useDefaultShell = true;
  };

  # Add them to the Nix store trusted users:
  nix.settings.trusted-users = [
    "jakku"
    "root"
    "@wheel"
  ];
}
