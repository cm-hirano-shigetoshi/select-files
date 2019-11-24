#!/usr/bin/env bash
set -eu

input_path=$(cat -)
if [[ "${input_path}" =~ /$ ]]; then
  echo "[44m${input_path}[00m"
  ls -l -G "${input_path}"
else
  head -n 1000 "${input_path}"
fi
