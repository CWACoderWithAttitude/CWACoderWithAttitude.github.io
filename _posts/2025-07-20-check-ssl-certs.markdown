---
layout: post
title: "SSL Cert Checker"
date: 2025-07-20 00:30:10 +0200
categories: [web]
tags: [ssl, cert, expired, valid]
---

# TL;DR
SSL Cert Checker lets you check the validity for a bunch of endpoints

## Problem

Our previous CA software had reached EOL. 

So we had to setup a new one and incrementally rollout new certs to application. During transition time two valid certs were used: old certs issued by trhe legacy CA. And new certs issued by the new CA software.

To assist ensuring all apps have valid certs i designed a small tool.
This tool enabled us to see which apps already use new certs and which ones need attention.

## Challenge

The number of involved certs and applications using them was humongous.

Every service and application was documented in excel.

My task was checking every https endpoint for valid certs:
- It had to be issued by the new CA
- It should not be expired

## How did we tackle te problem?

We wrote scripts to consume those excel lists, transform them and process every system / endpoint.

I had done similar tasks in te past. But not at this scale.

My first attempt involved shell scripts and openssl: Gets the job done but required way to muc time.

Next iteration was implemented in python: much better. Faster, easier to maintain - but still room for improvement.

## The solution

Then i decided to to try a [Rust](https://rust-lang.org) based approach.

Clean as python and fast as hell 🔥!

[Rust SSL-Cert-Checker](https://github.com/CWACoderWithAttitude/ssl-cert-checker)




