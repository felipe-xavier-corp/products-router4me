#!/bin/sh
ACLS_FILE="/mosquitto/config/mosquitto_acls"
PASSWORD_FILE="/mosquitto/config/passwd"

if [ ! -f "$ACLS_FILE" ]; then
  echo "user router4me_server" > $ACLS_FILE
  echo "topic readwrite" >> $ACLS_FILE

  echo "user router4me_client" >> $ACLS_FILE
  echo "topic read" >> $ACLS_FILE

  chmod 0700 $ACLS_FILE
fi

if [ ! -f "$PASSWORD_FILE" ]; then
  PASSWORD1=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
  PASSWORD2=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

  mosquitto_passwd -c -b "$PASSWORD_FILE" "router4me_server" "$PASSWORD1"
  mosquitto_passwd -b "$PASSWORD_FILE" "router4me_client" "$PASSWORD2"

  echo "*****PASSWORDS*******"
  echo "router4me_server:$PASSWORD1"
  echo "router4me_client:$PASSWORD2"
  echo "*****PASSWORDS*******"
fi

/docker-entrypoint.sh mosquitto -c "/mosquitto/config/mosquitto.conf"