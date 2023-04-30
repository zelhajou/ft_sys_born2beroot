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

### Step 1: Setting Up a Strong Password Policy

Password Age

Edit ```/etc/login.defs``` and find "password aging controls". Modify them as per subject instructions:
```bash
PASS_MAX_DAYS 30
PASS_MIN_DAYS 2
PASS_WARN_AGE 7
```
These changes aren't automatically applied to existing users, so use chage command to modify for any users and for root:
```bash
$ sudo chage -M 30 <username/root>
$ sudo chage -m 2 <username/root>
$ sudo chage -W 7 <username/root>
```
Use ```chage -l <username/root>``` to check user settings.

Password Strength

Install password quality verification library:
```bash
$ sudo apt install libpam-pwquality
```
Verify installation:

```bash
dpkg -l | grep libmap-pwquality
```
Configure password strength policy via:
```bash
sudo vim /etc/pam.d/common-password
```
specifically the below line:
```vi
25 password		requisite	pam_pwquality.so retry=3
``` 
- To set password minimum length to 10 characters, add the following option to the above line: `minlen=10`
- To require password to contain at least an uppercase character and a numeric character: ucredit=-1 dcredit=-1
- To set a maximum of 3 consecutive identical characters: maxrepeat=3
- To reject the password if it contains in some form: reject_username
- To set the number of changes required in the new password from the old password to 7: difok=7
- To implement the same policy on root: enforce_for_root
- Finally, it should look like the bellow:
```bash
password        requisite                       pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root
```

### Step 2: Creating a New User

**Hostname**

The hostname must be ```your_intra_login42```, but the hostname must be changed during the Born2beroot evaluation. The following commands might help:
```bash
$ sudo hostnamectl set-hostname <new_hostname>
$ hostnamectl status
```

There must be a user with ```your_intra_login``` as username. During evaluation, you will be asked to create, delete, modify user accounts. The following commands are useful to know:

- ```sudo adduser <username>``` : Create a new user
- ```userdel -r```              : Deletes a user and all associated files.
- ```getent passwd <username>```: Verify whether user was successfully created
- ```sudo chage -l <username>```: Verify newly-created user's password expire information

### Step 3: Creating a New Group

- ```sudo addgroup user42```          : Create new user42 group
- ```sudo adduser <username> user42```: Add user to user42 group
- ```getent group user42```           : Verify whether user was successfully added to user42 group

## cron
### Setting Up a cron Job

- Configure cron as root: `sudo crontab -u root -e`
- To schedule a shell script to run every 10 minutes replace: `23 # m h dom mon dow command with 23 */10 * * * * sh /path/to/script`
- Check root's scheduled cron jobs: `sudo crontab -u root -l`
