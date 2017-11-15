
source "$HOME/.config/fish/aliases.fish"

set -gx fish_greeting ''

set -gx EDITOR emacs
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx GREP_COLOR "1;37;45"


# This is how we add bin dirs to the $PATH
test -d ~/.cabal/bin ; and set PATH ~/.cabal/bin $PATH


function fish_user_key_bindings
    bind \ec append-copy
    bind \ep prepend-paste
    bind \ev prepend-vim
    bind \ey 'commandline -b | pbcopy'
    bind \e'>' 'commandline -a -- "| shiftr"'
    bind \e'<' 'commandline -a -- "| shiftl"'
    bind \es 'git st'
    bind \ed 'git di'
    bind \ex 'git x'
end


if status --is-login
    . ~/.config/fish/env.fish
end


# This allows quick cd'ing to some subdirectories
if status --is-interactive
    set CDPATH . ~/Projects/private
end


set -gx __fish_initialized 1

eval (direnv hook fish)


source "$HOME/.homesick/repos/homeshick/homeshick.fish"

source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
