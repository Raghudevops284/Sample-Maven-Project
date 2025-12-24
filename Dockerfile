# Use official Tomcat image
FROM tomcat:9.0-jdk11

USER ubuntu
WORKDIR /opt
# Remove default ROOT app (optional but recommended)
#RUN rm -rf /usr/local/tomcat/webapps/* && apt update && apt install nginx -y && mkdir /opt/tomcat  && wget  https://downloads.apache.org/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.zip.asc



ADD  src /opt/tomcat

ADD https://downloads.apache.org/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.zip.asc /opt/tomcat


# Copy your WAR file from Maven target directory into Tomcat
COPY target/devops111.war /usr/local/tomcat/webapps/ROOT.war

COPY Jenkinsfile /opt

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

#CMD ["echo", "Hello-world"]

