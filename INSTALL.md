# NixOS Installation Guide (i5-12400F & RX 6600)

This guide walks you through installing your custom NixOS configuration. Follow these steps precisely to ensure your hardware is detected and configured correctly.

---

## 1. Placeholder Reference (MUST FILL BEFORE INSTALL)
Open the following files and replace the strings starting with `REPLACE_ME`.

| Placeholder String | File Path | How to get the value |
| :--- | :--- | :--- |
| **`REPLACE_ME_USERNAME`** | `flake.nix` | Choose your login name (e.g., `dhilipan`). Lowercase, no spaces. |
| **`REPLACE_ME_FULLNAME`** | `flake.nix` | Your actual name (e.g., `Dhilipan S`). |
| **`REPLACE_ME_DISK_ID`** | `flake.nix` **AND** `hosts/desktop/disko.nix` | Run `ls -l /dev/disk/by-id/`. Find your NVMe/SSD (e.g., `nvme-Samsung_SSD_980...`). **Do not use IDs ending in -partX**. |
| **`REPLACE_ME_PASSWORD_HASH`** | `modules/core/users/default.nix` | Run `nix-shell -p mkpasswd --run "mkpasswd -m sha-512"`. Type your password and copy the long string. |
| **`REPLACE_ME_SSH_PUBLIC_KEY`** | `modules/core/users/default.nix` | Run `cat ~/.ssh/id_ed25519.pub` (if you have one) and paste the whole line. |
| **`REPLACE_ME_GAMES_UUID`** | `hosts/desktop/default.nix` | Run `blkid` to find your Games partition UUID. **If you don't have one, comment out the `beesd` block.** |

---

## 2. Installation Steps

### Step A: Boot the NixOS Live USB
1. Download the **NixOS Minimal ISO** (64-bit Intel/AMD) from [nixos.org](https://nixos.org/download.html).
2. Flash it to a USB drive and boot your PC from it.
3. Open a terminal in the live environment.

### Step B: Gathering your IDs
Run these commands in the live terminal and write down the results:
```bash
# 1. Get Disk ID
ls -l /dev/disk/by-id/

# 2. Generate Password Hash (type your desired password when prompted)
nix-shell -p mkpasswd --run "mkpasswd -m sha-512"

# 3. Get Games UUID (Optional)
blkid
```

### Step C: Cloning the Config
```bash
# Become root
sudo su

# Clone your config (replace with your repo URL)
git clone https://github.com/YOUR_USERNAME/YOUR_REPO /etc/nixos
cd /etc/nixos
```

### Step D: Editing the Files
Use the `nano` editor to fill in the placeholders identified in Section 1:
```bash
nano flake.nix
nano hosts/desktop/disko.nix
nano hosts/desktop/default.nix
nano modules/core/users/default.nix
```

### Step E: Partitioning (Disko)
**WARNING**: This wipes your drive. It creates a 70% NixOS partition and leaves 30% free space for Windows.
```bash
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /etc/nixos/hosts/desktop/disko.nix
```

### Step F: Final Install
1. **Sync Hardware Configuration**:
   ```bash
   nixos-generate-config --root /mnt
   cp /mnt/etc/nixos/hardware-configuration.nix /etc/nixos/hosts/desktop/hardware-configuration.nix
   ```
2. **Execute Install**:
   ```bash
   nixos-install --flake .#nixos-desktop
   ```

---

## 3. Post-Installation
1. **Reboot**: Run `reboot`.
2. **Login**: SDDM will automatically log you into **Niri**.
3. **Shortcuts**: Press **Super + Shift + / (Slash)** to see the keybindings.
4. **Maintenance**:
   - To apply config changes: `nh os switch`
   - To update everything: `upd` (alias for topgrade)

---

## 4. Hardware Configuration Status
*   **CPU**: Intel i5-12400F (Microcode & KVM Intel enabled).
*   **GPU**: AMD RX 6600 (Mesa-git enabled, LACT monitoring installed).
*   **Display**: HDMI-A-1 at 1080p@120Hz.
*   **Audio**: High-fidelity 24/32-bit output for KZ Castor IEMs.
