# Determine whether it is the Linux version or the stream version

centos_linux="CentOS Linux"
centos_stream="CentOS Stream"
redhat_release=$(cat /etc/redhat-release | grep "${centos_linux}")
if [[ "$redhat_release" != "" ]]
then
        release="Linux"
else
        release="Stream"
fi

base_os=/etc/yum.repos.d/CentOS-$release-BaseOS.repo
app_stream=/etc/yum.repos.d/CentOS-$release-AppStream.repo

echo BaseOS file is : $base_os
echo AppStream file is : $app_stream


# backup base_os

cp /etc/yum.repos.d/CentOS-$release-BaseOS.repo /etc/yum.repos.d/CentOS-$release-BaseOS.repo.backup


# backup app_stream

cp /etc/yum.repos.d/CentOS-$release-AppStream.repo /etc/yum.repos.d/CentOS-$release-AppStream.repo.backup


# remove base_os
rm -rf /etc/yum.repos.d/CentOS-$release-BaseOS.repo

# append base_os for aliyun
echo "$(curl https://raw.githubusercontent.com/jwyGithub/CentOS/main/repo/CentOS-Stream-BaseOS.repo)" >> /etc/yum.repos.d/CentOS-$release-BaseOS.repo

# remove app_stream
rm -rf /etc/yum.repos.d/CentOS-$release-AppStream.repo

# append app_stream for aliyun
echo "$(curl https://raw.githubusercontent.com/jwyGithub/CentOS/main/repo/CentOS-Stream-AppStream.repo)" >> /etc/yum.repos.d/CentOS-$release-AppStream.repo


# cache
yum makecache -y

# install epel-release
yum install epel-release -y
