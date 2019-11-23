#!/bin/sh

set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "isaiahnyabuto@gmail.com"
git config --global user.name "Isaiah Nyabuto"

git clone -b master https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git im-data-hub
cd im-data-hub
cp -r ../_book/* ./
git add --all *
git commit -m"Update the book" || true
git push -q origin master
