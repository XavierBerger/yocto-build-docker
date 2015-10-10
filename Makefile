IMAGE_NAME=juniorz/yocto-edison-builder

default:
	docker build -t $(IMAGE_NAME) .

build:
	docker run $(IMAGE_NAME)

run:
	docker run -i -t $(IMAGE_NAME) bash