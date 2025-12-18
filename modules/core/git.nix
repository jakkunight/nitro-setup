{inputs, ...}: {
  flake.modules.nixos."git" = {pkgs, ...}: {
    programs.git.enable = true;
    environment.systemPackages = with pkgs; [
      gitui
    ];
  };
  flake.modules.homeManager."git" = {
    programs = {
      git = {
        enable = true;
      };
      gitui = {
        enable = true;
      };
    };
  };
}
