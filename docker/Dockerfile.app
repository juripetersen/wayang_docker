FROM apache-wayang-base:latest

RUN mkdir -p /var/www/html
COPY . /var/www/html
WORKDIR /var/www/html

ENV MAVEN_CONFIG ""

# Aliases for builds
RUN echo 'rebuild () { mvn clean install -DskipTests -Drat.skip=true -pl :"$1" && mvn clean package -DskipTests -pl :"$1"; }' >> /root/.bashrc && \
    echo 'assemble () { mvn clean package -pl :wayang-assembly -Pdistribution && cd wayang-assembly/target && tar -xvf apache-wayang-assembly-0.7.1-incubating-dist.tar.gz && cd wayang-0.7.1; }' >> /root/.bashrc

# Install ThesisML python
RUN cd /var/www/html/wayang-plugins/wayang-ml/src/main/python && \
    git clone https://github.com/mylos97/Thesis-ML.git python-ml && \
    cd ./python-ml && \
    python3.11 -m venv ./venv && \
    ./venv/bin/python3.11 --version && \
    ./venv/bin/python3.11 -m pip install -r requirements.txt && \
    cd /var/www/html

ENTRYPOINT "/bin/bash"

