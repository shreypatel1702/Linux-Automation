#!bin/bash
cat > ~/apache_playbook.yaml <<EOF
- name: Install apache2 and configure ufw on target1-mgmt
  hosts: target1-mgmt
  remote_user: remoteadmin
  tasks:
    - name: Install apache2
      apt:
        name: apache2
        state: present
        update_cache: yes

    - name: Enable ufw
      command: ufw enable

    - name: Allow ssh through ufw
      command: ufw allow ssh

    - name: Allow http through ufw
      command: ufw allow http
EOF
