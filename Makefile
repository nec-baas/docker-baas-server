subdirs := openjdk tomcat baas-server

.PHONY: all $(subdirs)

all: $(subdirs)

$(subdirs):
	$(MAKE) -C $@
