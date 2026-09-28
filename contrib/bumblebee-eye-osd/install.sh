#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DEST="${HOME}/.local/bin"
SERVICE_DEST="${HOME}/.config/systemd/user"

echo "=== Installing Voxtype Bumblebee Eye OSD ==="

# 1. Check Python dependencies
echo "Checking dependencies..."
python3 -c "import gi, cairo; gi.require_version('Gtk', '3.0')" 2>/dev/null || {
    echo "Error: Python GTK3 or Cairo bindings missing."
    echo "Install them using your package manager, for example:"
    echo "  Ubuntu/Debian: sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 python3-cairo"
    echo "  Fedora:        sudo dnf install python3-gobject gtk3 cairo-gobject"
    echo "  Arch Linux:    sudo pacman -S python-gobject gtk3 python-cairo"
    exit 1
}

# 2. Create destination directories
mkdir -p "${BIN_DEST}"
mkdir -p "${SERVICE_DEST}"

# 3. Copy executable and service file
echo "Installing voxtype-pill-osd to ${BIN_DEST}..."
cp "${SCRIPT_DIR}/voxtype-pill-osd" "${BIN_DEST}/voxtype-pill-osd"
chmod +x "${BIN_DEST}/voxtype-pill-osd"

echo "Installing systemd service to ${SERVICE_DEST}..."
cp "${SCRIPT_DIR}/voxtype-pill-osd.service" "${SERVICE_DEST}/voxtype-pill-osd.service"

# 4. Reload and start systemd service
echo "Reloading systemd user daemon..."
systemctl --user daemon-reload
systemctl --user enable --now voxtype-pill-osd.service

echo ""
echo "=== Bumblebee Eye OSD installed and running successfully! ==="
systemctl --user status voxtype-pill-osd.service --no-pager
