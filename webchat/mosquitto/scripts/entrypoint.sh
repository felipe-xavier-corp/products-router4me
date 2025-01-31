#!/bin/sh 
PASSWORD_FILE="/mosquitto/config/passwordfile"

if [ ! -f "$PASSWORD_FILE" ]; then
  USER="router4me"
  PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

  echo "$USER:$PASSWORD" > "$PASSWORD_FILE"
fi

/docker-entrypoint.sh mosquitto