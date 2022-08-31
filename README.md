# CentOS
my CentOS init config.

## update mirrorlist to aliyun
```sh
wget -O- https://raw.githubusercontent.com/jwyGithub/CentOS/main/repo.sh | sh
```

## local
```sh
node repo/index.js

curl http://localhost:8090/repo-local | sh
```
