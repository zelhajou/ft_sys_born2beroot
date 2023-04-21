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
if user not exist
```bash
adduser <username> sudo
```
Verify whether user was added:
```bash
getent group sudo
```

Then ```exit``` root session and ```exit``` again to return to login prompt. Log in again as user. or `reboot`

Let's check if this user has sudo privileges:
```bash
$ sudo whoami
```
It should answer ```root```. If not, modify sudoers file as explained below and add this line:
```bash
username  ALL=(ALL:ALL) ALL
```
**Configuring sudo:** `sudo visudo`:

Edit sudoers.tmp file as root with the command:
```bash
# sudo visudo
```
To change visudo editor from nano to vim:
```bash
sudo update-alternatives --config editor
```
And add these default settings as per subject instructions:
- To limit authentication using sudo to 3 attempts in the event of an incorrect password
  ```bash
  Defaults     passwd_tries=3
  ```
- To add a custom error message in the event of an incorrect password:
  ```bash
  Defaults      badpass_message="Wrong password. Try again!"
  ```
  or
    ```bash
    Defaults      insults
    ```
- To archive all sudo inputs & outputs to `/var/log/sudo`
  ```bash
  Defaults     log_input, log_output
  Defaults     logfile="/var/log/sudo/sudo.log"
  ```
- To require TTV:
  ```bash
    Defaults     requiretty
  ```
- To set sudo paths: Defaults
 ```bash
  secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
 ```
If ```var/log/sudo``` directory does not exist, ```mkdir var/log/sudo```.
 
you can delete a user using userdel command and delete a group using `groupdel` command.
