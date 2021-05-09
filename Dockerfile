FROM ubuntu:bionic

ARG SRSRAN_VERSION=21_04_pre

ARG LIBZMQ_VERSION=4.3.4

ARG CZMQ_VERSION=4.2.1

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
        build-essential \
        cmake \
        unzip \
        libfftw3-dev \
        libmbedtls-dev \
        libpcsclite-dev \
        libboost-program-options-dev \
        libconfig++-dev \
        libsctp-dev libczmq-dev \
        libpcsclite-dev \
        rapidjson-dev \
        colordiff \
        ninja-build \
        clang-format-8 \
        libtool-bin \
        autoconf && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /srsran

ADD https://github.com/srsran/srsRAN/archive/refs/tags/release_${SRSRAN_VERSION}.zip .

ADD https://github.com/zeromq/libzmq/archive/refs/tags/v${LIBZMQ_VERSION}.zip .

ADD https://github.com/zeromq/czmq/archive/refs/tags/v${CZMQ_VERSION}.zip .

RUN unzip release_${SRSRAN_VERSION}.zip && \
    unzip v${LIBZMQ_VERSION}.zip && \
    unzip v${CZMQ_VERSION}.zip && \
    rm *.zip

WORKDIR /srsran/libzmq-${LIBZMQ_VERSION}

RUN ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    ldconfig

WORKDIR /srsran/czmq-${CZMQ_VERSION}

RUN ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    ldconfig

WORKDIR /srsran/srsRAN-release_${SRSRAN_VERSION}/build

RUN cmake .. && \
    make && \
    ldconfig