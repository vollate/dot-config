if [[ -f $HOME/.profile.local ]]; then
	source $HOME/.profile.local
fi

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [[ ! "$SSH_AUTH_SOCK" ]] || [[ $agent_run_state = 2 ]]; then
    agent_start
    for key in "${SSH_KEYCHAIN[@]}"; do
        ssh-add "$key" &>/dev/null
    done
elif [[ "$SSH_AUTH_SOCK" ]] && [[ $agent_run_state = 1 ]]; then
    for key in "${SSH_KEYCHAIN[@]}"; do
        ssh-add "$key" &>/dev/null
    done
fi

unset -f agent_load_env agent_start
unset SSH_KEYCHAIN
