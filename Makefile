.PHONY: check-scripts
check-scripts:
	@# Fail if any of these files have warnings
	find . -type f -not -path "./uncommited/*" -a \( -iname "*.sh" -o -iname "*.tmux" \) | xargs -I % sh -c 'shellcheck %'
	find . -type f -not -path "./uncommited/*" -a \( -iname "*.sh" -o -iname "*.tmux" \)  | xargs -I % sh -c 'shfmt -l -d %'
