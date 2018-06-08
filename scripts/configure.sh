#!/usr/bin/env bash

#echo "standaloneEnabled=false" >> /conf/zoo.cfg

# add dynamic configuration file
echo "dynamicConfigFile=/conf/zoo.cfg.dynamic" >> /conf/zoo.cfg

# allow reconfiguration
echo "reconfigEnabled=true" >> /conf/zoo.cfg

# skip ACL check in reconfiguration action
echo "skipACL=yes" >> /conf/zoo.cfg

# remove server.1 and serverId
sed -i "/^server/d" /conf/zoo.cfg
