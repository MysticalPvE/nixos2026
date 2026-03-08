{
  lib,
  inputs,
  pkgs,
  config,
  username,
  ...
}:
let
  cfg = config.niri;
in
{
  options = {
    niri = {
      enable = lib.mkEnableOption "Enable niri in NixOS";
    };
  };
  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      autoLogin = {
        enable = true;
        user = "${username}";
      };
      defaultSession = "niri";
    };

    home-manager.users.${username} = {
      xdg.configFile."niri/config.kdl".text = ''
        // Niri Config Migrated from Hyprland Bindings
        
        output "HDMI-A-1" {
            mode "1920x1080@120.000"
        }

        input {
            keyboard {
                xkb {
                    layout "us"
                }
            }
            touchpad {
                tap
                dwt
            }
            mouse {
                accel-profile "flat"
            }
        }

        layout {
            gaps 8
            center-focused-column "never"
            preset-column-widths {
                proportion 0.33333
                proportion 0.5
                proportion 0.66667
            }
            default-column-width { proportion 0.5; }
            focus-ring {
                width 2
                active-color "#f5c2e7"
                inactive-color "#45475a"
            }
        }

        spawn-at-startup "dms-shell"

        binds {
            // General
            Mod+Shift+Slash { show-hotkey-overlay; }
            Ctrl+Q { close-window; }
            Alt+F4 { close-window; }
            Mod+Delete { quit; }
            Mod+W { toggle-window-floating; }
            Shift+F11 { maximize-column; }
            Mod+L { spawn "swaylock"; } // Placeholder for lock
            
            // Focus Navigation
            Mod+Left  { focus-column-left; }
            Mod+Right { focus-column-right; }
            Mod+Up    { focus-window-up; }
            Mod+Down  { focus-window-down; }
            Alt+Tab   { focus-column-right; }

            // Moving Windows
            Mod+Ctrl+Shift+Left  { move-column-left; }
            Mod+Ctrl+Shift+Right { move-column-right; }
            Mod+Ctrl+Shift+Up    { move-window-up; }
            Mod+Ctrl+Shift+Down  { move-window-down; }

            // Resizing
            Mod+Shift+Right { adjust-column-width "+10%"; }
            Mod+Shift+Left  { adjust-column-width "-10%"; }
            Mod+Shift+Up    { adjust-window-height "+10%"; }
            Mod+Shift+Down  { adjust-window-height "-10%"; }

            // Apps
            Mod+T { spawn "wezterm"; }
            Mod+E { spawn "wezterm" "start" "yazi"; }
            Mod+C { spawn "wezterm" "start" "nvim"; }
            Mod+B { spawn "zen"; }
            Ctrl+Shift+Escape { spawn "wezterm" "start" "btop"; }

            // DMS / Rofi replacement Bindings
            Mod+A { spawn "dms-shell" "--launcher"; }
            Mod+Tab { spawn "dms-shell" "--windows"; }
            Mod+V { spawn "dms-shell" "--clipboard"; }

            // Audio
            XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
            XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
            XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
            XF86AudioMicMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

            // Media
            XF86AudioPlay { spawn "playerctl" "play-pause"; }
            XF86AudioPause { spawn "playerctl" "play-pause"; }
            XF86AudioNext { spawn "playerctl" "next"; }
            XF86AudioPrev { spawn "playerctl" "previous"; }

            // Brightness
            XF86MonBrightnessUp { spawn "brightnessctl" "set" "10%+"; }
            XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }

            // Screenshot (using grim/slurp which is standard for Wayland)
            Mod+P { spawn "grim" "-g" "$(slurp)" "-t" "png" "- | wl-copy"; }
            Print { spawn "grim" "-t" "png" "- | wl-copy"; }

            // Workspaces
            Mod+1 { focus-workspace 1; }
            Mod+2 { focus-workspace 2; }
            Mod+3 { focus-workspace 3; }
            Mod+4 { focus-workspace 4; }
            Mod+5 { focus-workspace 5; }
            Mod+6 { focus-workspace 6; }
            Mod+7 { focus-workspace 7; }
            Mod+8 { focus-workspace 8; }
            Mod+9 { focus-workspace 9; }
            Mod+0 { focus-workspace 10; }

            Mod+Shift+1 { move-column-to-workspace 1; }
            Mod+Shift+2 { move-column-to-workspace 2; }
            Mod+Shift+3 { move-column-to-workspace 3; }
            Mod+Shift+4 { move-column-to-workspace 4; }
            Mod+Shift+5 { move-column-to-workspace 5; }
            Mod+Shift+6 { move-column-to-workspace 6; }
            Mod+Shift+7 { move-column-to-workspace 7; }
            Mod+Shift+8 { move-column-to-workspace 8; }
            Mod+Shift+9 { move-column-to-workspace 9; }
            Mod+Shift+0 { move-column-to-workspace 10; }
            
            Mod+Ctrl+Right { focus-workspace-down; }
            Mod+Ctrl+Left  { focus-workspace-up; }
        }
      '';
    };
  };
}
