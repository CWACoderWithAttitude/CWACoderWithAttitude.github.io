---
layout: post
title:  "Kubernetes"
categories: [kubernetes]
tags: [kubernetes, docker, container]
---
## First hints on K8s

* [Cheatsheet](https://kubernetes.io/de/docs/reference/kubectl/cheatsheet)
* [Wildfly in K8s cluster](https://banzaicloud.com/blog/jee-kubernetes/)

```shell
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://kubernetes.docker.internal:6443
  name: docker-desktop
contexts:
- context:
    cluster: docker-desktop
    user: docker-desktop
  name: docker-desktop
- context:
    cluster: docker-desktop
    user: docker-desktop
  name: docker-for-desktop
current-context: docker-desktop
kind: Config
preferences: {}
users:
- name: docker-desktop
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
```




