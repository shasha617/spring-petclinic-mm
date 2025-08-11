FROM maven:3.9.11-eclipse-temurin-17-alpine as build
RUN apk add   
RUN git clone https://github.com/shasha617/spring-petclinic-mm.git && \
    cd spring-petclinic-mm && \
    mvn package

FROM openjdk:25-ea-17-jdk as run 

RUN useradd -m -d /usr/share/demo -s /bin/bash testuser
USER testuser
WORKDIR /usr/share/demo
COPY --from=build /spring-petclinic-mm/target/*.jar .
EXPOSE 8080/tcp
CMD ["java","-jar","spring-petclinic-3.5.0-SNAPSHOT.jar"]

