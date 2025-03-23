#!/bin/bash

docker swarm init --advertise-addr <SEU_IP>
docker network create --driver=overlay traefik-public
docker stack deploy -c traefik.yml traefik
docker stack deploy -c wallos-stack.yml wallos
