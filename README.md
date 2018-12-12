## CentOS 7 with Java Build Pack

[![pipeline status](https://gitlab.com/aem.design/centos-java-buildpack/badges/master/pipeline.svg)](https://gitlab.com/aem.design/centos-java-buildpack/commits/master)

This is docker image based on CentOS 7 with Java 8 and Build Tools

### Included Packages

Following is the list of packages included

* npm                   - for building node sub projects
* nvm                   - for managing node version
* chrome                - for headless testing
* bash tools            - for scripting
* oracle-8-jdk          - Latest Oracle Java version 8 JDK
* maven                 - for build process

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