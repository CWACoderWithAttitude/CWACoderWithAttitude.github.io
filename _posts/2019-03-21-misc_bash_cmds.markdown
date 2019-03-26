---
layout: post
title:  "Misc. Bash Commands"
date:   2019-03-08 16:30:17 +0200
categories: bash cmds
---

# Misc. Bash Commands

## tar

Extract just a file or folder from tar archive

```bash
$> tar -xf tarfile.tar folder1 filename1
```
[Taken from here](https://www.cyberciti.biz/faq/linux-unix-extracting-specific-files/)

## tmux

* [tmux cheat sheet](http://atkinsam.com/documents/tmux.pdf)

## Text processing w `sed`

- replace the version number in a pom.xml file
```bash
sed -i -e "s/<version>2.13.0-SNAPSHOT<\/version>/<version>2.15<\/version>/g" pom.xml
```
- replace verion number in all pom.xml files
```bash
find . -name pom.xml \
    -exec sed -i -e "s/<version>REPLACE-ME<\/version>/<version>REPLACEMENT<\/version>/g" {} \;
```
