#!/bin/sh 
PASSWORD_FILE="/mosquitto/config/passwordfile"

if [ ! -f "$PASSWORD_FILE" ]; then
  PASSWORD1=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
  PASSWORD2=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

  mosquitto_passwd -c -b "$PASSWORD_FILE" "router4me_server" "$PASSWORD1"
  mosquitto_passwd -b "$PASSWORD_FILE" "router4me_client" "$PASSWORD2"

  echo "router4me_server:$PASSWORD1"
  echo "router4me_client:$PASSWORD2"
fi

/docker-entrypoint.sh mosquitto