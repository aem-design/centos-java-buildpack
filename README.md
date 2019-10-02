## CentOS 7 with Java Build Pack

[![build_status](https://travis-ci.org/aem-design/centos-java-buildpack.svg?branch=master)](https://travis-ci.org/aem-design/centos-java-buildpack) 
[![github license](https://img.shields.io/github/license/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack) 
[![github issues](https://img.shields.io/github/issues/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack) 
[![github last commit](https://img.shields.io/github/last-commit/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack) 
[![github repo size](https://img.shields.io/github/repo-size/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack) 
[![docker stars](https://img.shields.io/docker/stars/aemdesign/centos-java-buildpack)](https://hub.docker.com/r/aemdesign/centos-java-buildpack) 
[![docker pulls](https://img.shields.io/docker/pulls/aemdesign/centos-java-buildpack)](https://hub.docker.com/r/aemdesign/centos-java-buildpack) 
[![github release](https://img.shields.io/github/release/aem-design/centos-java-buildpack)](https://github.com/aem-design/centos-java-buildpack)

This is docker image based on CentOS 7 with Java 8 and Build Tools

### Included Packages

Following is the list of packages included

| Package | Version | Notes  |
| ---  | ---    | --- |
| nvm | v0.34.0 | node version manager - for building node sub projects|
| node | 10.2.1 | node - for managing node version|
| chrome driver | 77.0.3865.40  | for headless testing |
| mvn | 3.6.1 | maven - for build process |
| java | 1.8 | aemdesign/oracle-jdk:jdk8 - Latest Oracle Java version 8 JDK |

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
