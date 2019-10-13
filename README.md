# dynamic-freeDNS42
Dynamic record update for FreeDNS::42 with EdgeOS

This set of scripts privide a functionalit to dynamically update your DNS.

## Installation

1. Dowload [this Python script](https://freedns.42.pl/freedns-dyndns.py) from https://freedns.42.pl
2. Save it in router in '/config/scripts' as 'freedns-dyndns.py'
3. Modify default values hardcoded in script. Look at first lines ehere:
'''
params = \
{       "user"          : "yourUserID",
        "password"      : "******",
        "zone"          : "put.your.domain.here",
        "name"          : "@",
        "oldaddress"    : "*",
        "ttl"           : "600",
        "updatereverse" : "0",
}
'''
3. Copy script 'freedns-dyndns-cronjob.sh', to '/config/scripts/' which will be executed by task scheduler.
4. Modify router configuration:

'''
configure
set system task-scheduler task update-freedns executable path /config/scripts/freedns-dyndns-cronjob.sh
set system task-scheduler task update-freedns interval 1h
commit
save
'''
