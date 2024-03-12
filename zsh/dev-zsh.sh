#!/bin/bash

# 定义高亮输出函数
highlight_echo() {
    echo -e "\e[1;32m$1\e[0m"
}

# 定义新的主题值
jwy_theme='ZSH_THEME="jwy"'

# 设置 .zshrc 文件路径
zshrc_file="$HOME/.zshrc"

# 直接替换 .zshrc 文件中的 ZSH_THEME 行为新值
sed -i "/^ZSH_THEME=/c\\$jwy_theme" "$zshrc_file"

highlight_echo "已更新 .zshrc 文件中的 ZSH_THEME 为 jwy"

# 使用 curl 下载主题文件并移动到 oh-my-zsh 的主题目录
curl -s -o ~/.oh-my-zsh/themes/jwy.zsh-theme https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/theme/jwy.zsh-theme

highlight_echo "已下载并移动 jwy 主题文件到 ~/.oh-my-zsh/themes/"

# 使用 curl 下载别名配置文件并追加到 .zshrc 文件
curl -s https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/alias.zsh >> ~/.zshrc

highlight_echo "已追加别名配置到 .zshrc 文件"

# 下载 zsh 插件 zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

highlight_echo "已下载 zsh-syntax-highlighting 插件到 ~/.oh-my-zsh/custom/plugins/"

sleep 1

# 下载 zsh 插件 zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

highlight_echo "已下载 zsh-autosuggestions 插件到 ~/.oh-my-zsh/custom/plugins/"

sleep 1

# 修改 .zshrc 中的插件值
sed -i 's/^plugins=(/plugins=(zsh-syntax-highlighting zsh-autosuggestions /' "$zshrc_file"

highlight_echo "已修改 .zshrc 文件中的插件列表"

# 立即生效 .zshrc 文件的修改
source "$zshrc_file"

highlight_echo "已重新加载 .zshrc 文件"
