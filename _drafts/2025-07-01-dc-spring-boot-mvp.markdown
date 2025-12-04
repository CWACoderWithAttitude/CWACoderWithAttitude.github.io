---
layout: post
title: "Spring Boot MVP Devcontainer"
date: 2025-07-01 12:30:10 +0200
categories: [web]
tags: [api,java,spring-boot,postgresql,monitoring,prometheus]
---

This is a stripped down version of [This is on opinionated template](https://github.com/CWACoderWithAttitude/dc-spring-boot-all-in-one).

 that should get you kickstarted.
It contains a micro service implemented with spring boot and JDK21.
These aspects are covered:

* [Container based local development](https://containers.dev)
* JDK21 based spring boot web service (a games database)
  * [Spring Boot default metrics](https://docs.spring.io/spring-boot/reference/actuator/metrics.html)
  * Service shows how to export your own custom metrics.
  * Build-Pipeline that builds the project on each commit. 
  [A code coverage report is generated and published to the projects website](https://github.com/CWACoderWithAttitude/dc-spring-boot-all-in-one).
* Monitoring:
  * [Prometheus](https://prometheus.io) to gather metrics
  * [Grafana](https://grafana.com) to visualize gathered metrics
  * [Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/) to send alert messages - based on gathered metrics.
* [Bruno](https://github.com/usebruno/bruno) API-Request Collection  
* Mailcatcher as FakeSMTP to enable sending alert mails 
* MSSQL DB 2022
* Adminer as GUI tool to manage DBs
* MSSQL Tools if you don't like GUIs

You can click the green `Use this template` button in the upper right corner to create a your own project.
