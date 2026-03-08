{
  lib,
  config,
  ...
}:
let
  cfg = config.networking;
in
{
  options = {
    networking = {
      enable = lib.mkEnableOption "Enable networking in NixOS & home-manager";
    };
  };
  config = lib.mkIf cfg.enable {
    networking = {
      hosts = {
        "10.20.1.1" = [
          "opnsense"
        ];
        "10.20.1.7" = [
          "UCK-G2"
        ];
        "10.20.20.11" = [
          "bazzite"
        ];
        "10.20.20.13" = [
          "crusader"
        ];
        "10.20.20.15" = [
          "bazzite-htpc"
        ];
        "10.20.20.29" = [
          "MiSTer"
        ];
      };
      networkmanager = {
        enable = true;
      };
      nftables = {
        enable = true;
      };
      useDHCP = lib.mkDefault true;
      wireguard.enable = true;
    };
    services.resolved = {
      enable = true;
      settings = {
        Resolve = {
          FallbackDNS = [
            "9.9.9.9"
            "149.112.112.112"
          ];
        };
      };
    };
  };
}
