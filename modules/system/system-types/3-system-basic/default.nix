{ self, inputs, ... }:
{
  flake.modules.nixos."3-system-basic" = {
    imports = with self.modules.nixos; [
      "2-system-essential"
      core
      ntfs3g
    ];
  };
}
