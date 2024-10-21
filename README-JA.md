# Palworld dedicated server docker

[ENGLISH](README.md) | [日本語](README-JA.md)

[Palworld](https://www.pocketpair.jp/palworld?lang=ja)のマルチプレイを可能にする、公式専用サーバーのDockerイメージとDocker Composeのサンプルを配布しています。 Palworldサーバーガイドも併せてご確認ください。

[はじめに | Palworld Server Guide](https://tech.palworldgame.com/ja/)

### Note
配布している `compose.yaml` ファイルはサンプルです。ご利用の環境で適宜編集し、セーブデータがきちんと保存されるか確認してからご利用ください。

また、Docker Desktopを用いたWindows / macOS環境での実行はディスク書き込み・読み込み速度が制限されるため非推奨です。代わりにSteamを利用した方法をご検討ください。

[要件 | Palworld Server Guide](https://tech.palworldgame.com/ja/getting-started/requirements)

## 公式専用サーバーのイメージ

GitHub Packagesでイメージを配布しています。

[Package palserver](https://github.com/pocketpairjp/palworld-dedicated-server-docker/pkgs/container/palserver)

## Docker Compose
Docker Composeを利用して簡単に専用サーバーを立ち上げることもできます。

### 起動と終了
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

初回時のみ、 `docker compose up` コマンドを利用して起動すると、セーブファイルと設定ファイルが `./Saved` 以下に生成されます。

### サーバーの設定

各設定項目についてはあらかじめPalworldサーバーガイドをご確認ください。

[Settings and Operations | Palworld Server Guide](https://tech.palworldgame.com/ja/category/settings-and-operations)

プレイヤー人数やポートの変更など、引数を通した設定を行いたい場合は `compose.yaml` を編集してください。

```yaml
services:
    # ... #
    command:
      - -port=8211
      - -useperfthreads
      - -NoAsyncLoadingThread
      - -UseMultithreadForDS
```

ゲームバランスやサーバー名等の変更を行いたい場合は `./Saved/Config/LinuxServer/PalWorldSettings.ini` を編集してください。下記はサーバーパスワードとデスペナルティの設定を行った場合の設定ファイルの内容です。

```ini
[/Script/Pal.PalGameWorldSettings]
OptionSettings=(ServerPassword="quivern0119",DeathPenalty=None)
```

デフォルトの設定値を確認したい場合はイメージ内の `/pal/Package/DefaultPalWorldSettings.ini` をご確認ください。 `docker compose up` コマンドで専用サーバーを立ち上げたあと下記コマンドで確認を行うことができます。このファイルを直接編集してもゲーム内に設定は反映されないので注意してください。

```ini
> docker compose exec palworld-server bash -c "cat /pal/Package/DefaultPalWorldSettings.ini"
; This configuration file is a sample of the default server settings.
; Changes to this file will NOT be reflected on the server.
; To change the server settings, modify Pal/Saved/Config/LinuxServer/PalWorldSettings.ini.
[/Script/Pal.PalGameWorldSettings]
OptionSettings=(Difficulty=None // ... //)
```

### 専用サーバーの更新

**必ずバックアップを取得してから更新を行ってください。** `docker compose down` コマンドでサーバーを停止し、 `compose.yaml` のイメージタグをゲームバージョンに合わせて変更して `docker compose up -d` コマンドで再起動してください。