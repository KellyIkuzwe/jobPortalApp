# Use a base image with Java and Maven pre-installed
FROM maven:3.8-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project file
COPY pom.xml .

# Download dependencies and build the application
RUN mvn clean package -DskipTests

# Use a lightweight base image with Java
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/JobPortal-0.0.1-SNAPSHOT.jar .

# Expose the port that the application will run on
EXPOSE 8080

# Specify the command to run on container start
CMD ["java", "-jar", "JobPortal-0.0.1-SNAPSHOT.jar"]
