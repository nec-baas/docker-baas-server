FROM debian:sid-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl wget \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION 11.0.1

# Download OpenJDK and create minified JDK with jlink.
RUN cd /opt \
    && curl -O --insecure https://download.java.net/java/GA/jdk11/13/GPL/openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz \
    && tar xzf openjdk-${JAVA_VERSION}*.tar.gz \
    && /bin/rm openjdk-${JAVA_VERSION}*.tar.gz \
    && /opt/jdk-${JAVA_VERSION}/bin/jlink \
        --module-path /opt/jdk-${JAVA_VERSION}/jmods \
        --compress=2 \
        --add-modules java.se,jdk.jdi,jdk.httpserver,jdk.unsupported \
        --no-header-files \
        --no-man-pages \
        --output /opt/jdk-min \
    && /bin/rm -rf openjdk-*.tar.gz /opt/jdk-${JAVA_VERSION}

ENV JAVA_HOME /opt/jdk-min
ENV PATH ${PATH}:${JAVA_HOME}/bin

