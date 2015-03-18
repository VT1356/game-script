# Nguyen Hoai Nam
echo "Scrip cai dat apache tren Ubuntu va CenOS ban 64 bit"
echo "Author: Nguyen Hoai Nam - VDC"

# Kiem tra thong tin may
tt=`cat /etc/issue.net | awk 'FNR == 1 {print}' | awk '{print $1}'`
echo Ban dang dung HDH:$tt
# Thuc hien viec cai dat
if [ "$tt" = "Ubuntu" ] ; then
	check=`dpkg -l | grep -w apache2-bin | awk '{print $2}'`
	if [ "$check" = "apache2-bin" ] ; then
	echo "May ban da la web-server voi phien ban `dpkg -l | grep apache2-bin | awk '{print $3}'`"
	echo "Truy cap theo dia chi:"
	ifconfig | grep -w inet | grep Bcast | awk -F ':' '{print $2}' | awk '{print $1}'
	echo "thong qua port:`cat /etc/apache2/ports.conf | grep Listen |  awk 'FNR == 1 {print}' | awk '{print $2}'`"
	else
	echo "Update he thong!!!"
	sleep 2
	#apt-get -y upgrade && apt-get -y dist-upgrade
	apt-get update
	apt-get install -y apache2
	tput setaf 2
	echo "Nhap port ban muon doi:"
	read p
	tput setaf 7
	sed -i "s/80/$p/" /etc/apache2/ports.conf
	sed -i "s/<VirtualHost *:80>/<VirtualHost *:$p>/" /etc/apache2/sites-enabled/000-default.conf
	service apache2 restart
	# Mo port cho may
	service ufw start
	iptables  -A INPUT  -p tcp --dport $p -j ACCEPT
	iptables  -A OUTPUT -p tcp --sport $p -j ACCEPT
	# Xong
	echo "Da cai xong web-server. Dia chi web-server la:`ifconfig | grep -w inet | grep Bcast | awk -F ':' '{print $2}' | awk '{print $1}'`"
	echo "Voi port la port ban vua chuyen !!! "
	fi
elif [ "$tt" = "CentOS" ] ; then
	check=`yum list | grep -w httpd.x86_64 | awk '{print $1}'`
	if [ "$check" = "httpd.x86_64" ]; then
	echo "May ban da la web-server voi phien ban:`yum list | grep -w httpd.x86_64 | awk '{print $2}'`"
	echo "Truy cap theo dia chi:"
	ifconfig | grep -w inet | grep Bcast | awk -F ':' '{print $2}' | awk '{print $1}'
	echo "thong qua port:`cat /etc/httpd/conf/httpd.conf | grep  Listen | grep -v ^# | awk '{print $2}'`"
	else
	echo "Update he thong"
	sleep 2
	yum update
	yum -y install httpd
	tput setaf 2
	echo "Nhap port ban muon doi:"
	read p
	tput setaf 7
	sed -i "s/Listen 80/Listen $p/" /etc/httpd/conf/httpd.conf
	service httpd restart
	# Mo port cho web-server
	service iptables start
	iptables  -A INPUT  -p tcp --dport $p -j ACCEPT
	iptables  -A OUTPUT -p tcp --sport $p -j ACCEPT
	echo "Da cai xong web-server. Dia chi web-server la:`ifconfig | grep -w inet | grep Bcast | awk -F ':' '{print $2}' | awk '{print $1}'`"
	echo "Voi port la port ban vua chuyen !!! "
	fi
else
echo "HDH may ban khong phai la Linux hoac CenOS. Bye"
fi

	
	
	





