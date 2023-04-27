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

Check the status of the webserver to be sure that it is running.

```bash
$ sudo systemctl status lighttpd
```

In case it failed to activate/start use
```bash
sudo apt install --reinstall lighttpd
```

If you are running a UFW firewall, you need to open the following ports to enable access to Lighttpd.

Allow incoming connections using Port 80 via sudo ufw allow 80.
```bash
$ sudo ufw allow 80
$ sudo ufw allow 443
OR
$ sudo ufw allow http
$ sudo ufw allow https
```

### Step 2: Installing & Configuring MariaDB

Install mariadb.

```bash
$ sudo apt install mariadb-server
```

Verify whether mariadb-server was successfully installed via dpkg -l | grep mariadb-server.

```bash
$ dpkg -l | grep mariadb-server
```

Start interactive script to remove insecure default settings via `sudo mysql_secure_installation`.

```bash
$ sudo mysql_secure_installation
Enter current password for root (enter for none): #Just press Enter (do not confuse database root with system root)
Set root password? [Y/n] n
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

Restart MariaDB service:
```bash
$ sudo systemctl restart mariadb
```

- Log in to MariaDB console: `sudo mariadb`
- Create new database: `CREATE DATABASE <database-name>;`
- Create new database user and grant them full privileges on the newly-created database:
```bash
MariaDB [(none)]> CREATE DATABASE wordpress_db;
MariaDB [(none)]> CREATE USER 'admin'@'localhost' IDENTIFIED BY 'WPpassw0rd';
MariaDB [(none)]> GRANT ALL ON wordpress_db.* TO 'admin'@'localhost' IDENTIFIED BY 'WPpassw0rd' WITH GRANT OPTION;
```
- Flush the privileges: `FLUSH PRIVILEGES;`
- Exit MariaDB shell: `exit`

Check that the database was created successfully, go back into MariaDB interface:

```bash
$ mysql -u root -p
```

And show databases:
```bash
MariaDB [(none)]> show databases;
```

You should see something like this:
```bash
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| wordpress_db       |
+--------------------+
```
If the database is there, everything's good!

Exit the MariaDB shell: `exit`

### Step 3: Installing PHP



