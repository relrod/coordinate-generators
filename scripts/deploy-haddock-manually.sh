#!/usr/bin/env bash

cwd="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"
cd "$cwd/.."
f=`mktemp -d`
git clone "git@github.com:relrod/coordinate-generators.git" "$f/coordinate-generators.git"
cabal haddock
pushd "$f/coordinate-generators.git"
  git checkout gh-pages && git rm -rf *
popd
mv dist/doc/html/coordinate-generators/* "$f/coordinate-generators.git/"
pushd "$f/coordinate-generators.git"
  git add -A
  git commit -m "Manual docs deploy."
  git push origin gh-pages
popd
rm -rf "$f"

if [ $? == 0 ]; then
  echo "*** Done: https://relrod.github.io/coordinate-generators/"
  exit 0
else
  echo "*** ERROR!!! Fix the above and try again."
  exit 1
fi
