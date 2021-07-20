export OPENMRS_SERVER_USER=bahmni
export OPENMRS_SERVER_RUN=/opt/openmrs/bin/start.sh
export OPENMRS_SERVER_DEBUG=/opt/openmrs/bin/debug.sh
export CUR_USER=`/usr/bin/whoami`
export OPENMRS_LIB_CACHE=/tmp/*.openmrs-lib-cache
export JAVA_HOME=/usr/java/jdk1.8.0_291-amd64

create_dirs() {
    if [[ ! -e /var/run/openmrs ]]; then
        ln -s /opt/openmrs/run /var/run/openmrs
    fi

    if [[ ! -e /var/run/openmrs/openmrs ]]; then
        ln -s /opt/openmrs/openmrs /var/run/openmrs/openmrs
    fi

    if [[ ! -e /var/log/openmrs ]]; then
        ln -s /opt/openmrs/log /var/log/openmrs
    fi
}

. /etc/openmrs/openmrs.conf
create_dirs
runuser -u $OPENMRS_SERVER_USER -- nohup $JAVA_HOME/bin/java -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 -jar /opt/openmrs/lib/openmrs.jar >> /var/log/openmrs/openmrs.log 2>&1 &
