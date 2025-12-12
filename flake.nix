{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
    flake-file = {
      url = "github:vic/flake-file";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wanderer-grub-theme = {
      url = "github:jakkunight/Wanderer-Themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-parts,
    home-manager,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({
        withSystem,
        config,
        lib,
        ...
      } @ top: {
        imports = [
          flake-parts.flakeModules.modules
          home-manager.flakeModules.home-manager
        ];
        systems = [
          "x86_64-linux"
        ];
        perSystem = {
          config,
          pkgs,
          ...
        }: {
          # Packages and Devshells
        };
        flake = {
          # NixOS modules:
          # Home Manager modules:
        };
      });
}
