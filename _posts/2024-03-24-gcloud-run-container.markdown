---
layout: post
title: "Run a container and GCloud"
date: 2024-03-24 00:30:10 +0200
categories: [gloud]
tags: [web api container]
---

> Disclaimer: Data shown here is most likely incorrect.
> Use at your own risk.
> The main purpose is a kinda cheat sheet i can refer to.

## TL;DR

Run a container on google cloud infrastructure.

This is inspired by this [Beyond Fireship: How I deploy serverless containers for free](https://www.youtube.com/watch?v=cw34KMPSt4k) video.

Here i'll try to summarize the basic steps to make it work.

1. Upload the image of your app to the google image registry -
   atrifact
   registry
   1.1 [create a repository](https://console.cloud.google.com/artifacts?hl=de&project=clear-faculty-418222)
