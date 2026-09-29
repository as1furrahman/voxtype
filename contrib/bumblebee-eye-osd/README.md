# Liquid Glass Dynamic Island Pill OSD for Voxtype

An ultra-compact, pixel-perfect, voice-reactive on-screen display (OSD) for [Voxtype](https://github.com/peteonrails/voxtype). Designed with an Apple-inspired Dynamic Island pill aesthetic and a dark transparent Liquid Glass substrate.

Engineered specifically for Linux Wayland and X11 desktops (GNOME Shell, Sway, Hyprland, KDE Plasma), it floats centered beneath the top panel with zero dock intrusion, zero window decorations, and zero click blocking.

---

## Visual Architecture & Themes

### 1. Liquid Glass Substrate & Specular Optics
- **Dark Obsidian Substrate:** 74% opacity deep obsidian smoked liquid glass (`rgba(0.008, 0.008, 0.012, 0.74)`), maintaining backdrop transparency while preventing wash-out on bright or white windows.
- **Convex Dome Specular Shine:** Upper curvature reflection gradient that mimics a convex optical glass crystal dome.
- **Physical Glass Crystal Rim:** Dual-layer integer-aligned border (0.90 pure white top highlight, 0.32 base rim) creating physical refraction depth.
- **Micro Capsule Dimensions:** Precision-engineered micro capsule (`82 × 24 px`, `r = 12 px`) keeping screen footprint minimal and unobtrusive.

### 2. Voice-Reactive Acoustic Diaphragm
- **Center-Weighted Breathing Pearls:** 4 pure white pearls with silver radial depth gradients and upper-left pinpoint specular glints.
- **Zero Vertical Bouncing:** Pearls stay stably anchored to the centerline (`cy`), expanding in radius and breathing horizontally in direct response to vocal energy.
- **Symmetrical Expansion:** Inner pearls pulse up to `3.4 px` radius, while outer flank pearls expand to `2.4 px` radius (baseline `1.5 px` at rest).
- **Adaptive Ambient Noise Floor:** Real-time dynamic noise floor tracker (`-45` to `-25 dBFS`) that filters out background fan/room noise and suppresses startup audio feedback chimes. In silence, the volume level sits at absolute `0.0`.
- **Fast Attack & Smooth Decay:** Studio PPM ballistics (75% instant attack on syllable onsets, 18% smooth decay over ~160ms between words).

### 3. Micro Digital Timer & Transcription Spinner
- **Right-Aligned Timer:** Clean fixed 10 px right margin inset (`x0 + w - 10.0 - width`) with a crisp drop shadow for 100% legibility on any wallpaper or window.
- **Transcribing State:** Pure white crystal arc spinner (`r = 3.4 px`) with shimmering "Processing..." label.

### 4. Available Visual Themes
Selectable via `--theme <name>`:
- `dark-glass` (Default): 74% deep obsidian smoked liquid glass.
- `clear-glass`: 42% high-transparency liquid glass with prominent crystal rim refraction.
- `matte-black`: 96% deep matte obsidian pill with high-contrast pure white typography.

---

## Desktop Stealth & Performance

- **Zero Dock / Alt+Tab Intrusion:** Uses `Gtk.WindowType.POPUP` with `GDK_BACKEND=x11` (XWayland override-redirect), ensuring GNOME Shell / Ubuntu Dock / window managers treat it strictly as an overlay.
- **100% Click-Through:** Mouse clicks, drags, and scrolls pass straight through the visualizer to underlying applications (`cairo.Region()`).
- **Dynamic Pointer Tracking:** Automatically positions top-center on whichever monitor your mouse pointer is currently active.
- **Live Audio Socket:** Connects directly to `$XDG_RUNTIME_DIR/voxtype/audio.sock` to parse real-time dBFS audio frames without IPC overhead.
- **Low CPU & Memory:** Consumes ~1.7 MB RAM and throttles state file checks to ~48ms intervals to avoid continuous 60Hz disk I/O polling.

---

## Installation

### Prerequisites
Make sure GTK3 and Cairo Python bindings are installed:
```bash
# Ubuntu / Debian
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 python3-cairo

# Fedora
sudo dnf install python3-gobject gtk3 cairo-gobject

# Arch Linux
sudo pacman -S python-gobject gtk3 python-cairo
```

### 1-Line Install
Run the included installer:
```bash
./install.sh
```

Or manually:
```bash
# 1. Install script
mkdir -p ~/.local/bin ~/.config/systemd/user
cp voxtype-pill-osd ~/.local/bin/
chmod +x ~/.local/bin/voxtype-pill-osd

# 2. Install and enable systemd user unit
cp voxtype-pill-osd.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now voxtype-pill-osd.service
```

---

## Usage & CLI Options

Preview interactive demo mode:
```bash
voxtype-pill-osd --demo
```

Launch with custom theme or top offset:
```bash
voxtype-pill-osd --theme clear-glass --top-margin 42
```

CLI options:
```text
  --demo                 Launch in interactive demo preview mode
  --theme THEME          Visual theme: dark-glass (default), clear-glass, matte-black
  --top-margin PIXELS    Vertical offset in pixels from the top of the screen (default: 36)
```

---

## Recommended Keybindings

Recommended setup is a custom shortcut calling `voxtype record toggle`:

### GNOME Settings → Keyboard → Custom Shortcuts
- **Shortcut 1:** `Ctrl + Space` -> `voxtype record toggle`
- **Shortcut 2:** `Alt + Space` -> `voxtype record toggle`

### Voxtype Config (`~/.config/voxtype/config.toml`)
If using compositor/desktop shortcuts, set the built-in evdev grab to disabled:
```toml
[hotkey]
enabled = false
key = "SCROLLLOCK"
mode = "toggle"
```

---

## Service Verification & Logs

Check visualizer status:
```bash
systemctl --user status voxtype-pill-osd.service
```

View live logs:
```bash
journalctl --user -u voxtype-pill-osd.service -f
```
