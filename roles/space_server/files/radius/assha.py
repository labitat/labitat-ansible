#!/usr/bin/env python

import radiusd
import hashlib
import re

USERS = '/etc/raddb/mods-config/files/authorize'
REXP = re.compile('^([^ ]+) ASSHA-Password := "(.*)"$')

def authorize(p):
    #radiusd.radlog(radiusd.L_INFO, '*** radlog call in authorize ***')
    reply = ( ('Reply-Message', 'Welcome to Labitat!'), )
    config = ( ('Auth-Type', 'python3'), )
    return (radiusd.RLM_MODULE_OK, reply, config)

def load_users():
    users = {}
    with open(USERS) as fp:
        for line in fp:
            match = REXP.match(line)
            if match:
                users[match.group(1)] = match.group(2)

    return users

def check_pwd(user, pw):
    users = load_users()
    if user not in users:
        return False
    assha = users[user]
    crypted = assha[:40]
    salt = assha[40:]
    h = hashlib.sha1('--{}--{}--'.format(salt, pw).encode('utf-8')).hexdigest()
    return h == crypted

def authenticate(p):
    #radiusd.radlog(radiusd.L_INFO, '*** radlog call in authenticate *** ')
    user = None
    pw = None
    for (attr, value) in p:
        if attr == 'User-Name':
            user = value
        if attr == 'User-Password':
            pw = value

    # check password
    if user != None and pw != None and check_pwd(user, pw):
        return radiusd.RLM_MODULE_OK

    return radiusd.RLM_MODULE_REJECT
