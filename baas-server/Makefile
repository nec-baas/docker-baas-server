PORT_OPTS = -p 28080:8080

VOLUME_OPTS = -v $(PWD)/logs:/opt/tomcat/logs:rw

all: download api console

download:
	@./download.sh

Dockerfile.api: Dockerfile.in
	@cat Dockerfile.in | sed "s/%%SERVER_TYPE%%/api/" > Dockerfile.api

Dockerfile.console: Dockerfile.in
	@cat Dockerfile.in | sed "s/%%SERVER_TYPE%%/console/" > Dockerfile.console

api: Dockerfile.api
	docker build -t necbaas/api-server -f Dockerfile.api .

console: Dockerfile.console
	docker build -t necbaas/console-server -f Dockerfile.console .

clean:
	-/bin/rm Dockerfile.api Dockerfile.console

rmi:
	docker rmi necbaas/api-server necbaas/console-server

bash:
	docker run -it --rm necbaas/api-server /bin/bash

bash-console:
	docker run -it --rm necbaas/console-server /bin/bash

start:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) necbaas/api-server

start-console:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) necbaas/console-server
