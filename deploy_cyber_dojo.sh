#!/bin/bash

# Constants and Configuration
PACKAGES=("git" "ansible-core" "ruby" "ruby-devel" "qemu-kvm" "libvirt" "libvirt-devel" "gcc" "make" "patch") 
BRIDGES=("virbr2" "virbr3")
BRIDGE_CONFIG="/etc/qemu/bridge.conf"
BRIDGE_XML_DIR="/etc/libvirt/qemu/networks"

# Bridge configurations
DEFAULT_BRIDGE_CONFIG=$(cat <<EOF
<network>
  <name>default</name>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:0a:cd:20'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
EOF
)

VIRBR2_BRIDGE_CONFIG=$(cat <<EOF
<network>
  <name>virbr2</name>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr2' stp='on' delay='0'/>
  <ip address='10.0.1.2' netmask='255.255.255.0'>
    <dhcp>
      <range start='10.0.1.3' end='10.0.1.254'/>
    </dhcp>
  </ip>
</network>
EOF
)

print_ascii_banner() {
  echo "   _______       __               _______                         "
  echo "  |   _   .--.--|  |--.-----.----|   _   .---.-.-----.-----.-----."
  echo "  |.  1___|  |  |  _  |  -__|   _|.  l   |  _  |     |  _  |  -__|"
  echo "  |.  |___|___  |_____|_____|__| |.  _   |___._|__|__|___  |_____|"
  echo "  |:  1   |_____|                |:  |   |           |_____|      "
  echo "  |::.. . |                      |::.|:. |                        "
  echo "   ------                         --- ---                         "
  echo "                                                      @pabi 2024  "
}

# Functions
install_packages() {
    echo "Installing dependencies..."
    sudo dnf install -y "${PACKAGES[@]}" || { echo "Error installing packages. Exiting."; exit 1; } 
}

install_vagrant() {
    echo "Installing Vagrant..."
    sudo dnf install -y vagrant || { echo "Error installing Vagrant. Exiting."; exit 1; }
}

install_gem() {
    gem_name="$1"
    echo "Installing Ruby gem $gem_name..."
    sudo /usr/bin/gem install "$gem_name" || { echo "Error installing Ruby gem $gem_name."; exit 1; }
    echo "Ruby gem $gem_name installed successfully."
}

install_vagrant_plugin() {
    plugin_name="$1"
    echo "Installing Vagrant plugin $plugin_name..."
    vagrant plugin install "$plugin_name" || { 
        echo "Error installing Vagrant plugin $plugin_name. Please check the output for details."; 
        vagrant plugin install "$plugin_name" --verbose  # Retry with verbose output for troubleshooting
        exit 1
    }
    echo "Vagrant plugin $plugin_name installed successfully."
}

# configure_bridges() {
#     mkdir -p "$BRIDGE_XML_DIR"  # Create the directory if it doesn't exist
#     for bridge in "${BRIDGES[@]}"; do
#         echo -n "Checking bridge $bridge..."
#         if virsh net-info "$bridge" &>/dev/null; then
#             echo "already active."
#         else
#             echo -n "defining and starting..."
#             sudo virsh net-define "${BRIDGE_XML_DIR}/${bridge}.xml" 
#             sudo virsh net-autostart "$bridge"  # Enable autostart
#             sudo virsh net-start "$bridge"
#             echo "done."
#         fi
#     done
# }

# update_bridge_config() {
#     if ! sudo grep -q 'allow all' "$BRIDGE_CONFIG"; then
#         echo "allow all" | sudo tee -a "$BRIDGE_CONFIG" >/dev/null
#     fi
# }

# Function to check if bridges are active
check_bridge_status() {
    for bridge in "${BRIDGES[@]}"; do
        echo -n "Checking bridge $bridge..."
        if virsh net-info "$bridge" &>/dev/null; then
            echo "active."
        else
            echo "inactive or not defined."
        fi
    done
}

# Function to enable autostart for bridges
enable_autostart() {
    for bridge in "${BRIDGES[@]}"; do
        sudo virsh net-autostart "$bridge" >/dev/null 2>&1
        echo "Autostart enabled for bridge $bridge."
    done
}

# Main Script Logic
main() {
  print_ascii_banner
  # Check if running as root (or with sudo)
  if [[ $EUID -ne 0 ]]; then
      echo "This script needs to be run with sudo or as root." >&2
      exit 1
  fi

  # Bridge configuration
  mkdir -p "$BRIDGE_XML_DIR"
  echo "$DEFAULT_BRIDGE_CONFIG" | sudo tee "$BRIDGE_XML_DIR/default.xml" >/dev/null
  echo "$VIRBR2_BRIDGE_CONFIG" | sudo tee "$BRIDGE_XML_DIR/virbr2.xml" >/dev/null
  check_bridge_status
  enable_autostart

  # Installation Steps
  install_packages
  install_vagrant
  install_gem winrm
  install_vagrant_plugin vagrant-libvirt
  install_vagrant_plugin winrm
  install_vagrant_plugin winrm-elevated

  # Add the Windows Ansible collection
  ansible-galaxy collection install ansible.windows

  # Opensense ansible collection https://opnsense.ansibleguy.net/
  #ansible-galaxy collection install git+https://github.com/ansibleguy/collection_opnsense.git
  # Opnsense: https://puzzle.github.io/puzzle.opnsense/collections/puzzle/opnsense/index.html#description
  ansible-galaxy collection install puzzle.opnsense

  # Microsoft AD collection
  ansible-galaxy collection install microsoft.ad

  # Community general collection
  ansible-galaxy collection install community.general

  # Install python3
  sudo dnf install -y python3

  # Install pip
  sudo dnf install -y python3-pip

  # Install sshpass
  sudo dnf install -y sshpass

  # Add user to libvirt and qemu group and restart libvirtd
  sudo usermod -aG libvirt $USER
  sudo usermod -aG qemu $USER
  sudo systemctl restart libvirtd

  # Network Configuration
  configure_bridges
  update_bridge_config

  # Additional Plugin Installation
  install_vagrant_plugin vagrant-hostmanager

  # Might need to change permissions on /etc/qemu/bridge.conf
  sudo chmod 644 /etc/qemu/bridge.conf

  # git clone the cyberrange repo
  git clone git@github.com:dig-sec/CyberRange.git

  echo "Setup completed successfully!"
}

main