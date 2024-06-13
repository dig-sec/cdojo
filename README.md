**CyberRange**

![Cyber Dojo Cat](docs/images/cyber-dojo-cat.jpg)

This script streamlines the installation and configuration of the CyberRange virtual environment using Vagrant and libvirt on Fedora-based systems. It automates the process of setting up dependencies, cloning the CyberRange repository, configuring network bridges, and starting the Vagrant machines.

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

1. **Download:** Clone or download this script.
2. **Make Executable:** Give the script execution permissions: `chmod +x cyberrange_setup.sh`
3. **Run as Root:** Execute the script with root privileges: `sudo ./cyberrange_setup.sh`

**Configuration**

* **Bridge XML Files:** Make sure you have the bridge XML configuration files (`virbr2.xml`, `virbr3.xml`) in the same directory as this script. These files define the network bridges used by the CyberRange environment.

**Usage**

After running the script, you can manage your CyberRange virtual environment using standard Vagrant commands:

* `vagrant status`: Check the status of the virtual machines.
* `vagrant ssh <machine-name>`: SSH into a specific virtual machine.
* `vagrant halt`: Stop the virtual machines.
* `vagrant destroy`: Destroy the virtual machines.

**Troubleshooting**

If you encounter any issues during the setup, here are some common troubleshooting steps:

* **Verify KVM/libvirt:** Double-check that KVM and libvirt are properly installed and running.
* **Check Bridge Files:** Ensure the bridge XML files are present and correctly configured.
* **Review Error Messages:** Examine the output of the script for any error messages that might indicate problems with package installations or Vagrant configuration.

**Disclaimer**

This script is provided as-is, with no guarantees of any kind. Use it at your own risk. The authors are not responsible for any data loss, damage, or other issues that may occur from using this script. 

**Contributing**

Contributions are welcome! If you find any issues or have improvements, feel free to submit a pull request.

**License**

This project is licensed under the [Choose a License] License. See the `LICENSE` file for details.

**Acknowledgments**

* The CyberRange project: [invalid URL removed]

Let me know if you'd like any modifications or have specific details you want to add! 
