TAG ?= pwn
NAME ?= pwn-$(shell date +%s | shasum | fold -w 8 | head -1)
LABEL := dev.ssrf.pwn

.PHONY: build
build:
	docker build -t $(TAG) .

.PHONY: clean-build
clean-build:
	docker build --no-cache -t $(TAG).

.PHONY: ps
ps:
	docker ps -f label=$(LABEL)

.PHONY: run
run:
	@ docker run --privileged -itd -v $(CURDIR)/workspace:/workspace -w /workspace --name $(NAME) pwn:latest /bin/sh > /dev/null
	docker exec -it $(NAME) /bin/zsh

.PHONY: stop
stop:
	docker stop `docker ps -aq -f label=$(LABEL)`

.PHONY: clean
clean:
	docker stop `docker ps -aq -f label=$(LABEL)`
	docker rm -f `docker ps -aq -f label=$(LABEL)`
	docker rmi -f `docker images -aq -f label=$(LABEL)`
