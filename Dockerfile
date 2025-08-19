FROM maven:3.9.11-eclipse-temurin-17 AS build
RUN git clone https://github.com/spring-petclinic/spring-petclinic.git && \
    cd spring-petclinic && \
    mvn package

FROM eclipse-temurin:17.0.16_8-jre-ubi9-minimal AS run 
RUN  adduser -m -d /usr/share/demo -s /bin/bash testuser
USER testuser
WORKDIR /usr/share/demo
COPY --from=build /spring-petclinic/target/*.jar manu.jar
EXPOSE 8080/tcp
CMD ["java","-jar","manu.jar"]

