# Migration guide from v1 to v2

Hello there!

I am so happy to see you here and are interested in using the new version of tmux-gruvbox theme.

I really try to do all my best giving you new, interesting features that you probably always wanted to have.

In here I also wanted to thank you all people involved in contributing to this theme 🙏🙇. Especially for adding all suggestions, or reporting problems if they occurred - this helped a lot!

## What's new?

There are couple of great things ahead:

- new themes supporting 16-bit color palette
- new fully customizable spaces A, X, Y, Z for your disposal
- support for transparency (experimental)
- and many more

See what's new in [CHANGELOG][docs-changelog].

## Breaking changes

I planned to have best possible user experience between migrating from v1 and v2, therefore tried to build new changes this way to keep the breaking changes as low as possible. This was not ideal, although I believe for many this would not require many changes and for some none.

### Theme names changes

|         v1          |     v2     | description                                                             |
| :-----------------: | :--------: | ----------------------------------------------------------------------- |
|       `dark`        | `dark256`  | 256-colors theme                                                        |
|       `light`       | `light256` | 256-colors theme                                                        |
| `dark-transparent`  |     ∅      | set `dark` or `dark256` theme and add `@tmux-gruvbox-statusbar-alpha`   |
| `light-transparent` |     ∅      | set `light` or `light256` theme and add `@tmux-gruvbox-statusbar-alpha` |

In v2 we've introduced a 16-bit color themes that should give the users more happiness utilizing a greater amount of supported colors (full gruvbox palette).

Therefore in v2 themes `light` & `dark` has been simply renamed and `256` postfix has been added to indicate used palette. In v2 `light` & `dark` themes will be refering to 16-bit versions.

> [!NOTE]
> While implementing 16-bit colors I realized that many users (including me) had problems with setting up correct the color interpretation in their workspace to support multiple colors.
>
> Here is the page [True Color (24-bit) and italics with alacritty + tmux + vim (neovim)][github-gist-andersevenrud-alacritty-tmux-vim-truecolor] where I found great wisdom how to adjust my terminal, especially when used alacritty, tmux & neovim.

### Fallback theme name

|   v1   |    v2     |
| :----: | :-------: |
| `dark` | `dark256` |

Continuing topic of introducing 16-bit colors, we have make slight change in fallback theme name. We love idea adding new colors to our theme, although during those changes we cannot forget about users whose terminals might not support more then basic 256 colors. Therefore the fallback theme name also has to be adapted and in v2 it's `dark256`.

## FAQ

### Plugin not upgrading automatically with tmux update

Error ([source](https://github.com/egel/tmux-gruvbox/issues/21#issuecomment-2373794273)):

```
"tmux-gruvbox" update fail
    | fatal: couldn't find remote ref refs/heads/master
```

Solution:

We recently migrate from `master` to `main` as the primary branch, therefore tmux plugin manager using old reference to master and it's not possible to pull.

The simplest way would be to:

1. remove the plugin `rm -rf ~/.tmux/plugins/tmux-gruvbox`
2. and reinstall it again via tpm key-binding `<prefix>` + `I`.

[docs-changelog]: ../CHANGELOG.md
[github-gist-andersevenrud-alacritty-tmux-vim-truecolor]: https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
