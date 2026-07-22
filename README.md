# My Nix Setup Notes

## First Time Setup

### macOS (Choon-Keats-MacBook-Air)

1. Install prerequisites
```bash
xcode-select --install
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

2. Clone config
```bash
git clone https://github.com/ekiost/nix.git ~/.config/nix
```

3. Apply config
```bash
nix run nix-darwin -- switch --flake ~/.config/nix#Choon-Keats-MacBook-Air
```

> If it fails, give Terminal Full Disk Access in System Settings > Privacy & Security

4. Reboot

---

### NixOS (Choon-Keats-NixOS)

1. After installing NixOS, clone config
```bash
nix-shell -p git
git clone https://github.com/ekiost/nix.git ~/.config/nix
```

2. Apply config
```bash
sudo nixos-rebuild switch --flake ~/.config/nix#Choon-Keats-NixOS
```

3. Reboot

---

## Daily Use

Update config:
```bash
config-switch
```

Update flake inputs:
```bash
config-update
```

---

## Clean Slate (macOS only)

```bash
# Remove homebrew casks
brew list --cask | xargs brew uninstall --cask --zap

# Remove nix-darwin
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller

# Remove nix
/nix/nix-installer uninstall
```
