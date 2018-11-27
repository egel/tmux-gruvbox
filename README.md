# Gruvbox color theme configuration for Tmux

Theme with 'retro groove' flavor for [Tmux][github-tmux], based on Pavel Pertsev's [gruvbox colorscheme][github-grovbox] and inspired by work of [Gordon Chiam](https://gist.github.com/gchiam/4606522f513cc64b79ce).

> Screenshot made from Mac OSX builtin terminal with xterm-256color and [Hack font][github-hack].

<img src="http://i.imgur.com/OqnVzqf.png" title="Tmux grovbox colorscheme" style="width: 100%; max-width: 600px; text-align: center;" />


## Installation
### Install manually
The simplest way is just:

> HINT: Always make a backup of your config files before any action.

```bash
cat tmux-gruvbox-dark.conf >> ~/.tmux.conf
```

### Install through [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
Add plugin to the list of TPM plugins in `.tmux.conf`
```
set -g @plugin 'egel/tmux-gruvbox'
```
Hit `prefix + I` to fetch the plugin and source it.
Your tmux should be updated with the theme at this point.

## License
GPLv3 - Maciej Sypień

[github-tmux]: https://github.com/tmux/tmux
[github-grovbox]: https://github.com/morhetz/gruvbox
[github-hack]: https://github.com/chrissimpkins/Hack

