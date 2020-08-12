#!/bin/bash
#author m1ron
#usage ./modpack-updater.sh package.zip

ENV="$HOME/Downloads/valhelsia"
PATH_DOWNLOADS="server-downloads"
PATH_BACKUPS="server-backups"
PATH_CURRENT="valhelsia-2-test"
PACKAGE=$1
DATE=`date +%Y%m%d%H%M%S`

#i only left last cURL arguments.
#  --compressed --output $ENV/$PATH_DOWNLOADS/latest.zip

#check if the server is running 
if [[ -n `lsof $ENV/$PATH_CURRENT/forge*` ]]; then echo "MINECRAFT FORGE STILL RUNNING!!!"; echo "exiting"; exit; fi

#make backup of current server, add -x world_name/* if no symlink created so you exclude the world from being backed up
printf "backuping current server: "$PATH_CURRENT" to "$PATH_BACKUPS"/"$PATH_CURRENT".tar.gz."$DATE
zip -yr $ENV/$PATH_BACKUPS/val-2.zip.$DATE $ENV/$PATH_CURRENT/

#no need for this anymore
#if ! [[ -d $ENV/$PATH_TMP ]]; then mkdir $ENV/$PATH_TMP; fi

#remove all files and directories you are going to replace
for i in config defaultconfigs libraries global_data_pack mods openloader scripts 1.15.2.json forge* minecraft_server.1.15.2.jar ServerStart.sh ServerStart.bat; do rm -r $PATH_CURRENT/$i; done

echo "sleeping 15 sec"
sleep 15

#unpack the zip file into the current valhelsia 2 location excluding all the readme etc.
bsdtar --strip-components=1 -xvf $ENV/$PACKAGE -C $ENV/$PATH_CURRENT --exclude 'server.properties' --exclude 'README.txt' --exclude 'server-icon.png' --exclude 'whitelist.json' --exclude 'banned-ips.json' --exclude 'banned-players.json' --exclude 'eula.txt' --exclude 'usercache.json' --exclude 'backups'

#add run privilege if you are using ServerStart.sh
chmod a+x $ENV/$PATH_CURRENT/ServerStart.sh

#add all config update lines below this comment. 
