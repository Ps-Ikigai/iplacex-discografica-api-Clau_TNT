# -------- STAGE 1: Build con Gradle --------
FROM gradle:8.4-jdk17 AS build
WORKDIR /app

COPY . .
RUN gradle clean build -x test

# -------- STAGE 2: Run con JDK estable --------
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/build/libs/discografia-api-1.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
