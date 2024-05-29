

# change_bbr
function change_bbr(){
    echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
    sysctl -p
    sysctl -n net.ipv4.tcp_congestion_control
    echo "BBR installed successfully"
    echo "Please reboot the system to apply the changes"
}


function update_bbr(){
    wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh
    wget https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/bbrplus/centos/7/kernel-4.14.129-bbrplus.rpm
    yum -y install kernel-4.14.129-bbrplus.rpm
    grub2-mkconfig -o /boot/grub2/grub.cfg
    grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg
    sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /boot/efi/EFI/centos/grub.cfg
    grub2-set-default 0
    echo "BBR installed successfully"
    echo "Please reboot the system to apply the changes"
}

function bbr(){
    local os_version=$(rpm -E %{rhel})
    if [[ "$os_version" == "8" ]]; then
        change_bbr
    else
        update_bbr
    fi
}
