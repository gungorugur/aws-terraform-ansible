ansible_ssh_private_key_file: "keys/private_key.pem"
ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o ProxyCommand="ssh -i {{ ansible_ssh_private_key_file }} -o StrictHostKeyChecking=no -W %h:%p -q ec2-user@${bastion}"'