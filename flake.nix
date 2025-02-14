{
  description = ''
    My Setup Settings (v3.0.0)
  '';

  # Enable Cachix:
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    # Nixpkgs:
    nixpkgs = {
      url = "github:nixos/nixpkgs";
    };

    # Home Manager:
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Yazi
    yazi = {
      url = "github:sxyazi/yazi";
    };

    # Devenv:
    devenv-repo = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland:
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # NVF:
    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # My Wanderer themes:
    wanderer-themes = {
      url = "github:jakkunight/Wanderer-Themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Genshin Impact font (with NF glyphs):
    genshin-font = {
      url = "github:jakkunight/GenshinImpact-font";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        nitro = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # NVF:
            inputs.nvf.nixosModules.default

            # Host configuration:
            ./hosts/nitro/configuration.nix
          ];
        };
      };
      # Home-Manager:
      homeConfigurations = {
        jakku = inputs.home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./users/jakku/home.nix
          ];
        };
      };
    };
}
