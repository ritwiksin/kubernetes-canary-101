# CI-CD-example

I have created a Python app and the Dockerfile for the app.

creating Docker image

$ docker build -t ritwik3aug/ci-cd-example .

$ docker login

$ docker push ritwik3aug/ci-cd-example:latest

Start the minikube

$ minikube start

deploy the application

$ kubectl apply -f app.yaml

---

Let's deploy the Jenkins Helm chart to our cluster. 

Let's start by creating a namespace and persistant volume for Jenkins.

$ kubectl create namespace jenkins

$ kubectl apply -f jenkins-vol.yaml

We use the jenkins-values.yaml as template to provide our own values. We will claim our volume, mount the Docker socket and pre-populate the plugins.

$ helm repo update

$ helm install --name jenkins -f jenkins-values.yaml charts/stable/jenkins --namespace jenkins-project

Let's get the Jenkins password:

$ printf $(kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
