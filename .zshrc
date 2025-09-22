if [[ -f $HOME/.profile ]]; then
    source $HOME/.profile
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


case "$(uname -s)" in
    Darwin)
        HOMEBREW_PREFIX=$(brew --prefix)
        source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh

        zstyle ':omz:lib:theme-and-appearance' gnu-ls yes
        if type brew &>/dev/null; then
          FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
        fi
        unset HOMEBREW_PREFIX
        ;;

    Linux)
        source '/usr/share/zsh-antidote/antidote.zsh'
        ;;

    *)
        ;;
esac

antidote load

setopt autocd
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# SSH agent
env=$HOME/.ssh/agent.env


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

