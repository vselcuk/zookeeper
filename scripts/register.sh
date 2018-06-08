#!/usr/bin/env bash

SERVER_IP=`ip -4 addr show eth0 | grep inet | awk '{print $2}' | awk -F '/' '{print $1}'`

if [[ -n "${ZK_HOST}" ]]; then
    # get server list from another zookeeper instance
    SERVER_LIST=`zkCli.sh -server ${ZK_HOST}:2181 get /zookeeper/config | grep ^server`

    # calculate the next server id
    SERVER_ID=$((`echo "${SERVER_LIST}" | awk -F'=' '{print$1}' | awk -F'.' '{print $2}' | sort -nr | head -1` + 1))

    # populate the zookeeper dynamic configuration
    echo "${SERVER_LIST}" > /conf/zoo.cfg.dynamic
    echo "server.${SERVER_ID}=${SERVER_IP}:2888:3888:observer;2181" >> /conf/zoo.cfg.dynamic

    # initiate the current zookeeper for the calculated id
    zkServer-initialize.sh --myid=${SERVER_ID} --force

    # start the zookeeper and register the new zookeeper instance to the cluster
    zkServer.sh start
    zkCli.sh -server ${ZK_HOST}:2181 reconfig -add "server.${SERVER_ID}=${SERVER_IP}:2888:3888:participant;2181"

    # start the zookeeper and let it started again in foreground to stream the logs
    zkServer.sh stop
else
    # first zookeeper instance
    SERVER_ID=1

    # populate the zookeeper dynamic configuration
    echo "server.${SERVER_ID}=${SERVER_IP}:2888:3888;2181" > /conf/zoo.cfg.dynamic

    # initiate the current zookeeper
    zkServer-initialize.sh --myid=${SERVER_ID} --force
fi;
