### VPS

#### centos8 stream

> bbr.sh

```sh
curl https://cdn.jsdelivr.net/gh/jwyGithub/oh-my-dev/vps/bbr.sh | sh
curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/next/vps/bbr.sh | sh
```

> init.sh

```sh
curl https://cdn.jsdelivr.net/gh/jwyGithub/oh-my-dev/vps/init.sh | sh
curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/next/vps/init.sh | sh
```

> docker.sh

```sh
curl https://cdn.jsdelivr.net/gh/jwyGithub/oh-my-dev/vps/docker.sh | sh
curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/next/vps/docker.sh | sh
```

> xui.sh

```sh
curl https://cdn.jsdelivr.net/gh/jwyGithub/oh-my-dev/vps/xui.sh | sh
curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/next/vps/xui.sh | sh
```

> acme.sh

```sh
curl https://cdn.jsdelivr.net/gh/jwyGithub/oh-my-dev/vps/acme.sh | sh
curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/next/vps/acme.sh | sh
```

#### centos7

> bbr.sh

```sh
curl https://cdn.jsdelivr.net/gh/jwyGithub/oh-my-dev/vps/bbr.sh | sh
curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/next/vps/bbr.sh | sh
sysctl net.ipv4.tcp_available_congestion_control
```

> init.sh

```sh
curl https://cdn.jsdelivr.net/gh/jwyGithub/oh-my-dev/vps/init.sh | sh
curl https://raw.githubusercontent.com/jwyGithub/oh-my-dev/next/vps/init.sh | sh
```

### acme

```sh
~/.acme.sh/acme.sh --renew -d xx.xxx --force
~/.acme.sh/acme.sh --installcert -d xx.xx --key-file ~/x-ui/cert/private.key --fullchain-file ~/x-ui/cert/cert.crt
```

