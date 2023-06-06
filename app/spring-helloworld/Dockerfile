# Use a OpenJDK image
FROM openjdk:17

WORKDIR /usr/src/myapp

COPY ./app/spring-helloworld/target/fullstackbook-springboot-eks-0.0.1-SNAPSHOT.jar /usr/src/myapp

CMD ["java", "-jar", "/usr/src/myapp/fullstackbook-springboot-eks-0.0.1-SNAPSHOT.jar"]
