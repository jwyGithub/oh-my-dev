# my development configuration

## CentOS

```sh
wget -O- https://cdn.jsdelivr.net/gh/jwyGithub/oh-my-dev/centos/repo.sh | sh
```

## zsh

1. append alias to ~/.zshrc

```sh
echo "$(curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/alias.zsh)" >> ~/.zshrc
```

2. append proxy to ~/.zshrc

> macos

```sh
echo "$(curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/proxy/macos.zsh)" >> ~/.zshrc
```

> linux

```sh
echo "$(curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/proxy/linux.zsh)" >> ~/.zshrc
```

3. append theme to ~/.oh-my-zsh/themes/

```sh
curl -O https://raw.githubusercontent.com/jwyGithub/oh-my-dev/main/zsh/theme/jwy.zsh-theme
mv jwy.zsh-theme ~/.oh-my-zsh/themes/
```

4. set theme ~/.zshrc

```sh
vim ~/.zshrc
ZSH_THEME="jwy"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

zsh-autosuggestions
zsh-syntax-highlighting
```

5. load ~/.zshrc

```sh
source ~/.zshrc
```

## VPS

-   更换 bbr plus

```sh
wget https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/bbrplus/centos/7/kernel-4.14.129-bbrplus.rpm
yum -y install kernel-4.14.129-bbrplus.rpm
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg
sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /boot/efi/EFI/centos/grub.cfg
grub2-set-default 0
reboot
```

```sh
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```

> 选择 7 选择 10 Y

```sh
sysctl net.ipv4.tcp_available_congestion_control
```

-   安装证书

```sh
yum install -y socat
curl https://get.acme.sh | sh
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --register-account -m XXXX@XXX.com
~/.acme.sh/acme.sh  --issue -d XXX.XXX   --standalone
~/.acme.sh/acme.sh --installcert -d xxx.xxx --key-file ~/x-ui/cert/private.key --fullchain-file ~/x-ui/cert/cert.crt
```

-   安装 docker

```sh
curl -fsSL https://get.docker.com | sh
yum install docker-compose -y
systemctl start docker
mkdir x-ui && cd x-ui
wget https://raw.githubusercontent.com/Chasing66/beautiful_docker/main/x-ui/docker-compose.yml
vim ./docker-compose.yml
3.9 > 3.3
docker-compose up -d
```

-   开启防火墙

```
systemctl start firewalld.service
```

-   开机自启

```sh
systemctl enable firewalld.service
```

-   开放端口

```sh
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=54321/tcp --permanent
```

-   重启防火墙

```sh
systemctl restart firewalld.service
```

-   查看开放的端口

```sh
firewall-cmd --list-ports
```

-   重新注册证书

```sh
~/.acme.sh/acme.sh --renew -d xx.xxx --force
~/.acme.sh/acme.sh --installcert -d xx.xx --key-file ~/x-ui/cert/private.key --fullchain-file ~/x-ui/cert/cert.crt
```
