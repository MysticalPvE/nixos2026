{
  lib,
  config,
  username,
  fullname,
  pkgs,
  ...
}:
let
  cfg = config.users;
in
{
  options = {
    users = {
      enable = lib.mkEnableOption "Enable users in NixOS & home-manager";
    };
  };
  config = lib.mkIf cfg.enable {
    users = {
      defaultUserShell = pkgs.zsh;
      groups = {
        adbusers = { };
        plugdev = { };
      };
      mutableUsers = true;
      users = {
        "${username}" = {
          description = "${fullname}";
          isNormalUser = true;
          # REPLACE_ME: Run 'mkpasswd -m sha-512' and put the hash here
          initialHashedPassword = "REPLACE_ME_PASSWORD_HASH"; 
          extraGroups = [
            "adbusers"
            "i2c"
            "input"
            "networkmanager"
            "plugdev"
            "realtime"
            "uinput"
            "video"
            "wheel"
            "ydotool"
          ];
          openssh.authorizedKeys.keys = [
            "REPLACE_ME_SSH_PUBLIC_KEY"
          ];
        };
      };
    };
    home-manager.users.${username} = { };
  };
}
