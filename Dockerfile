FROM       aemdesign/centos-java-buildpack

MAINTAINER devops <devops@aem.design>

LABEL   os="centos" \
        container.description="centos with java build pack and maven dependencies" \
        version="aem" \
        imagename="centos-java-buildpack" \
        test.command="bash -c 'mvn --version'" \
        test.command.verify="Apache Maven 3.6.1"

RUN \
    echo "==> Install Jq..." && \
    wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && chmod +x ./jq && cp jq /usr/bin && jq --version && \
    echo "==> Download Showcase Maven Dependecies..." && \
#    curl https://api.github.com/repos/aem-design/aemdesign-aem-support/releases/latest | jq -r .zipball_url | cat | wget -O aemdesign-aem-support-master.zip -qi - && \
    wget https://codeload.github.com/aem-design/aemdesign-aem-support/zip/master -O aemdesign-aem-support-master.zip && \
    unzip -qq aemdesign-aem-support-master.zip && \
    cd aemdesign-aem-support-master && ls -l && \
    mvn clean  dependency:resolve -P all-modules -pl "!aemdesign-aem-support-deploy" -Dmaven.repo.local=/build/.m2/repository && \
    ls -l /build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-support-master && \
    echo "==> Download Core Maven Dependecies..." && \
#    curl https://api.github.com/repos/aem-design/aemdesign-aem-core/releases/latest | jq -r .zipball_url | cat | wget -O aemdesign-aem-core-master.zip -qi - && \
    wget https://codeload.github.com/aem-design/aemdesign-aem-core/zip/master -O aemdesign-aem-core-master.zip && \
    unzip -qq aemdesign-aem-core-master.zip && \
    cd aemdesign-aem-core-master && \
    mvn package -Dmaven.repo.local=/build/.m2/repository && \
    ls -l /build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-core-master aemdesign-aem-core-master


