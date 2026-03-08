{
  config,
  inputs,
  lib,
  username,
  pkgs,
  vars,
  ...
}:
let
  accent-lower = "lavender";
  accent-upper = "Lavender";
  flavor-lower = "mocha";
  flavor-upper = "Mocha";
  cfg = config.catppuccinTheming;
  mono-font = "Maple Mono Normal NF";
  sans-font = "Inter";
  sans-font-pkg = pkgs.inter;
  #serif-font = "IBM Plex Serif";
  GTK-THEME = "Breeze-Dark";
  #cursor-theme = "breeze_cursors";
  cursor-theme = "catppuccin-${flavor-lower}-${accent-lower}-cursors";
  icon-theme = "Papirus-Dark";
  #wallpaper = "lavender-wave-haikei.png";
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/2k/wallhaven-2kpexy.jpg";
    hash = "sha256-vSzbsrAg6EalV5FzvHPQRS1qdhjJpDSjda4M+s8ACU4=";
  };
in
{
  options = {
    catppuccinTheming = {
      enable = lib.mkEnableOption "Enable catppuccinTheming in NixOS & home-manager";
    };
  };
  config = lib.mkIf cfg.enable {
    catppuccin = {
      enable = true;
      cache.enable = false;
      accent = "${accent-lower}";
      flavor = "${flavor-lower}";
      sddm = {
        background = "${wallpaper}";
        font = "${mono-font}";
        fontSize = "11";
      };
    };
    console = {
      packages = with pkgs; [ terminus_font ];
    };
    environment = {
      sessionVariables = {
        # Breaks theming but forces the color scheme
        #GTK_THEME = "${GTK-THEME}";
      };
      systemPackages = with pkgs; [
        (catppuccin-papirus-folders.override {
          accent = "${accent-lower}";
          flavor = "${flavor-lower}";
        })
      ];
    };

    nix.settings = {
      extra-substituters = [
        "https://catppuccin.cachix.org"
      ];
      extra-trusted-public-keys = [
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
    };

    services = {
      displayManager = {
        sddm = {
          settings = {
            Theme = {
              CursorTheme = "${cursor-theme}";
            };
          };
        };
      };
    };

    programs.dconf.enable = true;

    home-manager.users.${username} =
      {
        inputs,
        lib,
        config,
        username,
        pkgs,
        ...
      }:
      {
        catppuccin = {
          enable = true;
          accent = "${accent-lower}";
          flavor = "${flavor-lower}";
          cache.enable = false;
          cursors = {
            enable = true;
            accent = "${accent-lower}";
          };
          fzf = {
            accent = "${accent-lower}";
          };
          lazygit = {
            accent = "${accent-lower}";
          };
          mangohud.enable = false;
          micro = {
            transparent = true;
          };
          vscode = {
            profiles.default = {
              accent = "${accent-lower}";
            };
          };
          yazi = {
            accent = "${accent-lower}";
          };
        };

        dconf.settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };

        gtk = {
          enable = true;
          cursorTheme = {
            name = "${cursor-theme}";
            size = 24;
          };
          font = {
            name = "${sans-font}";
            size = 12;
            package = sans-font-pkg;
          };
          gtk2 = {
            force = true;
          };
          gtk3 = {
            extraConfig = {
              gtk-application-prefer-dark-theme = true;
              gtk-button-images = true;
              gtk-decoration-layout = "icon:minimize,maximize,close";
              gtk-enable-animations = true;
              gtk-menu-images = true;
              gtk-modules = "colorreload-gtk-module";
              gtk-primary-button-warps-slider = true;
              gtk-sound-theme-name = "ocean";
              gtk-toolbar-style = "3";
              gtk-xft-antialias = 1;
              gtk-xft-hinting = 1;
              gtk-xft-hintstyle = "hintslight";
              gtk-xft-rgba = "rgb";
            };
          };
          gtk4 = {
            extraConfig = {
              gtk-decoration-layout = "icon:minimize,maximize,close";
              gtk-enable-animations = true;
              gtk-primary-button-warps-slider = true;
              gtk-sound-theme-name = "ocean";
              gtk-xft-antialias = 1;
              gtk-xft-hinting = 1;
              gtk-xft-hintstyle = "hintslight";
              gtk-xft-rgba = "rgb";
            };
          };
        };
        home = {
          file = {
            catppuccin-gtk = {
              enable = true;
              source = "${pkgs.catppuccin-gtk.override {
                accents = [ accent-lower ];
                variant = flavor-lower;
              }}/share/themes/${GTK-THEME}";
              target = "${config.xdg.configHome}/themes/${GTK-THEME}";
            };
            catppuccin-ghostwriter = {
              enable = true;
              source = "${inputs.catppuccin-ghostwriter}/themes/catppuccin-${flavor-lower}-${accent-lower}.json";
              target = "${config.xdg.dataHome}/ghostwriter/themes/catppuccin-${flavor-lower}-${accent-lower}.json";
            };
            catppuccin-heroic = {
              enable = vars.gaming;
              source = "${inputs.catppuccin-heroic}/themes/catppuccin-${flavor-lower}-${accent-lower}.css";
              target = "Games/Heroic/catppuccin-${flavor-lower}-${accent-lower}.css";
            };
            catppuccin-krita = {
              enable = true;
              text = builtins.readFile ./krita/CatppuccinMochaLavender.colors;
              target = "${config.xdg.dataHome}/krita/color-schemes/Catppuccin${flavor-upper}${accent-upper}.colors";
            };
            catppuccin-obs-flatpak = {
              enable = true;
              recursive = true;
              source = "${inputs.catppuccin-obs}/themes";
              target = ".var/app/com.obsproject.Studio/config/obs-studio/themes";
            };
            catppuccin-powershell = {
              enable = true;
              source = "${inputs.catppuccin-powershell}";
              target = "${config.xdg.dataHome}/powershell/Modules/Catppuccin";
            };
            catppuccin-zen-flatpak = {
              enable = true;
              source = "${inputs.catppuccin-zen}/themes/${flavor-upper}/${accent-upper}";
              target = ".var/app/app.zen_browser.zen/.zen/${username}/chrome";
            };
            cursor-theme-default = {
              enable = false;
              text = ''
                [Icon Theme]
                Inherits=${cursor-theme}
              '';
              target = "${config.xdg.dataHome}/icons/default/index.theme";
            };
            darkly-config = {
              enable = false;
              text = builtins.readFile ./darklyrc;
              target = "${config.xdg.configHome}/darklyrc";
            };
            # Flatpak theming issue workarounds
            flatpak-font = {
              enable = true;
              source = "${pkgs.inter}/share/fonts/opentype";
              target = "${config.xdg.dataHome}/fonts/inter";
            };
            gtk3-config-colors = {
              enable = true;
              text = builtins.readFile ./gtk-3.0/colors.css;
              target = "${config.xdg.configHome}/gtk-3.0/colors.css";
            };
            gtk3-config-gtk = {
              enable = true;
              text = builtins.readFile ./gtk-3.0/gtk.css;
              target = "${config.xdg.configHome}/gtk-3.0/gtk.css";
            };
            gtk4-config-colors = {
              enable = true;
              text = builtins.readFile ./gtk-4.0/colors.css;
              target = "${config.xdg.configHome}/gtk-4.0/colors.css";
            };
            gtk4-config-gtk = {
              enable = true;
              text = builtins.readFile ./gtk-4.0/gtk.css;
              target = "${config.xdg.configHome}/gtk-4.0/gtk.css";
            };
            powershell-profile = {
              enable = true;
              text = ''
                Import-Module Catppuccin
                $Flavor = $Catppuccin['${flavor-upper}']
              '';
              target = "${config.xdg.configHome}/powershell/Microsoft.PowerShell_profile.ps1";
            };
            wallpapers = {
              enable = true;
              recursive = true;
              source = ./wallpapers;
              target = "${config.home.homeDirectory}/Pictures/wallpapers";
            };
          };
          packages = with pkgs; [
            hicolor-icon-theme
            ## GNOME
            adwaita-icon-theme
            gnome-settings-daemon
            gsettings-desktop-schemas
            gsettings-qt
          ];
          sessionVariables = {
            GSETTINGS_BACKEND = "keyfile";
            GTK_USE_PORTAL = "1";
            LS_COLORS = "$(${lib.getExe pkgs.vivid} generate catppuccin-${flavor-lower})";
            XCURSOR_NAME = "${cursor-theme}";
            XCURSOR_SIZE = "24";
          };
        };
        programs = {
          bat = {
            config = {
              pager = "less -FR";
            };
          };
          btop = {
            settings = {
              theme_background = false;
            };
          };
          freetube = {
            settings = {
              baseTheme = "catppuccin${flavor-upper}";
            };
          };
          halloy = {
            settings = {
              font = {
                family = "${mono-font}";
                size = 20;
              };
            };
          };
          helix = {
            settings = {
              theme = lib.mkForce "catppuccin_transparent";
            };
            themes = {
              catppuccin_transparent = {
                "inherits" = "catppuccin-${flavor-lower}";
                "ui.background" = "none";
              };
            };
          };
          lazygit = {
            settings = {
              gui = {
                border = "single";
                mainPanelSplitMode = "vertical";
                nerdFontsVersion = "3";
                scrollHeight = 10;
                scrollOffMargin = 4;
                showFileTree = false;
                sidePanelWidth = 0.3333;
              };
            };
          };
          lazyvim = {
            plugins = {
              colorscheme = ''
                return {
                  "catppuccin/nvim",
                  opts = { flavour = "mocha", transparent_background = true },
                  {
                    "LazyVim/LazyVim",
                    opts = {
                      colorscheme = "catppuccin",
                    },
                  }
                }
              '';
            };
          };
          nvf = {
            settings = {
              vim = {
                theme = {
                  enable = true;
                  name = "catppuccin";
                  style = "mocha";
                  transparent = true;
                };
              };
            };
          };
          vscode = {
            profiles = {
              default = {
                userSettings = {
                  "editor.fontFamily" = "'${mono-font}', 'monospace', monospace";
                  "editor.fontLigatures" = true;
                  "editor.fontSize" = 18;
                  "terminal.integrated.fontFamily" = "${mono-font}";
                  "terminal.integrated.fontSize" = 14;
                  "terminal.integrated.fontWeight" = "normal";
                };
              };
            };
          };
        };
        services = {
          flatpak = {
            overrides = {
              "com.fightcade.Fightcade" = {
                Environment = {
                  GTK_THEME = "${GTK-THEME}";
                };
              };
              "app.zen_browser.zen" = {
                Environment = {
                  GTK_THEME = "${GTK-THEME}";
                };
              };
            };
          };
          xsettingsd = {
            settings = {
              "Gtk/CursorThemeSize" = 24;
              "Gtk/CursorThemeName" = "${cursor-theme}";
              "Gtk/FontName" = "${sans-font},  12";
              "Net/IconThemeName" = "${icon-theme}";
              "Net/ThemeName" = "${GTK-THEME}";
            };
          };
        };

        xresources = {
          properties = {
            "Xcursor.size" = 24;
            "Xcursor.theme" = "${cursor-theme}";
            "Xft.autohint" = 1;
            "Xft.lcdfilter" = "lcddefault";
            "Xft.hintstyle" = "hintfull";
            "Xft.hinting" = 1;
            "Xft.antialias" = 1;
            "Xft.rgba" = "rgb";
            # Catppuccin
            "*background" = "#1E1E2E";
            "*foreground" = "#CDD6F4";
            "*color0" = "#45475A";
            "*color8" = "#585B70";
            "*color1" = "#F38BA8";
            "*color9" = "#F38BA8";
            "*color2" = "#A6E3A1";
            "*color10" = "#A6E3A1";
            "*color3" = "#F9E2AF";
            "*color11" = "#F9E2AF";
            "*color4" = "#89B4FA";
            "*color12" = "#89B4FA";
            "*color5" = "#F5C2E7";
            "*color13" = "#F5C2E7";
            "*color6" = "#94E2D5";
            "*color14" = "#94E2D5";
            "*color7" = "#BAC2DE";
            "*color15" = "#A6ADC8";
          };
        };
      };
  };
}
