FROM debian:jessie

MAINTAINER Guillaume Goussard <ggoussard@fandango.com>

WORKDIR /opt
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:/opt/bento4/bin"
ENV BENTO4_VERSION="1-5-0-613"
ENV BENTO4_CHECKSUM="4d4cd17ef6729fee152f6c391da04a6358cb918d"

RUN groupadd -r bento4 && \
    useradd -r -g bento4 bento4

RUN apt-get update && \
    apt-get install -yq --no-install-recommends curl unzip && \
    curl -O -s http://zebulon.bok.net/Bento4/binaries/Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip && \
    sha1sum -b Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip | grep -o "^$BENTO4_CHECKSUM " && \
    unzip Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip && \
    ln -s /opt/Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux /opt/bento4 && \
    chown -R bento4:bento4 /opt/Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux && \
    apt-get -yq purge unzip && \
    apt-get -yq autoclean && \
    rm -rf /var/lib/apt/lists/*

COPY bento4.sh /opt/bento4/bento4.sh

USER bento4

ENTRYPOINT ["/opt/bento4/bento4.sh"]
