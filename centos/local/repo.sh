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
base_os_backup=$base_os.backup

# stream_backup
stream_backup=$app_stream.backup

# base_os file
base_os_file=$base_os

# stream_file
stream_file=$app_stream

if [ ! -f "$base_os_backup" && -f $base_os_file ]; then
# backup base_os
cp $base_os_file /etc/yum.repos.d/$base_os_backup.backup
fi


if [ ! -f "$stream_backup" && -f $stream_file]; then
# backup app_stream
cp $stream_file /etc/yum.repos.d/$stream_backup.backup
fi

if ([ -f $base_os_file ]) 
then
# remove base_os
rm -f $base_os_file
fi

if ([ -f $stream_file ]) 
then
# remove app_stream
rm -r $stream_file
fi


# append base_os for aliyun
echo "$(curl http://$ip:$port/base_os)" >> /etc/yum.repos.d/CentOS-$release-BaseOS.repo

# append app_stream for aliyun
echo "$(curl http://$ip:$port/stream)" >> /etc/yum.repos.d/CentOS-$release-AppStream.repo

# install epel-release
yum install epel-release -y
