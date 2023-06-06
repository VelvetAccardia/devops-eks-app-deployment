FROM maven:3.8.2-openjdk-17-slim AS build
WORKDIR /app
COPY ./app/spring-helloworld/pom.xml ./pom.xml
COPY ./app/spring-helloworld/src ./src
RUN mvn clean package

FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/spring-helloworld-0.0.1-SNAPSHOT.jar /app
CMD ["java", "-jar", "/app/spring-helloworld-0.0.1-SNAPSHOT.jar"]
