function proxy_on() {
    export {http,https,ftp}_proxy="http://127.0.0.1:${MIXIN_PROXY_PORT}"
    export {HTTP,HTTPS,FTP}_PROXY="http://127.0.0.1:${MIXIN_PROXY_PORT}"
}

function proxy_off() {
    unset {http,https,ftp}_proxy
    unset {HTTP,HTTPS,FTP}_PROXY
}

function gbc() {
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "fatal: not a git repository (or any parent up to mount point /)"
        return 1
    fi
    echo -n "Are you sure you want to delete all local merged (out of date) branches except master, main, and dev? (y/N) "
    read -r -k 1 REPLY
    if [[ "$REPLY" =~ [Yy] ]]; then
        echo "\n"
        git branch --merged | grep -Ev "(^\*|master|main|dev)" | xargs -r git branch -d
    else
        echo "\nOperation cancelled."
    fi
}

function use_clang() {
    export CC=clang
    export CXX=clang++
}

function use_gcc() {
    export CC=gcc
    export CXX=g++
}

function disable_python_venv() {
    while [[ $(which python) != '/usr/bin/python' ]]; do
        mamba deactivate || break
    done
}
