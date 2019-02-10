NAME := "bash-plus"
VERSION := $(shell git tag --points-at HEAD )

ifdef VERSION
else
  VERSION := $(shell git describe --abbrev=0 --tags)-debug
endif

.PHONY: build
build:
	# use bash-plus to build ourselves
	./bash-plus compile bash-plus > bash-plus

.PHONE: publish
publish: build
	pip install twine
	python setup.py sdist
	twine upload dist/*.tar.gz || echo already exists