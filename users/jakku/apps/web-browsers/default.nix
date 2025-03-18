# Web Browsers:
{config, lib, pkgs, inputs, ...}:
{
  imports = [
    ./firefox.nix
    ./brave.nix
  ];
  
  config = {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
  };
}
