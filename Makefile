.DEFAULT_GOAL := help

PKGS := $(shell go list ./...)
SOURCES := $(shell find . -prune -o -name "*.go" -not -name '*_test.go' -print)

.PHONY: dependency
dependency:  ## Setup for dependencies.
	go get -u golang.org/x/lint/golint
	go get -u golang.org/x/tools/cmd/goimports
	go get -u github.com/golang/protobuf/protoc-gen-go

.PHONY: proto
proto:  ## Generate go files from proto.
	protoc -I=./_proto --go_out=onnx ./_proto/onnx.proto3
	protoc -I=./_proto --go_out=onnx_ml ./_proto/onnx-ml.proto3

.PHONY: fmt
fmt: $(SOURCES) ## Formatting source codes.
	@goimports -w $^

.PHONY: lint
lint: ## Run golint and go vet.
	@golint -set_exit_status=1 $(PKGS)
	@go vet $(PKGS)

.PHONY: test
test:  ## Run tests with race condition checking.
	@go test -race ./...

.PHONY: bench
bench:  ## Run benchmarks.
	@go test -bench=. -run=- -benchmem ./...

.PHONY: coverage
cover:  ## Run the tests.
	@go test -coverprofile=coverage.o
	@go tool cover -func=coverage.o

.PHONY: generate
generate: ## Run go generate
	@go generate ./...

.PHONY: build
build: ## Build example command lines.
	./_example/build.sh

.PHONY: help
help: ## Show help text
	@echo "Commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'
