FROM maven:3.8.5-openjdk-8 AS build

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the final lightweight image
FROM openjdk:8-jre-slim

WORKDIR /app

COPY --from=build /app/target/JobPortal-0.0.1-SNAPSHOT.jar /app/JobPortal.jar

EXPOSE 5050

CMD ["java", "-Xmx512m", "-jar", "JobPortal.jar"]

# Optional: Health check
HEALTHCHECK CMD curl --fail http://https:/JobPortal-web-8aku.onrender.com/actuator/health || exit 1
