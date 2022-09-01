# my development configuration

## CentOS

## remote mode

```sh
wget -O- https://raw.githubusercontent.com/jwyGithub/CentOS/main/remote/repo.sh | sh
```

## local mode

```sh
git clone https://github.com/jwyGithub/CentOS.git

node centos/bin/index.js

copy cmd
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
```

5. load ~/.zshrc

```sh
source ~/.zshrc
```

