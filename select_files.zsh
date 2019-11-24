SELECT_FILES_TOOL_DIR=${SELECT_FILES_TOOL_DIR-${0:A:h}}

function select_files() {
  local strings left center right dir query
  strings=$(${SELECT_FILES_TOOL_DIR}/bin/range $CURSOR "$BUFFER")
  left=$(sed -z -n '1p' <<< "${strings}" | sed 's/\x0//')
  center=$(sed -z -n '2p' <<< "${strings}" | sed 's/\x0//')
  right=$(sed -z -n '3p' <<< "${strings}" | sed 's/\x0//')
  #echo "\"$left\"" | xxd
  #echo "\"$center\"" | xxd
  #echo "\"$right\"" | xxd

  center="$(echo "${center}" | sed 's%\([^/]\)$%\1/%')"
  dir="$(echo "${center}" | sed -e 's%^$%.%' -e "s%^~%${HOME}%")"
  if [[ -d "${dir}" ]]; then
    query=""
  else
    center="$(echo "${center}" | sed 's%[^/]\+/$%%')"
    query="$(basename "${dir}")"
    dir="$(dirname "${dir}")"
  fi
  out=$(fzfyml run ${SELECT_FILES_TOOL_DIR}/main/select_files.yml "${center}" "${dir}" "${query}")
  if [[ -n "$out" ]]; then
    BUFFER="${left}${out}${right}"
    CURSOR=$((${#BUFFER} - ${#right}))
    zle redisplay
  fi
}
zle -N select_files

function select_files_test() {
  result=$(python $SELECT_FILES_TOOL_DIR/test.py)
  if [[ -n $result ]]; then
    BUFFER=$result
    zle redisplay
  fi
}
zle -N select_files_test
bindkey '\e[Z' select_files

