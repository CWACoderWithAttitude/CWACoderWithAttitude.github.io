---
layout: post
title: "SSL Cert Checker"
date: 2025-07-20 00:30:10 +0200
categories: [web]
tags: [ssl, cert, expired, valid]
---

# The problem
Our solution to issue, administer and maintain certificates for SSL encryption had to be updated.

The transition process was quite challenging. The number of involved certs and application using them was humongous.

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




