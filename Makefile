.PHONY: check-scripts
check-scripts:
	# Fail if any of these files have warnings
	shellcheck ./gruvbox-tmp.tmux
