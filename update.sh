#!/bin/bash

set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	echo "Usage: bash update.sh [version ...]"
	exit 1
fi
versions=( "${versions[@]%/}" )

function copyTemplates {
	local tag=$1
	local shortTag=$(echo $tag | sed -r -e 's/^([0-9]+.[0-9]+).*/\1/')
	local variant=$2

	if [[ -z $variant ]]; then
		targetDir="$shortTag"
		template=templates/Dockerfile
	else
		targetDir="$shortTag/$variant"
		template=templates/$variant/Dockerfile
	fi

	targetFile="$targetDir/Dockerfile"

	mkdir -p "$targetDir"
	cp "$template" "$targetFile"

	sed -ri 's/%%COMPOSER_VERSION%%/'"$tag"'/' "$targetFile"
}

tags="$(git ls-remote --tags --refs https://github.com/composer/composer | cut -d/ -f3 | sort -rV)"

for version in "${versions[@]}"; do
    matches="$(echo "$tags" | grep "^$version" )"

	if releases="$(echo "$matches" | grep -ivEm1 'milestone|-alpha|-beta|-rc')"; then
		tag="$releases"
	else
		tag="$(echo "$matches" | head -n1)"
	fi

	if [[ -z $tag ]]; then
		echo "Cannot find tag matching version: $version"
		exit 1
	fi

	# base for given tag
	copyTemplates "$tag"

	# variants for given tag
	for target in alpine php5 php5/alpine; do
		copyTemplates "$tag" "$target"
	done
done
