# System Tools & Applications Reference

This file serves as a guide for every tool, application, and script currently active in your NixOS configuration.

---

### 🏠 Desktop & Core (Niri Environment)
*   **Niri**: Your tiling window manager. Use this to manage windows, workspaces, and your overall layout.
*   **Catppuccin**: Your global color scheme. It keeps everything visually consistent.
*   **LACT**: A Linux AMDGPU Controller. Use this to monitor, overclock, or manage your **RX 6600**.
*   **Beesd**: A background deduplication daemon for BTRFS. It scans your "Games" drive and merges duplicate data to save space.
*   **Tuned**: Manages power profiles. It automatically switches between "performance" and "balanced" modes.
*   **Ydotool**: A background service for command-line automation (simulating keypresses and mouse clicks).

### 🐧 KDE Applications (Native tools running in Niri)
*   **Dolphin**: Your primary File Manager. Best for managing folders, drag-and-drop, and network shares.
*   **Kate**: Advanced Text Editor. Use this for editing code, config files, or taking notes.
*   **Gwenview**: Image Viewer. Use this for browsing photos or quick image crops.
*   **Okular**: Document Viewer. Best for PDFs, E-books, and comic book formats.
*   **Haruna**: Video Player. A modern frontend for `mpv` that supports hardware acceleration.
*   **KCalc**: Simple calculator.
*   **Kdenlive**: Professional-grade Video Editor. Use this for cutting and rendering your gameplay clips.

### 🎮 Gaming Storefronts & Launchers
*   **Steam**: Primary store/launcher for most games.
*   **Heroic Games Launcher**: Use this for **Epic Games** and **GOG** titles.
*   **Lutris**: The "all-in-one" launcher. Use this for standalone Windows games, older PC titles, or games from other sources.
*   **Bottles**: Use this to create "Bottles" (isolated environments) for specific Windows software or launchers.
*   **RetroArch**: The ultimate frontend for emulators. Use this to play console games (NES, SNES, PS1, etc.).

### 📡 Streaming & Performance
*   **Sunshine**: Streaming Server. Use this to allow other devices (like a Steam Deck or Phone) to stream games *from* this PC.
*   **Apollo**: A fork of Moonlight. Use this to stream games *to* this PC from another computer.
*   **GameMode**: Runs in the background. Use the command `gamemoderun <game>` to give your game priority for CPU and GPU resources.
*   **MangoHud**: Performance Overlay. Use the command `mangohud <game>` to see FPS, temperatures, and usage in-game.
*   **Gamescope**: Use this to force games to run at specific resolutions, fix scaling issues, or enable HDR in a containerized window.
*   **VkBasalt**: Use this to add "Reshade-like" effects (sharpening, color correction) to Vulkan games.
*   **Nero-UMU**: A specialized launcher for Wine/Proton games that simplifies the runtime environment.
*   **CDEmu**: Virtual drive. Use this to mount `.iso` or `.bin/.cue` disc images so they appear as a physical CD-ROM.

### 🎨 Media & Creativity
*   **OBS Studio**: Screen recording and live streaming.
*   **Handbrake**: Video Transcoder. Use this to compress massive video files or change their format.
*   **Audacious**: Lightweight audio player (similar to Winamp). Best for low resource usage.
*   **Fooyin**: A customizable music player built for massive local music libraries.
*   **Mousai**: Desktop "Shazam." Use this to identify songs playing through your speakers.
*   **Picard**: MusicBrainz Tagger. Use this to automatically fix the metadata (names, art) of your MP3 files.
*   **Puddletag**: Manual audio tag editor.
*   **LosslessCut**: Use this to quickly trim the beginning or end of a video without having to re-render it (instant saving).
*   **QPwGraph**: PipeWire Patchbay. Use this to visually connect audio inputs to outputs (e.g., routing a microphone through a filter).
*   **Metadata-cleaner**: Removes GPS, camera info, and personal data from files before you share them.
*   **ProjectM-SDL**: Music visualizer (MilkDrop).

### 🌐 Internet & Communication
*   **Zen Browser**: Your main web browser. Optimized for speed and privacy.
*   **Vesktop**: An enhanced Discord client. Supports Vencord plugins and better Linux screensharing.
*   **Signal Desktop**: Private, encrypted messaging.
*   **Neochat**: Client for the **Matrix** decentralized chat protocol.
*   **Mumble**: Ultra low-latency voice chat. Best for competitive gaming coordination.
*   **RustDesk**: Open-source remote desktop. Use this if you need to control this PC from another device or help a friend.
*   **RSSGuard**: Feed reader for keeping up with news and blogs without visiting websites.
*   **FileZilla**: FTP/SFTP client. Use this to move files to/from servers or websites.
*   **Mullvad VPN**: High-privacy VPN client.
*   **Tailscale**: Creates a secure "private internet" between all your personal devices.
*   **ZeroTier**: Virtual LAN. Use this to play "LAN only" games over the internet with friends.

### 💻 System & CLI Tools (Terminal)
*   **Nix Management**:
    *   **nh**: Your primary command for system updates. Use `nh os switch` to apply changes.
    *   **nvd**: Shows you exactly what changed between two system versions.
    *   **nix-index**: Use this to find which package contains a specific file (e.g., `nix-locate libfoo.so`).
    *   **nix-ld**: Allows you to run pre-compiled binaries downloaded from the web that weren't made for NixOS.
*   **Shell Experience**:
    *   **zsh / starship**: Your command shell and the pretty "prompt" that shows info like your current directory and Git status.
    *   **atuin**: A better shell history. Press the `Up` arrow to search all commands you've ever typed.
    *   **zoxide**: Smarter `cd`. Use `z <folder_name>` to jump to a directory you've visited before without typing the path.
*   **File & Data CLI**:
    *   **yazi**: An extremely fast terminal file manager with image previews.
    *   **lsd**: An improved `ls`. Use it to see files with icons and colors.
    *   **fd**: A faster alternative to `find`.
    *   **ripgrep (rg)**: A faster alternative to `grep`. Use it to search for text inside files.
    *   **bat**: An improved `cat` with syntax highlighting.
    *   **rclone**: The "Swiss Army Knife" for cloud storage. Sync files to Google Drive, OneDrive, etc.
*   **System Monitoring**:
    *   **btop**: Your system monitor. Use this to see CPU/RAM usage and kill processes.
    *   **fastfetch**: Displays your system hardware and OS info in the terminal.
    *   **lazydocker**: A terminal UI for managing Docker containers.
*   **Development & Editing**:
    *   **nvim / helix**: Powerful terminal-based text editors.
    *   **lazygit**: A terminal UI for Git. Use this to commit and push code without typing complex Git commands.
    *   **devenv**: A tool to create isolated development environments for specific coding projects.
*   **Miscellaneous CLI**:
    *   **yt-dlp**: The best tool for downloading videos from YouTube, Twitch, and 1000+ other sites.
    *   **jq / yq**: Tools for processing JSON and YAML data in the terminal.
    *   **topgrade**: Use this to update *everything* (Nix, Flatpaks, Firmware, etc.) with one command.
    *   **pay-respects**: If you make a typo in a command, type `f` to fix it and run it again.

### 📜 Custom Automation Scripts
*   **script-game-stuff**: Automatically downloads and sets up **DREAMM** (LucasArts emulator) and **Conty** (compatibility layer for difficult games).
*   **script-exodos-nuked**: A specific fix for the **eXoDOS** collection that switches MIDI devices from FluidSynth to Nuked SC-55 for better sound quality.
*   **script-gameclip720p**: A quick utility to take a video file and compress it to a shareable 720p 60fps format using Handbrake.
