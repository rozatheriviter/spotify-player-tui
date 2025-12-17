#!/bin/bash
set -e

echo "Building 1337spotify..."
cargo build --release

echo "Installing 1337spotify to /usr/local/bin..."
if [ -f "target/release/1337spotify" ]; then
    sudo install -m 755 target/release/1337spotify /usr/local/bin/1337spotify
else
    echo "Error: Binary not found at target/release/1337spotify"
    exit 1
fi

echo "Installation complete! You can now run '1337spotify'."
