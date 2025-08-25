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
        export HOMEBREW_PREFIX=$(brew --prefix)
        source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh

        zstyle ':omz:lib:theme-and-appearance' gnu-ls yes
        if type brew &>/dev/null; then
          FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
        fi
        ;;

    Linux)
        # TODO!: fix linux
        #if command -v dircolors >/dev/null 2>&1; then
            #eval "$(dircolors -b)"
        #fi
        #alias ls='ls --color=auto'
        ;;

    *)
        # 兼容其他操作系统的通用配置，或者不设置
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

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [[ ! "$SSH_AUTH_SOCK" ]] || [[ $agent_run_state = 2 ]]; then
    agent_start
    ssh-add $VKEY&>/dev/null
    ssh-add $GIT_WOA&>/dev/null
elif [[ "$SSH_AUTH_SOCK" ]] && [[ $agent_run_state = 1 ]]; then
    ssh-add $VKEY&>/dev/null
    ssh-add $GIT_WOA&>/dev/null
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


