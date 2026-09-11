let
  feature = "serpantinum-shell";
in
{ self, inputs, ... }: {
  flake.modules.nixos.${feature} = { lib, ... }: {
    services.tlp.pd.enable = lib.mkForce false;
    services.tlp.enable = lib.mkForce false;
  };
  flake.modules.homeManager.${feature} = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      easyeffects
      wl-clipboard-rs
    ];
    programs.serpantinum = {
      systemd.enable = true;
      settings = {
        wallpaperDir = "${
          self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers
        }/share/wallpapers";

        general = {
          language = "es_PY";
          # weatherUnit = "metric";
          # weatherInterval = 30;
        };

        bar = {
          position = "top";
          style = "solid";
          width = 40;
          workspaceCount = 10;
          modules = {
            left = [ "workspaces" ];
            center = [ "time" ];
            right = [
              "tray"
              [
                "kb"
                "wifi"
                "bt"
                "vol"
                "bat"
              ]
            ];
          };
        };

        theme = {
          fontFamily = "Mononoki Nerd Font";
          borderRadius = 12;
          matugen = true;
        };

        notifications = {
          dnd = false;
          position = "top right";
          sound = true;
        };
      };
    };
    wayland.windowManager.hyprland = {
      settings = {
        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                hl.exec_cmd("wl-paste --type text --watch cliphist store")
                hl.exec_cmd("wl-paste --type image --watch cliphist store")
                hl.exec_cmd("systemctl --user enable --now easyeffects")
              end
            '')
          ];
        };
      };
    };
  };
}
