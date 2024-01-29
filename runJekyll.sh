#!/bin/sh
image="jekyll/jekyll:3.8"
image="richardsoper/jekyll:latest"
image="starefossen/github-pages"
#echo \
#docker run \
#    --volume="${PWD}:/srv/jekyll" \
#    -p 4000:4000 \
#    -it $image \
#    jekyll serve --incremental --drafts

docker run \
    -it \
    --rm \
    -v "$PWD":/usr/src/app \
    -p "4000:4000" \
    $image #\
    #serve --incremental --drafts #starefossen/github-pages 
