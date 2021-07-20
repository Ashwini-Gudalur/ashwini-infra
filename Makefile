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
	-mysql -u root -p, -e 'drop database openmrs;'
	mysql -u root -p, -e 'create database openmrs;'
	mysql -u root -p, openmrs < backup/schema.sql
	mysql -u root -p, openmrs < backup/metadata.sql
	mysql -u root -p, openmrs < backup/tx-dump-1.sql
	mysql -u root -p, openmrs < backup/tx-dump-2.sql
	mysql -u root -p, openmrs < backup/tx-dump-3.sql
	mysql -u root -p, openmrs < backup/tx-dump-4.sql
	mysql -u root -p, openmrs < backup/tx-dump-5.sql
