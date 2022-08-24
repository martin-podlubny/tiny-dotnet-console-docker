FROM ubuntu:focal as build

RUN apt update && \
    apt install -y --no-install-recommends \
        ca-certificates binutils file patch cpio python unzip rsync bc bzip2 ncurses-dev git make g++ wget && \
    apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /buildroot

# get buildroot itself
RUN wget -q -O- \
    https://buildroot.org/downloads/buildroot-2022.02.4.tar.gz | tar xz --strip 1

# copy the bare-minimum config (only has initd, musl, and libstdc++6)
COPY ./buildroot.config ./.config

# pickup the existing config && verbose build the rootfs.tar
RUN make oldconfig && make V=s

# extract rootfs for easier copying to scratch
RUN mkdir ./rootfs-extracted && \
    tar -xf ./output/images/rootfs.tar --directory ./rootfs-extracted

# just scratch and the custom linux rootfs
FROM scratch
COPY --from=build /buildroot/rootfs-extracted /