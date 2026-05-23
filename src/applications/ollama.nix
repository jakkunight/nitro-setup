let
  feature = "ollama";
  extra-feature = "ollama-cuda";
  extra-feature-2 = "ollama-vulkan";

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
  # ======== OLLAMA CUDA ========
  flake.modules.nixos.${extra-feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ollama-cuda
      ];
    };
  flake.modules.homeManager.${extra-feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ollama-cuda
      ];
    };
  # ======== OLLAMA VULKAN ========
  flake.modules.nixos.${extra-feature-2} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ollama-vulkan
      ];
    };
  flake.modules.homeManager.${extra-feature-2} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ollama-vulkan
      ];
    };
}
