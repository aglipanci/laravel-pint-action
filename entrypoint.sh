#!/bin/bash
set -e

# Install Pint
pint_install_command=("composer global require laravel/pint:PINT_VERSION --no-progress --dev")
if [[ "${INPUT_PINTVERSION}" ]]
then
 pint_install_command="${pint_install_command/PINT_VERSION/${INPUT_PINTVERSION}}"
elif  [[ "${INPUT_USECOMPOSER}" ]]
then
 pint_install_command="${pint_install_command/PINT_VERSION/$(composer show --locked | grep 'laravel/pint' | awk '{print $2}')}"
else
 pint_install_command="${pint_install_command/:PINT_VERSION/}"
fi

echo "Running Command: " "${pint_install_command[@]}"
${pint_install_command[@]}
PATH="/tmp/vendor/bin:${PATH}"

# Get version after installation
pint_version=$(pint --version | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
version_check=$(printf '%s\n1.23' "$pint_version" | sort -V | head -1)

# Build command with consistent array syntax
pint_command=("pint")
if [[ "${INPUT_TESTMODE}" == true ]]; then
  pint_command+=("--test")
fi

if [[ "${INPUT_VERBOSEMODE}" == true ]]; then
  pint_command+=("-v")
fi

if [[ "${INPUT_CONFIGPATH}" ]]; then
  pint_command+=("--config" "${INPUT_CONFIGPATH}")
fi

if [[ "${INPUT_PRESET}" ]]; then
  pint_command+=("--preset" "${INPUT_PRESET}")
fi

if [[ "${INPUT_ONLYDIFF}" ]]; then
  pint_command+=("--diff=${INPUT_ONLYDIFF}")
fi

if [[ "${INPUT_ONLYDIRTY}" == true ]]; then
  pint_command+=("--dirty")
fi

if [[ "${INPUT_PARALLEL}" == true ]]; then
  if [[ "$version_check" == "1.23" ]]; then
    pint_command+=("--parallel")
    echo "Parallel mode enabled (Pint version: $pint_version)"
  else
    echo "Warning: Parallel mode requested but Pint version $pint_version < 1.23. Skipping --parallel flag."
  fi
fi

echo "Running Command: " "${pint_command[@]}"
"${pint_command[@]}"