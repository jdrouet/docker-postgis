BUILDX_VER=v0.3.1
POSTGRES_VERSION=9.6
POSTGIS_VERSION=2.3
IMAGE_TAG?=${POSTGRES_VERSION}-${POSTGIS_VERSION}
IMAGE_BASE?=jdrouet
BUILD_PLATFORM?=linux/arm/v7,linux/arm64/v8,linux/386,linux/amd64
BUILD_ARGS?=

build:
	docker buildx build ${BUILD_ARGS} \
		--build-arg OSMOSIS_VERSION=${OSMOSIS_VERSION} \
		--platform ${BUILD_PLATFORM} \
		-t ${IMAGE_BASE}/postgis:${IMAGE_TAG} \
		.

build-latest:
	docker buildx build ${BUILD_ARGS} \
		--build-arg OSMOSIS_VERSION=${OSMOSIS_VERSION} \
		--platform ${BUILD_PLATFORM} \
		-t ${IMAGE_BASE}/osmosis:${IMAGE_TAG} \
		-t ${IMAGE_BASE}/osmosis:latest \
		.

install-buildx:
	mkdir -vp ~/.docker/cli-plugins/ ~/dockercache
	curl --silent -L "https://github.com/docker/buildx/releases/download/${BUILDX_VER}/buildx-${BUILDX_VER}.linux-amd64" > ~/.docker/cli-plugins/docker-buildx
	chmod a+x ~/.docker/cli-plugins/docker-buildx
	docker buildx create --use --platform ${BUILD_PLATFORM}
	docker buildx inspect
