# Palworld Dedicated Server Docker

[ENGLISH](README.md) | [日本語](README-JA.md)

This repository provides a Docker image and a Docker Compose sample for hosting an official dedicated server for multiplayer in [Palworld](https://www.pocketpair.jp/palworld?lang=en).

Please also refer to the Palworld Server Guide for more details.

- Palworld Server Guide: [https://tech.palworldgame.com/en/](https://tech.palworldgame.com/en/)

## Official Dedicated Server Image

The image is available at the following page:

- Package palserver: [https://github.com/pocketpairjp/palworld-dedicated-server-docker/pkgs/container/palserver](https://github.com/pocketpairjp/palworld-dedicated-server-docker/pkgs/container/palserver)

## Docker Compose
You can easily set up a dedicated server using Docker Compose.

### Starting and Stopping
```shell
# Perform operations in the folder containing compose.yaml.
> ls
compose.yaml

# Start the server
> docker compose up -d

# Stop the server
> docker compose down

# View logs
> docker compose logs
```

When you start the server using the `docker compose up` command, save files and configuration files will be generated under `./Saved` for the first time.

### Server Configuration

For details on each configuration item, please refer to the Palworld Server Guide.

- Palworld Server Guide: [https://tech.palworldgame.com/en/](https://tech.palworldgame.com/en/)

If you want to adjust player count, port settings, or other parameters, edit the `compose.yaml` file.

```yaml
services:
    # ... #
    command:
      - -port=8211
      - -useperfthreads
      - -NoAsyncLoadingThread
      - -UseMultithreadForDS
```

To adjust settings like game balance or server name, edit ./Saved/Config/LinuxServer/PalWorldSettings.ini. Below is an example of a configuration file where the server password and death penalty have been set:

```ini
[/Script/Pal.PalGameWorldSettings]
OptionSettings=(ServerPassword="quivern0119",DeathPenalty=None)
```

To check the default configuration values, refer to /pal/Package/DefaultPalWorldSettings.ini inside the image. After starting the dedicated server with the docker compose up command, you can check the contents using the following command. Note that directly editing this file will not apply changes in the game.

```ini
> docker compose exec palworld-server bash -c "cat /pal/Package/DefaultPalWorldSettings.ini"
; This configuration file is a sample of the default server settings.
; Changes to this file will NOT be reflected on the server.
; To change the server settings, modify Pal/Saved/Config/LinuxServer/PalWorldSettings.ini.
[/Script/Pal.PalGameWorldSettings]
OptionSettings=(Difficulty=None // ... //)
```

### Updating the Dedicated Server

You can update the server by changing the image part at the end of the compose.yaml file. Always back up your save data before performing an update.

### Troubleshooting

#### Q. I can't connect to the server from the game
If you are using Windows Subsystem for Linux, there is a known issue where connecting via localhost does not work. Please use 127.0.0.1 instead.
