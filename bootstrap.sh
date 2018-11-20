#!/bin/sh

# 環境変数
export API_BASE_URL=${API_BASE_URL:-http://localhost:8080/api}
export API_INTERNAL_BASE_URL=${API_INTERNAL_BASE_URL:-}
export CONSOLE_BASE_URL=${CONSOLE_BASE_URL:-http://localhost:8080/console}

export MONGO_SERVERS=${MONGO_SERVERS:-127.0.0.1:27017}
export MONGO_USERNAME=${MONGO_USERNAME:-}
export MONGO_PASSWORD=${MONGO_PASSWORD:-}
export MONGO_MAX_CONNECTIONS_PER_HOST=${MONGO_MAX_CONNECTIONS_PER_HOST:-200}

export AMQP_ADDR=${AMQP_ADDR:-}
export AMQP_USERNAME=${AMQP_USERNAME:-}
export AMQP_PASSWORD=${AMQP_PASSWORD:-}
export AMQP_VHOST=${AMQP_VHOST:-}
export AMQP_URI=${AMQP_URI:-}

export SYSTEM_NO_CHARGE_KEY=${SYSTEM_NO_CHARGE_KEY:-tC0br8ciFAZmYdUHfS1JeJy4c}

export LOG_LEVEL=${LOG_LEVEL:-INFO}
export LOG_FLUENT_HOST=${LOG_FLUENT_HOST:-}
export LOG_FLUENT_PORT=${LOG_FLUENT_PORT:-24224}

export TOMCAT_MAX_THREADS=${TOMCAT_MAX_THREADS:-2000}
export TOMCAT_MAX_CONNECTIONS=${TOMCAT_MAX_CONNECTIONS:-2000}
export TOMCAT_SCHEME=${TOMCAT_SCHEME:-http}
export TOMCAT_SECURE=${TOMCAT_SECURE:-false}
export TOMCAT_PROXY_PORT=${TOMCAT_PROXY_PORT:-}

export TOMCAT_CONN_OTHER_CFGS=
if [ -n "$TOMCAT_PROXY_PORT" ]; then
    export TOMCAT_CONN_OTHER_CFGS="proxyPort=\"$TOMCAT_PROXY_PORT\""
fi

if [ ! -n "$LOG_FLUENT_HOST" ]; then
    echo "Not set logback.fluent"
    export LOG_TYPES=STDOUT,FILE
else
    echo "Set logback.fluent"
    export LOG_TYPES=STDOUT,FILE,FLUENT
fi

# Tomcat server.xml設定
cat server.template.xml | envsubst > /opt/tomcat/conf/server.xml

# BaaS 設定ファイル生成
cat /etc/baas/properties.template.xml | envsubst > /etc/baas/development.xml

# logback設定ファイル生成
cat /etc/baas/logback.template.properties | envsubst > /etc/baas/logback.properties

# tomcat 起動 (foreground)
exec /opt/tomcat/bin/catalina.sh run
