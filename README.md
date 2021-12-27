# Supported tags and respective `Dockerfile` links
-	[`latest` (*buster/Dockerfile*)](https://github.com/matm616/ProjectZomboidServer/blob/master/buster/Dockerfile)


# What is Project Zomboid?
Project Zomboid is an open world survival horror video game in development by British and Canadian independent developer The Indie Stone. The game is set in a post-apocalyptic, zombie-infested world where the player is challenged to survive for as long as possible

>  [Project Zomboid](https://store.steampowered.com/app/108600/Project_Zomboid/)

## How to use
There are 2 persitant directories to set
- `server-data`: hold server configuration, needed to persist save and settings
- `server-files`: holds server files, recommended by [CM2Walki/steamcmd](https://github.com/CM2Walki/steamcmd) to enable faster and better updating

# Configuration
## Environment Variables
```dockerfile
SERVER_PUBLIC_NAME="Project Zomboid Server on Docker"
SERVER_PUBLIC_DESC=""
SERVER_PASSWORD=""
RCON_PORT=27015
RCON_PASSWORD="projectzomboid-rcon-password"
XMX="1G"
XMS="4G"
ADMIN_PASSWORD="projectzomboidserver"
```

## Volumes

- **/server-data** Data directory of the server. Contains db, config files...
- **/server-files** Application dir of the server.

## Expose
- **8766** Steam port 1 (udp)
- **8767** Steam port 2 (udp)
- **27015** RCON
- **16261** Game server (udp)

## Contributions
- [CM2Walki/steamcmd](https://github.com/CM2Walki/steamcmd): For the base steamcmd image and image configuration
- [cyrale/project-zomboid](https://github.com/cyrale/project-zomboid): For information on image scripts and configuration
- [Project Zomboid Dedicated Server Wiki](https://pzwiki.net/wiki/Dedicated_Server): For information on how to set up the game server