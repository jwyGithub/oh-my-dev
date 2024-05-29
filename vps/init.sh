function install_pkg(){
    dnf install -y python3-librepo
    dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
    dnf update -y
    dnf makecache
}


function install_pkg_7(){
    yum update -y
    yum makecache
}



function firewall(){
    systemctl start firewalld.service
    systemctl enable firewalld.service

    firewall-cmd --zone=public --add-port=22/tcp --permanent
    firewall-cmd --zone=public --add-port=54321/tcp --permanent
    firewall-cmd --zone=public --add-port=9000-9999/tcp --permanent

    systemctl restart firewalld.service
    firewall-cmd --list-ports
}


function main(){
    local $os_version=$(rpm -E %{rhel})
    if [[ "$os_version" == "8" ]]; then
        install_pkg
    else
        install_pkg_7
    fi

    firewall
}


main
