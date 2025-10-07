FROM maven:3.9.4-amazoncorretto as builder

WORKDIR /app
COPY ./pom.xml ./
RUN mvn dependency:resolve
COPY . .
RUN mvn package
VOLUME ["/app/data"]
FROM tomcat:9.0
# WORKDIR /app
COPY --from=builder /app/target/maven-web-application.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
# CMD ["java","-jar","EmployeeService.jar"]

