#!/bin/bash

# 检查是否已安装 nvm
if [ -d "$HOME/.nvm" ]; then
    echo "nvm is already installed."
    # 设置 nvm 相关环境变量和加载 nvm.sh
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # 打印当前安装的 nvm 版本信息
    nvm_version=$(nvm --version)
    echo "nvm version: $nvm_version"
    # 打印当前 nvm 安装的路径
    echo "nvm installation path: $NVM_DIR"
    exit 0
fi

# 安装 nvm
echo "nvm is not installed. Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# 设置 nvm 相关环境变量和加载 nvm.sh
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# 打印当前安装的 nvm 版本信息
nvm_version=$(nvm --version)
echo "nvm version: $nvm_version"

# 打印当前 nvm 安装的路径
echo "nvm installation path: $NVM_DIR"

# 使用 nvm 安装 Node.js 的 LTS 版本
nvm install --lts

# 打印 Node.js 版本
node_version=$(node --version)
echo "Node.js version: $node_version"

# 打印 npm 版本
npm_version=$(npm --version)
echo "npm version: $npm_version"
