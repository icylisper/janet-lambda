FROM amazonlinux:latest

RUN yum -y update && yum -y install tar gzip wget
RUN yum -y install git gcc libcurl4-gnutls-dev curl-devel

COPY build.sh /build.sh

CMD ["/build.sh"]
