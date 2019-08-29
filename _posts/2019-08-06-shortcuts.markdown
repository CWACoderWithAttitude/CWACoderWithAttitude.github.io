---
layout: post
title:  "Keyboard Shortcuts"
date:   2019-08-05 09:11:17 +0200
categories: [hacking]
tags: [shortcut, os x, ssh]
permalink: /shortcuts
---
# Collection of keyboard shortcuts i consider handy

Although i consider those shortcuts are important to know my brain tends to bury this knowledge.

## Chrome

|Shortcut|Purpose|
|--|---|
|alt + cmd + arrow left|Switch to next tab on the left|
|alt + cmd + arrow right|Switch to next tab on the right|

## SSH

When my ssh session hangs due to lost conection the whole terminal is unusable.   
Try typing `ENTER + ~ + .` to kill the ssh session (or whatever blocks the terminal)

## OS X 

|Shortcut| Purpose |
|---|---|
|Ctrl + Arrow up | Show all windows on current screen|
|Ctrl + Arrow left| Switch to the left screen| 
|Ctrl + Arrow right| Switch to the right screen| 
|Ctrl + Arrow down| Show all windows of the focused application| <-- very handy| 

## iTerm2

|Shortcut|Purpose|
|---|---|
|Cmd + Arrow left|Move to left terminal|
|Cmd + Arrow right|Move to richt terminal|

## mplayer

|Shortcut|Pupose|
|---|---|
| <-  or  ->|       seek backward/forward 10 seconds|
| down or up |      seek backward/forward  1 minute|
| pgdown or pgup|   seek backward/forward 10 minutes|
| < or >    |       step backward/forward in playlist|
| p or SPACE |      pause movie (press any key to continue)|
| q or ESC    |     stop playing and quit program|

## Starting WebServers
Sometimes its quite convenient to access your file via http.   
To implement that you do not have to setup a full fledged apache httpd.
### Python
* [Starting simple python webserver](https://blog.adriaan.io/run-a-simple-server-on-your-mac-for-your-static-files.html)

### NodeJS
In node there's [http-server](). Install it globally to have the chance to start a webserver whereever you want:
```shell
$> npm install -g http-server
```

Now start the webserver from a	ny directory on your system:
```shell
$> http-server
Starting up http-server, serving ./
Available on:
  http://127.0.0.1:8081
  http://192.168.43.192:8081
Hit CTRL-C to stop the server
```
 

