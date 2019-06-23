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

Access the service:

$ kubectl port-forward svc/app 8000:80



Clone the repo, make changes in the app and push.


Run the script the script to build an new image, push it to Docker repo and deploy canary version.

$ chmod +x pipeline.sh

$ ./pipeline.sh

Access the service:

$ kubectl port-forward svc/app 8000:80

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
