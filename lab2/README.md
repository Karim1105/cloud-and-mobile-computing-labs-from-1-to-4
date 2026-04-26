Lab 2 - Distributed Consistency and Consensus

This one is about Redis replication and etcd Raft. I used Docker Compose to bring everything up, then I tested the replica behavior and the leader-based consistency.

Start the lab:

```bash
docker compose up -d
docker compose ps
```

Redis replication stuff:

Write to the primary:

```bash
docker exec -it redis-node1 redis-cli
SET lab2 "hello from node1"
GET lab2
```

Then read from the replica:

```bash
docker exec -it redis-node2 redis-cli
GET lab2
INFO replication
```

I also stopped the replica to see what happens when it is down, then wrote a value on the primary and started the replica again:

```bash
docker stop redis-node2
docker exec -it redis-node1 redis-cli SET during_failure "written while replica down"
docker start redis-node2
docker exec -it redis-node2 redis-cli GET during_failure
```

For etcd Raft:

```bash
docker exec -it etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 put foo bar
docker exec -it etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 get foo
docker exec -it etcd1 etcdctl --endpoints=http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 endpoint status -w table
```

Then I stopped one etcd node and checked the status again to see how the cluster stays available:

```bash
docker stop etcd1
docker exec -it etcd2 etcdctl --endpoints=http://etcd2:2379,http://etcd3:2379 endpoint status -w table
```

Cleanup:

```bash
docker compose down
```
