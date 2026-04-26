import concurrent.futures
import statistics
import time

import matplotlib.pyplot as plt
import requests

URL = "http://localhost:5000/"
REQUESTS = 100
CONCURRENCY = 10


def call_service(_):
    start = time.perf_counter()
    response = requests.get(URL, timeout=10)
    elapsed = time.perf_counter() - start
    response.raise_for_status()
    return elapsed


def main():
    with concurrent.futures.ThreadPoolExecutor(max_workers=CONCURRENCY) as pool:
        latencies = list(pool.map(call_service, range(REQUESTS)))

    print(f"requests: {len(latencies)}")
    print(f"min: {min(latencies):.3f}s")
    print(f"mean: {statistics.mean(latencies):.3f}s")
    print(f"median: {statistics.median(latencies):.3f}s")
    print(f"max: {max(latencies):.3f}s")

    plt.hist(latencies, bins=15, edgecolor="black")
    plt.title("Lab 1 Flask Response Time Histogram")
    plt.xlabel("Response time (seconds)")
    plt.ylabel("Request count")
    plt.tight_layout()
    plt.savefig("latency_histogram.png", dpi=160)
    print("saved: latency_histogram.png")


if __name__ == "__main__":
    main()
