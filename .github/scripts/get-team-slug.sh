#!/usr/bin/env bash

set -e

export TEAM_SLUG
export PREVIOUS_TEAM_SLUG

privilege=$1
: "${privilege:?}"

repository=$2
: "${repository:?}"
repository=$(echo "$repository" | tr -d ' ')

TEAM_SLUG=
PREVIOUS_TEAM_SLUG=

case $repository in
"AgaveMonorepo")
  case $privilege in
  "Triage")
    TEAM_SLUG="monorepo-triage"
    ;;
  "Write")
    PREVIOUS_TEAM_SLUG="monorepo-triage"
    TEAM_SLUG="monorepo-write"
    ;;
  *)
    echo "unexpected privilege: $privilege"
    exit 1
    ;;
  esac
  ;;
*)
  echo "unexpected repository: $repository"
  exit 1
  ;;
esac
