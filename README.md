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
- Modules are classified into programs and services.
- Offline ISO installers will be created by NixOS-Generators. They have to
  include all the available firmware support.
- User modules and configurations will be handled by Home-Manager.
- Home-Manager will be used as a NixOS module, but there will be a
  `homeConfigurations` output in the `flake.nix` to port the users' config to
  non-NixOS distros as well.
- Modules are grouped together by purpose for convenience.
- Every program, module and service must have an option to be enabled or
  disabled, in order to make easy to build new system configurations.
- There's only one active module configuration at a time for each host, though
  user configuration con override the system configuration.

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

### Users

1. Create a `user/default.nix` at the `users/` directory and fill it up with the
   settings of the new user, such as default shell, name, and groups.
2. Import it into the `host/default.nix` that will be used by the user.
3. Create a new `home.nix` at the `users/` folder and fill it with the basic
   Home-Manager configurations. It will also import and enable all the desired
   home modules and configurations.
4. Create a new user configuration at the `homeConfigurations` output on the
   `flake.nix` file.
5. Import the `user/home.nix` file where is needed.

### Grouped Modules

1. Create a new `grouped-module/default.nix` at the `modules` folder.
2. Create the new modules.
3. Import the created modules into this one.
4. Add an option to enable or disable the `grouped-module`.

### Modules

1. Create a `module/default.nix` at the `modules/grouped/module/path/` folder.
2. Add the enable options to the module.
3. Add the programs or NixOS settings to configure.
4. Import the module into the immediate superior grouped module.

### Configurations

1. Create a `module/configuration.nix` at the
   `configurations/grouped/module/path/` folder.
2. Add it to the `module/default.nix` options to select the active
   configuration.
3. Import the `module/default.nix` file into the host or user configuration file
   and select the active module configuration via the options.
