#!/bin/bash

ENV="$HOME/Downloads/valhelsia"
PATH_DOWNLOADS="server-downloads"
PATH_BACKUPS="server-backups"
PATH_CURRENT="valhelsia-2-test"
PACKAGE=$1
DATE=`date +%Y%m%d%H%M%S`

#curl 'https://edge.forgecdn.net/files/3028/425/Valhelsia%202-2.2.7.zip' \
#  -H 'authority: edge.forgecdn.net' \
#  -H 'upgrade-insecure-requests: 1' \
#  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36' \
#  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
#  -H 'sec-fetch-site: cross-site' \
#  -H 'sec-fetch-mode: navigate' \
#  -H 'sec-fetch-dest: document' \
#  -H 'referer: https://www.curseforge.com/minecraft/modpacks/valhelsia-2/download/3028425' \
#  -H 'accept-language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7,und;q=0.6,de;q=0.5' \
#  --compressed --output $ENV/$PATH_DOWNLOADS/latest.zip

if [[ -n `lsof $ENV/$PATH_CURRENT/forge*` ]]; then echo "MINECRAFT FORGE STILL RUNNING!!!"; echo "exiting"; exit; fi

printf "backuping current server: "$PATH_CURRENT" to "$PATH_BACKUPS"/"$PATH_CURRENT".tar.gz."$DATE
zip -yr $ENV/$PATH_BACKUPS/val-2.zip.$DATE $ENV/$PATH_CURRENT/

#if ! [[ -d $ENV/$PATH_TMP ]]; then mkdir $ENV/$PATH_TMP; fi

for i in config defaultconfigs libraries global_data_pack mods openloader scripts 1.15.2.json forge* minecraft_server.1.15.2.jar ServerStart.sh ServerStart.bat; do rm -r $PATH_CURRENT/$i; done

echo "sleeping 15 sec"
sleep 15

bsdtar --strip-components=1 -xvf $ENV/$PACKAGE -C $ENV/$PATH_CURRENT --exclude 'server.properties' --exclude 'README.txt' --exclude 'server-icon.png' --exclude 'whitelist.json' --exclude 'banned-ips.json' --exclude 'banned-players.json' --exclude 'eula.txt' --exclude 'usercache.json' --exclude 'backups'

chmod a+x $ENV/$PATH_CURRENT/ServerStart.sh
