## Giving ssh access to a machine
### For servers WITH users set in in host_vars/<servername>

 - Add user + sshkey to [roles/users/defaults/main.yml]()
 - Add user to list in host_vars/servername
 - Run command:
```
ansible-playbook -e "HOSTS=<servername>" users.yml
```

### For servers without users set in host_vars/<servername>

 - Add user + sshkey to [roles/users/defaults/main.yml]()
 - Find the <servername> in [inventory]()
 - Run command:
```
ansible-playbook -e "HOSTS=<servername>" -e '{"users":{"<labitat username>":"sudo"}}' users.yml
```

## Revoking access to a machine
WARNING: This will delete all users that aren't explicitly named in host_vars. Try with `--check` first!

 - Remove user from host_vars/servername file
 - Run a check command to which users get deleted:
```
ansible-playbook --check -e "remove_users=true" -e "HOSTS=<servername>" users.yml
```
 - Run the real deletion command:
```
ansible-playbook -e "remove_users=true" -e "HOSTS=<servername>" users.yml
```
