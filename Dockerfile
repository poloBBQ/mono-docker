ARG CENTOS_VERSION=7
ARG MONO_VERSION=5.18.1.0-1.2.nw.el${CENTOS_VERSION}

FROM centos:$CENTOS_VERSION
ARG CENTOS_VERSION
ARG MONO_VERSION

LABEL version=${MONO_VERSION}
LABEL description="CentOS-${CENTOS_VERSION} based mono base image"
LABEL maintainer="pablo@evicertia.com"
LABEL vendor="evicertia"

WORKDIR /

# Install base stuff..

ADD files/netway-mono.repo /etc/yum.repos.d/
RUN yum -y install openssl ca-certificates redhat-lsb-core epel-release yum-priorities
RUN echo ${MONO_VERSION} > /MONO_VERSION
RUN yum -y --enablerepo=netway-mono install \
    mono-core-${MONO_VERSION} \
    mono-web-${MONO_VERSION} \
    mono-data-${MONO_VERSION} \
    mono-data-sqlite-${MONO_VERSION} \
    mono-extras-${MONO_VERSION} \
    mono-wcf-${MONO_VERSION} \
    mono-winforms-${MONO_VERSION} \
    mono-winfx-${MONO_VERSION} \
    mono-locale-extras-${MONO_VERSION} \
    mono-devel-${MONO_VERSION} \
    mono-web-devel-${MONO_VERSION}
RUN yum --enablerepo=\* clean all

CMD ["/bin/bash"]
