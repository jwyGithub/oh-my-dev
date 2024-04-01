# proxy
export hostip='127.0.0.1'
alias proxy='export https_proxy="http://${hostip}:7890";export http_proxy="http://${hostip}:7890";'
alias unproxy='export https_proxy="";export http_proxy=""'

# terminal
alias cl="clear"
alias lzshrc="source ~/.zshrc"


# ipenv函数用于获取网络接口的IP地址。如果没有参数，它将显示主网络接口的IPv4地址。
# 如果第一个参数是"-all"，它将显示所有网络接口的IPv4地址。
# 如果第一个参数是"-all"并且第二个参数是"--ipv6"，它将显示所有网络接口的IPv4和IPv6地址。
ipenv() {
    if [ "$1" = "-all" ]
    then
        if [ "$2" = "--ipv6" ]
        then
            # 显示所有网络接口的IPv4和IPv6地址
            ifconfig | grep inet | awk '{print $2}'
        else
            # 显示所有网络接口的IPv4地址
            ifconfig | grep inet | grep -v inet6 | grep -v 127.0.0.1 | awk '{print $2}'
        fi
    else
        # 显示主网络接口的IPv4地址
        ipconfig getifaddr en0
    fi
}

zipDir() {
    if [ $# -ne 2 ]
    then
        echo "Usage: zipDir <directory> <zipfile>"
        return 1
    fi

    zip -r $2 $1
}
