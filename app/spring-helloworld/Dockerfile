# Stage 1: Build
FROM maven:3.8.3-openjdk-17-slim AS build
WORKDIR /app/spring-helloworld
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Runtime
FROM openjdk:17
WORKDIR /app
COPY --from=build /app/spring-helloworld/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
