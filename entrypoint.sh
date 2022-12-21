#!/bin/bash
set -e

command_string=("pint")

if [[ "${INPUT_TESTMODE}" ]]; then
  command_string+=" --test"
fi

if [[ "${INPUT_VERBOSEMODE}" ]]; then
  command_string+=" -v"
fi

if [[ "${INPUT_CONFIGPATH}" ]]; then
  command_string+=" --config ${INPUT_CONFIGPATH}"
fi

if [[ "${INPUT_PRESET}" ]]; then
  command_string+=" --preset ${INPUT_PRESET}"
fi

composer global require laravel/pint --no-progress --dev
PATH="/tmp/vendor/bin:${PATH}"

echo "Running Command: " "${command_string[@]}"

${command_string[@]}
