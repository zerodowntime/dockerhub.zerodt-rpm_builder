FROM centos:7

LABEL maintainer="Krzysztof Kotewa <krzysztof.kotewa@zerodowntime.pl>"
ARG SPEC_FILE_NAME

RUN yum clean all; \
    yum -y install \
      sudo \
      rpm-build \
      make cmake automake autoconf \
      gcc gcc-c++ \
      git \
      pkgconfig \
      yum-utils \
      rpmdevtools ; \
    yum clean all; \
    rm -rf /var/cache/yum

RUN useradd -s '/bin/bash' -G systemd-journal -m rpm
RUN echo -e "rpm ALL=(ALL)  NOPASSWD:ALL" > /etc/sudoers.d/admins

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

USER rpm
RUN rpmdev-setuptree

CMD ["/entrypoint.sh"]
