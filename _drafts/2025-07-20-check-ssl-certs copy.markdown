---
layout: post
title: "Kick Docker Desktop - Use Podman instead"
date: 2026-02-05 23:00:00 +0200
categories: [dev]
tags: [docker, podman, devcontainers]
---

# Use Podman istead of Docker Desktop

1. I upgraded Podman

```
❯ brew upgrade podman
✔︎ JSON API cask.jws.json                                   Downloaded   15.3MB/ 15.3MB
✔︎ JSON API formula.jws.json                                Downloaded   32.0MB/ 32.0MB
Warning: podman 5.7.1 already installed
```

2. Initialize the Podman VM
Docker containers - or more specific OCI containers - are a linux thing.

So initialize and fire up the VM that runs a tiny linux instance
```
❯ podman machine init
Looking up Podman Machine image at quay.io/podman/machine-os:5.7 to create VM
Getting image source signatures
Copying blob 755f2149fbd7 done   |
Copying config 44136fa355 done   |
Writing manifest to image destination
755f2149fbd7459cd18238941fb6e9e701a2fff9c3af468f81315ccf601ac8d2
Extracting compressed file: podman-machine-default-arm64.raw: done
Machine init complete
To start your machine run:

	podman machine start

  ~/Dev/volker/dev-container-repo/articles/dc-spring-boot-keycloak   keycloak ⇡3 !11 ?5 ············  1m 37s  system  23:26:13
❯ podman machine start
Starting machine "podman-machine-default"

This machine is currently configured in rootless mode. If your containers
require root permissions (e.g. ports < 1024), or if you run into compatibility
issues with non-podman clients, you can switch using the following command:

	podman machine set --rootful

API forwarding listening on: /var/folders/y_/sh3qh6bj2td30hdc4x6dp9280000gn/T/podman/podman-machine-default-api.sock

Another process was listening on the default Docker API socket address.
You can still connect Docker API clients by setting DOCKER_HOST using the
following command in your terminal session:

        export DOCKER_HOST='unix:///var/folders/y_/sh3qh6bj2td30hdc4x6dp9280000gn/T/podman/podman-machine-default-api.sock'

Machine "podman-machine-default" started successfully
```

3. Env Update
I added this to the end of my  `~/.zshrc`
```
DOCKER_HOST='unix:///var/folders/y_/sh3qh6bj2td30hdc4x6dp9280000gn/T/podman/podman-machine-default-api.sock'
alias docker=podman
```

Apply the changes:
`source ~/.zshrc`

Result:

```
❯ docker -v
podman version 5.7.1
  ~/Dev/volker/dev-container-repo/articles/dc-spring-boot-keycloak   keycloak ⇡3 !13 ?5 ·····················  system  00:06:36
❯ docker-compose -v
podman-compose version 1.5.0
podman version 5.7.1```