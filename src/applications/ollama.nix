let
  feature = "ollama";
in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ollama
      ];
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ollama
      ];
    };
}
