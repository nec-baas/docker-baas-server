FROM necbaas/openjdk

ENV TOMCAT_VERSION 9.0.13

# install tomcat
RUN mkdir /opt/tomcat && cd /opt/tomcat \
  && curl -SLO http://archive.apache.org/dist/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz \
  && tar xzf apache-tomcat-$TOMCAT_VERSION.tar.gz --strip-components=1 \
  && rm apache-tomcat-$TOMCAT_VERSION.tar.gz \
  && rm -rf webapps/* \
  && chmod -R ugo+rwx conf webapps logs temp work
