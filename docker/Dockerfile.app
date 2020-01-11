FROM maven:3.5-jdk-8

WORKDIR /code

ADD pom.xml /code/pom.xml
ADD src /code/src
RUN ["mvn", "package", "-DskipTests=true"]
RUN ["mvn", "sonar:sonar", "-Dsonar.projectKey=purple-team","-Dsonar.host.url=http://54.154.164.61:9000", "-Dsonar.login=ace1ec5b77e570e7eadf82efb3cfa7d37505078b"]

FROM java:8-jre

COPY --from=0 /code/target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar /

# expose http and debug ports
EXPOSE 8080 8000

CMD ["java", "-agentlib:jdwp=transport=dt_socket,server=y,address=8000,suspend=n", "-jar", "spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar"]
