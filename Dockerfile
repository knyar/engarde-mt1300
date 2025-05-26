FROM debian:12-slim
ENV OPENWRT_SDK="openwrt-sdk-22.03.4-ramips-mt7621_gcc-11.2.0_musl.Linux-x86_64"

RUN apt-get update && \
    apt-get install -y git screen rsync wget build-essential libncurses-dev \
    gawk unzip bzip2 wget python3 python3-distutils-extra file \
    nodejs npm

RUN mkdir /openwrt-sdk && \
    cd /openwrt-sdk && \    
    wget https://downloads.openwrt.org/releases/22.03.4/targets/ramips/mt7621/${OPENWRT_SDK}.tar.xz && \
    tar -xvf ${OPENWRT_SDK}.tar.xz && \
    rm ${OPENWRT_SDK}.tar.xz

COPY . /app/
CMD cd /app && \
  ./build.sh /openwrt-sdk/${OPENWRT_SDK} && \
  sh -c 'cp /openwrt-sdk/${OPENWRT_SDK}/bin/packages/mipsel_24kc/base/* /dist/'
