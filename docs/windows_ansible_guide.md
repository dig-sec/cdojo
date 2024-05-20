### Ansible Configuration (ansible.cfg)

You can place your `ansible.cfg` file in one of the following locations:

* **Project Directory:**
  - Create an `ansible.cfg` file in your current working directory (where your playbook resides).
  - This configuration will only apply to the specific project.

* **Home Directory (User-Specific):**
  - Create a `~/.ansible.cfg` file in your home directory.
  - This configuration will apply to all your projects unless overridden by a local `ansible.cfg` in the project directory.

* **System-Wide:**
  - Edit the system-wide configuration file at `/etc/ansible/ansible.cfg`.
  - This configuration applies to all users and projects on the system.

**Note:** It's recommended to use a project-specific `ansible.cfg` to avoid conflicts with other projects or system-wide settings.


### How to use ansible and ansible-playbooks

1. **Single Ad-Hoc Command:**

   - Execute a single command on specific hosts using `ansible`:

     ```bash
     ansible hostname -m command_name -a arguments
     ```

     - Replace `hostname` with the target host's name or inventory group (e.g., `[windows_group]`).
     - Replace `command_name` with the desired module (e.g., `win_ping`, `setup`).
     - Replace `-a arguments` with optional arguments for the module (e.g., none for `win_ping`).

2. **Module Arguments:**

   - Modules often accept arguments to customize their behavior:

     ```bash
     ansible all -m win_ping -a "count=3"
     ```

     - In this example, `count=3` instructs `win_ping` to attempt three pings.

**Using `win_ping` for Basic Connectivity Checks**

- The `win_ping` module helps verify basic network connectivity with Windows hosts:

  ```bash
  ansible hostname -m win_ping
  ```


3. **Modules**
https://docs.ansible.com/ansible/latest/collections/ansible/windows/index.html#communication