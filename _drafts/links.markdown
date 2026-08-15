<https://www.linkedin.com/posts/rocky-bhatia-a4801010_backend-systemdesign-authentication-share-7475148634704203776-UlCZ/?utm_source=share&utm_medium=member_desktop&rcm=ACoAAAAgS5sBtmZyF_9KsdqYMsMZ5sDAhOIK_YQ>
90% of developers pick the wrong authentication method.

Then spend months patching the consequences.

JWT, Session, OAuth 2.0, API Keys - they're not interchangeable. Each one solves a different problem.

Here's the breakdown every backend engineer should know 👇

🔹 𝗦𝗲𝘀𝘀𝗶𝗼𝗻
Server creates a session on login, stores it in Redis/DB, returns session ID via cookie.
→ Stateful. Easy to revoke. Best for traditional web apps with a single backend.
→ Weakness: doesn't scale across services without a shared store.

🔹 𝗝𝗪𝗧
Server signs a token with claims (user, expiry, scope). Client sends it on every request.
→ Stateless. Scales infinitely. Best for microservices, SPAs, mobile apps.
→ Weakness: hard to revoke before expiry, payload is visible by default.

🔹 𝗢𝗔𝘂𝘁𝗵 𝟮.𝟬
User grants third-party apps limited access via an authorization server.
→ Mixed state. Industry standard for delegation. Best for "Login with Google," GitHub access, third-party integrations.
→ Weakness: complex to implement correctly - auth code, PKCE, client credentials, device flows.

🔹 𝗔𝗣𝗜 𝗞𝗲𝘆𝘀
Static long-lived secret tied to a service or developer account.
→ Stateful. Simple to rotate. Best for server-to-server APIs, SDKs, internal services.
→ Weakness: no user identity, no expiry by default. Leaked keys are dangerous.

The rule:
→ Web app, one backend → Session
→ Microservices, mobile, SPA → JWT
→ Third-party access → OAuth 2.0
→ Server-to-server → API Keys

Picking the wrong one isn't a bug. It's a security incident waiting to happen.

Save this for your next system design. 📌

Which one do you use most? 💬
