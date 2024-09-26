# Stage 2: Build the Artifact
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN ./mvnw package
# Stage 3: Create Final Image
FROM openjdk:17-jdk-slim
WORKDIR /code
COPY --from=builder /app/target/*.jar /code/app.jar
CMD ["java", "-jar", "/code/app.jar"
