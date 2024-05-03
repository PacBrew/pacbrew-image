# syntax=docker/dockerfile:1

FROM archlinux:base-devel

# create pacbrew user
RUN useradd -m "pacbrew"
RUN echo "pacbrew:pacbrew" | chpasswd
RUN echo "pacbrew ALL=(ALL) NOPASSWD: ALL" >> "/etc/sudoers.d/10-pacbrew"
RUN mkdir -p "/home/pacbrew/.ssh" && chown -R pacbrew:pacbrew "/home/pacbrew/.ssh"

# add pacbrew repo to pacman config
RUN echo "[pacbrew]" >> /etc/pacman.conf
RUN echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf
RUN echo "Server = http://pacbrew.mydedibox.fr/packages/" >> /etc/pacman.conf

# i want "tar.xz" packages for pacbrew
RUN sed -i "s/PKGEXT=.*/PKGEXT='.pkg.tar.xz'/g" /etc/makepkg.conf

# install needed packages
RUN pacman -Sy
RUN pacman -S --noconfirm --needed \
  sudo openssh openssl-1.1 wget curl git cmake nasm \
  ps4-openorbis ps4-openorbis-portlibs

# cleanup
RUN sudo pacman -Scc --noconfirm
RUN rm -rf /var/cache/pacman/pkg

