#!/usr/bin/env bash

set -eu -o pipefail

if ! command gpt --help &> /dev/null; then
  echo >&2 "Error: gpt is not installed or is not on your PATH"
  echo >&2 "  - See https://github.com/sysread/bash-gpt for installation instructions"
  exit 1
fi

usage() {
  local exit_code="${1:-0}"

  cat << 'EOF'

usage: cmd <prompt>

  -h, --help    Display this help message

EOF

  exit "$exit_code"
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
fi

os=$(uname -s | tr '[:upper:]' '[:lower:]')
who="you are a $SHELL shell command generator for $os"
what="respond ONLY with a suitable command that can be directly evaluated in $SHELL, no explanation"

formatted=$(gpt -s "$who" -u "$what" -u "$*" | gum format)

echo "> $formatted"

# shellcheck disable=SC2001
stripped=$(echo "$formatted" | sed 's/\x1b\[[0-9;]*m//g')                                                 # remove ANSI color codes
stripped=$(echo -e "$stripped" | awk 'BEGIN {RS = ""; ORS = ""} { gsub(/^[\n\t ]*/, "", $0); print $0 }') # remove leading whitespace
stripped=$(echo -e "$stripped" | awk 'BEGIN {RS = ""; ORS = ""} { gsub(/[\n\t ]*$/, "", $0); print $0 }') # remove trailing whitespace

gum confirm --default="No" "Execute?" && eval "$stripped"
