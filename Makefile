SHELL := /bin/bash

.PHONY: init
init:
	@(cd terraform; terraform init)

.PHONY: apply
apply:
	@(cd terraform; terraform apply)

.PHONY: destroy
destroy:
	@(cd terraform; terraform destroy -auto-approve)
