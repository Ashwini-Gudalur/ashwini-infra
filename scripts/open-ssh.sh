echo "opening reverse ssh port on 2300"
ssh -v -R2300:localhost:22 sam@139.59.23.103 -i /root/.ssh/id_rsa_temp
