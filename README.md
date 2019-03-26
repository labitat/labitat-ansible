# Labitat Ansible

Ansible playbooks for space infrastructure

## Running ansible

```
ansible-playbook {playbook}.yml -t {task} -D -C
```
- `{playbook}` = the playbook you wish to run
- `{task}` = the task to run
- -D = prints a diff of files that are changed
- -C = does not make any changes; instead, trys to predict some of the changes that may occur (remove when everything is ok)
