PORT_OPTS = -p 28080:8080

VOLUME_OPTS = -v $(PWD)/logs:/opt/tomcat/logs:rw

VERSION = 7.5.3

NAME_API     = necbaas/api-server:$(VERSION)
NAME_CONSOLE = necbaas/console-server:$(VERSION)
NAME_BOTH = necbaas/api-console-server:$(VERSION)

.PHONY: api console both

all: api console both

#download:
#	@./download.sh

api:
	docker image build -t $(NAME_API) -f Dockerfile.api .

console:
	docker image build -t $(NAME_CONSOLE) -f Dockerfile.console .

both:
	docker image build -t $(NAME_BOTH) -f Dockerfile.both .

rmi:
	docker image rm $(NAME_API) $(NAME_CONSOLE) $(NAME_BOTH)

bash-api:
	docker container run -it --rm $(NAME_API) /bin/bash

bash-console:
	docker container run -it --rm $(NAME_CONSOLE) /bin/bash

bash-both:
	docker container run -it --rm $(NAME_BOTH) /bin/bash

start-api:
	docker container run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME_API)

start-console:
	docker container run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME_CONSOLE)

start-both:
	docker container run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME_BOTH)

push-api:
	docker image push $(NAME_API)

push-console:
	docker image push $(NAME_CONSOLE)

push-both:
	docker image push $(NAME_BOTH)
