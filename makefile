VERSION     = 7.2-1.0.0
PROJECT     = php
REGISTRY_URL = arvintian

build:
	docker build -t $(REGISTRY_URL)/$(PROJECT):$(VERSION) .

publish: build
	docker push $(REGISTRY_URL)/$(PROJECT):$(VERSION)

dev:
	docker run --name php-dev -it --rm -p 6000:80 -v `pwd`:/var/www/html $(REGISTRY_URL)/$(PROJECT):$(VERSION)
