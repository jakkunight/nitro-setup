_: {
  # Configure Nixpkgs:
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Enable Flakes!
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # DEPRECATED: Using NH instaed of this.
    # gc = {
    #   automatic = true;
    #   options = "--delete-older-than 15d";
    #   dates = "weekly";
    # };
  };
}
