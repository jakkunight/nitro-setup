{
  description = "My Setup Settings (v0.5.0)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:nix-community/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zjstatus = {
      url = "github:dj95/zjstatus";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland?submodules=1";
    };
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    genshin-font = {
      url = "github:jakkunight/GenshinImpact-font";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wanderer-grub-theme = {
      url = "github:jakkunight/Wanderer-Themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox.url = "github:adriankarlen/textfox";
  };
  outputs = {
    nixpkgs,
    home-manager,
    disko,
    stylix,
    sops-nix,
    zjstatus,
    flake-parts,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({
        config,
        withSystem,
        moduleWithSystem,
        ...
      } @ top: {
        imports = [];
        systems = ["x86_64-linux"];
        # perSystem = {
        #   config,
        #   pkgs,
        #   ...
        # }: {};
        flake = {
          nixosConfigurations = {
            nitro = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs;
              };
              modules = [
                sops-nix.nixosModules.sops
                stylix.nixosModules.stylix
                disko.nixosModules.disko
                ./configuration.nix
              ];
            };
          };
          homeConfigurations = {
            "jakku" = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = {
                inherit inputs;
              };
              modules = [
                stylix.homeModules.stylix
                ./home.nix
              ];
            };
          };
          packages.x86_64-linux.live = inputs.nixos-generators.nixosGenerate {
            inherit system;
            specialArgs = {
              inherit inputs;
            };
            format = "install-iso";
            modules = [
              (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
              sops-nix.nixosModules.sops
              stylix.nixosModules.stylix
              disko.nixosModules.disko
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users = {
                    jakku = ./home.nix;
                  };
                  extraSpecialArgs = let
                    pkgs = import nixpkgs {
                      inherit system;
                      config.allowUnfree = true; # Allow unfree packages here
                    };
                  in {inherit inputs pkgs;};
                };
              }
              ./configuration.nix
            ];
          };
        };
      });
}
