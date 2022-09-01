# # Determine whether it is the Linux version or the stream version


wsl2=$(uname -r | grep WSL2)
ip=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')

if([ $PORT ])
then
    port=$PORT
else
    port=20202
fi

if([ "$wsl2" != "" ])
then
    ip=$SERVER
else
    ip=$ip
fi

echo $ip

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


# base_os_backup
base_os_backup=/etc/yum.repos.d/CentOS-$release-BaseOS.repo.backup

# stream_backup
stream_backup=/etc/yum.repos.d/CentOS-$release-AppStream.repo.backup

if [ ! -f "$base_os_backup" ]; then
# backup base_os
cp /etc/yum.repos.d/CentOS-$release-BaseOS.repo /etc/yum.repos.d/CentOS-$release-BaseOS.repo.backup
fi


if [ ! -f "$stream_backup" ]; then
# backup app_stream
cp /etc/yum.repos.d/CentOS-$release-AppStream.repo /etc/yum.repos.d/CentOS-$release-AppStream.repo.backup
fi


# remove base_os
rm -rf /etc/yum.repos.d/CentOS-$release-BaseOS.repo

# remove app_stream
rm -rf /etc/yum.repos.d/CentOS-$release-AppStream.repo

# append base_os for aliyun
echo "$(curl http://$ip:$port/base_os)" >> /etc/yum.repos.d/CentOS-$release-BaseOS.repo

# append app_stream for aliyun
echo "$(curl http://$ip:$port/stream)" >> /etc/yum.repos.d/CentOS-$release-AppStream.repo


# cache
yum makecache

# install epel-release
yum install epel-release -y
