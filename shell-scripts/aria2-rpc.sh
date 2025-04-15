#!/bin/env bash

aria2c --input-file=$HOME/.config/aria2/aria2.session --dir=$HOME/Downloads --log=$HOME/.config/aria2/aria2.log --save-session=$HOME/.config/aria2/aria2.session -D
