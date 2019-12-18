TAG ?= pwn
NAME ?= pwn-$(shell date +%s | shasum | fold -w 8 | head -1)

.PHONY: build
build:
	docker build -t $(TAG) .

.PHONY: run
run:
	@ docker run -itd -v $(CURDIR)/workspace:/workspace -w /workspace --name $(NAME) pwn:latest /bin/sh > /dev/null
	docker exec -it $(NAME) /bin/bash

.PHONY: stop
stop:
	docker stop `docker ps -aq -f ancestor=pwn`

.PHONY: rm
rm: stop
	docker rm `docker ps -aq -f ancestor=pwn`

.PHONY: clean
clean: rm
	docker rmi `docker images -aq -f label=dev.ssrf.pwn`
