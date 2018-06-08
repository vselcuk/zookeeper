#!/usr/bin/env bash

/scripts/configure.sh
/scripts/register.sh
/zookeeper-3.5.4-beta/bin/zkServer.sh start-foreground
