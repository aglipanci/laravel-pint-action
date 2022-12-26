#!/bin/bash
set -e

pint_install_command=("composer global require laravel/pint:PINT_VERSION --no-progress --dev")

if [[ "${INPUT_PINTVERSION}" ]]
then
 pint_install_command="${pint_install_command/PINT_VERSION/${INPUT_PINTVERSION}}"
else
 pint_install_command="${pint_install_command/:PINT_VERSION/}"
fi

pint_command=("pint")

if [[ "${INPUT_TESTMODE}" == true ]]; then
  pint_command+=" --test"
fi

if [[ "${INPUT_VERBOSEMODE}" == true ]]; then
  pint_command+=" -v"
fi

if [[ "${INPUT_CONFIGPATH}" ]]; then
  pint_command+=" --config ${INPUT_CONFIGPATH}"
fi

if [[ "${INPUT_PRESET}" ]]; then
  pint_command+=" --preset ${INPUT_PRESET}"
fi

echo "Running Command: " "${pint_install_command[@]}"

${pint_install_command[@]}
PATH="/tmp/vendor/bin:${PATH}"

echo "Running Command: " "${pint_command[@]}"

${pint_command[@]}
