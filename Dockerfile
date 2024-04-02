FROM maven:latest as builder
COPY . .
RUN mvn package


FROM openjdk:17-alpine
COPY --from=builder ./target/my-app-1.0.jar .
CMD java -jar my-app-1.0.jar
