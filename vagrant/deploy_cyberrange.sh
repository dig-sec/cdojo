#!/bin/bash

# Constants and Configuration
PACKAGES=("git" "ansible-core" "ruby" "ruby-devel" "qemu-kvm" "libvirt" "libvirt-devel" "gcc" "make" "patch") 
BRIDGES=("virbr2" "virbr3")
BRIDGE_CONFIG="/etc/qemu/bridge.conf"
BRIDGE_XML_DIR="${HOME}/.config/libvirt/qemu/networks"  # Use default libvirt storage location

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

configure_bridges() {
    mkdir -p "$BRIDGE_XML_DIR"  # Create the directory if it doesn't exist
    for bridge in "${BRIDGES[@]}"; do
        echo -n "Checking bridge $bridge..."
        if virsh net-info "$bridge" &>/dev/null; then
            echo "already active."
        else
            echo -n "defining and starting..."
            sudo virsh net-define "${BRIDGE_XML_DIR}/${bridge}.xml" 
            sudo virsh net-autostart "$bridge"  # Enable autostart
            sudo virsh net-start "$bridge"
            echo "done."
        fi
    done
}

update_bridge_config() {
    if ! sudo grep -q 'allow all' "$BRIDGE_CONFIG"; then
        echo "allow all" | sudo tee -a "$BRIDGE_CONFIG" >/dev/null
    fi
}



# Main Script Logic
main() {
    # Check if running as root (or with sudo)
    if [[ $EUID -ne 0 ]]; then
        echo "This script needs to be run with sudo or as root." >&2
        exit 1
    fi

    # Installation Steps
    install_packages
    install_vagrant
    install_gem winrm
    install_vagrant_plugin vagrant-libvirt
    install_vagrant_plugin winrm
    install_vagrant_plugin winrm-elevated

    # Add the Windows Ansible collection
    ansible-galaxy collection install ansible.windows

    # Install python3
    sudo dnf install -y python3

    # Install pip
    sudo dnf install -y python3-pip

    # Add user to libvirt group and restart libvirtd
    sudo usermod -aG libvirt $USER
    sudo systemctl restart libvirtd

    # Network Configuration
    configure_bridges
    update_bridge_config

    # Additional Plugin Installation
    install_vagrant_plugin vagrant-hostmanager

    echo "Setup completed successfully!"
}

main