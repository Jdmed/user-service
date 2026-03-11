# ----------- BUILD STAGE -----------
FROM maven:3.9-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ----------- RUNTIME STAGE ----------
FROM eclipse-temurin:11-jdk
WORKDIR /home/app
ENV SPRING_PROFILES_ACTIVE=prod
ENV _JAVA_OPTIONS="-Xmx256m -Xms256m"
COPY --from=build /app/target/*.jar user-service.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "user-service.jar"]



