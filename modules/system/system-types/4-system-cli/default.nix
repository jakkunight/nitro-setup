{ self, inputs, ... }:
{
  flake.modules.nixos."4-system-cli" = {
    imports = with self.modules.nixos; [
      "3-system-basic"
    ];
  };
  flake.modules.homeManager."4-system-cli" = {
    imports = with self.modules.homeManager; [
      core
      bat
      eza
      starship
      zoxide
      zellij
      fastfetch
      asciinema
      devenv
    ];
  };
}
