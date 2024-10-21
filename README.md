# Palworld Dedicated Server Docker

[ENGLISH](README.md) | [日本語](README-JA.md)

We provide the Docker image and sample Docker Compose files for the official dedicated server, enabling multiplayer for [Palworld](https://www.pocketpair.jp/palworld?lang=en). Please also check the Palworld server guide.

[Introduction | Palworld Server Guide](https://tech.palworldgame.com/)

### Note
The distributed `compose.yaml` file is a sample. Edit it as necessary to fit your environment and verify that save data is correctly saved before using it.

Also, running this on Windows/macOS using Docker Desktop is not recommended, as disk write/read speeds are limited. Consider using the Steam-based method instead.

[Requirements | Palworld Server Guide](https://tech.palworldgame.com/getting-started/requirements)

## Official Dedicated Server Image

The image is distributed via GitHub Packages.

[Package palserver](https://github.com/pocketpairjp/palworld-dedicated-server-docker/pkgs/container/palserver)

## Docker Compose
You can easily set up a dedicated server using Docker Compose.

### Starting and Stopping
```shell
# Check the folder containing compose.yaml.
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

[Settings and Operations | Palworld Server Guide](https://tech.palworldgame.com/category/settings-and-operations)

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

To check the default settings, refer to the `/pal/Package/DefaultPalWorldSettings.ini` file inside the image. After starting the dedicated server with the `docker compose up` command, you can use the following command to check the contents. Note that editing this file directly will not reflect the changes in the game.

```ini
> docker compose exec palworld-server bash -c "cat /pal/Package/DefaultPalWorldSettings.ini"
; This configuration file is a sample of the default server settings.
; Changes to this file will NOT be reflected on the server.
; To change the server settings, modify Pal/Saved/Config/LinuxServer/PalWorldSettings.ini.
[/Script/Pal.PalGameWorldSettings]
OptionSettings=(Difficulty=None // ... //)
```

### Updating the Dedicated Server

**Be sure to back up your data before updating.** Stop the server with the `docker compose down` command, update the image tag in `compose.yaml` to match the game version, and restart with the `docker compose up -d` command.
