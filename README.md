## CentOS 8 with Java 11 Build Pack

[![build](https://github.com/aem-design/docker-centos-java-buildpack/actions/workflows/build.yml/badge.svg?branch=jdk11)](https://github.com/aem-design/docker-centos-java-buildpack/actions/workflows/build.yml)[![github license](https://img.shields.io/github/license/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack)
[![github license](https://img.shields.io/github/license/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack)
[![github issues](https://img.shields.io/github/issues/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack)
[![github last commit](https://img.shields.io/github/last-commit/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack)
[![github repo size](https://img.shields.io/github/repo-size/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack)
[![docker stars](https://img.shields.io/docker/stars/aemdesign/centos-java-buildpack)](https://hub.docker.com/r/aemdesign/centos-java-buildpack)
[![docker pulls](https://img.shields.io/docker/pulls/aemdesign/centos-java-buildpack)](https://hub.docker.com/r/aemdesign/centos-java-buildpack)
[![github release](https://img.shields.io/github/release/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack)

Docker image based on CentOS 8 with Java 11 and build tools.

### Included Packages

Following is the list of packages included

| Package       | Version      | Notes                                                          |
| ------------- | ------------ | -------------------------------------------------------------- |
| nvm           | v0.37.2      | node version manager - for building node sub projects          |
| node          | 12.19.0      | node - for managing node version                               |
| chrome driver | 88.0.4324.96 | for headless testing                                           |
| mvn           | 3.6.1        | maven - for build process                                      |
| java          | 11           | aemdesign/oracle-jdk:jdk11 - Latest Oracle Java version 11 JDK |
| docker        |              | for running docker commands on docker hosts                    |

### Manual JDK Download Test

```bash
export JAVA_VERSION_TIMESTAMP="2133151" && \
export JAVA_DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html" && \
    export AUTO_JDKURLINFO=$(curl -Ls ${JAVA_DOWNLOAD_URL} | grep -m1 jdk\-8u.*\-linux\-x64\.rpm ) && \
    echo AUTO_JDKURLINFO=$AUTO_JDKURLINFO && \
    AUTO_JDKURL=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"filepath":"\(.*\)","MD5":.*/\1/g') && \
    AUTO_JDKMD5=$(echo ${AUTO_JDKURLINFO} | sed -e 's/.*"MD5":"\(.*\)","SHA256":.*/\1/g' )  && \
    AUTO_JDKFILE=$(echo ${AUTO_JDKURL} | sed 's,^[^ ]*/,,' ) && \
    echo JAVA_VERSION_TIMESTAMP=$JAVA_VERSION_TIMESTAMP && \
    echo JAVA_DOWNLOAD_URL=$JAVA_DOWNLOAD_URL && \
    echo AUTO_JDKURL=$AUTO_JDKURL && \
    echo AUTO_JDKMD5=$AUTO_JDKMD5 && \
    echo AUTO_JDKFILE=$AUTO_JDKFILE
```

### Run dev container in a path

Use these commands to run container in cyour current path.

#### JDK 8

```bash
docker run --rm -it --name dev-jdk8 -v `pwd`:/build/source -v ${HOME}/.m2:/build/.m2 -v /var/run/docker.sock:/var/run/docker.sock -p 3001:3001 -e M2_HOME=/build/.m2 -w /build/source -e AEM_HOST=host.docker.internal --net=host aemdesign/centos-java-buildpack:jdk8 /bin/bash --login
```

#### JDK 11

```bash
docker run --rm -it --name dev-jdk11 -v `pwd`:/build/source -v ${HOME}/.m2:/build/.m2 -v /var/run/docker.sock:/var/run/docker.sock -e M2_HOME=/build/.m2 -w /build/source -e AEM_HOST=host.docker.internal --net=host aemdesign/centos-java-buildpack:jdk11 /bin/bash --login
```
