#!/bin/bash

TAG=$1
IMAGE=ledharaujo/app-back:$TAG

docker build -t app-back:$TAG .
docker tag app-back:$TAG $IMAGE
docker push $IMAGE

ssh root@<<IP>> << EOF
  echo "Baixando nova imagem"
  docker pull $IMAGE

  echo "Trocando TAG da imagem no YAML"
  cd ~/app-back
  sed -i "s|image: .*/.*:.*|image: $IMAGE|" app-back-stack.yml

  echo "Mostrando conteúdo do YAML"
  cat app-back-stack.yml
  docker stack deploy -c app-back-stack.yml app_back
EOF
