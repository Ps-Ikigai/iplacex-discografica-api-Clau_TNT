# =======================
# STAGE 1: Build del JAR
# =======================
FROM gradle:8.2.1-jdk17 AS build

WORKDIR /app

COPY . .

RUN gradle clean build -x test

# =======================
# STAGE 2: Run del JAR
# =======================
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/build/libs/discografia-api-1.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]