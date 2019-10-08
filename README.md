# CI-CD-example

We have a Python app, Dockerfile for the app and the Kubernetes manifest. 
This app returns Hello. 

Let's test Canary for this app!

creating Docker image
```
$ docker build -t kubernetes-canary-101 .
```
Start the minikube
```
$ minikube start
```
deploy the application
```
$ kubectl apply -f app.yaml
```
Access the service:
```
$ kubectl port-forward svc/app 8000:80
```


Clone the repo, make changes in the app response, build the Docker image and push it to the Docker repo again.

Run the script the script to build an new image, push it to Docker repo and deploy canary version.
```
$ chmod +x deploy.sh

$ ./deploy.sh
```
Access the service:
```
$ kubectl port-forward svc/app 8000:80
```
---

Let's deploy the Jenkins Helm chart to our cluster. 

Let's start by creating a persistant volume for Jenkins.

$ kubectl apply -f jenkins-vol.yaml

We use the jenkins-values.yaml as template to provide our own values. We will claim our volume, mount the Docker socket and pre-populate the plugins.

$ helm init

$ helm install --name jenkins -f jenkins-values.yaml stable/jenkins

Let's get the Jenkins password:

$ printf $(kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

$ kubectl port-forward svc/jenkins 8000:8080
