# Soporte-MCO config:
{ pkgs, config, lib, inputs, ... }: {
  options = {
    userconfigs.soporte-mco = {
      enable = lib.mkEnableOption "Enable the user 'soporte-mco' to use the host.";
    };
  };
  config = lib.mkIf config.userconfigs.soporte-mco.enable {
    # Use ZSH as default shell:
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.soporte-mco = {
      isNormalUser = true;
      group = "soporte-mco";
      initialPassword = "1234";
      extraGroups = [ "wheel" "networkmanager" "libvirtd" ]; # Enable ‘sudo’ for the user.
      useDefaultShell = true;
      home = "/home/soporte-mco";
    };

    # Create a user group for soporte-mco:
    users.groups.soporte-mco = {
      members = [
        "soporte-mco"
      ];
    };

    # Add them to the Nix store trusted users:
    nix.settings.trusted-users = [
      "soporte-mco"
      "root"
      "@wheel"
    ];

    # # Fix Firefox bug:
    # environment.sessionVariables = {
    #   MOZ_ENABLE_WAYLAND = 0;
    # };
  };
}
