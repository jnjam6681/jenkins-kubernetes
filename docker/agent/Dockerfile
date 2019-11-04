FROM openjdk:8-jdk

# prepare home, user for jenkins
ENV JENKINS_HOME /var/jenkins_home

ARG VERSION=3.35
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

VOLUME /var/jenkins_home

RUN echo 'deb http://deb.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/stretch-backports.list
RUN apt-get update && apt-get install -t stretch-backports git-lfs \
    && mkdir /var/run/sshd && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ssh/ssh_host_*
RUN curl --create-dirs -fsSLo /usr/share/jenkins/agent.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
    && chmod 755 /usr/share/jenkins \
    && chmod 644 /usr/share/jenkins/agent.jar \
    && ln -sf /usr/share/jenkins/agent.jar /usr/share/jenkins/slave.jar

# install docker
RUN mkdir -p /tmp/download && \
    curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.06.0-ce.tgz | tar -xz -C /tmp/download && \
    rm -rf /tmp/download/docker/dockerd && \
    mv /tmp/download/docker/docker* /usr/local/bin/ && \
    rm -rf /tmp/download && \
    groupadd -g 999 docker && \
    usermod -aG staff,docker jenkins

# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl && \
   chmod +x ./kubectl && \
   mv ./kubectl /usr/local/bin/kubectl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
