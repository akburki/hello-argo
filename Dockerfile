FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -q -B package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/hello-argo.jar app.jar
RUN useradd --system --uid 10001 app
USER 10001
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
