~/check-assign2-script https://github.com/yourgithubusername/yourreponame/assignment2.sh 2>&1 >~/assignment2-checked.txt
--2024-03-17 22:33:32--  https://zonzorp.github.io/COMP2137/check-assign2-script
Resolving zonzorp.github.io (zonzorp.github.io)... 185.199.110.153, 185.199.111.153, 185.199.108.153, ...
Connecting to zonzorp.github.io (zonzorp.github.io)|185.199.110.153|:443... connected.
HTTP request sent, awaiting response... 404 Not Found
2024-03-17 22:33:33 ERROR 404: Not Found.




wget -O ~/makecontainers.sh https://zonzorp.github.io/COMP2137/makecontainers.sh && chmod +x ~/makecontainers.sh

 ~/makecontainers.sh --prefix server --count 2 --fresh


ssh remoteadmin@server1-mgmt


scp assignment2.sh remoteadmin@server1-mgmt:/root/



wget -O ~/check-assign2-script https://zonzorp.github.io/COMP2137/check-assign2-script &&

chmod +x ~/check-assign2-script &&

~/check-assign2-script https://github.com/yourgithubusername/yourreponame/assignment2.sh 2>&1 >~/assignment2-checked.txt

