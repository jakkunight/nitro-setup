_: {
  flake.modules.nixos."terminal/system-monitor/btop" = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      btop
    ];
  };
  flake.modules.homeManager."terminal/system-monitor/btop" = {pkgs, ...}: {
    programs.btop = {
      enable = true;
    };
  };
}
