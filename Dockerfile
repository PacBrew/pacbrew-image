# syntax=docker/dockerfile:1

FROM ubuntu:24.04
RUN apt update
RUN apt install -y git build-essential automake autoconf libtool libarchive-tools nasm pacman-package-manager makepkg
RUN echo "[pacbrew]" >> /etc/pacman.conf
RUN echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf
RUN echo "Server = http://pacbrew.mydedibox.fr/packages/" >> /etc/pacman.conf
RUN pacman -Sy
RUN pacman -S --noconfirm ps4-openorbis ps4-openorbis-portlibs dc-toolchain dc-portlibs

