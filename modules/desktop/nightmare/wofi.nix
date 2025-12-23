_: {
  flake.modules.homeManager."desktop/nightmare/wofi" = {
    pkgs,
    lib,
    ...
  }: {
    programs.wofi = {
      enable = true;
      package = pkgs.wofi;
      settings = {
        allow_images = true;
      };
      style = lib.mkAfter ''
        * {
          background: alpha(@base01, 0.90);
        }

        #window {
          margin: auto;
          padding: 10px;
        }

        #input {
          padding: 10px;
          margin-bottom: 10px;
        }

        #outer-box {
          padding: 20px;
        }

        #img {
          margin-right: 6px;
        }

        #entry {
          padding: 10px;
        }

        #text {
          margin: 2px;
        }

      '';
    };
  };
}
