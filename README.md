# t2server
Scripts to install and run a Tribes 2 server on Linux with Wine.

## about
t2server automates the installation of Tribes 2 and the TribesNEXT patch to run under wine on Linux. After installation, it provides systemd service units and Python scripts for the purpose of managing your server.

## prerequisites
t2server has a handful of dependencies which are not automatically handled at this time. Before you run the setup script, run the following commands depending on your distro:

### Debian 10; Ubuntu 20.04 LTS
```
$ sudo dpkg --add-architecture i386
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install unzip xvfb python3-minimal python3-pip wine32 cpulimit less
$ sudo pip3 install tqdm requests pyyaml
```
(more to be tested and added)

## installation
Run the 'setup' script and follow the instructions on screen.

The Tribes 2 installer (tribes2\_gsi.exe) and the TribesNEXT installer (TribesNext\_rc2a.exe) will be downloaded automatically. If you already have a copy of these, you can place them in the winbin directory and setup will use them instead of downloading.

Before automatic installation, you'll be asked to review and agree to both the Tribes 2 and TribesNEXT License Agreements.

A 't2server' user will be created with a home directory of /opt/t2server, which is also where Tribes 2 will be installed.

A compiled AutoIt script handles automatic installation of Tribes 2 and TribesNEXT via Wine. This script logs to /var/log/t2server/install\_wrapper.log.

After install, any .vl2 files in the addons directory will be copied to the GameData/base directory. Any .tar, .tgz, .tar.gz, .txz, .tar.xz, .tbz, or .tar.bz files will be extracted into GameData. This can be used to automate the installation of any mods, map packs, texture packs, etc, just make sure the archive file contains the directory that should be created under GameData (eg. if you're including the Version2 mod, your archive file should have only a 'Version2' directory at the top level with all the contents within it). The setup script will not do any safety checks on these archive files, so an improperly set up archive file will make a mess in GameData.

## running and managing t2server
The basic config file is /etc/t2server/config.yaml. Here you can specify which server prefs file to load, which mod to use, and whether the server is public or private (LAN). Additionally, you can schedule a day and time to auto-restart t2server each week as Tribes 2 servers are known to have stability issues as uptime increases. There is also a setting for overriding Tribes 2's man-in-the-middle attack detection, which tends to interfere with multihomed servers or those behind a NAT. Finally, you can specify a map rotation here. Some mods provide their own mechanisms for this and some do not. Be sure to only enable one or the other.

ServerPrefs files can be kept in /etc/t2server/serverprefs:
- t2server can be controlled using systemctl:
- Start server: `$ sudo systemctl start t2server`
- Stop server: `$ sudo systemctl stop t2server`
- Restart server: `$ sudo systemctl restart t2server`

The Tribes 2 console logs to /var/log/t2server/console.log.

## known issues
If you attempt to install from /root or one of its subdirectories, the t2server user will not be able to access the winbin directory and the automated Tribes 2 and TribesNEXT installation will fail. Place the installer under /home, /tmp, /var/tmp, or some other path that is traversable by unprivileged users.

RHEL/CentOS 7 and 8 no longer include wine32 in their repos, so installing on them is non-trivial. You would likely need to compile it yourself.

t2server depends on systemd, so it definitely won't work on any distro that's not using it.

When wine is run in the background, it spawns 2 "wineconsole --use-event=*nn*" processes that will consume all available CPU. I have been unable to find a proper solution to this, so for now t2server will run cpulimit against these processes at startup in order to contain them. I have not seen this result in any performance issues.

console.log includes ANSI escape sequences to set colors and terminal size, so your shell will get a little funky after tailing this log. Just run `reset` to reinitialize your session and you'll be back to normal.
