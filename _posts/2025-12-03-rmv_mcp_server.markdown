---
layout: post
title: "MCP Server for RMV API"
date: 2025-12-03 23:10:10 +0200
categories: [AI, KI]
tags: [mcp, stdio, uv, python]
---

Last week i showcased one of the most impressive tools in AI i've seen so far: MCP servers.
The audience was company wide - open to technical and non-technical listeners during a developer exchange with my employer.

Most data is hidden in databases, filesystems, mail-servers, Sharepoint, Jira,... or  behind APIs.
Accesible very often only by writing code, SQL quueries etc.

MCP servers bring super powers to users because they can query company data using natural language.

Think of queries like:
```
Which products generated most revenue during christmas season last year.
please group result by city.
```

## MCP?

* Model -> The LLMs brains
* Context -> Your question
* Protocol -> Communication between the ChatBot and MCP server

[I built an example showing the possibilities with public transport data in Frankfurt, Germany](https://github.com/CWACoderWithAttitude/rmv-mcp-server).


