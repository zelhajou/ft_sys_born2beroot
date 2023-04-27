# Bonus

## Installation

### Step 1: Installing Lighttpd

Install lighttpd via `sudo apt install lighttpd`.
```bash
$ sudo apt install lighttpd
```

Verify whether lighttpd was successfully installed via `dpkg -l | grep lighttpd`.
```bash
$ dpkg -l | grep lighttpd
```

Now that the webserver is installed, we need to start and enable it to keep running even after a successful system boot or reboot.

```bash
$ sudo systemctl start lighttpd
$ sudo systemctl enable lighttpd
```

Allow incoming connections using Port 80 via sudo ufw allow 80.
```bash
$ sudo ufw allow 80
```
