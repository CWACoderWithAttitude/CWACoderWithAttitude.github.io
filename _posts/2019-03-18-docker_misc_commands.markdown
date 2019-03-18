---
layout: post
title:  "Docker Misc Commands"
date:   2019-03-08 16:30:17 +0200
categories: docker commands
---

```bash
container_ids=$(docker ps -q)

for id in $container_ids; do

  docker restart $id
done
```
## Show all docker networks

```bash
#!/bin/sh

ids="$(docker network ls |grep -v NETWORK | awk '{print $1}')"

for id in $ids
do
  docker network inspect "$id" \
    | jq '.[] | (.Name + ": " + .IPAM.Config[].Subnet)'
done
```

Shows
```bash
"bridge: 172.180.0.0/16"
"itzelbritzel: 172.28.0.0/16"
"sentrydockercompose_default: 172.22.0.0/16"
"portainer_default: 172.199.0.0/16"
"wildflyjava8_default: 172.31.0.0/16"
"wildflypreviewserver_default: 172.41.0.0/16"
```


Show containers connected to a network

```bash
#!/bin/sh

ids="$(docker network ls |grep -v NETWORK | awk '{print $1}')"

for id in $ids
do
  docker network inspect "$id" \
    | jq -r '.[] | (.Name + ": " + (.Containers[] | (.Name + " : " + .IPv4Address) ))'
done
```

produces output like this

```bash
itzelbritzel: mailcatcher : 172.28.5.1/16
itzelbritzel: jenkins : 172.28.5.2/16
itzelbritzel: jenkins_bastel : 172.28.5.3/16
itzelbritzel: wildflyOracle : 172.28.5.0/16
sentrydockercompose_default: sentry-worker : 172.22.0.3/16
sentrydockercompose_default: sentry-cron : 172.22.0.6/16
sentrydockercompose_default: sentry-redis : 172.22.0.5/16
sentrydockercompose_default: sentry : 172.22.0.4/16
sentrydockercompose_default: sentry-postgres : 172.22.0.2/16
portainer_default: portainer_portainer_1 : 172.199.0.2/16
wildflypreviewserver_default: wildflypreviewserver_mailcatcher_1 : 172.41.0.3/16
wildflypreviewserver_default: wildflypreviewserver_wildfly_1 : 172.41.0.2/16
```
