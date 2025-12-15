---
layout: post
title: "MCP Server for RMV API"
date: 2025-12-03 23:10:10 +0200
categories: [AI, KI]
tags: [mcp, stdio, uv, python]
---

## TL;DR
MCP servers connect ChatBots and AI agents to the real world: 

They open up the possibility to ask natural language questions on custom data.

## How it works
I'll show you how to connect claude desktop to an MCP server.

### Different approaches

There're three ways to integrate MCP servers:
- STDOIO
- HTTP
- SSE (legacy)

#### STDIO
Used when MCP server and chatbot / AI agent run on the same machine

#### HTTP
In case both components run on different hosts, for redundancy or scalability.

#### SSE (legacy)
Server Sent Events is what was used in the beginning. It's still supported 


## Show me the code

[I built an example showing the possibilities with public transport data in Frankfurt, Germany](https://github.com/CWACoderWithAttitude/rmv-mcp-server).


You can use "normal" queries like :
```
I want to go from Königsteiner Strasse in Höchst to Landgasthof Alt Bischofsheim in Maintal.
```

Using the chat bots 
- `LLM` (the model - that's what the model "M" in MCP stands for) the bot/agent understands the
- `question` (that would be the context "C" in MCP): the query is split into main concepts  and then 
- uses `external` resources - public RMV in this case - to answer the question.
The standardized communication makes up for the protocol "P" in MCP.

The above question leads to this answer:
```
Ich helfe dir gerne bei der Routenplanung mit dem RMV! Lass mich zunächst die beiden Stationen suchen.
...

```
Please find the full converstion [here](https://claude.ai/share/881a9f3d-e46c-4375-b35b-d755a06c06f1)

In my eyes MCP is one of the most impressive tools in AI i've seen so far.

They enable chat bots or agents to use information that is not stored in their LLMs brain. 
Enabling them to systematically use data there were NOT trained with.

Most data is hidden in databases, filesystems, mail-servers, Sharepoint, Jira,... or  behind APIs.
Accessible very often only by writing code, SQL queries etc.

MCP servers bring super powers to users because they can query company data using natural language.

Think of queries like:

```
Which products generated most revenue during christmas season last year.
please group result by city.
```


