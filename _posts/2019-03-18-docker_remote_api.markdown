---
layout: post
title:  "Docker (Remote) API"
date:   2019-03-08 16:30:17 +0200
categories: docker remote api
---
# Whats this about

Docker services are bound to localhost by default by using Sockets.
You can choose to make dockerd available to remote hosts. This can be achieved by binding the docker daemon to the tcp interface:
```bash
# /etc/systemd/system/multi-user.target.wants/docker.service
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
```

In case tweaking docker config is not an option yo may use `socat`:

```bash
$> docker run -d \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name socat \
    -p 127.0.0.1:2375:2375 \
    bobrik/socat \
    TCP-LISTEN:2375,fork UNIX-CONNECT:/var/run/docker.sock
```
A detailed decription of the [Docker Engine API can be found here](https://docs.docker.com/develop/sdk/). Please find more detailed info on [socat here](https://lihsmi.ch/docker/2020/01/02/socat-docker.html)

## List containers and their state

```bash
curl -s  http://vm-itzelbritzel:2376/v1.24/containers/json \
    | jq -r '.[] | .Names[0] + " : " + .State '
/itzelbritzel_jenkins_bastel : running
/itzelbritzel_jenkins : running
/sentry-worker : running
/sentry-cron : running
/sentry : running
/sentry-postgres : running
/sentry-redis : running
/portainer_portainer_1 : running
/mailcatcher : running
/wildflyOracle : running
/wildflypreviewserver_wildfly_1 : running
/wildflypreviewserver_mailcatcher_1 : running
```

## Restart all docker containers
```bash
#!/bin/sh

container_ids=$(docker ps -q)

for id in $container_ids; do
#  echo \
  docker restart $id
done
```

## list all docker networks

```bash
#!/bin/sh

ids=$(docker network ls|grep -v NETWORK|awk '{print $1}')

echo $ids

for id in $ids; do
  docker network inspect $id | jq '.[] | (.Name) + ": " + (.IPAM.Config[0].Subnet)'
done
```

## list all docker networks and containers connected to each
```

$> docker network inspect bridge | \
    jq '.[] | (.Name + ": " + (.Containers[] | (.Name + " : " + .IPv4Address) ))'

"bridge: flamboyant_raman : 172.17.0.2/16"
"bridge: uum_jenkinsX : 172.17.0.7/16"
"bridge: mongodb-3.6 : 172.17.0.4/16"
"bridge: mailcatcherAEM : 172.17.0.3/16"
"bridge: check_mk : 172.17.0.6/16"
```

## Configure network details w docker-compose

We had to restrict docker-compose setups to special network settings.

This can be done easily by adding something like this to your docker-compoe.yml:

```yml
...
networks:
  default:
    driver: bridge
    ipam:
      config:
      - subnet: 192.168.15.0/24
```

# eof
