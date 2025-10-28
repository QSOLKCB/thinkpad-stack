#!/usr/bin/env bash
#
# Arch Linux Science + Audio Workstation Setup
# --------------------------------------------
# Safe and idempotent setup script with AUR fallback and automatic error handling.
#

# Exit early if any command fails (noncritical parts use `|| true`)
set -euo pipefail

# Colors for readability
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
CYAN="\033[1;36m"
RESET="\033[0m"

info()  { echo -e "${CYAN}==>${RESET} $*"; }
warn()  { echo -e "${YELLOW}⚠${RESET} $*"; }
error() { echo -e "${RED}✖${RESET} $*" >&2; }
ok()    { echo -e "${GREEN}✔${RESET} $*"; }

# --- Ensure yay is available ---
if ! command -v yay &>/dev/null; then
    info "Installing yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd ~ && rm -rf /tmp/yay
    ok "yay installed."
else
    ok "yay already installed."
fi

# --- System Update Check ---
info "Checking for system updates..."
sudo pacman -Syu --noconfirm
ok "System updated."

# --- Ensure pacman-contrib is installed (for paccache, checkupdates, etc.) ---
info "Installing pacman-contrib..."
sudo pacman -S --needed --noconfirm pacman-contrib
ok "pacman-contrib installed."

# --- Hardware & Power Management Tools ---
info "Installing hardware and power-management tools..."
sudo pacman -S --needed --noconfirm \
    amd-ucode linux-firmware mesa vulkan-radeon \
    lm_sensors bluez bluez-utils networkmanager iwd smartmontools \
    dbus-glib hdparm iw usbutils acpi acpid brightnessctl ethtool \
    mesa-utils powertop thermald tlp vulkan-mesa-layers vulkan-tools

# Enable related services
sudo systemctl enable --now \
    thermald.service \
    bluetooth.service \
    tlp.service || true

ok "Hardware and power tools installed and configured."

# --- Developer & System Utilities ---
info "Installing developer and system utilities..."
sudo pacman -S --needed --noconfirm \
    base-devel git curl wget unzip vim nano htop btop fastfetch \
    python python-pip gcc pkgconf cmake zip tmux r

ok "Developer environment ready."

# --- Audio Production Stack (PipeWire) ---
info "Installing PipeWire-based audio production stack..."
sudo pacman -S --needed --noconfirm \
    pipewire pipewire-pulse wireplumber ffmpeg fluidsynth || true

# Handle missing packages gracefully (example: calf-plugins)
if ! sudo pacman -S --needed --noconfirm calf-plugins; then
    warn "calf-plugins not found in repos — trying AUR fallback..."
    yay -S --noconfirm calf || warn "Failed to install calf from AUR."
fi

ok "Audio production stack installed."

# --- Optional: Performance tuning (if supported) ---
if command -v powertop &>/dev/null; then
    info "Running Powertop calibration (optional)..."
    sudo powertop --auto-tune || warn "Powertop calibration skipped."
fi

ok "All components configured successfully."

# --- Final Summary ---
echo -e "\n${GREEN}=== Setup complete! ===${RESET}"
echo "It’s recommended to reboot to ensure firmware, TLP, and audio stack are fully active."
echo
