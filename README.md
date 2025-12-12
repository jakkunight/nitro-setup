# My Setup Settings (v0.5.0b)

This is a setup using the good old [`flake-parts`](https://flake.parts/)
framework and the allmighty
[Determinate Nix](https://docs.determinate.systems/determinate-nix/) Nix
distribution.

The idea behind this is to make my config a bit more... declarative, leveraging
the [Dendritic Nix Pattern](https://dendrix.oeiuwq.com/Dendritic.html) since it
does not force a specific directory structure and makes the thinking more in
terms of "features" instead of NixOS modules, HomeManager modules, Darwin
modules, and so.

## The background problem

Every person who starts creating its NixOS configuration ends with something
like this:

> NOTE: Using SQL to illustrate, since is better understood than Nix

```sql
CREATE TABLE nixos_users (
  -- The most basic information to configure a NixOS user:
  username VARCHAR(128) NOT NULL PRIMARY KEY,
  shell VARCHAR(128) NOT NULL,
  -- This field is a list of extra groups for the user.
  extra_groups VARCHAR(128) NOT NULL,
);

CREATE TABLE nixos_hosts (
  -- The most basic information needed to create a NixOS host:
  hostname VARCHAR(128) NOT NULL PRIMARY KEY,
  system VARCHAR(64) NOT NULL, 
);

CREATE TABLE home_configurations (
  -- The most basic information to create a HomeManager configuration:
  -- Notice that the `home.username` and `home.homeDirectory` can only be set _after_ the user config is also set.
  name VARCHAR(128) NOT NULL PRIMARY KEY
);

-- Modules are identified by their names:
CREATE TABLE home_modules (
  feature VARCHAR(128) NOT NULL PRIMARY KEY
);

CREATE TABLE nixos_modules (
  feature VARCHAR(128) NOT NULL PRIMARY KEY
);

CREATE TABLE home_configuration_modules (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  home_configuration VARCHAR(128) NOT NULL,
  home_module VARCHAR(128) NOT NULL,
  FOREIGN KEY (home_configuration) REFERENCES home_configurations(name),
  FOREIGN KEY (home_module) REFERENCES home_modules(feature)
);

CREATE TABLE nixos_host_modules (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nixos_host VARCHAR(128) NOT NULL,
  nixos_module VARCHAR(128) NOT NULL,
  FOREIGN KEY (nixos_host) REFERENCES nixos_hosts(name),
  FOREIGN KEY (nixos_module) REFERENCES nixos_modules(feature)
);

-- This is the thing we actually want!
CREATE TABLE user_setups (
  -- A user uses a host with a home configuration!
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user VARCHAR(128) NOT NULL,
  nixos_host VARCHAR(128) NOT NULL,
  home_configuration VARCHAR(128) NOT NULL,
  FOREIGN KEY (user) REFERENCES nixos_users(username),
  FOREIGN KEY (nixos_host) REFERENCES nixos_hosts(name),
  FOREIGN KEY (home_configuration) REFERENCES home_configurations(name),
);
```

Although this layout is not necesarily bad, it could (and usually does) split a
single feature into two parts. This is not convenient for obvious reasons. Here
is where the Dendritic pattern enters and ties together both modules into a
single one. Now we're left with this:

```sql
CREATE TABLE nixos_users (
  -- The most basic information to configure a NixOS user:
  username VARCHAR(128) NOT NULL PRIMARY KEY,
  shell VARCHAR(128) NOT NULL,
  -- This field is a list of extra groups for the user.
  extra_groups VARCHAR(128) NOT NULL,
);

CREATE TABLE nixos_hosts (
  -- The most basic information needed to create a NixOS host:
  hostname VARCHAR(128) NOT NULL PRIMARY KEY,
  system VARCHAR(64) NOT NULL, 
);

CREATE TABLE home_configurations (
  -- The most basic information to create a HomeManager configuration:
  -- Notice that the `home.username` and `home.homeDirectory` can only be set _after_ the user config is also set.
  name VARCHAR(128) NOT NULL PRIMARY KEY
);

-- Modules are identified by their names:
CREATE TABLE home_modules (
  feature VARCHAR(128) NOT NULL PRIMARY KEY
);

CREATE TABLE nixos_modules (
  feature VARCHAR(128) NOT NULL PRIMARY KEY
);

-- Features:
CREATE TABLE features (
  feature VARCHAR(128) NOT NULL PRIMARY KEY,
  nixos_module VARCHAR(128) NULL,
  home_module VARCHAR(128) NULL,
  FOREIGN KEY (nixos_module) REFERENCES nixos_modules(feature),
  FOREIGN KEY (home_module) REFERENCES home_modules(feature)
);

CREATE TABLE user_setups (
  -- A user uses a host with a home configuration!
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user VARCHAR(128) NOT NULL,
  nixos_host VARCHAR(128) NOT NULL,
  home_configuration VARCHAR(128) NOT NULL,
  FOREIGN KEY (user) REFERENCES nixos_users(username),
  FOREIGN KEY (nixos_host) REFERENCES nixos_hosts(name),
  FOREIGN KEY (home_configuration) REFERENCES home_configurations(name),
);

CREATE TABLE user_setup_features (
  -- A user uses a host with a home configuration!
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  setup INT NOT NULL,
  feature VARCHAR(128) NOT NULL,
  FOREIGN KEY (setup) REFERENCES user_setups(id),
  FOREIGN KEY (feature) REFERENCES features(feature)
);
```

But now, there's another problem. One user can implement the same feature in a
different way. There could be some conflicts with host settings. So now we have
the classical problem of selecting a concrete implementation for an abstract
feature. We only want a module that implements a certain feature, but also let
us decide which implementation to use.
