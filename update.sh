#!/usr/bin/env bash
# ==========================================
# Arch Linux Maintenance & Update Script
# Author: Trent's Assistant :)
# ==========================================

# Define some colors for output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLANK="\e[0m"

echo -e "${YELLOW}=== Arch Linux System Maintenance ===${BLANK}"
echo

# Step 1: Sync and update the system
echo -e "${GREEN}→ Updating package database and system...${BLANK}"
sudo pacman -Syu --noconfirm

# Step 2: Clean up package cache (keep last 3 versions)
echo -e "${GREEN}→ Cleaning package cache (keeping 3 versions)...${BLANK}"
sudo paccache -r -k3

# Step 3: Remove orphaned packages
echo -e "${GREEN}→ Removing orphaned packages...${BLANK}"
sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || echo "No orphans found."

# Step 4: Update AUR packages (if yay or paru is installed)
if command -v yay &>/dev/null; then
    echo -e "${GREEN}→ Updating AUR packages with yay...${BLANK}"
    yay -Syu --noconfirm
elif command -v paru &>/dev/null; then
    echo -e "${GREEN}→ Updating AUR packages with paru...${BLANK}"
    paru -Syu --noconfirm
else
    echo -e "${YELLOW}AUR helper not found. Skipping AUR updates.${BLANK}"
fi

# Step 5: Check for system health (journal, failed services)
echo -e "${GREEN}→ Checking for failed systemd services...${BLANK}"
systemctl --failed || true

# Step 6: Optional - trim SSD (if applicable)
if lsblk -dno ROTA | grep -q '^0'; then
    echo -e "${GREEN}→ Detected SSD; running fstrim...${BLANK}"
    sudo fstrim -av
else
    echo -e "${YELLOW}No SSD detected; skipping fstrim.${BLANK}"
fi

# Step 7: Clear old journal logs (keep 2 weeks)
echo -e "${GREEN}→ Cleaning old journal logs (keeping 2 weeks)...${BLANK}"
sudo journalctl --vacuum-time=2weeks

# Step 8: Display memory usage summary
echo
echo -e "${GREEN}→ Current memory usage:${BLANK}"
free -h

echo
echo -e "${YELLOW}=== System maintenance complete! ===${BLANK}"
echo "Tip: Reboot if any core packages (e.g., kernel, systemd) were updated."
echo
