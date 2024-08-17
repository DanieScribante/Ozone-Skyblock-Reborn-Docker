Server Download: https://drive.google.com/drive/folders/1iwMkd7_ez6o_sm-37JGeO6samSz49JCu
Mod Page: https://www.curseforge.com/minecraft/modpacks/ozone-skyblock-reborn

Place server [modpacks downloaded from CurseForge](https://www.curseforge.com/minecraft/modpacks) in this directory.

The example [`docker-compose-curseforge.yml`](../docker-compose-curseforge.yml) references a modpack downloaded from <https://www.curseforge.com/minecraft/modpacks/skyfactory-4/files/3012800>.


--

# [FTB Skies Expert](https://feed-the-beast.com/modpacks/117-ftb-skies-expert) By FTB

<!-- toc -->

- [Description](#description)
- [Requirements](#requirements)
- [Options](#options)
  * [Adding Minecraft Operators](#adding-minecraft-operators)
- [Troubleshooting](#troubleshooting)
  * [Accept the EULA](#accept-the-eula)
  * [Permissions of Files](#permissions-of-files)
  * [Resetting](#resetting)
- [Source](#source)

<!-- tocstop -->

## Description

This container is built to run on an [Unraid](https://unraid.net) server, outside of that your milliage will vary.

The docker on first run will download the same version as tagged of `FTB Skies Expert` and install it.  This can take a while as the Forge installer can take a bit to complete.  You can watch the logs and it will eventually finish.

After the first run it will simply start the server.

Note: There are no modded minecraft files shipped in the container, they are all downloaded at runtime.

## Requirements

* /data mounted to a persistent disk
* Port 25565/tcp mapped
* environment variable EULA set to "true"

As the end user, you are repsonsible for accepting the EULA from Mojang to run their server, by default in the container it is set to false.

## Options

These environment variables can be set at run time to override their defaults.

* JVM_OPTS "-Xms4096m -Xmx6144m"
* MOTD "FTB Skies Expert Server Powered by Docker"
* LEVEL world

### Adding Minecraft Operators

Set the enviroment variable `OPS` with a comma separated list of players.

example:
`OPS="OpPlayer1,OpPlayer2"`

## Troubleshooting

### Accept the EULA
Did you pass in the environment variable EULA set to `true`?

### Permissions of Files
This container is designed for [Unraid](https://unraid.net) so the user in the container runs on uid 99 and gid 100.  This may cause permission errors on the /data mount on other systems.

### Resetting
If the install is incomplete for some reason.  Deleting the downloaded server file in /data will restart the install/upgrade process.

## Source
Github: https://github.com/Robonau/docker-ftbskies-expert

Docker: https://github.com/Robonau/docker-ftbskies-expert

Original Template is by [Goobaroo](https://github.com/Goobaroo/docker-ftbskies)

Workflows partially from [math7935](https://github.com/math7935/docker-ftbskies-expert)