Week 4 Lab Report - Microservices and Cloud-Native Design

Name: Karim Mohamed Hamed Gad
Group: SE2

What I did

I built a tiny two-service app with Docker Compose:

- `product-service` gives product info.
- `order-service` asks `product-service` for that info and then returns an order.

I got both containers running in `week4-lab`.

What happened

Commands I used:

```bash
cd week4-lab
sudo docker compose up -d --build
docker compose ps
```

Both services became healthy:

- `product-service`: healthy
- `order-service`: healthy

Then I tested the API:

```bash
curl -s http://127.0.0.1:5001/health
curl -s -X POST http://127.0.0.1:5002/orders \
  -H "Content-Type: application/json" \
  -d '{"product_id": 2, "quantity": 3}'
```

The order endpoint returned:

```json
{"message":"Order created","product":"Phone","quantity":3,"total_price":1950}
```

Evidence:

- `evidence/lab4/lab4_run.txt`

Failure test

I stopped `product-service` and tried the same request again. It returned:

```json
{"error":"product-service unavailable"}
```

Then I restarted `product-service` and the order API worked again.

What I learned

This lab shows why microservices are useful: each service does one thing. But it also shows why they can be annoying, because one service depends on another.

If `product-service` is down, `order-service` breaks too. So in real systems you need retries, timeouts, or some fallback logic.

Problems I hit

This wasn’t super hard, but it was a little annoying getting the JSON formatting right for curl and making sure Docker Compose ran with sudo. I also got a buildx warning from Docker Compose, but it didn’t stop the app from running.