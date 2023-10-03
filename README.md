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



## dbの更新

```
docker-compose run web rails　 db:migrate
```

or

```
docker-compose exec web bash #bashに入る
db:migrate
```

