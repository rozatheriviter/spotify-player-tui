# spotify_player

**spotify_player** is a fast, easy to use, and configurable Spotify player in the terminal. It is designed to be a full-featured Spotify client, supporting streaming, playlist management, lyrics, and more.

## Navigation

The application features an intuitive, **iPod-like navigation system** designed for ease of use with minimal keys:

- **Right** or **Enter**: Enter the selected item or view.
- **Left** or **Backspace**: Go back to the previous page/view.
- **Up** / **Down**: Navigate through the list items.

This system allows you to browse through your library, playlists, and albums naturally without needing to memorize complex shortcuts.

## Features

- **Streaming**: Stream music directly from the terminal (requires Spotify Premium).
- **Full Parity**: Access your Library, Playlists, Albums, Artists, and more.
- **Lyrics**: View synchronized lyrics for the current track.
- **Media Control**: MPRIS support for media keys integration.
- **Cross-Platform**: Works on Linux, macOS, and Windows.
- **Configurable**: extensive configuration options including keymaps, themes, and layouts.

## Installation

### Dependencies (Linux)

You may need the following dependencies:

```bash
# Debian / Ubuntu
sudo apt install build-essential pkg-config libssl-dev libasound2-dev libdbus-1-dev libxcb-shape0-dev libxcb-xfixes0-dev
```

### From Source

```bash
cargo install spotify_player --features "streaming media-control lyric-finder"
```

## Keybindings

Below are the default keybindings. You can customize them in your configuration file.

### Navigation
| Key | Action |
| --- | --- |
| `Right` / `Enter` | Choose selected item (Enter) |
| `Left` / `Backspace` | Go back (Previous page) |
| `j` / `Down` | Move selection down |
| `k` / `Up` | Move selection up |
| `g g` / `Home` | Go to top |
| `G` / `End` | Go to bottom |
| `Tab` | Focus next window |
| `Shift`+`Tab` | Focus previous window |

### Playback Control
| Key | Action |
| --- | --- |
| `Space` | Resume / Pause |
| `n` | Next track |
| `p` | Previous track |
| `.` | Play random track |
| `+` / `-` | Volume up / down |
| `_` | Mute |
| `r` | Refresh playback |

### Pages & Views
| Key | Action |
| --- | --- |
| `g l` | Library Page |
| `g p` | Playlists Page |
| `g a` | Albums Page |
| `g A` | Artists Page |
| `g s` | Search Page |
| `g L` | Lyrics Page |
| `/` | Search |

### Other
| Key | Action |
| --- | --- |
| `q` | Quit |
| `?` | Open Command Help |

For a full list of commands and configuration options, please refer to the configuration file or the help menu (`?`) within the application.
