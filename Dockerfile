# work from latest LTS ubuntu release
FROM ubuntu:18.04

# set the environment variables
ENV manta_version 1.5.0

# run update and install necessary tools
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libnss-sss \
    curl \
    vim \
    less \
    wget \
    bzip2 \
    python \
    zlib1g-dev \
    cmake \
    libboost-all-dev

# download manta
WORKDIR /usr/local/bin
RUN wget https://github.com/Illumina/manta/releases/download/v${manta_version}/manta-${manta_version}.release_src.tar.bz2
RUN tar -xvjf manta-${manta_version}.release_src.tar.bz2
RUN mkdir -p /usr/local/bin/manta-${manta_version}.release_src/build
WORKDIR /usr/local/bin/manta-${manta_version}.release_src/build
RUN ../configure --prefix=/usr/local/bin
RUN make install

# set default command
WORKDIR /usr/local/bin
CMD ["manta --help"]
