#!/bin/bash


# 安装软件包
function install_pkg() {
    local os_version=$(rpm -E %{rhel})

    for package in "$@"; do
        if [[ "$os_version" == "8" ]]; then
            sudo dnf install -y "$package"
        else
            sudo yum install -y "$package"
        fi
    done
}

# 错误处理函数
function handle_error() {
    local exit_code="$1"
    local error_message="$2"
    echo "错误：$error_message"
    exit "$exit_code"
}

# 检查是否已安装 docker
function install_docker() {
    if ! command -v docker &> /dev/null; then
        echo "Docker 未安装，开始安装..."
        curl -fsSL https://get.docker.com | sh || handle_error 1 "安装 Docker 失败"
    else
        echo "Docker 已安装，跳过安装过程。"
    fi
}

# 检查是否已安装 docker-compose
function install_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        echo "Docker Compose 未安装，开始安装..."
        dnf -y install --nobest docker-ce
        curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        mv /usr/local/bin/docker-compose /usr/bin/docker-compose
        chmod +x /usr/bin/docker-compose || handle_error 1 "安装 Docker Compose 失败"
    else
        echo "Docker Compose 已安装，跳过安装过程。"
    fi
}

# 主函数
function main() {
    install_docker
    install_docker_compose
    echo "Docker 和 Docker Compose 已安装完毕！"
}

# 调用主函数
main
