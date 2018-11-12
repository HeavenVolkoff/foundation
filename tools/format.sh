#! /bin/env bash

set -euo pipefail
IFS=$'\n\t'

if [[ -z ${1+x} ]]; then
  >&2 echo "Missing argument"
  exit -1
fi

for file in "$@"; do
    if [[ ! -f "$file" ]]; then
        >&2 echo "$file: Don't exist"
        exit -1
    fi

    filename="$(basename -- "$file")"
    file_ext="${filename##*.}"
    if [[ "$file_ext" == "py" ]]; then
        if ! { hash isort && hash black; }; then
            >&2 echo "Python: isort and black are not installed"
            exit -1
        fi

        formatted="$(isort -ac ${1} -d | black --config black.toml -)"
    else
        >&2 echo "$file: Don't have a recognizable extension"
        exit -1
    fi

    echo "$formatted" > "$1"
    echo "$file: Formatted"
done
