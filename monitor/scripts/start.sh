#!/bin/bash
cd .. 

mkdir ./grafana/storage

chown 472:472 ./grafana/storage

docker compose up -d
