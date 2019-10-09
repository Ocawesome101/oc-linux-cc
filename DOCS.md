# Overview

OC Linux is a reimplementation of Linux, written entorely in Lua. It depends on a few of the ComputerCraft APIs, though it can probably be ported to a non-ComputerCraft system very easily.

This is somewhat of my pet project; I will add features when I have the time, and I do accept commits as long as they are clearly explained and don't unnecessarily change things too drastically. For instance, if you rewrite all my scripts, just make your own version and repo, don't go making a pull request to this.

# Technical Details

## 1. Booting

OC Linux is not a UEFI-compatible OS, though it can probably be made to boot with UEFI-CSM, if any such thing is available for ComputerCraft. By default, it uses [a custom BIOS](https://github.com/ocawesome101/ocbios), which boots from .mbr/boot.lua on the specified device (disk booting is as yet untested and may not work).

The OC-Linux MBR loads `/boot/syslinux/bootCC.boot`, which in turn loads the kernel at `/boot/vmlinux.lua`.

My custom OC-Linux kernel loads `/sbin/ccinit.lua` as its [`init` system](https://en.wikipedia.org/wiki/Init). CCInit then loads a few things and displays a login prompt.

## 2. Login

The OC-Linux login prompt is located at `/usr/bin/login.lua`. To decrypt the user's password, it loads a simple obfuscation API from `/usr/lib/hash.lua`, and unloads it when done. Passwords are stored in `/etc/passwd`, and usernames in `/ect/users`. It should be noted that EVERY user MUST have a password, or the login system will break.

Once the user has successfully logged in, they are greeted with a shell.

## 3. The Shell

The OC-Linux shell is based on the default CraftOS one, though it does have some omissions; Linux does not have `multishell`, for instance.

The prompt is only customizable by editing the `/bin/ocsh.lua` file and changing it. By default, it displays `user@hostname: ` followed by `your/current/directory`, with a `#` or a `$` at the end depending on your user.

When you exit the shell, you will be brought back to the login screen.

- If you are in a subfolder of your home folder, the full path (`/home/user/path`, not `~/path`) will be displayed.

## 4. Shutdown

The shutdown process is fairly simple: unload CCInit, unload the kernel, close the log file (located at `/var/log/dmesg.log` and/or `/var/log/dmesg.log.old`). After this has been done, OC Linux calls an ACPI shutdown.

## 5. Reboot

Rebooting shuts down the computer, and then calls an ACPI reboot.
