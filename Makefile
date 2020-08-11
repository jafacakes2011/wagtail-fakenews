.PHONY: build help publish publish-test
.DEFAULT_GOAL := help

help: ## See what commands are available.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36mmake %-15s\033[0m # %s\n", $$1, $$2}'

build: ## Build the package.
	@echo '== Cleanup =='
	rm dist/* 2>/dev/null || true
	@echo '== Build project =='
	python setup.py sdist

publish: build ## Publishes a new version to PyPI.
	@echo '== Publish project to PyPi =='
	twine upload dist/*
	@echo '== Success =='
	@echo 'Go to https://pypi.org/project/wagtail-fakenews/ and check that all is well.'

publish-test: build ## Publishes a new version to TestPyPI.
	@echo '== Publish project to PyPi [TEST] =='
	twine upload --repository-url https://test.pypi.org/legacy/ dist/*
	@echo '== Success =='
	@echo 'Go to https://test.pypi.org/project/wagtail-fakenews/ and check that all is well.'