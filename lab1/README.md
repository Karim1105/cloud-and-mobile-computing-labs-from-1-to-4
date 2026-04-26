Lab 1 - VM vs Container and Tail Latency

This lab is supposed to compare VMs and containers, but the environment I had did not have Multipass or Docker installed. I still wrote down the commands from the handout and included the resource check commands that would be used if the tools were available.

Commands from the handout:

```bash
multipass launch --name ubuntu-vm
docker run -it --name test-container ubuntu /bin/bash
```

Resource checks:

```bash
free -h
ps aux --sort=-%mem | head
df -h
docker stats
```

I did run the tail latency Flask app and the benchmark locally:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

Then in another terminal:

```bash
python benchmark.py
```

This should create `latency_histogram.png` and show the usual long tail in latency.

The checklist I used:

- VM startup or `multipass list` (if available)
- Container startup or `docker ps` (if available)
- Memory/process/disk output
- Flask benchmark terminal output
- `latency_histogram.png`
