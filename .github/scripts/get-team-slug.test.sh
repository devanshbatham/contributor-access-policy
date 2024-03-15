#!/usr/bin/env bash

here=$(dirname "$0")

check() {
  local test_name=$1
  local privilege=$2
  local repository=$3
  local expected_team_slug=$4
  local expected_previous_team_slug=$5

  # shellcheck source=.github/scripts/get-team-slug.sh
  source "$here"/get-team-slug.sh "$privilege" "$repository" 2>&1

  if [[ "$TEAM_SLUG" != "$expected_team_slug" ]]; then
    echo "❌ $test_name team slug: got: $TEAM_SLUG, want: $expected_team_slug"
    exit 1
  fi

  if [[ "$PREVIOUS_TEAM_SLUG" != "$expected_previous_team_slug" ]]; then
    echo "❌ $test_name previous team slug: got: $DISCORDPREVIOUS_TEAM_SLUG_HANDLE, want: $expected_previous_team_slug"
    exit 1
  fi

  echo "✅ $test_name"
}

(
  check "monorepo triage" "Triage" "Agave Monorepo" "monorepo-triage" ""
)
(
  check "monorepo write" "Write" "Agave Monorepo" "monorepo-write" "monorepo-triage"
)
(
  check "repositroy with space #1" "Write" "Agave Monorepo " "monorepo-write" "monorepo-triage"
)
(
  check "repositroy with space #2" "Write" " Agave Monorepo " "monorepo-write" "monorepo-triage"
)
(
  check "repositroy with space #3" "Write" " Agave Monorepo"  "monorepo-write" "monorepo-triage"
)
(
  check "repositroy with space #4" "Write" "Agave  Monorepo"  "monorepo-write" "monorepo-triage"
)