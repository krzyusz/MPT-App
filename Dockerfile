# Używamy oficjalnego obrazu OpenJDK z narzędziem Gradle do budowy
FROM gradle:jdk17 AS builder

# Tworzymy katalog aplikacji wewnątrz kontenera
WORKDIR /app

# Kopiujemy pliki źródłowe do kontenera
COPY src /app/src
COPY build.gradle /app/build.gradle
COPY settings.gradle /app/settings.gradle

# Budujemy plik JAR za pomocą Gradle
RUN gradle build

RUN pwd
RUN ls ./build/libs

# Używamy mniejszego obrazu JRE
FROM openjdk:17-jdk-slim

# Tworzymy katalog aplikacji wewnątrz kontenera
WORKDIR /app

# Kopiujemy skompilowany plik JAR z etapu budowy
COPY --from=builder /app/build/libs/SurveysServerApplication-0.0.1.jar /app/app.jar

# Expose port, na którym działa serwer Spring Boot
EXPOSE 8080

# Komenda uruchamiana przy starcie kontenera
CMD ["java", "-jar", "/app/app.jar"]