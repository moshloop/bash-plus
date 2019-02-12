NAME := "bash-plus"
VERSION := $(shell git tag --points-at HEAD )

ifdef VERSION
else
  VERSION := $(shell git describe --abbrev=0 --tags)-debug
endif

.PHONY: build
build:
	./bash-plus bash-plus | sponge bash-plus

.PHONY: publish
publish:
	pip install twine
	python setup.py sdist
	twine upload dist/*.tar.gz || echo already exists