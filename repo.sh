
# backup CentOS-Stream-AppStream.repo

cp /etc/yum.repos.d/CentOS-Stream-AppStream.repo /etc/yum.repos.d/CentOS-Stream-AppStream.repo.backup


# backup CentOS-Stream-BaseOS.repo

cp /etc/yum.repos.d/CentOS-Stream-BaseOS.repo /etc/yum.repos.d/CentOS-Stream-BaseOS.repo.backup


# remove CentOS-Stream-BaseOS.repo
rm -rf CentOS-Stream-BaseOS.repo

# append CentOS-Stream-BaseOS.repo for aliyun
echo "$(curl https://raw.githubusercontent.com/jwyGithub/CentOS/main/repo/CentOS-Stream-BaseOS.repo)" >> /etc/yum.repos.d/CentOS-Stream-BaseOS.repo

# remove CentOS-Stream-BaseOS.repo
rm -rf CentOS-Stream-AppStream.repo

# append CentOS-Stream-AppStream.repo for aliyun
echo "$(curl https://raw.githubusercontent.com/jwyGithub/CentOS/main/repo/CentOS-Stream-AppStream.repo)" >> /etc/yum.repos.d/CentOS-Stream-AppStream.repo


# cache
yum makecache -y

# install epel-release
yum install epel-release -y
