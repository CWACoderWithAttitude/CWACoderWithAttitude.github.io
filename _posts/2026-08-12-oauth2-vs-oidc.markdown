---
layout: post
title: "OAuth2 vs. OIDC: Demystified in Simple Terms"
date: 2026-08-12 10:00:00 +0200
categories: [security, web]
tags: [OAuth2, OIDC, Authentication, Authorization]
---

If you've ever built a web app, integrated Google/GitHub login, or set up an API gateway, you've almost certainly bumped into **OAuth 2.0** and **OIDC (OpenID Connect)**.

People often mix them up or treat them as interchangeable. They aren't. Let's clear up the confusion with a simple analogy.

---

## TL;DR

* **OAuth 2.0** is about **access** (giving permissions to apps).
* **OIDC** is about **identity** (proving who you are).
* OIDC is just OAuth 2.0 wearing an identity badge.

---

## The Ultimate Analogy: The Valet vs. The Bouncer

Imagine you go to a fancy resort:

1. **OAuth 2.0 is your Valet Ticket.**
   When you hand your car keys to the valet, you give them permission (*authorization*) to park and retrieve your car. The valet doesn't need to know your life story, your passport number, or who you are; they just need proof that you authorized them to drive *this* car.
2. **OIDC is your Hotel Room Key Card (with your ID checked at check-in).**
   When you check into the front desk, the hotel verifies your identity (*authentication*) and gives you a key card that proves who you are and what room you belong in.

---

## OAuth 2.0: Authorization ("Can I do this?")

* **What it is:** An authorization framework.
* **What it solves:** Delegation. It lets Application A access resources on Application B on behalf of User X, without sharing User X's password.
* **Key concept:** Access Tokens.
* **Example:** Allowing a fitness app (Strava) to post workouts to your Twitter feed. Twitter gives Strava a token saying *"Hey, this app has permission to post a tweet for user Volker."*

---

## OIDC: Authentication ("Who are you?")

* **What it is:** An identity layer built **on top** of OAuth 2.0.
* **What it solves:** Authentication. It standardizes how an application can verify who the user is and get basic profile information (like name, email, and user ID).
* **Key concept:** ID Tokens (JWTs).
* **Example:** Clicking "Login with Google" on a new website. Google authenticates you and hands the website an ID token proving who you are.

---

## The Relationship: OIDC = OAuth 2.0 + Identity

The relationship is hierarchical: **OIDC is built on OAuth 2.0.**

OIDC uses OAuth 2.0's exact same infrastructure, flows (like Authorization Code Flow with PKCE), and token endpoints. The only difference is that when you request the `openid` scope in OAuth 2.0, the Authorization Server returns an **ID Token** alongside the usual Access Token.

| Feature | OAuth 2.0 | OpenID Connect (OIDC) |
| :--- | :--- | :--- |
| **Primary Goal** | **Authorization** (Access delegation) | **Authentication** (User verification) |
| **Core Question** | *"What can this app do?"* | *"Who is this user?"* |
| **Key Artifact** | Access Token | ID Token (JWT) + Access Token |
| **Scope Required** | Any custom scope | Must include `openid` |
