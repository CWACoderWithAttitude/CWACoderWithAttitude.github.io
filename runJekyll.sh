#!/bin/sh

docker run \
    --volume="${PWD}:/srv/jekyll" \
    -p 4000:4000 \
    -it jekyll/jekyll:3.8 \
    jekyll serve --incremental --drafts

