# EnglishSpeak



## 環境構築

**前準備**

①docker desktopアプリをインストール

https://docs.docker.jp/docker-for-windows/install.html



**環境構築**

①作業フォルダへ移動する

```
cd ./EnglishSpeak/backend
```

②dockerでビルドを行う

```
docker-compose build
```

③コンテナを起動する（-dは デタッチド・モード: バックグラウンドでコンテナを実行し、新しいコンテナ名を表示する）

```
 docker-compose up -d
```

④データベースを作成する

```
docker-compose run web rails db:create
```



## アプリについて（途中）

コンテナの中へは下記コマンドで入る

```
docker-compose exec web bash
```

アプリへのアクセスは起動後

```
http://localhost:3000/
```



アプリの再起動は、下記手順で行う。



**再起動手順**

①作業フォルダへ移動する

```
cd ./EnglishSpeak/backend
```

②dockerでビルドを行う

```
docker-compose build
```

③コンテナを起動する（-dは デタッチド・モード: バックグラウンドでコンテナを実行し、新しいコンテナ名を表示する）

```
 docker-compose up -d
```



## dbの更新

dbの更新はdbの構成変更後に、下記コマンドをどちらか打つことで解決。

```
docker-compose run web rails　 db:migrate
```

or

```
docker-compose exec web bash #bashに入る
db:migrate
```



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
docker-compose exec web bash
```

RSpecを実施

```
RSpec
```

