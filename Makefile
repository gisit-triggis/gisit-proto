SHELL := /bin/bash

PROTO_DIR := shared

GO_OUT_DIR := gen/go
PHP_OUT_DIR := gen/php
PY_OUT_DIR := gen/python

GOPATH := $(shell go env GOPATH)

PROTOC_GEN_GO := $(GOPATH)/bin/protoc-gen-go
PROTOC_GEN_GO_GRPC := $(GOPATH)/bin/protoc-gen-go-grpc
GRPC_PHP_PLUGIN := $(shell which grpc_php_plugin || echo "")
PYTHON_PROTOC := $(shell which python3 || which python)
VENV_DIR := .venv
PYTHON := $(VENV_DIR)/bin/python
PIP := $(VENV_DIR)/bin/pip

.PHONY: all protoc-go protoc-php protoc-python deps-go deps-python deps-php deps clean venv commit

all: protoc-go protoc-php protoc-python

protoc-go:
	@echo "Генерация Go кода..."
	mkdir -p $(GO_OUT_DIR)
	PATH=$(GOPATH)/bin:$$PATH find $(PROTO_DIR) -name "*.proto" -exec protoc \
		--proto_path=$(PROTO_DIR) \
		--go_out=$(GO_OUT_DIR) --go_opt=paths=source_relative \
		--go-grpc_out=$(GO_OUT_DIR) --go-grpc_opt=paths=source_relative \
		--experimental_allow_proto3_optional \
		{} \;

protoc-php:
	@echo "Генерация PHP кода..."
	mkdir -p $(PHP_OUT_DIR)
	find $(PROTO_DIR) -name "*.proto" -exec protoc \
		--proto_path=$(PROTO_DIR) \
		--php_out=$(PHP_OUT_DIR) \
		--grpc_out=$(PHP_OUT_DIR) --plugin=protoc-gen-grpc=$(shell which grpc_php_plugin) \
		--experimental_allow_proto3_optional \
		{} \;

protoc-python: venv
	@echo "Generating Python code..."
	mkdir -p $(PY_OUT_DIR)
	find $(PROTO_DIR) -name "*.proto" -exec $(PYTHON) -m grpc_tools.protoc \
		--proto_path=$(PROTO_DIR) \
		--python_out=$(PY_OUT_DIR) \
		--grpc_python_out=$(PY_OUT_DIR) \
		{} \;

clean:
	rm -rf $(GO_OUT_DIR) $(PHP_OUT_DIR) $(PY_OUT_DIR)

deps: deps-go deps-php deps-python

deps-go:
	@echo "Проверка Go плагинов..."
	@if [ ! -f $(PROTOC_GEN_GO) ]; then \
		echo "Установка protoc-gen-go..."; \
		go install google.golang.org/protobuf/cmd/protoc-gen-go@latest; \
	fi
	@if [ ! -f $(PROTOC_GEN_GO_GRPC) ]; then \
		echo "Установка protoc-gen-go-grpc..."; \
		go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest; \
	fi

deps-php:
	@echo "Проверка PHP плагинов..."
	@if [ -z "$(GRPC_PHP_PLUGIN)" ]; then \
		echo "Ошибка: grpc_php_plugin не найден в PATH."; \
		exit 1; \
	fi

deps-python: venv
	@echo "Проверка Python плагинов..."
	@$(PIP) show grpcio-tools > /dev/null 2>&1 || $(PIP) install grpcio grpcio-tools

venv:
	@if [ ! -d "$(VENV_DIR)" ]; then \
		echo "Создание Python venv..."; \
		python -m venv $(VENV_DIR); \
	fi

commit:
	@git add .
	@git commit -m "fix"
	@git push