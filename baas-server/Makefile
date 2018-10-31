PORT_OPTS = -p 28080:8080

VOLUME_OPTS = -v $(PWD)/logs:/opt/tomcat/logs:rw

NAME_API     = necbaas/api-server
NAME_CONSOLE = necbaas/console-server

all: download api console

download:
	@./download.sh

Dockerfile.api: Dockerfile.in
	@cat Dockerfile.in | sed "s/%%SERVER_TYPE%%/api/" > Dockerfile.api

Dockerfile.console: Dockerfile.in
	@cat Dockerfile.in | sed "s/%%SERVER_TYPE%%/console/" > Dockerfile.console

api: Dockerfile.api
	docker build -t $(NAME_API) -f Dockerfile.api .

console: Dockerfile.console
	docker build -t $(NAME_CONSOLE) -f Dockerfile.console .

clean:
	-/bin/rm Dockerfile.api Dockerfile.console

rmi:
	docker rmi $(NAME_API) $(NAME_CONSOLE)

bash-api:
	docker run -it --rm $(NAME_API) /bin/bash

bash-console:
	docker run -it --rm $(NAME_CONSOLE) /bin/bash

start-api:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME_API)

start-console:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME_CONSOLE)

push-api:
	docker push $(NAME_API)

push-console:
	docker push $(NAME_CONSOLE)
