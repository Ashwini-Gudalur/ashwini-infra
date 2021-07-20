export OPENMRS_SERVER_USER=bahmni
export OPENMRS_SERVER_RUN=/opt/openmrs/bin/start.sh
export OPENMRS_SERVER_DEBUG=/opt/openmrs/bin/debug.sh
export CUR_USER=`/usr/bin/whoami`
export OPENMRS_LIB_CACHE=/tmp/*.openmrs-lib-cache
export JAVA_HOME=/usr/java/jdk1.8.0_291-amd64

. /etc/openmrs/openmrs.conf
runuser -u $OPENMRS_SERVER_USER nohup $JAVA_HOME/bin/java -jar -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 /opt/openmrs/lib/openmrs.jar >> /var/log/openmrs/openmrs.log 2>&1 &
