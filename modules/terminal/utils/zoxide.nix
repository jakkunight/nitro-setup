{ lib, config, pkgs, ... }: {
  options = {
    terminal.utils.zoxide = {
      enable = lib.mkEnableOption "Enable zoxide.";
      zshIntegration = {
        enable = lib.mkEnableOption "Enable ZSH integration.";
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
      environment.shallAliases = lib.mkIf config.terminal.utils.zoxide.zshIntegration.enable {
        "${config.terminal.utils.zoxide.alias}" = "zoxide";
      };
    };
  };
}
