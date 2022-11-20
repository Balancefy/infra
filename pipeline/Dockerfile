FROM jenkins/jenkins:lts

USER root

RUN apt-get update -qq \
  && apt-get install -y \
  apt-transport-https \
  ca-certificates \ 
  gnupg2 \
  curl \
  software-properties-common 

RUN curl -fsSL https://get.docker.com -o get-docker.sh

RUN sh ./get-docker.sh

RUN usermod -aG docker jenkins