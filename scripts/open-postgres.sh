@echo "opening reverse postgres port on 2302"
ssh -R2302:localhost:5432 root@143.110.188.91 -i /root/.ssh/abi
