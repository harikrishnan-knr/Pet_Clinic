FROM maven:3.9.9-amazoncorretto-21-alpine AS builder

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

FROM tomcat:9.0

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/war.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
