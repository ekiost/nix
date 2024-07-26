# Setup

1. Install Xcode Command Line Tools
```bash
xcode-select --install
```

2. Install Nix
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

3. Clone the repository
```bash
git clone https://github.com/ekiost/nix-config ~/.config/nix
```

4. First-time configuration
```bash
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.config/nix
```

5. Subsequent updates
```bash
switch
```