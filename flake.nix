{
  description = "Keenan's Nix Flake";

  inputs = {
    #nixpkgs-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    #parition disks
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #impermanence
    impermanence.url = "github:nix-community/impermanence";

    #declare flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    #nix-locate
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #file manager plugins
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #iso builder
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #user repo
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-bandithedoge.url = "github:bandithedoge/nur-packages";
    
    #neovim
    nvf.url = "github:notashelf/nvf";
    
    #vim editor
    lazyvim.url = "github:pfassina/lazyvim-nix";

    # Gaming
    #moonlight client
    apollo = {
      url = "github:nil-andreas/apollo-flake";
    };
    #proton
    dw-proton.url = "github:imaviso/dwproton-flake";
    
    #lossless scaling
    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #cachyos kernels
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    
    #rom manager
    rom-properties = {
      url = "github:Whovian9369/rom-properties-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #idk have to figure out what it does
    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    just-one-more-repo = {
      url = "github:ProverbialPennance/just-one-more-repo";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #seems like audio
    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #useful gaming options
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming-edge = {
      url = "github:powerofthe69/nix-gaming-edge/nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #reshade
    nix-reshade.url = "github:LovingMelody/nix-reshade";

    #for steam config
    steam-config-nix = {
      url = "github:different-name/steam-config-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #the steam alternative launcher
    umu.url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";

    #raw accel
    yeetmouse = {
      url = "github:AndyFilter/YeetMouse?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    catppuccin-ghostwriter = {
      url = "github:catppuccin/ghostwriter";
      flake = false;
    };
    catppuccin-heroic = {
      url = "github:catppuccin/heroic";
      flake = false;
    };
    catppuccin-obs = {
      url = "github:catppuccin/obs";
      flake = false;
    };
    catppuccin-powershell = {
      url = "github:catppuccin/powershell";
      flake = false;
    };
    catppuccin-xresources = {
      url = "github:catppuccin/xresources";
      flake = false;
    };
    catppuccin-zen = {
      url = "github:catppuccin/zen-browser";
      flake = false;
    };

    # Niri
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # DMS
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations =
        let
          fullname = "REPLACE_ME_FULLNAME";
          username = "REPLACE_ME_USERNAME";
        in
        {
          # Desktop
          nixos-desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = {
              inherit inputs;
              inherit fullname username;

              vars = {
                desktop = true;
                gaming = true;
              };
            };

            modules = with inputs; [

              ./hosts/desktop

              apollo.nixosModules.x86_64-linux.default
              catppuccin.nixosModules.catppuccin
              disko.nixosModules.disko
              ./hosts/desktop/disko.nix
              { _module.args.disks = [ "/dev/disk/by-id/REPLACE_ME_DISK_ID" ]; }
              dms.nixosModules.dank-material-shell
              dms-plugin-registry.modules.default
              impermanence.nixosModules.impermanence
              just-one-more-repo.nixosModules.default
              lsfg-vk-flake.nixosModules.default
              niri.nixosModules.niri
              nix-flatpak.nixosModules.nix-flatpak
              nix-gaming-edge.nixosModules.default
              nur.modules.nixos.default
              yeetmouse.nixosModules.default
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  backupFileExtension = "hmbak";
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit inputs; # Experiment with config and other attributes
                    inherit fullname username;

                    vars = {
                      desktop = true;
                      gaming = true;
                    };
                  };
                  sharedModules = with inputs; [
                    catppuccin.homeModules.catppuccin
                    lazyvim.homeManagerModules.default
                    nix-flatpak.homeManagerModules.nix-flatpak
                    nix-index-database.homeModules.nix-index
                    nur.modules.homeManager.default
                    nvf.homeManagerModules.default
                    steam-config-nix.homeModules.default
                    wayland-pipewire-idle-inhibit.homeModules.default
                  ];
                };
              }
            ];
          };
        };
    };
}
