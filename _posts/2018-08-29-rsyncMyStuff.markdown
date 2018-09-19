---
layout: post
title:  "My rsync backup script"
date:   2018-08-29 22:20:17 +0200
categories: rsync shell backup 
---
# How i backup stuff 

{% highlight bash %}
#!/bin/sh 
now=$(date +%Y-%m-%d_%H-%M)
dst_drive=/Volumes/BACKUP_DRIVE
dst=$dst_drive/$USER/$now

mkdir -p $dst

rsync_options="-arvz"

root=/Users/vbe

src="
$root/.ssh
$root/bin
$root/Documents
$root/Pictures
$root/Dev/source/non_commercial
"
for s in $src; do
#  echo \
  rsync $rsync_options $s $dst
done
{% endhighlight %}

