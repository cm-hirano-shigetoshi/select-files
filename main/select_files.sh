#!/usr/bin/env bash
set -eu

target="$1"
shift
show_dir=false
show_hidden=false
while [[ $# > 0 ]]; do
  if [[ $1 = "-d" ]]; then
    show_dir=true
  elif [[ $1 = "-h" ]]; then
    show_hidden=true
  fi
  shift
done

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
  options=""
  if $show_hidden; then
    options="-U --hidden"
  fi
  pt -g ^ "${1}/." $options 2>/dev/null \
    | sed 's%//\+%/%g' \
    | sed 's%^\./%%' \
    | grep -v '^\s*$'
}

if $show_dir; then
  parent_dir "$target" && true
  direstories "$target" && true
  files "$target"
else
  files "$target"
fi

