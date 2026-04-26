Lab 1 Report - Exploring Cloud Virtualization and Data Center Architecture

Name: Karim Mohamed Hamed Gad
Group: SE2

Part A - VM and Container Comparison

So, I couldn’t really do the VM vs container comparison in this environment because Multipass and Docker weren’t installed. I still grabbed the host-side stats that would be used if the missing tools were available.

Evidence I got:

- `evidence/lab1/free_h_host_screenshot.png`
- `evidence/lab1/top_processes_host_screenshot.png`
- `evidence/lab1/df_h_host_screenshot.png`

Part B - Cloud Infrastructure Exploration

I didn’t run the AWS instance stuff here because there was no AWS access or cloud VM on this machine. If I had a cloud instance, I would check the hypervisor info and see whether it looks like Nitro or something similar.

Part C - Tail Latency Simulation

I did run the Flask app and the benchmark in `lab1`:

```bash
cd lab1
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
python benchmark.py
```

It worked and saved the latency graph.

Result from the run:

```text
requests: 100
min: 0.004s
mean: 0.109s
median: 0.080s
max: 0.490s
saved: latency_histogram.png
```

Evidence I collected:

- `evidence/lab1/benchmark_output.txt`
- `evidence/lab1/health_output.txt`
- `evidence/lab1/latency_histogram.png`

What I Learned

The graph shows the usual tail latency thing: most requests are fast, but a few are much slower. That’s annoying in cloud apps because a single slow request can slow down the whole system.

If I had been able to do the VM/container comparison, I’d expect containers to start faster and use fewer resources, while VMs would still be better if you need a full OS or stronger isolation.

Problems I Hit

The only real problem here was missing tools. I had the code and the benchmark, but the machine just didn’t have Multipass or Docker installed, so I couldn’t fully compare VM vs container on this setup.