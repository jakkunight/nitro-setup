{inputs, ...}: {
  flake.modules.nixos."terminal/prompt/starship" = {pkgs, ...}: {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        scan_timeout = 10;
      };
    };
  };
  flake.modules.homeManager."terminal/prompt/starship" = {pkgs, ...}: {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        scan_timeout = 10;
      };
    };
  };
}
