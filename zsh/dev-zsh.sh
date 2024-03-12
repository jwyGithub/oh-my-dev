#!/bin/bash

# 定义新的主题值
jwy_theme='ZSH_THEME="jwy"'

# 设置 .zshrc 文件路径
zshrc_file="$HOME/.zshrc"

# 使用 sed 命令将匹配到的行替换为新值
sed -i "s/^ZSH_THEME=.*/$jwy_theme/" "$zshrc_file"
