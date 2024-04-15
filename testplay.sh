#!bin/bash
cat > ~/testplay.yaml <<EOF
- name: test play - install the cow
  hosts: targets
  remote_user: remoteadmin
  tasks:
    - name: fortune and cowsay package install
      apt:
        name:
          - fortune
          - cowsay
        state: present
        update_cache: yes
EOF
