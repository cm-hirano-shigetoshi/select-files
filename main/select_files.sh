#!/usr/bin/env bash
set -eu

dir=$(cd $1 && pwd)
readonly DEPTH=$(echo "${dir}" | tr '/' '\n' | wc -l)
if [[ ${DEPTH} -gt 3 ]]; then
  cd $dir && find . -type d 2>/dev/null \
    | sed 's%$%/%' \
    | sed 's%^\./%%' \
    | grep -v '^\s*$' \
    && true
  cd $dir && pt -g ^ 2>/dev/null \
    | sed 's%^\./%%'
else
  cd $dir && find . -maxdepth 3 -type d 2>/dev/null \
    | sed 's%$%/%' \
    | sed 's%^\./%%' \
    | grep -v '^\s*$' \
    && true
  cd $dir && pt -g ^ --depth=3 2>/dev/null \
    | sed 's%^\./%%'
fi

