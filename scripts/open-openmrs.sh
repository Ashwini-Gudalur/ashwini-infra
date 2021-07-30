echo "opening reverse openmrs port on 2304"
ssh -R2304:localhost:8050 sam@139.59.23.103 -i /root/.ssh/id_rsa_temp
