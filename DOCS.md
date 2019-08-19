# Overview

OC Linux is a reimplementation of Linux, written entorely in Lua. It depends on a few of the ComputerCraft APIs, though it can probably be ported to a non-ComputerCraft system very easily.

This is somewhat of my pet project; I will add features when I have the time, and I do accept commits as long as they are clearly explained and don't unnecessarily change things too drastically. For instance, if you rewrite all my scripts, just make your own version and repo, don't go making a pull request to this.

# Technical Details

### 1. Booting

OC Linux is not a UEFI-compatible OS, though it can probably be made to boot with UEFI-CSM. It uses [a custom BIOS](https://github.com/ocawesome101/ocbios)
