
FROM gradle:jdk17 AS builder

WORKDIR /app

COPY SurveysServer/src /app/src
COPY SurveysServer/build.gradle /app/build.gradle
COPY SurveysServer/settings.gradle /app/settings.gradle


RUN gradle build

RUN pwd
RUN ls ./build/libs
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/build/libs/SurveysServer-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"]