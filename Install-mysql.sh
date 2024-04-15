#!bin/bash
cat > ~/mysql_playbook.yaml <<EOF
- name: Install mysql and configure ufw on target2-mgmt
  hosts: target2-mgmt
  remote_user: remoteadmin
  tasks:
    - name: Install mysql
      apt:
        name: mysql-server
        state: present
        update_cache: yes

    - name: Enable ufw
      command: ufw enable

    - name: Allow ssh through ufw
      command: ufw allow ssh

    - name: Allow mysql through ufw
      command: ufw allow 3306/tcp
EOF
