## ali's dotfiles

## Install
`rake` or `rake install` or `rake all:install`

## Uninstall

`rake uninstall`

## Features

### Local Overrides
For shell configurations, aliases and scripts it also provides the concept of `.local`. This way you can create local content unique to your specific system while offloading the bulk of the work to the core configuration. If you're running on a Raspberry Pi add some Rasbian specific settings in `~/.bashrc.local`. If you've got a script that only works from box with specific credentials toss it in `~/.bin.local`.

#### Shell Config Loading

##### ZSH
```
  (system) -> .zshenv
  (system) -> .zshrc
    (zshrc) -> .zshrc.local (if you created it)
    (zshrc) -> .aliases_shared
    (zshrc) -> .zsh_aliases
    (zshrc) -> .aliases_shared.local (if you created it)
    (zshrc) -> .zsh_aliases.local (if you created it)
```

##### BASH
```
  (system) -> .bashrc
    (bashrc) -> .bashrc.local (if you created it)
    (bashrc) -> .aliases_shared
    (bashrc) -> .bash_aliases
    (bashrc) -> .aliases_shared.local (if you created it)
    (bashrc) -> .bash_aliases.local (if you created it)
```

### Tmuxline
This uses [tmuxline.vim](https://github.com/edkolev/tmuxline.vim). Tmuxline can be used to match against [vim-airline](https://github.com/vim-airline/vim-airline), [powerline](https://github.com/powerline/powerline), [vim-lightline](https://github.com/itchyny/lightline.vim) or any other certain type of status line. Currently this defaults to the style of the normal vim status line, but you can use another status line in your `.vimrc.local` and create a `.tmuxline.conf.local` which will be referenced instead to make a tmux status line that matches a vim one.

## Additional setup

### fzf key bindings
To enable fuzzy completion (e.g. `cd **<TAB>`, `kill -9 <TAB>`, `ssh **<TAB>`) after installing via homebrew: `$(brew --prefix)/opt/fzf/install`
