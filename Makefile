VENV = venv
VENV_BIN = $(VENV)/bin

PIP := $(VENV_BIN)/pip3
ACTIVATE := $(VENV_BIN)/activate
ANSIBLE_PLAYBOOK := $(VENV_BIN)/ansible-playbook
ANSIBLE_GALAXY := $(VENV_BIN)/ansible-galaxy
ANSIBLE_LINT := $(VENV_BIN)/ansible-lint
PRE_COMMIT := $(VENV_BIN)/pre-commit
BLACK := $(VENV_BIN)/black

.PHONY: run
run:
	$(ANSIBLE_PLAYBOOK) -i inventory main.yml

.PHONY: lint
lint:
	$(PRE_COMMIT) run --all-files

.PHONY: fmt
fmt:
	 $(BLACK) --target-version py310 \
	 	roles/wikijs/library/wikijs_authentications.py \
		roles/wikijs/module_utils/wikijs.py

#
# Install all required dependencies.
#
deps: $(ACTIVATE)
	$(PIP) install -r requirements.txt
	$(PRE_COMMIT) install

#
# Setup virtual environment for python.
#
$(ACTIVATE):
	virtualenv $(VENV)
