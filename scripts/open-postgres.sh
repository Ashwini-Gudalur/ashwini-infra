echo "opening reverse postgres port on 2302"
ssh -R2302:localhost:5432 sam@139.59.23.103 -i /root/.ssh/id_rsa_temp
