#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
  # No boilerplate if sourced
  IS_SOURCED=true
else
  set -eu -o pipefail
fi

if ! command gpt --help &> /dev/null; then
  echo >&2 "Error: gpt is not installed or is not on your PATH"
  echo >&2 "  - See https://github.com/sysread/bash-gpt for installation instructions"
  [ "$IS_SOURCED" == "true" ] && return 1 || exit 1
fi

usage() {
  local exit_code="${1:-0}"

  cat << 'EOF'

usage: cmd <prompt>

  -h, --help    Display this help message

EOF

  [ "$IS_SOURCED" == "true" ] && return "$exit_code" || exit "$exit_code"
}

while (("$#")); do
  case "$1" in
    --help | -h)
      usage 0
      ;;

    *)
      break
      ;;
  esac
done

if [ -z "$*" ]; then
  echo "error: a prompt is required"
  usage 1

  # usage() won't return from the outer script when being sourced
  [ "$IS_SOURCED" == "true" ] && return 1
fi

os=$(uname -s | tr '[:upper:]' '[:lower:]')
who="you are a $SHELL shell command generator for $os"
what="respond ONLY with a suitable command that can be directly evaluated in $SHELL, no explanation"

formatted=$(gpt -s "$who" -u "$what" -u "$*" | gum format)

echo "> $formatted"

# shellcheck disable=SC2001
stripped=$(echo "$formatted" | sed 's/\x1b\[[0-9;]*m//g') || true                                                 # remove ANSI color codes
stripped=$(echo -e "$stripped" | awk 'BEGIN {RS = ""; ORS = ""} { gsub(/^[\n\t ]*/, "", $0); print $0 }') || true # remove leading whitespace
stripped=$(echo -e "$stripped" | awk 'BEGIN {RS = ""; ORS = ""} { gsub(/[\n\t ]*$/, "", $0); print $0 }') || true # remove trailing whitespace

if gum confirm --default="No" "Execute?"; then
  history -s "$stripped"
  eval "$stripped" || true
fi
