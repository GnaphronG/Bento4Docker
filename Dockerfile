FROM debian:jessie

MAINTAINER Guillaume Goussard <guillaume.goussard@gmail.com>

WORKDIR /mnt
ENV PATH="$PATH:/opt/bento4/bin" \
    BENTO4_VERSION="1-5-0-616" \
    BENTO4_CHECKSUM="c3e896a943927328085114afec6ce4dc1348f2c5"

RUN groupadd -r bento4 && \
    useradd -r -g bento4 bento4

RUN apt-get -yq update && \
    apt-get install -yq --no-install-recommends curl python unzip && \
    curl -O -s http://zebulon.bok.net/Bento4/binaries/Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip && \
    sha1sum -b Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip | grep -o "^$BENTO4_CHECKSUM " && \
    unzip Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip -d /opt && \
    ln -s Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux /opt/bento4 && \
    chown -R bento4:bento4 /opt/bento4 && \
    apt-get -yq purge unzip && \
    apt-get -yq autoclean && \
    rm -rf /var/lib/apt/lists/* Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip

COPY bento4.sh /opt/bento4/bento4.sh

USER bento4

ENTRYPOINT ["/opt/bento4/bento4.sh"]
