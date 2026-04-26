Lab 3 Report - Containerization and Cluster Orchestration

Name: Karim Mohamed Hamed Gad
Group: SE2

Part A - Docker and Kubernetes Setup

I built the lab images from `lab3/Dockerfile.basic` and `lab3/Dockerfile.multistage`, then created a local kind cluster and loaded the `lab3-multi` image into it.

Commands I used:

```bash
cd lab3
sudo docker build -f Dockerfile.basic -t lab3-basic .
sudo docker build -f Dockerfile.multistage -t lab3-multi .
sudo kind create cluster --name lab3-cluster
sudo kind load docker-image lab3-multi --name lab3-cluster
sudo kubectl label nodes --all node-role=general
```

The multi-stage build was the better one because it only has the runtime files the app needs.

Part B - Deployment and Service

I applied the Kubernetes manifests and checked the pods:

```bash
sudo kubectl apply -f deployment.yaml
sudo kubectl apply -f service.yaml
sudo kubectl get deployments
sudo kubectl get pods -o wide
```

It created three `lab3-web` pods and two `lab3-web-probe` pods. I also tested the service with curl:

- `GET /` returned `Hello from Lab 3`
- `GET /health` returned `ok`

Evidence I collected:

- `evidence/lab3/lab3_partCDE_final.txt`

Part C - Self-Healing and Probes

I deleted one of the web pods and Kubernetes recreated it, so the Deployment kept the desired replica count.

The probe pods had a small issue at first: they showed `ErrImageNeverPull` because the image wasn’t loaded into the kind node yet. After loading `lab3-multi`, they started fine.

I also killed one probe pod’s main process to make sure Kubernetes restarted it and kept it ready.

Evidence I collected:

- `evidence/lab3/lab3_probe_restart.txt`

Reflection

This lab showed me how Kubernetes keeps the system in the desired state. I tell it I want three replicas, and then it actually makes that happen.

I also saw why `imagePullPolicy: Never` is only good for local work: if the image isn’t in the node, the pod fails to start. That was a real issue until I loaded the image into kind.

Liveness probes restart broken containers, while readiness probes make sure only healthy pods get traffic.

Problems I Hit

This one was the trickiest lab because there are a lot of moving parts. Docker, kind, image loading, and the Kubernetes manifests all have to line up. The main pain point was the `ErrImageNeverPull` error, but once the image was loaded into kind, everything worked.
