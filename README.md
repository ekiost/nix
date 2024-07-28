# Nix Flakes for MacOS

1. Install Xcode Command Line Tools
```bash
xcode-select --install
```

2. Install Nix
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

3. Download this repository to .config/nix

4. Rename default config.nix to config.nix.before-darwin-config
```bash
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-darwin-config
```

5. Run the following command to apply the configuration
```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix
```

6. Reboot the system

Subsequent updates can be applied with the following command
```bash
config-switch
```