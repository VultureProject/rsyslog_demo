FROM    ubuntu:22.04 AS build
ENV     DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    autoconf \
    autoconf-archive \
    automake \
    autotools-dev \
    bison \
    clang \
    clang-tools \
    curl \
    cmake \
    default-jdk \
    default-jre \
    faketime libdbd-mysql \
    flex \
    gcc \
    gcc-12 \
    gdb \
    git \
    libaprutil1-dev \
    libbson-dev \
    libcurl4-gnutls-dev \
    libdbi-dev \
    libgcrypt20-dev \
    libglib2.0-dev \
    libgnutls28-dev \
    libgrok1 libgrok-dev \
    libhiredis-dev \
    libevent-dev \
    libkrb5-dev \
    liblz4-dev \
    libmaxminddb-dev libmongoc-dev \
    libmongoc-dev \
    libmysqlclient-dev \
    libnet1-dev \
    libpcap-dev \
    librabbitmq-dev \
    librdkafka-dev \
    libsnmp-dev \
    libssl-dev libsasl2-dev \
    libsystemd-dev \
    libtirpc-dev \
    libtokyocabinet-dev \
    libtool \
    libtool-bin \
    libzstd-dev \
    logrotate \
    lsof \
    make \
    mysql-server \
    net-tools \
    pkg-config \
    postgresql-client libpq-dev \
    python3-docutils  \
    python3-pip \
    python3-pysnmp4 \
    software-properties-common \
    sudo \
    uuid-dev \
    valgrind \
    vim \
    wget \
    zlib1g-dev \
    zstd

RUN echo 'deb http://download.opensuse.org/repositories/home:/rgerhards/xUbuntu_22.04/ /' > /etc/apt/sources.list.d/home:rgerhards.list && \
    wget -nv https://download.opensuse.org/repositories/home:rgerhards/xUbuntu_22.04/Release.key -O Release.key && \
    apt-key add - < Release.key && \
    apt-get update -y && \
    apt-get install -y  \
    libestr-dev \
    librelp-dev \
    liblogging-stdlog-dev \
    libfastjson-dev \
    liblognorm-dev

RUN mkdir /build && \
    mkdir /installed && \
    echo "/installed/usr/local/lib/" > /etc/ld.so.conf.d/custom.conf

RUN apt-get -y install cmake
RUN cd /build && \
    git clone https://github.com/stricaud/faup.git && \
    cd faup && \
    cd build && \
    cmake .. && make -j && \
    DESTDIR="/installed" make install && \
    cd .. && \
    cd ..

RUN git clone https://github.com/VultureProject/rsyslog.git --branch imhiredis_syntax /rsyslog &&\
    cd /rsyslog &&\
    ./autogen.sh --enable-debug --disable-generate-man-pages --enable-compile-warning=warning \
        --enable-omstdout \
        --enable-impcap \
        --enable-elasticsearch \
        --enable-ommongodb \
        --enable-gnutls \
        --enable-mmnormalize \
        --enable-mmjsonparse \
        --enable-imfile \
        --enable-relp \
        --enable-impstats \
        --enable-omuxsock \
        --enable-mmdblookup \
        --enable-ffaup \
        --enable-imkafka \
        --enable-omkafka \
        --enable-omhiredis \
        --enable-imhiredis \
        CFLAGS="-I/installed/usr/local/include/ -I/installed/usr/local/lib/" &&\
    DESTDIR="/installed" make install


FROM    ubuntu:22.04
ENV     DEBIAN_FRONTEND=noninteractive

COPY --from=build /installed /
COPY rsyslog.conf /etc/rsyslog.conf

RUN apt-get update && \
    apt-get upgrade && \
    apt-get install --no-install-recommends -y \
    libbson-1.0-0 \
    libcurl3-gnutls \
    libestr0 \
    libevent-2.1-7 \
    libevent-pthreads-2.1-7 \
    libfastjson4 \
    libgnutls30 \
    libhiredis0.14 \
    libkrb5-3 \
    liblognorm5 \
    liblz4-1 \
    libmaxminddb0 \
    libmongoc-1.0-0 \
    libmysqlclient21 \
    libpcap0.8 \
    libpq5 \
    librabbitmq4 \
    librdkafka1 \
    librelp0 \
    libsasl2-2 \
    libsnmp40 \
    libssl3 \
    libsystemd0 \
    libtirpc3 \
    libuuid1 \
    libzstd1 \
    zlib1g && \
    apt-get clean
