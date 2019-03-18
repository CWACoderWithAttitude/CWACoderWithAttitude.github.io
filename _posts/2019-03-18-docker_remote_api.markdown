---
layout: post
title:  "Docker Remote API"
date:   2019-03-08 16:30:17 +0200
categories: docker remote api
---
# Whats this about

Docker services are bound to localhost by default by using Sockets.
You can choose to make dockerd available to remote hosts. This can be achieved by binding the docker daemon to the tcp interface:
{% highlight bash %}
# /etc/systemd/system/multi-user.target.wants/docker.service
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
{% endhighlight %}



## List containers and their state

{% highlight bash %}
curl -s  http://vm-ruv:2376/v1.24/containers/json | jq -r '.[] | .Names[0] + " : " + .State '
/ruv_jenkins_bastel : running
/ruv_jenkins : running
/sentry-worker : running
/sentry-cron : running
/sentry : running
/sentry-postgres : running
/sentry-redis : running
/uumportainer_portainer_1 : running
/mailcatcher : running
/wildflyOracle : running
/wildflypreviewserver_wildfly_1 : running
/wildflypreviewserver_mailcatcher_1 : running
{% endhighlight %}
