.ONESHELL:

# List of targets for clarity
.PHONY: all install install-packages activate-and-install ansible-galaxy-install

# Explicitly define default target
all: install ansible-galaxy-install

# Indent recipe lines for readability
install-packages:
	sudo apt-get install python3-pip git libffi-dev libssl-dev ansible

VENV := ./.venv/cyberrange
VENV_BIN := $(VENV)/bin
PYTHON := $(VENV_BIN)/python
PIP := $(VENV_BIN)/python -m pip

$(VENV):
	pip install virtualenv
	virtualenv $(VENV)
	$(PIP) install -r requirements.txt

activate-and-install: $(VENV)
	source $(VENV_BIN)/activate && $(PIP) install -r requirements.txt

install: create-venv  # Ensure consistent virtual environment creation

ansible-galaxy-install:
	ansible-galaxy collection install ansible.windows

# Define create-venv for consistency and reusability
create-venv: $(VENV)
