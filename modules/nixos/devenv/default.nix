{pkgs, ...}: {
  nix.settings = {
    substituters = [
      "https://devenv.cachix.org"
    ];
    trusted-substituters = [
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
    trusted-users = [
      "root"
      "jakku"
      "@wheel"
    ];
  };

  programs.nix-ld.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    devenv
  ];
}
