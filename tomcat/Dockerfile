FROM necbaas/openjdk

ENV TOMCAT_VERSION 9.0.12

# install tomcat
RUN curl -SLO http://archive.apache.org/dist/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz \
  && mkdir /opt/tomcat \
  && tar xzf apache-tomcat-$TOMCAT_VERSION.tar.gz -C /opt/tomcat --strip-components=1 \
  && rm apache-tomcat-$TOMCAT_VERSION.tar.gz \
  && rm -rf /opt/tomcat/webapps/*
