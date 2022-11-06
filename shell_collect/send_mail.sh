#首先安装邮箱服务
yum -y install mailx
#在文件中添加以下配置/etc/mail.rc
set from=ly2015XXXX@163.com smtp=smtp.163.com
#smtp-auth-password来自邮箱POP3/SMTP/IMAP的授权管理码设置
set smtp-auth-user=ly201552XXX@163.com smtp-auth-password=XXXXXXXXXX
set smtp-auth=login

#发送邮件测试
echo "Hello This is first linux mail" | mail -s hello ly201XXXX@163.com
