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




shrey@Generic-VM:~/Linux-Automation$ ssh remoteadmin@server1-mgmt
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:6ZD/UHYEPDi5J1m1C9zyzXHh8F5b1g3q0bQYYvQyqks.
Please contact your system administrator.
Add correct host key in /home/shrey/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/shrey/.ssh/known_hosts:6
  remove with:
  ssh-keygen -f "/home/shrey/.ssh/known_hosts" -R "server1-mgmt"
Host key for server1-mgmt has changed and you have requested strict checking.
Host key verification failed.
shrey@Generic-VM:~/Linux-Automation$ 



ssh-keygen -f "/home/shrey/.ssh/known_hosts" -R "server1-mgmt"

