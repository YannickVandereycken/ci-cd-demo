FROM tomcat:latest
COPY /target/Animals-1.0.war /usr/local/tomcat/webapps/
