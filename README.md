## Cyber Dojo

This script streamlines the installation and configuration of the Cyber Dojo virtual environment using Vagrant and libvirt on Fedora-based systems.

<p align="center">
    <img src="docs/images/cyber-dojo.png" alt="Logo" width="40%" style="display: block; margin: 0 auto">
</p>


**Features**

* **Automated Setup:**  Handles installation of necessary packages (Git, Ansible, QEMU/KVM, libvirt, etc.).
* **Vagrant Integration:** Clones the Cyber Dojo repository, installs Vagrant plugins (vagrant-libvirt, vagrant-hostmanager), and launches the virtual environment.
* **Error Handling:** Includes basic error checks to identify potential issues during the setup process.

**Prerequisites**

* **Fedora-based System:**  The script is primarily designed and tested on Fedora Linux. It may work on other distributions, but some adjustments might be needed.
* **Root Privileges:**  The script requires root access (sudo) to install packages and manage system services.
* **KVM/libvirt:**  Ensure that your system has KVM (Kernel-based Virtual Machine) and libvirt virtualization platform installed and configured.

**Installation**

1. **Download:**
2. **Make Executable:** Give the script execution permissions: `chmod +x deploy_cyber_dojo.sh`
3. **Run as Root:** Execute the script with root privileges: `sudo ./deploy_cyber_dojo.sh`

**Configuration**

**Usage**

After running the script, you can manage your Cyber Dojo virtual environment using standard Vagrant commands:

* `vagrant status`: Check the status of the virtual machines.
* `vagrant ssh <machine-name>`: SSH into a specific virtual machine.
* `vagrant halt`: Stop the virtual machines.
* `vagrant destroy`: Destroy the virtual machines.

**Contributing**

Contributions are welcome! If you find any issues or have improvements, feel free to submit a pull request.


**Acknowledgments**

* https://github.com/Marshall-Hallenbeck/red_team_attack_lab/tree/main
* https://github.com/Orange-Cyberdefense/GOAD
* https://github.com/clong/detectionlab
