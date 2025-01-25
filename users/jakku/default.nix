# Jakku config:
{ pkgs, config, lib, inputs, ... }: {
  config = {
    # Use ZSH as default shell:
    #programs.zsh.enable = true;
    #users.defaultUserShell = pkgs.zsh;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jakku = {
      isNormalUser = true;
      initialPassword = "1234";
      extraGroups = [ "wheel" "networkmanager" "libvirtd" ]; # Enable ‘sudo’ for the user.
      useDefaultShell = true;
    };

    # Add them to the Nix store trusted users:
    nix.settings.trusted-users = [
      "jakku"
      "root"
      "@wheel"
    ];

    # # Fix Firefox bug:
    # environment.sessionVariables = {
    #   MOZ_ENABLE_WAYLAND = 0;
    # };
  };
}
