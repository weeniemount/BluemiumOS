#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux unzip
# basically everything that ChromiumOS linux binaries needs
dnf5 install -y \
  	nss \
  	nspr \
	cups-libs \
	libX11 \
	libXcomposite \
	libXcursor \
	libXdamage \
	libXext \
	libXfixes \
	libXi \
	libXrandr \
	libXrender \
	libXScrnSaver \
	libXtst \
	libxcb \
	libxkbcommon \
	alsa-lib \
	mesa-libEGL \
	mesa-libGLES \
	mesa-libGL \
  	mesa-libEGL-devel \
	mesa-libGLES-devel \
	mesa-dri-drivers \
	mesa-vulkan-drivers \
	libglvnd \
	libglvnd-egl \
	libglvnd-gles \
	libglvnd-glx \
	libglvnd-opengl \
	xorg-x11-server-Xvfb

# get chromiumos and unpack it
rm -rf /usr/bluemium/cros/README.txt
curl -L \
  "https://download-chromium.appspot.com/dl/Linux_ChromiumOS_Full?type=snapshots" \
  -o /tmp/chromiumos.zip

unzip -q /tmp/chromiumos.zip "chrome-chromeos/*" -d /tmp
cp -r /tmp/chrome-chromeos/* /usr/bluemium/cros/

rm -f /tmp/chromiumos.zip


# according to chromium documentation, this is some stuff we need to do
sudo sh -c "echo 'KERNEL==\"event*\", NAME=\"input/%k\", MODE=\"660\", GROUP=\"plugdev\"' > /etc/udev/rules.d/90-input.rules"
sudo sh -c "echo 'KERNEL==\"card[0-9]*\", NAME=\"dri/%k\", GROUP=\"video\"' > /etc/udev/rules.d/90-dri.rules"
#sudo udevadm control --reload
#sudo udevadm trigger --action=add
#sudo usermod -a -G plugdev $USER
#sudo usermod -a -G video $USER
#sudo usermod -a -G audio $USER
#newgrp video
#newgrp plugdev
#newgrp audio

#pactl exit

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
