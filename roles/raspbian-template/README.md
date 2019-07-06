raspbian-template
=================

About
-----

This is a template for an ansible role setting up a
[Raspberry Pi][rpi] running [Raspbian][raspbian].

[rpi]: https://www.raspberrypi.org
[raspbian]: https://www.raspbian.org

Bootstrap a new Raspberry Pi
----------------------------

Download a "Lite" image from the Raspberry Pi [homepage][downloads],
and write it to your sd-card as described on that page.

Before removing the sd-card from your computer make sure to mount
the vfat filesystem on the first partition and create an (empty)
file called "ssh". This enables an [SSH][ssh] daemon on boot so
you and Ansible can log into it on boot.

Now move your sd-card to the Raspberry Pi, connect an ethernet cable
and lastly the power.
Once you figure out the ip address of the Raspberry Pi it's a good idea
to ssh into it manually just to accept the host key:
```sh
ssh pi@<ip address>
```
Now run the following command to bootstrap it:

```sh
ansible-playbook -D \
  -i raspbian-template, \
  -e ansible_host=<ip address> \
  -e ansible_ssh_user=pi \
  -e ansible_ssh_pass=raspberry \
  -e '{"users":{"<your labitat user>":"sudo"}}' \
  raspbian-template.yml
```

Now go buy a Mate or something. This will take a long time..

Once it finishes you should have a fully upgraded Raspbian
with your Labitat user and all the ssh keys in place.
Hence you should now be able run ansible with your own
ssh user. Eg. just

```sh
ansible-playbook -D \
  -i raspbian-template, \
  -e ansible_host=<ip address> \
  -e '{"users":{"<your labitat user>":"sudo"}}' \
  raspbian-template.yml
```

Now is a good time to ssh into it and reboot it,
so it uses the new network setup after boot.

[downloads]: https://www.raspberrypi.org/downloads/raspbian/
[ssh]: https://en.wikipedia.org/wiki/Secure_Shell
