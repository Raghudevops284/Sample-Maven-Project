# Use official Tomcat image
FROM tomcat:9.0-jdk11

# Remove default ROOT app (optional but recommended)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file from Maven target directory into Tomcat
COPY target/devops111.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
