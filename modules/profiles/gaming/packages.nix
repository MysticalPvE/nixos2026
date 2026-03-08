{
  pkgs,
  inputs,
  config,
  ...
}:
with pkgs;
{
  games = [
    ## Doom
    #acc
    #inputs.nur-bandithedoge.legacyPackages.${stdenv.hostPlatform.system}.cherry-doom
    #chocolate-doom
    #crispy-doom
    #darkradiant
    #doomrunner
    #doomseeker
    #dsda-doom
    #nugget-doom
    #inputs.nur-bandithedoge.legacyPackages.${stdenv.hostPlatform.system}.nyan-doom
    #odamex
    #slade
    #uzdoom
    #woof-doom
    #zandronum
    ## Fallout
    #fallout-ce
    #fallout2-ce
    ## Freespace
    #descent3
    #dxx-rebirth
    #knossosnet
    ## HOMM
    #fheroes2
    #vcmi
    ## Morrowind
    #tes3cmd
    #openmw
    ## Quake
    #ironwail
    #quake-injector
    ## Arma
    #arma3-unix-launcher
    # (arma3-unix-launcher.override { buildDayZLauncher = true; })
    ## Duke
    #rigel-engine
    ## Wolf
    #bstone
    #ecwolf
    #etlegacy
    ## Other
    #abuse
    #arx-libertatis # Arx Fatalis
    #augustus # Caesar 3
    #bolt-launcher # RuneScape
    #corsix-th # Theme Hospital
    #gamma-launcher
    #isle-portable
    #jazz2
    #katawa-shoujo-re-engineered
    #openjk # Jedi Academy
    #openloco
    #openomf
    #openrct2
    #openttd
    #opentyrian
    #openxcom
    #openxray # STALKER
    #rsdkv3
    #sdlpop # Prince of Persia
    #serious-sam-classic-vulkan
    #sm64ex
    #theforceengine # Dark Forces / Outlaws
    #urbanterror
    #vvvvvv
    #wipeout-rewrite
    #yarg
    #zelda64recomp
  ];
  tools = [
    ## Emulators
    #_86box-with-roms
    # archipelago
    # bizhawk
    #dosbox-staging
    #easyrpg-player
    #hypseus-singe
    #mednafen
    #mednaffe
    #mesen
    #scummvm
    #shadps4
    #inputs.nur-bandithedoge.legacyPackages.${stdenv.hostPlatform.system}.sheepshaver-bin
    #xenia-canary
    ## Input
    joystickwake
    oversteer
    sc-controller
    ## Launchers & utils
    faugus-launcher
    goverlay
    ## Modding
    hedgemodmanager
    limo
    inputs.just-one-more-repo.packages.${stdenv.hostPlatform.system}.r2modman
    ## Other
    adwsteamgtk
    chiaki-ng
    flips
    gst_all_1.gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gswatcher
    igir
    innoextract
    lgogdownloader
    python314Packages.lnkparse3
    parsec-bin
    protonplus
    tochd
    xlink-kai
    xvidcore
    ## Wine
    umu-launcher
    inputs.nur-bandithedoge.legacyPackages.${stdenv.hostPlatform.system}.winegui
    inputs.nix-gaming.packages.${stdenv.hostPlatform.system}.wine-tkg
    winetricks
    ## One-and-dones
    /*
         glxinfo
         jpsxdec
         mame.tools
         mmv
         nsz
         openspeedrun
         ps3-disc-dumper
         renderdoc
         vgmplay-libvgm
         vgmstream
         vgmtools
         vgmtrans
         vulkan-tools
    */
  ];
  scripts = [
    (writeShellApplication {
      name = "script-exodos-nuked";
      runtimeEnv = {
        EXODOS = "/mnt/crusader/Games/eXo/eXoDOS/eXo/eXoDOS";
      };
      runtimeInputs = [
        fd
        sd
      ];
      text = ''
        fd -t file "run.bat" $EXODOS -x sd 'CONFIG -set "mididevice=fluidsynth"' 'CONFIG -set "mididevice=soundcanvas"' {}
      '';
    })
    (writeShellApplication {
      name = "script-game-stuff";
      runtimeEnv = {
        DREAMM = "https://aarongiles.com/dreamm/releases/dreamm-3.0.3-linux-x64.tgz";
        CONTY = "https://api.github.com/repos/Kron4ek/conty/releases/latest";
        GAMES_DIR = "${config.home.homeDirectory}/Games";
        LOCAL_BIN = "${config.home.homeDirectory}/.local/bin";
      };
      runtimeInputs = [
        coreutils
        curl
        fd
        jq
        wget
      ];
      text = ''
        ## DREAMM
        wget -P "$GAMES_DIR"/dreamm $DREAMM
        fd dreamm -e tgz "$GAMES_DIR"/dreamm -x tar xf {} -c "$GAMES_DIR"/dreamm
        ## Conty
        curl $CONTY | jq -r '.assets[] | select(.name | test("conty_lite.sh$")).browser_download_url' | xargs wget -P "$LOCAL_BIN"
        chmod +x "$LOCAL_BIN"/conty_lite.sh
      '';
    })
  ];
}
