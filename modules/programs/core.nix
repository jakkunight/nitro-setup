let
  feature = "core";
in
{ self, ... }:
{
  flake.modules = {
    nixos.${feature} = {
      imports = with self.modules.nixos; [
        zsh
        nushell
        helix
        eza
        yazi
        zellij
        uutils-coreutils
        rmpc
        btop
        ani-cli
        youtube
        zoxide
        multimedia
        bat
        starship
        presenterm
        zathura
      ];
    };
    homeManager.${feature} = {
      imports = with self.modules.homeManager; [
        zsh
        nushell
        helix
        eza
        yazi
        zellij
        uutils-coreutils
        rmpc
        mpd
        btop
        ani-cli
        youtube
        zoxide
        multimedia
        bat
        starship
        presenterm
        zathura
      ];
    };
  };
}
