This directory can hold addons that you want automatically added to your server.

Any .vl2 files placed here will be copied into the /opt/t2server/GameData/base 
directory.

Any .zip, .tar, .tgz, or .tar.gz files placed here will be extracted into 
/opt/t2server/GameData. This is intended for deploying mods. The setup script 
will not create a directory, so be sure your archive contains the parent
directory for the mod. For example:
   # tar -tf Version2.tar 
   Version2/
   Version2/V2_Features.txt
   Version2/prefs/
   Version2/prefs/banlist.cs
   Version2/prefs/11.29.2020Connect.log
   Version2/prefs/ServerPrefs.cs
   Version2/prefs/SctfPrefs.cs.dso
   Version2/prefs/SctfPrefs.cs
   Version2/prefs/ClientPrefs.cs
   Version2/Version2.txt
   ...

If your mod archive doesn't start with a directory, it will just make a mess of
GameData when extracted. There are no safety checks in the script.
