# Stage 1: SonarQube Analysis
FROM maven:3.8.5-openjdk-8 AS sonar
WORKDIR /app
COPY . .
RUN mvn sonar:sonar -Dsonar.host.url=<your-sonar-host-url> -Dsonar.login=<your-sonar-token>

# Stage 2: Build the Artifact
FROM maven:3.8.5-openjdk-8 AS builder
WORKDIR /app
COPY . .
RUN ./mvnw package -X

# Stage 3: Create Final Image
FROM openjdk:11-jre-slim
WORKDIR /code
COPY --from=builder /app/target/*.jar /code/
CMD ["java", "-jar", "/code/*.jar"]
