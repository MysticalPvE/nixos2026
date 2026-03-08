{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.ssh;
in
{
  options = {
    ssh = {
      enable = lib.mkEnableOption "Enable ssh in NixOS";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enableAskPassword = true;
      startAgent = true;
    };
    services.fail2ban.enable = true;
    services.openssh = {
      enable = true;
      ports = [ 6777 ];
      settings = {
        AllowUsers = [ "${username}" ];
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    home-manager.users.${username} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          lazyssh
          seahorse
          sshs
        ];
        home.sessionVariables = {
          SSH_ASKPASS = lib.getExe' pkgs.seahorse "ssh-askpass";
          SSH_ASKPASS_REQUIRE = "prefer";
        };
        programs.ssh = {
          enable = true;
          enableDefaultConfig = false;
          matchBlocks = {
            "*" = {
              addKeysToAgent = "yes";
            };
            bazzite = {
              hostname = "bazzite";
              user = "bazzite";
            };
            mister = {
              hostname = "mister";
              user = "root";
            };
            mumble = {
              hostname = "game-central.party";
              port = 6777;
            };
            nixos-desktop = {
              hostname = "nixos-desktop";
              port = 6777;
            };
            bazzite-htpc = {
              hostname = "bazzite-htpc";
            };
            opnsense = {
              hostname = "opnsense";
            };
            unifi-CKG2 = {
              hostname = "unifi";
              port = 6777;
              user = "keenanweaver";
            };
            unraid = {
              hostname = "crusader";
              port = 6777;
              user = "root";
            };
          };
        };
      };
  };
}
