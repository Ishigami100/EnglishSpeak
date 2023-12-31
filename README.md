# EnglishSpeak



## 環境構築

**前準備**

①docker desktopアプリをインストール

https://docs.docker.jp/docker-for-windows/install.html



**環境構築**

①作業フォルダへ移動する

```
cd ./EnglishSpeak
```

②dockerでビルドを行う

```
docker-compose build
```

③コンテナを起動する（-dは デタッチド・モード: バックグラウンドでコンテナを実行し、新しいコンテナ名を表示する）

```
 docker-compose up -d
```

※②③は下記コマンドにまとめられる

```
docker compose up -d --build
```

④データベースを作成する

```
docker-compose run backend rails db:create
```

追記：No such file entrypoint.shが出た場合

Windowsの設定でLFからCRLFに変換されてしまうらしいので、こちらのコマンドで変更後うまくいきます。

```
git config --global core.autocrlf input
```

## アプリの起動

**Backend**

Railsのバックエンド側は下記アドレスで入れる

```
http://localhost:3001
```

Swagger-uiは下記のアドレスで入れる

ここに実装済みのAPIについては説明を入れました。

```
http://localhost:3001/api-docs
```

**Frontend**

①コンテナの中へ下記コマンドで入る

```
docker compose exec front bash
```

②中に入った後必要モジュールのインストール(初回のみ)

```
npm install --save-dev typescript return
```

③npmを起動

```
npm start
```



## dbの初期化

アプリを起動するためにdbを構成する

```
docker-compose exec backend bash #bashに入る
もしくは
docker desktopのbackendコンテナからCLIに入る

rails db:migrate:reset
rails db:seed
```

これにより初期データの挿入が行われる。



ここから下は時間があった場合に実装を行う。

## テストについて

Swagger-ui,rswag,rspecを導入済み。

下記コマンドでswagger.yml を生成。SPecを直しこのコマンドを打つことで、swagger.yml が更新される

```
RAILS_ENV=test rake rswag:specs:swaggerize
```



※もしうまくいかない場合は、下記コマンドで初期化を行う。

```
bundle install
```

rswag をインストール

```
bundle exec rails g rswag:api:install
bundle exec rails g rswag:ui:install
bundle exec rails generate rspec:install
RAILS_ENV=test bundle exec rails g rswag:specs:install
```



## RSpec

RSpecを実行するために、中に入る

```
docker-compose exec backend bash
```

RSpecを実施

```
RSpec
```

