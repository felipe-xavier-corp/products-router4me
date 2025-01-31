#!/bin/sh 
PASSWORD_FILE="/mosquitto/config/passwordfile"

if [ ! -f "$PASSWORD_FILE" ]; then
  PASSWORD1=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
  PASSWORD2=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

  echo "router4me_server:$PASSWORD1" > "$PASSWORD_FILE"
  echo "router4me_client:$PASSWORD2" > "$PASSWORD_FILE"
fi

/docker-entrypoint.sh mosquitto