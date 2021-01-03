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
$ sudo apt install unzip xvfb python3-minimal python3-pip wine32 cpulimit
$ sudo pip3 install tqdm requests pyyaml
```
(more to be tested and added)

## running and managing t2server
t2server can be controlled using systemctl.

Start server: `$ sudo systemctl start t2server`

Stop server: `$ sudo systemctl stop t2server`

Restart server: `$ sudo systemctl restart t2server`

The basic config file is /etc/t2server/config.yaml. Here you can specify which server prefs file to load, which mod to use, and whether the server is public or private (LAN). 

Additionally, you can schedule a day and time to auto-restart t2server each week as Tribes 2 servers are known to have stability issues as uptime increases.

There is also a setting for overriding Tribes 2's man-in-the-middle attack detection, which tends to interfere with multihomed servers or those behind a NAT.

Finally, you can specify a map rotation here. Some mods provide their own mechanisms for this and some do not. Be sure to only enable one or the other.

serverprefs files can be kept in /etc/t2server/serverprefs.

## known issues
If you attempt to install from /root or one of its subdirectories, the t2server user will not be able to access the winbin directory and the automated Tribes 2 and TribesNEXT installation will fail. Place the installer under /home, /tmp, /var/tmp, or some other path that is traversable by unprivileged users.

RHEL/CentOS 7 and 8 no longer include wine32 in their repos, so installing on them is non-trivial. You would likely need to compile it yourself.

t2server depends on systemd, so it definitely won't work on any distro that's not using it.

When wine is run in the background, it spawns a `wineconsole --use-event=52` process that will consume all available CPU. I have been unable to find a proper solution to this, so for now t2server will run cpulimit against this process at startup in order to contain it.

## legal compliance
Tribes 2 and TribesNEXT are freely available but are not Free Software so the installers have not been bundled in. Instead, the setup script will automatically download and run them during installation. As the automated installation of both prevents you from seeing their license agreements, the setup script will display them in plain text and require you to accept them before installation runs.
