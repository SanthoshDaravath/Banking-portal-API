# Build stage
FROM eclipse-temurin:25-jdk-alpine AS build
RUN apk add --no-cache maven
WORKDIR /app
COPY . .
RUN mvn -DskipTests clean package

# Runtime stage
FROM eclipse-temurin:25-jre-alpine
WORKDIR /
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
