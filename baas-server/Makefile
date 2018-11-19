PORT_OPTS = -p 28080:8080

VOLUME_OPTS = -v $(PWD)/logs:/opt/tomcat/logs:rw

NAME_API     = necbaas/api-server
NAME_CONSOLE = necbaas/console-server
NAME_BOTH = necbaas/api-console-server

.PHONY: download api console both

all: download api console both

download:
	@./download.sh

update: api/Dockerfile console/Dockerfile both/Dockerfile

api/Dockerfile: Dockerfile.in
	@cat Dockerfile.in | sed "s/%%SERVER_TYPE%%/api/" > api/Dockerfile

console/Dockerfile: Dockerfile.in
	@cat Dockerfile.in | sed "s/%%SERVER_TYPE%%/console/" > console/Dockerfile

both/Dockerfile: Dockerfile.in
	@cat Dockerfile.in | sed "s/%%SERVER_TYPE%%/*/" > both/Dockerfile

api:
	docker build -t $(NAME_API) -f api/Dockerfile .

console:
	docker build -t $(NAME_CONSOLE) -f console/Dockerfile .

both:
	docker build -t $(NAME_BOTH) -f both/Dockerfile .

rmi:
	docker rmi $(NAME_API) $(NAME_CONSOLE)

bash-api:
	docker run -it --rm $(NAME_API) /bin/bash

bash-console:
	docker run -it --rm $(NAME_CONSOLE) /bin/bash

bash-both:
	docker run -it --rm $(NAME_BOTH) /bin/bash

start-api:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME_API)

start-console:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME_CONSOLE)

start-both:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME_BOTH)

push-api:
	docker push $(NAME_API)

push-console:
	docker push $(NAME_CONSOLE)

push-both:
	docker push $(NAME_BOTH)
