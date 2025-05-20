# NixOS Setup: A NixOS framework to manage Everything, Everywhere, Everytime

This is the general guide to build reliable, multi-user and multi-host configs
with NixOS.

## Goals

- Making portable setups that can be installed and configured without any
  internet connection.
- Managing multiple users, hosts, modules, home configurations, and secrets from
  the same project.
- To have fun learning more about the Nix ecosystem.

## Principles

- Modules are different from their configurations. For instance, the program
  `yazi` can be installed at `host-a`, but being used "as it". It only means
  that a user, via Home-Manager, has to activate a configuration for that
  program, or another host has to select a system-wide configuration for it.
- Modules and configurations are not tied to any hosts or users. This means that
  every program will be enabled or disabled from the main `host/default.nix`,
  `user/default.nix` and `home.nix` files of each host and user.
- System (host) and Home (user) configurations and modules are treated
  separately.
- Secrets are managed by SOPS-NIX.
- Styling is manged by Stylix.
- Disk layout is managed by Disko.
- Modules are classified into programs and services. Both can be classified into
  other categories.
- Offline ISO installers will be created by NixOS-Generators. They have to
  include all the available firmware support and the configuration that
  generated the installer.
- User modules and configurations will be handled by Home-Manager.
- Home-Manager will be used as a NixOS module, but there will be a
  `homeConfigurations` output in the `flake.nix` to port the users' config to
  non-NixOS distros as well.
- Modules are grouped together by purpose for convenience.
- Every program, module and service must have an option to be enabled or
  disabled, in order to make easy to build new system configurations.
- There's only one active module configuration at a time for each host, though
  each user configuration con override the system configuration.
- If the configuration is too complex to keep it into one file, it could be
  split into a folder, with a `default.nix` file as the entry file.

## Adding new things

> [!IMPORTANT] All the paths are relative to the project's root folder.

### Hosts

1. Create a `host/default.nix` at the `hosts/` directory.
2. Fill up the file with the desired configurations. Remember that NixOS needs
   at very least the hostname, a bootloader, disk layout, the correct CPU kernel
   modules, the storage kernel modules, the timezone and language settings, and
   a terminal text editor to be able to boot and edit the configuration.
3. Create a new host configuration at the `flake.nix` file and import the host
   configuration as a module.

Here's a code snippet for the new host file:

```nix
# hosts/hostname/default.nix
{ modulesPath, config, lib, pkgs, inputs, ... }: {
    imports = [
        # Import all modules and configs:
        ../../modules
        ../../configurations

        # Don't forget to replace with the correct user config file:
        ../../users/user
    ];

    # This must match the platform architecture:
    nixpkgs.hostPlatform = "x86_64-linux";

    # This must match the hostname:
    networking.hostName = "hostname";

    time.timeZone = "America/Asuncion";
    i18n.defaultLocale = "es_PY.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        keyMap = "la-latin1";
        useXkbConfig = true;
    };
    system.stateVersion = "25.05" # The latest stable version of NixOS.

    users.defaultUserShell = pkgs.zsh # Choose the shell you like.

    # Hardware options:
    modules.system.hardware = {
        disk = {
            enable = true;

            # Make sure that the configuration file exists at
            # `configurations/system/hardware/disk/` directory:
            configuration = "simple";

            # Make sure that this is a valid path to the device file
            # at `/dev`
            device = "/dev/nvme0n1p1";
        };

        boot = {
            enable = true;

            # Make sure this is a valid option at the module's declaration:
            loader = "systemd-with-grub-menu";

            # Make sure the configuration file exists at
            # `configurations/system/hardware/boot/<loader>/` directory:
            configuration = "my-config";
        };

        cpu = {
            enable = true;

            # Make sure this is a valid option at the module's declaration:
            vendor = "intel";

            # Make sure the configuration file exists at
            # `configurations/system/hardware/cpus/<vendor>/` directory:
            configuration = "default";
        };
    };
}
```

And here is a snippet to add it into the `flake.nix` file:

```nix
# flake.nix
{
    inputs = {
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

        # ...
    };
    outputs = { nixpkgs, home-manager, disko, ... } @ inputs: {
        nixosConfigurations = {
            hostname = let
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
                    # Home-Manager is mandatory here!
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

                    # Disko is mandatory here!
                    disko.nixosModules.disko

                    # Other modules:
                    inputs.stylix.nixosModules.stylix
                    inputs.nvf.nixosModules.nvf
                    inputs.sops-nix.nixosModules.sops

                    # Archivo de configuración principal:
                    ./hosts/hostname
                ];
            };
        };
    };
}
```

### Users

1. Create a `user/default.nix` at the `users/` directory and fill it up with the
   settings of the new user, such as default shell, name, and groups.
2. Import it into the `host/default.nix` that will be used by the user.
3. Create a new `home.nix` at the `users/` folder and fill it with the basic
   Home-Manager configurations. It will also import and enable all the desired
   home modules and configurations.
4. Create a new user configuration at the `homeConfigurations` output on the
   `flake.nix` file. Make sure is pointing to the correct user's `home.nix`
   file.
5. Import the `user/home.nix` file where is needed.

```nix
# Creates user:
{
  config,
  lib,
  ...
}: {

    users.users.myname = {
        isNormalUser = true;
        initialPassword = "1234";
        extraGroups = [
            # Enable ‘sudo’ for the user
            "wheel"
            # Enable networking for the user
            "networkmanager"
            # Enable virtualization for the user
            "libvirtd"
        ];
        # Use the default shell:
        useDefaultShell = true;

        # Or provide your own with:
        # useDefaultShell = false;
        # shell = <your_shell_package>

        # Add the user to the Nix store trusted users:
        nix.settings.trusted-users = [
            "myname"
            "root"
            "@wheel"
        ];
    };
}
```

### Grouped Modules

1. Create a new `grouped-module/default.nix` at the `modules` folder.
2. Create the new modules.
3. Import the created modules into this one.
4. Add an option to enable or disable the `grouped-module`.

Example:

```nix
# modules/system/utils/default.nix
{ config, lib, ... }: {
    imports = [
        # Submódulos:
        # ...
    ];
    # You can also set some defaults here:
    config.modules.system.utils = {
        submodule1.enable = lib.mkDefault true;
        # ...
    };
}
```

### Modules

1. Create a `module/default.nix` at the `modules/grouped/module/path/` folder.
2. Add the enable options to the module.
3. Add the programs or NixOS settings to configure.
4. Import the module into the immediate superior grouped module.

Here's a code snippet for the module:

```nix
# modules/home/tools/my-module/default.nix
{ config, lib, ... }: 
let
    cfg = options.modules.home.tools.my-module;

    # Use as much ".." as you need in the path to reach the project's root folder:
    configurations = builtins.attrNames (lib.attrsets.readDir ./../../../configurations/home/tools/my-module);
in
{
    options.modules.home.tools.my-module = {
        # The "enable" options is mandatory:
        enable = lib.mkEnableOption "Wether to enable this module.";

        # More options:
        # ...
    };
    config = lib.mkIf config.options.modules.home.tools.my-module.enable {
        # Here goes the module:
        # ...
    };
}
```

> [!NOTE]
> Notice that not all modules need a `configuration` option.

### Configurations

1. Create a `module/configuration.nix` at the
   `configurations/grouped/module/path/` folder.
2. Add it to the `module/default.nix` options to select the active
   configuration.
3. Import the `module/default.nix` file into the host or user configuration file
   and select the active module configuration via the options.

Example:

```nix
# hosts/hostname/default.nix
{ config, ... }: {
    imports = [
        ../../modules
        # ...
    ];
    # ...
    config.module.system.utils.my-util = {
        enable = true;
        configuration = "my-config";
        # ...
    };
    # ...
}
```

> [!NOTE]
> The configuration path for a module **ALWAYS** mimics its path at the
> `modules/` folder.
