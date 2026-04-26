Week 4 Lab - Microservices and Cloud-Native Design

This lab is a small microservices example with two services: product-service and order-service. The idea is to show how one service depends on another and what happens when the product service is down.

Run the app:

```bash
docker compose up --build -d
docker compose ps
```

Check product-service:

```bash
curl http://localhost:5001/health
curl http://localhost:5001/products/1
curl http://localhost:5001/products/99
```

Check order-service:

```bash
curl -X POST http://localhost:5002/orders \
  -H "Content-Type: application/json" \
  -d '{"product_id": 1, "quantity": 2}'
```

Then test the failure case by stopping product-service:

```bash
docker stop product-service
curl -X POST http://localhost:5002/orders \
  -H "Content-Type: application/json" \
  -d '{"product_id": 2, "quantity": 1}'
docker start product-service
docker compose ps
```

Expected failure response:

```json
{"error":"product-service unavailable"}
```

This proves the point: if the product service is down, the order service cannot finish the request.
