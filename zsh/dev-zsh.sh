#!/bin/bash

# 定义高亮输出函数
highlight_echo() {
    printf "\033[1;32m%s\033[0m\n" "$1"
}

# 定义新的主题值
jwy_theme='ZSH_THEME="jwy"'

# 设置 .zshrc 文件路径
zshrc_file="$HOME/.zshrc"

# 检查 .zshrc 文件是否存在
if [ ! -f "$zshrc_file" ]; then
    highlight_echo "错误: 未找到 $zshrc_file 文件。请确保已安装 oh-my-zsh。"
    exit 1
fi

# 备份 .zshrc 文件
cp "$zshrc_file" "${zshrc_file}.backup"
highlight_echo "已创建 .zshrc 备份文件: ${zshrc_file}.backup"

# 直接替换 .zshrc 文件中的 ZSH_THEME 行为新值 (兼容不同系统的 sed)
sed -i.bak "/^ZSH_THEME=/c\\$jwy_theme" "$zshrc_file" && rm -f "${zshrc_file}.bak"

highlight_echo "已更新 .zshrc 文件中的 ZSH_THEME 为 jwy"

# 使用 curl 下载主题文件并移动到 oh-my-zsh 的主题目录
if ! curl -s -o ~/.oh-my-zsh/themes/jwy.zsh-theme https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/theme/jwy.zsh-theme; then
    highlight_echo "错误: 下载主题文件失败。请检查网络连接或 GitHub 可访问性。"
    exit 1
fi

highlight_echo "已下载并移动 jwy 主题文件到 ~/.oh-my-zsh/themes/"

# # 使用 curl 下载别名配置文件并追加到 .zshrc 文件
# curl -s https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/alias.zsh >> ~/.zshrc

# 创建 ~/.zsh_functions 目录（如果不存在）
mkdir -p ~/.zsh_functions

# 添加functions目录的文件
highlight_echo "正在下载函数文件到 ~/.zsh_functions/ 目录..."
curl -s https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/functions/common.zsh > ~/.zsh_functions/common.zsh
curl -s https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/functions/git.zsh > ~/.zsh_functions/git.zsh
curl -s https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/functions/maven.zsh > ~/.zsh_functions/maven.zsh
curl -s https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/functions/node.zsh > ~/.zsh_functions/node.zsh
curl -s https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/functions/python.zsh > ~/.zsh_functions/python.zsh
curl -s https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/functions/ruby.zsh > ~/.zsh_functions/ruby.zsh

# 确保 .zshrc 中加载这些函数文件
if ! grep -q "source ~/.zsh_functions/" "$zshrc_file"; then
    echo '# 加载自定义函数' >> "$zshrc_file"
    echo 'for file in ~/.zsh_functions/*.zsh; do' >> "$zshrc_file"
    echo '    source "$file"' >> "$zshrc_file"
    echo 'done' >> "$zshrc_file"
    highlight_echo "已添加函数文件加载配置到 .zshrc"
fi

# 下载 zsh 插件 zsh-syntax-highlighting
highlight_echo "正在下载 zsh-syntax-highlighting 插件..."
if [ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    highlight_echo "zsh-syntax-highlighting 插件已存在，跳过下载"
else
    if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting; then
        highlight_echo "警告: 下载 zsh-syntax-highlighting 插件失败。请手动安装。"
    else
        highlight_echo "已下载 zsh-syntax-highlighting 插件"
    fi
fi

sleep 1

# 下载 zsh 插件 zsh-autosuggestions
highlight_echo "正在下载 zsh-autosuggestions 插件..."
if [ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    highlight_echo "zsh-autosuggestions 插件已存在，跳过下载"
else
    if ! git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions; then
        highlight_echo "警告: 下载 zsh-autosuggestions 插件失败。请手动安装。"
    else
        highlight_echo "已下载 zsh-autosuggestions 插件"
    fi
fi

sleep 1

# 修改 .zshrc 中的插件值 (更安全的方式)
if grep -q "^plugins=(" "$zshrc_file"; then
    # 检查插件是否已经存在
    if ! grep -q "plugins=(.*zsh-syntax-highlighting.*zsh-autosuggestions.*)" "$zshrc_file"; then
        # 备份当前插件行
        plugins_line=$(grep "^plugins=(" "$zshrc_file")
        # 提取现有插件
        existing_plugins=$(echo "$plugins_line" | sed 's/^plugins=(//' | sed 's/)$//')
        # 检查是否已包含我们要添加的插件
        if ! echo "$existing_plugins" | grep -q "zsh-syntax-highlighting"; then
            existing_plugins="$existing_plugins zsh-syntax-highlighting"
        fi
        if ! echo "$existing_plugins" | grep -q "zsh-autosuggestions"; then
            existing_plugins="$existing_plugins zsh-autosuggestions"
        fi
        # 更新插件行
        sed -i.bak "s/^plugins=(.*)/plugins=($existing_plugins)/" "$zshrc_file" && rm -f "${zshrc_file}.bak"
        highlight_echo "已修改 .zshrc 文件中的插件列表"
    else
        highlight_echo "插件已存在于 .zshrc 中，无需修改"
    fi
else
    echo 'plugins=(git zsh-syntax-highlighting zsh-autosuggestions)' >> "$zshrc_file"
    highlight_echo "已添加插件配置到 .zshrc"
fi

highlight_echo "配置完成！请执行以下命令应用更改: source ~/.zshrc"
highlight_echo "或者重新打开终端使更改生效"

exec zsh
