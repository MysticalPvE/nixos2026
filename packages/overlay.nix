{ inputs }:

(final: prev: {
  fooyin = prev.callPackage ./fooyin { };
  gpu-screen-recorder = prev.callPackage ./gpu-screen-recorder/gsr.nix { };
  gpu-screen-recorder-notification = prev.callPackage ./gpu-screen-recorder/notif.nix { };
  gpu-screen-recorder-ui = prev.callPackage ./gpu-screen-recorder/ui.nix { };
  inter = prev.callPackage ./inter { };
  /*
    lutris-unwrapped = prev.lutris-unwrapped.overrideAttrs {
      version = "0.5.20";
      src = prev.fetchFromGitHub {
        owner = "lutris";
        repo = "lutris";
        rev = "c45a98a42b71b799d7169abd6ef3bd25f0065f9b";
        hash = "sha256-ycAlVV5CkLLsk/m17R8k6x40av1wcEVQU2GMbOuc7Bs=";
      };
    };
  */
  moondeck-buddy = prev.callPackage ./moondeck-buddy { };
  nero-umu = prev.nero-umu.overrideAttrs {
    version = "1.2.0-unstable-02-23-2026";
    src = prev.fetchFromGitHub {
      owner = "SeongGino";
      repo = "Nero-umu";
      rev = "6246d8d2d01426c55311d5e02bd55b34d5818524";
      hash = "sha256-j6JS1r7LrhYBuENpuJQxgW8PPME2XmJveTb57svYdEs=";
    };
  };
  openttd = prev.openttd.overrideAttrs {
    postPatch = ''
      substituteInPlace src/music/fluidsynth.cpp \
        --replace-fail "/usr/share/soundfonts/default.sf2" \
          "${final.soundfont-generaluser}/share/soundfonts/GeneralUser-GS.sf2"
    '';
  };
  proton-cachyos-x86_64-v4 =
    inputs.nix-gaming-edge.packages.${final.stdenv.hostPlatform.system}.proton-cachyos-x86_64-v4;
  proton-dw = inputs.dw-proton.packages.${final.stdenv.hostPlatform.system}.dw-proton;
  proton-em = final.callPackage ./proton-em { };
  relive = prev.callPackage ./relive { };
  /*
    scummvm = prev.scummvm.overrideAttrs {
      version = "3.0.0-unstable-01-20-2026";
      src = prev.fetchFromGitHub {
        owner = "scummvm";
        repo = "scummvm";
        rev = "59f4176fd731eac3dedca125971fc8a41c9a5a55";
        hash = "sha256-w8Dsa8g9HcdTKVORCSaFhwMX8VlL1L6AY9HRbG4vZ40=";
      };
    };
  */
  xlink-kai = prev.callPackage ./xlink-kai { };
})
