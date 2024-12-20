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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home Manager:
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Old Yazi (v3.2)
    old-yazi = {
      url = "github:nixos/nixpkgs/45508c1098a3fb7140ae3d86414cee8f5ee7511c";
    };
    # Hyprpanel:
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # Hy3:
    hy3 = {
      url = "github:outfoxxed/hy3"; # where {version} is the hyprland release version
      # or "github:outfoxxed/hy3" to follow the development branch.
      # (you may encounter issues if you dont do the same for hyprland)
      inputs.hyprland.follows = "hyprland";
    };
    # Disko:
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Devenv:
    devenv-repo = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Hyprland:
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # EnvFS:
    # Nix-LD:
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NixOS-GRUB2-Themes:
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    # NixVim:
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Wezterm:
    wezterm-repo = {
      url = "github:wez/wezterm?dir=nix";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations = {
        # iso = lib.nixosSystem {
        #   modules = [
        #     "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
        #     "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
        #     ./
        #   ];
        #   specialArgs = { inherit inputs outputs; };
        # };
        nitro = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs.inputs = inputs;
          modules = [
            inputs.nix-ld.nixosModules.nix-ld
            { programs.nix-ld.dev.enable = true; }
            inputs.disko.nixosModules.disko
            ./disk/disk.nix
            { _module.args.disks = [ "/dev/nvme0n1" ]; }
            ./basic/config.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };
      };
      # Home-Manager:
      homeConfigurations = {
        jakku = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              inputs.hyprpanel.overlay
            ];
          };
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./users/jakku/home.nix
            inputs.nixvim.homeManagerModules.nixvim
          ];
        };
      };
    };
}
