SELECT_FILES_TOOL_DIR=${SELECT_FILES_TOOL_DIR-${0:A:h}}

function select_files() {
  strings=$(python ${SELECT_FILES_TOOL_DIR}/main/range.py "$BUFFER" $CURSOR)
  left=$(sed -n '1p' <<< "${strings}")
  center=$(sed -n '2p' <<< "${strings}")
  right=$(sed -n '3p' <<< "${strings}")
  out=$(fzfyml3 run ${SELECT_FILES_TOOL_DIR}/main/select_files.yml . "$center")
  if [[ -n "$out" ]]; then
    BUFFER="${left}${out}${right}"
    CURSOR=$((${#BUFFER} - ${#right} + 1))
    zle redisplay
  fi
}
zle -N select_files
bindkey '\e[Z' select_files

