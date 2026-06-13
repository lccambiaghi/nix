# Luca's Nix Config

macOS (nix-darwin) plus a Home Manager-only Linux VM profile, driven by flakes.

## Prerequisites

- Nix installed with flakes enabled (e.g., Determinate installer).  
- macOS: nix-darwin available (the flake builds it).  
- Linux VM: Home Manager available (`nix shell nixpkgs#home-manager -c home-manager …` is fine).

## Quick start

### 1) Clone

```bash
git clone https://github.com/lucacambiaghi/config-nix ~/.config/nix
cd ~/.config/nix
```

### 2) macOS hosts (`mbp`, `brc`)

```bash
# first run (replace <host> with mbp or brc)
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-25.11#darwin-rebuild -- switch --flake ~/.config/nix/#<host>

# from second run (auto-detects the host from hostname):
make reload
```

### 3) Linux VM (`cloudVM`, Home Manager only)

On an x86_64 Linux machine/container with Nix:

```bash
nix shell nixpkgs#home-manager -c home-manager switch --flake ~/.config/nix#cloudVM
```

If you just want to check it evaluates from macOS:

```bash
nix build ~/.config/nix#homeConfigurations.cloudVM.activationPackage
```

## Structure

```
flake.nix          # inputs and outputs (mbp + brc + cloudVM)
darwin/            # nix-darwin modules (macOS)
home/              # Home Manager modules (shared by mac + VM)
hosts/mbp/         # host-specific darwin module(s)
hosts/brc/         # host-specific darwin module(s)
```
