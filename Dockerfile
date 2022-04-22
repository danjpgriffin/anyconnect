FROM ubuntu:jammy AS builder
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -y \
    build-essential

WORKDIR /
RUN echo 'int main() { pause(); }' > nop.c; make nop

FROM ubuntu:jammy

ENV TERM linux

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -y \
    wget \
    libxml2 \
    openssl \
    iproute2 \
    kmod \
    iptables \
    ca-certificates \
    file \
    gettext-base \
    libglib2.0-0 \
    dnsmasq

RUN mkdir /root/Install
WORKDIR /root/Install
COPY packages/anyconnect.tar.gz .
COPY packages/cortex.deb .

RUN tar xzf anyconnect.tar.gz && \
    mv anyconnect-* anyconnect && \
    bash -c "mkdir -p /usr/share/icons/hicolor/{48x48,64x64,96x96,128x128,256x256}/apps /usr/share/desktop-directories /usr/share/applications/" 

WORKDIR /root/Install/anyconnect/vpn
RUN yes | ./vpn_install.sh 2 > /dev/null

RUN ln -sf /etc/ssl/certs/ca-certificates.crt /opt/.cisco/certificates/ca/ca-certificates.pem

WORKDIR /root/Install/anyconnect/posture
RUN ./posture_install.sh --no-license > /dev/null

WORKDIR /root

COPY docker/entrypoint.sh /entrypoint.sh
COPY docker/fix-firewall.sh /fix-firewall.sh
COPY docker/systemctl /sbin/systemctl
COPY docker/start-traps.sh /start-traps.sh

RUN chmod +x /entrypoint.sh && \
    chmod +x /fix-firewall.sh && \
    chmod +x /sbin/systemctl && \
    chmod +x /fix-firewall.sh

RUN apt-get install /root/Install/cortex.deb

ENTRYPOINT /entrypoint.sh
