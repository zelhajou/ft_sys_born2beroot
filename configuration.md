# Born2beroot Configuration

## Sudo Setup
### Step 1: Installing sudo
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
### Step 2: Adding User to sudo Group
Add user to sudo group:
```bash
sudo usermod -aG sudo <username>
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

### Step 3: Running root-Privileged Commands

Let's check if this user has sudo privileges:
```bash
sudo whoami
```
It should answer ```root```. If not, modify sudoers file as explained below and add this line:
```bash
username  ALL=(ALL:ALL) ALL
```
From here on out, run root-privileged commands via prefix sudo. For instance:
```bash
$ sudo apt update
```

### Step 4: Configuring sudo

**Configuring sudo:** `sudo visudo`:

Edit sudoers.tmp file as root with the command:
```bash
sudo visudo
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

## SSH Setup
### Step 1: Installing & Configuring SSH
Install OpenSSH:

```bash
$ sudo apt install openssh-server
```
Check SSH status:
```bash
$ sudo systemctl status ssh
```
Change SSH listening port to 4242:
```bash
$ sudo nano /etc/ssh/sshd_config
```
Find this line:
```bash
#Port 22
```
And uncomment (delete #) and change it to 4242:
```bash
Port 4242
```
To disable SSH login as root irregardless of authentication mechanism replace: 

Find this line:
```bash
#PermitRootLogin prohibit-password 
```
And uncomment (delete #) and change it with:
```bash
PermitRootLogin no
```
Restart SSH service
```bash
$ sudo systemctl restart ssh
```
Check SSH status
```bash
$ sudo service ssh status
$ systemctl status ssh
```

### Step 2: Installing & Configuring UFW

Install and enable UFW:
```bash
$ sudo apt install ufw
```
Verify installaiton: 
```bash
dpkg -l | grep ufw
```
Enabe FireWall
```bash
$ sudo ufw enable
```
Allow or deny ports:
```bash
$ sudo ufw allow 4242
$ sudo ufw deny <port>
```
Check UFW status:
```bash
$ sudo ufw status verbose
```
Remove port rule:
```bash
$ sudo ufw delete allow <port>
$ sudo ufw delete deny <port>
```
Or, another method for rule deletion:
```bash
$ sudo ufw status numbered
$ sudo ufw delete <port index number>
```
Careful with the numbered method, the index numbers change after a deletion, check between deletes to get the correct port index number!

### Step 3: Connecting to Server via SSH

Forward the host port 4242 to the guest port 4242: in VirtualBox, 
* go to VM >> Settings >> Network >> Adapter 1 >> Advanced >> Port Forwarding.
* add a rule: Host port 4242 and guest port 4242.

Restart SSH service after this change.

In the host terminal, connect like this:
```bash
$ ssh <username>@localhost -p 4242
```
Or like this:
```bash
$ ssh <username>@127.0.0.1 -p 4242
```
To quit the ssh connection, just ```exit```.

## User Management


