# kubernetes-canary-101

We have a Python app, Dockerfile for the app and the Kubernetes manifest. 

Let's test Canary. Assuming we have the kubectl configured and Istio installed in the kubernetes cluster.

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
Access the service locally on port 8000:
```
$ kubectl port-forward svc/app 8000:80
$ for i in {1..10}; do \
    curl -k localhost:8000 \
  done
```

### Istio provides the control needed to deploy canary services. The idea is to introduce a new version of a service by first testing it using a small percentage of user traffic, and then if all goes well, increase, possibly gradually in increments, the percentage while simultaneously phasing out the old version. If anything goes wrong along the way, we abort and rollback to the previous version. For now, we're randomly routing a small percentage of traffic to the new version. But, we can also route the traffic based on the region, user or request properties.

Now, change the app response, build the Docker image and push it to the Docker repo again.
Deploy the canary version.

```
$ kubectl apply -f app-canary.yaml
```
Deploy the Istio VirtualService and Service destination rule.

```
$ kubectl apply -f istio-virtual-service-dest-rule.yaml
```
This will 80% of the traffic to the version1 of the app and the remaining 20% to the version 2.

Now, let's access the service:
```
$ kubectl port-forward svc/app 8000:80
$ for i in {1..10}; do \
    curl -k localhost:8000 \
  done
```

We should receive 20% of the response with the new message, and the remaining with the old one.


