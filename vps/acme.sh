#!/bin/bash

# 错误处理函数
function handle_error() {
    local exit_code="$1"
    local error_message="$2"
    echo "错误：$error_message"
    exit "$exit_code"
}

# 判断是否已安装 socat
function install_socat() {
    if ! command -v socat &> /dev/null; then
        echo "socat 未安装，开始安装..."
        if [[ -f "/etc/debian_version" ]]; then
            sudo apt-get update
            sudo apt-get install -y socat || handle_error 1 "安装 socat 失败"
        elif [[ -f "/etc/redhat-release" ]]; then
            if [[ "$(rpm -E %{rhel})" == "8" ]]; then
                sudo dnf install -y socat || handle_error 1 "安装 socat 失败"
            else
                sudo yum install -y socat || handle_error 1 "安装 socat 失败"
            fi
        else
            echo "未知的 Linux 发行版，无法安装 socat。"
            exit 1
        fi
    else
        echo "socat 已安装，跳过安装过程。"
    fi
}

# 安装 acme.sh
function install_acme() {
    if ! command -v acme.sh &> /dev/null; then
        echo "acme.sh 未安装，开始安装..."
        curl https://get.acme.sh | sh || handle_error 1 "安装 acme.sh 失败"
    else
        echo "acme.sh 已安装，跳过安装过程。"
    fi
}

# 读取 env 文件中的环境变量并解析
function read_env_file() {
    if [[ -f "env" ]]; then
        while IFS= read -r line; do
            key=$(echo "$line" | cut -d '=' -f 1)
            value=$(echo "$line" | cut -d '=' -f 2)
            export "$key=$value"
            echo "$key=$value"  # 在这里输出环境变量的值
        done < "env"
        echo "从 env 文件中读取并解析环境变量。"
    else
        echo "未找到 env 文件，将使用交互式对话设置环境变量。"
        read -p "请输入 CF_Key: " CF_Key
        read -p "请输入 CF_Email: " CF_Email
        read -p "请输入 CF_Domain: " CF_Domain
        read -p "请输入 CERT_PATH: " CERT_PATH
    fi
}

# 申请证书
function issue_certificate() {
    ~/.acme.sh/acme.sh --issue --dns dns_cf -d "$CF_Domain" -d "*.$CF_Domain" --log || handle_error 1 "申请证书失败"
}

# 安装证书
function install_certificate() {
    ~/.acme.sh/acme.sh --installcert -d "$CF_Domain" -d "*.$CF_Domain" \
        --ca-file "$CERT_PATH/ca.cer" \
        --cert-file "$CERT_PATH/cert.crt" \
        --key-file "$CERT_PATH/private.key" \
        --fullchain-file "$CERT_PATH/fullchain.cer" || handle_error 1 "安装证书失败"
}

# 主函数
function main() {
    install_socat
    install_acme
    read_env_file
    issue_certificate
    install_certificate
    echo "证书已申请并安装完毕！"
}

# 调用主函数
main
