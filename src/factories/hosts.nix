{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.factory.mkHost =
    {
      name ? throw "You must provide a valid host name",
      system ? "x86_64-linux",
    }:
    (inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.modules.nixos.${name}
        (
          { pkgs, ... }:
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            networking.hostName = "${name}";
            system.stateVersion = "26.05";
            programs.nh.enable = true;
            programs.git.enable = true;
            environment.systemPackages = with pkgs; [
              gitui
              inputs.home-manager.packages.${system}.home-manager
              inputs.disko.packages.${system}.disko
            ];
            environment.etc = {
              nixos-setup = {
                source = ../..;
              };
            };
          }
        )
      ];
    });
}
