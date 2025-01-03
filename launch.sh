#!/bin/bash

set -x

if ! [[ -w "/data" ]]; then
  echo "Directory is not writable, check permissions for /mnt/user/appdata/"
  exit 66
fi

ID=117
VER=11927
FilesVer=1.12.2
tempVar=Server

cd /data

if ! [[ "$EULA" = "false" ]] || grep -i true eula.txt; then
	echo "eula=true" > eula.txt
else
	echo "You must accept the EULA by in the container settings."
	exit 9
fi

#-------------------------------------------------------
# I need to recreate this

# if ! [[ -f serverinstall_${ID}_${VER} ]]; then
#   rm -f serverinstall_${ID}* forge-*.jar run.sh start.sh
#   curl -Lo serverinstall_${ID}_${VER} https://api.modpacks.ch/public/modpack/${ID}/${VER}/server/linux
#   chmod +x serverinstall_${ID}_${VER}
#    ./serverinstall_${ID}_${VER} --path /data --nojava
#   rm -f ./mods/entity_model_features_forge_*.jar ./mods/entity_texture_features_forge_*.jar
# fi

if ! [[ -f Version_${FilesVer}.txt ]]; then
  mkdir todelete
  mv * todelete/
  mv todelete/world .
  rm -rf todelete
  touch Version_${FilesVer}.txt
  curl -L "https://drive.usercontent.google.com/download?id=1xwDl4lpHaeRi7hjPdxHV6JDegTf48BHA&confirm=xxx" -o ServerFiles.zip
  unzip ServerFiles.zip
  mv OSR\ Server\ -\ ${FilesVer}/* ./
  rm ServerFiles.zip
fi

  # mv OSR\ 1.11.8\ -\ ${tempVar}/* ./
#-------------------------------------------------------

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' > ops.txt
fi
if [[ -n "$ALLOWLIST" ]]; then
    echo $ALLOWLIST | awk -v RS=, '{print}' > white-list.txt
fi

sed -i 's/server-port.*/server-port=25565/g' server.properties

[[ -f run.sh ]] && chmod 755 run.sh
[[ -f start.sh ]] && chmod 755 start.sh
if [[ -f run.sh || -f start.sh ]]; then
  if [[ -f user_jvm_args.txt ]]; then
    echo $JVM_OPTS > user_jvm_args.txt
  fi
  [[ -f run.sh ]] && ./run.sh || ./start.sh
else
  rm -f forge-*-installer.jar
  FORGE_JAR=$(ls forge-*.jar)

  curl -Lo log4j2_112-116.xml https://launcher.mojang.com/v1/objects/02937d122c86ce73319ef9975b58896fc1b491d1/log4j2_112-116.xml
  java -server -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -Dfml.queryResult=confirm -Dlog4j.configurationFile=log4j2_112-116.xml $JVM_OPTS -jar $FORGE_JAR nogui
fi