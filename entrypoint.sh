#!/bin/bash
set -e

pint_install_command=("composer global require laravel/pint:PINT_VERSION --no-progress --dev")

if [[ "${INPUT_PINT_VERSION}" ]]
then
 pint_install_command="${pint_install_command/PINT_VERSION/${INPUT_PINT_VERSION}}"
else
 pint_install_command="${pint_install_command/:PINT_VERSION/}"
fi

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

${pint_install_command[@]}
PATH="/tmp/vendor/bin:${PATH}"

echo "Running Command: " "${command_string[@]}"

${command_string[@]}
