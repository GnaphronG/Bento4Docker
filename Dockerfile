ARG DEBIAN_VERSION=bullseye

FROM debian:${DEBIAN_VERSION}

WORKDIR /mnt
ENV PATH="$PATH:/opt/bento4/bin" 
ENV BENTO4_VERSION="1-6-0-639"

RUN groupadd -r bento4 && \
    useradd -r -g bento4 bento4

RUN apt-get -yq update && \
    apt-get install -yq --no-install-recommends ca-certificates curl python unzip && \
    :

RUN curl -lO https://www.bok.net/Bento4/binaries/Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip && \
    unzip Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip -d /opt && \
    ln -s Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux /opt/bento4 && \
    chown -R bento4:bento4 /opt/bento4 && \
    apt-get -yq purge unzip && \
    apt-get -yq autoclean && \
    rm -rf /var/lib/apt/lists/* Bento4-SDK-${BENTO4_VERSION}.x86_64-unknown-linux.zip

COPY bento4.sh /opt/bento4/bento4.sh

USER bento4

ENTRYPOINT ["/opt/bento4/bento4.sh"]
