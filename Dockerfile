### BUILD image
FROM maven:3-jdk-11 as builder
# create app folder for sources
RUN mkdir -p /build
WORKDIR /build
COPY pom.xml /build
#Download all required dependencies into one layer
RUN mvn -B dependency:resolve dependency:resolve-plugins
#Copy source code
COPY src /build/src
# Build application
RUN mvn package
#copy war file
COPY --from=builder /build/target/*.war animals.war

#deploy in tomcat
FROM tomcat:latest
COPY animals.war /usr/local/tomcat/webapps/
CMD ["catalina.sh","run"]