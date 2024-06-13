## CyberRange

<p align="center">
    <img src="docs/images/cyber-dojo-cat.jpg" alt="Logo" width="40%" style="display: block; margin: 0 auto; border-radius: 50%;">
</p>


This script streamlines the installation and configuration of the CyberRange virtual environment using Vagrant and libvirt on Fedora-based systems.

**Features**

* **Automated Setup:**  Handles installation of necessary packages (Git, Ansible, QEMU/KVM, libvirt, etc.).
* **Bridge Configuration:**  Ensures the required network bridges (virbr2, virbr3) are active for seamless communication between virtual machines.
* **Vagrant Integration:** Clones the CyberRange repository, installs Vagrant plugins (vagrant-libvirt, vagrant-hostmanager), and launches the virtual environment.
* **Error Handling:** Includes basic error checks to identify potential issues during the setup process.

**Prerequisites**

* **Fedora-based System:**  The script is primarily designed and tested on Fedora Linux. It may work on other distributions, but some adjustments might be needed.
* **Root Privileges:**  The script requires root access (sudo) to install packages and manage system services.
* **KVM/libvirt:**  Ensure that your system has KVM (Kernel-based Virtual Machine) and libvirt virtualization platform installed and configured.

**Installation**

1. **Download:**
2. **Make Executable:** Give the script execution permissions: `chmod +x cyberrange_setup.sh`
3. **Run as Root:** Execute the script with root privileges: `sudo ./cyberrange_setup.sh`

**Configuration**

**Usage**

After running the script, you can manage your CyberRange virtual environment using standard Vagrant commands:

* `vagrant status`: Check the status of the virtual machines.
* `vagrant ssh <machine-name>`: SSH into a specific virtual machine.
* `vagrant halt`: Stop the virtual machines.
* `vagrant destroy`: Destroy the virtual machines.

**Contributing**

Contributions are welcome! If you find any issues or have improvements, feel free to submit a pull request.


**Acknowledgments**

* https://github.com/Marshall-Hallenbeck/red_team_attack_lab/tree/main
* https://github.com/Orange-Cyberdefense/GOAD
