# Web Browsers:
{inputs, ...}: {
  imports = [
    ./firefox.nix
    ./brave.nix
    inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
    enable = true;
  };
}
