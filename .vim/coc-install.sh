#!/bin/bash

targets="coc-clangd coc-json coc-go coc-pyright coc-sh coc-tsserver coc-yaml coc-cmake coc-rust-analyzer coc-markdownlint coc-html coc-css"
vim -c ":CocInstall $targets"
