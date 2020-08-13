# minecraft-modpack-updater
simple updater allowing to update the modpack. 
author: m1ron


prequisities: 


sudo apt install libarchive-tools

sudo apt install zip

mkdir server-backup #not required but PATH_BACKUPS has to point somewhere

chmod a+x modpack-updater.sh



you can move the world to other location (everything should still work as before, but tested without AMP): mv world /home/miron/Downloads/valhelsia/modpack-worlds and then create a symlink: ln -s /home/miron/Downloads/valhelsia/modpack-worlds . (dot only when you are in directory where world is supposed to be)

remember to link as absolute path (from root directory) (/a/b/c/d/map)



variables (ONLY ABSOLUTE PATHS)

PATH_BACKUPS="/media/sf_cudashared/valhelsia-2/server-backups"   #variable for backup created when script is run

PATH_CURRENT="/media/sf_cudashared/valhelsia-2/valhelsia-2-current"  #has to point at valhelsia 2 directory

WORLD="/media/sf_cudashared/valhelsia-2/valhelsia-2-current/valhelsia-2-world" #script checks if value is NULL (empty) and will take it under account if world is present
OR
WORLD=     #choose whether it should omit world directory or not

script will automatically create a backup of the current server version excluding symbolic links.

usage: ./modpack-updater.sh Valhelsia+2-2.2.7.zip
