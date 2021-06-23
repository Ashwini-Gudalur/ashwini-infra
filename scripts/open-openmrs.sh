echo "opening reverse openmrs port on 2304"
ssh -R2304:localhost:8050 root@143.110.188.91 -i /root/.ssh/abi
