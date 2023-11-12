#!/usr/bin/env bash

echo "Init new presentation"

name=$1

if [[ -z $name ]]; then
  echo "name is missing"
  exit 0
fi

path=$PWD/$name

if [[ -d $path ]]; then
  echo "prez already exist"
  exit 0
fi

mkdir -p $path/slides/images

echo ":source-highlighter: highlightjs" > $path/slides/index.adoc
echo ":revealjs_theme: black" >> $path/slides/index.adoc
echo ":revealjs_progress: true" >> $path/slides/index.adoc
echo ":revealjs_slideNumber: true" >> $path/slides/index.adoc
echo ":revealjs_history: true" >> $path/slides/index.adoc
echo ":revealjs_showNotes: false" >> $path/slides/index.adoc
echo ":revealjs_width: 1080" >> $path/slides/index.adoc
echo ":imagesdir: images" >> $path/slides/index.adoc
echo ":customcss: css/custom.css" >> $path/slides/index.adoc
echo ":docinfo: private" >> $path/slides/index.adoc
echo "" >> $path/slides/index.adoc
echo "== $name" >> $path/slides/index.adoc

ln -srf $PWD/_slides/* $path/slides/
ln -srf $PWD/_slides/images/* $path/slides/images/

ln -srf $PWD/_tooling/* $path
ln -srf $PWD/_tooling/.nojekyll $path/.nojekyll
