from flask import Flask
import random
import time

app = Flask(__name__)


@app.route("/")
def hello():
    delay = random.expovariate(1 / 0.1)
    time.sleep(delay)
    return f"Response after {delay:.2f} seconds\n"


@app.route("/health")
def health():
    return "ok\n"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
