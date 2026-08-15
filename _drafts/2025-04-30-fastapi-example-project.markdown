---
layout: post
title:  "FastAPI Devcontainers Project"
date:   2025-04-30 15:04:10 +0200
categories: [fastapi]
tags: [python, restapi, devcontainers]

---
# FastAPI Example Project

## TL;DR

This is a fastapi development project based on devcontainers.

## What does it provide?

It includes:

* FastAPI application
* PostgreSQL: DB to store data
* Adminer: graphical interface to the DB
* Prometheus:collect and store metrics from the FastAPI application
* Grafana: visualize metrics
* Alertmanager: Send notofications basesd on the collected metrics: not ready yet
* Mailcatcher: Test sending emails
* Bruno API collections to test the api.
*
* Github workflow to run tests and publish the covwerager report to the project-homepage
