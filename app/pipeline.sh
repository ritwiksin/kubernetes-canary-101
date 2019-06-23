#!/bin/bash

echo "enter Github username:"
read username

echo -n "enter Github password"
read -s password

git clone https://$username:$password@github.com/ritwiksin/CI-CD-example.git

cd CI-CD-example

docker build -t ritwik3aug/ci-cd-example .

docker login

docker push ritwik3aug/ci-cd-example

kubectl apply -f app-canary.yaml
