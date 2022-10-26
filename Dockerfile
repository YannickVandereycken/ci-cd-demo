### BUILD image
FROM maven:3.8.6-openjdk-18-slim as builder
# create app folder for sources
RUN mkdir -p /build
WORKDIR /build
COPY pom.xml /build
#Download all required dependencies into one layer
RUN mvn -B dependency:resolve dependency:resolve-plugins
#Copy source code
COPY src /build/src
# Build application
RUN mvn package -Dmaven.test.skip

#deploy in tomcat
FROM tomcat:9.0-jdk17-corretto
#copy war file
COPY --from=builder /build/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh","run"]
