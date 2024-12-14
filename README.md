# Nix Flakes for MacOS

1. Install Xcode Command Line Tools
```bash
xcode-select --install
```

2. Install Nix
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

3. Clone the repository

4. Run the following command to apply the configuration
```bash
nix run nix-darwin -- switch --flake ~/.config/nix
```
[!NOTE]
If the command fails, enable Full Disk Access for Terminal in System Preferences > Security & Privacy > Privacy > Full Disk Access

5. Reboot the system

Subsequent updates can be applied with the following command
```bash
config-switch
```
