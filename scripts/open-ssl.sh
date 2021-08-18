echo "opening reverse https port on 6040"
ssh -R6040:localhost:443 sam@139.59.23.103 -i /root/.ssh/id_rsa_temp
