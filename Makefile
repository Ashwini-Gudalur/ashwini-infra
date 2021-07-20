backup-mysql-lite:
	echo "TBD"

download-mysql-lite-dump:
	ssh dspace-auto "scp ashwini:/tmp/schema.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/metadata.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-1.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-2.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-3.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-4.sql /tmp/"
	ssh dspace-auto "scp ashwini:/tmp/tx-dump-5.sql /tmp/"

download-mysql-lite-dump-to-local-from-jump:
	scp dspace-auto:/tmp/schema.sql backup/
	scp dspace-auto:/tmp/metadata.sql backup/
	scp dspace-auto:/tmp/tx-dump-1.sql backup/
	scp dspace-auto:/tmp/tx-dump-2.sql backup/
	scp dspace-auto:/tmp/tx-dump-3.sql backup/
	scp dspace-auto:/tmp/tx-dump-4.sql backup/
	scp dspace-auto:/tmp/tx-dump-5.sql backup/

download-mysql-lite-dump-all-the-way: download-mysql-lite-dump download-mysql-lite-dump-to-local-from-jump

restore-mysql-lite-dump:
	-mysql -u root -ppassword -e 'drop database openmrs;'
	mysql -u root -ppassword -e 'create database openmrs;'
	mysql -u root -ppassword openmrs < backup/schema.sql
	mysql -u root -ppassword openmrs < backup/metadata.sql
	mysql -u root -ppassword openmrs < backup/tx-dump-1.sql
	mysql -u root -ppassword openmrs < backup/tx-dump-2.sql
	mysql -u root -ppassword openmrs < backup/tx-dump-3.sql
	mysql -u root -ppassword openmrs < backup/tx-dump-4.sql
	mysql -u root -ppassword openmrs < backup/tx-dump-5.sql

define _scp_vagrant
	scp -P 2222 -i ~/.vagrant.d/insecure_private_key backup/$1 vagrant@127.0.0.1:/tmp/
endef

copy-mysql-lite-to-vagrant:
	$(call _scp_vagrant,schema.sql)
	$(call _scp_vagrant,metadata.sql)
	$(call _scp_vagrant,tx-dump-1.sql)
	$(call _scp_vagrant,tx-dump-2.sql)
	$(call _scp_vagrant,tx-dump-3.sql)
	$(call _scp_vagrant,tx-dump-4.sql)
	$(call _scp_vagrant,tx-dump-5.sql)
