---
layout: post
title: "OAuth2 Grant-Types"
date: 2024-01-03 00:30:10 +0200
categories: [oauth2]
tags: [grant-type, security, terminology]
---

> Disclaimer: Data shown here is most likely incorrect. Use at your own risk. The main purpose is a kinda cheat sheet i can refer to.

# Different `grant types`

OAuth2 can be used in various scenarios.

Scenarios differ in security contraints.

| Scenario                          | Meaning                        | Comment                    |
| --------------------------------- | ------------------------------ | -------------------------- |
| Web Applicatiuon w backend server | authorization code flow        | Most common                |
| Native mobile app                 | authorization code flow w PKCE |                            |
| JS app (aka SPA) w API backend    | implicit flow                  | Should not be used anymore |
|                                   |                                | Transfers token through    |
| MicroServices and APIs            | client credential flow         |

```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```
