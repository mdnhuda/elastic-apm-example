FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY elastic*.jar /usr/app/agent.jar
COPY ${JAR_FILE} /usr/app/frontend.jar

WORKDIR /usr/app

CMD java -javaagent:agent.jar \
    -Delastic.apm.service_name=frontend \
    -Delastic.apm.server_urls=http://apm:8200 \
    -Delastic.apm.application_packages=com.kambi \
    -Delastic.apm.transaction_sample_rate=0.1 \
    -jar frontend.jar
