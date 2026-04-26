#!/bin/bash
OUTPUT="/home/crankylama/Documents/cloud and mobile computing assigment/evidence/lab3/lab3_partCDE_final.txt"
rm -f "$OUTPUT"
exec >"$OUTPUT" 2>&1
set -o pipefail
export KUBECONFIG=/root/.kube/config

echo "--- CLUSTER INFO ---"
kubectl cluster-info || true

echo "--- DEPLOYMENTS ---"
kubectl get deployments || true

echo "--- PODS ---"
kubectl get pods -o wide || true

echo "--- SERVICE ACCESS ---"
if [ -f /tmp/lab3_pf6.pid ]; then
  kill "$(cat /tmp/lab3_pf6.pid)" 2>/dev/null || true
  rm -f /tmp/lab3_pf6.pid
fi
kubectl port-forward service/lab3-web-svc 8080:80 >/tmp/lab3_pf6.log 2>&1 &
PF_PID=$!
echo "PORTFORWARD PID $PF_PID"
echo $PF_PID >/tmp/lab3_pf6.pid
sleep 5

echo "curl /"
curl -v http://127.0.0.1:8080/ || true

echo "curl /health"
curl -v http://127.0.0.1:8080/health || true

echo "kill port-forward"
kill "$PF_PID" 2>/dev/null || true
sleep 2

echo "--- SELF-HEALING WITHOUT PROBES ---"
POD=$(kubectl get pods -l app=lab3-web -o jsonpath="{.items[0].metadata.name}")
echo "delete pod: $POD"
kubectl delete pod "$POD" || true
sleep 20
kubectl get pods -o wide || true

echo "--- PROBES DEPLOYMENT ---"
PROBE_POD=$(kubectl get pods -l app=lab3-web-probe -o jsonpath="{.items[0].metadata.name}")
echo "probe pod: $PROBE_POD"
kubectl describe pod "$PROBE_POD" | tail -n 30 || true

echo "kill probe container main process"
kubectl exec "$PROBE_POD" -- /bin/sh -c "kill 1" || true
sleep 20
kubectl get pods -o wide || true
kubectl describe pod "$PROBE_POD" | tail -n 30 || true

echo "--- LAB 3 KIND DEPLOYMENT COMPLETE ---"
