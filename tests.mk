#
# See ./CONTRIBUTING.rst
#

DOCKER_TEST := docker-compose -f docker-compose.yml -f docker-compose/test.yml

test: clean
	@echo $(MESSAGE) Running tests on the current Python interpreter with coverage $(END)
	$(DOCKER_TEST) run --rm app \
		bash -c "py.test --cov lannister --cov tests --doctest-modules --verbose lannister tests";
	@echo

test.lint: clean
	pre-commit run --all-files --verbose

test.pytest: clean
	@echo $(MESSAGE) Running tests on the current Python $(END)
	@if [ "${test}" == "" ]; then \
		$(DOCKER_TEST) run --rm app \
			bash -c "py.test -s lannister tests"; \
	else \
		$(DOCKER_TEST) run --rm app \
			bash -c "py.test -s -v tests/${test}"; \
	fi
