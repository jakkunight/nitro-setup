{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    terminal.shells.nushell = {
      enable = lib.mkEnableOption "Enable the nushell config module";
      default = lib.mkEnableOption "Weather if nushell is your default shell";
    };
  };
  config = lib.mkIf config.terminal.shells.nushell.enable {
    users.defaultUserShell = lib.mkIf config.terminal.shells.nushell.default (lib.mkDefault pkgs.nushell);
    # Install some useful plugins:
    environment.systemPackages = [
      pkgs.nushellPlugins.highlight
      pkgs.nushellPlugins.formats
      pkgs.nushellPlugins.net
      pkgs.nushellPlugins.dbus
      pkgs.nushellPlugins.gstat
      pkgs.nushellPlugins.query
      pkgs.nushellPlugins.units
    ];
  };
}
