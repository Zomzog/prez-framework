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
    exit 1
fi

echo "Create folders"
mkdir -p $slides/images

if [[ -d $slides/slides.md ]]; then
    echo "slides.md already exist"
else
    echo "Init slides.md"
    cp _slides/slides.md $slides/slides.md
    sed -i -e "s/theTitle/$name/g" "$slides/slides.md"
fi

echo "Add submodule"
cd $path
git init
git submodule add git@github.com:Zomzog/prez-framework.git

echo "Create links"
ln -srf prez-framework/_slides/.* $slides/
ln -srf prez-framework/_slides/*.json $slides/
ln -srf prez-framework/_slides/*.toml $slides/
ln -srf prez-framework/_slides/images/* $slides/images/

ln -srf prez-framework/_tooling/* $slides
ln -srf prez-framework/_tooling/.nojekyll $path/.nojekyll

ln -srf prez-framework/_github $path/.github
cp prez-framework/.gitignore $path/.gitignore

echo "First build"
cd $slides
pnpm install

echo "First commit"
git add .
git commit -m "First commit"
git branch -M main
