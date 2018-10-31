NAME = necbaas/tomcat

all: image

image:
	docker build -t $(NAME) .

clean:

rmi:
	docker rmi $(NAME)

bash:
	docker run -it --rm $(NAME) /bin/bash

start:
	docker run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME)

push:
	docker push $(NAME)
