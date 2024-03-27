shrey@Generic-VM:~/Linux-Automation$ wget -O ~/check-assign2-script.sh https://zonzorp.github.io/COMP2137/check-assign2-script.sh && 

chmod +x ~/check-assign2-script.sh &&

~/check-assign2-script.sh https://github.com/yourgithubusername/yourreponame/assignment2.sh 2>&1 >~/assignment2-checked.txt

--2024-03-26 22:06:38--  https://zonzorp.github.io/COMP2137/check-assign2-script.sh
Resolving zonzorp.github.io (zonzorp.github.io)... 185.199.109.153, 185.199.108.153, 185.199.111.153, ...
Connecting to zonzorp.github.io (zonzorp.github.io)|185.199.109.153|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 2236 (2.2K) [application/x-sh]
Saving to: ‘/home/shrey/check-assign2-script.sh’

/home/shrey/check-assign2-script 100%[==========================================================>]   2.18K  --.-KB/s    in 0.003s  

2024-03-26 22:06:38 (641 KB/s) - ‘/home/shrey/check-assign2-script.sh’ saved [2236/2236]

Error: Failed checking instance exists "local:openwrt": Instance not found
WARNING:root:Cannot call Open vSwitch: ovsdb-server.service is not running.
