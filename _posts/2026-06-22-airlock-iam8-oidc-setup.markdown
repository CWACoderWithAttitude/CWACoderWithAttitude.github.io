---
layout: post
title: "Airlock IAM 8 — OAuth2/OIDC Authorization Server Setup"
date: 2026-06-22 23:00:10 +0200
categories: [devops]
tags: [Airlock IAM, OAuth2, OIDC, Authorization Server]
---

## Caveat

This is work in progress and will be updated as frequent and nescessary.

## TL;DR

Our Airlock IAM server acts as the **Authorization Server (AS) / OpenID Provider (OP)**.
The  application is the **Relying Party (RP) / OAuth2 Client**.

## Gathering required information

Befor we can setup anything we need to collect information about the application.

### Mandatory

| Field | Description | Example |
| --- | --- | --- |
| `client_id` | Unique identifier for the app | `my-app-prod` |
| `redirect_uris` | Exact callback URLs after auth. No wildcards. Must include scheme. | `https://app.example.com/callback` |
| `grant_types` | OAuth2 flows the app will use | `authorization_code`, `refresh_token` |
| `scopes` | Claims the app needs | `openid profile email` |
| `token_endpoint_auth_method` | How the app authenticates at `/token` | `client_secret_basic` or `private_key_jwt` |

### Conditional

| Field | Condition | Notes |
| --- | --- | --- |
| `client_secret` | Required if `client_secret_*` auth method | Generate securely; min. 32 bytes entropy |
| `public_key` / JWKS URI | Required if `private_key_jwt` auth method | Preferred for FAPI compliance |
| `post_logout_redirect_uris` | Required if app uses RP-initiated logout | Must be pre-registered |
| `allowed_origins` / CORS | Required for SPA / browser-based apps | Needed if app calls endpoints directly |
| `id_token_signed_response_alg` | If non-default signing is needed | Default: `RS256` |
| `access_token_lifetime` | If app requires non-default TTL | Default defined at AS level |
| `refresh_token_lifetime` | If offline access is needed | Only with `refresh_token` grant |

### Security Decisions (Agree with App Team)

* **PKCE** — mandatory for all clients (S256). No exceptions.
* **State parameter** — app must send and validate state (CSRF protection).
* **Nonce** — app must send and validate nonce in ID token.
* **Token storage** — app must not store tokens in `localStorage` (XSS risk).

---

## Phase 2: Airlock IAM Configuration

### 2.1 Create the Authorization Server

Navigate to:<br>
`Adminapp → Config Editor → Loginapp → OAuth 2.0/OIDC Authorization Servers`

```yaml
Authorization Server ID: <as-identifier>   # e.g. "myAS" — used in all endpoint URLs
Issuer ID: https://<iam-host>/auth/rest/oauth2/authorization-servers/<as-identifier>
```

> **Note:** The Issuer ID must exactly match the `iss` claim in tokens and the discovery document.

### 2.2 Configure Grants and Flows

Navigate to:<br>
`... → OAuth 2.0 Grants and Flows → OIDC Authorization Code / Hybrid Flow`

```yaml
PKCE Code Challenge Method: S256 required   # Enforce globally
Authorization Code Lifetime: 60s            # Short-lived; non-negotiable
```

### 2.3 Register the Application as a Static Client

Navigate to:<br>
`... → Static Clients → OAuth 2.0 Static Client`

```yaml
Client ID:        <client_id>
Client Secret:    <generated-secret>         # Only if client_secret auth method
Redirect URIs:    https://app.example.com/callback
Grant Types:      authorization_code
                  refresh_token              # Optional
Response Types:   code
Scopes:           openid profile email
```

#### Token Endpoint Authentication

```yaml
# Option A — client_secret_basic (simpler, acceptable for confidential backend apps)
Token Endpoint Auth Method: client_secret_basic

# Option B — private_key_jwt (FAPI-aligned, preferred for high-assurance)
Token Endpoint Auth Method: private_key_jwt
JWKS URI: https://app.example.com/.well-known/jwks.json
```

> **Warning:** `private_key_jwt` requires the DB table `OAUTH2_ACCEPTED_CLIENT_ASSERTIONS`.<br>
Run the IAM migration script if upgrading from IAM 8.2 or older.

#### PKCE Override (per client)

```yaml
PKCE Code Challenge Method: S256 required   # Override default if needed per client
```

### 2.4 Configure Token Lifetimes

Navigate to:<br>
`... → Token Settings`

```yaml
Access Token Lifetime:  300    # 5 minutes — recommended for CIAM
Refresh Token Lifetime: 3600   # 1 hour — adjust to session policy
ID Token Lifetime:      300
```

### 2.5 Configure Scopes and Claims

Navigate to:<br>
`... → Scope Settings`

```yaml
Scopes:
  - openid     # Required for OIDC
  - profile    # Maps: name, given_name, family_name, etc.
  - email      # Maps: email, email_verified

# Map IAM user attributes to token claims
Claim Mappings:
  sub:          <user-identifier-attribute>
  email:        <user-email-attribute>
  given_name:   <user-firstname-attribute>
```

### 2.6 Endpoints Reference

All endpoints are published via the discovery document.

```
Discovery:       https://<iam-host>/auth/rest/oauth2/authorization-servers/<as-id>/.well-known/openid-configuration
Authorization:   https://<iam-host>/auth/oauth2/v3/<as-id>/authorize
Token:           https://<iam-host>/auth/rest/oauth2/authorization-servers/<as-id>/token
Userinfo:        https://<iam-host>/auth/rest/oauth2/authorization-servers/<as-id>/userinfo
JWKS:            https://<iam-host>/auth/rest/oauth2/authorization-servers/<as-id>/jwks
Introspection:   https://<iam-host>/auth/rest/oauth2/authorization-servers/<as-id>/introspect
Revocation:      https://<iam-host>/auth/rest/oauth2/authorization-servers/<as-id>/revoke
```

---

## Phase 3: Application Integration Checklist

### Authorization Request (app → IAM)

```http
GET /auth/oauth2/v3/<as-id>/authorize
  ?response_type=code
  &client_id=<client_id>
  &redirect_uri=https://app.example.com/callback
  &scope=openid%20profile%20email
  &state=<random-csrf-token>
  &nonce=<random-nonce>
  &code_challenge=<S256-challenge>
  &code_challenge_method=S256
```

### Token Exchange (app → IAM)

```http
POST /auth/rest/oauth2/authorization-servers/<as-id>/token
Authorization: Basic <base64(client_id:client_secret)>
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code
&code=<auth-code>
&redirect_uri=https://app.example.com/callback
&code_verifier=<pkce-verifier>
```

### Validation Checklist (app-side)

* [ ] Validate `state` matches value sent in authorization request
* [ ] Validate `nonce` in ID token matches sent value
* [ ] Validate `iss` matches configured Issuer ID
* [ ] Validate `aud` contains `client_id`
* [ ] Validate `exp` — reject expired tokens
* [ ] Validate ID token signature against JWKS endpoint

---

## Security Flags

> **Warning:**
>
> * Never disable PKCE — even for confidential clients.
> * Never use `none` as `token_endpoint_auth_method`.
> * Enforce exact `redirect_uri` matching — no prefix or wildcard matching.
> * Short access token lifetimes + refresh token rotation is preferred over long-lived access tokens.
> * Rotate `client_secret` on a defined schedule; treat it as a credential, not a config value.
