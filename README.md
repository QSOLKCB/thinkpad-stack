# 🧠 ThinkPad-Stack  
**An Arch Linux workstation stack for science, audio, and dev rigs**  
Designed by QSOLKCB to turn a ThinkPad (or any Arch box) into a full-fledged developer studio with minimal fuss.

---

## 🔧 What’s in this repo  

| Script        | Role |
|--------------|------|
| `setup.sh`   | One-time bootstrap installer: sets up dev tools, audio stack (PipeWire + WirePlumber), power management (TLP + thermald), GPU support (Mesa/Vulkan), scientific stack (Python, R, Octave), etc. |
| `update.sh`  | Routine maintenance script: updates Arch & AUR packages, cleans cache, trims SSDs, removes orphans, checks services, and keeps the machine lean. |

---

## 🧩 Features at a glance  

### `setup.sh`
- Idempotent: safe to rerun — it skips already installed components  
- Detects and installs `yay` if missing, handles AUR fall-backs  
- Configures:
  - PipeWire & WirePlumber for low-latency audio  
  - TLP + thermald for battery & thermal optimization  
  - Mesa + Vulkan for modern GPU stacks  
  - Core scientific tools (Python, R, Octave, GCC, CMake)  
- Clear color output, simple logging — easy to understand what it’s doing  

### `update.sh`
- Runs system (`pacman`) + AUR package updates  
- Cleans pacman cache (keeping last 3 versions)  
- Purges orphaned dependencies  
- SSD Trim (if NVMe or relevant drive)  
- `journalctl --vacuum-time` for 2-week log cleanup  
- Memory/CPU summary at end for quick health check  

---

## 🛠 Installation & Usage  

**Clone the repo and prepare scripts:**
```bash
git clone https://github.com/QSOLKCB/thinkpad-stack.git

Initial setup:

./setup.sh


Run this once (or rerun safely) to get the base platform.

Routine maintenance:

./update.sh


Run weekly or after major system upgrades.

✅ Recommended workflow

After initial setup.sh, reboot the system — it ensures firmware, TLP, and audio services are active.

Use update.sh regularly (e.g., Sunday morning) to keep things smooth.

If you add hardware or major components (e.g., external audio interface, GPU), rerun setup.sh to capture any module tweaks.

Track any custom configurations by committing changes to .conf files or /etc tweaks with sudo.

📋 Notes

Intended for Arch Linux (tested on ThinkPad T/X series); works on Arch-based distros (EndeavourOS, Manjaro) with minimal adjustment.

You can comment out or disable portions inside the scripts (for example, powertop --auto-tune) if you have specific hardware or workload requirements.

If you use a non-ThinkPad laptop, adjust TLP/thermald configs accordingly — see script comments for guidance.

🎯 Why this exists

At QSOLKCB, we build for convergence: science + audio + dev in one machine.
This repo was created to automate the “lab setup” of every laptop so we spend less time configuring and more time creating.

📝 License

MIT — “Use it, tweak it, share it.”
Pull requests and improvement suggestions always welcome.
cd thinkpad-stack
chmod +x setup.sh update.sh
