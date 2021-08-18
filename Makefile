backup-mysql-lite:
	sh database/mysql-backup-light.sh

backup-mysql:
	#GRANT ALL ON *.* TO 'openmrs-user'@'%' IDENTIFIED BY 'P@ssw0rd';
	mysqldump -u root -p openmrs > /tmp/mysql-full.sql

download-mysql-lite-dump:
	ssh dspace-auto "scp ashwini:/tmp/schema.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/metadata.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/user-person.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-1.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-2.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-3.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-4.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-5.sql /tmp/"

download-mysql-lite-dump-to-local-from-jump:
	scp dspace-auto:/tmp/schema.sql backup/
	scp dspace-auto:/tmp/metadata.sql backup/
	scp dspace-auto:/tmp/user-person.sql backup/
	scp dspace-auto:/tmp/tx-dump-1.sql backup/
	scp dspace-auto:/tmp/tx-dump-2.sql backup/
	scp dspace-auto:/tmp/tx-dump-3.sql backup/
	scp dspace-auto:/tmp/tx-dump-4.sql backup/
	scp dspace-auto:/tmp/tx-dump-5.sql backup/

download-mysql-lite-dump-all-the-way: download-mysql-lite-dump download-mysql-lite-dump-to-local-from-jump

stop-openmrs:
	systemctl stop openmrs

start-openmrs:
	systemctl start openmrs

restore-mysql-lite-dump-only:
	-mysql -u root -pP@ssw0rd -e 'drop database openmrs;'
	mysql -u root -pP@ssw0rd -e 'create database openmrs;'
	mysql -u root -pP@ssw0rd openmrs < /tmp/schema.sql
	mysql -u root -pP@ssw0rd openmrs < /tmp/metadata.sql
	mysql -u root -pP@ssw0rd openmrs < /tmp/user-person.sql
	mysql -u root -pP@ssw0rd openmrs < /tmp/tx-dump-1.sql
	mysql -u root -pP@ssw0rd openmrs < /tmp/tx-dump-2.sql
	mysql -u root -pP@ssw0rd openmrs < /tmp/tx-dump-3.sql
	mysql -u root -pP@ssw0rd openmrs < /tmp/tx-dump-4.sql
	mysql -u root -pP@ssw0rd openmrs < /tmp/tx-dump-5.sql

restore-mysql-lite-dump: stop-openmrs restore-mysql-lite-dump-only start-openmrs

define _scp_vagrant
	scp -P 2222 -i ~/.vagrant.d/insecure_private_key backup/$1 vagrant@127.0.0.1:/tmp/
endef

copy-mysql-lite-to-vagrant:
	$(call _scp_vagrant,schema.sql)
	$(call _scp_vagrant,metadata.sql)
	$(call _scp_vagrant,user-person.sql)
	$(call _scp_vagrant,tx-dump-1.sql)
	$(call _scp_vagrant,tx-dump-2.sql)
	$(call _scp_vagrant,tx-dump-3.sql)
	$(call _scp_vagrant,tx-dump-4.sql)
	$(call _scp_vagrant,tx-dump-5.sql)

tunnel-debug-port-vagrant:
	ssh -p 2222 -i ~/.vagrant.d/insecure_private_key vagrant@127.0.0.1 -L 5005:localhost:5005

stop-all: stop-all-but-openmrs
	systemctl stop openmrs

stop-all-but-openmrs:
	systemctl stop odoo
	systemctl stop bahmni-lab
	systemctl stop bahmni-reports
	systemctl stop atomfeed-console
	systemctl stop bahmni-erp-connect

disable-all-but-openmrs:
	systemctl disable odoo
	systemctl disable bahmni-lab
	systemctl disable bahmni-reports
	systemctl disable atomfeed-console
	systemctl disable bahmni-erp-connect


# Tunnels
tunnel-https:
	echo "opening reverse https port on 6040"
	ssh -R6040:localhost:443 sam@139.59.23.103 -i /root/.ssh/id_rsa_temp
