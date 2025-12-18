{inputs, ...}: {
  flake.modules.nixos."terminal/multiplexer/zellij" = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      zellij
    ];
  };
  flake.modules.homeManager."terminal/multiplexer/zellij" = {pkgs, ...}: {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        pane_frames = false;
      };
    };
  };
}
