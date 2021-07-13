echo "opening reverse mysql port on 2301"
ssh -R2301:localhost:3306 sam@139.59.23.103 -i /root/.ssh/id_rsa_temp
