This learning activity is graded. If you want feedback or commentary on your work as you progress, ask your professor to review what you have done.



In this assignment, you will be modifying an existing Ubuntu 22.04 server. In order to keep lab machine requirements to a minimum, we will be simulating the server using containers running inside of our existing VM. I created a script to set it up from scratch for you, so that you can focus on your script instead of creating and recreating VMs. Download the script to make the container first. Once you have a copy of it on your generic-vm, you do not need to download it again.



student@generic-vm% wget -O ~/makecontainers.sh https://zonzorp.github.io/COMP2137/makecontainers.sh && chmod +x ~/makecontainers.sh



Run this script in your existing generic-vm to create your server container using this command:



student@generic-vm% ~/makecontainers.sh --prefix server --count 2 --fresh



You will need a minimum of 4GB of free space in your existing VM in order to run this successfully. When it finishes, you will have a virtual network with a server system on it that you will do your assignment on. The default it will create looks like the diagram in this image file. The network which has the mgmt names is a private network and does not provide routing to the internet. The servers on the network 192.168.16 access the internet through the openwrt router at 192.168.16.2.



The script will print a summary of hosts and IP addresses when it runs. You can re-run it to delete the existing containers and re-create them at any time. The name of the server you are creating is server1 and you can access it for this assignment using



student@generic-vm% ssh remoteadmin@server1-mgmt



The script also created a server named server2 that looks just like server1, so if you want to test things, or compare the results of your own commands to what was there before they ran, you can always compare server1 and server2.



You are going to create a script named assignment2.sh that determines what modifications are necessary to perform to a running system, runs on the target system to make those modifications, and reports on what it did. This script must be robust and should not assume the target is a fresh server1, so it must include testing for what changes need to be applied. It should keep the user notified of its actions in a human friendly way, with all output labeled, organized, and visually easy to read. Your script should produce human-friendly error information should it encounter any errors. Your script must be idempotent which means it can be run repeatedly on the same machine it was already run on without affecting the outcome.



The system to be modified must have the following configuration when it is complete (all of these configuration items must be checked for and updated as needed by your script). Run and test your script on your server1 container. If you mess up the container while working on this, simply re-create it by running the makecontainers.sh script again. You can create and work on your script on server1 using nano or vi, or on generic-vm and work on it there in order to make use of graphical tools then copy it to the server1 container using the following command:



generic-vm% scp assignment2.sh remoteadmin@server1-mgmt:/root/



The configuration for the 192.168.16 network interface must have the following persistent configuration defined using the existing netplan configuration file. The interface which is attached to the private mgmt network must not be affected or altered. The /etc/hosts file on server1 must have the 192.168.16.21 address in it for the hostname server1. It must not have the old address which no longer is valid for server1.

Address: 192.168.16.21/24


Software installed must include the following.

apache2 web server running in its default configuration
squid web proxy running in its default configuration


Firewall must be implemented and enabled using ufw with rules to allow only the following services.

ssh port 22 only on the mgmt network
http on both interfaces
web proxy on both interfaces


User accounts created with the following configuration.

all users in this list must have a home directory and bash as their default shell
all users in this list must have ssh keys for rsa and ed25519 algorithms, with both of their own public keys added to their own authorized_keys file
The account list must include the following:

dennis
this is the only user who should have sudo access
should allow access using ssh with the following public key as well as their generated public keys:
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4rT3vTt99Ox5kndS4HmgTrKBT8SKzhK4rhGkEVGlCI student@generic-vm
aubrey
captain
snibbles
brownie
scooter
sandy
perrier
cindy
tiger
yoda


Your script must run correctly without errors on our Ubuntu 22.04 course VM.

To submit this assignment, you will need to create 2 files. Your script file which you have created to ensure the configuration above is set up on server1, and a text file containing the output of running the check-assign2-script program on your own VM. The check-assign2-script program requires you to specify the URL for your script on your github repo, and it wipes out your existing server1 container as well as ~/makecontainers.sh and ~/assignment2.sh and ~/check-assign2-script. To create the screenshots, you must do the following:

Start a fresh terminal window on your VM. Run the following command and screenshot all of the output:



generic-vm% wget -O ~/check-assign2-script.sh https://zonzorp.github.io/COMP2137/check-assign2-script.sh &&

chmod +x ~/check-assign2-script.sh &&

~/check-assign2-script.sh https://github.com/yourgithubusername/yourreponame/assignment2.sh 2>&1 >~/assignment2-checked.txt



Review the rubric linked above for details on how your work will be graded.

You are done with the learning activity for this lesson and should proceed to writing the quiz for this lesson before the next class in this course begins.
