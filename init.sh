#!/usr/bin/env bash

echo "Init new presentation"

name=$1

if [[ -z $name ]]; then
  echo "name is missing"
  exit 0
fi

path=$PWD/../$name

slides=$path/slides

if [[ -d $path ]]; then
  echo "prez already exist"
  exit 0
fi

echo "Create folders"
mkdir -p $slides/images

echo "Init index.adoc"

echo ":source-highlighter: highlightjs" > $slides/index.adoc
echo ":revealjs_theme: black" >> $slides/index.adoc
echo ":revealjs_progress: true" >> $slides/index.adoc
echo ":revealjs_slideNumber: true" >> $slides/index.adoc
echo ":revealjs_history: true" >> $slides/index.adoc
echo ":revealjs_showNotes: false" >> $slides/index.adoc
echo ":revealjs_width: 1080" >> $slides/index.adoc
echo ":imagesdir: images" >> $slides/index.adoc
echo ":customcss: css/custom.css" >> $slides/index.adoc
echo ":docinfo: private" >> $slides/index.adoc
echo "" >> $slides/index.adoc
echo "## $name" >> $slides/index.adoc

echo "Add submodule"
cd $path
git init
git submodule add git@github.com:Zomzog/prez-framework.git

echo "Create links"
ln -srf prez-framework/_slides/* $slides/
ln -srf prez-framework/_slides/images/* $slides/images/

ln -srf prez-framework/_tooling/* $path
ln -srf prez-framework/_tooling/.nojekyll $path/.nojekyll

ln -srf prez-framework/_github $path/.github
cp prez-framework/.gitignore $path/.gitignore

echo "First build"
npm install

echo "First commit"
git add .
git commit -m "First commit"
git branch -M main
