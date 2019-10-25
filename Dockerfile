FROM       aemdesign/centos-java-buildpack

MAINTAINER devops <devops@aem.design>

LABEL   os="centos" \
        container.description="centos with java build pack and maven dependencies" \
        version="aem" \
        imagename="centos-java-buildpack" \
        test.command="bash -c 'mvn --version'" \
        test.command.verify="Apache Maven 3.6.1"

RUN \
    echo "==> Download Showcase Maven Dependecies..." && \
    wget https://github.com/aem-design/aemdesign-docker/releases/latest/download/package.zip -O aemdesign-aem-support-master.zip && \
    unzip aemdesign-aem-support-master.zip  && \
    cd aemdesign-aem-support-master && \
    mvn dependency:resolve -Dmaven.repo.local=/build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-support-master && \
    echo "==> Download Core Maven Dependecies..." && \
    wget https://github.com/aem-design/aemdesign-aem-core/releases/latest/download/package.zip -O aemdesign-aem-core-master.zip && \
    unzip aemdesign-aem-core-master.zip && \
    cd aemdesign-aem-core-master && \
    mvn dependency:resolve -Dmaven.repo.local=/build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-core-master


