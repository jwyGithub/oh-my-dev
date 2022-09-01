# proxy
export hostip='127.0.0.1'
alias proxy='export https_proxy="http://${hostip}:7890";export http_proxy="http://${hostip}:7890";'
alias unproxy='export https_proxy="";export http_proxy=""'
