_: {
  # Nix/Nixpkgs config:
  nix = {
    settings = {
      # Enable Flakes!
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Optimise store after every operation:
      auto-optimise-store = true;
      trustedUsers = [
        "@wheel"
        "root"
      ];

      # Binary caching:
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://hyprland.cachix.org"
        "https://yazi.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
  };

  # Allow unfree software:
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
}
