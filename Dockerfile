FROM openjdk:19-jdk-alpine

LABEL authors="Omar E. Negm, Mohammed H. Ramadan"

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]