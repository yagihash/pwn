TAG ?= pwn
NAME ?= pwn-$(shell date +%s | shasum | fold -w 8 | head -1)

.PHONY: build
build:
	docker build -t $(TAG) .

.PHONY: run
run:
	@ docker run -itd --name $(NAME) pwn:latest /bin/sh > /dev/null
	docker exec -it $(NAME) /bin/bash
	@ docker stop $(NAME) > /dev/null
