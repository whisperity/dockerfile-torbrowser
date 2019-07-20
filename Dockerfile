FROM ubuntu:latest

MAINTAINER Phocean <jc@phocean.net>

ENV DEBIAN_FRONTEND=noninteractive \
    VERSION=8.5.4 \
    LANGUAGE=en-US \
    HOME=/home/anon \
    GPG_KEY=0x4E2C6E8793298290

WORKDIR $HOME

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    libgtk-3-0 libxt6 libx11-xcb1 libdbus-glib-1-2 xz-utils curl libcurl4 ca-certificates gnupg dirmngr &&\
    rm -rf /var/lib/apt/lists/* &&\
    curl -SL -o tor.tar.xz https://www.torproject.org/dist/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_${LANGUAGE}.tar.xz &&\
    tar xvf tor.tar.xz &&\
    rm -rf "$GNUPGHOME" rm -f tor.tar.xz* &&\
    mkdir -p $HOME/Downloads &&\
    useradd -u 1000 anon &&\
    chown -R anon:anon $HOME

VOLUME $HOME/Downloads

USER anon

CMD $HOME/tor-browser_en-US/Browser/start-tor-browser
