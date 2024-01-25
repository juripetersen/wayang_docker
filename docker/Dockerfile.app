FROM apache-wayang-base:latest

RUN mkdir -p /var/www/html
COPY . /var/www/html
WORKDIR /var/www/html

ENV MAVEN_CONFIG ""
#RUN mvn clean package -pl :wayang-assembly -Pdistribution -X

ENTRYPOINT "/bin/bash"
