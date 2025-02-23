# My Nix Setup Notes

## First Time Setup

1. Prerequisites
```bash
xcode-select --install
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

2. Apply config
```bash
nix run nix-darwin -- switch --flake ~/.config/nix
```

Note: If fails, give Terminal Full Disk Access in Security & Privacy settings

3. Reboot

## Daily Use

Update config:
```bash
config-switch
```

Update flake inputs:
```bash
config-update
```

## Clean Slate (if needed)

```bash
# Remove homebrew casks
brew list --cask | xargs brew uninstall --cask --zap

# Remove nix-darwin
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller

# Remove nix
/nix/nix-installer uninstall
```