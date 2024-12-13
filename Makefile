export REGISTRY := ghcr.io/deepshore
export BUNDLE_IMAGE_BASE := chirpstack-operator-bundle
export TEMPLATE_FILE := catalog-template.yaml
export DOCKER_IMAGE := ${REGISTRY}/${BUNDLE_IMAGE_BASE}

version:
	mkdir -p version

version/%: version
	@sh script/update-catalog.sh "$(@F)"

build-catalog-image:
	@sh script/build-catalog-image.sh
