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
* 🎨 [Open & Edit in Mermaid Live Editor](https://mermaid.live/edit#base64:eyJjb2RlIjogInNlcXVlbmNlRGlhZ3JhbVxuICAgIGF1dG9udW1iZXJcbiAgICBwYXJ0aWNpcGFudCBVc2VyIGFzIFVzZXIgLyBCcm93c2VyXG4gICAgcGFydGljaXBhbnQgQXBwIGFzIFNQQSAvIE1vYmlsZSBBcHAgKFB1YmxpYylcbiAgICBwYXJ0aWNpcGFudCBLQyBhcyBLZXljbG9hayAoQXV0aCBTZXJ2ZXIpXG4gICAgXG4gICAgVXNlci0-PkFwcDogQ2xpY2tzIFwiTG9naW5cIlxuICAgIE5vdGUgb3ZlciBBcHA6IEdlbmVyYXRlIGNvZGVfdmVyaWZpZXIgJiBjb2RlX2NoYWxsZW5nZSAoUEtDRSlcbiAgICBBcHAtPj5LQzogUmVkaXJlY3QgdG8gL2F1dGg_cmVzcG9uc2VfdHlwZT1jb2RlJmNvZGVfY2hhbGxlbmdlPS4uLlxuICAgIFVzZXItPj5LQzogRW50ZXJzIGNyZWRlbnRpYWxzICYgY29uc2VudHNcbiAgICBLQy0-PkFwcDogUmVkaXJlY3RzIGJhY2sgd2l0aCBhdXRoIGBjb2RlYFxuICAgIEFwcC0-PktDOiBQT1NUIC90b2tlbiAoY29kZSArIGNvZGVfdmVyaWZpZXIpXG4gICAgS0MtPj5BcHA6IFJldHVybnMgQWNjZXNzIFRva2VuLCBJRCBUb2tlbiwgUmVmcmVzaCBUb2tlblxuICAgIEFwcC0-PlVzZXI6IExvZ2luIHN1Y2Nlc3NmdWwhXG4iLCAibWVybWFpZCI6ICJ7XCJ0aGVtZVwiOlwiZGVmYXVsdFwifSIsICJhdXRvU3luYyI6IHRydWUsICJ1cGRhdGVEaWFncmFtIjogdHJ1ZX0)
* 📄 [View Diagram Source File (`diagrams/pkce-flow.mmd`)](https://github.com/CWACoderWithAttitude/CWACoderWithAttitude.github.io2/blob/main/diagrams/pkce-flow.mmd)

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
* 🎨 [Open & Edit in Mermaid Live Editor](https://mermaid.live/edit#base64:eyJjb2RlIjogInNlcXVlbmNlRGlhZ3JhbVxuICAgIGF1dG9udW1iZXJcbiAgICBwYXJ0aWNpcGFudCBVc2VyIGFzIFVzZXIgLyBCcm93c2VyXG4gICAgcGFydGljaXBhbnQgU2VydmVyIGFzIEJhY2tlbmQgV2ViIEFwcCAoQ29uZmlkZW50aWFsKVxuICAgIHBhcnRpY2lwYW50IEtDIGFzIEtleWNsb2FrIChBdXRoIFNlcnZlcilcbiAgICBcbiAgICBVc2VyLT4-U2VydmVyOiBSZXF1ZXN0cyBwcm90ZWN0ZWQgcGFnZVxuICAgIFNlcnZlci0-PktDOiBSZWRpcmVjdHMgdXNlciB0byBLZXljbG9hayBsb2dpblxuICAgIFVzZXItPj5LQzogQXV0aGVudGljYXRlcyBzdWNjZXNzZnVsbHlcbiAgICBLQy0-PlNlcnZlcjogUmVkaXJlY3RzIHdpdGggYXV0aCBgY29kZWBcbiAgICBTZXJ2ZXItPj5LQzogUE9TVCAvdG9rZW4gKGNvZGUgKyBDbGllbnQgU2VjcmV0KVxuICAgIE5vdGUgb3ZlciBTZXJ2ZXIsS0M6IFNlY3JldCBwcm92ZXMgYmFja2VuZCBpZGVudGl0eVxuICAgIEtDLT4-U2VydmVyOiBSZXR1cm5zIFRva2VucyAoQWNjZXNzLCBJRCwgUmVmcmVzaClcbiAgICBTZXJ2ZXItPj5Vc2VyOiBTZXRzIHNlc3Npb24gY29va2llICYgcmVuZGVycyBwYWdlXG4iLCAibWVybWFpZCI6ICJ7XCJ0aGVtZVwiOlwiZGVmYXVsdFwifSIsICJhdXRvU3luYyI6IHRydWUsICJ1cGRhdGVEaWFncmFtIjogdHJ1ZX0)
* 📄 [View Diagram Source File (`diagrams/standard-code-flow.mmd`)](https://github.com/CWACoderWithAttitude/CWACoderWithAttitude.github.io2/blob/main/diagrams/standard-code-flow.mmd)

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
* 🎨 [Open & Edit in Mermaid Live Editor](https://mermaid.live/edit#base64:eyJjb2RlIjogInNlcXVlbmNlRGlhZ3JhbVxuICAgIGF1dG9udW1iZXJcbiAgICBwYXJ0aWNpcGFudCBNMk0gYXMgRGFlbW9uIC8gTWljcm9zZXJ2aWNlXG4gICAgcGFydGljaXBhbnQgS0MgYXMgS2V5Y2xvYWsgKEF1dGggU2VydmVyKVxuICAgIHBhcnRpY2lwYW50IEFQSSBhcyBQcm90ZWN0ZWQgUmVzb3VyY2UgQVBJXG4gICAgXG4gICAgTTJNLT4-S0M6IFBPU1QgL3Rva2VuIChncmFudF90eXBlPWNsaWVudF9jcmVkZW50aWFscyAmIGNsaWVudF9pZCAmIGNsaWVudF9zZWNyZXQpXG4gICAgS0MtPj5NMk06IFJldHVybnMgQWNjZXNzIFRva2VuIChTZXJ2aWNlIEFjY291bnQpXG4gICAgTTJNLT4-QVBJOiBIVFRQIFJlcXVlc3Qgd2l0aCBCZWFyZXIgQWNjZXNzIFRva2VuXG4gICAgQVBJLT4-QVBJOiBWYWxpZGF0ZXMgdG9rZW4gc2lnbmF0dXJlICYgc2NvcGVzXG4gICAgQVBJLT4-TTJNOiBSZXR1cm5zIHJlcXVlc3RlZCBkYXRhXG4iLCAibWVybWFpZCI6ICJ7XCJ0aGVtZVwiOlwiZGVmYXVsdFwifSIsICJhdXRvU3luYyI6IHRydWUsICJ1cGRhdGVEaWFncmFtIjogdHJ1ZX0)
* 📄 [View Diagram Source File (`diagrams/client-credentials-flow.mmd`)](https://github.com/CWACoderWithAttitude/CWACoderWithAttitude.github.io2/blob/main/diagrams/client-credentials-flow.mmd)

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
* 🎨 [Open & Edit in Mermaid Live Editor](https://mermaid.live/edit#base64:eyJjb2RlIjogInNlcXVlbmNlRGlhZ3JhbVxuICAgIGF1dG9udW1iZXJcbiAgICBwYXJ0aWNpcGFudCBDTEkgYXMgQ0xJIFRvb2wgLyBTbWFydCBUVlxuICAgIHBhcnRpY2lwYW50IEtDIGFzIEtleWNsb2FrIChBdXRoIFNlcnZlcilcbiAgICBwYXJ0aWNpcGFudCBQaG9uZSBhcyBVc2VyJ3MgUGhvbmUgLyBMYXB0b3BcbiAgICBcbiAgICBDTEktPj5LQzogUE9TVCAvYXV0aC9kZXZpY2UgKGNsaWVudF9pZClcbiAgICBLQy0-PkNMSTogUmV0dXJucyBgdXNlcl9jb2RlYCwgYHZlcmlmaWNhdGlvbl91cmlgLCBgZGV2aWNlX2NvZGVgXG4gICAgQ0xJLT4-VXNlcjogRGlzcGxheTogXCJHbyB0byBVUkwgJiBlbnRlciBjb2RlXCJcbiAgICBcbiAgICBVc2VyLT4-UGhvbmU6IE5hdmlnYXRlcyB0byB2ZXJpZmljYXRpb25fdXJpICYgZW50ZXJzIGNvZGVcbiAgICBQaG9uZS0-PktDOiBBdXRoZW50aWNhdGVzICYgZ3JhbnRzIGFjY2Vzc1xuICAgIFxuICAgIGxvb3AgUG9sbGluZyAoZXZlcnkgWCBzZWNvbmRzKVxuICAgICAgICBDTEktPj5LQzogUE9TVCAvdG9rZW4gKGdyYW50X3R5cGU9ZGV2aWNlX2NvZGUgJiBkZXZpY2VfY29kZT0uLi4pXG4gICAgICAgIEtDLT4-Q0xJOiBSZXR1cm5zIHBlbmRpbmcgb3IgQWNjZXNzICsgUmVmcmVzaCBUb2tlbnNcbiAgICBlbmRcbiAgICBcbiAgICBDTEktPj5Vc2VyOiBBdXRoZW50aWNhdGlvbiBjb21wbGV0ZSFcbiIsICJtZXJtYWlkIjogIntcInRoZW1lXCI6XCJkZWZhdWx0XCJ9IiwgImF1dG9TeW5jIjogdHJ1ZSwgInVwZGF0ZURpYWdyYW0iOiB0cnVlfQ))
* 📄 [View Diagram Source File (`diagrams/device-authorization-flow.mmd`)](https://github.com/CWACoderWithAttitude/CWACoderWithAttitude.github.io2/blob/main/diagrams/device-authorization-flow.mmd)

---

## Summary Best Practices for Keycloak

1. **Never use Implicit Flow:** It exposes tokens in the URL fragment. Use
   **Authorization Code Flow with PKCE** for SPAs and mobile apps instead.
2. **Protect Confidential Clients:** Never bundle client secrets into frontend
   code, mobile APKs, or SPAs.
3. **Leverage Service Accounts:** Use Client Credentials Flow with Keycloak
   Service Accounts rather than hardcoding technical user passwords.
