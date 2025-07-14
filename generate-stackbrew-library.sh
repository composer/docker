#!/usr/bin/env bash
set -Eeuo pipefail

declare -A aliases=(
	[latest]='2 latest'
	[1.10]='1'
)

self="$(basename "${BASH_SOURCE[0]}")"

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" || exit

# get the most recent commit which modified any of "$@"
fileCommit() {
	git log -1 --format='format:%H' HEAD -- "$@"
}

# get the most recent commit which modified "$1/Dockerfile" or any file COPY'd from "$1/Dockerfile"
dirCommit() {
	local dir="$1"; shift
	(
		cd "$dir" || exit
		fileCommit Dockerfile \
			"$(git show HEAD:./Dockerfile | awk '
				toupper($1) == "COPY" {
					for (i = 2; i < NF; i++) {
						print $i
					}
				}
			')"
	)
}

# determine actual composer version based on COMPOSER_VERSION value
extractVersion() {
	git show "$1:$2/Dockerfile" | grep -oP 'ENV COMPOSER_VERSION=\K\d+\.\d+\.\d+'
}

getArches() {
	local repo="$1"; shift
	local officialImagesUrl='https://github.com/docker-library/official-images/raw/master/library/'

	eval "declare -g -A parentRepoToArches=( $(
		find . -name 'Dockerfile' -exec awk '
				toupper($1) == "FROM" && $2 !~ /^('"$repo"'|scratch|binary-with-runtime)(:|$)/ {
					print "'"$officialImagesUrl"'" $2
				}
			' '{}' + \
			| sort -u \
			| xargs bashbrew cat --format '[{{ .RepoName }}:{{ .TagName }}]="{{ join " " .TagEntry.Architectures }}"'
	) )"
}

declare parentRepoToArches

getArches 'composer'

# prints "$2$1$3$1...$N"
join() {
	local sep="$1"; shift
	local out; printf -v out "${sep//%/%%}%s" "$@"
	echo "${out#"$sep"}"
}

directories=( */ )
directories=( "${directories[@]%/}" )

# sort directories descending
IFS=$'\n'; directories=( $(echo "${directories[*]}" | sort -rV) ); unset IFS

# manifest header
cat <<-HEADER
# this file was generated using https://github.com/composer/docker/blob/$(fileCommit "$self")/$self

Maintainers: Composer (@composer), Rob Bast (@alcohol)
GitRepo: https://github.com/composer/docker.git
Builder: buildkit
HEADER

# image metadata for each directory found
for directory in "${directories[@]}"; do
	commit="$(dirCommit "$directory")"
	version="$(extractVersion "$commit" "$directory")"
	tags=("$version" "${version%.*}" "${aliases[$directory]:-}")
	parent="$(awk 'toupper($1) == "FROM" { print $2; exit }' "$directory/Dockerfile")"
	arches="${parentRepoToArches[$parent]}"

	cat <<-METADATA

		Tags: $(join ', ' ${tags[*]})
		Architectures: $(join ', ' $arches)
		GitFetch: refs/heads/main
		GitCommit: $commit
		Directory: $directory
	METADATA
done
