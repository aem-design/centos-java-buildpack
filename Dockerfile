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
    wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && chmod +x ./jq && cp jq /usr/bin && \
    echo "==> Download Showcase Maven Dependecies..." && \
    curl https://api.github.com/repos/aem-design/aemdesign-aem-support/releases/latest | jq .zipball_url | cat | wget -O aemdesign-aem-support-master.zip -qi - && \
    unzip aemdesign-aem-support-master.zip  && \
    cd aemdesign-aem-support-master && \
    mvn dependency:resolve -Dmaven.repo.local=/build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-support-master && \
    echo "==> Download Core Maven Dependecies..." && \
    curl https://api.github.com/repos/aem-design/aemdesign-aem-core/releases/latest | jq .zipball_url | cat | wget -O aemdesign-aem-core-master.zip -qi - && \
    unzip aemdesign-aem-core-master.zip && \
    cd aemdesign-aem-core-master && \
    mvn dependency:resolve -Dmaven.repo.local=/build/.m2/repository && \
    cd .. && rm -rf aemdesign-aem-core-master


