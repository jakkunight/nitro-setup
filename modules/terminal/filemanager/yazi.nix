# Yazi configuration:
{ lib, config, pkgs, inputs, ... }: {
  options = {
    terminal.filemanager.yazi = {
      enable = lib.mkEnableOption "Enable Yazi";
    };
  };
  config = lib.mkIf config.terminal.filemanager.yazi.enable {
    environment.systemPackages = [
      inputs.yazi.packages.${pkgs.system}.default
    ];
    programs.yazi = {
      enable = true;
      package = inputs.yazi.packages.${pkgs.system}.default;
      flavors = {
        tokyonight = inputs.yazi-tokyonight;
      };
    };
  };
}
