# Checklists

## Pre-release checklist

- [ ] change the `version` value defined in `main.rs` and `Cargo.toml`.
- [ ] run `cargo clippy` to check the codes as well as to update `Cargo.lock`
- [ ] run `cargo publish` in the `1337spotify` folder to publish the package
- [ ] create a new release in [`github`](https://github.com/rozatheriviter/1337spotify-tui/releases/new)

## Creating new commands

- [ ] add new entries to the `Command` enum defined in `command.rs` and to the `Command::desc` function
- [ ] add a new default key mapping for the command in `config/keymap.rs`
- [ ] update the command table in `readme.md`

**Note**: should follow a similar checklist when modifying a command
