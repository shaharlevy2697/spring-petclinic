# Stage 1: Build and SonarQube Analysis
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy the project files
COPY . .

# Compile the project first
RUN mvn clean install

# Run SonarQube analysis after compilation
RUN mvn sonar:sonar \
    -Dsonar.host.url=http://20.224.19.207:9000 \
    -Dsonar.login=squ_900bb33ebc9fbc1d6bf974fa87b2592150084db6 \
    -Dsonar.qualitygate.wait=false \
    -Dsonar.java.binaries=target/classes || exit 1

# Stage 2: Build the final artifact
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app

# Copy the project again and build the final artifact
COPY . .
RUN ./mvnw clean package

# Stage 3: Create Final Image
FROM openjdk:17-jdk-slim
WORKDIR /code

# Copy the final JAR from the builder stage
COPY --from=builder /app/target/*.jar /code/app.jar

# Run the JAR file
CMD ["java", "-jar", "/code/app.jar"]
