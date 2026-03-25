#!/bin/bash

KEYS_FILE="$HOME/.config/bluemium/oauth2.conf"

case "$1" in
  set)
    mkdir -p "$HOME/.config/bluemium"
    echo "OAuth2 client ID:"
    read -r CLIENT_ID
    echo "OAuth2 client secret:"
    read -r CLIENT_SECRET
    cat > "$KEYS_FILE" << EOF
OAUTH2_ENABLED=true
OAUTH2_CLIENT_ID=$CLIENT_ID
OAUTH2_CLIENT_SECRET=$CLIENT_SECRET
EOF
    echo "keys have been saved! chromium will start with --login-manager so you can add and log into your google accounts"
    ;;
  remove)
    rm -f "$KEYS_FILE"
    echo "keys have been removed! chromium wont start with --login-manager anymore"
    ;;
  enable)
    if [ ! -f "$KEYS_FILE" ]; then
      echo "no keys set, run set-oauth-keys set first"
      exit 1
    fi
    sed -i 's/OAUTH2_ENABLED=false/OAUTH2_ENABLED=true/' "$KEYS_FILE"
    echo "OAuth2 enabled"
    ;;
  disable)
    if [ ! -f "$KEYS_FILE" ]; then
      echo "no keys set, nothing to disable"
      exit 1
    fi
    sed -i 's/OAUTH2_ENABLED=true/OAUTH2_ENABLED=false/' "$KEYS_FILE"
    echo "OAuth2 disabled, chromium will start without --login-manager"
    ;;
  status)
    if [ -f "$KEYS_FILE" ]; then
      echo "OAuth2 keys are set"
    else
      echo "no OAuth2 keys set"
    fi
    ;;
  *)
    echo "usage: set-oauth-keys [set|remove|enable|disable|status]"
    ;;
esac