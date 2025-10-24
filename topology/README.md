# Topology Visualization

This directory contains nix-topology configuration for visualizing your NixOS infrastructure.

## Overview

The topology system automatically generates SVG diagrams showing:

- **Hosts**: All NixOS configurations (WSL, L2) and other systems (L1 macOS)
- **Networks**: Defined networks (home, wsl) with CIDR information
- **Connections**: Network interfaces and their connections
- **Services**: (Optional) Services running on each host

## Structure

```
topology/
├── default.nix          # Global topology (networks, non-NixOS nodes, internet)
└── README.md            # This file

hosts/
├── nixos/
│   ├── L2/topology.nix  # L2 host topology config
│   └── WSL/topology.nix # WSL host topology config
└── darwin/
    └── L1/topology.nix  # L1 macOS (documentation only)
```

## Building the Topology

**Important**: The topology visualization requires Linux to build (uses Node.js/Puppeteer for rendering).

### On Linux Hosts (L2 or WSL)

```bash
# Build the topology diagrams
nix build .#topology.x86_64-linux.config.output

# View the output
ls -la result/

# Open the main topology diagram
xdg-open result/main.svg  # Linux
```

### From macOS (L1)

Option 1 - SSH to a Linux host:

```bash
ssh L2  # or WSL
cd /path/to/OS-nixCfg
nix build .#topology.x86_64-linux.config.output
```

Option 2 - Use remote builders (if configured):

```bash
nix build .#topology.x86_64-linux.config.output --builders 'ssh://L2 x86_64-linux'
```

### Automated Builds (GitHub Actions)

The topology is automatically built and committed to the repository via GitHub Actions:

- **Workflow**: `.github/workflows/topology-build.yml`
- **Trigger**: Changes to topology configuration files
- **Output**: SVG files in `assets/topology/`
- **Runner**: Ubuntu (Linux required for rendering)

The workflow automatically:

1. Builds the topology on every push to `master`
2. Generates all SVG diagrams
3. Commits them to `assets/topology/`
4. Makes visualizations available without manual builds

View the latest topology diagrams:

```bash
ls assets/topology/
# main.svg, network.svg, networks-overview.svg, etc.
```

Available diagrams in the output:

- `main.svg` - Complete infrastructure overview
- `network.svg` - Network-only view
- `networks-overview.svg` - Networks with their nodes
- `services-overview.svg` - Services across all hosts
- Individual host diagrams (e.g., `preferred-render-node-L2.svg`)

## Configuration

### Adding a New Host

For NixOS hosts, create a `topology.nix` file in the host directory:

```nix
{config, ...}: {
  topology.self = {
    # deviceType and name are automatically set for NixOS hosts

    hardware.info = "Description of the hardware";

    interfaces = {
      eth0 = {
        network = "home";  # Reference to network in topology/default.nix
        type = "ethernet"; # or "wifi", "virtual", etc.
      };
    };
  };
}
```

For non-NixOS hosts (like macOS, other Linux, routers), add them to `topology/default.nix`:

```nix
nodes.myhost = {
  name = "MyHost";
  deviceType = "device";  # or "router", "switch", etc.
  hardware.info = "Hardware description";
  interfaces.en0 = {
    network = "home";
    type = "wifi";
  };
};
```

### Adding Networks

Edit `topology/default.nix`:

```nix
networks.mynetwork = {
  name = "My Network";
  cidrv4 = "192.168.2.0/24";
  # cidrv6 = "fd00::/64";  # Optional IPv6
};
```

### Adding Services

In a host's `topology.nix`:

```nix
topology.self.services = {
  ssh = {
    name = "SSH Server";
    port = 22;
  };
  web = {
    name = "Web Server";
    port = 80;
  };
};
```

## Current Configuration

### Hosts

- **L2**: NixOS Desktop (Physical Hardware) - Connected to home network
- **WSL**: WSL2 Instance - Connected to WSL virtual network
- **L1**: macOS (nix-darwin) - Connected to home network via WiFi

### Networks

- **home**: Home Network (192.168.1.0/24)
- **wsl**: WSL Network (172.16.0.0/12)
- **internet**: Global Network

## Customization

The topology module supports many more features:

- Physical connections between devices
- Multiple interfaces per host
- Custom device types and icons
- Connection labels and metadata
- Network diagrams with subnets

See the [nix-topology documentation](https://github.com/oddlama/nix-topology) for more details.
