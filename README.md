NECモバイルバックエンド基盤 Dockerfile
======================================

NECモバイルバックエンド基盤サーバ (APIサーバ/Consoleサーバ)用の
Dockerfile

以下イメージを含む。

* necbaas/api-server : BaaS APIサーバ
* necbaas/console-server : BaaS Consoleサーバ
* necbaas/api-console-server : BaaS API + Consoleサーバ

起動例
------

    $ docker pull necbaas/api-console-server
    $ docker run -d -p 8080:8080 -e JAVA_OPTS="-Xmx2048m" -e MONGO_SERVERS=mongodb://mongo1.example.com:27017 necbaas/api-server

環境変数
--------

APIサーバ / Console サーバ実行時には以下の環境変数が参照される。

なお、Java, Tomcat 関連については、それぞれ
[docker-openjdk](https://github.com/nec-baas/docker-openjdk)
[docker-tomcat](https://github.com/nec-baas/docker-tomcat)
を参照のこと。

### MongoDB関連

* MONGO_SERVERS: MongoDBサーバURL (default: 127.0.0.1:27017)
* MONGO_USERNAME: MongoDB認証ユーザ名 (default: なし)
* MONGO_PASSWORD: MongoDB認証パスワード (default: なし)
* MONGO_MAX_CONNECTIONS_PER_HOST: MongoDB最大コネクション数/ホスト (default: 200)

### AMQP (RabbitMQ) 関連

* AMQP_ADDR: AMQPサーバアドレス (default: なし)
* AMQP_USERNAME: AMQP認証ユーザ名 (default: なし)
* AMQP_PASSWORD: AMQP認証パスワード (default: なし)
* AMQP_VHOST: AMQP vhost (default: なし)
* AMQP_URI: AMQP URI (default: なし)

### ロギング
* LOG_LEVEL: ログレベル (default: INFO)
* LOG_FLUENT_HOST: fluentd ホスト名 (default: なし)
* LOG_FLUENT_PORT: fluentd ポート番号 (default: 24224)

### その他

* SYSTEM_NO_CHARGE_KEY: No charge key (default: tC0br8ciFAZmYdUHfS1JeJy4c)
