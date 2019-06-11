#!/bin/bash

PORT=$((30000 + $RANDOM % 10000))

kubectl create ns jenkins
kubectl apply -f jenkins-pvc.yaml
kubectl apply -f jenkins-svc.yaml
kubectl apply -f jenkins-deploy.yaml

while ! kubectl get pods -n jenkins | grep jenkins | grep Running &> /dev/null; do
    echo Waiting until Jenkins is running...
    sleep 10
done

POD_NAME=`kubectl get pods -n jenkins | grep jenkins | awk '{print $1}'`
PORT_FORWARD="kubectl port-forward -n jenkins $POD_NAME $PORT:8080"
cat << EOF
____________________________________________________________________________

Please go to the following url and unlock Jenkins using your Admin Token

    Url:        http://localhost:$PORT/
    Pod Name:   $POD_NAME
____________________________________________________________________________

/!\ Warning! /!\
---          ---

Closing this shell will cut the connection with Jenkins.
Close it when you are going to end the lab.
If you want to reenable the connection, execute: 

$PORT_FORWARD

EOF

$PORT_FORWARD &> /dev/null
