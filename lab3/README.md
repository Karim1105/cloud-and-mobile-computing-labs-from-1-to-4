Lab 3 - Containerization and Cluster Orchestration

This lab is the one where I had to do container isolation, build images, and then run them in a local Kubernetes cluster. It was a bit annoying because kind and image loading can be flaky, but I got it working.

Part A: namespaces and cgroups

```bash
docker run --rm -it --name nsdemo ubuntu:22.04 bash
hostname
ps -ef
ip addr
mount | head
cat /proc/1/cgroup
```

Then from another terminal:

```bash
docker ps
docker inspect nsdemo --format "{{.State.Pid}}"
ps -fp <PID_FROM_PREVIOUS_COMMAND>
```

Resource limits and container behavior:

```bash
docker run --rm -it --cpus="0.5" --memory="256m" ubuntu:22.04 bash
apt-get update && apt-get install -y stress
stress --cpu 2 --vm 1 --vm-bytes 220M --timeout 30
docker stats
```

Part B: image builds

```bash
docker build -f Dockerfile.basic -t lab3-basic .
docker history lab3-basic
docker image ls
docker build -f Dockerfile.multistage -t lab3-multi .
docker history lab3-multi
docker image ls
```

Part C: Kubernetes deploy

```bash
kind create cluster --name lab3-cluster
kubectl cluster-info
kubectl get nodes -o wide
kind load docker-image lab3-basic --name lab3-cluster
kind load docker-image lab3-multi --name lab3-cluster
kubectl label nodes --all node-role=general
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get pods -o wide
kubectl get deployments
kubectl describe deployment lab3-web
kubectl port-forward service/lab3-web-svc 8080:80
curl http://localhost:8080/
curl http://localhost:8080/health
```

Part E: self-healing

```bash
kubectl get pods
kubectl delete pod <ONE_POD_NAME>
kubectl get pods -w
kubectl apply -f probe-deployment.yaml
kubectl get pods
kubectl describe pod <ONE_PROBE_POD_NAME>
kubectl exec -it <ONE_PROBE_POD_NAME> -- /bin/sh
ps -ef
kill 1
```

Cleanup:

```bash
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
kubectl delete -f probe-deployment.yaml
kind delete cluster --name lab3-cluster
```
