# ---------- Stage 1: Build the application ----------
    FROM eclipse-temurin:17-jdk-alpine as build

    # Set working directory inside the container
    WORKDIR /workspace/app
    
    # Install Maven in the Alpine container
    RUN apk add --no-cache maven
    
    # Copy project files into container
    COPY pom.xml .
    COPY src ./src
    
    # Build the project and skip tests
    RUN mvn clean install -DskipTests
    
    # Unpack the JAR file into dependency folder
    RUN mkdir -p target/dependency && \
        cd target/dependency && \
        jar -xf ../*.jar
    
    # ---------- Stage 2: Create minimal runtime image ----------
    FROM eclipse-temurin:17-jre-alpine
    
    VOLUME /tmp
    ARG DEPENDENCY=/workspace/app/target/dependency
    
    # Copy only what is needed to run the app
    COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
    COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
    COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
    
    # Entry point to start the application
    ENTRYPOINT ["java","-cp","app:app/lib/*","com.example.notification.NotificationServiceApplication"]
    