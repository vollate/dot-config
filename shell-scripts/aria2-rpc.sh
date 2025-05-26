#!/bin/env zsh

download_dir="$HOME/Downloads"
config_dir="$HOME/.config/aria2"
store_dir="$HOME/.local/share/aria2"
config_file="${config_dir}/aria2.conf"
session_file="${store_dir}/aria2.session"
log_file="${store_dir}/aria2.log"

if [ ! -f ${session_file} ]; then # for the first run
    touch ${session_file}
fi

ria2c --input-file=${session_file} --dir=${download_dir} --log=${log_file} --save-session=${session_file} -D
