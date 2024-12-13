#!/bin/sh

VERSION="$1" && test -n "${VERSION}" &&
echo -n "${VERSION}" | egrep '^v[0-9]+\.[0-9]+\.[0-9]+$$' 1>/dev/null 2>/dev/null &&
git describe --always --dirty | egrep '^[0-9a-f]{7}$' &&
{
  {
    yq -i '.Candidate.Bundles = .Candidate.Bundles + [{ "Image": "'"${DOCKER_IMAGE}:${VERSION}"'" }]' \
      ${TEMPLATE_FILE} &&
    touch version/${VERSION} &&
    git add version/${VERSION} &&
    git add catalog-template.yaml &&
    git commit -m "Adding operator version ${VERSION}"
  } ||
  {
    rm version/${VERSION}
    git reset --hard
    exit 1
  }
}
