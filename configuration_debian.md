# Born2beroot Configuration

## Sudo Setup

Log in as root:
```bash
$ su root
```
or
```bash
$ su -
```

Install sudo:
```bash
# apt update
# apt upgrade
# apt install sudo
```

Add user to sudo group:
```bash
# sudo usermod -aG sudo <username>
```
Then ```exit``` root session and ```exit``` again to return to login prompt. Log in again as user.
Let's check if this user has sudo privileges:
```bash
$ sudo whoami
```
It should answer ```root```. If not, modify sudoers file as explained below and add this line:
```bash
username  ALL=(ALL:ALL) ALL
```

Edit sudoers.tmp file as root with the command:
```bash
# sudo visudo
```
And add these default settings as per subject instructions:
```bash
Defaults     passwd_tries=3
Defaults     badpass_message="Wrong password. Try again!"
Defaults     logfile="/var/log/sudo/sudo.log"
Defaults     log_input
Defaults     log_output
Defaults     requiretty
```
If ```var/log/sudo``` directory does not exist, ```mkdir var/log/sudo```.
