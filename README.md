This repository contains a sample usage of ZooKeeper Dynamic Reconfiguration.

### How to run it
Build the zookeeper image
```
docker-compose build
```

Run the first zookeeper container
```
docker-compose up zk_main
```

Run the second zookeeper container
```
docker-compose up --scale zk_follower=1
```

Run the third zookeeper container
```
docker-compose up --scale zk_follower=2
```

Run the fourth zookeeper container
```
docker-compose up --scale zk_follower=3
```

and so on...

### Validate the Zookeeper configuration
Get any of the follower zookeeper's ip
```
ZK_FOLLOWER_IP=`docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <CONTAINER ID>`

```

Compare the server configuration from the first zookeeper and the follower
```
docker exec zk_main zkCli.sh -server localhost get /zookeeper/config | grep ^server
docker exec zk_main zkCli.sh -server ${ZK_FOLLOWER_IP} get /zookeeper/config | grep ^server

```



