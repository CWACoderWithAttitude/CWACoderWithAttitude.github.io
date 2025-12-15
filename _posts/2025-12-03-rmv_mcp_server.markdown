---
layout: post
title: "MCP Server for RMV API"
date: 2025-12-03 23:10:10 +0200
categories: [AI, KI]
tags: [mcp, stdio, uv, python]
---

[I built an example showing the possibilities with public transport data in Frankfurt, Germany](https://github.com/CWACoderWithAttitude/rmv-mcp-server).

You can use "normal" queries like :
```
I want to go from Königsteiner Strasse in Höchst to Landgasthof Alt Bischofsheim in Maintal.
```

Using the chat bots 
- `LLM` (the model - thats what the model "M" in MCP stands for) the bot/agent understands the
- `question` (that would be the context "C" in MCP): the query is split into main concepts  and then 
- uses `external` resources - public RMV in this case - to answer the question.
The standardized communication makes up for the protocol "P" in MCP.

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


