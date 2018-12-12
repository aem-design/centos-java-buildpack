FROM       centos:latest

MAINTAINER devops <devops@aem.design>

LABEL   os.version="centos" \
        container.description="centos with java build pack"

ARG JAVA_VERSION_TIMESTAMP="2133151"
ARG JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-$JAVA_VERSION_TIMESTAMP.html"
ARG CHROME_DRIVER_VERSION="2.38"
ARG CHROME_DRIVER_FILE="chromedriver_linux64.zip"
ARG CHROME_DRIVER_URL="https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/${CHROME_DRIVER_FILE}"
ARG CHROME_FILE="google-chrome-stable_current_x86_64.rpm"
ARG CHROME_URL="https://dl.google.com/linux/direct/${CHROME_FILE}"
ARG NODE_VERSION="10.2.1"
ARG NVM_VERSION="v0.33.11"
ARG NVM_URL="https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh"
ARG MAVEN_VERSION="3.6.0"
ARG MAVEN_FILE="apache-maven-${MAVEN_VERSION}-bin.zip"
ARG MAVEN_URL="http://mirrors.sonic.net/apache/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_FILE}"

ENV HOME="/build"

RUN mkdir -p $HOME

WORKDIR $HOME

RUN \
    echo "==> Make dirs..." && \
    mkdir -p /apps/ && \
    echo "==> Install packages..." && \
    yum update -y && yum install -y epel-release && yum install -y curl tar zip unzip ruby groovy ivy junit rsync python-setuptools autoconf gcc-c++ make gcc python-devel openssl-devel openssh-server vim git git-lfs wget bzip2 ca-certificates chrpath fontconfig freetype libfreetype.so.6 libfontconfig.so.1 libstdc++.so.6 ImageMagick ImageMagick-devel libcurl-devel libffi libffi-devel libtool-ltdl libtool-ltdl-devel lib16-devel libpng-devel pngquant && \
    echo "==> Install Java..." && \
    AUTO_JDKURLINFO=$(curl -Ls ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-8u.*\-linux\-x64\.rpm ) && \
    AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(.*\)","MD5":.*/\1/g') && \
    AUTO_JDKMD5=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"MD5":"\(.*\)","SHA256":.*/\1/g' )  && \
    AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
    curl -L -O --header "Cookie: oraclelicense=accept-securebackup-cookie" $AUTO_JDKURL && \
    echo "${AUTO_JDKMD5}  ${AUTO_JDKFILE}" >> MD5SUM && \
    md5sum -c MD5SUM && \
    rpm -Uvh $AUTO_JDKFILE && \
    echo "==> Install node..." && \
    curl -sL https://rpm.nodesource.com/setup_8.x | bash - && \
    yum install -y nodejs && \
    echo "==> Install nvm..." && \
    export NVM_DIR=".nvm" && mkdir -p ${NVM_DIR} && touch .bashrc && \
    curl -o- ${NVM_URL} | bash && source $HOME/.bashrc && \
    nvm install $NODE_VERSION && npm install -g npm yarn && \
    echo "==> Install chrome..." && \
    wget ${CHROME_DRIVER_URL} && unzip ${CHROME_DRIVER_FILE} && mv chromedriver /usr/bin && rm -f ${CHROME_DRIVER_FILE} && \
    wget ${CHROME_URL} && yum install -y Xvfb ${CHROME_FILE} && rm -f ${CHROME_FILE} && \
    echo "==> Install maven..." && \
    wget ${MAVEN_URL} && unzip ${MAVEN_FILE} && mv apache-maven-${MAVEN_VERSION} /apps/maven && rm -f ${MAVEN_FILE} && \
    echo "export PATH=/apps/maven/bin:${PATH}">/etc/profile.d/maven.sh && \
    echo "export PATH=/apps/maven/bin:${PATH}">>$HOME/.bashrc && \
    echo "export PATH=/apps/maven/bin:${PATH}">>/etc/profile.d/sh.local

CMD ["/bin/bash"]