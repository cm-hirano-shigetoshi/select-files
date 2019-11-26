#!/usr/bin/env bash
set -eu

function direstories() {
  echo '../'
  find "$1" -type d 2>/dev/null \
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

direstories "$1"
files "$1"

