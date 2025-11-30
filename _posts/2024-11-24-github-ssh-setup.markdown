---
layout: post
title:  "Setup Github SSH Connection "
date:   2024-11-24 21:20:10 +0200
categories: [ssh]
tags: [ssh, scp, github, secure shell]

---
# Misc Studf on SSH

## Setup Github SSH Connection

When pushing or pulling your stuff to and from github it's prety anoying to have to enter your password.
Rescue comes from SSH - the Secure SHell.
SSH can use cyptographic keys instead of username+password to authenticate requests.
This is how:

1. [Create Key-Pair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
```shell
$ ssh-keygen -t ed25519 -b 4096 -f ~/.ssh/id_ed25519_cwa_github -C "CWACoderWithAttitude@gmail.com"
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/pi/.ssh/id_ed25519_cwa_github
Your public key has been saved in /home/pi/.ssh/id_ed25519_cwa_github.pub
The key fingerprint is:
SHA256:4Ib0JfR8bmjc8lP46J7ZG/M4M7dHW7tjihpvrgzZQsk CWACoderWithAttitude@gmail.com
The key's randomart image is:
+--[ED25519 256]--+
|      .          |
|     . o         |
|    . o + .      |
|   . +.=.= .     |
|    . +ES = .    |
|     ...o+ +    o|
|       + o+ +  .+|
|        +.o*==.=.|
|         =X++B=+o|
+----[SHA256]-----+
```

2. [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
![Photoprism Menu](/images/github_add_public-key.png){:height="10%"}
Copy the contents of your public key file to clipboard
a) Either with `pbcopy` - if available
```shell
$> pbcopy < ~/.ssh/ed25519_cwa_github.pub
```
or
b) open the public key in a text editor like nano or (n)vim or
c) cat file to console and copy from there
```
$> $ cat ~/.ssh/ed25519_cwa_github.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGgClkWDu6awkjVGX3OAnJQYtbrGuw/R/MV+NuQwvupb CWACoderWithAttitude@gmail.com
```

3. Add key to your account

I. Click your profile photo in the upper right corner
II. Select `Settings` > `SSH and GPG keys` > `New SSH Key`
III. Give it a reasobale title and paste the public key copied to the `Key` field

Awesome - your're good to go to clone and push your repos w/o nasty passwords.