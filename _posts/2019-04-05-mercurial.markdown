---
layout: post
title:  "Tips on Mercurial"
;date:   2018-10-20 10:20:17 +0200
categories: [scm]
tags: [hg, mercurial, scm, source code management, version control]
---

# Tips on Hg (Mercurial)

## How does it work?

In general it works like Git.  
The most important differences:

| Feature |Git |Hg |
| --- | --- | --- |
| Pull |only current branch | entire repo |
| Push |only current branch | entire repo |
| Put aside current changes | stash |shelve |

 
## Marking your current branch as closed

```
Use "hg commit --close-branch" to mark this branch head as closed. When all heads
    of the branch are closed, the branch will be considered closed.
```
Taken from `hg branch -h`
 
* []()
