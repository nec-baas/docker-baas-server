NAME = necbaas/openjdk

all: image

Dockerfile: Dockerfile.in
	@if [ -n "$(http_proxy)" ]; then \
	    cat Dockerfile.in | sed "s|%%PROXY_URL%%|$(http_proxy)|" > Dockerfile; \
	else \
	    grep -v "# proxy" Dockerfile.in > Dockerfile; \
	fi

image: Dockerfile
	docker build -t $(NAME) .

clean:
	-/bin/rm Dockerfile

rmi:
	docker rmi $(NAME)

bash:
	docker run -it --rm $(NAME) /bin/bash

start:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME)

push:
	docker push $(NAME)
