let
  feature = "slow_network";
in
{
  flake.modules = {
    nixos.${feature} =
      { lib, ... }:
      {
        # Tuned for slow (~500 KiB/s) and unstable links.
        nix.settings = {
          # Fewer parallel jobs: prevents N concurrent large downloads
          # from thrashing the link and timing out.
          max-jobs = lib.mkDefault 2;
          cores = lib.mkDefault 4;

          # Retry / timeout resilience.
          download-attempts = lib.mkDefault 10;
          connect-timeout = lib.mkDefault 30;
          stalled-download-timeout = lib.mkDefault 300;

          # Fewer parallel HTTP connections to binary caches.
          http-connections = lib.mkDefault 4;

          # Large buffer = fewer small writes, better throughput on slow links.
          download-buffer-size = lib.mkDefault 524288000;

          # Build from source if a binary download fails instead of aborting.
          fallback = lib.mkDefault true;
          keep-going = lib.mkDefault true;
        };
      };
  };
}
