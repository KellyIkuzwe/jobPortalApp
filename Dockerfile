# Stage 1: Build the application
FROM maven:3.8-openjdk-17 AS build
WORKDIR /app

# Copy only the POM file to cache dependencies
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline

# Copy the source code
COPY src/ src/

# Build the application
RUN mvn package -DskipTests

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy only the necessary artifacts from the build stage
COPY --from=build /app/target/JobPortal-0.0.1-SNAPSHOT.jar .

# Expose the port that the application will run on
EXPOSE 8080

# Specify the command to run on container start
CMD ["java", "-jar", "JobPortal-0.0.1-SNAPSHOT.jar"]
