#!/bin/sh

# 環境変数
MONGO_SERVERS=${MONGO_SERVERS:-127.0.0.1:27017}
MONGO_USERNAME=${MONGO_USERNAME:-}
MONGO_PASSWORD=${MONGO_PASSWORD:-}
MONGO_MAX_CONNECTIONS_PER_HOST=${MONGO_MAX_CONNECTIONS_PER_HOST:-200}
AMQP_ADDR=${AMQP_ADDR:-}
AMQP_USERNAME=${AMQP_USERNAME:-}
AMQP_PASSWORD=${AMQP_PASSWORD:-}
AMQP_VHOST=${AMQP_VHOST:-}
AMQP_URI=${AMQP_URI:-}
SYSTEM_NO_CHARGE_KEY=${SYSTEM_NO_CHARGE_KEY:-tC0br8ciFAZmYdUHfS1JeJy4c}
LOG_LEVEL=${LOG_LEVEL:-INFO}
LOG_FLUENT_HOST=${LOG_FLUENT_HOST:-}
LOG_FLUENT_PORT=${LOG_FLUENT_PORT:-24224}
BAAS_TYPE=${BAAS_TYPE:-both}
TOMCAT_MAX_THREADS=${TOMCAT_MAX_THREADS:-2000}
TOMCAT_MAX_CONNECTIONS=${TOMCAT_MAX_CONNECTIONS:-2000}
TOMCAT_SCHEME=${TOMCAT_SCHEME:-http}
TOMCAT_SECURE=${TOMCAT_SECURE:-false}
TOMCAT_PROXY_PORT=${TOMCAT_PROXY_PORT:-}

TOMCAT_CONN_OTHER_CFGS=
if [ -n "$TOMCAT_PROXY_PORT" ]; then
    TOMCAT_CONN_OTHER_CFGS="proxyPort=\"$TOMCAT_PROXY_PORT\""
fi

# Tomcat server.xml設定
cat server.template.xml \
    | sed "s/%TOMCAT_MAX_THREADS%/$TOMCAT_MAX_THREADS/" \
    | sed "s/%TOMCAT_MAX_CONNECTIONS%/$TOMCAT_MAX_CONNECTIONS/" \
    | sed "s/%TOMCAT_SCHEME%/$TOMCAT_SCHEME/" \
    | sed "s/%TOMCAT_SECURE%/$TOMCAT_SECURE/" \
    | sed "s/%TOMCAT_CONN_OTHER_CFGS%/$TOMCAT_CONN_OTHER_CFGS/" \
    > /opt/tomcat/conf/server.xml

# war 配置
case "$BAAS_TYPE" in
    "apiOnly" )
        echo "BAAS_TYPE is apiOnly"
        rm /opt/tomcat/webapps/console.war
        ;;
    "consoleOnly" )
        echo "BAAS_TYPE is consoleOnly"
        rm /opt/tomcat/webapps/api.war
        ;;
    * )
        echo "BAAS_TYPE is both"
        ;;
esac

# 設定ファイル生成
if [ -n "$AMQP_ADDR" ]; then
    echo "Set AMQP_ADDR"
    cat /etc/baas/properties.template.xml \
        | sed 's#<!-- <entry key="amqp.addrs"></entry> -->#<entry key="amqp.addrs">%AMQP_ADDR%</entry>#' \
        | sed 's#<!-- <entry key="amqp.username"></entry> -->#<entry key="amqp.username">%AMQP_USERNAME%</entry>#' \
        | sed 's#<!-- <entry key="amqp.password"></entry> -->#<entry key="amqp.password">%AMQP_PASSWORD%</entry>#' \
        | sed 's#<!-- <entry key="amqp.vhost"></entry> -->#<entry key="amqp.vhost">%AMQP_VHOST%</entry>#' \
        > /etc/baas/properties.template2.xml
    cat /etc/baas/properties.template2.xml \
        | sed "s#%AMQP_ADDR%#$AMQP_ADDR#" \
        | sed "s#%AMQP_USERNAME%#$AMQP_USERNAME#" \
        | sed "s#%AMQP_PASSWORD%#$AMQP_PASSWORD#" \
        | sed "s#%AMQP_VHOST%#$AMQP_VHOST#" \
        > /etc/baas/properties.template.xml
elif [ -n "$AMQP_URI" ]; then
    echo "Set AMQP_URI"
    cat /etc/baas/properties.template.xml \
        | sed 's#<!-- <entry key="amqp.uri"></entry> -->#<entry key="amqp.uri">%AMQP_URI%</entry>#' \
        > /etc/baas/properties.template2.xml
    cat /etc/baas/properties.template2.xml \
        | sed "s#%AMQP_URI%#$AMQP_URI#" \
        > /etc/baas/properties.template.xml
else
    echo "Not set AMQP"
fi

cat /etc/baas/properties.template.xml \
    | sed "s/%MONGO_SERVERS%/$MONGO_SERVERS/" \
    | sed "s/%MONGO_USERNAME%/$MONGO_USERNAME/" \
    | sed "s/%MONGO_PASSWORD%/$MONGO_PASSWORD/" \
    | sed "s/%MONGO_MAX_CONNECTIONS_PER_HOST%/$MONGO_MAX_CONNECTIONS_PER_HOST/" \
    | sed "s/%SYSTEM_NO_CHARGE_KEY%/$SYSTEM_NO_CHARGE_KEY/" \
    > /etc/baas/development.xml

# logback設定ファイル生成
cat /etc/baas/logback.template.properties \
    | sed "s/%LOG_LEVEL%/$LOG_LEVEL/" \
    > /etc/baas/logback.template2.properties

if [ ! -n "$LOG_FLUENT_HOST" ]; then
    echo "Not set logback.fluent"
    cat /etc/baas/logback.template2.properties \
        | sed "s/%LOG_TYPES%/STDOUT,FILE/" \
        > /etc/baas/logback.properties
else
    echo "Set logback.fluent"
    cat /etc/baas/logback.template2.properties \
        | sed "s/%LOG_TYPES%/STDOUT,FILE,FLUENT/" \
        | sed 's/#logback.fluent.host=%LOG_FLUENT_HOST%/logback.fluent.host=%LOG_FLUENT_HOST%/' \
        | sed 's/#logback.fluent.port=%LOG_FLUENT_PORT%/logback.fluent.port=%LOG_FLUENT_PORT%/' \
        > /etc/baas/logback.template.properties
    cat /etc/baas/logback.template.properties \
        | sed "s/%LOG_FLUENT_HOST%/$LOG_FLUENT_HOST/" \
        | sed "s/%LOG_FLUENT_PORT%/$LOG_FLUENT_PORT/" \
        > /etc/baas/logback.properties
fi

# tomcat 起動 (foreground)
#/opt/tomcat/bin/startup.sh && tail -f /opt/tomcat/logs/catalina.out
/opt/tomcat/bin/catalina.sh run
