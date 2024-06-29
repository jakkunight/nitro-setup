# User management:
{ config, lib, pkgs, inputs, ... }: {
  # Allow unfree software:
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakku = {
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox-wayland
      tree
      libreoffice
      brave
      discord
      steam
    ];
  };

  # Home-Manager stuff:
  home-manager = {
    extraSpecialArgs = { inherit inputs };
    users = {
      jakku = import ../jakku;
    };
  };
}
