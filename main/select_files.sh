#!/usr/bin/env bash
set -eu

function direstories() {
  depth_option=""
  if [[ $# > 1 ]]; then
    depth_option="-maxdepth $2"
  fi
  cd $1 && find . ${depth_option} -type d 2>/dev/null \
    | sed 's%$%/%' \
    | sed 's%^\./%%' \
    | grep -v '^\s*$'
}

function files() {
  depth_option=""
  if [[ $# > 1 ]]; then
    depth_option="-maxdepth $2"
  fi
  cd $1 && pt -g ^ ${depth_option} 2>/dev/null \
    | sed 's%^\./%%'
}

dir=$(cd $1 && pwd)
readonly DEPTH=$(echo "${dir}" | tr '/' '\n' | wc -l)
if [[ ${DEPTH} -gt 3 ]]; then
  direstories ${dir} && true
  files ${dir}
else
  direstories ${dir} 3 && true
  files ${dir} 3
fi

