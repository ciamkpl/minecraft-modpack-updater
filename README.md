# minecraft-modpack-updater
simple updater allowing to update the modpack. 
author: m1ron

prequisities: 

sudo apt install libarchive-tools
sudo apt install zip
mkdir server-downloads
mkdir server-backups
mkdir modpack-worlds
chmod a+x modpack-updater.sh

either move the world to other location (everything should still work as before, but tested without AMP): mv world /home/miron/Downloads/valhelsia/modpack-worlds and then create a symlink: ln -s /home/miron/Downloads/valhelsia/modpack-worlds . (dot only when you are in directory where world is supposed to be)

for convenience remember to link full path from root (/a/b/c/d/map)

variables:
ENV="$HOME/Downloads/valhelsia"   #set this variable to script location, KEEP THE DIRECTORY STRUCTURE as i didn't make sure it will work without it ^^
PATH_DOWNLOADS="server-downloads"   #variable pointing at zip files download location
PATH_BACKUPS="server-backups"   #variable for backup created when script is run
PATH_CURRENT="valhelsia-2-test"  #has to point at valhelsia 2 directory

script will automatically create a backup of the current server version excluding symbolic links, so either symlink the world or add -x world/* as argument.

usage: ./modpack-updater.sh server-downloads/Valhelsia+2-2.2.7.zip
