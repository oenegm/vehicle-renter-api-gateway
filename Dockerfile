# Stage 1: Build
FROM gradle:jdk21-alpine AS build
WORKDIR /app

# Copy only build files for dependency resolution
COPY build.gradle.kts .
COPY settings.gradle.kts .
RUN gradle --no-daemon --parallel clean dependencies

# Copy the rest of the application code
COPY . .
RUN gradle --no-daemon --parallel bootJar -x test

# Stage 2: Run
FROM openjdk:21-jdk-slim
COPY --from=build /app/build/libs/*.jar /app.jar
CMD ["java", "-XX:+UseParallelGC", "-jar", "/app.jar"]
