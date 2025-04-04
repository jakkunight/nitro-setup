{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    terminal.utils.zoxide = {
      enable = lib.mkEnableOption "Enable zoxide.";
      shellIntegration = {
        enable = lib.mkEnableOption "Enable shell integration integration.";
        alias = lib.mkOption {
          description = "Set the command alias.";
          type = lib.types.nonEmptyStr;
          default = "cd";
        };
      };
    };
    config = {
      environment.systemPackages = [
        pkgs.zoxide
      ];
      environment.shallAliases = lib.mkIf config.terminal.utils.zoxide.shellIntegration.enable {
        "${config.terminal.utils.zoxide.shellIntegration.alias}" = "zoxide";
      };
    };
  };
}
