# Palworld dedicated server docker

[ENGLISH](README.md) | [日本語](README-JA.md)

[Palworld](https://www.pocketpair.jp/palworld?lang=ja)のマルチプレイを可能にする、公式専用サーバーのDockerイメージとDocker Composeのサンプルを配布しています。

Palworldサーバーガイドも併せてご確認ください。

- Palworldサーバーガイド
[https://tech.palworldgame.com/ja/](https://tech.palworldgame.com/ja/)

## 公式専用サーバーのイメージ

下記ページでイメージを配布しています。

- Package palserver
[https://github.com/pocketpairjp/palworld-dedicated-server-docker/pkgs/container/palserver](https://github.com/pocketpairjp/palworld-dedicated-server-docker/pkgs/container/palserver)

## Docker Compose
Docker Composeを利用して簡単に専用サーバーを立ち上げることもできます。

### 起動と終了
```shell
# compose.yaml が存在するフォルダで操作を行ってください。
> ls
compose.yaml

# 起動
> docker compose up -d

# 終了
> docker compose down

# ログの確認
> docker compose logs
```

`docker compose up` コマンドを利用して起動すると、初回時のみセーブファイルと設定ファイルが `./Saved` 以下に生成されます。

### サーバーの設定

各設定項目についてはあらかじめPalworldサーバーガイドをご確認ください。

- Palworldサーバーガイド
[https://tech.palworldgame.com/ja/](https://tech.palworldgame.com/ja/)


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

`compose.yaml` ファイル内 `image` 部分の末尾を変更することでサーバーの更新を行うことができます。更新作業の際は必ずセーブデータのバックアップを行ってください。

### トラブルシューティング

#### Q. ゲームから接続ができません
Windows Subsystem for Linuxを利用している場合、 `localhost` で接続できない問題を確認しています。代わりに `127.0.0.1` を利用してください。
