#!/bin/bash


# sudo chvt 8; 
# we should run this command, but not right now as i need to make sure starting chromium actually works

EGL_PLATFORM=surfaceless /usr/bluemium/cros/chrome \
  --ozone-platform=drm \
  --enable-running-as-system-compositor \
  --login-profile=user \
  --user-data-dir=$HOME/.config/google-chrome-gbm \
  --use-gl=egl \
  --enable-wayland-server \
  --login-manager \
  --ash-constrain-pointer-to-root \
  --default-tile-width=512 \
  --default-tile-height=512 \
  --system-developer-mode \
  --crosh-command=/bin/bash