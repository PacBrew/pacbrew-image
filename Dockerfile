# syntax=docker/dockerfile:1

FROM archlinux:base-devel

# create/add pacbrew user
RUN useradd -m "pacbrew" && \
  echo "pacbrew:pacbrew" | chpasswd && \
  echo "pacbrew ALL=(ALL) NOPASSWD: ALL" >> "/etc/sudoers.d/10-pacbrew" && \
  mkdir -p "/home/pacbrew/.ssh" && \
  chown -R pacbrew:pacbrew "/home/pacbrew/.ssh"

# add pacbrew repo to pacman config
RUN echo "[pacbrew]" >> /etc/pacman.conf && \
  echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf && \
  echo "Server = https://pacman.mydedibox.fr/pacbrew/packages/" >> /etc/pacman.conf && \
  sed -i "s/PKGEXT=.*/PKGEXT='.pkg.tar.xz'/g" /etc/makepkg.conf # we want "tar.xz" packages for pacbrew

# install needed packages and cleanup
RUN pacman -Sy && \
  pacman -S --noconfirm --needed \
    sudo openssh wget curl git cmake nasm python dotnet-sdk \
    ps4-openorbis ps4-openorbis-portlibs && \
  sudo pacman -Scc --noconfirm && \
  rm -rf /var/cache/pacman/pkg

