# Network Overview

## Tailscale

This document outlines the process of using Tailscale to provide availablitty for remote club memebers and admin off hours configurations. Tailscale provides an overlay VPN solution that allows us to access club hosted resources remotely.

## OPNsense Firewall

- A Single simple linux bridge is created from the Proxmox GUI and labeled accordingly. This bridge will be the lan bridge.
- Create an SDN Zone in the cluster and diffrennt vnets will be attached to them

### Network Setup
