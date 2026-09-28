# Bumblebee Eye Voice-Reactive OSD for Voxtype

A cinematic, ultra-lightweight, voice-reactive on-screen display (OSD) for [Voxtype](https://github.com/peteonrails/voxtype) modeled after the authentic Cybertronian optic anatomy of Bumblebee from *Transformers*.

Designed specifically for Linux Wayland and X11 desktops (GNOME Shell, Sway, Hyprland, KDE Plasma), it floats cleanly top-center beneath the status bar with zero dock intrusion, zero window decorations, and zero click blocking.

---

## Visual & Cybernetic Architecture

### 1. Authentic Cybertronian Optic Anatomy
- **Outer Armor Socket:** Soft champagne / warm titanium gold bezel rim with deep recessed socket shadow.
- **Stepped Collar & Servos:** Dual concentric metallic focus rings etched with 16 precision servo teeth and cardinal markers at 0°, 90°, 180°, and 270°.
- **Luminous Compound Optic:** Diffused emissive light field with 12 radial faceted lens ribs (reflector lattice) that gently rotate in the background.
- **Articulated Shutter Blades:** 6 curved titanium iris blades with metallic drop shadows that dynamically dilate and counter-rotate as voice energy peaks.
- **Projector Diode (Focal Core):** High-intensity white-hot plasma core that expands dynamically with voice dBFS.
- **Target Lock Scanner:** High-tech orbital radar sweep with a leading scanning pip along the focus ring during transcription.
- **Spherical Glass Lens:** Dual specular reflections (a 3D curved lens sheen and pinpoint optical micro-glint).

### 2. Faded Minimal Palette
To avoid distracting bright/neon colors on your desktop, the visualizer uses an understated, desaturated luxury-cyber palette:
- **Calm / Listening (Recording):** Soft, misty ice blue (`#73B8D1`) optic within a faded champagne gold (`#CDC2A3`) rim.
- **Speaking (Battle Mode):** Seamlessly shifts into a muted, dusty rose / dark ember crimson (`#D15761`), dilating in real-time with voice volume.
- **Transcribing:** Precision misty ice scanning reticle sweep.
- **Chassis:** Deep matte obsidian slate (`#0F1113`) and muted brushed titanium steel (`#949EA8`).

---

## Desktop Stealth & Performance Features

- **Zero Dock / Alt+Tab Intrusion:** Uses `Gtk.WindowType.POPUP` with `GDK_BACKEND=x11` (XWayland override-redirect), ensuring GNOME Shell / Ubuntu Dock / window managers treat it strictly as an overlay.
- **100% Click-Through:** Mouse clicks, drags, and scrolls pass straight through the visualizer to underlying applications (`cairo.Region()`).
- **Dynamic Pointer Tracking:** Automatically positions top-center on whichever monitor your mouse pointer is currently active.
- **Live Voice Ballistics:** Connects directly to `$XDG_RUNTIME_DIR/voxtype/audio.sock` to parse real-time peak audio dBFS with asymmetrical ballistics (fast 60ms attack, smooth 200ms decay).
- **Ultra-Low CPU:** State checks are throttled to ~48ms intervals to avoid continuous 60Hz disk I/O polling.

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

## Recommended Keybindings

Because desktop environments (like GNOME) reserve standalone modifier keys (e.g. lone `Alt`), the recommended setup is a custom shortcut calling `voxtype record toggle`:

### GNOME Settings → Keyboard → Custom Shortcuts
- **Shortcut 1:** `Ctrl + Space` -> `voxtype record toggle`
- **Shortcut 2:** `Alt + Space` -> `voxtype record toggle`

### Voxtype Config (`~/.config/voxtype/config.toml`)
If using compositor/desktop shortcuts, set the built-in evdev grab to disabled or an unused key to avoid modifier conflicts:
```toml
[hotkey]
enabled = false
key = "SCROLLLOCK"
mode = "toggle"
```

---

## Verification & Status

Check the visualizer status:
```bash
systemctl --user status voxtype-pill-osd.service
```

View live logs:
```bash
journalctl --user -u voxtype-pill-osd.service -f
```
