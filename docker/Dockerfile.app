FROM apache-wayang-base:latest

RUN mkdir -p /var/www/html
COPY . /var/www/html
WORKDIR /var/www/html

ENV MAVEN_CONFIG ""

# Aliases for builds
RUN echo 'rebuild () { mvn clean install -DskipTests -Drat.skip=true -pl :"$1" && mvn clean package -DskipTests -pl :"$1"; }' >> /root/.bashrc && \
    echo 'assemble () { mvn clean package -pl :wayang-assembly -Pdistribution && cd wayang-assembly/target && tar -xvf apache-wayang-assembly-0.7.1-SNAPSHOT-incubating-dist.tar.gz && cd wayang-0.7.1-SNAPSHOT; }' >> /root/.bashrc

ENTRYPOINT "/bin/bash"

