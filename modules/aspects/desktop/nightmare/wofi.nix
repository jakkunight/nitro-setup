let
  feature = "nightmare-wofi";
in
{ den, ... }:
{
  den.aspects.${feature}.homeManager =
    { lib, ... }:
    {
      programs.wofi = {
        settings = {
          allow_images = true;
        };
        style = lib.mkAfter ''
          * {
            background: transparent;
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
