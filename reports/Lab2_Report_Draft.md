Lab 2 Report - Distributed Consistency and Consensus

Name: Karim Mohamed Hamed Gad
Group: SE2

Setup

I used `lab2/docker-compose.yml` to start Redis and etcd. After Docker was available, I ran:

```bash
cd lab2
sudo docker compose up -d
docker compose ps
```

Evidence I collected:

- `evidence/lab2/compose_ps.txt`
- `evidence/lab2/lab2_full_run.txt`
- `evidence/lab2/redis2_info.txt`
- `evidence/lab2/etcd_endpoint_status_before.txt`
- `evidence/lab2/etcd_endpoint_status_after.txt`

Task 1 - Redis Replication and CAP

I wrote a key to `redis-node1` and then read it from `redis-node2`:

```bash
docker exec -it redis-node1 redis-cli SET lab2 "hello from node1"
docker exec -it redis-node2 redis-cli GET lab2
```

It showed the correct value, so replication worked. Then I stopped the replica, wrote another key on the primary, and restarted the replica to see if it catches up.

This shows the usual Redis behavior: the primary keeps accepting writes, but the replica can lag and needs to sync later.

Task 2 - Raft with etcd

I did a simple etcd put/get:

```bash
docker exec -it etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 put foo bar
docker exec -it etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 get foo
```

That worked. Then I checked the cluster status and leader election:

```bash
docker exec -it etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 endpoint status -w table
```

The first output showed `etcd3` as leader. After stopping `etcd1`, `etcd2` and `etcd3` still had quorum and the cluster stayed available.

Reflection

Redis replication is useful for scaling reads, but it is weaker consistency because the replica can lag behind the primary. That’s why this setup is more like eventual consistency.

etcd uses Raft, which is stronger: writes only commit after a majority agrees. With three nodes, it can handle one failure but not two. That’s why etcd is better for important coordination data than plain Redis replication.

Problems I Hit

This lab had a few annoying bits. I had to double-check the Docker Compose service names and make sure the commands matched exactly, especially for etcd. The hardest part was interpreting the etcd endpoint status after stopping one node, but after that the cluster behavior made sense.
