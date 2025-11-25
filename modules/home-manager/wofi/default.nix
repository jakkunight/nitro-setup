{pkgs, ...}: {
  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
    settings = {
      allow_images = true;
    };
    style = builtins.readFile ./style.css;
  };
}
