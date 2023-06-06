# Build
FROM maven:3.8.3-openjdk-17-slim AS build

WORKDIR /app

COPY app/spring-helloworld/pom.xml .

COPY app/spring-helloworld/src ./src

RUN mvn package -DskipTests

# Runtime
FROM openjdk:17-jdk-alpine

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app.jar"]