# flake.nix
{
  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    # nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*";
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    # all other inputs your flake needs, like nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-auth.url = "github:numtide/nix-auth";
    waybar-git = {
      url = "github:Alexays/Waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = {
      url = "github:musnix/musnix";
    };
    # nixos-generators = {
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww.url = "git+https://codeberg.org/LGFae/awww";
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # xremap--flake = {
    #   url = "github:xremap/nix-flake";
    # };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # hyprland-easymotion = {
    #   url = "github:bryewalks/hyprland-easymotion";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # hypr-darkwindow = {
    #   url = "github:micha4w/Hypr-DarkWindow"; # Make sure to change the tag to match your hyprland version
    #   inputs.hyprland.follows = "hyprland";
    # };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    genshin-font = {
      url = "github:jakkunight/GenshinImpact-font";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wanderer-grub-theme = {
      url = "github:jakkunight/Wanderer-Themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprglass = {
    #   url = "github:jakkunight/hyprglass";
    #   inputs.hyprland.follows = "hyprland";
    # };
    oracle-database = {
      url = "github:drupol/nix-oracle-db";
    };
    yorha-grub-theme = {
      url = "github:jakkunight/yorha-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    milk-grub-theme.url = "github:gemakfy/MilkGrub";
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix/";
    oisd = {
      url = "https://big.oisd.nl/domainswild";
      flake = false;
    };
    llama-cpp-turboquant = {
      url = "github:TheTom/llama-cpp-turboquant";
    };
    scarlett2-firmware-nix = {
      url = "github:jakkunight/scarlett2-firmware-nix";
    };
    hermes-agent = {
      url = "github:NousResearch/hermes-agent";
    };
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
