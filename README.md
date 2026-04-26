Karim Mohamed Hamed Gad, group SE2.

Hi and welcomed to my repo, first things first I want to be honest: I was finishing my graduation project weggo at the same time, so this was stressful, and the work is not perfectly polished. I still did my best and kept the evidence.

What is in this repo

lab1    - VM vs container notes plus the tail latency Flask app and benchmark

lab2    - Redis replication and etcd Raft with Docker Compose

lab3    - Docker image builds, local kind Kubernetes cluster, deployment, service, and self-healing checks ------> this lab bricked my arch linux install twice this was not fun

week4-lab    - a small microservices example with product-service and order-service

reports    - the lab reports written from my perspective

in the evidence folder there are screenshots and text logs for each lab so the professor can verify the work

evidence files included

environment
- evidence/environment/missing_tools_output.txt
- evidence/environment/missing_tools_screenshot.png

lab1
- evidence/lab1/benchmark_output.txt
- evidence/lab1/benchmark_output_screenshot.png
- evidence/lab1/free_h_host.txt
- evidence/lab1/free_h_host_screenshot.png
- evidence/lab1/df_h_host.txt
- evidence/lab1/df_h_host_screenshot.png
- evidence/lab1/top_processes_host.txt
- evidence/lab1/top_processes_host_screenshot.png
- evidence/lab1/latency_histogram.png
- evidence/lab1/health_output.txt

lab2
- evidence/lab2/lab2_full_run.txt
- evidence/lab2/compose_ps.txt
- evidence/lab2/compose_down.txt
- evidence/lab2/redis2_info.txt
- evidence/lab2/etcd_endpoint_status_before.txt
- evidence/lab2/etcd_endpoint_status_after.txt
- evidence/lab2/lab2_final_results.txt
- evidence/lab2/lab2_log.txt

lab3
- evidence/lab3/lab3_partA.txt
- evidence/lab3/lab3_partA_final.txt
- evidence/lab3/lab3_partA_retry.txt
- evidence/lab3/lab3_partA_cgroup.txt
- evidence/lab3/lab3_partA_cgroup_stats.txt
- evidence/lab3/lab3_partB.txt
- evidence/lab3/lab3_partCDE.txt
- evidence/lab3/lab3_partCDE_retry2.txt
- evidence/lab3/lab3_partCDE_final.txt
- evidence/lab3/lab3_probe_restart.txt

lab4
- evidence/lab4/lab4_run.txt
- evidence/lab4/api_success_output.txt
- evidence/lab4/api_success_output_screenshot.png
- evidence/lab4/failure_output.txt
- evidence/lab4/failure_output_screenshot.png

What I did and what the objectives were

lab1    - I tried the VM/container comparison part as much as possible, then I ran the Flask tail latency app and benchmark. The main point was to show how most requests are fast, but the tail of requests can still be slow.
lab2    - I made Redis replication work, I tested reading from the replica and how it syncs after failure, and I used etcd to show Raft leader election and consistency. The point was to see eventual consistency vs strong consensus.
lab3    - I built the Docker images, loaded the local image into kind, deployed the app and the probe deployment, and I tested pod restart and recovery. The goal was to demonstrate Kubernetes orchestration and self-healing behavior.
week4-lab    - I built the two microservices, ran them with Docker Compose, and tested the case where product-service is down so order-service fails. The goal was to show service dependency and how microservices can break when another service stops.

What I achieved

I completed the main lab activities and kept records for the professor to verify. For lab1, I have benchmark output and the latency histogram. For lab2, I have Redis and etcd logs plus compose outputs. For lab3, I have Kubernetes output and probe restart evidence. For lab4, I have the order API success output and the failure output when product-service was stopped.

Where to find everything

reports    - lab write-ups and reflections
evidence    - actual output files, logs, and screenshots
lab1, lab2, lab3, week4-lab    - the code and configs used for each lab

like i said in the begining of this readme i know this is not perfect, but i did my best while managing between these assighments and my gradupation project and given its scale this was really hard to do, either thank you for the experience and enjoy :) 

