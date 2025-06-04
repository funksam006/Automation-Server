FROM debian:bullseye 

RUN apt update && \
    apt install -y iproute2 iptables wireguard-tools curl mysql-client unzip

RUN curl -LO https://github.com/cloudflare/boringtun/releases/download/v0.3.0/boringtun-linux-amd64 && \
    chmod +x boringtun-linux-amd64 && mv boringtun-linux-amd64 /usr/local/bin/boringtun

ENV WG_QUICK_USERSPACE_IMPLEMENTATION=boringtun
ENV WG_SUDO=1

COPY wg0.conf /etc/wireguard/wg0.conf
CMD ["sh", "-c", "boringtun wg0 && wg-quick up wg0 && tail -f /dev/null"]
