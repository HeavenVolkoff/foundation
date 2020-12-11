#!/usr/bin/env bash

# Command Interpreter Configuration
set -e          # exit immediate if an error occurs in a pipeline
set -u          # don't allow not set variables to be utilized
set -o pipefail # trace ERR through pipes
set -o errtrace # trace ERR through 'time command' and other functions

curl -LSs https://github.com/spdx/license-list-data/archive/master.zip | bsdtar -xf - --strip-components 1 license-list-data-master/jsonld
trap '[ -d jsonld ] && rm -r jsonld' INT TERM EXIT
IF="if"
for file in jsonld/*; do
    [ "${file: -7}" == ".jsonld" ] || continue
    license=$(basename "$file" .jsonld)
    text="$(jq -r '.["@graph"][1] | select((.isFsfLibre == "true" or .isOsiApproved == "true") and (.isDeprecatedLicenseId == null or .isDeprecatedLicenseId == "false")) | .licenseText' "${file}")"
    [ -z "$text" ] && continue
    echo >&2 "$license"
    cat <<EOF
{% ${IF} cookiecutter.project_license == "${license}" -%}
${text}
EOF
    IF="elif"
done
echo "{% endif -%}"
