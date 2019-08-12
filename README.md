# oc-linux-cc
Linux, for ComputerCraft. Much better than [this](https://github.com/ocawesome101/oc-linux-cc-old).

#### Installation
Simply run `pastebin run wMhFGDAr` in your CraftOS shell. While OC Linux will work best on an Advanced Computer, it should work on any computer, though (in the case of the Command Computer) potentially without full support.

#### Changelog
Dates are formatted `MM/DD/YY`.

08/10/19
 - Initial release.
 - Includes a basic shell and commands. These will improve with time.
Features:
 - Better login system than the previous OC Linux (0.5.0).
 - Two users, `root` (default password `root`) and `user` (default password `user`).
 - Detects when the user is in their home directory and changes the directory from i.e. `/home` to `~`. Also will change the prompt to `#` or `$` depending on the user.
- Realistic boot and shutdown logging, 
- A custom BIOS that supports (or should support) booting from floppy disks on any side of the computer. (Not strictly a part of OC Linux, but a nice feature. Adds some polish.)
- Really terrible password "protection". All it does is obscure.

#### Planned Features
- A package manager.
- Some kind of permissions system.
- The ability to change your password through `passwd`
- Better password protection.
- `sudo` or `su` commands to allow switching users.
- `useradd` and `userdel`. Share your computer without fear!
- `hostname` to change your hostname.
- `/etc/motd`

#### Workarounds while I add front-ends for these features
- To add a new user, first edit `/etc/users` and append your desired username. Then, edit `/etc/passwd` and append your desired password, reversed and repeated thrice backwards (so `root` becomes `toortoortoor`).
After adding one user (in this example `john`, with password `foobar`), your `/etc/passwd` and `/etc/users` should be, respectively:

        toortoortoor
    
        drowssapdrowssapdrowssap
    
        raboofraboofraboof
    
- and

        root
    
        user
    
        john

- To remove a user, simply remove the lines corresponding to that UID from `/etc/users` and `/etc/passwd`. Keep in mind, however, that this will shift all subsequent UIDs *down* by one. So, for instance, if you have users up to uid `7`, and you remove uid `5`, then uid `7` and `6` become uid `6` and `5`.

- To change your password, first figure out your UID (i.e. `john` from the previous example would be `3`.) Then, change line `<your UID>` of `/etc/passwd` to your desired password repeated thrice over and reversed (`word` becomes `drowdrowdrow`).

- To set your hostname, you can simply edit `/etc/hostname` and reboot. The system reads `/etc/hostname` when booting; the hostname can later be accessed as `_G._HOSTNAME` or, simply, `_HOSTNAME`.

##### Is this safe?
All builds are programmed and tested in the latest version of CCEmuX (version 88ba9e7a at the time of writing).
