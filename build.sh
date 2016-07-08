#!/bin/bash

set -e

cd $(cd ${0%/*} && pwd -P);

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

template="Dockerfile.template"
dockerfile="Dockerfile"

if [[ "$versions" == "" ]]; then
	versions=5.4.0
fi

cp $template $dockerfile

sed -i -e "s/0.0.0/$versions/g" $dockerfile
rm "$dockerfile-e"

# Build and push the image
docker build -t particle4dev/node:$versions .