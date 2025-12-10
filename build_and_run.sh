#!/bin/bash
set -e

echo "Building spotify_player..."
if ! command -v cargo &> /dev/null; then
    echo "Error: 'cargo' is not found. Please ensure Rust is installed."
    exit 1
fi

# Build the project in release mode
cargo build --release

echo "Build successful! Starting spotify_player..."
./target/release/spotify_player
