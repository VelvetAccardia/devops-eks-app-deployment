# Build
FROM maven:3.8.3-openjdk-17-slim AS build

WORKDIR /app

COPY pom.xml .

COPY src ./src

RUN mvn package -DskipTests

# Runtime
FROM openjdk:17-jdk-alpine

COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
