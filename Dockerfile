# Stage 1: Build
FROM gradle:jdk17-alpine AS build
WORKDIR /app

# Copy only build files for dependency resolution
COPY build.gradle.kts .
COPY settings.gradle.kts .
RUN gradle --no-daemon --parallel dependencies

# Copy the rest of the application code
COPY . .
RUN gradle --no-daemon --parallel bootJar

# Stage 2: Run
FROM openjdk:17-jdk-alpine
COPY --from=build /app/build/libs/*.jar /app.jar
CMD ["java", "-XX:+UseParallelGC", "-jar", "/app.jar"]
