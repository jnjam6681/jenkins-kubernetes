FROM openjdk:8-jdk

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} && \
    useradd -c "Jenkins user" -d /home/${user} -u ${uid} -g ${gid} -m ${user}

# install docker
RUN mkdir -p /tmp/download && \
    curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.06.0-ce.tgz | tar -xz -C /tmp/download && \
    rm -rf /tmp/download/docker/dockerd && \
    mv /tmp/download/docker/docker* /usr/local/bin/ && \
    rm -rf /tmp/download && \
    groupadd -g 999 docker && \
    usermod -aG staff,docker jenkins

VOLUME /var/jenkins_home
