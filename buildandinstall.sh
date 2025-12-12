#!/bin/bash
set -e

# Check if script is run from the project root
if [ ! -f "Cargo.toml" ]; then
    echo "Error: This script must be run from the root of the repository."
    exit 1
fi

echo "Updating package lists..."
sudo apt-get update

echo "Installing dependencies..."
# Dependencies based on CI workflow and Cargo.toml
# libssl-dev for native-tls (reqwest, librespot)
# libasound2-dev for alsa-backend (default rodio backend on Linux)
# libdbus-1-dev for media-control (souvlaki)
# libxcb-shape0-dev, libxcb-xfixes0-dev for clipboard/window integration (mentioned in CI)
# pkg-config for build scripts
# build-essential for linker and gcc
sudo apt-get install -y build-essential pkg-config libssl-dev libasound2-dev libdbus-1-dev libxcb-shape0-dev libxcb-xfixes0-dev cargo

echo "Building spotify_player..."
# Build release version with default features (rodio-backend, media-control)
# Note: CI uses features "rodio-backend,media-control,image,notify,fzf"
# The user didn't ask for extra features, but 'image' and 'notify' are popular.
# However, adhering to defaults is safer unless specified.
# Default features in Cargo.toml are: ["rodio-backend", "media-control"]
cargo build --release

echo "Installing binary as spotify21337..."
# Install to /usr/local/bin so it's in PATH
BINARY_PATH="target/release/spotify_player"
INSTALL_NAME="spotify21337"
INSTALL_DIR="/usr/local/bin"

if [ -f "$BINARY_PATH" ]; then
    echo "Installing to $INSTALL_DIR/$INSTALL_NAME..."
    sudo install -m 755 "$BINARY_PATH" "$INSTALL_DIR/$INSTALL_NAME"
    echo "Successfully installed!"
    echo "You can now run the app with: $INSTALL_NAME"
else
    echo "Error: Binary not found at $BINARY_PATH"
    exit 1
fi
