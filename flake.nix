# flake.nix
{
  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*";
    flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/*";
    import-tree.url = "github:vic/import-tree";
    # all other inputs your flake needs, like nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "https://flakehub.com/f/nix-community/disko/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "https://flakehub.com/f/numtide/treefmt-nix/*";
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
