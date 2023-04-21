### `su`
su is an acronym of switch user or substitute user you are basically switching to a particular user and you need the password for the user you are switching to. Most often, the user account you switch can be any account on the system. for example

```bash
`su -` will login as the root user by default
``` 
### `root`
root is the superuser account in Unix and Linux. it is a user account for administrative purposes and typically has the highest access right on the system. Usually, the root user account is called root

### `dpkg`
dpkg in Linux is the primary package manager for Debian and Debian-based systems, such as Ubuntu. The Tool installs, build, removes, configures, and retrieves information for Debian packages. The command works with packages in .deb format

### `aptitude` and `apt` 
are both package management tools used to install, update, and remove software packages on a system.

- Aptitude is a high-level package management tool that provides a text-based user interface for managing packages. It has a more powerful dependency resolution system and can handle complex package management tasks.

- apt is a command-line tool that provides a simple interface for managing packages. It is designed to be fast and easy to use and is often preferred by experienced users who prefer a more streamlined approach to package management.

The main difference between the two is that aptitude has more advanced features and can handle complex package management tasks, while apt is simpler and faster to use but lacks some of the more advanced features of aptitude.

To summarize, aptitude and apt are both package management tools in Linux, but aptitude is more advanced and powerful, while apt is simpler and faster to use.

### the difference between `apt` and `dpkg`
dpkg is a low-level tool that is used to install, remove, and manage individual packages on a Debian-based system, whereas apt (Advanced Package Tool) is a higher-level tool that uses dpkg as a backend to manage packages and their dependencies. Apt provides additional functionality such as automatic dependency resolution, package searching, and repository management.

### `sudoers`
the sudoers file is where you grant users elevated privileges. By default, only the root user has these privileges. But, in some cases, it may be necessary for regular users to have elevated privileges as well.

The sudoers file lives in the /etc/sudoers, a plain text file containing the policies on what privileges a user gains when executing the sudo command.

![visudo](https://user-images.githubusercontent.com/39954629/233695566-20cb2114-1bff-4bc6-a683-ea78a4a879c4.PNG)

**Defaults Section**

![defaul](https://user-images.githubusercontent.com/39954629/233696135-779dfecd-f331-45bb-b548-62aa2580b3b7.PNG)
- `Defaults env_reset` - Executing commands with sudo creates a new environment with minimal or default environment variables. In most Linux distros, sudo will load the environment variable in the /etc/environment file.
- `Defaults mail_badpass` – This line triggers sending an email to the root when a user enters a wrong password with sudo.
- `Defaults mail_badpass` – This line triggers sending an email to the root when a user enters a wrong password with sudo.
- `Defaults secure_path` - This line defines the PATH environment variable that sudo uses instead of the user’s PATH environment.

**User and Group Sudo Privileges**

![user](https://user-images.githubusercontent.com/39954629/233701127-8281517b-3ba3-41b9-b1bf-f51fda28c010.PNG)
Note: The % at the beginning indicates that the policy applies to the group members.

  - The first field defines that his policy applies to the `root` user and the members of the `sudo` groups.
  - The first `ALL` means that the rule applies to all hosts.
  - The second `ALL` allows the `root` account to run commands as any user.
  - The third `ALL` allows the `root` account to run commands as any group.
  - The last `ALL` means that this policy applies to command commands.

**Include Directives**

![include](https://user-images.githubusercontent.com/39954629/233702551-908bbcd6-1fb2-4bc7-9360-5ff1d3988fb1.PNG)
`#includedir /etc/sudoers.d` – This line tells sudo to look in the `/etc/sudoers.d` directory for any additional configuration files.




