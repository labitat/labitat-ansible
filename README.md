# Labitat Ansible

This repository contains configuration management that controls our infrastructure in the space as well as works as documentation on how it's all set up.

## Contributing

To make this ansible code maximally useful to Labitat even if people come and go, the contribution process follow general OSS contribution patterns.

Basically:

 - [Fork this repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo) to your own user on Github
 - Commit your changes in the forked repository (following [commit message guidelines](#commit-message-guidelines)
 - [Create a Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) (PR) to labitat/labitat-ansible
 - If you're making big changes, feel free to name your PR with [WIP] to indicate it's not ready for review yet.
 - Respond to review comments, and implement or communicate about any suggestions.
 - Wait for merge

After contributing a few PR's, you are welcome to become a reviewer yourself :).

If it's a small change and you have access, it's OK to run ansible before your PR is reviewed. Just remember to re-run if changes are made.

### Commit message guidelines
Your commit message should answer the following questions:
 - What is the problem you're fixing?
 - How are you solving it?
 - What impact will this have on users / fellow coders?

Additionally, split your changes so that you [solve only one problem per commit](https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes). (tip: use `git add -p` to add lines interactively).

In general, [Linux kernel commit guidelines](https://www.kernel.org/doc/html/latest/process/submitting-patches.html) are a good reference.

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
