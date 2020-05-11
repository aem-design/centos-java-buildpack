FROM       aemdesign/centos-java-buildpack

MAINTAINER devops <devops@aem.design>

LABEL   os="centos" \
        container.description="centos with java build pack and maven dependencies" \
        version="aem" \
        imagename="centos-java-buildpack" \
        test.command="mvn --version" \
        test.command.verify="Apache Maven 3.6.1"

RUN \
    echo "==> Install Jq..." && \
    wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && chmod +x ./jq && cp jq /usr/bin && jq --version && \
    echo "==> Download Showcase Maven Dependecies..." && \
    wget https://codeload.github.com/aem-design/aemdesign-aem-support/zip/develop -O aemdesign-aem-support-develop.zip && \
    unzip -qq aemdesign-aem-support-develop.zip && \
    cd aemdesign-aem-support-develop && \
    git config --global user.email "devops@aem.design" && git config --global user.name "devops" && git init && git add . && git commit -m "test" && \
    mvn clean -DskipTests=true -P all-modules -pl "!aemdesign-aem-support-deploy" -Dmaven.repo.local=/build/.m2/repository && \
    ls -l /build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-support-develop && \
    echo "==> Download Core Maven Dependecies..." && \
    wget https://codeload.github.com/aem-design/aemdesign-aem-core/zip/develop -O aemdesign-aem-core-develop.zip && \
    unzip -qq aemdesign-aem-core-develop.zip && \
    cd aemdesign-aem-core-develop && \
    git config --global user.email "devops@aem.design" && git config --global user.name "devops" && git init && git add . && git commit -m "test" && \
    mvn clean -DskipTests=true -Dmaven.repo.local=/build/.m2/repository && \
    ls -l /build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-core-develop aemdesign-aem-core-develop


