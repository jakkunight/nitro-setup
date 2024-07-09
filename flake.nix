# /mnt/etc/nixos/flake.nix
{
  inputs = {
    # NOTE: Replace "nixos-23.11" with that which is in system.stateVersion of
    # configuration.nix. You can also use latter versions if you wish to
    # upgrade.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    envfs = {
      url = "github:Mic92/envfs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nitro = nixpkgs.lib.nixosSystem {
          # NOTE: Change this to aarch64-linux if you are on ARM
          inherit system;
          specialArgs = { inherit inputs; }; # this is the important part
          modules = [
            ./hosts/nitro/configuration.nix
            inputs.disko.nixosModules.disko
            inputs.envfs.nixosModules.envfs
            inputs.nix-ld.nixosModules.nix-ld
            {
              nix = {
                settings.experimental-features = [ "nix-command" "flakes" ];
              };
            }
          ];
        };
      };
      homeConfigurations = {
        jakku = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/nitro/home.nix
          ];
        };
      };
      devShells."${system}".default = (import ./shell.nix { inherit pkgs; });
    };
}
