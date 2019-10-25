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
    git clone --depth 1 --branch master --single-branch https://github.com/aem-design/aemdesign-aem-support && \
    cd aemdesign-aem-support && \
    mvn clean package -Dmaven.repo.local=/build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-support && \
    echo "==> Download Core Maven Dependecies..." && \
    git clone --depth 1 --branch master --single-branch https://github.com/aem-design/aemdesign-aem-core && \
    cd aemdesign-aem-core && \
    mvn clean package -Dmaven.repo.local=/build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-core


