🧠 ThinkPad Stack — Arch Linux Science & Audio Workstation

Turn your ThinkPad (or any Arch box) into a developer-grade science, audio, and performance workstation — safely, reproducibly, and fast.

This repo provides two companion scripts:

Script	Purpose
setup.sh	One-shot bootstrap installer for a full science + audio + dev environment on Arch Linux. Installs yay, PipeWire stack, TLP, hardware utilities, and core packages.
update.sh	Ongoing maintenance tool to keep your system fast, clean, and healthy — updates Arch packages, trims SSDs, clears logs, and refreshes AUR packages.
⚙️ Features
🧩 setup.sh

Idempotent (safe to re-run anytime)

Auto-detects missing tools and reinstalls yay if needed

Configures:

PipeWire + WirePlumber for low-latency audio

TLP + thermald for power management

Vulkan + Mesa for GPU acceleration

Full scientific stack (python, r, gcc, cmake, octave, etc.)

Gracefully falls back to AUR if official packages fail

Clean colored output and readable logging

🔄 update.sh

Syncs all system and AUR packages

Cleans pacman cache (keeps last 3 versions)

Removes orphaned dependencies

Checks for failed systemd services

Runs SSD trim (if applicable)

Clears journal logs older than 2 weeks

Prints memory usage summary

🧰 Installation

Clone the repo and make both scripts executable:

git clone https://github.com/QSOLKCB/thinkpad-stack.git
cd thinkpad-stack
chmod +x setup.sh update.sh

Initial Setup
./setup.sh


Safe to re-run; it skips anything already installed.

Routine Maintenance
./update.sh


Recommended weekly or after large package updates.

🧩 Notes

Designed for Arch Linux (tested on ThinkPad T and X series)

Works on any Arch-based distro (EndeavourOS, Manjaro) with minor tweaks

You can comment out optional sections (e.g., Powertop calibration) if not needed

Reboot after first run to ensure firmware, TLP, and audio services are active

🧠 Why this exists

Trent built this to unify his QEC + Producer.ai development environments across machines — a reproducible lab + studio setup in one shell pass.

🧾 License

MIT — feel free to fork, tweak, and remix.
Pull requests welcome!
