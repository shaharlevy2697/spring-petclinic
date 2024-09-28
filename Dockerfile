# Stage 2: Build the Artifact
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN ./mvnw package

RUN  mvn sonar:sonar \
    -Dsonar.host.url=http://20.224.19.207:9000 \
    -Dsonar.login=sqa_55fb99cf571c3ab44349acac72cd21d32ce49b68 \
    -Dsonar.qualitygate.wait=false

# Stage 3: Create Final Image
FROM openjdk:17-jdk-slim
WORKDIR /code
COPY --from=builder /app/target/*.jar /code/app.jar
CMD ["java", "-jar", "/code/app.jar"}
