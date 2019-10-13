# dynamic-freeDNS42
Dynamic record update for [FreeDNS::42](https://freedns.42.pl) with EdgeOS.
        
This set of steps provide a functionality of dynamic update of your domain at FreeDNS::42.
Tested on [ERLite-3](https://www.ui.com/edgemax/edgerouter-lite/) running 1.10.x version of EdgeOS.

## Installation

1. Connect via ssh to your router.
2. Dowload [this Python script](https://freedns.42.pl/freedns-dyndns.py) from https://freedns.42.pl
```bash
curl https://freedns.42.pl/freedns-dyndns.py -o freedns-dyndns.py
```
3. Modify default values hardcoded in script. Look at first lines here:
```python
params = \
{       "user"          : "yourUserID",
        "password"      : "******",
        "zone"          : "put.your.domain.here",
        "name"          : "@",
        "oldaddress"    : "*",
        "ttl"           : "600",
        "updatereverse" : "0",
}
```
4. Elevate your access and save modified script in `/config/scripts`.
```bash
sudo su

cp freedns-dyndns.py /config/scripts/freedns-dyndns.py
```
All need to be in `/config/scripts/` directory, otherwise scripts will not survive system upgrade in future.    

5. Copy script `freedns-dyndns-cronjob.sh`, to `/config/scripts/`. Make it executabe.
```bash
curl https://raw.githubusercontent.com/acejacek/dynamic-freeDNS42/master/freedns-dyndns-cronjob.sh -o /config/scripts/freedns-dyndns-cronjob.sh

chmod +x /config/scripts/freedns-dyndns-cronjob.sh
```
Theoretically, this step could be avoided, but it's bloody difficult to escape `"` characters in router configuration. It's just easier to create such a _shell script_.

6. Add _task scheduler_ job in router configuration:
```
configure
set system task-scheduler task update-freedns executable path /config/scripts/freedns-dyndns-cronjob.sh
set system task-scheduler task update-freedns interval 1h
commit
save
```
## Test
Check the `/var/log/messages` for any sign of logged activity:
```bash
grep FreeDNS /var/log/messages
```
There should be entry similar to this:
```
Oct 13 17:34:14 edge FreeDNS::42: result: {'serial': '2005106563', 'ttl': 600, 'name': '@', 'zone': 'your.domain.here', 'addresses': ['123.123.123.123']}
```