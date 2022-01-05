GOROOT?=/usr/local/go
GOBIN?=go

moduleName:=$(shell head -n 1 go.mod | awk '{print $$2}')
GOMODCACHE:=$(shell $(GOBIN) env GOMODCACHE)

run:
	bin/app
build:
	$(GOBIN) build -o ./bin/app $(moduleName)/src