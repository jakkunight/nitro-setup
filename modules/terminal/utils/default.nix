{ lib, config, ... }: {
  imports = [
    ./btop.nix
    ./gitui.nix
    ./zoxide.nix
    ./fastfetch.nix
    ./netscanner.nix
    ./tui-journal.nix
    ./serie.nix
    ./wikitui.nix
    ./bat.nix
    ./ripgrep.nix
    ./tldr.nix
    ./mprocs.nix
    ./termusic.nix
    ./speedtest-rs.nix
  ];
  options = {
    terminal.utils = {
      enable = lib.mkEnableOption "Enable TUI/CLI utils.";
    };
  };
  config = lib.mkIf config.terminal.utils.enable {
    terminal.utils = {
      btop.enable = lib.mkDefault true;
      gitui.enable = lib.mkDefault true;
      zoxide = {
        enable = lib.mkDefault true;
        zshIntegration = {
          enable = lib.mkDefault true;
          alias = lib.mkDefault "cd";
        };
      };
      fastfetch.enable = lib.mkDefault true;
      mprocs.enable = lib.mkDefault true;
      bat.enable = lib.mkDefault true;
      netscanner.enable = lib.mkDefault true;
      ripgrep.enable = lib.mkDefault true;
      serie.enable = lib.mkDefault true;
      tui-journal.enable = lib.mkDefault false;
      termusic.enable = lib.mkDefault false;
      wikitui.enable = lib.mkDefault false;
      tldr.enable = lib.mkDefault false;
    };
  };
}
