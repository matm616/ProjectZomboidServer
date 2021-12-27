# Supported tags and respective `Dockerfile` links
-	[`latest` (*Dockerfile*)](https://github.com/matm616/ProjectZomboidServer/blob/master/buster/Dockerfile)


# What is Project Zomboid?
Project Zomboid is an open world survival horror video game in development by British and Canadian independent developer The Indie Stone. The game is set in a post-apocalyptic, zombie-infested world where the player is challenged to survive for as long as possible

>  [Project Zomboid](https://store.steampowered.com/app/108600/Project_Zomboid/)

## How to use
After first launch, the container should be restarted. This will allow the container to overwrite values in the config

There are 2 persitant directories to set
- `/home/steam/Zomboid`: hold server configuration, needed to persist save and settings
- `/home/steam/projectzomboid-dedicated`: holds server files, recommended by [CM2Walki/steamcmd](https://github.com/CM2Walki/steamcmd) to enable faster and better updating

Here is an example docker-compose file
```yaml
version: "3"

services:      
  projectzomboid:
    image: matm616/projectzomboid:latest
    container_name: projectzomboid
    restart: unless-stopped
    stdin_open: true
    tty: true
    environment:
      - RCON_PASSWORD=SuperSecretRcon
      - ADMIN_PASSWORD=SuperSecretAdmin
      - SERVER_PASSWORD=SuperSecretServer
    ports:
      - 8766:8766/udp
      - 8767:8767/udp
      - 16261:16261/udp
    volumes:
      - /home/ubuntu/projectzomboid/server:/home/steam/projectzomboid-dedicated
      - /home/ubuntu/projectzomboid/config:/home/steam/Zomboid
```

# Configuration
## Environment Variables
```dockerfile
SERVER_PUBLIC_NAME="Project Zomboid Server on Docker"
SERVER_PUBLIC_DESC=""
SERVER_PASSWORD=""
RCON_PORT=27015
RCON_PASSWORD="projectzomboid-rcon-password"
XMX="2G"
XMS="4G"
ADMIN_PASSWORD="projectzomboidserver"
```
These values will overwrite existing values in the config on restart

## Volumes
- **/home/steam/Zomboid** hold server configuration, needed to persist save and settings
- **/home/steam/projectzomboid-dedicated** Application folder, holds the server itself

## Expose
- **8766** Steam port 1 (udp)
- **8767** Steam port 2 (udp)
- **27015** RCON
- **16261** Game server (udp)

# Notes
## Contributions
- [CM2Walki/steamcmd](https://github.com/CM2Walki/steamcmd): For the base steamcmd image and image configuration
- [cyrale/project-zomboid](https://github.com/cyrale/project-zomboid): For information on image scripts and configuration
- [Project Zomboid Dedicated Server Wiki](https://pzwiki.net/wiki/Dedicated_Server): For information on how to set up the game server

## Final Notes
Use at own risk, this is the first time I created a docker image and it's messy