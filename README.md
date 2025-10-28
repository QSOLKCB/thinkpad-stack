# 🧠 ThinkPad-Stack
Turn a ThinkPad (or any Arch Linux box) into a **science + audio + dev** workstation with two scripts: a safe, idempotent setup and a lean maintenance routine.

> **Targets:** Arch Linux on ThinkPad T/X/P series (works on other Arch-based distros with minor tweaks)  
> **Scripts:** `setup.sh` (bootstrap) · `update.sh` (maintenance)

---

## ✨ What you get

- **Audio**: PipeWire + WirePlumber for low-latency, JACK/Pulse/ALSA compatibility. :contentReference[oaicite:0]{index=0}  
- **Power & thermals**: TLP + thermald tuned for laptops; easy to adjust in `/etc/tlp.conf`. :contentReference[oaicite:1]{index=1}  
- **Dev/Science stack**: Python toolchain, compilers, R/Octave (adjust as needed).
- **GPU & media**: Mesa/Vulkan basics for modern stacks.
- **AUR support**: Installs an AUR helper and keeps the flow consistent with Arch guidelines. :contentReference[oaicite:2]{index=2}
- **Maintenance**: Full system updates, AUR refresh, orphan cleanup, pacman cache trim, SSD TRIM, journal vacuum—aligned with Arch’s maintenance recommendations. :contentReference[oaicite:3]{index=3}

---

## 🔧 Quick start

```bash
git clone https://github.com/QSOLKCB/thinkpad-stack.git
cd thinkpad-stack
chmod +x setup.sh update.sh
````

### 1) Bootstrap once

```bash
./setup.sh
```

* Safe to re-run; it skips what’s already installed.
* Reboot afterward so audio/power services start cleanly.

### 2) Maintain regularly

```bash
./update.sh
```

* Run weekly or after big upgrades. It updates Arch & AUR, trims cache/logs, removes orphans, and prints a quick health summary. ([wiki.archlinux.org][1])

---

## 🧩 Script overview

### `setup.sh`

* Detects/installs prerequisites (including an AUR helper). ([wiki.archlinux.org][2])
* Configures:

  * PipeWire + WirePlumber (Pulse/JACK/ALSA compatible) for production-friendly audio. ([wiki.archlinux.org][3])
  * TLP + thermald defaults appropriate for laptops; tweak `/etc/tlp.conf` as needed. ([wiki.archlinux.org][4])
  * Core dev/science packages (editable list inside the script).
* Idempotent: re-running won’t wreck your system; it just ensures the stack is present.

### `update.sh`

* `pacman -Syu` full upgrades (no partial upgrades), then AUR updates. ([wiki.archlinux.org][1])
* Cleans pacman cache (keeps recent versions), removes orphans, vacuums journals, trims SSDs. ([wiki.archlinux.org][1])

---

## ✅ Recommended workflow

1. **Run `./setup.sh`**, reboot once.
2. **Run `./update.sh`** weekly (or before heavy sessions).
3. When you add new hardware (USB DAC, eGPU, dock), re-run `setup.sh` to pull any optional bits.

---

## 🔧 Configuration notes

* **PipeWire:** If you use JACK-native apps, PipeWire provides a compat layer; JACK/ALSA/Pulse clients should “just work”. Check `pavucontrol` for routing. ([wiki.archlinux.org][3])
* **TLP:** Battery thresholds, runtime PCIe power management on AC, and Wi-Fi behaviors can be set in `/etc/tlp.conf`. Use `tlp-stat` for diagnostics. ([wiki.archlinux.org][4])
* **AUR:** Treat PKGBUILDs as untrusted until reviewed; the helper automates builds but you’re responsible for updates and rebuilds after soname bumps. ([wiki.archlinux.org][2])

---

## 🩺 Troubleshooting (short list)

* **“Partial upgrades are unsupported.”**
  Don’t mix `-Sy` with later `-S`; always do full upgrades with `pacman -Syu`. If an upgrade fails mid-flight, resolve it before any other package operations. ([wiki.archlinux.org][1])

* **Disk space creep (cache/orphans/logs).**
  Use the provided maintenance script; it trims `/var/cache/pacman/pkg`, prunes orphans, and vacuums the journal—recommended by Arch’s maintenance guide. ([wiki.archlinux.org][1])

* **USB DAC / sample-rate quirks or JACK routing.**
  PipeWire supports multiple client types and can be tuned for lossless rates; see PipeWire docs and `pw-top` to inspect live streams. ([wiki.archlinux.org][3])

* **Battery/Wi-Fi quirks after TLP.**
  Adjust `RUNTIME_PM_ON_AC`, `DEVICES_TO_ENABLE_ON_STARTUP`, or USB denylist in `/etc/tlp.conf`, then `systemctl restart tlp`. ([wiki.archlinux.org][4])

---

## 📦 Scope & support

* Target: **Arch Linux** (ThinkPad T/X/P series), but works broadly on Arch-based distros.
* If you don’t need parts of the stack, **comment them out** in the scripts—both are readable shell with clear sections.

---

## 📝 License

MIT — use, fork, remix. PRs welcome.
