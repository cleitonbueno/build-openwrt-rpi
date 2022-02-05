FROM ubuntu:20.04

# Does prevent interactive questions on apt operations
ENV DEBIAN_FRONTEND=noninteractive

# Install the required packages
RUN apt-get update && \
        apt-get install -y --no-install-recommends realpath || true && \
        apt-get install -y --no-install-recommends \
        apt-transport-https \
        bash \
        build-essential \
        ccache \
        ecj \
        fastjar \
        file \
        g++ \
        gawk \
        gettext \
        git \
        java-propose-classpath \
        libelf-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libssl-dev \
        locales \
        python \
        python2.7-dev \
        python3 \
        python3-distutils \
        python3-setuptools \
        python3-dev \
        unzip \
        wget \
        rsync \
        subversion \
        sudo \
        swig \
        time \
        xsltproc \
        zlib1g-dev \
        vim \
        \
        && \
        rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV USER_NAME user
ARG host_uid=1000
ARG host_gid=1000
RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME
RUN echo 'user:user' | chpasswd
RUN adduser $USER_NAME sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $USER_NAME

ENV BUILD_DIR /home/${USER_NAME}/openwrt
RUN mkdir -p $BUILD_DIR

WORKDIR $BUILD_DIR
