#!/bin/bash
set -e

echo "Updating package lists..."
sudo apt-get update

echo "Installing dependencies..."
# Dependencies based on Cargo.toml and common requirements for linux
# libssl-dev for native-tls
# libasound2-dev for alsa-backend (default)
# libdbus-1-dev for media-control (default)
# pkg-config for build scripts
# build-essential for linker and gcc
sudo apt-get install -y build-essential pkg-config libssl-dev libasound2-dev libdbus-1-dev cargo

echo "Building spotify_player..."
# Build release version
cargo build --release

echo "Installing binary as spotify21337..."
# Install to /usr/local/bin so it's in PATH
if [ -f "target/release/spotify_player" ]; then
    sudo cp target/release/spotify_player /usr/local/bin/spotify21337
    echo "Successfully installed to /usr/local/bin/spotify21337"
else
    echo "Error: Binary not found at target/release/spotify_player"
    exit 1
fi

echo "Installation complete! You can run the app with: spotify21337"
