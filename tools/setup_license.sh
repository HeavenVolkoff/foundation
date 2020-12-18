#!/usr/bin/env bash

# Command Interpreter Configuration
set -e          # exit immediate if an error occurs in a pipeline
set -u          # don't allow not set variables to be utilized
set -o pipefail # trace ERR through pipes
set -o errtrace # trace ERR through 'time command' and other functions

echo "{% if cookiecutter.project_license == \"NOT_USED\" -%}"
curl -LSs https://github.com/spdx/license-list-data/raw/master/jsonld/licenses.jsonld |
    jq -r '.["@graph"] | map(select((.isFsfLibre == "true" or .isOsiApproved == "true") and (.isDeprecatedLicenseId == null or .isDeprecatedLicenseId == "false"))) | .[] | "{% elif cookiecutter.project_license == \"\(.licenseId)\" -%}\n\(.licenseText)"'
echo "{% endif -%}"
