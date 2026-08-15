---
layout: post
title: "OAuth2 & OIDC Auth Flows Demystified: The Keycloak Edition"
date: 2026-08-13 10:00:00 +0200
categories: [security, keycloak]
tags: [OAuth2, OIDC, Keycloak, Authentication, Authorization, Flows]
---

If OAuth 2.0 and OIDC are the rules of the security road, Auth Flows (grant
types) are the specific vehicles you drive depending on where you are going.

When you use an identity provider like Keycloak, picking the right flow is
critical for security and user experience. Choosing the wrong one leaves your
app vulnerable to token theft or broken authentication.

Let's break down the most important auth flows, see how Keycloak handles
them, and know exactly when to use which.

---

## Summary Matrix: Which Flow When?

| Flow | Client Type | Keycloak Client Setting | Best Use Case |
| :--- | :--- | :--- | :--- |
| **Auth Code + PKCE** | Public (SPA / Mobile) | Client auth: `Off`, Standard flow: `On` | Single Page Apps (React/Vue), Mobile apps |
| **Auth Code (Standard)** | Confidential (Server) | Client auth: `On`, Standard flow: `On` | Server-side web apps (Spring Boot, Node.js) |
| **Client Credentials** | M2M (Service / Daemon) | Client auth: `On`, Service accounts: `On` | Microservices calling APIs, Cron jobs |
| **Device Authorization** | Input-constrained | Standard flow: `Off`, Device Auth: `On` | CLI tools, Smart TVs, IoT devices |

---

## 1. Authorization Code Flow with PKCE (Proof Key for Code Exchange)

### When to Use (PKCE)

* **Examples:** A React/Vue Single Page Application (SPA) or mobile app.
* **Why:** Public clients cannot securely store a client secret. PKCE prevents
  interception attacks by creating a dynamic cryptographic verifier per request.

### Keycloak Configuration (PKCE)

1. Create a client with **Client authentication = Off** (Public).
2. Enable **Standard flow**.
3. Set valid redirect URIs (e.g., `http://localhost:3000/*`).
4. Keycloak automatically enforces PKCE (`code_challenge` / `code_verifier`).

### Flow Diagram (PKCE)
>
> View the diagram source code: **[PKCE Flow Diagram Source](https://github.com/CWACoderWithAttitude/CWACoderWithAttitude.github.io2/blob/main/diagrams/pkce-flow.mmd)**

---

## 2. Standard Authorization Code Flow (Confidential Client)

### When to Use (Standard Code)

* **Examples:** Traditional server-rendered web apps (Spring Boot, Express.js).
* **Why:** The backend server can securely store a **Client Secret** away from
  the user's browser.

### Keycloak Configuration (Standard Code)

1. Create a client with **Client authentication = On** (Confidential).
2. Retrieve the **Client Secret** from the *Credentials* tab and configure it.
3. Enable **Standard flow**.

### Flow Diagram (Standard Code)
>
> View the diagram source code: **[Standard Code Flow Diagram Source](https://github.com/CWACoderWithAttitude/CWACoderWithAttitude.github.io2/blob/main/diagrams/standard-code-flow.mmd)**

---

## 3. Client Credentials Flow (Machine-to-Machine / M2M)

### When to Use (Client Credentials)

* **Examples:** Background cron jobs, microservices calling internal APIs.
* **Why:** There is **no user involved**. The application authenticates itself
  directly to Keycloak using its own credentials.

### Keycloak Configuration (Client Credentials)

1. Create a client in Keycloak.
2. Set **Client authentication = On**.
3. Enable **Service accounts roles** under the client settings.
4. Assign appropriate roles to the service account user in Keycloak.

### Flow Diagram (Client Credentials)
>
> View the diagram source code: **[Client Credentials Flow Diagram Source](https://github.com/CWACoderWithAttitude/CWACoderWithAttitude.github.io2/blob/main/diagrams/client-credentials-flow.mmd)**

---

## 4. Device Authorization Flow (IoT & CLI)

### When to Use (Device Authorization)

* **Examples:** CLI tools (`kubectl`, `gh`), Smart TVs, headless IoT devices.
* **Why:** These devices lack standard browsers or keyboard input, so users
  authenticate on a secondary device (phone/laptop).

### Keycloak Configuration (Device Authorization)

1. Enable **OAuth 2.0 Device Authorization Grant** on the client settings.
2. The CLI requests a device code, getting a verification URI and user code.
3. The user opens the URL on their phone, types the code, and logs in.

### Flow Diagram (Device Authorization)
>
> View the diagram source code: **[Device Authorization Flow Diagram Source](https://github.com/CWACoderWithAttitude/CWACoderWithAttitude.github.io2/blob/main/diagrams/device-authorization-flow.mmd)**

---

## Summary Best Practices for Keycloak

1. **Never use Implicit Flow:** It exposes tokens in the URL fragment. Use
   **Authorization Code Flow with PKCE** for SPAs and mobile apps instead.
2. **Protect Confidential Clients:** Never bundle client secrets into frontend
   code, mobile APKs, or SPAs.
3. **Leverage Service Accounts:** Use Client Credentials Flow with Keycloak
   Service Accounts rather than hardcoding technical user passwords.
