FROM maven:latest
COPY . .
RUN mvn package
CMD java -jar /target/my-app-1.0.jar
