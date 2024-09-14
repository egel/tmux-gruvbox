.PHONY: lint_shellcheck
lint_shellcheck:
	find . -type f -not -path "./uncommited/*" -a \( -iname "*.sh" \) | \
	xargs -I % sh -c 'shellcheck %'

.PHONY: lint_shfmt
lint_shfmt:
	find . -type f -not -path "./uncommited/*" -a \( -iname "*.sh" \) | \
	xargs -I % sh -c 'shfmt -i=2 -l -d -ln=bash %'

.PHONY: check_scripts
check_scripts: lint_shellcheck lint_shfmt
