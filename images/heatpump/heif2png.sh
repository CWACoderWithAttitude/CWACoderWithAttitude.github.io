#!/bin/sh

for file in *.heic; do 
  convert "$file" "${file%.heic}.png";
done