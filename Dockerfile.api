FROM necbaas/tomcat

# Install BaaS Server
ENV BAAS_VERSION 7.5.1
RUN cd /opt/tomcat/webapps \
    && aria2c -x10 --check-certificate=false https://github.com/nec-baas/baas-server/releases/download/v$BAAS_VERSION/api.war

# Add config files
RUN mkdir /etc/baas /var/log/baas
ADD properties.template.xml /etc/baas/
ADD logback.template.properties /etc/baas/
ADD server.template.xml /

# Fix permission
RUN chmod -R ugo+rwx /etc/baas /var/log/baas

# Add startup script
ADD bootstrap.sh /
RUN chmod +x /bootstrap.sh

# Volume options
VOLUME ["/opt/tomcat/logs","/var/log/baas"]
 
# Open Tomcat port
EXPOSE 8080

CMD ["/bootstrap.sh"]
