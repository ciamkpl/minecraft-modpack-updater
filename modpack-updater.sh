#!/bin/bash
#author m1ron
#usage ./modpack-updater.sh package.zip

#getting package absolute path, now script location can be random
get_path() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

#absolute paths implemented everywhere
PATH_BACKUPS="/media/sf_cudashared/valhelsia-2/server-backups"
PATH_CURRENT="/media/sf_cudashared/valhelsia-2/valhelsia-2-current"
PACKAGE=$(get_path $1)
DATE=`date +%Y%m%d%H%M%S`

#LEAVE EMPTY UNLESS YOU DONT HAVE/DONT WANT TO HAVE SYMBOLIC LINK TO THE WORLD IN DIRECTORY
#WORLD=
WORLD="/media/sf_cudashared/valhelsia-2/valhelsia-2-current/valhelsia-2-world"

#check if the server is running 
if [[ -n `lsof $PATH_CURRENT/forge*` ]]; then echo "MINECRAFT FORGE STILL RUNNING!!!"; echo "exiting"; exit; fi

#make backup of current server, add -x world_name/* if no symlink created so you exclude the world from being backed up
printf "backuping current server: "$PATH_CURRENT" to "$PATH_BACKUPS"/valhelsia-2.zip."$DATE

if [[ -z $WORLD ]]
then
  echo "INFO: world not excluded"
  zip -yr $PATH_BACKUPS/val-2.zip.$DATE $PATH_CURRENT/
else
  echo "INFO: world IS excluded"
  zip -yr $PATH_BACKUPS/val-2.zip.$DATE $PATH_CURRENT/ -x "$WORLD/*"
fi

#remove all files and directories you are going to replace
for i in config defaultconfigs libraries global_data_pack mods openloader scripts 1.15.2.json forge* minecraft_server.1.15.2.jar ServerStart.sh ServerStart.bat
do
  echo "removing $i"
  rm -r $PATH_CURRENT/$i
done

#for debug purposes
echo "sleeping 5 sec"
sleep 5

#unpack the zip file into the current valhelsia 2 location excluding all the readme etc.
bsdtar --strip-components=1 -xvf $PACKAGE -C $PATH_CURRENT --exclude 'server.properties' --exclude 'README.txt' --exclude 'server-icon.png' --exclude 'whitelist.json' --exclude 'banned-ips.json' --exclude 'banned-players.json' --exclude 'eula.txt' --exclude 'usercache.json' --exclude 'backups'

#add run privilege if you are using ServerStart.sh
chmod a+x $PATH_CURRENT/ServerStart.sh

#add all config update lines below this comment. 
