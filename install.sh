#!/bin/bash
yum install vsftpd -y
systemctl start vsftpd -y
systemctl enable vsftpd -y
firewall-cmd --zone=public --permanent --add-port=21/tcp
firewall-cmd --zone=public --permanent --add-service=ftp
firewall-cmd --reload
cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.orig
echo "chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=Yes
pasv_max_port=40000
pasv_min_port=40000" >> /etc/vsftpd/vsftpd.conf

systemctl restart vsftpd
firewall-cmd --permanent --add-port=40000/tcp
firewall-cmd --reload

firewall-cmd --permanent --add-port=27015/tcp
firewall-cmd --permanent --add-port=27015/udp

firewall-cmd --permanent --add-port=27016/tcp
firewall-cmd --permanent --add-port=27016/udp


firewall-cmd --permanent --add-port=27017/tcp
firewall-cmd --permanent --add-port=27017/udp
firewall-cmd --reload

service iptables enable
service iptables start

mkdir -p /game/public
cd /game/public
wget http://lspublic.com/hlds/newbuild.zip
yum install unzip
unzip newbuild.zip
rm -rf newbuild.zip
cd newbuild
chmod +x hlds_run
chmod +x hlds_linux
cd
yum install vsftpd screen nano unzip ld-linux.so.2 -y
yum install gcc php-devel php-pear libssh2 libssh2-devel -y
pecl install -f ssh2
touch /etc/php.d/ssh2.ini
echo extension=ssh2.so > /etc/php.d/ssh2.ini
service httpd restart

clear
echo "VsFTP & HLDS Succefully installed"
echo "HLDS path is /game/public/newbuild"


