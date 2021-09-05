#!/bin/sh

BAAS_VERSION=7.5.4

if [ ! -e files/baas-server-$BAAS_VERSION ]; then
    wget --no-check-certificate https://github.com/nec-baas/baas-server/releases/download/v$BAAS_VERSION/baas-server-$BAAS_VERSION.tar.gz
    tar xvzf baas-server-$BAAS_VERSION.tar.gz -C files/
fi
