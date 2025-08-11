FROM maven:3.9.11-eclipse-temurin-17-alpine as build
RUN git clone https://github.com/shasha617/spring-petclinic-mm.git && \
    cd spring-petclinic && \
    mvn package

FROM openjdk:25-ea-17-jdk as run 
RUN adduser -d -h /usr/share/demo -s /bin/bash testuser
USER testuser
WORKDIR /usr/share/demo
COPY --from=build /target/*.jar .
EXPOSE 8080/tcp
CMD ["java","-jar","*.jar"]

