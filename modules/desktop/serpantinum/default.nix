let
  feature = "serpantinum-shell";
in
{ self, inputs, ... }:
{
  flake.modules.nixos.${feature} = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      inputs.serpantinum.nixosModules.default
      hyprland
      hyprland-nvidia
      kitty
      foot
      ghostty
    ];
    programs.serpantinum.enable = true;
  };
  flake.modules.homeManager.${feature} = { pkgs, ... }: {
    imports = with self.modules.homeManager; [
      inputs.serpantinum.nixosModules.default
      nightmare-hyprland
      kitty
      foot
      ghostty
      zen-browser
      zsh
      nushell
      remmina
    ];
    programs.serpantinum.enable = true;
  };
}
