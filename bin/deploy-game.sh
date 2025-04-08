#!/usr/bin/env bash

set -euo pipefail

# Deploy latest game version
# deploy-game.sh

# Deploy specific version of game
# deploy-game.sh v1.20.4

# Deploy all versions
# deploy-game.sh all

if [[ ! -f ./Dockerfile ]]; then
  echo "Not in a Docker project directory: $(pwd)"
  exit 1
fi

if [[ ! -f ./game-start ]]; then
  echo "Not in a Game project directory: $(pwd)"
  exit 1
fi

GAMEDIR=$(pwd)
GAMENAME=$(basename "$GAMEDIR")
LATEST_RELEASE=${RELEASES[0]}

function releases {
  local versions=$(ls v*)
  echo $(printf "%s\n" "${versions[@]}" | sort -rV)
}

function latest_release {
  local _releases=($(releases))
  echo ${releases[0]}
}

function build_all {
  echo "Build all"
}

function build_version {
  local version="$1"

  if [[ ! -f "./$version" ]]; then
    echo "No version file found: $version"
    exit 1
  fi

  local tag="${GAMENAME}_${version//./_}"

  echo "docker build '$@' -t $tag ."
}

function build_latest {
  echo ""
}

if [[ "$1" = "all" ]]; then
  build_all
elif [[ ! -z "$1" ]]; then
  build_version "$1"
else
  build_latest
fi

for release in $(releases); do
  echo "$release"
done

#dlogin

echo "docker build "$@" -t $GAMENAME ."
echo
#docker build "$@" -t $GAMENAME .

