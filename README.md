# Labitat Ansible

Ansible playbooks for space infrastructure

## Running ansible

```
ansible-playbook <playbook>.yml -D [-t <tag>[,<tag2>,..]] [-C]
```
- `<playbook>.yml`: the playbook you wish to run
- `-D`: prints the changes made, fx. the difference between old and updated files
- `-t <tag>`: limit the run to certain tags, tasks are usually tagged with their name
- `-C`: don't make any changes, just show what would be changed

example:
```
ansible-playbook jumbotron.yml -D -t irssi -C
```

This will log into the jumbotron server and show how the irssi configuration
would be updated by your local changes in your ansible repo.

```
ansible-playbook jumbotron.yml -D -t irssi
```
This will actually do the changes, but again limit itself to just the tasks that are
tagged `irssi`.
