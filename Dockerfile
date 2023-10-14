FROM ubuntu:latest AS build

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y openjdk-21-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . . 

RUN apt-get install maven -y 
RUN mvn clean install

FROM openjdk:21-jdk-slim

EXPOSE 8080

COPY --from=build /target/todolist-1.0.0.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]