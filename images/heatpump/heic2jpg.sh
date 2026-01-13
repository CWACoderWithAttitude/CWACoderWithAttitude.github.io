#!/bin/sh

for file in *.heic; do 
  convert "$file" -quality 85 -interlace Plane "${file%.heic}.jpg";
done