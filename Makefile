# Setup options
empty           :=

region          ?= us-east-2
profile         ?= contino-mikey
cli_opts        ?= --profile $(profile) --region $(region)

template        ?= ./cloudformation/tc_apigateway.yaml
stack_name      ?= tc-apigateway-stack-$(shell date +%Y%m%d%H%M%S)
capabilities    ?= CAPABILITY_IAM

subcommand_opts ?= --stack-name $(stack_name) --template-file $(template) --capabilities $(capabilities)

deploy_opts     := -c '$(cli_opts)' -s '$(subcommand_opts)'

deploy:
	./scripts/deploy $(deploy_opts)
