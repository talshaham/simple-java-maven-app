FROM maven:latest as builder
COPY . .
RUN mvn package


FROM openjdk:17-alpine
ARG VERSION=1
ENV VERSION=$VERSION
COPY --from=builder ./target/my-app-1.0.$VERSION.jar .
CMD java -jar my-app-1.0.$VERSION.jar
