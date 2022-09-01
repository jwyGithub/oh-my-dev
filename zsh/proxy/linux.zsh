# proxy
export hostip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
alias proxy='export https_proxy="http://${hostip}:7890";export http_proxy="http://${hostip}:7890";'
alias unproxy='unset all_proxy'
