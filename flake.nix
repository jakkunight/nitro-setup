{
  description = "My NixOS configuration";

  inputs = {
    #### Core apps ####
    # Nixpkgs:
    nixpkgs = {
      url = "github:nixos/nixpkgs";
    };

    # Home-Manager:
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko:
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix:
    stylix = {
      url = "github:danth/stylix";
    };

    # NVF:
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-SOPS:
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS-Generators:
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Yazi:
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland:
    hyprland = {
      url = "github:/hyprwm/Hyprland";
    };

    #### Other apps ####
    # Zen Browser:
    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #### My own packages (?) ####
    # Genshin Impact font (with NF glyphs):
    genshin-font = {
      url = "github:jakkunight/GenshinImpact-font";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    sops-nix,
    stylix,
    nvf,
    nixos-generators,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nitro = let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in
        nixpkgs.lib.nixosSystem
        {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = false;
                extraSpecialArgs = {
                  inherit inputs;
                };
              };
            }
            stylix.nixosModules.stylix
            nvf.nixosModules.nvf
            sops-nix.nixosModules.sops
          ];
        };
    };
  };
}
