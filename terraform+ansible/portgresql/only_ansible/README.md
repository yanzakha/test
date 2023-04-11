For install on remote host you need to do this command
    ansible-playbook -i iporhostname, playbook.yml
public ssh-key of current user should be added to remote host ~/.ssh/authorized_keys

If you dont want to add ssh-key to remote host provide -u <remote_user> and --ask-pass parameters when you execute command

If you need to do it on current host you should add to /etc/ansible/hosts to [host] inventory
    [host]
    localhost ansible_connection=local
and execute this command
    ansible-playbook plyabook.yml
