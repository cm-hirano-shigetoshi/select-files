#!/usr/bin/env bash
set -eu

function parent_dir() {
  if [[ "$1" = "/" ]]; then
    echo "/"
  else
    echo "$1/../"
  fi
}

function direstories() {
  find "$1" -maxdepth 1 -type d 2>/dev/null \
    | grep -vxF "$1" \
    | sed 's%//\+%/%g' \
    | sed 's%$%/%' \
    | sed 's%^\./%%' \
    | grep -v '^\s*$'
}

function files() {
  pt -g ^ "$1" 2>/dev/null \
    | sed 's%//\+%/%g' \
    | sed 's%^\./%%' \
    | grep -v '^\s*$'
}

if [[ $# > 1 ]] && [[ $2 = "-d" ]]; then
  parent_dir "$1" && true
  direstories "$1" && true
  files "$1"
else
  files "$1"
fi

